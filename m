Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77D968008E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jan 2023 18:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbjA2RtN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Jan 2023 12:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjA2RtM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Jan 2023 12:49:12 -0500
X-Greylist: delayed 78 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 29 Jan 2023 09:49:08 PST
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CEF1BAF2;
        Sun, 29 Jan 2023 09:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1675014546;
        bh=Y61RWFCbR13wg6BFep+WVQctLjj8vWW8mlN2SWaoMr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=J2BguWbhEexvqnNz2dMk2SYbsqa+8kWbcoZHzLliCBz7Wa32ya81J2CDCpv05N4yy
         ZGi3z6Oj47mYz1/BlJTDe5UIQMjid/a93VlhMKnpjzH4XeFA+eCMvLnBQkbYMpRa5Q
         sa1bH1H6LunI7oHLobI4tzUlY4Lv5JsdAnOmgCrQ=
Received: from wen-VirtualBox.lan ([222.182.118.145])
        by newxmesmtplogicsvrsza2-0.qq.com (NewEsmtp) with SMTP
        id BEC84CF4; Mon, 30 Jan 2023 01:47:44 +0800
X-QQ-mid: xmsmtpt1675014467t06e4mn1g
Message-ID: <tencent_D113D23D99C9FC229F0FAADCA8CF823A2609@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTWGp3hc87REw5AQmiRShY3adkgN1gxutWh75RtbesjrHJxSj3m/
         ly7leuSPrmCFWHzCLmOzBl8Xcwl0d05/AzW4qxaCl0LJ8Bf1r81PPOmEU6S7ns22qt1MdUqQf4bx
         MMEiKwMlDpt6w3wp7+Ef8BdJQtmDUzE/Z4CxftwADe9SgvweitZjLEkIvfdtP1HzQ9CgzZvE9eID
         P64gv6YMrT+ruHqBHOGlqEsneVPvIuiodUHHUCfS6D+YClCI0HqLSxJawMNH+OUZ1jTCQTraaXJi
         QOe5cyqoqL7//IZ8XFGZdDUC22U7J/IDaODINFjFm9NMLaWIo39/I4Ko1zeKzkjSNYHVCmcP4due
         EjrD5XRVCAxuO5HYo0OSRWS11ATxcaEARCbaZtXL15h+r5Hq4rtPxQLN2z43jP5odUg5zLwIVXyH
         GqOe0NoMXRpbNsU3MzVzKxglQJN3rWf3eOyhprC+XdrZ1z0e45RqTDLbyClmf4qTUHjlwIMzFlca
         y+1+AxuJ7sSkhVC0AfItMcW96UsJN5zL0VqwkbmWrAmzy4dIeYknZAkLREYPm3w0Shh8v5bacAxA
         qt1tDDREXSSeQgfcIGlC2yS2+5SAuZvVxYsAhQs2RKfCC8nretTMQwXvA9t7D+KksFwcBQ1tEiaX
         WYbwwgpAq3ofwQzqYEgcfZa5A7h5At7Ll6kQdhXjqv4QKCs851Q/ljRs+go29lDgx1xvYUQ0YBzR
         +pQ6RLgjz6uOqJzE4qoQsXhGuGvG2TEJC7eVCac/x5lZtk6m7Z1fBZWnIKCoF0+eb8ProJC6o1kg
         oIbPHOkC9v3ovpWWu/P9Z5tTNIvjxbvsVV3Kt/dWBw+EE53IX6kP/0E0/IOhcykS8P77MlWeAHrC
         jeL+z4J+MamohrqW+Yrwxl2W3R3ruA3h+r5xlhJd2/Z1S4brVnFkwoU47O93/qiYmFmKZD3q5Qx6
         IqHuZ74NY82tvDWyjI1t0++tPG8LmjM8j+DlRiHKvwkaH8vnNYXvP6bnHeUo+ROB5PuaCgzLEaU2
         WLLlHR0A==
From:   wenyang.linux@foxmail.com
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Wen Yang <wenyang.linux@foxmail.com>,
        Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        Jens Axboe <axboe@kernel.dk>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] eventfd: support delayed wakeup for non-semaphore eventfd to reduce cpu utilization
Date:   Mon, 30 Jan 2023 01:47:21 +0800
X-OQ-MSGID: <20230129174721.18155-2-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230129174721.18155-1-wenyang.linux@foxmail.com>
References: <20230129174721.18155-1-wenyang.linux@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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
https://github.com/w-simon/tests/blob/master/src/test.c
./test_zmq  > /dev/null

The cpu usage is as follows:
12:14:22     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
12:14:24     all   55.46    0.00    4.78    0.00    0.00    0.96    0.00    0.00    0.00   38.80
12:14:26     all   56.29    0.00    4.70    0.00    0.00    1.24    0.00    0.00    0.00   37.76
12:14:28     all   54.97    0.00    5.25    0.00    0.00    0.97    0.00    0.00    0.00   38.81
12:14:30     all   56.02    0.00    5.26    0.00    0.00    1.24    0.00    0.00    0.00   37.48
12:14:32     all   55.31    0.00    5.03    0.00    0.00    1.40    0.00    0.00    0.00   38.27
12:14:34     all   55.46    0.00    5.26    0.00    0.00    1.24    0.00    0.00    0.00   38.04

Then adjust the new control parameter, as follows:
echo 5 > /proc/sys/fs/eventfd_write_wake_delay_ms

The cpu usagen was observed to decrease by more than 30%, as follows:
12:14:36     all   28.17    0.00    0.93    0.00    0.00    0.00    0.00    0.00    0.00   70.90
12:14:38     all   24.00    0.00    0.80    0.00    0.00    0.13    0.00    0.00    0.00   75.07
12:14:40     all   23.57    0.00    0.53    0.00    0.00    0.13    0.00    0.00    0.00   75.77
12:14:42     all   23.59    0.00    0.40    0.00    0.00    0.00    0.00    0.00    0.00   76.01
12:14:44     all   23.69    0.00    0.27    0.00    0.00    0.00    0.00    0.00    0.00   76.04
12:14:46     all   23.20    0.00    0.67    0.00    0.00    0.13    0.00    0.00    0.00   76.00
12:14:48     all   24.87    0.00    0.66    0.00    0.00    0.00    0.00    0.00    0.00   74.47
12:14:50     all   24.27    0.00    0.66    0.00    0.00    0.00    0.00    0.00    0.00   75.07

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dylan Yudaken <dylany@fb.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventfd.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index c5bda3df4a28..e45436737f9d 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -41,6 +41,9 @@ struct eventfd_ctx {
 	__u64 count;
 	unsigned int flags;
 	int id;
+#ifdef CONFIG_SYSCTL
+	struct delayed_work dwork;
+#endif
 };
 
 __u64 eventfd_signal_mask(struct eventfd_ctx *ctx, __u64 n, unsigned mask)
@@ -95,6 +98,9 @@ static void eventfd_free_ctx(struct eventfd_ctx *ctx)
 {
 	if (ctx->id >= 0)
 		ida_simple_remove(&eventfd_ida, ctx->id);
+#ifdef CONFIG_SYSCTL
+	flush_delayed_work(&ctx->dwork);
+#endif
 	kfree(ctx);
 }
 
@@ -256,6 +262,28 @@ static ssize_t eventfd_read(struct kiocb *iocb, struct iov_iter *to)
 	return sizeof(ucnt);
 }
 
+#ifdef CONFIG_SYSCTL
+
+static unsigned long sysctl_eventfd_write_wake_delay_ms;
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
@@ -282,8 +310,26 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
 	if (likely(res > 0)) {
 		ctx->count += ucnt;
 		current->in_eventfd = 1;
-		if (waitqueue_active(&ctx->wqh))
+
+		/* waitqueue_active is safe because ctx->wqh.lock is being held here. */
+		if (waitqueue_active(&ctx->wqh)) {
+#ifdef CONFIG_SYSCTL
+			if (ctx->flags & EFD_SEMAPHORE)
+				wake_up_locked_poll(&ctx->wqh, EPOLLIN);
+			else {
+				unsigned long delay = sysctl_eventfd_write_wake_delay_ms;
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
 		current->in_eventfd = 0;
 	}
 	spin_unlock_irq(&ctx->wqh.lock);
@@ -406,6 +452,9 @@ static int do_eventfd(unsigned int count, int flags)
 	ctx->count = count;
 	ctx->flags = flags;
 	ctx->id = ida_simple_get(&eventfd_ida, 0, 0, GFP_KERNEL);
+#ifdef CONFIG_SYSCTL
+	INIT_DELAYED_WORK(&ctx->dwork, eventfd_delayed_workfn);
+#endif
 
 	flags &= EFD_SHARED_FCNTL_FLAGS;
 	flags |= O_RDWR;
@@ -438,3 +487,31 @@ SYSCALL_DEFINE1(eventfd, unsigned int, count)
 	return do_eventfd(count, 0);
 }
 
+#ifdef CONFIG_SYSCTL
+
+static unsigned long min_wake_delay;
+
+static unsigned long max_wake_delay = HZ / 10;
+
+static struct ctl_table fs_eventfd_ctl[] = {
+	{
+		.procname      = "eventfd_write_wake_delay_ms",
+		.data          = &sysctl_eventfd_write_wake_delay_ms,
+		.maxlen        = sizeof(unsigned long),
+		.mode          = 0644,
+		.proc_handler  = proc_doulongvec_ms_jiffies_minmax,
+		.extra1        = (void *)&min_wake_delay,
+		.extra2        = (void *)&max_wake_delay,
+	},
+	{ }
+};
+
+static int __init init_fs_exec_sysctls(void)
+{
+	register_sysctl_init("fs", fs_eventfd_ctl);
+	return 0;
+}
+
+fs_initcall(init_fs_exec_sysctls);
+
+#endif /* CONFIG_SYSCTL */
-- 
2.37.2

