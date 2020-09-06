Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603AB25EE9C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Sep 2020 17:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgIFPhZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Sep 2020 11:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbgIFPhT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Sep 2020 11:37:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F0EC061573;
        Sun,  6 Sep 2020 08:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Resent-To:Resent-Message-ID:Resent-Date:
        Resent-From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        In-Reply-To:References; bh=OFf0LPWq+N5jrV9Hhs2llP5KAHSXD0S5GihZT+xebI4=; b=Ia
        sJ6Yi7B98vow3nzVLL4ha0Ta5WV8OKVhUrmpaiee+0osbuZJgqXUhXSmK6tZ1ZiBQDg53CuyRK9z1
        T0Dv2mgMhTgmLDksZpVKyb5iN/asVQDSILwbhZFm97Gy1Cb78DLrvGoH6b21kz9J2FH7DrIGlKS/1
        qBCnlR+aNV83DEgKu51k3yrccVHB0D/Nee8TuF+wbzXpQ+ddClABuzizsJjd7/eBTJ6C4DDQd8+ih
        y69rG+kszOaM52MZC7Smebe5ZCAS9CwZ/FpPoL84HxWSVsHvqZR/wqbeL6yCLX+suvmfoYXK8MAOb
        CEvLjwjnKQjky+gMl6q57Uv6nbMFzzeQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEwj3-0000zA-6k; Sun, 06 Sep 2020 15:37:05 +0000
Received: from mout.gmx.net ([212.227.15.18])
        by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEwVY-00008c-Jk
        for willy@infradead.org; Sun, 06 Sep 2020 15:23:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599405780;
        bh=fba9t+vlFsupMOni3Mo/UQizfPkPJvT3QjxaFpkfifc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=FZbgTomJ+SWeWevRqWlDcnL2J2UxgRF0XOLBsTo4tpX/4uEBk/Jw7ixkkwA3aEdU+
         HF+F+yF1KDobGLuZ53XqZh5C5vf6OIf2JYa8Ora1pyzs5HpixJmvR6Q2oytw6W38OL
         IId6khKAqjHvZwjX0c59O35gRxTEk9ndznPjtJck=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.73.70]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MFKKh-1kLl4X15LN-00Fgmz; Sun, 06 Sep 2020 17:23:00 +0200
From:   John Wood <john.wood@gmx.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     John Wood <john.wood@gmx.com>
Subject: [RFC PATCH 3/9] security/fbfam: Use the api to manage statistics
Date:   Sun,  6 Sep 2020 17:22:47 +0200
Message-Id: <20200906152247.7149-1-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bHGDCe2f9IdRjz+Z2EcseIpWCNmVqy7VoDUkIQMHvARMpch9oPy
 sLIdXtp8nldEo+0Qp5YGrA8qrWU5UNaNCeqf0kUWJYOv70CWhUMwFy//Ml12DoS7fCRRCoG
 SllBrrbQlvmjviNPkBl8WB1hDra9FPOK5FaJKu10ZkYeAeN+Kyp9EurwjscifPATUGEY86H
 2k2+zPpeef+SRCBJ4yIYQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SM2qnhGHBgQ=:R9di0UH+SKUFpdPnM1Sw/c
 5ZnoIaM5b6FGMhJ90RN+v6ZPt7f+9LwBj1/e2bPGM1/5+crFZPb79fBoI4zH0WYdg77E2afbA
 BqtNmMgF5PiMroCbOFWVMvS57sV55b4AP1iS7lhE7EhbysoY8Su6CeVTFrP5fRxZTSb5JANrk
 EQkrHAxS7B+7ZqpcMskw/NtpFtnTcvM+3U+7Co1sNjZlqKtamTqAaXPYTQOZ4PabsUSM1kjPA
 GPUNYU0CT7LGSzDbrxLcO8aPlouzKTpdB1hKIpUYLVP3E6KE6sPIUlh0NJ5lMgB0L3WI7OGVF
 14QgXQsypOPttv7QjprqQqgD3ptb0o53rskAbYfSHUtp60+qIPcKUSdREtS/UXg8wATqU82z6
 9yGOuM6WOFZ3HV3u5MINlGLbtAFPqiPS0ya1EG02VCfA8lGtiXWybNT7qCi5viz/7RcM2x8Hf
 L5X/71kkZuYgy6bmXckyTW0PxabG6zckus+UBdmGu+kLHpa+xNUK1nCxZP7dceL+Ay+of4Ymf
 jYc/WkNht3uEpci+Zvib7wDykp+n0RADTg/hmia+LRHgpObJCKPbs7ZwULgjoF7sCF5P0Sw8x
 x0FQQ6Gp0oNMJGsrZIYWsYZCNj4a6b/exILpr8tlq+Yh4y4xtO0tUJ2o0KCyWAQQfCAnungyd
 lSboN1rEPhKeB2E+JRlsMIKvdFka00lFXlMFHd7PPRwxMjrtOkJbqMbM07doqVveeIBQXeOiD
 KzoDokXLINb7FEiI1fe3BScLofnPaf/e0QjKHbmgUEytkuVp5tuXHw8UXcdqbVxufsG/TxvJ5
 RcZOxJDYWxuDOROTnBN3KA/Io0ADMR8R/xJZA0ySdAuf9aeZ/ctYoUPcpHFu1JVBDPAyXW9Fp
 J9aFKkibdquA2E+p7Dvcmyp9OW95g3ET/FSPyAyfSZNoyfTr5M4ZFLyJvQHIgqHyKZRKSoIwe
 TgFM1VSOV4+Ld0Lzf730+GyyeDs7HYkn33753nXvaz/j5sT8vmkE++ApqHHw6+lfTyMUon2Rw
 I96Ws9qO7ppRrzRoC5qNunV6rUYTj7+sOVQsT0y0wMsikuo/+yiBb+QquRdGHX+1rmNRPNhZ7
 jBNOKufgcF+N4NXxZ41SZEYAtuBTvZGGNhvAp60FD+TTeI2joOyIO8o6tFBkOoDowdVs7RCwq
 24pWJZL64iJiShvujzlVQjaDzEq90bNkgXNbg3tmH+IaIzMgWYRabf76TxBY/Ojv/1mZeKj0X
 AKm/ha5fI19ggGdpayfABMknuQKAnjUghOFbxsg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200906_162308_907096_153AC323 
X-CRM114-Status: UNSURE (   9.81  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.6 (--)
X-Spam-Report: SpamAssassin version 3.4.4 on casper.infradead.org summary:
 Content analysis details:   (-2.6 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.7 RCVD_IN_DNSWL_LOW      RBL: Sender listed at https://www.dnswl.org/,
                             low trust
                             [212.227.15.18 listed in list.dnswl.org]
 -0.0 RCVD_IN_MSPIKE_H2      RBL: Average reputation (+2)
                             [212.227.15.18 listed in wl.mailspike.net]
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
  0.0 FREEMAIL_FROM          Sender email is commonly abused enduser mail
                             provider
                             [john.wood[at]gmx.com]
 -0.0 SPF_PASS               SPF: sender matches SPF record
  0.0 SPF_HELO_NONE          SPF: HELO does not publish an SPF Record
  0.1 DKIM_SIGNED            Message has a DKIM or DK signature, not necessarily
                             valid
 -0.1 DKIM_VALID             Message has at least one valid DKIM or DK signature
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the previous defined api to manage statistics calling it accordingly
when a task forks, calls execve or exits.

Signed-off-by: John Wood <john.wood@gmx.com>
=2D--
 fs/exec.c     | 2 ++
 kernel/exit.c | 2 ++
 kernel/fork.c | 4 ++++
 3 files changed, 8 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index a91003e28eaa..b30118674d32 100644
=2D-- a/fs/exec.c
+++ b/fs/exec.c
@@ -71,6 +71,7 @@
 #include "internal.h"

 #include <trace/events/sched.h>
+#include <fbfam/fbfam.h>

 static int bprm_creds_from_file(struct linux_binprm *bprm);

@@ -1940,6 +1941,7 @@ static int bprm_execve(struct linux_binprm *bprm,
 	task_numa_free(current, false);
 	if (displaced)
 		put_files_struct(displaced);
+	fbfam_execve();
 	return retval;

 out:
diff --git a/kernel/exit.c b/kernel/exit.c
index 733e80f334e7..39a6139dcf31 100644
=2D-- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -67,6 +67,7 @@
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
 #include <asm/mmu_context.h>
+#include <fbfam/fbfam.h>

 static void __unhash_process(struct task_struct *p, bool group_dead)
 {
@@ -852,6 +853,7 @@ void __noreturn do_exit(long code)
 		__this_cpu_add(dirty_throttle_leaks, tsk->nr_dirtied);
 	exit_rcu();
 	exit_tasks_rcu_finish();
+	fbfam_exit();

 	lockdep_free_task(tsk);
 	do_task_dead();
diff --git a/kernel/fork.c b/kernel/fork.c
index 4d32190861bd..088aa5b62634 100644
=2D-- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -107,6 +107,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/task.h>

+#include <fbfam/fbfam.h>
+
 /*
  * Minimum number of threads to boot the kernel
  */
@@ -941,6 +943,8 @@ static struct task_struct *dup_task_struct(struct task=
_struct *orig, int node)
 #ifdef CONFIG_MEMCG
 	tsk->active_memcg =3D NULL;
 #endif
+
+	fbfam_fork(tsk);
 	return tsk;

 free_stack:
=2D-
2.25.1

