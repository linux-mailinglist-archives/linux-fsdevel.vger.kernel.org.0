Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E520738148
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 13:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjFUJsa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 05:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjFUJs2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:48:28 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C54CA
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 02:48:27 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230621094825euoutp029e94dc9fd7157e9f525bf02c75101bed~qo50mTTsO1913319133euoutp02r
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 09:48:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230621094825euoutp029e94dc9fd7157e9f525bf02c75101bed~qo50mTTsO1913319133euoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687340905;
        bh=oMMsCBVAUEOP5xD/Z+INlpRHDKkS9VhizNcPTCBp948=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Vetou21bFg5GhYx6PfjQwLVmbOJvNqxiglRJajEOyDJl328PDRlTZgMU10ScV/Ve9
         R7toOsNaiRniJlf+C6JndiyvQbaNgOhyjrVngFt5Yd8CHnbn6iQcw/0WoQeyFC9AZ8
         4cTFXm2TwXChIXpPGJAvnyY8O1PNaf9P509R7LUc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230621094825eucas1p14a29d1829162515c73fa3108d1609c9c~qo50gGD1M1194511945eucas1p1C;
        Wed, 21 Jun 2023 09:48:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A2.47.11320.967C2946; Wed, 21
        Jun 2023 10:48:25 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230621094825eucas1p2d37372e5bd2377bfe953e6e4f7ff0363~qo50D7ZHB2114621146eucas1p2v;
        Wed, 21 Jun 2023 09:48:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230621094825eusmtrp1e66aac9eac34c360ca66a25014801dd3~qo50DdT361292612926eusmtrp1D;
        Wed, 21 Jun 2023 09:48:25 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-4b-6492c7690a9d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D7.06.10549.867C2946; Wed, 21
        Jun 2023 10:48:25 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230621094824eusmtip151933cc23390220a581d0f3fc016689d~qo5z2JBAA1131511315eusmtip18;
        Wed, 21 Jun 2023 09:48:24 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 21 Jun 2023 10:48:24 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
CC:     Joel Granados <j.granados@samsung.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH 10/11] sysctl: Remove nr_entries from new_links
Date:   Wed, 21 Jun 2023 11:48:01 +0200
Message-ID: <20230621094817.433842-2-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230621094817.433842-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.248]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42LZduznOd3M45NSDBY0KVuc6c612LP3JIvF
        5V1z2CxuTHjKaLFsp58Dq8fshossHgs2lXpsWtXJ5vF5k1wASxSXTUpqTmZZapG+XQJXxqcV
        N1gLTvNX/Pxyl6mB8SVPFyMnh4SAicSHGUeYuxi5OIQEVjBKrNu+kQXC+cIo8eP0YSYI5zOj
        xMqPKxhhWh78Oc8OYgsJLGeUWLVeCcIGKprYIw/RsJVRYueSXywgCTYBHYnzb+4wg9giAvES
        s9dsBxvELJArMWv5ErC4sIC9xMPbF1hBbBYBVYm9W/aBLeAVsJE4dO4P1GJ5ibbr08FsTgFb
        idcr+pkhagQlTs58wgIxU16ieetsZghbQuLgixfMEL3KEtf3LWaDsGslTm25BfaZhMAFDonn
        jztYIBIuEh/mbWeCsIUlXh3fwg5hy0icntzDAtEwmVFi/78P7BDOakaJZY1foTqsJVquPAFK
        cADZjhKXHgpDmHwSN94KQhzEJzFp23RmiDCvREeb0ARGlVlIXpiF5IVZSF5YwMi8ilE8tbQ4
        Nz212CgvtVyvODG3uDQvXS85P3cTIzCVnP53/MsOxuWvPuodYmTiYDzEKMHBrCTCK7tpUooQ
        b0piZVVqUX58UWlOavEhRmkOFiVxXm3bk8lCAumJJanZqakFqUUwWSYOTqkGJqUrIe+Zp0iG
        8P23do9P9K5tY7b/Oftw3gvuz/Oz+rN37pLMmCe0bPZeG85lurtf3Tt4/Kr29ydnPyZbzFxb
        vfTqrD/Jc37dcb1696T7hzqXW+zrp/d/mN/B/ehTRsxhPeOaU525O37wccq1lPm08XV8XPHE
        0jwpYN933kf+z3Suv3/nd3b/xhPHZ95NZ3q3ytrzZ0iyzLT+GSatp5XWN6kIH9y3d6ZHtPKM
        LSkVC645d92Pn8lpzT71XXyi4oYH88y70xd82Rd6ke3qVwHX9qNb8tt2HLFNe+ueMGWH1R/l
        1aWrp+i0qGzwiH8j4dp88fc2v6krLp3qY47eLLDLrUhm3vIYlrSLaZ+9H/5/6FqvxFKckWio
        xVxUnAgAq6xLppQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsVy+t/xu7qZxyelGCxvZrY4051rsWfvSRaL
        y7vmsFncmPCU0WLZTj8HVo/ZDRdZPBZsKvXYtKqTzePzJrkAlig9m6L80pJUhYz84hJbpWhD
        CyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jE8rbrAWnOav+PnlLlMD40ueLkZO
        DgkBE4kHf86zdzFycQgJLGWUOP+3nRkiISOx8ctVVghbWOLPtS42iKKPjBJn95xmhXC2Mkrc
        OLaeEaSKTUBH4vybO2DdIgLxErPXbAeLMwvkSsxavgQsLixgL/Hw9gWwqSwCqhJ7t+xjB7F5
        BWwkDp37wwixTV6i7fp0MJtTwFbi9Yp+sF4hgXyJLWtnsULUC0qcnPmEBWK+vETz1tnMELaE
        xMEXL6A+UJa4vm8xG4RdK/H57zPGCYwis5C0z0LSPgtJ+wJG5lWMIqmlxbnpucWGesWJucWl
        eel6yfm5mxiBsbbt2M/NOxjnvfqod4iRiYPxEKMEB7OSCK/spkkpQrwpiZVVqUX58UWlOanF
        hxhNgf6cyCwlmpwPjPa8knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILUIpg+Jg5O
        qQamJU689+/qrp4Qzv/1buzPI1+/RrBpSKb7PEtOzwhP2t+z6gm71dm5+4MvzEie2LqqqCj9
        jORBi6jNj8TtZv7O9vp85wq36o1/b072NXbETLIQnrzoLt/z3C8zGR/c/v2OuUW1unAFp2/H
        o/yyVdI3f10I69G+vTbiwqnerH8nI4Tifh0Oe/w25r7fEYVw7zJP2RjhjRv5/VnVGe+miNgU
        Zq843Ll64tvgxQYzC1Z919eb92a/yc4XvhX3wlvybaJ4ky8+VD1pGSkUzbgxZdf8N7xXr/a8
        N+T8Ge/m5TlL6o3cUXHbjLK2pV+CuPmaTPZKP5Y6uG7eUufXz4MvBh78NuV5zfwjy3o29JWU
        3jh6WImlOCPRUIu5qDgRAJxPrt4+AwAA
X-CMS-MailID: 20230621094825eucas1p2d37372e5bd2377bfe953e6e4f7ff0363
X-Msg-Generator: CA
X-RootMTR: 20230621094825eucas1p2d37372e5bd2377bfe953e6e4f7ff0363
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621094825eucas1p2d37372e5bd2377bfe953e6e4f7ff0363
References: <20230621091000.424843-1-j.granados@samsung.com>
        <20230621094817.433842-1-j.granados@samsung.com>
        <CGME20230621094825eucas1p2d37372e5bd2377bfe953e6e4f7ff0363@eucas1p2.samsung.com>
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

Now that the number of entries is set in the ctl_header struct, there is
no need to calculate that number. Replace the variable and logic that
does the calculation whith the ctl_header value.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 fs/proc/proc_sysctl.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 1debd01209fc..9e7e17dd6162 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1166,18 +1166,16 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table_
 	struct ctl_table_header *links;
 	struct ctl_node *node;
 	char *link_name;
-	int nr_entries, name_bytes;
+	int name_bytes;
 
 	name_bytes = 0;
-	nr_entries = 0;
 	list_for_each_table_entry(entry, head) {
-		nr_entries++;
 		name_bytes += strlen(entry->procname) + 1;
 	}
 
 	links = kzalloc(sizeof(struct ctl_table_header) +
-			sizeof(struct ctl_node)*nr_entries +
-			sizeof(struct ctl_table)*(nr_entries + 1) +
+			sizeof(struct ctl_node)*head->ctl_table_size +
+			sizeof(struct ctl_table)*(head->ctl_table_size + 1) +
 			name_bytes,
 			GFP_KERNEL);
 
@@ -1185,8 +1183,8 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table_
 		return NULL;
 
 	node = (struct ctl_node *)(links + 1);
-	link_table = (struct ctl_table *)(node + nr_entries);
-	link_name = (char *)&link_table[nr_entries + 1];
+	link_table = (struct ctl_table *)(node + head->ctl_table_size);
+	link_name = (char *)&link_table[head->ctl_table_size + 1];
 	link = link_table;
 
 	list_for_each_table_entry(entry, head) {
@@ -1200,7 +1198,7 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table_
 	}
 	init_header(links, dir->header.root, dir->header.set, node, link_table,
 		    head->ctl_table_size);
-	links->nreg = nr_entries;
+	links->nreg = head->ctl_table_size;
 
 	return links;
 }
-- 
2.30.2

