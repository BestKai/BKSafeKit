# BKSafeKit
利用method swizzlie实现类型安全
参考：
<https://github.com/jasenhuang/NSObjectSafe.git>      <https://github.com/JJMM/SafeKit.git>


本来想利用OC的消息转发机制实现屏蔽 `unrecognized selector sent to instance`但是发现总是有点问题，虽然可以屏蔽自定义的一些方法，但是对于系统消息会进行拦截，不完美。

提供两篇文章:

<http://bugly.qq.com/bbs/forum.php?mod=viewthread&tid=24&highlight=unrecognized%2Bselector%2Bsent%2Bto%2Binstance>

<http://bugly.qq.com/bbs/forum.php?mod=viewthread&tid=25&highlight=unrecognized%2Bselector%2Bsent%2Bto%2Binstance>