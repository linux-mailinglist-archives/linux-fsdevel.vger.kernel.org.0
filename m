Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0357D6E37C9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 13:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjDPLpn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 07:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjDPLpm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 07:45:42 -0400
X-Greylist: delayed 801 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 16 Apr 2023 04:45:40 PDT
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F231BD0
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Apr 2023 04:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1681645537;
        bh=HEn7uCmufleFzqhAfssVM6gFo6aBgBWRD2eGaMBDrYA=;
        h=From:To:Cc:Subject:Date;
        b=ZFOknG4OeXyL5Bwp+EqgF3HQd7iZTLsVMXIcGUftzXbudYv6k5PT9VCixlWA+7Cfr
         l0SsZpeA8X7jFyQ7IOkAHNfk26a9PseIOkYb83hQ8OkdfhNeoMpEcKYczgu0vc7wFW
         xIoxjmh/TqFM3S2vMwrDUFX6mQ10yDyNlafXhh6w=
Received: from wen-VirtualBox.lan ([106.92.97.36])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id 8010569A; Sun, 16 Apr 2023 19:32:01 +0800
X-QQ-mid: xmsmtpt1681644721tkwysbehx
Message-ID: <tencent_AF886EF226FD9F39D28FE4D9A94A95FA2605@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9eZ/qO3bGnXWU67tnbfJ7f+MZu9EtuAFRQzCN6W51OV9NvuyvLQ
         fre6s75Vv9BNPg1NyGHzB8iMlYlwS1YHsq6Ao67eJAwBMGLQrDqbczTytpdwKM1lRyop9kVQd/6U
         RiBs1i1c1MVrP0cJU2f/wL7taVgbvYeDgAJEDkMveidUTGgpTFdnkORVW1p05BUrGWxryONwWx0p
         g7dKJWq56kCu1gAa5Vjm/CJ6ecMwNXAc5gQZ/BskeVWZnHPSFkURkGF0T/m+oqjUfEmWJgfPwDRd
         m9MuLWP+4UfLQG/t1BagvPBEk4pZv56xfRuoBNaOD/BLcE0uqD3Z2pm8JUjfhdgnsP7ZJnEOueEl
         DB8p/L/o3At7RPhkfjgVEsPOZlQRyOzR912tOu7XBujPcR0FlPcSY5ryNSCECADgvP0O9RGtoJt+
         uIq39QjmR/KBIQy1v25EULnNwvcjYgXCgPDFTziBYaKMnNxgEBwNldeOpUz/YznHM3oovOHCowXz
         Xs5dRm1N2FaUzROlbN2DNEmr0v93+2AqdaCXhlg+ZObQwac4j7PVSkKHL/wWB7/eolproQPT//GK
         eEODWXhUz4TX9ustd3jotBQSh382uQnCd4nQ6LDfsf3aNOZACrJ2K6kwOsWvYaagtzDkc0lCPsd4
         ri5z8WI09/apg180fQivy2ZFyS/5XOq5l8CtaHJ9MoNqXUYZ3Bx/WeR7bdigYDKYC70QP20LvpYl
         ncpINZLu9ie3g8TyNBXWdJExZax+ed3sZcWQsesBFywqNf+905bhD3STASf/iupfjpX8EJEFF7dx
         vzfQ8S6/yOxVbMDyEmX23VM91mRWcCEd1fnIJZsWnA3v40faGSJSW3BRv7v4gFUf6huWjeGhVVbb
         UBOmKTXZlUmgBIVqGIHlGrC8i1Cvb550ng+XqL516GudWFu92USu3fyi/AbSA41LT9uaF2PbQsg2
         MNdFndHLHWq8Fxt8/49EIiF9K/TZTeUvJWpJFP3UfFh88M3hJeitytiQYXAKl7RijpBfsOdo6KLL
         m2bdxTJ5EJTWeYH722CzC122dawV4=
From:   wenyang.linux@foxmail.com
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Wen Yang <wenyang.linux@foxmail.com>,
        Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Paolo Bonzini <pbonzini@redhat.com>, Fu Wei <wefu@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] eventfd: support delayed wakeup for non-semaphore eventfd to reduce cpu utilization
Date:   Sun, 16 Apr 2023 19:31:55 +0800
X-OQ-MSGID: <20230416113155.18753-1-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Wen Yang <wenyang.linux@foxmail.com>

For the NON SEMAPHORE eventfd, if it's counter has a nonzero value,
then a read(2) returns 8 bytes containing that value, and the counter's
value is reset to zero. Therefore, in the NON SEMAPHORE scenario,
N event_writes vs ONE event_read is possible.

However, the current implementation wakes up the read thread immediately
in eventfd_write so that the cpu utilization increases unnecessarily.

By adding a configurable delay after eventfd_write, these unnecessary
wakeup operations are avoided, thereby reducing cpu utilization.

We used the following test code:

 #include <assert.h>
 #include <errno.h>
 #include <unistd.h>
 #include <stdio.h>
 #include <string.h>
 #include <poll.h>
 #include <sys/eventfd.h>
 #include <sys/prctl.h>

void publish(int fd)
{
	unsigned long long i = 0;
	int ret;

	prctl(PR_SET_NAME,"publish");
	while (1) {
		i++;
		ret = write(fd, &i, sizeof(i));
		if (ret < 0)
			printf("XXX: write error: %s\n", strerror(errno));
	}
}

void subscribe(int fd)
{
	unsigned long long i = 0;
	struct pollfd pfds[1];
	int ret;

	prctl(PR_SET_NAME,"subscribe");
	pfds[0].fd = fd;
	pfds[0].events = POLLIN;

	usleep(10);
	while(1) {
		ret = poll(pfds, 1, -1);
		if (ret == -1)
			printf("XXX: poll error: %s\n", strerror(errno));
		if(pfds[0].revents & POLLIN)
			read(fd, &i, sizeof(i));
	}
}

int main(int argc, char *argv[])
{
	pid_t pid;
	int fd;

	fd = eventfd(0, EFD_CLOEXEC | EFD_NONBLOCK | EFD_NONBLOCK);
	assert(fd);

	pid = fork();
	if (pid == 0)
		subscribe(fd);
	else if (pid > 0)
		publish(fd);
	else {
		printf("XXX: fork error!\n");
		return -1;
	}

	return 0;
}

 # taskset -c 2-3 ./a.out

The original cpu usage is as follows:
07:02:55 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
07:02:57 PM  all   16.43    0.00   16.28    0.16    0.00    0.00    0.00    0.00    0.00   67.14
07:02:57 PM    0    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
07:02:57 PM    1    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
07:02:57 PM    2   29.21    0.00   34.83    1.12    0.00    0.00    0.00    0.00    0.00   34.83
07:02:57 PM    3   51.97    0.00   48.03    0.00    0.00    0.00    0.00    0.00    0.00    0.00

07:02:57 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
07:02:59 PM  all   18.75    0.00   17.47    2.56    0.00    0.32    0.00    0.00    0.00   60.90
07:02:59 PM    0    6.88    0.00    1.59    5.82    0.00    0.00    0.00    0.00    0.00   85.71
07:02:59 PM    1    1.04    0.00    1.04    2.59    0.00    0.00    0.00    0.00    0.00   95.34
07:02:59 PM    2   26.09    0.00   35.87    0.00    0.00    1.09    0.00    0.00    0.00   36.96
07:02:59 PM    3   52.00    0.00   47.33    0.00    0.00    0.67    0.00    0.00    0.00    0.00

07:02:59 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
07:03:01 PM  all   16.15    0.00   16.77    0.00    0.00    0.00    0.00    0.00    0.00   67.08
07:03:01 PM    0    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
07:03:01 PM    1    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
07:03:01 PM    2   27.47    0.00   36.26    0.00    0.00    0.00    0.00    0.00    0.00   36.26
07:03:01 PM    3   51.30    0.00   48.70    0.00    0.00    0.00    0.00    0.00    0.00    0.00

Then settinga the new control parameter, as follows:
echo 5 > /proc/sys/fs/eventfd_wakeup_delay_msec

The cpu usagen was observed to decrease by more than 20% (cpu #2, 26% -> 0.x%),  as follows:

07:03:01 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
07:03:03 PM  all   10.31    0.00    8.36    0.00    0.00    0.00    0.00    0.00    0.00   81.34
07:03:03 PM    0    0.00    0.00    1.01    0.00    0.00    0.00    0.00    0.00    0.00   98.99
07:03:03 PM    1    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
07:03:03 PM    2    0.52    0.00    1.05    0.00    0.00    0.00    0.00    0.00    0.00   98.43
07:03:03 PM    3   56.59    0.00   43.41    0.00    0.00    0.00    0.00    0.00    0.00    0.00

07:03:03 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
07:03:05 PM  all   10.61    0.00    7.82    0.00    0.00    0.00    0.00    0.00    0.00   81.56
07:03:05 PM    0    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
07:03:05 PM    1    0.00    0.00    1.01    0.00    0.00    0.00    0.00    0.00    0.00   98.99
07:03:05 PM    2    0.53    0.00    0.53    0.00    0.00    0.00    0.00    0.00    0.00   98.94
07:03:05 PM    3   58.59    0.00   41.41    0.00    0.00    0.00    0.00    0.00    0.00    0.00

07:03:05 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
07:03:07 PM  all    8.99    0.00    7.25    0.72    0.00    0.00    0.00    0.00    0.00   83.04
07:03:07 PM    0    0.00    0.00    1.52    2.53    0.00    0.00    0.00    0.00    0.00   95.96
07:03:07 PM    1    0.00    0.00    0.50    0.00    0.00    0.00    0.00    0.00    0.00   99.50
07:03:07 PM    2    0.54    0.00    0.54    0.00    0.00    0.00    0.00    0.00    0.00   98.92
07:03:07 PM    3   57.55    0.00   42.45    0.00    0.00    0.00    0.00    0.00    0.00    0.00

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dylan Yudaken <dylany@fb.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fu Wei <wefu@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/admin-guide/sysctl/fs.rst | 13 +++++
 fs/eventfd.c                            | 78 ++++++++++++++++++++++++-
 init/Kconfig                            | 19 ++++++
 3 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
index a321b84eccaa..7baf702c2f72 100644
--- a/Documentation/admin-guide/sysctl/fs.rst
+++ b/Documentation/admin-guide/sysctl/fs.rst
@@ -70,6 +70,19 @@ negative dentries which do not map to any files. Instead,
 they help speeding up rejection of non-existing files provided
 by the users.
 
+eventfd_wakeup_delay_msec
+------------------
+Frequent writing of an eventfd can also lead to frequent wakeup of the peer
+read process, resulting in significant cpu overhead.
+How ever for the NON SEMAPHORE eventfd, if it's counter has a nonzero value,
+then a read(2) returns 8 bytes containing that value, and the counter's value
+is reset to zero.
+So it coule be optimized as follows: N event_writes vs ONE event_read.
+By adding a configurable delay after eventfd_write, these unnecessary wakeup
+operations are avoided.
+The max value is 100 ms.
+
+Default: 0
 
 file-max & file-nr
 ------------------
diff --git a/fs/eventfd.c b/fs/eventfd.c
index 95850a13ce8d..c34fff843c48 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -41,6 +41,9 @@ struct eventfd_ctx {
 	__u64 count;
 	unsigned int flags;
 	int id;
+#ifdef CONFIG_EVENTFD_WAKEUP_DELAY
+	struct delayed_work dwork;
+#endif
 };
 
 __u64 eventfd_signal_mask(struct eventfd_ctx *ctx, __u64 n, unsigned mask)
@@ -95,6 +98,9 @@ static void eventfd_free_ctx(struct eventfd_ctx *ctx)
 {
 	if (ctx->id >= 0)
 		ida_simple_remove(&eventfd_ida, ctx->id);
+#ifdef CONFIG_EVENTFD_WAKEUP_DELAY
+	flush_delayed_work(&ctx->dwork);
+#endif
 	kfree(ctx);
 }
 
@@ -256,6 +262,28 @@ static ssize_t eventfd_read(struct kiocb *iocb, struct iov_iter *to)
 	return sizeof(ucnt);
 }
 
+#ifdef CONFIG_EVENTFD_WAKEUP_DELAY
+
+static unsigned long eventfd_wake_delay_jiffies;
+
+static void eventfd_delayed_workfn(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct eventfd_ctx *ctx = container_of(dwork, struct eventfd_ctx, dwork);
+
+	spin_lock_irq(&ctx->wqh.lock);
+	current->in_eventfd = 1;
+	if (ctx->count) {
+		/* waitqueue_active is safe because ctx->wqh.lock is being held here. */
+		if (waitqueue_active(&ctx->wqh))
+			wake_up_locked_poll(&ctx->wqh, EPOLLIN);
+	}
+	current->in_eventfd = 0;
+	spin_unlock_irq(&ctx->wqh.lock);
+}
+
+#endif
+
 static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t count,
 			     loff_t *ppos)
 {
@@ -282,8 +310,27 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
 	if (likely(res > 0)) {
 		ctx->count += ucnt;
 		current->in_eventfd = 1;
-		if (waitqueue_active(&ctx->wqh))
+
+		/* waitqueue_active is safe because ctx->wqh.lock is being held here. */
+		if (waitqueue_active(&ctx->wqh)) {
+#ifdef CONFIG_EVENTFD_WAKEUP_DELAY
+			if (ctx->flags & EFD_SEMAPHORE)
+				wake_up_locked_poll(&ctx->wqh, EPOLLIN);
+			else {
+				unsigned long delay = eventfd_wake_delay_jiffies;
+
+				if (delay) {
+					if (!delayed_work_pending(&ctx->dwork))
+						queue_delayed_work(system_unbound_wq,
+								&ctx->dwork, delay);
+				} else
+					wake_up_locked_poll(&ctx->wqh, EPOLLIN);
+			}
+#else
 			wake_up_locked_poll(&ctx->wqh, EPOLLIN);
+#endif
+		}
+
 		current->in_eventfd = 0;
 	}
 	spin_unlock_irq(&ctx->wqh.lock);
@@ -406,6 +453,9 @@ static int do_eventfd(unsigned int count, int flags)
 	ctx->count = count;
 	ctx->flags = flags;
 	ctx->id = ida_simple_get(&eventfd_ida, 0, 0, GFP_KERNEL);
+#ifdef CONFIG_EVENTFD_WAKEUP_DELAY
+	INIT_DELAYED_WORK(&ctx->dwork, eventfd_delayed_workfn);
+#endif
 
 	flags &= EFD_SHARED_FCNTL_FLAGS;
 	flags |= O_RDWR;
@@ -438,3 +488,29 @@ SYSCALL_DEFINE1(eventfd, unsigned int, count)
 	return do_eventfd(count, 0);
 }
 
+#ifdef CONFIG_EVENTFD_WAKEUP_DELAY
+
+static const unsigned long eventfd_wake_delay_max = HZ / 10;
+
+static struct ctl_table fs_eventfd_ctl[] = {
+	{
+		.procname      = "eventfd_wakeup_delay_msec",
+		.data          = &eventfd_wake_delay_jiffies,
+		.maxlen        = sizeof(eventfd_wake_delay_jiffies),
+		.mode          = 0644,
+		.proc_handler  = proc_doulongvec_ms_jiffies_minmax,
+		.extra1        = SYSCTL_ZERO,
+		.extra2        = (void *)&eventfd_wake_delay_max,
+	},
+	{ }
+};
+
+static int __init init_fs_eventfd_sysctls(void)
+{
+	register_sysctl_init("fs", fs_eventfd_ctl);
+	return 0;
+}
+
+fs_initcall(init_fs_eventfd_sysctls);
+
+#endif /* CONFIG_EVENTFD_WAKEUP_DELAY */
diff --git a/init/Kconfig b/init/Kconfig
index 750d41a38574..23d68bcc1f19 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1629,6 +1629,25 @@ config EVENTFD
 
 	  If unsure, say Y.
 
+if EVENTFD
+config EVENTFD_WAKEUP_DELAY
+	bool "support delayed wakeup for the non-semaphore eventfd" if EXPERT
+	default n
+	depends on SYSCTL
+	help
+	  This option enables the delayed wakeup for the non-semaphore eventfd.
+	  Frequent writing of an eventfd can also lead to frequent wakeup of
+	  the peer read process, resulting in significant cpu overhead.
+	  How ever for the NON SEMAPHORE eventfd, if it's counter has a
+	  nonzero value, then a read(2) returns 8 bytes containing that value,
+	  and the counter's value is reset to zero.
+	  By adding a configurable delay after eventfd_write, these unnecessary
+	  wakeup operations are avoided.
+
+	  If unsure, say N.
+
+endif # EVENTFD
+
 config SHMEM
 	bool "Use full shmem filesystem" if EXPERT
 	default y
-- 
2.37.2

