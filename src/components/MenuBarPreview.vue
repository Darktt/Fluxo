<script setup lang="ts">
// No imports needed - pure presentational component
</script>

<template>
  <div class="preview-wrapper">
    <!-- Decorative Glow -->
    <div class="preview-glow"></div>

    <!-- Main Window Container -->
    <div class="preview-window">

      <!-- Window Title Bar -->
      <div class="preview-titlebar">
        <div class="preview-titlebar-left">
          <!-- Traffic Lights -->
          <div class="preview-traffic-lights">
            <div class="preview-traffic-light preview-traffic-light--red"></div>
            <div class="preview-traffic-light preview-traffic-light--yellow"></div>
            <div class="preview-traffic-light preview-traffic-light--green"></div>
          </div>
          <span class="preview-titlebar-title">服務運作中...</span>
        </div>

        <div class="preview-titlebar-right">
          <button class="preview-button">
            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <polyline points="3 6 5 6 21 6"></polyline>
              <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
            </svg>
            清除
          </button>
          <button class="preview-button">
            <div class="preview-stop-indicator"></div>
            停止
          </button>
        </div>
      </div>

      <!-- Main Content Area -->
      <div class="preview-content">
        <!-- Sidebar: Request List -->
        <div class="preview-sidebar">
          <!-- Active Item -->
          <div class="preview-sidebar-item preview-sidebar-item--active">
            <div class="preview-sidebar-item-header">
              <span class="preview-sidebar-item-url">http://localhost:8080</span>
              <span class="preview-sidebar-item-method">POST</span>
            </div>
          </div>

          <!-- Inactive Items -->
          <div class="preview-sidebar-item preview-sidebar-item--inactive">
            <div class="preview-sidebar-item-header">
              <span class="preview-sidebar-item-url">http://localhost:8080</span>
              <span class="preview-sidebar-item-method">POST</span>
            </div>
          </div>
          <div class="preview-sidebar-item preview-sidebar-item--inactive">
            <div class="preview-sidebar-item-header">
              <span class="preview-sidebar-item-url">http://localhost:8080</span>
              <span class="preview-sidebar-item-method">POST</span>
            </div>
          </div>
        </div>

        <!-- Right Panel: Details -->
        <div class="preview-details">
          <div class="preview-details-content">
            <!-- Request Headers Section -->
            <div>
              <h4 class="preview-section-title">Request Headers</h4>
              <div class="preview-section-content">
                <div class="preview-grid-row">
                  <span class="preview-grid-label">Accept</span>
                  <span class="preview-grid-value">*/*</span>
                </div>
                <div class="preview-grid-row">
                  <span class="preview-grid-label">Accept-Encoding</span>
                  <span class="preview-grid-value">gzip, br, deflate</span>
                </div>
                <div class="preview-grid-row">
                  <span class="preview-grid-label">Content-Length</span>
                  <span class="preview-grid-value">3895950</span>
                </div>
                <div class="preview-grid-row">
                  <span class="preview-grid-label">Content-Type</span>
                  <span class="preview-grid-value">multipart/form-data; boundary=79d52d378f2295c5-a1b97db5cfdba56a-c9a508873b9d5b10-859541e6b083310e</span>
                </div>
                <div class="preview-grid-row">
                  <span class="preview-grid-label">Host</span>
                  <span class="preview-grid-value">localhost:8080</span>
                </div>
                <div class="preview-grid-row">
                  <span class="preview-grid-label">User-Agent</span>
                  <span class="preview-grid-value">Fluxo-Agent</span>
                </div>
              </div>
            </div>

            <!-- Body Section -->
            <div>
              <h4 class="preview-section-title">Body</h4>
              <div class="preview-body-section">
                <div class="preview-body-row">
                  <span class="preview-body-label">Header</span>
                  <div class="preview-body-content">
                    Content-Disposition: form-data; name="image"; filename="桌布1.jpeg"<br/>
                    Content-Type: image/jpeg
                  </div>
                </div>
                <div class="preview-body-row preview-body-row--center">
                  <span class="preview-body-label">Content</span>
                  <div>
                    <button class="preview-save-button">
                      <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                        <polyline points="7 10 12 15 17 10"></polyline>
                        <line x1="12" y1="15" x2="12" y2="3"></line>
                      </svg>
                      保存檔案
                    </button>
                  </div>
                </div>

                <!-- Separator Line -->
                <div class="preview-separator"></div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Bottom Status Bar -->
      <div class="preview-statusbar">
        <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="12" cy="12" r="10"></circle>
          <line x1="2" y1="12" x2="22" y2="12"></line>
          <path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path>
        </svg>
        網址 : http://localhost:8080, http://172.28.20.130:8080
      </div>
    </div>
  </div>
</template>
