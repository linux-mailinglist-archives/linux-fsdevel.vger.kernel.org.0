Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509E673DEA5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 14:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjFZMPI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 08:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjFZMOD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:14:03 -0400
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07868E75;
        Mon, 26 Jun 2023 05:13:55 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-c8-64997d6b8990
From:   Byungchul Park <byungchul@sk.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel_team@skhynix.com, torvalds@linux-foundation.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, will@kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
        sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jlayton@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        boqun.feng@gmail.com, longman@redhat.com, hdanton@sina.com,
        her0gyugyu@gmail.com
Subject: [PATCH v10 04/25] dept: Add lock dependency tracker APIs
Date:   Mon, 26 Jun 2023 20:56:39 +0900
Message-Id: <20230626115700.13873-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230626115700.13873-1-byungchul@sk.com>
References: <20230626115700.13873-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0xTZxjHfc/lPaeV6knH5IhGXRMz1MDQeHkSL9Ho4vtFY+JijM5oZ89G
        BYppFcFoUqGaWsABykVLTC1aCcVbYRsCdRUEQSaXSSpKS4R4oUolQYsieCkYvzz5Jf//88vz
        4eFp5b9sNK/VHZD0OnWSCssZeTDCHpt49Kwm3uKPg7zseAi9NTNQcq0CQ8dVJ4KKqmMUBBo3
        wsORQQRj99tpKCroQHChz09DVVMvAndZBoYHT6dBV2gIQ0tBFobM0msYOl+NU+ArzKfA6doE
        rbl2CjyjLxgoCmCwFmVS4TFAwaijnAOHcT70l53jYLxvMbT0ellwP14EZ8/7MNS5Wxhoqu6n
        4EFNCYbeis8stDY1M9CRl8PCldd2DK9GHDQ4QkMc/O+xUXDdFBa9HHdTcOLNJxbu5njCdPEG
        BV2PahHcMj+hwFXhxdAQGqSg0lVAw4fLjQj6TwU5OJ49yoH12CkEWccLGWj/eJcFk28ZjL0v
        wWtXkobBIZqYKg8R94iNIffsIrl5zs8R063HHLG5DpLKsoWktC5AkQvDIZa4yk9i4hrO54gl
        2EURn7cOk9dtbRxpLh5jtszeIV+lkZK0qZL+pzV75Amm8HX7B6LSLnmMyIicSguS8aKwVOzJ
        O818Y7P/PD3BWPhR7O4eneRIYZ5YmfOctSA5TwulU8UXzXe4ieA7YZ3Y422YZEaYL973/hUW
        8bxCWCZmB1Z/dc4Vndc9kx6ZsFys/c+OJlgZrmT46vGEUxSyZKJjoJb+ujBTvF3WzeQihQ1N
        KUdKrS41Wa1NWhqXkK7TpsXtTUl2ofBbOY6O76xGwx1b65HAI1WEIn5OsUbJqlMN6cn1SORp
        VaRixvsijVKhUacflvQpu/UHkyRDPZrFM6ooxZKRQxql8If6gJQoSfsl/beU4mXRRoQiY/p3
        vkx2/Ba1qw3P/TWmyhK7O5jovLnNaqpZsS96w7yM3yOarI0xueZsa/GUjYObV3Rfrf1THd1q
        MKdd2nDGNuPi9sOLin9YV3O7Mz3zSFDWXt284J/pP1tzdVH5M6fJxfWFz4wkEPxlpT+2J9LK
        3ev8nHBjQd9ex9/fp7z7dKZliYoxJKgXL6T1BvUX5oVgh1IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+5/L/xxXs8NmerCLMZJAyexivVJZ0YdOQRL0IehDdWiHHN5i
        K3OVNHWFmUZKc1ZmOmuJrrJpYOlieF9aWpN1m1IS1cqSLluZdplGXx5+8Lz8eD88LKmopiNZ
        TcZBSZshpqmwjJIlr8lfkppzXh1vsSmhpCge/N8KKKi4acMwcKMega0plwBf52Z4EhhFMPGg
        nwSzaQBB9ashEpq6hhE4avMwuF+HwqB/DIPLdBpDfs1NDI8+TBLgLSsloN6+DXrPWghwjr+l
        wOzDcNGcTwTjHQHj1joGrIZoGKm9wMDkq2XgGvbQ0H7JRYPjeSycr/RiaHW4KOhqHiHAfbcC
        w7DtDw29XT0UDJQU03D9kwXDh4CVBKt/jIHHzioCGoxB2/tJBwEnv/6mobvYGaQrtwgYfNaC
        4F7BSwLsNg+Gdv8oAY12Ewk/r3UiGDnzkYETReMMXMw9g+D0iTIK+n9102D0JsDEjwq8Ya3Q
        PjpGCsbGw4IjUEUJ9y28cOfCECMY7z1nhCr7IaGxNkaoafURQvUXPy3Y605hwf6llBEKPw4S
        gtfTioVPDx8yQk/5BLV9/i7ZWrWUpsmStEuT9spSjMHvDryLyL7qNCADqlcUohCW51byBUOV
        5BRjbjH/9On4NIdxC/nG4jd0IZKxJFczk3/b08FMFUpuI//C0z7NFBfNP/DcpgoRy8q5BL7I
        t+6fM4qvb3BOe0K4VXxLnwVNsSJ4kudtw2eRrArNqENhmoysdFGTlhCnS03RZ2iy4/ZlpttR
        cDjWnMmSZvTNvbkNcSxSzZLHLyhXK2gxS6dPb0M8S6rC5OE/zGqFXC3qj0jazD3aQ2mSrg3N
        ZSlVhHzrTmmvgtsvHpRSJemApP3fEmxIpAFVz98t9eXnWsUdSeETWXm2RGPH0dW3O22Lw719
        s/p9XatD7yqPR/UpyYJHYTGfx+40+5dnig5F2ewVI5c3HTM3aCO2JSVWph81FUV9b1L2l5qu
        17gPm0K66UDn7Dnu0NSc0eRywznqdbZjy/rE6N7SQOR+vMj3xrWxR/9yXuxlvYrSpYjLYkit
        TvwLwSrfujQDAAA=
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Wrapped the base APIs for easier annotation on typical lock.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept_ldt.h | 77 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 include/linux/dept_ldt.h

diff --git a/include/linux/dept_ldt.h b/include/linux/dept_ldt.h
new file mode 100644
index 000000000000..062613e89fc3
--- /dev/null
+++ b/include/linux/dept_ldt.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Lock Dependency Tracker
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
+ */
+
+#ifndef __LINUX_DEPT_LDT_H
+#define __LINUX_DEPT_LDT_H
+
+#include <linux/dept.h>
+
+#ifdef CONFIG_DEPT
+#define LDT_EVT_L			1UL
+#define LDT_EVT_R			2UL
+#define LDT_EVT_W			1UL
+#define LDT_EVT_RW			(LDT_EVT_R | LDT_EVT_W)
+#define LDT_EVT_ALL			(LDT_EVT_L | LDT_EVT_RW)
+
+#define ldt_init(m, k, su, n)		dept_map_init(m, k, su, n)
+#define ldt_lock(m, sl, t, n, i)					\
+	do {								\
+		if (n)							\
+			dept_ecxt_enter_nokeep(m);			\
+		else if (t)						\
+			dept_ecxt_enter(m, LDT_EVT_L, i, "trylock", "unlock", sl);\
+		else {							\
+			dept_wait(m, LDT_EVT_L, i, "lock", sl);		\
+			dept_ecxt_enter(m, LDT_EVT_L, i, "lock", "unlock", sl);\
+		}							\
+	} while (0)
+
+#define ldt_rlock(m, sl, t, n, i, q)					\
+	do {								\
+		if (n)							\
+			dept_ecxt_enter_nokeep(m);			\
+		else if (t)						\
+			dept_ecxt_enter(m, LDT_EVT_R, i, "read_trylock", "read_unlock", sl);\
+		else {							\
+			dept_wait(m, q ? LDT_EVT_RW : LDT_EVT_W, i, "read_lock", sl);\
+			dept_ecxt_enter(m, LDT_EVT_R, i, "read_lock", "read_unlock", sl);\
+		}							\
+	} while (0)
+
+#define ldt_wlock(m, sl, t, n, i)					\
+	do {								\
+		if (n)							\
+			dept_ecxt_enter_nokeep(m);			\
+		else if (t)						\
+			dept_ecxt_enter(m, LDT_EVT_W, i, "write_trylock", "write_unlock", sl);\
+		else {							\
+			dept_wait(m, LDT_EVT_RW, i, "write_lock", sl);	\
+			dept_ecxt_enter(m, LDT_EVT_W, i, "write_lock", "write_unlock", sl);\
+		}							\
+	} while (0)
+
+#define ldt_unlock(m, i)		dept_ecxt_exit(m, LDT_EVT_ALL, i)
+
+#define ldt_downgrade(m, i)						\
+	do {								\
+		if (dept_ecxt_holding(m, LDT_EVT_W))			\
+			dept_map_ecxt_modify(m, LDT_EVT_W, NULL, LDT_EVT_R, i, "downgrade", "read_unlock", -1);\
+	} while (0)
+
+#define ldt_set_class(m, n, k, sl, i)	dept_map_ecxt_modify(m, LDT_EVT_ALL, k, 0UL, i, "lock_set_class", "(any)unlock", sl)
+#else /* !CONFIG_DEPT */
+#define ldt_init(m, k, su, n)		do { (void)(k); } while (0)
+#define ldt_lock(m, sl, t, n, i)	do { } while (0)
+#define ldt_rlock(m, sl, t, n, i, q)	do { } while (0)
+#define ldt_wlock(m, sl, t, n, i)	do { } while (0)
+#define ldt_unlock(m, i)		do { } while (0)
+#define ldt_downgrade(m, i)		do { } while (0)
+#define ldt_set_class(m, n, k, sl, i)	do { } while (0)
+#endif
+#endif /* __LINUX_DEPT_LDT_H */
-- 
2.17.1

