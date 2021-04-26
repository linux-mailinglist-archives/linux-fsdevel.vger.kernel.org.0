Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3E336BB76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 00:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbhDZWIQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 18:08:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60180 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbhDZWIL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 18:08:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13QLxbeS063565;
        Mon, 26 Apr 2021 22:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=VAx7UlJBLJcEkpNko9PY2Nve7EX7DM2MKmi0fwuaFZU=;
 b=r56nw0jF+dIhH94hjE7IUtyEl57QZ/Fj/PbtqeOgNU/XKo7UmaeeLgfdVlA4P5m/qpEa
 zpt42VsHRAfB5rnnuaDEOe16HmZjDG+6Fx/RLBYNYf2VjoRthOwS7FEAnx7LsNvyfZAg
 gC7et581FlneMrANiJSun9d33evrFxkqmz90ewoYWa3Xm7jr0bCaIj8lHEHsSUrJ/81J
 XxvtLcZrN/RcogfgPy4rTRWjsrcr79QxI0VBdJjQwzDqhgX/gi/R9XmtlB0FrpXIVSUX
 R4k3F3OR3lwH9KQ1TWpr98QE17EJFmAhgEBhPqFqpuyiqlG1uZFgUUxdVedsGQeYmteI MQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 385afsuk4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 22:07:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13QM6Kld105544;
        Mon, 26 Apr 2021 22:07:26 GMT
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2054.outbound.protection.outlook.com [104.47.46.54])
        by userp3020.oracle.com with ESMTP id 384w3s65pu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 22:07:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQvZWaB5HlEZrKXrh2dQIyMzmPAcDiBRBtSmIENmX7L4TMyw2VNc2IaNcRoFky3UlXzf5CJKA42F3+reCgoTtlK//vsTZqPcSlgj9wuzXhz22aDOT8Df4gTrdCORa+EeVb31aSaCXmMJwcy8YOpbyT4xiCYGStYvluLTpo6V8C4VYfjKLX/fTmhs5pi1JjDAuP1CmZZLcZDOsvne71K2tOLkOfGup1Jge5zfzr08BoKRnX7EEpqTqtpOcEHU/DQ7ktKDPeS1jpmzk/s6/rAq5X+j9iHrk22ISkn1k5fb0O5u3WQiueRv3XbKXH80GlP6HMDHa1zHh9oiBsKGXrVbzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAx7UlJBLJcEkpNko9PY2Nve7EX7DM2MKmi0fwuaFZU=;
 b=AXwp/d6/DP0VCpRd5xNqSNqH1TQQKqu0EMaQy7z7KDLGZt0oLwVv5KfHrui1rx5a6bVtgWJZYU46cRWZWjoHjOoc6z5ZX66PvTASjZmqvoVcXC+g8mlFeUTqgQKPLyj8VOyNacFFwgcuXJ5WCTec3d2+nyG9zx20lhfmClxYe645vKJ1Lw/1UbfQqJJrnHQT+rtiS8BuiWlwPYUJDIROkK6/+aXGc+3VdfIayXidAAd/ADXzGq2UA2VXJru3izavoGECZqQzpGaB+//kdub0T4telQ5G+sCcH1wJHH27lyR1BGmuLadqYXVG5eQRvPtCNqXrrHbhc3HKXLJSk8D+YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAx7UlJBLJcEkpNko9PY2Nve7EX7DM2MKmi0fwuaFZU=;
 b=Sv9Z7hBDikpmny97WdzKCHPjjfk2PIp6x+sh157DR4JZBtID/2+Ekaayrhuk0MTxbDcMUoJEVJFsbYQBqe+5Yx5O0WmF9USU4aARdEXbzo53XyskSTkWFvKMJvcB3Db9sf3bJUTjM0bgyqJ8K0oZJnZHacllMPvJ6n9W65aJNMY=
Authentication-Results: oss.oracle.com; dkim=none (message not signed)
 header.d=none;oss.oracle.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by BY5PR10MB4307.namprd10.prod.outlook.com (2603:10b6:a03:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Mon, 26 Apr
 2021 22:07:24 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::7865:7d35:9cee:363f]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::7865:7d35:9cee:363f%5]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 22:07:24 +0000
From:   Junxiao Bi <junxiao.bi@oracle.com>
To:     ocfs2-devel@oss.oracle.com, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org
Cc:     junxiao.bi@oracle.com
Subject: [PATCH 1/3] fs/buffer.c: add new api to allow eof writeback
Date:   Mon, 26 Apr 2021 15:05:50 -0700
Message-Id: <20210426220552.45413-1-junxiao.bi@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [73.231.9.254]
X-ClientProxiedBy: SN6PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:805:de::39) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-151-113.vpn.oracle.com (73.231.9.254) by SN6PR05CA0026.namprd05.prod.outlook.com (2603:10b6:805:de::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.16 via Frontend Transport; Mon, 26 Apr 2021 22:07:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0e7a9d6-7dfb-41e4-2b4e-08d908ffabb3
X-MS-TrafficTypeDiagnostic: BY5PR10MB4307:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB43078B1D69E3E36310F3E99CE8429@BY5PR10MB4307.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JCm1z0+6b1zuGy5r9LSdvAmxQhmEUu6SlYfOHQ6HpJcFmlO8cJCHOcaNQ6QamiVmJD4uhuHDaHGE04vgN//34xGS4ItTiOgS40WJFhviQdrhbWYP/xgsBk9t9ykXrvGJcIslRE5d/EIwOuVnM87oBSFyxqY7cQLQmfU3XSHY8Fk/llJJaUkc8e8OoIFXmmwPoY0OrnSil6cxvTcevNU6H83PFZpTe3iKOo7c+J9EIw+h9qbPL7Alk3wJB+bI6wnCfMPXsujYp+fsprMukxdsLQ4h0xaNb3TCqPKsUmIb9/nDzxM/TSmTUAsrmIy1YJ/oX3kmGQIbD/Q0x6NX8QJwEcgHY821yZZcFENijR5zsin/DmaJXM+1T9XguOqbpn+vJotRG7N4WZYOs+lRsewHWhWrGu832SwvN+K1srGASxet5+r9ByDay790C+csb9AMamDqmR27PfOTEXLXf5KwCwRHpZEP2MqW/8/3wgIwBIFXAI/Gr4AjvHmySpdmOSTwa6YsGaPQOczvgE0Aux1yr1lHgC2KLMNqsZxumwzji3w54j+d1UvMAm9BrdCnVuEfNAY9QU4GZM8AMrheO0ZGm6FnGjeADo+ME/frApBvRpMZA5hT/Uiia945HhpYoPkhvxjmQG4o1qZfTfWbjt/RKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(39860400002)(366004)(136003)(6486002)(6666004)(44832011)(5660300002)(478600001)(2906002)(66556008)(52116002)(4326008)(36756003)(83380400001)(38350700002)(86362001)(107886003)(26005)(956004)(2616005)(316002)(8676002)(16526019)(1076003)(38100700002)(8936002)(7696005)(66476007)(66946007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ca6vXAHUWEO1umxIvaUDG/QKTSImuog68hRpAxvVHkLmRkBEEWj5ECKtMJLy?=
 =?us-ascii?Q?gJwKQ5qv4uQHpUaJUUSwhqXvDTCop0swrncrgMeJmbuSSy10hZHgEndL0HbL?=
 =?us-ascii?Q?EyNELNPo1JaaXgWP3ptp3OJmnNdZgR+RvKpWe742PziIJv0R4kUC1XED89Ea?=
 =?us-ascii?Q?GTS+7o9mrz/UK/KgSRukVQRP/cmBhNIVhyw28D/1nU7wyrlF5CNWa+6gbk4t?=
 =?us-ascii?Q?DGwWp1L1+1CBfMKpk3EBcFGwkPtBzr40Hfen+HyUQm/AHwU98Et8CbDoOaL5?=
 =?us-ascii?Q?Z6mcxzfNFxtStkM+QjvQjAwINAvEs01iUqLJ/K/CnRa/uTpm/vh/tLIiBwKV?=
 =?us-ascii?Q?7RexTRFPsYHWuw42LAQUUih1JkFJH1G3iWTluqfmqwfNvmsT493ZEEVNkh6h?=
 =?us-ascii?Q?eYwtgX2j4JqFx9jl5JPWddEmaSJBB04mNOc/T+7uu6VAUAQz2khZElkW3xVX?=
 =?us-ascii?Q?xknW4XsY83pnYDU4uyB5MlPjhCPD1k56BVR8lUOTOZ04pSGYC4D9i3aiU+0a?=
 =?us-ascii?Q?4ke7SvZXhiyZp/RAgKWShshxt2mL4un89240CMLCGe9a7T2DhKO4YG5q9fGU?=
 =?us-ascii?Q?CfW7KNy0dPhErKxr3Ah+maON7zeuoy6MVx3Rq/n+dokTddXUIeOm+jU6CjRC?=
 =?us-ascii?Q?IYqhwalTiNdug5ZFrR2jxVq4HlVa+W31jzftVUa3wVm+OwX2slgMD0VGx71z?=
 =?us-ascii?Q?8S5IGLQdS4Fv7Dnkd0/dYN9ghnhoxnJMNusWla+MjErYZynEpTzkOAHY02gS?=
 =?us-ascii?Q?0zpl9UszNFcoS6X/1QzznEpTZDLw2pz51PF9nMZOH3ricn0PY8kY2xUCrSpV?=
 =?us-ascii?Q?fsIWugYXTX3T51/euhhhEnek6OyMvC2PtVOeKXKgWT2S8c0CC8ITO1wFRiqf?=
 =?us-ascii?Q?tKiSeIAuvbgolkhoo6I22U7M6Y6hGyiUBWAq3HK14Bey2N8tsuvb9mtrmSve?=
 =?us-ascii?Q?ot5cbqVSQHOr8i+zxy7XtyNmPXUH3SP55oPhWCpZj3uurFCTZp3tIlpvpc3J?=
 =?us-ascii?Q?ZHIPL/RrGYXfsGoWecCj3Fqet42cMT1k3Nezgr3V8Yxp9SElKpXj7ejfYBbV?=
 =?us-ascii?Q?F/Y0TBzYoSiROVM/zggbRCzIGVUe8uinmTf9Y+zaJy/I+WUt76UGl1yjuC2Y?=
 =?us-ascii?Q?Whviit9Ekq38kPj7UHCO0Qk2gLYPGvUpjGP/UnAhUJkUbhUGmUbaByb7zpoF?=
 =?us-ascii?Q?Xt5PvE3nW7s9d87Qi6bRU+O5SFi6NenDRBayY8lcMprkl9AAl3rKhvNedAYT?=
 =?us-ascii?Q?yo5kF1IkOytxkEvBo18sWSWcT7gh39sUWdwgyE3nWiwhf0Yc8kKPaTMAOGxo?=
 =?us-ascii?Q?GEuCyAc8lAG7gLE4MQ5mGK4q?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e7a9d6-7dfb-41e4-2b4e-08d908ffabb3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 22:07:24.2204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snLY8rZffYOjsGQC0zOLdHBspCuyTAIkdH+8UH/3c7TK1tzASA8A/o/dJA9lkyvNMV/XhOPJFhn/0kULeqaeWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4307
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9966 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104260167
X-Proofpoint-GUID: 1LFIfHEUzqo_M-tC2YlEiXp7-Iir2L2e
X-Proofpoint-ORIG-GUID: 1LFIfHEUzqo_M-tC2YlEiXp7-Iir2L2e
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9966 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1011 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104260166
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When doing truncate/fallocate for some filesytem like ocfs2, it
will zero some pages that are out of inode size and then later
update the inode size, so it needs this api to writeback eof
pages.

Cc: <stable@vger.kernel.org>
Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
---
 fs/buffer.c                 | 14 +++++++++++---
 include/linux/buffer_head.h |  3 +++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 0cb7ffd4977c..802f0bacdbde 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1709,9 +1709,9 @@ static struct buffer_head *create_page_buffers(struct page *page, struct inode *
  * WB_SYNC_ALL, the writes are posted using REQ_SYNC; this
  * causes the writes to be flagged as synchronous writes.
  */
-int __block_write_full_page(struct inode *inode, struct page *page,
+int __block_write_full_page_eof(struct inode *inode, struct page *page,
 			get_block_t *get_block, struct writeback_control *wbc,
-			bh_end_io_t *handler)
+			bh_end_io_t *handler, bool eof_write)
 {
 	int err;
 	sector_t block;
@@ -1746,7 +1746,7 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 	 * handle any aliases from the underlying blockdev's mapping.
 	 */
 	do {
-		if (block > last_block) {
+		if (block > last_block && !eof_write) {
 			/*
 			 * mapped buffers outside i_size will occur, because
 			 * this page can be outside i_size when there is a
@@ -1871,6 +1871,14 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 	unlock_page(page);
 	goto done;
 }
+EXPORT_SYMBOL(__block_write_full_page_eof);
+
+int __block_write_full_page(struct inode *inode, struct page *page,
+			get_block_t *get_block, struct writeback_control *wbc,
+			bh_end_io_t *handler)
+{
+	return __block_write_full_page_eof(inode, page, get_block, wbc, handler, false);
+}
 EXPORT_SYMBOL(__block_write_full_page);
 
 /*
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 6b47f94378c5..5da15a1ba15c 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -221,6 +221,9 @@ int block_write_full_page(struct page *page, get_block_t *get_block,
 int __block_write_full_page(struct inode *inode, struct page *page,
 			get_block_t *get_block, struct writeback_control *wbc,
 			bh_end_io_t *handler);
+int __block_write_full_page_eof(struct inode *inode, struct page *page,
+			get_block_t *get_block, struct writeback_control *wbc,
+			bh_end_io_t *handler, bool eof_write);
 int block_read_full_page(struct page*, get_block_t*);
 int block_is_partially_uptodate(struct page *page, unsigned long from,
 				unsigned long count);
-- 
2.24.3 (Apple Git-128)

