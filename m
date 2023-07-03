Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC937458D5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 11:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjGCJtt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 05:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjGCJtq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:49:46 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E1E9BE;
        Mon,  3 Jul 2023 02:49:40 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-16-64a299b26989
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
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        boqun.feng@gmail.com, longman@redhat.com, hdanton@sina.com,
        her0gyugyu@gmail.com
Subject: [PATCH v10 rebased on v6.4 04/25] dept: Add lock dependency tracker APIs
Date:   Mon,  3 Jul 2023 18:47:31 +0900
Message-Id: <20230703094752.79269-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230703094752.79269-1-byungchul@sk.com>
References: <20230703094752.79269-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0xTZxjG933n2krNsQM502SaxlswU9jQvC7TkJi5E2cTdYlGiXHVcwKN
        UEihINvIKlTFC0xNALlEobraAAqcYsYmdRUmiAToRqNgapWLG8RyCa4VBN0KxH/e/PI8T568
        fzwsoW6klrF6Q7pkNOiSNLSSVI6GWT+RS6xitKV2FVw8Hw2Bf/NIKK+tocF9qxpBTcMJDCP3
        v4LHQT+Cmc5uAooL3Qgq+58S0NDqQ+C059DQM7QYPIFxGtoLz9GQe62Whj9fzmLwFl3CUC1r
        oeOCFYNr+h8SikdoKCvOxaEzjGHaVsWAzbwaBuylDMz2x0C77xEFzifroeSKl4YmZzsJrY0D
        GHp+K6fBV/MfBR2tD0hwX8yn4OaYlYaXQRsBtsA4A3+5KjDUWUJFp169o6At34Xh1PV6DJ6+
        Owju5j3HINc8oqEl4MfgkAsJeHPjPoKBglEGTp6fZqDsRAGCcyeLSOh+20aBxbsJZqbK6bjP
        hRb/OCFYHJmCM1hBCg+tvPBr6VNGsNx9wggVsklw2KOEa00jWKicDFCCXHWGFuTJS4xwdtSD
        hbGuLkZ4cHmGFIY8xXj38oPKL0QpSZ8hGTdu+1aZaAl9lzocefxnlxmZUbX6LFKwPBfL//TW
        R7znZ01F1BzT3Fq+t3d6Xg/nVvKO/L9DupIluNOLePtEJz1nfMjt4fN+nwuxLMmt5m3meVRx
        m3jZfGChcgVfXeear1Fwm/kXUwVojtWhiLfERy9kchV8wZtVC/wRf8/eS15Aqgr0QRVS6w0Z
        yTp9UuyGxCyD/viGoynJMgrtyZY9G9+IJt3fNCOORZowVe/3laKa0mWkZSU3I54lNOGq3P6r
        olol6rK+k4wph42mJCmtGS1nSU2k6tNgpqjmEnTp0jFJSpWM713MKpaZ0a4flzZ5Ww51ur/m
        I7SvV7b9MRvRc2Qo1bEtezBhvym5fnAsbnH4lntT2eSZy9E31/wQPNgX9MTvrduuZZfsnJBH
        sOn6fltsX9zwwBbtuqgjNtOOEnGreGVXype/1KbHrJ/Y2hD5WY7ztH93pD+svW9H+DEkLtln
        uK3d/nFOW5kiIV9DpiXqYqIIY5ruf0PRll1LAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTH+93H715Xi9sSvFRQLCywMgcaByyLgroEvSiKpKjlLjmbFlua
        9oDVlunSkcKcr8pHraFmdTWycjWUzBWa5nImZik9lCx7TTLtsRX9c/hwvl8+nD8OSypK6Fms
        NuWwqE9R65RYRsk2xpqWSEUVmqjM1mmQlxMF/m9ZFJReq8HQUVuNoKb+JAHDD9aBb2wEwUTb
        ExLstg4E5QMvSKhv6Ufgcp7C0PV6Onj9oxg8trMYTJXXMHS+nySgryCfgGppAzw+V0GAe/wd
        BfZhDCV2ExEYQwSMO6oYcBjDYdBZzMDkgAo8/d00NJ/30ODqXQRFF/owNLo8FLQ0DBLQdacU
        Q3/Nbxoet7RS0JGXS8PVjxUY3o85SHD4Rxl46i4j4Lo5YMv8+ouGh7luAjIv3SDA+/wugntZ
        rwiQaroxNPtHCKiTbCT8uPIAwaD1AwOnc8YZKDlpRXD2dAEFT34+pMHcFwMT30vxqliheWSU
        FMx1RwTXWBklPKrghdvFLxjBfK+XEcqkVKHOGSFUNg4TQvkXPy1IVdlYkL7kM4Llg5cQPra3
        M0Jr4QQlvPbaic1z4mXLNaJOmybql8btlSWaA9cdGgpLv+w2IiOqVlhQCMtz0fzLxgI6yJhb
        yPf0jJNBDuXm8XW5bwN7GUtyZ6byzk9tOBjM5LbwWfeDJZaluHDeYfyLci6Gl4w7/ynn8tXX
        3X81Idwy/s13KwqyIlDpK+rH55CsDE2pQqHalLRktVYXE2k4kJiRok2PTDiYLKHAyzhOTOY1
        oG9d65oQxyLlNHnPsXKNglanGTKSmxDPkspQuWngokYh16gzjor6g3v0qTrR0IRms5QyTL5+
        h7hXwe1XHxYPiOIhUf8/JdiQWUa01RW1ulS1afriwvqG2043O0f27Piz2p/ZldHeW/mOnCvS
        Mut8q27S2Jl+bP7Xys9Y77HdNaqidtGLfNsTTL7VhTtGh1QXLb64BFuBJWnrhuTupKTd7e1h
        kWERSeH7btp7J351rqmKt0xdMTaDu+/L7lmbsK8ornhlbXyDJnPbgi1KypCoVkWQeoP6D0Di
        ZREuAwAA
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

