package openapi

import (
	"time"

	"github.com/gin-gonic/gin"
	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

// Métricas personalizadas
var (
	httpRequestsTotal = prometheus.NewCounterVec(
		prometheus.CounterOpts{
			Name: "http_requests_total",
			Help: "Total de peticiones HTTP procesadas",
		},
		[]string{"method", "endpoint", "status"},
	)

	httpRequestDuration = prometheus.NewHistogramVec(
		prometheus.HistogramOpts{
			Name:    "http_request_duration_seconds",
			Help:    "Duración de las peticiones HTTP en segundos",
			Buckets: []float64{0.01, 0.05, 0.1, 0.5, 1, 2, 5},
		},
		[]string{"method", "endpoint"},
	)

	activeConnections = prometheus.NewGauge(
		prometheus.GaugeOpts{
			Name: "active_connections",
			Help: "Número de conexiones activas",
		},
	)

	dbQueryDuration = prometheus.NewHistogramVec(
		prometheus.HistogramOpts{
			Name:    "db_query_duration_seconds",
			Help:    "Duración de consultas a la base de datos en segundos",
			Buckets: []float64{0.001, 0.005, 0.01, 0.05, 0.1, 0.5, 1},
		},
		[]string{"query_type"},
	)
)

// Inicializar métricas
func init() {
	prometheus.MustRegister(httpRequestsTotal)
	prometheus.MustRegister(httpRequestDuration)
	prometheus.MustRegister(activeConnections)
	prometheus.MustRegister(dbQueryDuration)
}

// MetricsAPI - API para métricas
type MetricsAPI struct{}

// GetMetrics - Handler para exponer métricas Prometheus
func (api *MetricsAPI) GetMetrics(c *gin.Context) {
	handler := promhttp.Handler()
	handler.ServeHTTP(c.Writer, c.Request)
}

// MetricsMiddleware - Middleware para capturar métricas HTTP
func MetricsMiddleware() gin.HandlerFunc {
	return func(c *gin.Context) {
		start := time.Now()
		method := c.Request.Method
		endpoint := c.Request.URL.Path

		// Incrementar conexiones activas
		activeConnections.Inc()

		// Procesar la petición
		c.Next()

		// Decrementar conexiones activas
		activeConnections.Dec()

		// Calcular duración
		duration := time.Since(start).Seconds()

		// Obtener status code
		status := "200"
		if c.Writer.Status() >= 400 {
			status = "4xx"
		}
		if c.Writer.Status() >= 500 {
			status = "5xx"
		}

		// Registrar métricas
		httpRequestsTotal.WithLabelValues(method, endpoint, status).Inc()
		httpRequestDuration.WithLabelValues(method, endpoint).Observe(duration)
	}
}

// RecordDBQuery - Función para registrar métricas de consultas a BD
func RecordDBQuery(queryType string, duration time.Duration) {
	dbQueryDuration.WithLabelValues(queryType).Observe(duration.Seconds())
}
