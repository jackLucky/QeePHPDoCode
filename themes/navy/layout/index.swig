<header id="banner" class="wrapper">
  <div class="inner">
    <h2 id="banner-title">{{ page.subtitle }}</h2>
    <div id="banner-start">
      <span id="banner-start-command"><p class="start-line">git clone https://github.com/jackLucky/qeephp.git</p> </span><a id="banner-start-link" href="{{ config.root }}guide/"><i class="fa fa-arrow-right"></i></a>
    </div>
    <div id="banner-share">{{ partial('partial/share') }}</div>
  </div>
</header>
</div>
<div id="content-wrap">
  <div class="wrapper">
    <div class="inner">
      {{ page.content }}
<!--           
      <ul id="intro-feature-list">
        <li class="intro-feature-wrap"><div class="intro-feature">
            <div class="intro-feature-icon">
              <i class="fa fa-code"></i>
            </div>
            <h3 class="intro-feature-title">简洁、清晰的 API</h3>
            <p class="intro-feature-desc">让你不会再为记住那些方法名称而痛苦，我们让一切都更加语义化，更加简洁的命名。符合
              PSR-4 标准，你可以各种方便的与你的框架集成；</p>
          </div></li>
        <li class="intro-feature-wrap"><div class="intro-feature">
            <div class="intro-feature-icon">
              <i class="fa fa-cogs"></i>
            </div>
            <h3 class="intro-feature-title">更清晰的模块划分</h3>
            <p class="intro-feature-desc">你不用花过多的时间在研究微信官方文档上，不用再反复调试那没有规律的
              API，我们已经为你做好了。</p>
          </div></li>
        <li class="intro-feature-wrap"><div class="intro-feature">
            <div class="intro-feature-icon">
              <i class="fa fa-book"></i>
            </div>
            <h3 class="intro-feature-title">丰富的文档与示例</h3>
            <p class="intro-feature-desc">从 3.0 开始，我们将会提供更清晰更规范更清晰的文档与示例。</p>
          </div></li>
        <li class="intro-feature-wrap"><div class="intro-feature">
            <div class="intro-feature-icon">
              <i class="fa fa-bolt"></i>
            </div>
            <h3 class="intro-feature-title">完整的功能支持</h3>
            <p class="intro-feature-desc">微信支付、硬件接入？应有尽有。</p>
          </div>
        </li>
      </ul>
   -->   
      <div id="intro-get-started-wrap">
        <a href="guide/" id="intro-get-started-link">{{ __('index.get_started') }}</a>
      </div>
    </div>
  </div>
</div>