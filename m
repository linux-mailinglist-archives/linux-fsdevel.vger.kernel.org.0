Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EF74FC1D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 18:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348415AbiDKQKg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 12:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239636AbiDKQKQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:10:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3BA165A8;
        Mon, 11 Apr 2022 09:07:57 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BF9VOV014133;
        Mon, 11 Apr 2022 16:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=jnwvLFTj1SfpHchAOm9ayKGf+zx6iaTYkuHrwHxh2sg=;
 b=j+OiDoezlXYf/Q49EH3gldajV8bMb00glji1Kpv9Kk/yvC7yVMG29sf3A0+ExCOo1ilg
 HG8gX66NzwQxRcY7ZUdIVXaaVdX288mRJ2hW4kxLnhQp1umI0nCBwVeEV6TwTgQI0CS2
 xkwvAJiSYppTqKuNcmkDezWAJ0x6uDauGZkVY+sY/t3NQPQIFXMII45M1C+O8hlt7r8w
 7GY/6GPOTRrIC2fsaqBTcicpbYMoVHfzCveILY8bl2dp+pnrQp29xnvH7szxUk2+hvoy
 vN5UcnA7Qqm1wkht1epzeU8O/fAmnhChCc61lUR+c9EQiKwtirfi5aj1yU8brrqDbgqv ag== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb2ptv6q4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:06:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23BG1ABp033069;
        Mon, 11 Apr 2022 16:06:57 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k1kee0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:06:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRbIvk5iNvPNcaMk/Sw8WhBQtmI/hsdj5DjvO5RPSpO/C92mgg2j73zhJ1Ga+eNKvTECdaDb0n15M4Av15gjqWVsJqRynTWnkbTNlEsHXXIMKJTWcf1Nik0DqFb6781M2kJhKxRJxOZMumG7JXTfs0XQrtrK7CcBWEEyMOIjGf2hxQFvjjA1NYU0WV2v4NySDRO9H/+ODyJcsBpR9f/X08RzO2D+rMEZe8ULGRioLwuPJ3Yu2VuCB/mACFt6w9PEhNOhoyN0H2izYj6oHQQ8kxMD/habfZCB78u/AVosbW+EK9cFmII947cu1Pjrjjm1OXW84oDf9ggrH/ESwgca/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnwvLFTj1SfpHchAOm9ayKGf+zx6iaTYkuHrwHxh2sg=;
 b=X+5CyOaoT0oSo6j3tB/9IjxJFOqUmelKZYZu9jxyEi66R63HI2TiMNwHwUtFtvTrZUQRMEamgNsb/bHF8z76y3yJ2FoTjBVcUAic9e/3aXMq1CKIN7G3VUdKkFFRU8/0p3npP5q1qAH3SmBUEAFBokKhnFjJyHDakyPEQRBzzu3bMQSXVjVd6BjM4eeTkQPKSJVmOEAuuHIjpPY3dVeVazDy5x/4zo/WmPk3wPWOxTh9Tcj1D1SRwGv/r7/z2T8muggVUT1SegtGJX23VfKtVS6a8zztZYabyj+nNN6G8tPfdlqU7xZjACNJIQIu8lod0ljimLevSNZ6xOgxkjmHoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnwvLFTj1SfpHchAOm9ayKGf+zx6iaTYkuHrwHxh2sg=;
 b=AJtEg7MfpfzppTsoGrCgy2+n+ZLPpZyUGKsbcBUbQKF1yip1qLIO5G4sZJAn9aCE2JVkcY45ygQSYxVKR+HX9Ke7TmfSOm1O7mlP4PUnRJCACULDMg/e5fnC97I8W2N9i5wMcXagBX75NfCmjsmyVsYrfMf8Po+oo6KUzfUT2cs=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by MN2PR10MB3616.namprd10.prod.outlook.com (2603:10b6:208:11e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 16:06:54 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 16:06:54 +0000
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     akpm@linux-foundation.org, willy@infradead.org
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, aneesh.kumar@linux.ibm.com,
        arnd@arndb.de, 21cnbao@gmail.com, corbet@lwn.net,
        dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
Subject: [PATCH v1 04/14] mm/mshare: implement mshare_unlink syscall
Date:   Mon, 11 Apr 2022 10:05:48 -0600
Message-Id: <378f51749fd4d0bbe303f1a1b942cf1c7f5ea480.1649370874.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1649370874.git.khalid.aziz@oracle.com>
References: <cover.1649370874.git.khalid.aziz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::20) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eeb6ce93-b483-4703-4242-08da1bd54c1a
X-MS-TrafficTypeDiagnostic: MN2PR10MB3616:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3616CB1A813E94C2B28EA64486EA9@MN2PR10MB3616.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EZCbHT7C8jPiDk01uKff9W694nwTbre27zhsXYB7FC3EyFhV0vRz1yeRSItdtV4eB3TiPQIeunF9UROiTnMDXE1X676u4nUkkBb0hHh4dOfOwn9+WzwJXtlf7GpMLYG2jJjTl0/Vnq+4jj5OwhmFJYF11wNGcPRBgztVCc1yO7FkxoVI6ldGXH6IglzuXCVbHBAfk08giPF195nDVWFUhNbH4QNuGP++poc/Rl6WlIwJLrR85XFAxmRaupmG8YVkEpkYJGP0/P24RV6wobksByhkVjRPliN7DJUMKuXxhze26B4dB6i8TtSSntFYt6N38DgNbliA7CBHK+NVi7YGR56iV0iyRlple4psWi8XKqcT78b7vUoQpq9V+lQBvSdJcPIgAgjeN36X33xymCmyy13wBA8Tp1OWeHXliIOyDrdakT7OyJr/re0o0lViduYmlOl4O0alxwLpFPKbK8xJq1A1egku2GsTb0IxYOgyxoWtMsquXfAP7gLSGw77V6aUsSLjf8kctEGpAJtEVyRAkF1gYyT1oLhzIAA3dOoZjWnmIsz+YWFY2xUJhFJMkggkLhOJsljyXk3d3MgBQ0SGonA/lLHgmVZN9YIarG+M08qoK/O7LtZ/aOmVzlrrcvqib4Frtqqb0j+EGuqmWlTnj2AZigk+Z2nUUTAOXpalvQQKzJZ73N41S/j8Uffx0pJi+bI6YRTUYsRE7xCX6tfqKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(44832011)(7416002)(5660300002)(86362001)(6666004)(36756003)(2616005)(8936002)(52116002)(6506007)(316002)(4326008)(38100700002)(6512007)(2906002)(66556008)(38350700002)(66946007)(66476007)(26005)(508600001)(83380400001)(6486002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4ED3hNPVSTW85u9XOp1AhgJIkYxrfPhGnn2cfnpCeKAbQQ/Hu2tq2p5B5BSp?=
 =?us-ascii?Q?WrsBexKGfpoy+O9MN9ys1yF0zTx6OQCbCoFhMphYwSo9xpC+7laL233aku6C?=
 =?us-ascii?Q?PM+6rhRtdzy0drVZdAvj4palAbfDOaqfPC/hT3a3Z+m/Z3rlSSRXZKQoVlk1?=
 =?us-ascii?Q?86KhbA9wQNV6XKpEXItzf9D1gHSasyi8Tp0LqvQE1HBoxFi/dY6kZPqtko12?=
 =?us-ascii?Q?ed5sKgtAOiUrQAFnR3jpEj3naOKbJ1lcXm8cPlRUj4rK5m53nNLubBe6DWBq?=
 =?us-ascii?Q?tVbhwSPnNlvs4vsJg8ZIzOfqFXJP7cjQzc3D/GT01VLXUe2MxMYBQa8+t+2h?=
 =?us-ascii?Q?4Wk3cK21/eGeKO0+CADC+dkzVCB1R/CtJwrntkcPBSs0MtsevJxdURwTw0bo?=
 =?us-ascii?Q?tXj18YRRrDtFYbv/2c+GOmMqtLPmj1WI4cKzohPkjUXHw3wchHwvv3zuzg/2?=
 =?us-ascii?Q?OBEqkSFbH/X3HSk2zObRbTlIKG0Mx3qNFqVTlxF1t6WMUU2/kRpa3rwyzktO?=
 =?us-ascii?Q?Dw7LjTnl5kvMf48JHYBlF4XvlDfsxO07ovvGWmR+HIbin4GGVMNyhJYRv5b6?=
 =?us-ascii?Q?rY/OCxgXkbGqpqGHi7QkcQU0deM4W3D4+pNis1Yw7vlyn85lSUPPhi1Zl6Xe?=
 =?us-ascii?Q?CpgReyON1bNAftMZY/yZknMbleSE0DDNGnkDAxYiFrBToYNZhyQMO+a0McNp?=
 =?us-ascii?Q?LixcIgr0wXSemh21eDqGirRAYc5wD5r3mRym0ZZ4dgQsPArDh5s+0aDBZYOc?=
 =?us-ascii?Q?6B4wzZJs4+bCb2YTue/MbdXxy+FJll4qv1nk/m9pjnYk/i4c32EKWeJ0tFFD?=
 =?us-ascii?Q?n3AOt4cyKRIVKVuuriWkHgvkTdvNLxPVYGlAachqAfLTYqTEFS37IFfH3jv6?=
 =?us-ascii?Q?6KHStI3cT8jlUd0BbXdey5e5X9qtuVT3eyKxL7Gw7YN6szIX+nryRooewyKE?=
 =?us-ascii?Q?EnSa/jF+ag+/s5K/e3UJTfH1IVpN7weDKuGltG1pCPln+mmFflqGbAcPrZcW?=
 =?us-ascii?Q?7mY+5Gur68kHJ4YHTBWX0m8rqb9ArKxkAXWGxCzkjyN3BNGbavW8Z5yb0xco?=
 =?us-ascii?Q?0KcrNM9iYGIQi6Rzq5QRScMuhSfSJpEWYCxtzCfnt2EkTwQWwZW6diomMNzV?=
 =?us-ascii?Q?/3SL5PZtGX92QbvNAEGnvY77AlbX7opniAuzON3U4SK7a5L72qqgBbwl+rh3?=
 =?us-ascii?Q?cpTYgXzd+YcatvikH1FUl3+SWrFADUyvaUm+SNpcn1kE2lBRJrkAHy+zlCTK?=
 =?us-ascii?Q?VoCgi0LdY2RfGnMyRtCzye+3JWWnuphLG5cOwaa9OF4OHO/OmklynagjUy2V?=
 =?us-ascii?Q?yg6LZK9fQpRlHwwh/tD71EFCOjyeqhlZcB8MagcmA79LzFgU/G2OwVJeza+V?=
 =?us-ascii?Q?6xg8DWMtkBRgY/LB378B5Ag4vULVefWqmCIiGBhWcdNYUl55MjAWL/tm1YCB?=
 =?us-ascii?Q?q14ARWB15uAMq3ZVANJE+yJLeBVWT8Bx58lKSDtHNxRvpbUN7FfUGJx5/lyx?=
 =?us-ascii?Q?K6R7k1ge1ciIPwjizQcfpOQWxez6M0z8BBb2aZIlOTPksPCLVJ0NNQWS/w+f?=
 =?us-ascii?Q?e6BarY9VUbZV4KarTSaoeCHcPMJw56RdGM2xHB7Fsr0qKaopA4+BBDT1s7i9?=
 =?us-ascii?Q?XO6wsCC+rWMEdK7LyilBUwbhLF+H4hEoejObfYvTbI20TtmrcYm26TCZ9ktH?=
 =?us-ascii?Q?iZk+O/8MgXDa5rUWYV31Iq6ysnmr2ZZkLE+ikWQ/0uMjaFoBOB5uiUmEEYHx?=
 =?us-ascii?Q?UrMz07NCHQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb6ce93-b483-4703-4242-08da1bd54c1a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 16:06:54.8244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRTuSL1sxDHIzmfsrYZCDRh88KVwxinpJD93PhiXFBJdWyO/kUj3KsR6Aa217JoFyil5zooBXj8pM+ZGPn2geg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3616
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-11_06:2022-04-11,2022-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=657 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204110089
X-Proofpoint-ORIG-GUID: 5ZtnxGJ7CSYHnHMbj_DkWqGjkafGSnCC
X-Proofpoint-GUID: 5ZtnxGJ7CSYHnHMbj_DkWqGjkafGSnCC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add code to allow mshare syscall to be made for an exisitng mshare'd
region. Complete the implementation for mshare_unlink syscall. Make
reading mshare resource name from userspace safer. Fix code to allow
msharefs to be unmounted cleanly.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 mm/mshare.c | 144 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 113 insertions(+), 31 deletions(-)

diff --git a/mm/mshare.c b/mm/mshare.c
index 0247275aac50..b9d7836f9bd1 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -23,11 +23,24 @@
 
 struct mshare_data {
 	struct mm_struct *mm;
+	mode_t mode;
 	refcount_t refcnt;
 };
 
 static struct super_block *msharefs_sb;
 
+static void
+msharefs_evict_inode(struct inode *inode)
+{
+	clear_inode(inode);
+}
+
+static const struct super_operations msharefs_ops = {
+	.statfs		= simple_statfs,
+	.drop_inode	= generic_delete_inode,
+	.evict_inode	= msharefs_evict_inode,
+};
+
 static ssize_t
 mshare_read(struct kiocb *iocb, struct iov_iter *iov)
 {
@@ -115,7 +128,7 @@ static struct inode
 }
 
 static int
-mshare_file_create(const char *name, unsigned long flags,
+mshare_file_create(struct filename *fname, int flags,
 			struct mshare_data *info)
 {
 	struct inode *inode;
@@ -124,13 +137,16 @@ mshare_file_create(const char *name, unsigned long flags,
 
 	root = msharefs_sb->s_root;
 
+	/*
+	 * This is a read only file.
+	 */
 	inode = msharefs_get_inode(msharefs_sb, S_IFREG | 0400);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
 	inode->i_private = info;
 
-	dentry = msharefs_alloc_dentry(root, name);
+	dentry = msharefs_alloc_dentry(root, fname->name);
 	if (IS_ERR(dentry)) {
 		err = PTR_ERR(dentry);
 		goto fail_inode;
@@ -138,6 +154,7 @@ mshare_file_create(const char *name, unsigned long flags,
 
 	d_add(dentry, inode);
 
+	dput(dentry);
 	return err;
 
 fail_inode:
@@ -151,10 +168,13 @@ mshare_file_create(const char *name, unsigned long flags,
 SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 		unsigned long, len, int, oflag, mode_t, mode)
 {
-	char mshare_name[NAME_MAX];
 	struct mshare_data *info;
 	struct mm_struct *mm;
-	int err;
+	struct filename *fname = getname(name);
+	struct dentry *dentry;
+	struct inode *inode;
+	struct qstr namestr;
+	int err = PTR_ERR(fname);
 
 	/*
 	 * Address range being shared must be aligned to pgdir
@@ -163,29 +183,56 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 	if ((addr | len) & (PGDIR_SIZE - 1))
 		return -EINVAL;
 
-	err = copy_from_user(mshare_name, name, NAME_MAX);
+	if (IS_ERR(fname))
+		goto err_out;
+
+	/*
+	 * Does this mshare entry exist already? If it does, calling
+	 * mshare with O_EXCL|O_CREAT is an error
+	 */
+	namestr.name = fname->name;
+	namestr.len = strlen(fname->name);
+	err = msharefs_d_hash(msharefs_sb->s_root, &namestr);
 	if (err)
 		goto err_out;
+	dentry = d_lookup(msharefs_sb->s_root, &namestr);
+	if (dentry && (oflag & (O_EXCL|O_CREAT))) {
+		err = -EEXIST;
+		dput(dentry);
+		goto err_out;
+	}
 
-	mm = mm_alloc();
-	if (!mm)
-		return -ENOMEM;
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
-	if (!info) {
-		err = -ENOMEM;
-		goto err_relmm;
+	if (dentry) {
+		inode = d_inode(dentry);
+		if (inode == NULL) {
+			err = -EINVAL;
+			goto err_out;
+		}
+		info = inode->i_private;
+		refcount_inc(&info->refcnt);
+		dput(dentry);
+	} else {
+		mm = mm_alloc();
+		if (!mm)
+			return -ENOMEM;
+		info = kzalloc(sizeof(*info), GFP_KERNEL);
+		if (!info) {
+			err = -ENOMEM;
+			goto err_relmm;
+		}
+		mm->mmap_base = addr;
+		mm->task_size = addr + len;
+		if (!mm->task_size)
+			mm->task_size--;
+		info->mm = mm;
+		info->mode = mode;
+		refcount_set(&info->refcnt, 1);
+		err = mshare_file_create(fname, oflag, info);
+		if (err)
+			goto err_relinfo;
 	}
-	mm->mmap_base = addr;
-	mm->task_size = addr + len;
-	if (!mm->task_size)
-		mm->task_size--;
-	info->mm = mm;
-	refcount_set(&info->refcnt, 1);
-
-	err = mshare_file_create(mshare_name, oflag, info);
-	if (err)
-		goto err_relinfo;
 
+	putname(fname);
 	return 0;
 
 err_relinfo:
@@ -193,6 +240,7 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 err_relmm:
 	mmput(mm);
 err_out:
+	putname(fname);
 	return err;
 }
 
@@ -201,21 +249,54 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
  */
 SYSCALL_DEFINE1(mshare_unlink, const char *, name)
 {
-	char mshare_name[NAME_MAX];
-	int err;
+	struct filename *fname = getname(name);
+	int err = PTR_ERR(fname);
+	struct dentry *dentry;
+	struct inode *inode;
+	struct mshare_data *info;
+	struct qstr namestr;
 
-	/*
-	 * Delete the named object
-	 *
-	 * TODO: Mark mshare'd range for deletion
-	 *
-	 */
-	err = copy_from_user(mshare_name, name, NAME_MAX);
+	if (IS_ERR(fname))
+		goto err_out;
+
+	namestr.name = fname->name;
+	namestr.len = strlen(fname->name);
+	err = msharefs_d_hash(msharefs_sb->s_root, &namestr);
 	if (err)
 		goto err_out;
+	dentry = d_lookup(msharefs_sb->s_root, &namestr);
+	if (dentry == NULL) {
+		err = -EINVAL;
+		goto err_out;
+	}
+
+	inode = d_inode(dentry);
+	if (inode == NULL) {
+		err = -EINVAL;
+		goto err_dput;
+	}
+	info = inode->i_private;
+
+	/*
+	 * Is this the last reference?
+	 */
+	if (refcount_dec_and_test(&info->refcnt)) {
+		simple_unlink(d_inode(msharefs_sb->s_root), dentry);
+		d_drop(dentry);
+		d_delete(dentry);
+		mmput(info->mm);
+		kfree(info);
+	} else {
+		dput(dentry);
+	}
+
+	putname(fname);
 	return 0;
 
+err_dput:
+	dput(dentry);
 err_out:
+	putname(fname);
 	return err;
 }
 
@@ -229,6 +310,7 @@ msharefs_fill_super(struct super_block *sb, struct fs_context *fc)
 	static const struct tree_descr empty_descr = {""};
 	int err;
 
+	sb->s_op = &msharefs_ops;
 	sb->s_d_op = &msharefs_d_ops;
 	err = simple_fill_super(sb, MSHARE_MAGIC, &empty_descr);
 	if (err)
-- 
2.32.0

