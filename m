Return-Path: <linux-fsdevel+bounces-1455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E997DA323
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 00:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4526928242F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 22:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6277405D1;
	Fri, 27 Oct 2023 22:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="Lsd3wiih"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA0A3FE3D
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 22:07:00 +0000 (UTC)
Received: from butterfly.pear.relay.mailchannels.net (butterfly.pear.relay.mailchannels.net [23.83.216.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345C51B9
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 15:06:59 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0EBF0501107
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 21:47:14 +0000 (UTC)
Received: from pdx1-sub0-mail-a302.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id B86BA500F6B
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 21:47:13 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1698443233; a=rsa-sha256;
	cv=none;
	b=eq8O/MVN+C5Q3zG9QJloeAQMGMkpxUseiX3CFgQRZNRPSgBhFCuIfRR5HE1FO6yBoQMdW8
	b2ka8qmrzwdPmBRXY+vRmxLCBRXWJuXy+Kx3hDXOjrhQOEer8OGYb8Co6sEhCqtKJX454R
	FcVvBYHbUIKknRsahYOsebnLfLamikenzK8S6BPdp4mNe7B5Niudpvtw2hvtoHIiysuLhJ
	bZo5DbH/w0OGfzIKEjRXnOGT4FLt3KdzYrEQne8qY5C/d3Ln2nenzHXmj8AiymrMitf/ix
	xoFcDCODF6sNqC+I/ZjfoNrT5aM5XNmR+Yb/rZtjurVg2L0oPcy9Q0ZsoH6+uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1698443233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=0kXzCiZbGPBTOEojx/2Lih4mxRwPi4XPavoOAgVaQRE=;
	b=CtdSUzX9cJ4oZL0uCFIW67d2SRTlcfI9yM1YSxlSsOsOpQ/X6PJM5RV4yKJU3oRAxb+QdP
	iE2nXwWZ9IXTQGL4jhlKwEwavYJo1mTX/6s870xU+c8LYgHeBM7WyOWKJz/yglknyw35dA
	/Djt+xXy/DjNyFcmxfndS8AZ98mDmyzlqYnsclZAqC8kiRhGtcadiTXACes3U37B5OacJS
	7vkmDwd5wXGokcCMV4SL5TSIk+LBuL5sWFIwKgV+hz/qvVdUx/4+ZY38tUaNKBrdHIBMlq
	VSzNbtQjmaoRJAYnRdkWk6DqI9+EePVyj4xCNskPejWuf6TXabEi4cxkehxN3A==
ARC-Authentication-Results: i=1;
	rspamd-79d8cddc67-j5nfp;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Little-Sponge: 0ef456e05ab8de5b_1698443233904_3492133301
X-MC-Loop-Signature: 1698443233904:1041117626
X-MC-Ingress-Time: 1698443233904
Received: from pdx1-sub0-mail-a302.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.178.160 (trex/6.9.2);
	Fri, 27 Oct 2023 21:47:13 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a302.dreamhost.com (Postfix) with ESMTPSA id 4SHGTs0RCNz13B
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 14:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1698443233;
	bh=0kXzCiZbGPBTOEojx/2Lih4mxRwPi4XPavoOAgVaQRE=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=Lsd3wiihPliiMMmYhtQI88cIJg9fimvqMqdgkwhuzk65lErIyUvlqM9dOPeNjjg/n
	 KHUzIcX+k8Ky1dwm5dnJj6SxA0+hV6RoMyZ7url0UsC2bfIeH/CD6Kx9SehEx6RWgL
	 lU3Vws/irQxz3fv+7JOYY2l58I3sGQuIgej8+ib9C19rlEsm6vAO9Rl2kPE5B9bz87
	 qyjdkWy3JyUTmTR8E4H0KMUmbuw8YEqh7cVZYN/BrU52hL88b3QSmnLZYGGxflmjy9
	 Wk8x3EWdbNkL8BLjo61mTFpaA57ObpiU5ACZySlWEyUv/ViP7xdDdv6QeFzwFAtnli
	 MuN8OKCn3/u5w==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e00e5
	by kmjvbox (DragonFly Mail Agent v0.12);
	Fri, 27 Oct 2023 14:46:40 -0700
Date: Fri, 27 Oct 2023 14:46:40 -0700
From: Krister Johansen <kjlx@templeofstupid.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	Iurii Zaikin <yzaikin@google.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
	Vlastimil Babka <vbabka@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
	Lecopzer Chen <lecopzer.chen@mediatek.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Hildenbrand <david@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Pingfan Liu <kernelfans@gmail.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Petr Mladek <pmladek@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Guilherme G. Piccoli" <kernel@gpiccoli.net>,
	Mike Rapoport <rppt@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/2] proc: sysctl: prevent aliased sysctls from getting
 passed to init
Message-ID: <960ced39bec87d22f264ab73eec3e3c1a95ec026.1698441495.git.kjlx@templeofstupid.com>
References: <cover.1698441495.git.kjlx@templeofstupid.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698441495.git.kjlx@templeofstupid.com>

The code that checks for unknown boot options is unaware of the sysctl
alias facility, which maps bootparams to sysctl values.  If a user sets
an old value that has a valid alias, a message about an invalid
parameter will be printed during boot, and the parameter will get passed
to init.  Fix by checking for the existence of aliased parameters in the
unknown boot parameter code.  If an alias exists, don't return an error
or pass the value to init.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Cc: stable@vger.kernel.org
Fixes: 0a477e1ae21b ("kernel/sysctl: support handling command line aliases")
---
 fs/proc/proc_sysctl.c  | 7 +++++++
 include/linux/sysctl.h | 6 ++++++
 init/main.c            | 4 ++++
 3 files changed, 17 insertions(+)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index c88854df0b62..1c9635dddb70 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1592,6 +1592,13 @@ static const char *sysctl_find_alias(char *param)
 	return NULL;
 }
 
+bool sysctl_is_alias(char *param)
+{
+	const char *alias = sysctl_find_alias(param);
+
+	return alias != NULL;
+}
+
 /* Set sysctl value passed on kernel command line. */
 static int process_sysctl_arg(char *param, char *val,
 			       const char *unused, void *arg)
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 09d7429d67c0..61b40ea81f4d 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -242,6 +242,7 @@ extern void __register_sysctl_init(const char *path, struct ctl_table *table,
 extern struct ctl_table_header *register_sysctl_mount_point(const char *path);
 
 void do_sysctl_args(void);
+bool sysctl_is_alias(char *param);
 int do_proc_douintvec(struct ctl_table *table, int write,
 		      void *buffer, size_t *lenp, loff_t *ppos,
 		      int (*conv)(unsigned long *lvalp,
@@ -287,6 +288,11 @@ static inline void setup_sysctl_set(struct ctl_table_set *p,
 static inline void do_sysctl_args(void)
 {
 }
+
+static inline bool sysctl_is_alias(char *param)
+{
+	return false;
+}
 #endif /* CONFIG_SYSCTL */
 
 int sysctl_max_threads(struct ctl_table *table, int write, void *buffer,
diff --git a/init/main.c b/init/main.c
index 436d73261810..e24b0780fdff 100644
--- a/init/main.c
+++ b/init/main.c
@@ -530,6 +530,10 @@ static int __init unknown_bootoption(char *param, char *val,
 {
 	size_t len = strlen(param);
 
+	/* Handle params aliased to sysctls */
+	if (sysctl_is_alias(param))
+		return 0;
+
 	repair_env_string(param, val);
 
 	/* Handle obsolete-style parameters */
-- 
2.25.1


