Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC79E36BB78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 00:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbhDZWIS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 18:08:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34850 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbhDZWIO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 18:08:14 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13QLxgDj080831;
        Mon, 26 Apr 2021 22:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=kOI1/jG4tx6HSqiE1AFRt0kX1WHLPj3Q/Mqf5omPxHQ=;
 b=zN1A2xVJgviJrYs6vQ3tXm0PvUM2s2T6weyd5k4KJhgtrpssJ2yFljm47TmaAeBI41Zb
 hl9T06tKbno/jWx/4SS/WBZrK7LuSVpS3V9XTBTXEpu5PtoK3VYMyte6cMhSFohYNbOj
 iqFzWNeNHZi7TaclC96CwxolaMrpQNlk8ViuNcr+sKE7QuQlJ9hKr4JvAn60C6hmL1NT
 +jJj6kqNKjnoHzHEctpFGtjsyd89eU2VObfrAywtOvZrX1PxlKzeQ4pVUqkQN0I8ECgM
 TwFSzZwdQoeW8fZwRAIKFOFVtRQa3a0sMerIHvANCAMcoSZojecWZ7IurAg3WbF+esmI 3Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 385ahbkk8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 22:07:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13QM6Kli105544;
        Mon, 26 Apr 2021 22:07:29 GMT
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2054.outbound.protection.outlook.com [104.47.46.54])
        by userp3020.oracle.com with ESMTP id 384w3s65pu-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 22:07:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfyHO/QnH0VbHqXs7mzJeY3If4+ZHVCpyk+9pcv2M/51lYgWvx0tdjWWt2BK+4wl/jlSYifLAPrfHr3CAzLtD3NbZhMCeO4Ki1NHLSgp/BhW9Agu7OVQtq8kDw/KqX/NUecoes1k5kWesMLUcy4WI0lf1k65K9/li8+HuNPoAQABtmnaZrZjgNYo7W9f37rKIzjpfScC60VL8VEnpFiOhZ7qkM/bAnw77D84nSOkyld6CJWIPweUNUv32FTpm7F+E1A0y4kLzX8Vv5PlGG26ZaHwnDeR9AnUWFQYVEqpw3H+6/+ToI1RiGH5JHG3HKCejOyJdOBRDj3YpO90be6Wvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOI1/jG4tx6HSqiE1AFRt0kX1WHLPj3Q/Mqf5omPxHQ=;
 b=RsGOjlOwi3yg7BavCb1dVIUL9ySK27ahOAYF7RTPz4LTOlqb1tvMXxF2sBsWl5L33TJDzGHVND+kKt2OZN6bGySLaJdFRSH16H6HONvjoRe4MD0hlI4Eq/q2OX8jLMIRAZEY19mSR9pvQHo+KCjl6IqP6haTsPainA3LULkJD1LrDd1wPFwAEbIrCCSMr/jHwoqdhCAo4LFBAgf+w1vunbmQIU+7r1r/82gyEA+cTbktSZl/XSo0JOXpQkHCUiT5ZHpdKJ1/tSLqf3JvVtXS4ryYaEQ0w+VPsKKBnzvU48HjXdGOKVCRHidvfQ8rHKp1HZy5AjCEZmRyWkKEKPeeTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOI1/jG4tx6HSqiE1AFRt0kX1WHLPj3Q/Mqf5omPxHQ=;
 b=T7Ty2caDwvdhxZ+WyFIeqNAFQjxA496RKBJDpX+Fi2jJaclVZtdX84psykIPeaokdFb2RIq2oB7JZpsjV2GrkUNyPs5aBkwcREp/WFBBudznYAuZ9mNjQT88LH68TG6nA4ioBlnjyEsVQLMLTW8LQs2vaTbOrLQVrp0JaDYySS4=
Authentication-Results: oss.oracle.com; dkim=none (message not signed)
 header.d=none;oss.oracle.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by BY5PR10MB4307.namprd10.prod.outlook.com (2603:10b6:a03:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Mon, 26 Apr
 2021 22:07:26 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::7865:7d35:9cee:363f]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::7865:7d35:9cee:363f%5]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 22:07:26 +0000
From:   Junxiao Bi <junxiao.bi@oracle.com>
To:     ocfs2-devel@oss.oracle.com, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org
Cc:     junxiao.bi@oracle.com
Subject: [PATCH 3/3] gfs2: fix out of inode size writeback
Date:   Mon, 26 Apr 2021 15:05:52 -0700
Message-Id: <20210426220552.45413-3-junxiao.bi@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210426220552.45413-1-junxiao.bi@oracle.com>
References: <20210426220552.45413-1-junxiao.bi@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [73.231.9.254]
X-ClientProxiedBy: SN6PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:805:de::39) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-151-113.vpn.oracle.com (73.231.9.254) by SN6PR05CA0026.namprd05.prod.outlook.com (2603:10b6:805:de::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.16 via Frontend Transport; Mon, 26 Apr 2021 22:07:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 437b5311-e205-4d22-619f-08d908ffad33
X-MS-TrafficTypeDiagnostic: BY5PR10MB4307:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB4307267405CDC4286F1AC124E8429@BY5PR10MB4307.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E3563R/10UTPyrmNSTiDTgafHe7Q3aZWp9OIPGLDA1MZl/A+ymtbh0fLDmlEgr+TPOtfwCt3QAnKb0r1MakBP2waKYIvtrcYGOM2ZtSEDUlxj90/sO89dboO6pCLSlyTSK5j4ARSHOkIoj+xehZXPDsy/UgOR+qiTaiUAgJ2OVx8/+dlbUD72rZkV2bLdsK2w4VhRt/1ByC9PKAOkayg3+LBLQ8qSB/psXtLj5QXFfnCOlqsKtaWmmOq/Wb7Bawi7nPGGpWLgpFxTq337gyGbpTdHgRXEPGPddPjf6THuiQJ4QdueSBU4ihVDFkmjxXtbLmi3Z2L76uG/ye3gyyg01TmusJb4B25qvPVZE13fSw8Sis3RDjIRTrSiq3mqao6oW9TwpqYgzyh2zPkDPTOKB7JHGbRrppc4CiWc408nDQCVQD7Gw1OKARsbrjjXXPDxtgseqQLPJ05/wM35mDa9M68lsYif0Bos/Gn46U3hOammoRGFaM3nkGaJVVlCs/nZq/SNzwcZMhKLReYt8DUIF4M47M8oUExh7X3NB/iyo2Dvnp+tYZscvVAdLHUpsENCR5lw4gWvewu0keuPe69ZnLF6UQRlckvJz5a8oFmp4MCeOWwHWIOSExcHyczvJW2TdaLcilXNLrcbP4hz28GIGgBRrA2kZx6FBpJvBofrRY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(39860400002)(366004)(136003)(6486002)(6666004)(4744005)(44832011)(5660300002)(478600001)(2906002)(66556008)(52116002)(4326008)(36756003)(83380400001)(38350700002)(86362001)(107886003)(26005)(956004)(2616005)(316002)(8676002)(16526019)(1076003)(38100700002)(8936002)(7696005)(66476007)(66946007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SYJyfE8DDXUmEEYW/WWlB+vpPILtTWRe0Toc9hp/3Zj2I291rylSDAzkFtJw?=
 =?us-ascii?Q?WqkD6TeE5viW28i3C4sY2agGAgco1dxIwtxhLRkgbKq+zb7jHIybASK0dpbb?=
 =?us-ascii?Q?QzfnP8IdHtD04g8PymfvsmGYVJbfuUV8t+4WrSqT6cQjTlK6hb+glvx0SOh7?=
 =?us-ascii?Q?AutRHooU6XtAT6tsS6TPHeEHylXKicgpc5N0seCrf+pW7t2TGKyk6mr7RX9T?=
 =?us-ascii?Q?ACKHOAQ5lvi161p5a8UP6G/rzLweVbtHLq0G9PSZy5sGAzygutdr9/WDmOSz?=
 =?us-ascii?Q?RLiyUQJeDG09CtAN7fjB/1SxTJBv1wYmTWC6atJ9KeCarRG488ddRjKZdlUi?=
 =?us-ascii?Q?KBeTqV1N4ZlDQQI8TRYztXsd4ux5M9oAz7Efl1ymUTBlFwFhxSpPrxPDCykO?=
 =?us-ascii?Q?9PYrpK/L1Eh393nYRItuVFN00bEQ1wvAiXjBZgMa/u/OqGStpCaNW5XBYWFX?=
 =?us-ascii?Q?mdZzstvf+hrWM/mtugXdro9KxXJFK75k8N6Z6DFavyY32+Sb0u7IYZua8nE4?=
 =?us-ascii?Q?wTL/FEGlj8CQ4jgzieXNAV13u6K6w/MgP4mBZHbb05u7WoLfP7CJswNJLkiu?=
 =?us-ascii?Q?6MtxulWnoxSWsMAyvOoQ9fEUvTLIvY5BZzVkHSCqze9WGg5Ynb+6ejs+N+en?=
 =?us-ascii?Q?Sp1MjTPo+Dm9Dnhqibi/AQXy0SZtPEXIeoVGmKlPsTrrsoSoM+oDt+t0vN9c?=
 =?us-ascii?Q?9BBzuYLLsFvCXahkNaqDKwc2sRmw58OOuuRfnxYUk+WfQn8tGAwxrrp0899f?=
 =?us-ascii?Q?dMJmsDjHJEf/mk0rKvIXiuacli7xut7VhAsb13TNM2dE4grJDRrXI9i4nLMp?=
 =?us-ascii?Q?r3RrlVjNPvCu76OfXV58gPPv6hiR6RBJF7ExOYXY8m5YSyxh7uSFdug2pmWB?=
 =?us-ascii?Q?goU96RIEgYOwFumKOOaQajNGB6XjwrdyyWT0gYah2bebSYmZwS9wVCJmB5ZW?=
 =?us-ascii?Q?Qe52HnGJ1mx+CM/zfbGl2LGUxxU/HPifnX27vheF1EhjYQ4sV2H0qMd8Case?=
 =?us-ascii?Q?QU0C777jP06j1Khrqisv73JnNKw8qJme8BxI4XwlBE99wDp6jmBgWrQpkHTs?=
 =?us-ascii?Q?7xTm9KvNdHtifzIJ/cXrT4u29V/+IhNKv21v9avGw/HB3KVltEJFdMoNJouj?=
 =?us-ascii?Q?htQElsf20kJPnJFUpFCi+OJW0buQFvoDFFxK7BTFosqfO4vcZCPPcT6UnShe?=
 =?us-ascii?Q?XWrPJaKBkGFQ32wwMS4Kap84zJDNwPH//h9QELrZBYoo0KVmsdrVbwaW/5/W?=
 =?us-ascii?Q?IpSiVt3E3jdk5NlhxvdeaEPQMahKqnG7+W2o19OT6x27Ro9gcsWDIzUvZqtP?=
 =?us-ascii?Q?QJ6e5a/u+GKT5hNViBkMDQro?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437b5311-e205-4d22-619f-08d908ffad33
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 22:07:26.6806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AV2nH1kgmO15bSd33q5EULvTf6tmN7l6AXVOY4eg7O+YjuEZK1TRAVjsiU9PftSbml5PxPsAB6/8l0aTUbZ6uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4307
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9966 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104260167
X-Proofpoint-GUID: kgpF6frZziYuiZ1zwB3wCZEF0kH0xbys
X-Proofpoint-ORIG-GUID: kgpF6frZziYuiZ1zwB3wCZEF0kH0xbys
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9966 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104260166
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dirty flag of buffers out of inode size will be cleared and will not
be writeback.

Cc: <stable@vger.kernel.org>
Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
---
 fs/gfs2/aops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index cc4f987687f3..cd8a87555b3a 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -133,8 +133,8 @@ static int gfs2_write_jdata_page(struct page *page,
 	if (page->index == end_index && offset)
 		zero_user_segment(page, offset, PAGE_SIZE);
 
-	return __block_write_full_page(inode, page, gfs2_get_block_noalloc, wbc,
-				       end_buffer_async_write);
+	return __block_write_full_page_eof(inode, page, gfs2_get_block_noalloc, wbc,
+				       end_buffer_async_write, true);
 }
 
 /**
-- 
2.24.3 (Apple Git-128)

