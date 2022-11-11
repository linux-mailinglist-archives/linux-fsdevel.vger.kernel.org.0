Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69584626427
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 23:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbiKKWGl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 17:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbiKKWGg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:06:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6982DAB0;
        Fri, 11 Nov 2022 14:06:35 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABLomDB025514;
        Fri, 11 Nov 2022 22:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=r+JK2xhlQ14b6zZzmCECL5gWzBVH/1UEmZ33S4f1XoI=;
 b=tclGVTzxO0Yf+DxYHa6xvl/A+73Ce+8JoBN1LMYtFxDRWuXG7zRmYUq5qc++Fdxrt02A
 veJlr8LPE3+W8J3SwDyQMAYktCWSi/31HDDmRrlCZJL7QjV0BeUJTZdfV4qN/J7LWk2A
 wPJsdwdKy7ha/yUAcC2nvus5hrwavzgkQtN1cCBlUk2cz06gUyZA1U6DRXyKSs8X/6rr
 bQM1ZPR/wAEH+a/tjw2hncP00lZyTvEZF0bhhec4JB/LQZocQuafT29Y1EawvBpsDai3
 9gkc9e3QDzE9/mFO2+/KrW4aHM1MgpM3gea8Arttdulb9TyU4o6DysMM2k1RoMVuzZCs aA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ksxnrr13d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 22:06:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABLV4h1009032;
        Fri, 11 Nov 2022 22:06:25 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcqmyka4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 22:06:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gC+88rtip8Jd2v9ropx1S8A0E5/XMXVolcAwXVjlqQgxYvJqAm53fsneNKC79OPWC3YofWAXdNAmEg/6Ykc+zSCUZhNhkQvUX/4LKsB2HWs1gp4le/6BeKJ3YcG9JGcA642ghRahxNX1H6Wtwsc+cSq4cIVsPRUfsH6p/zlGzjEnhvMHdRNliWacr4BIC5+51xj9TjYUoLw8V0BX5kDqEReAPPznGRGpzH6ma/2Uo4wBlzHjnH+Pho2bjdp79NCmORa3sF0CJDFPysHTnnLqfwkIwm0nY4b3vUb7EmVUTfABooZm2pUamNq1dQyxY3RnHVr/OMZQ9OodRobEKTzsfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+JK2xhlQ14b6zZzmCECL5gWzBVH/1UEmZ33S4f1XoI=;
 b=dajKbW+4NKeUxYJKYplFNCWgT4i/F5dtPQisuMFqRX5PMZ5dPIGrlxvQHRksgaSF6D0uhe8xWoSAMnDkBWrf1O5jxUrk6MGaldN8ht7NCsC4q9+BVujbpf478ArXonXiGXdJv0SVYhHtLpJ3fSt4v23DqfVuPKiD9tIvtlAD6MjHK9/xJM/t7KVOuwO2xgb7WZsCgkYIC+DxAdXoSPdAYICG4h+jcVDiQa22/urnbkvIxRjzJWGYyHCuMmwn6dgRM05P2E1kOGbmT6u7vCIJsBFHBmYF6vctxw6OOBPT3pEGHyopLxZYs+5Q9Wklg8X482CpFy1Z0bgNFZ+7BDM6pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+JK2xhlQ14b6zZzmCECL5gWzBVH/1UEmZ33S4f1XoI=;
 b=CeFVh9we39c5aCNwS1Xv19L1RIsDI9eqKYOkfV7XEy894YP2VXh/KYOvjDWWUCoZ34dBPpxCnd0C4IMyXfgCDX8YVM2Sf0iTpjoLEqea6goojd/Hvq1wnJRmjm3pTeRtGENIC9yLW2RjyM+GRX1FhFdok/y2j3UGHDDBP95kEyQ=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by PH0PR10MB4535.namprd10.prod.outlook.com (2603:10b6:510:31::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14; Fri, 11 Nov
 2022 22:06:23 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::c544:e51b:19a0:35b2]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::c544:e51b:19a0:35b2%7]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 22:06:23 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v4 3/5] dnotify: move fsnotify_recalc_mask() outside spinlock
Date:   Fri, 11 Nov 2022 14:06:12 -0800
Message-Id: <20221111220614.991928-4-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221111220614.991928-1-stephen.s.brennan@oracle.com>
References: <20221028001016.332663-1-stephen.s.brennan@oracle.com>
 <20221111220614.991928-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::31) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|PH0PR10MB4535:EE_
X-MS-Office365-Filtering-Correlation-Id: ca28bbd8-9ed6-4460-e764-08dac430f861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xKSfbNqE8eWBNoX3qvAaEphp82O/T+EZXkFaa/C4ciCocyJHEROKhvRuKocLDuPu7YiGRAS9Adx8IWJ36FS52dAV2L7CvjgpkghjPSGPzvGPu7niNHpm0TVG8INiH7cosleQl6CXXFep7bwE8FEOUnLy7kIanyhsdKzDzBb5kbMSbCmTXlY7c1NgsmEnOEayK14781Y1eQPPoz7beFkgJv/7PdD1Ujkh9mN/UPZ6+bvolh98ItzwqB3+AF4DAoF3i5tUXy42ORLE6i8igibP8NoOyOcn8CHEZ2dvygtWeqezwIUOUt+7oLxgL5JrpJg8TYnmCqaPsyMOt5BRtnd4zS0aRIPouEFiYwCMGkq4SWY3jPZam20268aY9mURXid5gn4Kf5tbYq/CrV0Om3qMf+VbkOYk+47w5tPRiUvbd71GR2Ad1jON9+DQqXDg4szUi0h4fTYaVy1hzsDvcWtUeTNLIwLG1f1PnXv6Aotyc29IbcmYi/kANLIvE81j4zFFmEZi4M4rkQI09fyB5vW2C5CJCgyKQfPMH3otO9y00ZCscHrrT8NY1W4M5lSKjvOri8dZgyk1ih+41d1gSUdGnXWWHei0X9JgtwiVvs5biUxjlfZ0O+puHSl4csp+wXmPY4waNsSfgDKdbU0xu1BIrJVKU4QY61PvkhBd0U2WT4lGQcMiXAlg5TkA92A+0TcR4PeKey8IkI1UcAkjQvXfRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199015)(86362001)(83380400001)(103116003)(38100700002)(66946007)(2906002)(8936002)(5660300002)(4326008)(8676002)(66476007)(41300700001)(186003)(6506007)(26005)(1076003)(66556008)(6512007)(6666004)(54906003)(2616005)(6916009)(316002)(6486002)(478600001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CeSS0YJzUFlLH/1X6uxuCu2Xz6h+0XHIzQ2RCP5I2pMa2d0dy0RVIlwHTXAI?=
 =?us-ascii?Q?8oMuxbyRsv2au0rpySyWKDATERTg1p0p287dEQ/iS8kygbd3CuXaZafCzE2y?=
 =?us-ascii?Q?BZMfE5Ej/XdAfDXfA7/7dpv6csLoYpKHYlDuIFWHVi2jhaxsfIFLQcMW9pFF?=
 =?us-ascii?Q?kctktePrfr2L15NZuAWqoxSVLep/xsIh1svoS9ZMVyqtU4xWjggeAbb3cpSG?=
 =?us-ascii?Q?I+Pp/0SI4nJf+gwAfgoJtqdihejVeGQrOAevEBWHryRbY1BQSQIEnVqJGTXO?=
 =?us-ascii?Q?ACL5xZsLj61KJLvrlCdkGk4LU+HM7MoOehifQOwrCRKTe2ePgjpqg7tDfjXi?=
 =?us-ascii?Q?5IfMocso2RoPmXeDNoWHPOoft6k96g226aRaWarQQsMIcf/J0zxvbYVnlDVW?=
 =?us-ascii?Q?w2Clbr60YikP9qTmJj7fkLSHAfjurgxLheYi5V0bckgdVbcbpopKA5yyPfg5?=
 =?us-ascii?Q?f/iaJL1O6kyv255hpdYsUc2/fsB3b1zlK0rkrUOEV/EemTrXKtZ6EspLIFEj?=
 =?us-ascii?Q?tW3kBOSVOa3HdcIs6YMtTS2M63qR5kII8BLRjlfwte9AUqkUFpVtgmVU097h?=
 =?us-ascii?Q?+SjzCwyDcuUZV6M8mMk/de+AwOG7sP5g6hmActXmrTdswNyE9y06Z5jvgr3j?=
 =?us-ascii?Q?GcN9eALaKXWCKAO0FOX6JHfFOe1xhvw1z1FZTYHhHl0ic8kBnkcLkRBOmu5s?=
 =?us-ascii?Q?O9RbgbDSd0E1WyxKbCpq5xPgvNtXZmNIyqfeKtdEbzf2SMIKXYKNKdn//cGH?=
 =?us-ascii?Q?nZRre3l41vTiSYMmz416aa0cTopxZ+HMmh3gdPJvwwAajsXlSvYv41Xz88Hn?=
 =?us-ascii?Q?eBy/IEp5QUWbfymULKICo5p61k4H16+pBDSyp58kXkfpYFW8Hlcjam+NzwLy?=
 =?us-ascii?Q?L70ncS7ImBM8RgZWW8JCX+p6gTRXkeg8F/ttQaSJnv2I2GG2TYImgHnFvcc5?=
 =?us-ascii?Q?8O1+rvIsLwa1fr9uvoe+D4g+wXX12vxCOx7StXjQDkupLP/xjm21aSS9vGs3?=
 =?us-ascii?Q?oEb5gZDBJ+dnTI4WAFX71bArYniJ5j2D0Eu0vTy0YOhwmfilnM8PCzOCOT49?=
 =?us-ascii?Q?qfxrSFYf9EJk2TwgmxnUrkQ4GAdd1/y6HcjfY+22HsbDR058cMvr4aZnpQUS?=
 =?us-ascii?Q?Mmk4hCZXYjw5pkvcw4gBjcyNA5NAoof2ZFb3VfNmLLleI/aKaHC3oMORfBZc?=
 =?us-ascii?Q?Qh5VMsQ66aKteMHVUP3k21+cR5GvNiEgrRlitkX4WyesTxHNVF+NQa/zEVm3?=
 =?us-ascii?Q?LEtfVcJHRQtTc0Ub9WkvzGrnOghAKvJ0P9y+6ZElShNt+wUHHQNr4i1z0ACI?=
 =?us-ascii?Q?SIJA2auRVN6R3r3t9rCGLxjFfKIEjYRsb5+SAIYCy3lHQs+0ysGG4sQntg8E?=
 =?us-ascii?Q?fPFldgKHqvbOExvUSKHik5VDp+DwB5AJEFpZK3GXRIBGMzyvFoof+G3/x23D?=
 =?us-ascii?Q?5zCGFCTvC6kGGdqOz0Hi/DG68bLAHHd1DxQ61H1PrrN3h6YwDtgWbnRnILnB?=
 =?us-ascii?Q?lpwjuPsuWcacU2H777RpTzQjMY/HffD05W3xaVk63Tdx9+Q5LlDcatutvQy2?=
 =?us-ascii?Q?HbGiiYwTVny8mJVDPHYe1JRJKZzmeg6ukM9oLdMJT8pb1irq5+5XlXwEWpUZ?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ai69utR/aQsnLIdSYU+krFa5lg2319fKOYyLMWX7PB0YcKl8voPuRibv9WB5kfwOGzcGIzn2rNhxeTqtnRyohQvjb2IC7rjCvueFF+QaSG8fItP3f2xoIBNt6vYdAOaVfHP5JQ2854uioz9AADOZXW0k6hkBU0QbOPocAy0DN+q6aOJboKvQ6mm73OpUfWGT2sRDJAxdIIRDTCaF0v9ZNEZxDnu+1le8oOIh1DjeXo+vZobKtFmBR7c0qTl0pLJH4LV1ZtMyx6zqJdHdDeaSUTTeRD68lkrE+Pp0wB/JMmq4ASsxr4jg6hG6QtCkDf5d4FWIEUuKphvtJY1oZUrsEdzH+211iShFNsJeMVEzZ6CsH7s6TkMv4ulFinnj8y5fd1q5Y9XAvyRn9dYalKt2yZKVbXk6GHNJBGnybsI5uXRbZw+m7LRmBQfDVD4eIcaF1F/Z9Mo7DwE5DQBt2BGMRLtvE7HU77S3E4LL64zo43KawQgOAgUzLySN+6gMXAMmPR314DYEcVRcc6Ml2JAdR5lLa5jQnU0pftoALQKdR1mPQk3hVUycRHCHNjWQjQjvO3RvheqIs3MC40XtSHgUa6O3Am8kLSU8bZiiGmFRyYj78ai7wJuqQW4btLMWovY/kBwUoPL/NQJ1nR8hLtIKDtddTQAOr1OlXcHlSw8DbDPE/4Xj0zhti3fNh6bsCGFcvein+zASW0kHKKxC2IHKuuNBRvn05ZaQm2KdmBLNLLWpUHtG76GwkboFdxYKFtFu2j5iPMeSqFhJ043o135m6Wzu1eanxkAOyqGG+Kb/REVENbvyMZh4uDQRRbHIPu/Sgh+SVelrnfzQYkHNaepEiOkVOYsMbn3XFTqbq5VLpMlPbZPk1/dT9QJqJsvPVzHXWZCTMI300+TxcpDzQg/i2g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca28bbd8-9ed6-4460-e764-08dac430f861
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 22:06:23.2080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYt2vABgmycrhUp87PpWREASBFCAerA+Uj7vdUzG2goEVQwEhWhmeNUfgpl02LuWx/LaBS9FzShw5TCg2WITdnyG03Oh1TzVCMTZ0UB381w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4535
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_11,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211110149
X-Proofpoint-GUID: f5ZYdeS7SW-nIxuPzd6BJ-bH_RQofcUv
X-Proofpoint-ORIG-GUID: f5ZYdeS7SW-nIxuPzd6BJ-bH_RQofcUv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to allow sleeping during fsnotify_recalc_mask(), we need to
ensure no callers are holding a spinlock.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 fs/notify/dnotify/dnotify.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index 190aa717fa32..a9f05b3cf5ea 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -58,10 +58,10 @@ struct dnotify_mark {
  * dnotify cares about for that inode may change.  This function runs the
  * list of everything receiving dnotify events about this directory and calculates
  * the set of all those events.  After it updates what dnotify is interested in
- * it calls the fsnotify function so it can update the set of all events relevant
- * to this inode.
+ * it returns true if fsnotify_recalc_mask() should be called to update the set
+ * of all events related to this inode.
  */
-static void dnotify_recalc_inode_mask(struct fsnotify_mark *fsn_mark)
+static bool dnotify_recalc_inode_mask(struct fsnotify_mark *fsn_mark)
 {
 	__u32 new_mask = 0;
 	struct dnotify_struct *dn;
@@ -74,10 +74,9 @@ static void dnotify_recalc_inode_mask(struct fsnotify_mark *fsn_mark)
 	for (dn = dn_mark->dn; dn != NULL; dn = dn->dn_next)
 		new_mask |= (dn->dn_mask & ~FS_DN_MULTISHOT);
 	if (fsn_mark->mask == new_mask)
-		return;
+		return false;
 	fsn_mark->mask = new_mask;
-
-	fsnotify_recalc_mask(fsn_mark->connector);
+	return true;
 }
 
 /*
@@ -97,6 +96,7 @@ static int dnotify_handle_event(struct fsnotify_mark *inode_mark, u32 mask,
 	struct dnotify_struct **prev;
 	struct fown_struct *fown;
 	__u32 test_mask = mask & ~FS_EVENT_ON_CHILD;
+	bool recalc = false;
 
 	/* not a dir, dnotify doesn't care */
 	if (!dir && !(mask & FS_ISDIR))
@@ -118,12 +118,15 @@ static int dnotify_handle_event(struct fsnotify_mark *inode_mark, u32 mask,
 		else {
 			*prev = dn->dn_next;
 			kmem_cache_free(dnotify_struct_cache, dn);
-			dnotify_recalc_inode_mask(inode_mark);
+			recalc = dnotify_recalc_inode_mask(inode_mark);
 		}
 	}
 
 	spin_unlock(&inode_mark->lock);
 
+	if (recalc)
+		fsnotify_recalc_mask(inode_mark->connector);
+
 	return 0;
 }
 
@@ -158,6 +161,7 @@ void dnotify_flush(struct file *filp, fl_owner_t id)
 	struct dnotify_struct **prev;
 	struct inode *inode;
 	bool free = false;
+	bool recalc = false;
 
 	inode = file_inode(filp);
 	if (!S_ISDIR(inode->i_mode))
@@ -176,7 +180,7 @@ void dnotify_flush(struct file *filp, fl_owner_t id)
 		if ((dn->dn_owner == id) && (dn->dn_filp == filp)) {
 			*prev = dn->dn_next;
 			kmem_cache_free(dnotify_struct_cache, dn);
-			dnotify_recalc_inode_mask(fsn_mark);
+			recalc = dnotify_recalc_inode_mask(fsn_mark);
 			break;
 		}
 		prev = &dn->dn_next;
@@ -184,6 +188,9 @@ void dnotify_flush(struct file *filp, fl_owner_t id)
 
 	spin_unlock(&fsn_mark->lock);
 
+	if (recalc)
+		fsnotify_recalc_mask(fsn_mark->connector);
+
 	/* nothing else could have found us thanks to the dnotify_groups
 	   mark_mutex */
 	if (dn_mark->dn == NULL) {
@@ -268,6 +275,7 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
 	struct file *f;
 	int destroy = 0, error = 0;
 	__u32 mask;
+	bool recalc = false;
 
 	/* we use these to tell if we need to kfree */
 	new_fsn_mark = NULL;
@@ -377,9 +385,11 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
 	else if (error == -EEXIST)
 		error = 0;
 
-	dnotify_recalc_inode_mask(fsn_mark);
+	recalc = dnotify_recalc_inode_mask(fsn_mark);
 out:
 	spin_unlock(&fsn_mark->lock);
+	if (recalc)
+		fsnotify_recalc_mask(fsn_mark->connector);
 
 	if (destroy)
 		fsnotify_detach_mark(fsn_mark);
-- 
2.34.1

