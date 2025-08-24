package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html lang=\"vi\">\r\n");
      out.write("<head>\r\n");
      out.write("    <meta charset=\"UTF-8\">\r\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n");
      out.write("    <title>Phụ Tùng Xe Máy - Trang Chủ</title>\r\n");
      out.write("    <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n");
      out.write("    <link href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css\" rel=\"stylesheet\">\r\n");
      out.write("    <link href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("/css/style.css\" rel=\"stylesheet\">\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("    <!-- Include header -->\r\n");
      out.write("    ");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "includes/header.jsp", out, false);
      out.write("\r\n");
      out.write("    \r\n");
      out.write("    <!-- Hero Section -->\r\n");
      out.write("    <section class=\"hero-section bg-primary text-white py-5\">\r\n");
      out.write("        <div class=\"container\">\r\n");
      out.write("            <div class=\"row align-items-center\">\r\n");
      out.write("                <div class=\"col-lg-6\">\r\n");
      out.write("                    <h1 class=\"display-4 fw-bold mb-4\">Phụ Tùng Xe Máy Chính Hãng</h1>\r\n");
      out.write("                    <p class=\"lead mb-4\">Chuyên cung cấp phụ tùng xe máy chất lượng cao với giá tốt nhất thị trường</p>\r\n");
      out.write("                    <a href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("/products\" class=\"btn btn-light btn-lg\">\r\n");
      out.write("                        <i class=\"fas fa-shopping-cart me-2\"></i>Mua Ngay\r\n");
      out.write("                    </a>\r\n");
      out.write("                </div>\r\n");
      out.write("                <div class=\"col-lg-6\">\r\n");
      out.write("                    <img src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("/images/hero-motorcycle.jpg\" \r\n");
      out.write("                         alt=\"Xe máy\" class=\"img-fluid rounded\">\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("    </section>\r\n");
      out.write("    \r\n");
      out.write("    <!-- Categories Section -->\r\n");
      out.write("    <section class=\"categories-section py-5\">\r\n");
      out.write("        <div class=\"container\">\r\n");
      out.write("            <h2 class=\"text-center mb-5\">Danh Mục Sản Phẩm</h2>\r\n");
      out.write("            <div class=\"row\">\r\n");
      out.write("                <div class=\"col-md-4 mb-4\">\r\n");
      out.write("                    <div class=\"card category-card h-100\">\r\n");
      out.write("                        <img src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("/images/lop-xe.jpg\" \r\n");
      out.write("                             class=\"card-img-top\" alt=\"Lốp xe\">\r\n");
      out.write("                        <div class=\"card-body text-center\">\r\n");
      out.write("                            <h5 class=\"card-title\">Lốp Xe</h5>\r\n");
      out.write("                            <p class=\"card-text\">Lốp xe máy các hãng nổi tiếng</p>\r\n");
      out.write("                            <a href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("/products?action=category&categoryId=1\" \r\n");
      out.write("                               class=\"btn btn-primary\">Xem Sản Phẩm</a>\r\n");
      out.write("                        </div>\r\n");
      out.write("                    </div>\r\n");
      out.write("                </div>\r\n");
      out.write("                <div class=\"col-md-4 mb-4\">\r\n");
      out.write("                    <div class=\"card category-card h-100\">\r\n");
      out.write("                        <img src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("/images/phanh.jpg\" \r\n");
      out.write("                             class=\"card-img-top\" alt=\"Phanh\">\r\n");
      out.write("                        <div class=\"card-body text-center\">\r\n");
      out.write("                            <h5 class=\"card-title\">Phanh</h5>\r\n");
      out.write("                            <p class=\"card-text\">Má phanh, đĩa phanh chất lượng cao</p>\r\n");
      out.write("                            <a href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("/products?action=category&categoryId=2\" \r\n");
      out.write("                               class=\"btn btn-primary\">Xem Sản Phẩm</a>\r\n");
      out.write("                        </div>\r\n");
      out.write("                    </div>\r\n");
      out.write("                </div>\r\n");
      out.write("                <div class=\"col-md-4 mb-4\">\r\n");
      out.write("                    <div class=\"card category-card h-100\">\r\n");
      out.write("                        <img src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("/images/nhot.jpg\" \r\n");
      out.write("                             class=\"card-img-top\" alt=\"Nhớt\">\r\n");
      out.write("                        <div class=\"card-body text-center\">\r\n");
      out.write("                            <h5 class=\"card-title\">Nhớt</h5>\r\n");
      out.write("                            <p class=\"card-text\">Dầu nhớt động cơ chính hãng</p>\r\n");
      out.write("                            <a href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("/products?action=category&categoryId=3\" \r\n");
      out.write("                               class=\"btn btn-primary\">Xem Sản Phẩm</a>\r\n");
      out.write("                        </div>\r\n");
      out.write("                    </div>\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("    </section>\r\n");
      out.write("    \r\n");
      out.write("    <!-- Featured Products Section -->\r\n");
      out.write("    <section class=\"featured-products py-5 bg-light\">\r\n");
      out.write("        <div class=\"container\">\r\n");
      out.write("            <h2 class=\"text-center mb-5\">Sản Phẩm Nổi Bật</h2>\r\n");
      out.write("            <div class=\"row\" id=\"featured-products\">\r\n");
      out.write("                <!-- Products will be loaded here -->\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"text-center mt-4\">\r\n");
      out.write("                <a href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("/products\" class=\"btn btn-primary btn-lg\">\r\n");
      out.write("                    Xem Tất Cả Sản Phẩm\r\n");
      out.write("                </a>\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("    </section>\r\n");
      out.write("    \r\n");
      out.write("    <!-- Features Section -->\r\n");
      out.write("    <section class=\"features-section py-5\">\r\n");
      out.write("        <div class=\"container\">\r\n");
      out.write("            <div class=\"row\">\r\n");
      out.write("                <div class=\"col-md-3 text-center mb-4\">\r\n");
      out.write("                    <div class=\"feature-item\">\r\n");
      out.write("                        <i class=\"fas fa-shipping-fast fa-3x text-primary mb-3\"></i>\r\n");
      out.write("                        <h5>Giao Hàng Nhanh</h5>\r\n");
      out.write("                        <p>Giao hàng toàn quốc trong 24h</p>\r\n");
      out.write("                    </div>\r\n");
      out.write("                </div>\r\n");
      out.write("                <div class=\"col-md-3 text-center mb-4\">\r\n");
      out.write("                    <div class=\"feature-item\">\r\n");
      out.write("                        <i class=\"fas fa-medal fa-3x text-primary mb-3\"></i>\r\n");
      out.write("                        <h5>Chất Lượng</h5>\r\n");
      out.write("                        <p>Sản phẩm chính hãng 100%</p>\r\n");
      out.write("                    </div>\r\n");
      out.write("                </div>\r\n");
      out.write("                <div class=\"col-md-3 text-center mb-4\">\r\n");
      out.write("                    <div class=\"feature-item\">\r\n");
      out.write("                        <i class=\"fas fa-tools fa-3x text-primary mb-3\"></i>\r\n");
      out.write("                        <h5>Bảo Hành</h5>\r\n");
      out.write("                        <p>Bảo hành chính hãng theo quy định</p>\r\n");
      out.write("                    </div>\r\n");
      out.write("                </div>\r\n");
      out.write("                <div class=\"col-md-3 text-center mb-4\">\r\n");
      out.write("                    <div class=\"feature-item\">\r\n");
      out.write("                        <i class=\"fas fa-headset fa-3x text-primary mb-3\"></i>\r\n");
      out.write("                        <h5>Hỗ Trợ 24/7</h5>\r\n");
      out.write("                        <p>Tư vấn và hỗ trợ mọi lúc</p>\r\n");
      out.write("                    </div>\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("    </section>\r\n");
      out.write("    \r\n");
      out.write("    <!-- Include footer -->\r\n");
      out.write("    ");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "includes/footer.jsp", out, false);
      out.write("\r\n");
      out.write("    \r\n");
      out.write("    <script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js\"></script>\r\n");
      out.write("    \r\n");
      out.write("    <script>\r\n");
      out.write("        // Set global variables for JavaScript\r\n");
      out.write("        window.contextPath = '");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("';\r\n");
      out.write("        window.userLoggedIn = ");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${sessionScope.user != null ? 'true' : 'false'}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write(";\r\n");
      out.write("    </script>\r\n");
      out.write("    \r\n");
      out.write("    <script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("/js/script.js\"></script>\r\n");
      out.write("    \r\n");
      out.write("    <script>\r\n");
      out.write("        // Load featured products\r\n");
      out.write("        document.addEventListener('DOMContentLoaded', function() {\r\n");
      out.write("            loadFeaturedProducts();\r\n");
      out.write("        });\r\n");
      out.write("        \r\n");
      out.write("        function loadFeaturedProducts() {\r\n");
      out.write("            fetch('");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("/api/featured-products')\r\n");
      out.write("                .then(response => response.json())\r\n");
      out.write("                .then(data => {\r\n");
      out.write("                    if (data.success) {\r\n");
      out.write("                        displayFeaturedProducts(data.products);\r\n");
      out.write("                    }\r\n");
      out.write("                })\r\n");
      out.write("                .catch(error => console.error('Error:', error));\r\n");
      out.write("        }\r\n");
      out.write("        \r\n");
      out.write("        function displayFeaturedProducts(products) {\r\n");
      out.write("            const container = document.getElementById('featured-products');\r\n");
      out.write("            container.innerHTML = '';\r\n");
      out.write("            \r\n");
      out.write("            products.slice(0, 8).forEach(product => {\r\n");
      out.write("                const productCard = createProductCard(product);\r\n");
      out.write("                container.appendChild(productCard);\r\n");
      out.write("            });\r\n");
      out.write("        }\r\n");
      out.write("        \r\n");
      out.write("        function createProductCard(product) {\r\n");
      out.write("            const colDiv = document.createElement('div');\r\n");
      out.write("            colDiv.className = 'col-lg-3 col-md-4 col-sm-6 mb-4';\r\n");
      out.write("            \r\n");
      out.write("            colDiv.innerHTML = `\r\n");
      out.write("                <div class=\"card product-card h-100\">\r\n");
      out.write("                    <img src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("/images/${product.image || 'default-product.jpg'}\" \r\n");
      out.write("                         class=\"card-img-top\" alt=\"${product.name}\">\r\n");
      out.write("                    <div class=\"card-body d-flex flex-column\">\r\n");
      out.write("                        <h6 class=\"card-title\">${product.name}</h6>\r\n");
      out.write("                        <p class=\"card-text text-muted small\">${product.brand}</p>\r\n");
      out.write("                        <div class=\"mt-auto\">\r\n");
      out.write("                            <div class=\"d-flex justify-content-between align-items-center\">\r\n");
      out.write("                                <span class=\"h6 text-primary mb-0\">${formatCurrency(product.price)}</span>\r\n");
      out.write("                                <small class=\"text-muted\">Còn ${product.stockQuantity}</small>\r\n");
      out.write("                            </div>\r\n");
      out.write("                            <form method=\"post\" action=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("/cart\" class=\"mt-2\">\r\n");
      out.write("                                <input type=\"hidden\" name=\"action\" value=\"add\">\r\n");
      out.write("                                <input type=\"hidden\" name=\"productId\" value=\"${product.id}\">\r\n");
      out.write("                                <input type=\"hidden\" name=\"quantity\" value=\"1\">\r\n");
      out.write("                                <button type=\"submit\" class=\"btn btn-primary btn-sm w-100\">\r\n");
      out.write("                                    <i class=\"fas fa-cart-plus\"></i> Thêm vào giỏ\r\n");
      out.write("                                </button>\r\n");
      out.write("                            </form>\r\n");
      out.write("                        </div>\r\n");
      out.write("                    </div>\r\n");
      out.write("                </div>\r\n");
      out.write("            `;\r\n");
      out.write("            \r\n");
      out.write("            return colDiv;\r\n");
      out.write("        }\r\n");
      out.write("    </script>\r\n");
      out.write("</body>\r\n");
      out.write("</html>\r\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
