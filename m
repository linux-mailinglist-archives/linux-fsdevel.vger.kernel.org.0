Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0FA631BB73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 15:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhBOOye (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 09:54:34 -0500
Received: from sonic310-21.consmr.mail.gq1.yahoo.com ([98.137.69.147]:42407
        "EHLO sonic310-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229604AbhBOOya (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 09:54:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1613400791; bh=u26O4cC6s1lYSCJ8KFFpL0dyE7WMmST9692D1qmPohE=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=eZy4grwznBvS7wFkQi6kRUm8tS9cvwJrJ4qHSQdx+wrIHtkMOWJvsy5rVnUfOnz3zAjPliTF5AXYvfW0NVNieJojk255/b/G+qBVj5KA22RnmOiPDPMfK41Fly4tJd5AGgn+hBB6cWXP2lRnCaboO/cSeBU8wgbu1TIFQutbW7XqztLg1gVvGAunhWIRE7E2/BGMfM8ZQW9PpCeDz4jZB3iyJR3uvLUhz1EQUttuF1D1M1gev7L7YvsscFPz4aqEcEEek0vYovVxe7Ug3+N6JhkuJEMPPviATI8eS0VZNUvXIKIUqiwmCoEEcANnHFiLYqRvBsPWgA+nPB8E8kzh8g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1613400791; bh=pv/jgQO4/28xzFzUDwQDkU/9z5HacvUo6p+XlGpxI++=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=fmtQqIVAJ5tjVpmm1+EIrMWH/r3w2bX3OCJhU/Wjr4pqzNjCu5EMrAA7RgfOOkWeC+QeGcjA0WnmEDslGagzOcbcr6NYB2IWSumgAtm9zYYl1doO/+7c2UHoklPrrNUM1aTj3TQfJwzrVRJIFMRY2mCoYjFCHWFAvBc5BH76VAeUkw8/AAzkItmg4izTVcOyZY+LJV1z0XzefruQ1q4UgbOjlf9WuN1xOUdjOqOnSbOZDaAnXEHEBess8zWjzUutRPDv79oXt+0u0IYmoiHHXwerdugSvp62ZJlv29LofP2YCoInEzTVlMUkdKvLEQLkTws0tehlgwm66F0S2l8ZpQ==
X-YMail-OSG: .6gbdeIVM1nXJ53TWnW_..DG.AKVy3FgTDA2dlJ398.VWD3nROWDvRxsEQnvt8z
 8oYHpJ0C4mLvQ88eXoSsI4aLt99pVb_vRrmgxzcZ311hhxInlT_URAargesRkdz9PW_aD_o.lA9h
 _xjRDJLJrLLszVdAq2VYR9L441akD2sJCDTK_Hikxrw4d7N1_T4u17GMh0bkxmgTToof8ABRIQ5o
 k_PUAxL3ZOdmhMNoHegCupv_ki.Jasr_wDubx7ypuRpcGzF7u33aB3zEXnHGLd5Pa.W6AmHClG.N
 tmwLs.Qf4x.IDnzNVjc5fXQtSEET.8zxp5hJPENe7yv6aeRpFDZNTfzbZjJZYfeBsNOF_a2.ULuJ
 bKThYiqwl_.eqVm8PlaJqgGk0p9ebyOtRLic._il5tGaljA4akdwaiRCw0ZXTaTwL8wimhkHjyXZ
 Tecaof6lhsBY1oFUWongCtHTudLdriHz7h5yb1uaX0CtDpRk9bIDhJEEE4Ik0XfXbf1FoQDooPu8
 AkRDr7wpL138C0NxI6CPNYfp.PRx0sesu8Ok.PqUdtsR1NMfnWMhnZrWI3VSoNSDHJdQOnnS0rXa
 IAk_Dylk_y0wKDH8Ve04BvMwcn_OFr05DmFJjG5p7l9rotQLKAb6MZeij.RrTsR2tQ5PE2ltC1s_
 7gG9A1Lgtp09f7Fpgpolgs33OIKpPpTOeYwvLaLgx9sGC.jF6LtiBjLfULwjpnGj4U8nMbhsk.wp
 wMFNKcv9z5GfcclZRWfJ5eAKq75tpH2xq2uPbhPJsICQZ70WkktmtNwIA28wmp._RinckLZP_o5i
 Xlj1YlpkaJ0FSs3MiRYY6PiSebkGV_1GRCnCpbfMvHhMCbLTvXXXMi_ce4UInDKpxgIN.s4qfYeK
 E6ot3VQQHu9bydArbQdGhbGCgAF0ijfNPwi9tOSF90NxGx4M.RUziVA1ZByukj6_3MRahaVvU3T6
 zgpP7zGNVfitO.Pzg3Q.DAe49g8owAEokipYBxZqWZnUoH_N9gVGDPkZNsfVcCSfy_QQ8ZidZTdF
 nlyYq5Vw0rhbVY9Fp2zYYsLnwlYwSxdLwe6WHvLSjXXcxpJ1ulVXOTxGHth4cLCAarcDe6paS3IE
 04Gn2cihJuwCntovfHDCSIEkl.ZWn85iRaJMlOd.PaLp4BAgm.8QxFc1LKCyQEpUxfFS0pdFkiSz
 Wm9NCIt96ca.ZyATNYta.dLUpzC40JpyWVT408XNfDDR1jgptDa9UZvCO.EmohYfWtuqRmsh_yc0
 HYu4gK4CBy28T1o.AHgkcFG0IMoDDr47ELHjzfogb4Y4K1Z6KI2cKAqSPQvu53uhbjxqz6LyU4HE
 8.T6ACJa0RUSkokKvG1u9xrBzGTsBIYHmf_TOu4sJH9z3rOMDQPXpbFDGTpg9rEhobeyKG90wgJY
 wJA8m.sdm4l8gqshMg1GHNR0ufHQlzCJe06SRvK1.Shqsjfdiy.nyhMvFJ5cMZE3oMw4OSUXHfWc
 EzZQg3kucv10pqiKyoO_UCTqv7NWxUnRBtQpAXw3L4UT7lNpxHtB6YGBrmwhNHfWzBfIE1ldtUJI
 VvGQ2cJaG_Ul867vrUz9iIf5fhywW43QAZKYJb6KV5im8qHzd1ok5lUXPWGUZ3m0psSMprOEMh8j
 4.7mRcyfpQ6du0Xn3t4VeQQlwj2j.GSuEBUBRTMHO1BHob9utPd1wg2z7.NWIOkw84fcy7Q2AnEY
 9.fpncbhV9T.tKOf5BVOalyy4tHXrf4CZ2Fl_l_C99JWIR7uHlIf5udmup8XlryhaO3UiyThInQ0
 vFc4ZWbXCfbMV2Kh9qDiXaMSaWRAYBvCbABb7kueg9leJFZlAjXkGdJvgflaLcmtC9_HiXHwDYgR
 pae4iUjiFoQ.ipP0bkM4PKcuUzL.dpjKDAnSFSPCTgSo.yQmJhp4Dirme8I86Vrqa9poBgJu36V9
 Ax4cXb8RMrUR2QqKM3G58__FhVhhd2AjxnaRK1eohTa_ruh83Apkw2KMi1dE0B.g7SSm015Yo8dD
 QDzW5FzKpN636G2oLmtzRRzOEKBEZz1fQ4sjPCJCJQjvBblXCGkb.ubaBLmH3Z4psOsDpTl2KwMR
 cPi3idrZtfWwIoqqASQy.x_jA3oZ9FONh0BVry52yh7JNrf_yjRl.HJWWlliPslDHB6bqc_S5D0r
 71bILDQ1LFw1KzwAoSR4W_f.mQEMU_OFuyZDXwuHIS0TwBW78rZXWEn8NQJbWjkK8HmfSooYlvwc
 gND4nXl81h6VsUWGJ39eHYL4SgynBi8X5GlnlI5oV46oiMyoN09qA0TCBSPkr_KVzLpxR8wfV1Sx
 0nKjqFlb.F4l1lQjrwN0ld2esq4jbcp1olMQlNgv9AFfFsBmfWXUsP1zj4YPRCpiN6hjs0aGbAp0
 o.aO1n_KthYtso_7221XJe.PYnobeNZPl1FBlPTvvrqdZ9qHaH0THdz0lfp.JdVnDfIkZzQONd4U
 Lj1iqQM_THwpKycz85KoWWdIhZMXXNw7hh3ir6Kov.0UPPBFIemvoGbNXzcFlJ0w2lR9lhQeuxx5
 qZlCqti1.5KzMpVAQt0OXWMDJJ2ParCo.bJH7nwZOGOZ9NjkfV7nu1XtfaPfOIRirXxgFLcTcCqY
 Ups4oWOhRR9qvhlEUB_MoW99z_GsBHQQfTV0nCATG8NAFC1cxd33bK7AWsUHWa0hGV_of0mRQbGq
 .D6jCPLmOiUf4V1_8Cb23NnOj9usU3VKrP9_Emhx7PP.UQ_1dK7DNMB0idIIb3A69XhNbLuriyIn
 FvDbhroCzMEo-
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Mon, 15 Feb 2021 14:53:11 +0000
Received: by smtp401.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 0cff98c1fbbc603be05b279cd6d03027;
          Mon, 15 Feb 2021 14:53:07 +0000 (UTC)
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
To:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@lst.de>, Andrey Ignatov <rdna@fb.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: [PATCH] proc_sysctl: clamp sizes using table->maxlen
Date:   Mon, 15 Feb 2021 09:53:05 -0500
Message-Id: <20210215145305.283064-1-alex_y_xu@yahoo.ca>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20210215145305.283064-1-alex_y_xu.ref@yahoo.ca>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This issue was discussed at [0] and following, and the solution was to
clamp the size at KMALLOC_MAX_LEN. However, KMALLOC_MAX_LEN is a maximum
allocation, and may be difficult to allocate in low memory conditions.

Since maxlen is already exposed, we can allocate approximately the right
amount directly, fixing up those drivers which set a bogus maxlen. These
drivers were located based on those which had copy_x_user replaced in
32927393dc1c, on the basis that other drivers either use builtin proc_*
handlers, or do not access the data pointer. The latter is OK because
maxlen only needs to be an upper limit.

[0] https://lore.kernel.org/lkml/1fc7ce08-26a7-59ff-e580-4e6c22554752@oracle.com/

Fixes: 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
Signed-off-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
---
 drivers/parport/procfs.c       | 20 ++++++++++----------
 fs/proc/proc_sysctl.c          | 13 ++++++++-----
 include/linux/sysctl.h         |  2 +-
 net/core/sysctl_net_core.c     |  1 +
 net/decnet/sysctl_net_decnet.c |  4 ++--
 net/sunrpc/xprtrdma/svc_rdma.c | 18 +++++++++---------
 6 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index d740eba3c099..a2eeae73f9fa 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -280,28 +280,28 @@ static const struct parport_sysctl_table parport_sysctl_template = {
 		{
 			.procname	= "base-addr",
 			.data		= NULL,
-			.maxlen		= 0,
+			.maxlen		= 20,
 			.mode		= 0444,
 			.proc_handler	= do_hardware_base_addr
 		},
 		{
 			.procname	= "irq",
 			.data		= NULL,
-			.maxlen		= 0,
+			.maxlen		= 20,
 			.mode		= 0444,
 			.proc_handler	= do_hardware_irq
 		},
 		{
 			.procname	= "dma",
 			.data		= NULL,
-			.maxlen		= 0,
+			.maxlen		= 20,
 			.mode		= 0444,
 			.proc_handler	= do_hardware_dma
 		},
 		{
 			.procname	= "modes",
 			.data		= NULL,
-			.maxlen		= 0,
+			.maxlen		= 40,
 			.mode		= 0444,
 			.proc_handler	= do_hardware_modes
 		},
@@ -310,35 +310,35 @@ static const struct parport_sysctl_table parport_sysctl_template = {
 		{
 			.procname	= "autoprobe",
 			.data		= NULL,
-			.maxlen		= 0,
+			.maxlen		= 256,
 			.mode		= 0444,
 			.proc_handler	= do_autoprobe
 		},
 		{
 			.procname	= "autoprobe0",
 			.data		= NULL,
-			.maxlen		= 0,
+			.maxlen		= 256,
 			.mode		= 0444,
 			.proc_handler	= do_autoprobe
 		},
 		{
 			.procname	= "autoprobe1",
 			.data		= NULL,
-			.maxlen		= 0,
+			.maxlen		= 256,
 			.mode		= 0444,
 			.proc_handler	= do_autoprobe
 		},
 		{
 			.procname	= "autoprobe2",
 			.data		= NULL,
-			.maxlen		= 0,
+			.maxlen		= 256,
 			.mode		= 0444,
 			.proc_handler	= do_autoprobe
 		},
 		{
 			.procname	= "autoprobe3",
 			.data		= NULL,
-			.maxlen		= 0,
+			.maxlen		= 256,
 			.mode		= 0444,
 			.proc_handler	= do_autoprobe
 		},
@@ -349,7 +349,7 @@ static const struct parport_sysctl_table parport_sysctl_template = {
 		{
 			.procname	= "active",
 			.data		= NULL,
-			.maxlen		= 0,
+			.maxlen		= 256,
 			.mode		= 0444,
 			.proc_handler	= do_active_device
 		},
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index d2018f70d1fa..4a54d3cc174b 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -547,7 +547,7 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
 	struct inode *inode = file_inode(iocb->ki_filp);
 	struct ctl_table_header *head = grab_header(inode);
 	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
-	size_t count = iov_iter_count(iter);
+	size_t count = min(table->maxlen, iov_iter_count(iter));
 	char *kbuf;
 	ssize_t error;
 
@@ -567,10 +567,6 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
 	if (!table->proc_handler)
 		goto out;
 
-	/* don't even try if the size is too large */
-	error = -ENOMEM;
-	if (count >= KMALLOC_MAX_SIZE)
-		goto out;
 	kbuf = kzalloc(count + 1, GFP_KERNEL);
 	if (!kbuf)
 		goto out;
@@ -1138,6 +1134,13 @@ static int sysctl_check_table(const char *path, struct ctl_table *table)
 		if ((table->mode & (S_IRUGO|S_IWUGO)) != table->mode)
 			err |= sysctl_err(path, table, "bogus .mode 0%o",
 				table->mode);
+
+		if (table->maxlen >= KMALLOC_MAX_SIZE)
+			err |= sysctl_err(path, table, "maxlen %ld too big",
+				table->maxlen);
+
+		if ((table->mode & S_IRUGO) && !table->maxlen)
+			err |= sysctl_err(path, table, "cannot read maxlen=0");
 	}
 	return err;
 }
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 51298a4f4623..78a1d36767f9 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -112,7 +112,7 @@ static inline void *proc_sys_poll_event(struct ctl_table_poll *poll)
 struct ctl_table {
 	const char *procname;		/* Text ID for /proc/sys, or zero */
 	void *data;
-	int maxlen;
+	size_t maxlen;
 	umode_t mode;
 	struct ctl_table *child;	/* Deprecated */
 	proc_handler *proc_handler;	/* Callback for text formatting */
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index d86d8d11cfe4..c51a2e7e0dfb 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -470,6 +470,7 @@ static struct ctl_table net_core_table[] = {
 #ifdef CONFIG_NET_FLOW_LIMIT
 	{
 		.procname	= "flow_limit_cpu_bitmap",
+		.maxlen         = 128,
 		.mode		= 0644,
 		.proc_handler	= flow_limit_cpu_sysctl
 	},
diff --git a/net/decnet/sysctl_net_decnet.c b/net/decnet/sysctl_net_decnet.c
index 67b5ab2657b7..2ca2ac42c40c 100644
--- a/net/decnet/sysctl_net_decnet.c
+++ b/net/decnet/sysctl_net_decnet.c
@@ -239,14 +239,14 @@ static int dn_def_dev_handler(struct ctl_table *table, int write,
 static struct ctl_table dn_table[] = {
 	{
 		.procname = "node_address",
-		.maxlen = 7,
+		.maxlen = DN_ASCBUF_LEN,
 		.mode = 0644,
 		.proc_handler = dn_node_address_handler,
 	},
 	{
 		.procname = "node_name",
 		.data = node_name,
-		.maxlen = 7,
+		.maxlen = sizeof(node_name),
 		.mode = 0644,
 		.proc_handler = proc_dostring,
 	},
diff --git a/net/sunrpc/xprtrdma/svc_rdma.c b/net/sunrpc/xprtrdma/svc_rdma.c
index 526da5d4710b..f326ba6825f2 100644
--- a/net/sunrpc/xprtrdma/svc_rdma.c
+++ b/net/sunrpc/xprtrdma/svc_rdma.c
@@ -143,63 +143,63 @@ static struct ctl_table svcrdma_parm_table[] = {
 	{
 		.procname	= "rdma_stat_read",
 		.data		= &rdma_stat_read,
-		.maxlen		= sizeof(atomic_t),
+		.maxlen		= 32,
 		.mode		= 0644,
 		.proc_handler	= read_reset_stat,
 	},
 	{
 		.procname	= "rdma_stat_recv",
 		.data		= &rdma_stat_recv,
-		.maxlen		= sizeof(atomic_t),
+		.maxlen		= 32,
 		.mode		= 0644,
 		.proc_handler	= read_reset_stat,
 	},
 	{
 		.procname	= "rdma_stat_write",
 		.data		= &rdma_stat_write,
-		.maxlen		= sizeof(atomic_t),
+		.maxlen		= 32,
 		.mode		= 0644,
 		.proc_handler	= read_reset_stat,
 	},
 	{
 		.procname	= "rdma_stat_sq_starve",
 		.data		= &rdma_stat_sq_starve,
-		.maxlen		= sizeof(atomic_t),
+		.maxlen		= 32,
 		.mode		= 0644,
 		.proc_handler	= read_reset_stat,
 	},
 	{
 		.procname	= "rdma_stat_rq_starve",
 		.data		= &rdma_stat_rq_starve,
-		.maxlen		= sizeof(atomic_t),
+		.maxlen		= 32,
 		.mode		= 0644,
 		.proc_handler	= read_reset_stat,
 	},
 	{
 		.procname	= "rdma_stat_rq_poll",
 		.data		= &rdma_stat_rq_poll,
-		.maxlen		= sizeof(atomic_t),
+		.maxlen		= 32,
 		.mode		= 0644,
 		.proc_handler	= read_reset_stat,
 	},
 	{
 		.procname	= "rdma_stat_rq_prod",
 		.data		= &rdma_stat_rq_prod,
-		.maxlen		= sizeof(atomic_t),
+		.maxlen		= 32,
 		.mode		= 0644,
 		.proc_handler	= read_reset_stat,
 	},
 	{
 		.procname	= "rdma_stat_sq_poll",
 		.data		= &rdma_stat_sq_poll,
-		.maxlen		= sizeof(atomic_t),
+		.maxlen		= 32,
 		.mode		= 0644,
 		.proc_handler	= read_reset_stat,
 	},
 	{
 		.procname	= "rdma_stat_sq_prod",
 		.data		= &rdma_stat_sq_prod,
-		.maxlen		= sizeof(atomic_t),
+		.maxlen		= 32,
 		.mode		= 0644,
 		.proc_handler	= read_reset_stat,
 	},
-- 
2.30.1

