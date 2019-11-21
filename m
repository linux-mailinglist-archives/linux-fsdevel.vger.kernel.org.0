Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57C5F105B9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 22:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfKUVJn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 16:09:43 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:36547 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726293AbfKUVJm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 16:09:42 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9A0B71835;
        Thu, 21 Nov 2019 16:09:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 21 Nov 2019 16:09:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=27hbmoeIqxabDlUJntEU4zb9PL
        bVfwu+9iKmFJEM9FA=; b=Sb4Rx4QInA4iamfK6ROAyVi2hOx5lE9DTzJiBQye0o
        FB+07rmWCb1OR5kNUFha8oXty/dgoYsOJ7VH02hXeKTwSaF/+Olp1byAOmmThLs6
        tRENCbxQkWzyDZHlaUpYk+vbNyQ/j/FFhdrOxYFNS8Hk4N+uDoLzCPvABR/foB8C
        ed1zPDWYaFOvIQMbx2Xm8be9IgBDFeF0oTzCIQY/G5GFwE42RdVJ60qgZPYSZ4/h
        Hboy31tUMjPhi2j2zbLdcNjoU8N4TUQOFfmLWjX/fJyqbQyN+UEmfqzslIcKX/uJ
        olyy8D4tjKWo1WEy74zt92ePPjsAmIa/nkXk/hJtmnzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=27hbmoeIqxabDlUJn
        tEU4zb9PLbVfwu+9iKmFJEM9FA=; b=IilgPL0AawnpMBPE3SEa02TXcETb75AxH
        qGok+0p58FKL8CdG5SqvkzH+w/D2GnVncTDhuVCnnbLolcKuOPZN/W0iRorjrmXK
        GOfK54/uAnWjMhMCcb7OdFcVbX6t6kWsUKZlrK9RqNFFHBjVFMcC3Fu2lo/sGBWB
        EXC8EHJsIgh2Vp6cRgqzr34JNT6bTwCuwg5G+nJHVKOvmtKcOvTgWnz85J1ShOrA
        c8WYoxuQwE8FYhA3zb3qpglSj4MbB7Xn58KznWLWE4rreJJpgxSP5redH8oGju11
        bH/EwjMF06QuLGG0J/wTBEE92NUibpru/9ZhoAzBErtqaw1Sj7f6Q==
X-ME-Sender: <xms:E_3WXVctaq-l-8ybDYRjQ2xC_8KK1vrfYWhrF7nesdItbLsZHmudqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudehvddgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecukfhppeduieefrdduudegrddufedtrdduvdeknecurf
    grrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiinecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:E_3WXdcq5V8A95Y0moLHK3M_gTpG-1nHNDXRjOEIQldW0rcXHIBY8g>
    <xmx:E_3WXT8DbUbtTSmrCxc9dZiDQKY2OsYyyqMA2hbIJ3XClRQaGY_24g>
    <xmx:E_3WXVMbCNj07A_CqDSShq-s_mk_PopJi3j3tZtcbat2wqke9kmIXQ>
    <xmx:Ff3WXZIWvhbvRPjKWDqjESlYe_76uqaj6fY-WUl6gPo8bKl_O5mGBQ>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [163.114.130.128])
        by mail.messagingengine.com (Postfix) with ESMTPA id 85F7880060;
        Thu, 21 Nov 2019 16:09:38 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     adobriyan@gmail.com, christian@brauner.io,
        akpm@linux-foundation.org, tglx@linutronix.de, mhocko@suse.com,
        keescook@chromium.org, shakeelb@google.com, casey@schaufler-ca.com,
        khlebnikov@yandex-team.ru, kent.overstreet@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, dschatzberg@fb.com, htejun@fb.com,
        dennis@kernel.org, kernel-team@fb.com
Subject: [PATCH] proc: Make /proc/<pid>/io world readable
Date:   Thu, 21 Nov 2019 13:09:09 -0800
Message-Id: <20191121210909.15086-1-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

/proc/<pid>/io is currently only owner readable. This forces monitoring
programs (such as atop) to run with elevated permissions to collect disk
stats. Changing this file to world readable can add a measure of safety to
userspace.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 fs/proc/base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ebea9501afb8..1d1c1d680e16 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3076,7 +3076,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 	REG("coredump_filter", S_IRUGO|S_IWUSR, proc_coredump_filter_operations),
 #endif
 #ifdef CONFIG_TASK_IO_ACCOUNTING
-	ONE("io",	S_IRUSR, proc_tgid_io_accounting),
+	ONE("io",	S_IRUGO, proc_tgid_io_accounting),
 #endif
 #ifdef CONFIG_USER_NS
 	REG("uid_map",    S_IRUGO|S_IWUSR, proc_uid_map_operations),
@@ -3473,7 +3473,7 @@ static const struct pid_entry tid_base_stuff[] = {
 	REG("fail-nth", 0644, proc_fail_nth_operations),
 #endif
 #ifdef CONFIG_TASK_IO_ACCOUNTING
-	ONE("io",	S_IRUSR, proc_tid_io_accounting),
+	ONE("io",	S_IRUGO, proc_tid_io_accounting),
 #endif
 #ifdef CONFIG_USER_NS
 	REG("uid_map",    S_IRUGO|S_IWUSR, proc_uid_map_operations),
-- 
2.21.0

