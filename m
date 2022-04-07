Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A4D4F728D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 05:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239635AbiDGDJc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 23:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236613AbiDGDJ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 23:09:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1601F8936;
        Wed,  6 Apr 2022 20:07:27 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236LpIFL004895;
        Thu, 7 Apr 2022 03:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=YsLEXwzHHuhF8Y2ubKs7WB5IRORi93e0Vmn68Bi4rNA=;
 b=NfkaK2NCMW3x6JiAe6CyDENNOARvHDPb02I5fwoWxOu6QfcjwiXHY8Xrx4mcDWkinikI
 6y4iSHee4zyBe8QJm5tGfgOkAj83SF9OykxjXn7vNSW2mJgWYrf5/fUSzDfg0XfmCs1J
 +oAbW8F3tDhDUqTy+eCamQ91BX21vJ4MJB4EGZR8HynPhZNqhlYoDA/HLfQDBP+Bo4CR
 x9rTg/eQ+/XOfhq/Ik5Mn266beB4VlXnYt6pQZmsHu7vA+BBuG6FRivVgrT/mpZl+pEH
 mlVBoOLNp7A97wLDUSOK5yHa7XAT643O9e2NZAIcfD0zc10YNOs0pYfWr7nlIIE2mlT4 XQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d932m5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 03:05:19 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23730Wj4013140;
        Thu, 7 Apr 2022 03:05:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f9803h1d3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 03:05:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pp4OarTXw+ZWc+bEDRdAMXK755D2xX211YX+owPz9Du0TAvRUTo0JMux+A2OBM8Q2RUIis1E841+yCJs3xSxOmManJFMNq/HKUK46nW4ugGIOqLPGPgQd14A1tT8dQfZlck321dug3Mlr2oaMTCQFvDd9E0upVxo+d9LhdX4SwQT3T8h8pK6k6iRAaCjv4YL50Q0xnldBeKAjs11+DaPoBl3CCRMJKr7fmlIrDoclgTj6ihaJnWuAbqLIm7qh9YvCfak7EPF5C9DPbF1lWENUC42C9Z7b0y7xOYJ+PhU/FYlCF6pgrdVPLHHqR7SIoekmjE054OxDImP2k0DAwej/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsLEXwzHHuhF8Y2ubKs7WB5IRORi93e0Vmn68Bi4rNA=;
 b=MJpc+Q7Ee5f5cXgLArRFIO4GyTTByPQx/d+m/IktmZG1Q2KjRsf3Svl5A68hZNXDF7kpuKr0pGRYjRw0C4XD7EoN0n07HUtxAO+b5dM7h/Uz6tdrf8b4he6u5lJlRmKgpr04K9z+au2MRXr+x8POHZP/ZqFMZA1PvWr7ZZXtfD3C99pZ5FRmFQM/9TdsrBDSlVYpU73UGohcFQJ3GfN9i3QL1W+5s2ONRlUGdyHlytwDfgucSyTx6OZi/RwSYs2QdaJqUc1nlht+1irrCCn5KicE7KDAfgGur/oyN7PP7VCj97AuEL+jFJAmbHFPbZB+igWeXGiRoFpF9eKUVY46cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsLEXwzHHuhF8Y2ubKs7WB5IRORi93e0Vmn68Bi4rNA=;
 b=nQ1EV2Z2MwlvkJGlLAO7iFJYI6/mpP6qHesyCjyJNkoNah/7fILGtoubqQmqI1YcRdlyln9Kt9HjWF/h9c7R0jKk1BKfkc8enXMa4DreRin9+h1VJ4fFvcD86VOH7JoEWo+TzBXyBlfYYFG+s2hxLrvDcOlC6vYzT0JUfYneq2c=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY4PR1001MB2152.namprd10.prod.outlook.com (2603:10b6:910:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Thu, 7 Apr
 2022 03:05:16 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 03:05:16 +0000
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, jfs-discussion@lists.sourceforge.net,
        linux-nvme@lists.infradead.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        dm-devel@redhat.com, target-devel@vger.kernel.org,
        linux-mtd@lists.infradead.org, drbd-dev@lists.linbit.com,
        linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-scsi@vger.kernel.org, cluster-devel@redhat.com,
        xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org,
        linux-um@lists.infradead.org, nbd@other.debian.org,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        linux-fsdevel@vger.kernel.org, ntfs3@lists.linux.dev,
        linux-btrfs@vger.kernel.org
Subject: Re: [dm-devel] [PATCH 01/27] target: remove an incorrect unmap
 zeroes data deduction
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1wng1k2zn.fsf@ca-mkp.ca.oracle.com>
References: <20220406060516.409838-1-hch@lst.de>
        <20220406060516.409838-2-hch@lst.de>
Date:   Wed, 06 Apr 2022 23:05:13 -0400
In-Reply-To: <20220406060516.409838-2-hch@lst.de> (Christoph Hellwig's message
        of "Wed, 6 Apr 2022 08:04:50 +0200")
Content-Type: text/plain
X-ClientProxiedBy: DM5PR07CA0068.namprd07.prod.outlook.com
 (2603:10b6:4:ad::33) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 446c5253-2f86-4e5c-b24c-08da184370bf
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2152:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB2152E05222F1BBC5E98158F98EE69@CY4PR1001MB2152.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /nK5r/MuRnz8ktLCSFU22KjRIztZG5J+F4JDyOjXsdc31ie4LJRCbfsRVHM01SOjoWooWtF/OnruYEf2sJXIEJue+piPjYr79bmJhLuQxBTBaQMOegKNCL9P2RvPOPpM8gfjxEr2yp80dF71knzsUCiBPN97PDjwemHuidm0+ofeUYw32YiEMBOy+1Iswc5HiqLGRnNF0e3b6Kc4eUmHS5wX2i2DpHYidv4jAIaSRvP/UhzP3/8X+TMW52/5lz7HRoqyi+sOrCXAsCpWuXfg/E5nkUNHBjyV4ftC4ywCqRzk3NtYhWbzdvu0h+jV5tT9PvegMNvV8rz9qOzTy/mZcIGQ8D0GMCS3y0XjDGIJnAO1ORk75BbzU928Z1XBN6iT1tS/rKgnjO9Ql8iLGFulJ/lh7kVVnbOazr4/rqcL+YEoNsRgPBL02Y95X/uBSe7ksFXUETPP6a93DCohbGGlDToepS4lrXNrU4ROpdJoK55bybd5iNINiXPe3iivRayOLl6+iGGxfChhwp9ku/zix51NXgP9T4nGMBQ6OTYoMYhKm5hcti/urkEGQOejQc8TFc2MKf0a5e/IusjLKxQksMTYESwPmzNuRnrIgR0MIGkNtfxCCxtk3G2DtlJNoyCblF0gBziHq5pkVPTHzLnkyYZSvfhYWtCtSxeacZo2xalKWfaSiplfVJx53owNYdHAAejIzZINATBpKhooZ+F4Vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(38100700002)(26005)(6916009)(316002)(186003)(52116002)(2906002)(6506007)(6666004)(66556008)(86362001)(7416002)(508600001)(66946007)(8676002)(8936002)(66476007)(5660300002)(6486002)(4326008)(4744005)(36916002)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qY1nBGMXTuj8DG81dMRc1M9V4GVzuBIJ9qlOqc0uEdupd1bv+wCC59Ok6bo6?=
 =?us-ascii?Q?xybN22YVd/YDX8pGkxRCTpNSAXeh7lEoIdjnKlD4FPDjd1Q/zUsgbz5nMYM8?=
 =?us-ascii?Q?ITgNiQBp3NFaZGQCH225g0rN4jvLRSrMbzrlQ1xNMKU/mw2v54+/JIO8KuXG?=
 =?us-ascii?Q?Ivbo2zsRUjQQ4GiFmEtFh3YswKW7gJqMaRHsb9UcYsfregBwGVUrDiqZxBM2?=
 =?us-ascii?Q?ZSTlD0veR8ee7l0+5ApD/bKF/A/9kyzPsB3OusFL8ArYkHJfgCBJFqbfUuvr?=
 =?us-ascii?Q?t2lClIH4fAcA/eivwaSfLdMv7MEccMoyc2BbqUCvwG1DmCVjdjclfmwAkipO?=
 =?us-ascii?Q?3cVkfQRz8YKcbBcMV1KRP/DTMct+zBYnFNpfNy1Qmu27R8foSFqOKBVouGru?=
 =?us-ascii?Q?ydHGK86lkXLIYlfgwAtlU54MpAwHPpbVGHexsYhVbhXFm/jv1Rox725aNt8Z?=
 =?us-ascii?Q?KWzLwwQMSFGclLUtjLxxwuk3VjPY5HQPq02436NzC6gE5QTAUJH7PAVReXyp?=
 =?us-ascii?Q?d7iS93ChD8r2pGPAW2Q7cV8HeCT3GZR8cP9/5sLujMHhYrIwuJ0JyRWQs2AA?=
 =?us-ascii?Q?S7WO1oE7n00OGyZxnzbPhh86u4clsYw7nu+zWEccbvkd3H73a+s55DBdhBsX?=
 =?us-ascii?Q?EOSm3vUpPdWqd/NFB6Buav//MlAsh1j0ZetHi6J7XNmG3MCK2Ypd/KLkWxAQ?=
 =?us-ascii?Q?a9JJtEKXaG44jB8I6cCApuB5Evi/JP6sDm1C2LHDGy5MPg1jOeU1NpYahRbs?=
 =?us-ascii?Q?BZaDVmD3jyJ6H+SXWlW6MyKUScTXOMH/E8C02jCKsizLJbM5dOaJXCtJjp0t?=
 =?us-ascii?Q?ocGw9J1Eb7HZ+X3pYDM0/GO2ev238mT65vcSA0MrvfeeTKVuByoBoqy+7GJT?=
 =?us-ascii?Q?9I+REuB5mK3DT7ngexEU0TSy/hk6IDvbjLBPBEV8ak75ftSp40C5v14WbuvC?=
 =?us-ascii?Q?p9XcjGOhncF8nf1NCaLAY7wO9zgOnk+DzCaUG9pnt2iKGS+x12y3tFeqyupG?=
 =?us-ascii?Q?rlNVlp41NrsO2WD0Dj38OPI/CmJX+a/V3QxYrZs2pzCxwUxBkaS16BYJ19gs?=
 =?us-ascii?Q?utAJkPO9UcbMD1+p215yuOrF92OGRwnXIWUhWR0j1jnarPXh8Rx1g6WU5kIw?=
 =?us-ascii?Q?o6D5qM6yCgzqQS4ti8CR3a7YAUU+5K+Lur1IQbZ0jZ0UNcYqVAiRb0j1EDB9?=
 =?us-ascii?Q?snHxE2XKWTJ2Mc9tza3YxNjH+GoOVSmXsYmD/HLDjJ2rIDVtDmwZIuKlFStA?=
 =?us-ascii?Q?omkqKxn9xz8TAkZMov+tIAv3gSUfwB5k0yQH/9rv/TBeVR4K2/YqKhDBQffa?=
 =?us-ascii?Q?HgYYBLKVuV6ceja2TdZ/CiHIWMujNH3OPXFFfldRfkuoslxSbRk+AFl/0nul?=
 =?us-ascii?Q?bEYpvSqdZTuzCkhL/2DBp/sbtQHmJ1NkWMfGzA61MWF1wKm83Y36Nsrkqf9E?=
 =?us-ascii?Q?o+E8ycTJrFoj0R5DpHdN6kYroViJ50Gz89cLuSVSSDfXQc10hX06ize9gyU+?=
 =?us-ascii?Q?/ZOQYRwRDYL3DvU4idJibgI/zufed0BUnXDaI40FReyrrjtz8aMUU5sjQQEy?=
 =?us-ascii?Q?iUXFTa/BX37Lp80KVcYTfRZjxe1N/PeHsQwdyGpPuGOQjqHIVhWZPyD+I1ld?=
 =?us-ascii?Q?8qv1/Uxosiz61rt1qgrjx2Rcvox57kV9ZCsNKzW9mdJtSBiSCDurcEV+OILv?=
 =?us-ascii?Q?wHo9IC8tCyj7fQ3lZr3yKFe+94f5EPtGJDq5xbOz2yiALz4f+quYstOYI+gE?=
 =?us-ascii?Q?JTt78DP66djTrkit7F/PPtKpGwvCvXA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 446c5253-2f86-4e5c-b24c-08da184370bf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 03:05:16.1549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wd1AdPWpIjcCjxsi2pbd+ciWqzHOAajRxs38iCvhynb2Xri9DgaS4+iigUZuPE6wN79jbNBsZ1lsFi5zU6X0feZ+MmPZxgDmebjEXCo6PI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2152
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_13:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxlogscore=953 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204070015
X-Proofpoint-ORIG-GUID: z327C3w_lmDACCGlZXgN11Rpzh40Eu0h
X-Proofpoint-GUID: z327C3w_lmDACCGlZXgN11Rpzh40Eu0h
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Christoph,

> For block devices the target code implements UNMAP as calls to
> blkdev_issue_discard, which does not guarantee zeroing just because
> Write Zeroes is supported.
>
> Note that this does not affect the file backed path which uses
> fallocate to punch holes.
>
> Fixes: 2237498f0b5c ("target/iblock: Convert WRITE_SAME to blkdev_issue_zeroout")
> Signed-off-by: Christoph Hellwig <hch@lst.de>



-- 
Martin K. Petersen	Oracle Linux Engineering
