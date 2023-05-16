Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B41E7053DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 18:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjEPQav (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 12:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjEPQ3v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 12:29:51 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95DE83D0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 09:29:38 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230516162926euoutp01257b1153a1d10acf34b2ae639d224885~frJrep_NS2686026860euoutp01h
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 16:29:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230516162926euoutp01257b1153a1d10acf34b2ae639d224885~frJrep_NS2686026860euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684254566;
        bh=+cvSrG9BF2Lh8leXK/b8umU3dWU2v/m9nMhuIbw7feg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=XXd9PzLcwrhShGi9m5rO+q8JcMiGCAlxz8aJFQH16/9wnVyZaUc/T2UXiLcxLSuQg
         duSpYSUnXh6eNecoUT4tp1NzWyYXrv3z0yTyWats9eddtFrBqBWpfbhU7rvBWxXhr4
         KZcUNPlTVdn8engGqmDMw4RxT+wEAEkS+73h7usE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230516162926eucas1p22bc2c754369a5817e3557e22647af663~frJrRxcWz2141021410eucas1p2n;
        Tue, 16 May 2023 16:29:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id BF.C3.42423.66FA3646; Tue, 16
        May 2023 17:29:26 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230516162926eucas1p27084bb4e8f7910f479133d1f88105aa8~frJq_EMY41612516125eucas1p2z;
        Tue, 16 May 2023 16:29:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230516162926eusmtrp11d601a2a4bb1515b0f8779bf8015faf4~frJq9lxki2056220562eusmtrp1I;
        Tue, 16 May 2023 16:29:26 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-c2-6463af662a84
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 23.57.10549.66FA3646; Tue, 16
        May 2023 17:29:26 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230516162926eusmtip1237878a60e3fff8168b3ec785c9ce841~frJq07vOU0643706437eusmtip1W;
        Tue, 16 May 2023 16:29:26 +0000 (GMT)
Received: from localhost (106.210.248.56) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 16 May 2023 17:29:25 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     Kees Cook <keescook@chromium.org>, <linux-fsdevel@vger.kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH v3 6/6] sysctl: stop exporting register_sysctl_table
Date:   Tue, 16 May 2023 18:29:03 +0200
Message-ID: <20230516162903.3208880-7-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230516162903.3208880-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.56]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42LZduznOd209ckpBjd2KFmc6c612LP3JIvF
        5V1z2CxuTHjKaHHg9BRmi2U7/RzYPGY3XGTx2DnrLrvHgk2lHptWdbJ5fN4kF8AaxWWTkpqT
        WZZapG+XwJXxb4Z8wT/5igf/T7I0MG6W7GLk5JAQMJG4+aGNsYuRi0NIYAWjxOqnO9kgnC+M
        Evu/bGaBcD4zSly7sI8FpuVE/0FWiMRyRol7t08gVB08PA0qs4VRYtvZjcwgLWwCOhLn39wB
        s0UExCVOnN4MtpFZ4ClQ+97VbCAJYQEXic6O/UAJDg4WAVWJE1c5QMK8ArYS95++ZIdYLS/R
        dn06I4jNKWAn8X7NJiaIGkGJkzOfgJ3HDFTTvHU2M4QtIXHwxQtmiF4lifaJD1gh7FqJU1tu
        MYHcICFwh0Ni+/d5bBAJF4lP2+ZD2cISr45vgVosI3F6cg8LRMNkYMj8+8AO4axmlFjW+JUJ
        ospaouXKE6gOR4mle36DfSMhwCdx460gxEV8EpO2TWeGCPNKdLQJTWBUmYXkh1lIfpiF5IcF
        jMyrGMVTS4tz01OLDfNSy/WKE3OLS/PS9ZLzczcxAlPM6X/HP+1gnPvqo94hRiYOxkOMEhzM
        SiK8gX3JKUK8KYmVValF+fFFpTmpxYcYpTlYlMR5tW1PJgsJpCeWpGanphakFsFkmTg4pRqY
        uG+0PW+u+CI/0+HGtKd92mKlZeY9Wz1kGw7t/BBXwLxztdqK3cv5nprvUk+Pu/dWe+WWtjaD
        TIsdaxf8Fm1m+X/uytTdC5rPz7ixW1l0fnRW6TXr7wdS/VSEp/K/1pQM+PzoebtwYWIxW3Fy
        WlZT8rO3nq+y7+T3zpx5YH2eXtGmttxJr9i73044YPCq93pV2KX7ectN7juv0Txt/GvtBoEm
        zbN8C/0u3d/D5BnrIGBxlCv7zqRbz4uXrvz1UrqDz87mLvuCI7cTPl436PNndq5Tuxzx/5Pm
        chH+q7EfNfVi2otKH95J9S0u0VtYVafn9lL9Tom+/jHLz+phZ9JbfXbdSYyP1124l9FMJXiC
        EktxRqKhFnNRcSIAyYMHT6ADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xu7pp65NTDHq/8Fqc6c612LP3JIvF
        5V1z2CxuTHjKaHHg9BRmi2U7/RzYPGY3XGTx2DnrLrvHgk2lHptWdbJ5fN4kF8AapWdTlF9a
        kqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfxb4Z8wT/5igf/
        T7I0MG6W7GLk5JAQMJE40X+QtYuRi0NIYCmjxM9zn9ggEjISG79cZYWwhSX+XOtigyj6yCix
        dM0lKGcLo8SUk4cZQarYBHQkzr+5wwxiiwiIS5w4vRkszizwmFFizkFZEFtYwEWis2M/UJyD
        g0VAVeLEVQ6QMK+ArcT9py/ZIZbJS7Rdnw7WyilgJ/F+zSYmEFsIqGbi8h4WiHpBiZMzn7BA
        jJeXaN46mxnClpA4+OIFM8QcJYn2iQ+gHqiV+Pz3GeMERpFZSNpnIWmfhaR9ASPzKkaR1NLi
        3PTcYkO94sTc4tK8dL3k/NxNjMDY23bs5+YdjPNefdQ7xMjEwXiIUYKDWUmEN7AvOUWINyWx
        siq1KD++qDQntfgQoynQmxOZpUST84HRn1cSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKa
        nZpakFoE08fEwSnVwGS/clnh3fIVLxcKP1z379Ezn8cf41qerfVgNXY4kt/KtXTOJOlLjUy3
        611yK9t0K/bZz2NdkByiElC14qsLI0eAfFcjw6He388XVi4N4y94Jy63yG0N0/sw6zlyuiVN
        qx/O8bmv175mi/CVa+ELynM32ZXvYdYyWXnky4fDcuYh6RtqOHcl9v/l4XscX9m+c6rzjo4D
        B0WjFOKz/Ow+H9E7qPJl5dyDYif37XOeo2bbtCrBf2binuXnt7r3nWQ8dY8j82KzzVsnCRHx
        hzEHZnOdjAmYnqt6gYm5hpnH/9kydrNafuWP8UxiP9tfljY6Gj8+fHOF1AIp7psH16u5rIvW
        LxWSO99VkZ7+o0UyS4mlOCPRUIu5qDgRALb+MPlGAwAA
X-CMS-MailID: 20230516162926eucas1p27084bb4e8f7910f479133d1f88105aa8
X-Msg-Generator: CA
X-RootMTR: 20230516162926eucas1p27084bb4e8f7910f479133d1f88105aa8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230516162926eucas1p27084bb4e8f7910f479133d1f88105aa8
References: <20230516162903.3208880-1-j.granados@samsung.com>
        <CGME20230516162926eucas1p27084bb4e8f7910f479133d1f88105aa8@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We make register_sysctl_table static because the only function calling
it is in fs/proc/proc_sysctl.c (__register_sysctl_base). We remove it
from the sysctl.h header and modify the documentation in both the header
and proc_sysctl.c files to mention "register_sysctl" instead of
"register_sysctl_table".

This plus the commits that remove register_sysctl_table from parport
save 217 bytes:

./scripts/bloat-o-meter .bsysctl/vmlinux.old .bsysctl/vmlinux.new
add/remove: 0/1 grow/shrink: 5/1 up/down: 458/-675 (-217)
Function                                     old     new   delta
__register_sysctl_base                         8     286    +278
parport_proc_register                        268     379    +111
parport_device_proc_register                 195     247     +52
kzalloc.constprop                            598     608     +10
parport_default_proc_register                 62      69      +7
register_sysctl_table                        291       -    -291
parport_sysctl_template                     1288     904    -384
Total: Before=8603076, After=8602859, chg -0.00%

Signed-off-by: Joel Granados <j.granados@samsung.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/proc/proc_sysctl.c  | 5 ++---
 include/linux/sysctl.h | 8 +-------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 8038833ff5b0..f8f19e000d76 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1582,7 +1582,7 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
  * array. A completely 0 filled entry terminates the table.
  * We are slowly deprecating this call so avoid its use.
  */
-struct ctl_table_header *register_sysctl_table(struct ctl_table *table)
+static struct ctl_table_header *register_sysctl_table(struct ctl_table *table)
 {
 	struct ctl_table *ctl_table_arg = table;
 	int nr_subheaders = count_subheaders(table);
@@ -1634,7 +1634,6 @@ struct ctl_table_header *register_sysctl_table(struct ctl_table *table)
 	header = NULL;
 	goto out;
 }
-EXPORT_SYMBOL(register_sysctl_table);
 
 int __register_sysctl_base(struct ctl_table *base_table)
 {
@@ -1700,7 +1699,7 @@ static void drop_sysctl_table(struct ctl_table_header *header)
 
 /**
  * unregister_sysctl_table - unregister a sysctl table hierarchy
- * @header: the header returned from register_sysctl_table
+ * @header: the header returned from register_sysctl or __register_sysctl_table
  *
  * Unregisters the sysctl table and all children. proc entries may not
  * actually be removed until they are no longer used by anyone.
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 3d08277959af..218e56a26fb0 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -89,7 +89,7 @@ int proc_do_static_key(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 
 /*
- * Register a set of sysctl names by calling register_sysctl_table
+ * Register a set of sysctl names by calling register_sysctl
  * with an initialised array of struct ctl_table's.  An entry with 
  * NULL procname terminates the table.  table->de will be
  * set up by the registration and need not be initialised in advance.
@@ -222,7 +222,6 @@ struct ctl_table_header *__register_sysctl_table(
 	struct ctl_table_set *set,
 	const char *path, struct ctl_table *table);
 struct ctl_table_header *register_sysctl(const char *path, struct ctl_table *table);
-struct ctl_table_header *register_sysctl_table(struct ctl_table * table);
 void unregister_sysctl_table(struct ctl_table_header * table);
 
 extern int sysctl_init_bases(void);
@@ -257,11 +256,6 @@ static inline int __register_sysctl_base(struct ctl_table *base_table)
 
 #define register_sysctl_base(table) __register_sysctl_base(table)
 
-static inline struct ctl_table_header *register_sysctl_table(struct ctl_table * table)
-{
-	return NULL;
-}
-
 static inline void register_sysctl_init(const char *path, struct ctl_table *table)
 {
 }
-- 
2.30.2

