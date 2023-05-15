Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDAB7025DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 09:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240734AbjEOHPW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 03:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240664AbjEOHPI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 03:15:08 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1387D198B
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 00:14:59 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230515071457euoutp01993a6b3be144dd7146e07a884861c2c0~fP8RIG5EC1809018090euoutp01o
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 07:14:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230515071457euoutp01993a6b3be144dd7146e07a884861c2c0~fP8RIG5EC1809018090euoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684134897;
        bh=6PBemcNPoWe9oVs56Q8iJPd1Hh6luHfxm8DwLyJDgGA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ZaWqW07Bg+uWZaSSIbxTQ0QN5bujAfJiTnt4V0usCZu0r6WS4hyhx3WWrkjdMyasn
         DF1TGgi3FGjGNU8u7Im+ZvfEsGa2kNEoMpAua/SgFUQ+xHPhlyjhbARKcEffGc4AoT
         SOspabgzC6zSbJZOgxE/BDA0Ge4Rf5r3livNzod4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230515071457eucas1p19dac7057926ec5ad4f74741f5c43f473~fP8Q-HzD00315403154eucas1p1h;
        Mon, 15 May 2023 07:14:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 40.81.42423.1FBD1646; Mon, 15
        May 2023 08:14:57 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230515071457eucas1p105a2dba9f4741cd6fe495bcf527d664d~fP8QsGIES0813608136eucas1p1W;
        Mon, 15 May 2023 07:14:57 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230515071457eusmtrp20ea15dfc6cc0842d3b98dee3e17325e5~fP8Qrj6kz2610526105eusmtrp2T;
        Mon, 15 May 2023 07:14:57 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-a1-6461dbf112b9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 20.E9.14344.1FBD1646; Mon, 15
        May 2023 08:14:57 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230515071457eusmtip28c38e715b8fe725587302344b7894ca7~fP8QXs6Bf2126721267eusmtip2B;
        Mon, 15 May 2023 07:14:57 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 15 May 2023 08:14:56 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH 6/6] sysctl: stop exporting register_sysctl_table
Date:   Mon, 15 May 2023 09:14:46 +0200
Message-ID: <20230515071446.2277292-7-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230515071446.2277292-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.133]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42LZduznOd2PtxNTDJa0a1ic6c612LP3JIvF
        5V1z2CxuTHjKaHHg9BRmi2U7/RzYPGY3XGTx2DnrLrvHgk2lHptWdbJ5fN4kF8AaxWWTkpqT
        WZZapG+XwJXxrvkje8EGyYrrV08yNTCuFe1i5OSQEDCRuHz7ClMXIxeHkMAKRomGl49YIZwv
        jBKzGzqYQKqEBD4zSuxfJQnTMXvFXmaI+HJGidWTKiEagGrendrEDOFsYZToP7yYHaSKTUBH
        4vybO2AdIgLiEidOb2YEKWIWeMooMfdfL9gKYQFHiXsT+1lAbBYBVYkF03eDNfMK2Epc/76E
        BWK1vETb9emMIDangJ3Euv1HmSBqBCVOznwCVsMMVNO8dTYzhC0hcfDFC2aIXiWJr296WSHs
        WolTW26BPS0h8IBDYuG64+wQCReJq1eWQTUIS7w6vgUqLiPxf+d8qIbJwLD494EdwlnNKLGs
        8SsTRJW1RMuVJ1AdjhKTby0CinMA2XwSN94KQlzEJzFp23RmiDCvREeb0ARGlVlIfpiF5IdZ
        SH5YwMi8ilE8tbQ4Nz212DAvtVyvODG3uDQvXS85P3cTIzDFnP53/NMOxrmvPuodYmTiYDzE
        KMHBrCTC2z4zPkWINyWxsiq1KD++qDQntfgQozQHi5I4r7btyWQhgfTEktTs1NSC1CKYLBMH
        p1QDU4tGdPHVf9feVlw5O4n3yC93f5b2J/fjcuo/Vt9YduVkkkaP6VUbp52Nq93CvklfP3Sp
        uL5+h/sLbsY1x5Yazjs0yTS3Nu+8pOB/bhOHSpG1vee0FnMsaX0jxeXCfV90c8H97/YbJ5jl
        JBR2HlhR8VVxZVfxkXtlfcc+Kn5jbTIy+99XcpAxKLxGu89ChefN6eW23b8v1RZ8mBzRZDt3
        +w39M67X/oSfPWS2a+aq/WkbuF8UH6wvjInvFrH80Kvwo7ZBNPusxjSHhIX9577Obup0L5Fk
        3l1rZrD8zd8U8xvdGytF0v8VGPpstYw5rCThmtzMlnOref5rXpmy5+LOK9a8emjc3yV+9Evs
        Na1vSizFGYmGWsxFxYkASJk/QKADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xe7ofbyemGMzaI2xxpjvXYs/ekywW
        l3fNYbO4MeEpo8WB01OYLZbt9HNg85jdcJHFY+esu+weCzaVemxa1cnm8XmTXABrlJ5NUX5p
        SapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7Gu+aP7AUbJCuu
        Xz3J1MC4VrSLkZNDQsBEYvaKvcxdjFwcQgJLGSXe/N3EApGQkdj45SorhC0s8edaFxtE0UdG
        iSNHt0M5WxgletpuMoFUsQnoSJx/c4cZxBYREJc4cXozI0gRs8BTRomZh56CFQkLOErcm9gP
        toJFQFViwfTd7CA2r4CtxPXvS6BWy0u0XZ/OCGJzCthJrNt/FKxXCKjm9K5trBD1ghInZz4B
        q2cGqm/eOpsZwpaQOPjiBTPEHCWJr296oV6olfj89xnjBEaRWUjaZyFpn4WkfQEj8ypGkdTS
        4tz03GIjveLE3OLSvHS95PzcTYzACNx27OeWHYwrX33UO8TIxMF4iFGCg1lJhLd9ZnyKEG9K
        YmVValF+fFFpTmrxIUZToD8nMkuJJucDU0BeSbyhmYGpoYmZpYGppZmxkjivZ0FHopBAemJJ
        anZqakFqEUwfEwenVANTyVnrb3ufqZ6XTApIYepJ4VvfXF/60otlRbrU+RuuMrEr/7PF2Uve
        +Xk4+ezp0zPstommmjqkfvCtu3ZeRIW54Oy27kU/fhT9qi35se3YpIyj6ud3KQbmHt9fnZ7r
        LPk5Q3WNkuzC3+sSGnlWMUoIcuQsclTNSy+5wOPi8I6tYe/qM21zf9Taa+xmkb/qI2Z36ZfM
        rz9HcgL/Z71sDjDQSa1f8GRT6eKDXpM2sJVyXtz7imWOWn7CRc4fSicPOn9/tVhWe4mD0tzW
        zr8MthaJPxuzzyonxrB2e91ct4rrgKn820a2UN+9WpdPs4UJNF2Y/P6rwbOA1Q1qItppm3bO
        //zLMP3vMv+K3UcreBKUWIozEg21mIuKEwHPFX7DSQMAAA==
X-CMS-MailID: 20230515071457eucas1p105a2dba9f4741cd6fe495bcf527d664d
X-Msg-Generator: CA
X-RootMTR: 20230515071457eucas1p105a2dba9f4741cd6fe495bcf527d664d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230515071457eucas1p105a2dba9f4741cd6fe495bcf527d664d
References: <20230515071446.2277292-1-j.granados@samsung.com>
        <CGME20230515071457eucas1p105a2dba9f4741cd6fe495bcf527d664d@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Joel Granados <j.granados@samsung.com>
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

