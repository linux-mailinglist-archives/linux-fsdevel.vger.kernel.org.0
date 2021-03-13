Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BE3339C51
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 07:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhCMGHR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Mar 2021 01:07:17 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47510 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhCMGGh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Mar 2021 01:06:37 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12D64vW3144106;
        Sat, 13 Mar 2021 06:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=JwYb7acamJNfNE/BSj5cWBj554BgB7YMlGm6qCT5KnM=;
 b=N9xTf1VozvZSVeCRUBlmJ327tMq983JodHBROVCjwkySSyLFEm8ALwSx1FdMbCpL3WzM
 2Rfks4nk9GktgeLzn+CXkcAXVWC+f6ZMdbAEUIZ3SR9bnpwqBvU3n5ebZuG6EzoCApGx
 j97ZA6V1h62tJgqcWjAiywgR/fJb/eDcr8d4k8WPd7Mstf486pBO1RWMc/4Sdra1R223
 eQc8qm0jkkbdc+NAhktnjTDMsInCbcA4ivy7bVPJmJ81if5B/pY7Sm1hdfj9dgO71kZd
 hutunWz5PES1v1khhVYR0sOaiIw12dDOXgeAUrbaExw9Zj+PSZHZ5LIaLO7h8MeyVXYn Ew== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 378mtsr5ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Mar 2021 06:06:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12D64kwR098158;
        Sat, 13 Mar 2021 06:06:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by userp3020.oracle.com with ESMTP id 378mqj870y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Mar 2021 06:06:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gewj6Irr+w2ZKPSa5JqfPn7+Hh0pFTrRAfiFDwWXwISuFY1wMZ2A72XNxCWPl2dQL0IXgLYRh0aRjiag1vVg3evpODHNa/IiW9E3e7LdKNdu8ahpE1BhyTTXYGbOxoYMAFpfLnYjT7EdzpzILLW7gxbFzsKDjZuTTX6dtTz7x8se8WtQytbTGzTqK+oc8pXSkMjdbRMqzvtp7Q2pMY0WOGYO+DjGefk2BZJ6i/B44HbRH/A4x5CG7jPT+VgGOuiUwYswU5hheR2kMPQV1JknxkT/RwSeStmAgsvGP0wZDGPO5VKKYtakzw7r/7ku1A1j9KrB0Zw9xqJKRQPM5ENpEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwYb7acamJNfNE/BSj5cWBj554BgB7YMlGm6qCT5KnM=;
 b=abSfgewqZAfpMLNSQFAWbtHpT3rUKEXFVsahcxPDp8NI9ayo+mnQFkl9Hhdtfzk/kz9uBEdYotWhA4FBAQ9HVeVeoBni/dKNHxZWYVdrrgRLOqFuKzmLtU2jnbDKV6o2iTreXIhgsjM3GxYkuG6pmW4mruaeup27sZw1044YoAQpt8f7EX8Boa0CbWYRxDjcNIzcPQWqAmvweBwFMkmeY4lC8kvV1VRmEHoAEIw2rnB65/GRLWU8oQb/h30+eFBFs+/ivz7T+DPy/TG2PnrF8qR0Hyu1xwaqkIFs5RZNQzyMtymkhqiworQKtlDeuG8Lu6kztdkBXAcIZlS7srLwxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwYb7acamJNfNE/BSj5cWBj554BgB7YMlGm6qCT5KnM=;
 b=VNV4vRIyGX4P3/y0Mpimo3fuTQv142mFTyDBg1S/AVj9HC+xVM33Kw19LWQ5sGJ0C0tIOA4dG4FvUqYaFHg15JiM4KuStv/HW7P3DoOoHLDZf+oeVXWz1dxR0tp0aEyP38iI+83s4RQvyGgif/qAtl+2SVSgPHRvRe5yJmtvSFk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by BY5PR10MB4132.namprd10.prod.outlook.com (2603:10b6:a03:20b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Sat, 13 Mar
 2021 06:06:25 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::21a6:5c60:cd6e:1902]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::21a6:5c60:cd6e:1902%7]) with mapi id 15.20.3912.031; Sat, 13 Mar 2021
 06:06:25 +0000
Date:   Fri, 12 Mar 2021 23:06:22 -0700
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] include: linux: Fix a typo in the file fs.h
Message-ID: <20210313060622.dwfiejfxz5bpembl@brm-x62-17.us.oracle.com>
References: <20210313051955.18343-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313051955.18343-1-unixbhaskar@gmail.com>
X-Originating-IP: [129.157.69.43]
X-ClientProxiedBy: CH0PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:610:b1::28) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brm-x62-17.us.oracle.com (129.157.69.43) by CH0PR13CA0023.namprd13.prod.outlook.com (2603:10b6:610:b1::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.10 via Frontend Transport; Sat, 13 Mar 2021 06:06:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05046457-00b5-4787-6579-08d8e5e621e7
X-MS-TrafficTypeDiagnostic: BY5PR10MB4132:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4132F4875F501E8DDF0BFF4FFC6E9@BY5PR10MB4132.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dc1n2pGj0Mh1xfOmROvejTFnhwgTdo1O8dufCSc/r/SGFDpQMl6cwZ0qZ6WKXQzZdVGjgOwU6oe3qrEE6SVHpiXrLkiFdH098myzmExIaQb89/ijNLwpuK5gpPV9Vy5RE+m3jb4nkYf4sZT6oiR4+Jf7gTJxLtdpZwLvDtdpzUIPywJptHl8VurOxz4/JhPvjjxUqgivHBFJEYEe+/dk5ViShia+/VLsOqijd8tkaC/dc3fVWyHkuzSKBav7AKy6C5K2xKzj08SZp/FCHDrGykI5ZUc8bVrfPCxZZehTcZhvM6PsOb/ScDoiQvFoQSsAkHqmtq1I0GIiHUtxfS+SXHztGpkl30VWON7QpYYf43N1eRyHk64nBBry7LT/0KNG+WGu3GzDvXu7qrF411Ce9eBMoL49W0CIrv9rBWYI8gfprLRqexQ1tYJib0NkLFnb0s1qIYq9u4RvWfSJPFoPG+1XqvMezK3gPLyJa8kmmwsBlasLVE6kFbz1YWx8LZSVTkPMrtELPT3Gg8d/gs+M50A5pKg9X61Iqbx59TxMoiJLGCMDhOGjeNZOLhC+rLJ3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(346002)(136003)(366004)(186003)(2906002)(16526019)(1076003)(86362001)(44832011)(316002)(478600001)(4326008)(83380400001)(66946007)(66476007)(52116002)(7696005)(5660300002)(8676002)(956004)(8936002)(26005)(55016002)(6916009)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RTfYs7U4pvJ/BcFEBfAb9A2+P8tgHsyO8xrIJ51qDnstEgUj8xekF/H9psIr?=
 =?us-ascii?Q?+qdjBJSGdy7R/CW+wJpIQa0UxNlK2fk9Rem/qcnDpXBPgdJEn/V+92qP9xqg?=
 =?us-ascii?Q?T+8datkyMNrIFUiQQQ23ythoIQT0b8tYkMBNjjwc0TLsIdVGDsiUn0SyQjbE?=
 =?us-ascii?Q?aORHeMhtNaeCkxSyX6YHXrg1FzOCkKP0VwIK4XtBxnijwm5EFCGbMfzFfXrd?=
 =?us-ascii?Q?MRpEW2vW/FcQda12mDAYKo5J56gbMnSVHLw4PnnTpr83GAhMwo+Ni/ZCrkfC?=
 =?us-ascii?Q?z51UKO1hxMECFozJG50zcZvC1SlXdxbsWfRs/Wlsr1dGDnxSgQY5EBl7Skrq?=
 =?us-ascii?Q?LIW8yoVIi93gA7M3knAZl+MBk3yieISrtuT1/qrnkMINImBV6DTwjuchxZrz?=
 =?us-ascii?Q?PxgDJ5OiCSV5rfSdb6hx/LTBsfjGdMgkIDt6mmVP99EdDra6F1iCXCvA6qqd?=
 =?us-ascii?Q?hQrWkRpw6CC1EvyjondxpzI7RAoFc6ktmiIpblQdJLwyAg6ovTDlxzf1ie5P?=
 =?us-ascii?Q?du7Mw7Ip1E1TT0qHTroiWK7UkKIgab3NBlnScaNkEzsIKKjliRlpEMDEEVGN?=
 =?us-ascii?Q?l7lRbycw3tq81wGoX4nfWOZj/nUYVoDYc52GDEaAmOKdWJ0YUAs3t/NRZBE7?=
 =?us-ascii?Q?gsvPA6RkNPYPznmaH/74dsR/+6m9g6+C7IuP8edCChN52BfFt5KTtBa0pUep?=
 =?us-ascii?Q?FiMLUcj2hHJS9hNknrMdfecchtyZ4e8BgBnm2JRLsDaXLlvLGhEif9kiRir2?=
 =?us-ascii?Q?ITWBHvyAMOBhV0OJpCdyk0rHC2vhVGdT28rlcfE11HJEmb6wFVoHysq5aaHG?=
 =?us-ascii?Q?0Dr/G8+MDSzzhgzEohbNTKkP8Xg6uoR/yyq9S4a9vVQn+/XmsN+4U5or89lp?=
 =?us-ascii?Q?cAFXlHanv6+mI0xJA5dcugA5GGqQv4PlqmogA9d7Hta549XfON9WkzUmB0V/?=
 =?us-ascii?Q?GB7xyLPiXa6VDkbmU09ZF1XFPLJI5hgbHkltCmj8KF9hAL/uBStc1/tqf5QG?=
 =?us-ascii?Q?WnqHKFoTfetIFeju0hufNlkXgC7m7opReRiYMfqVUWgQswJPUHQS6gVKrQpc?=
 =?us-ascii?Q?CG0y1ISKaQHsbqZGekrdVF6xVGUkkWSwMENS4wHIOzmWuvDwbQPQX6hS3oXi?=
 =?us-ascii?Q?Ph4ph3Jb/htcDoFXIUNo+WkDPZaf3lgQhAtA+8fR9srl752c3Maeodt0i3yn?=
 =?us-ascii?Q?qQYR4Zft4r1w0GtPaJS6OEIJeFF+CaQ50YrTZCgJIHid9Pqw6kMtG2IA4Ubq?=
 =?us-ascii?Q?EPlSkir0USvbSv3IXriJmpBpaPDJbNzyKPsCbc5pawCnEQPlNGw1nBT9p00x?=
 =?us-ascii?Q?PsOrZsqhOBp3m0EOV0m3dPsI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05046457-00b5-4787-6579-08d8e5e621e7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2021 06:06:25.0564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BA2lXiw4t47xniyxpSoaDegihjfuatVKvy8fjZQwsDpVWUaVL4oVDk1fWQk7mT6MPjei2i9Q2dbbsI/zhcIxtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4132
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103130042
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1011 malwarescore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103130042
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 13, 2021 at 10:49:55AM +0530, Bhaskar Chowdhury wrote:
> s/varous/various/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  include/linux/fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index ec8f3ddf4a6a..c37a17c32d74 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1051,7 +1051,7 @@ bool opens_in_grace(struct net *);
>   * FIXME: should we create a separate "struct lock_request" to help distinguish
>   * these two uses?
>   *
> - * The varous i_flctx lists are ordered by:
> + * The various i_flctx lists are ordered by:
>   *
>   * 1) lock owner
>   * 2) lock range start
> --
> 2.26.2
> 

How about a few more?

found by running:
codespell -w -i 3 include/linux/fs.h

'specialy' could be 'special' or 'specialty'
it can be dropped altogether IMO, so I did.

--Tom

diff --git a/include/linux/fs.h b/include/linux/fs.h
index c37a17c32d74..9ffea695a059 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -126,7 +126,7 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* File is opened with O_EXCL (only set for block devices) */
 #define FMODE_EXCL             ((__force fmode_t)0x80)
 /* File is opened using open(.., 3, ..) and is writeable only for ioctls
-   (specialy hack for floppy.c) */
+   (hack for floppy.c) */
 #define FMODE_WRITE_IOCTL      ((__force fmode_t)0x100)
 /* 32bit hashes as llseek() offset (for directories) */
 #define FMODE_32BITHASH         ((__force fmode_t)0x200)
@@ -819,7 +819,7 @@ void lock_two_nondirectories(struct inode *, struct inode*);
 void unlock_two_nondirectories(struct inode *, struct inode*);

 /*
- * NOTE: in a 32bit arch with a preemptable kernel and
+ * NOTE: in a 32bit arch with a preemptible kernel and
  * an UP compile the i_size_read/write must be atomic
  * with respect to the local cpu (unlike with preempt disabled),
  * but they don't need to be atomic with respect to other cpus like in
