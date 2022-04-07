Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E43E4F7370
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 05:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240119AbiDGD1M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 23:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiDGD1H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 23:27:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8634013E14;
        Wed,  6 Apr 2022 20:25:08 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236LT0rb006378;
        Thu, 7 Apr 2022 03:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=nG3sI1771Qzwkix+7woUumXPeYpDKLLcIMXUM/nZXzc=;
 b=uCX4EVIMxM0btfDpTw5w1ew9bFLCrQilscmuwmVdRolfLJunbh9KT5j69VKpBFtOcJAq
 ObSXwXW1pjDG1XcmTA2ht9GIUnTTPukHcg63rNhtrS2pFvtUQU30jO65uVjIMPB7TAQ6
 M3z4ik2IbLzB7K5bswElc2TQSorNj2XqvboFkJ0QDgkOI0JlZpNXTZl+3TF/DJajXHTk
 8hGfsTiGys+WFrXr7iEbTTgcs7X+hTPGSqmMwHaLtKUw0KaZroaIflimn4O+OXx2aqdt
 +19y5fxddpLswZXH4y4t3+qmqVkl+7EYZAckUFjvjawOty9JLhF6oHbEW/rqImOgBjYX wg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d31jpgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 03:19:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2373FNjt015384;
        Thu, 7 Apr 2022 03:19:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97uwamrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 03:19:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeBKK8wmaZsO7X3MKYx+cP0NIPwThePF6OgXJN9eJjYoE61Ca4WnVWzIwon8zubWcc51fCiKIAGJSKkSzjZCtm5P17mKoYzyB4BoiSFE6XKPqGAOgECn02zjz2LUBY8b3E5k5E4qnIKyVuAGLsNHK1OvU0JmBlsTlHOldSr3QX35N4yymkcoK0qst0GvuOXiT8frduCyt7L98xkVhlwvH/qKrXsxZ9/tx1xf31n5NpJUXbVZTTaKva0ddlv9mfV5dr6Ytws0KDwQdNOuM4vLSTBVKgMtOMb6hYDc4gty4PCc2T2X1AHrUzduuYEDaEIW7Q598SWBEf39o4wzICLeDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nG3sI1771Qzwkix+7woUumXPeYpDKLLcIMXUM/nZXzc=;
 b=HmTg0RJy+iXrkjtl8lk00eiOq9/L5QrBz53uyW3z8WOBU2vYWGSFPClVCOoyp2qO+suBKdLX7aLJli/Q78jI9t6Ljxlu+TWowrUT+EXK8J66dshejZRs4BpvqvY6i+bPgkH9oP2H786SoQur+xaLRkxhRXb5H0YREIVWqPszlXHch6VV5OVjoK47O/Rn3Y046HldO8VzOedNF0qvCfluPlJRQt9YE8CEQwVJUmwc6cq7mlYu+BweJjAh/+vkBLEuq2H+L9pz3mbn5i8tgl8hpqTP+OAxdxoF5m3AuvdLj4vwW7y3QQK0tovhaynkwK+86htZ49Kx8HQYV85u1R9gow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nG3sI1771Qzwkix+7woUumXPeYpDKLLcIMXUM/nZXzc=;
 b=MLUZOxgb88Mde+78DEy0UZP5WVFusHEBbq/vjQIQIR8r4BS5W6s4Q8aQKGyXqKdDq+YD3vkzyihq8zM4+GZd7fMViQopAcLx4GHajrlD6Rr9AsisUc1bzBPWRbjcOU4KxtbcMR1Cp3oF+HFP8EV91//bwMu30rzG0ZlARgkOTv4=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4408.namprd10.prod.outlook.com (2603:10b6:510:39::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Thu, 7 Apr
 2022 03:19:37 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 03:19:37 +0000
To:     Christoph Hellwig via Ocfs2-devel <ocfs2-devel@oss.oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        jfs-discussion@lists.sourceforge.net,
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
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-btrfs@vger.kernel.org
Subject: Re: [Ocfs2-devel] [PATCH 15/27] block: use bdev_alignment_offset in
 part_alignment_offset_show
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1h775ins6.fsf@ca-mkp.ca.oracle.com>
References: <20220406060516.409838-1-hch@lst.de>
        <20220406060516.409838-16-hch@lst.de>
Date:   Wed, 06 Apr 2022 23:19:34 -0400
In-Reply-To: <20220406060516.409838-16-hch@lst.de> (Christoph Hellwig via
        Ocfs2-devel's message of "Wed, 6 Apr 2022 08:05:04 +0200")
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0018.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::31) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bce8477-072f-4601-b4e7-08da184571d9
X-MS-TrafficTypeDiagnostic: PH0PR10MB4408:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB4408DAE994838FAB82473B3E8EE69@PH0PR10MB4408.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rjpbJIEZKnNEYKvuq6mDkATU/XSk8rTGWhmb5BtdQPXIoA12PnI264xUaR/rDlDVV+WBKqN46ZTvSslyjx+vvmVSavnTq+ToxU/lxZ7jwCM0jkRWS6565SYeRh54rE0dFknk774nCe4mFT4kxRJW4rISoJXfX4c8wbJoGp5v0wwqcH4JU7G16moP4wWn9rWOgIRfhBOwB1LuA93pH/xGSMRetF1bgbkziL9/ygQxpSE2uajI6pdYtdcdsWew1l1pv+/fFUO2zbgoicMFfsPWtx0PIki+XILDeVGZPwdSUDq53Fd9tapAqcEp3loBIjdMBb0UfTAhpnocXc+W1qv41QZq7+7KAI3lm7/gSmaSnoe5hbPZ07FRqYyZZ+/LLYsdG07rCd/VneFYYEDDvdulWVadiEsZ1wwRHndYdGyLL9xu6nplKlkJOnf7dL+hxO30blOO8AaZ+lOyBvqvLtDlXoiA/lKECDGrvAMWxiwtERcVPjR8NemBDXP0SX1oEjx5mO6URk+lR/Bmk59yrbCZx6fJAPMgarBNWzL1JYJm5UiWQeTg7a617m/3LT9d7lMH4LIBCNZ5iVN8sAtfq8R98eSBqPm/0FfXVV5CJK+RrC9qgdZshBuqRT9cViOcWQ3xitqcvP5D+i9t849caJMnshXNcwMAJkpJzA/DidseX96z/rOISWGxyab0giL9dGjWo6ZwK9hhF4BQqMVVo/PSYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6512007)(26005)(6666004)(6506007)(36916002)(52116002)(7416002)(186003)(5660300002)(2906002)(8936002)(4744005)(54906003)(316002)(66946007)(38350700002)(38100700002)(6486002)(6862004)(66556008)(4326008)(8676002)(66476007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?otwK22u1FQL4H8p4tyeZC62SDKzQ2319TBwKD+0F5UmNPrBHHS4u0L6o2rWr?=
 =?us-ascii?Q?BdCuYhm2AiMo3Guj0AFAfewm0uazSezzFtLBMoDvh37dzt9lc99kNXH42YmG?=
 =?us-ascii?Q?ZSOeXycw6UPgFnYE6VQgzHH7lH3/eOqtm4S+7aSyK46h/AcoCl3LzHDZCjaN?=
 =?us-ascii?Q?FuVSwD8zgeOJ609VQQ62zQTPwh7+dVjDGpRojU38wJ6rZayrpeZaiSFbDq32?=
 =?us-ascii?Q?51kDYCIcVO23CVaL1If2RP3KziQzQJJ7M2bfk+ryCErPwZ6RaRj3wBcsnGVJ?=
 =?us-ascii?Q?yTegiaDAdy7fdvUVede7qNpal791NbXn4OQLOtUlkkft0eaxNhK3ZxmmPFzn?=
 =?us-ascii?Q?JTvm9ej/6pdqBL++5RATxdWTz5Df3z7J36ASOTWjjSkf3BcD6w3q0WS2AdGI?=
 =?us-ascii?Q?Z4AgqeeJTg2vkgjjPirXv7k+OhpowPR1tYlMG8NgliGRt8bC4IZvCwhXV1wW?=
 =?us-ascii?Q?R/LTR3xxNRo4hbqR7vrryQ8SM4Rv1kkBRQT/osU5Ivyw6DvQmYWK4GyvJnJG?=
 =?us-ascii?Q?/lgi6zxtBkpFkT4q1TLIbh7U7rh5KKGhEXtY51yjGeDtUfttvijKRI2xc42j?=
 =?us-ascii?Q?xN8x1B1zwTUTQkjePbxXhue3+JM1JcU+s4/EEOGl97MPxKpTI6PQvDmk8ILT?=
 =?us-ascii?Q?Jwcl2rD1xnpjGH4wXKOYvbvcpEb231x5hMBtbKQY5r/1/o1L6WAgwSSJvTNF?=
 =?us-ascii?Q?lOMnsIAAOBDMhVAqMCI2jOOcHbvxza6bSQ3NGQDXXbap6X9Y28Yyq3x2R+86?=
 =?us-ascii?Q?hovdBD/ZnL7xvGIPx4XwCSjPCcTet5+DxbB2FigmjYmLS4rjelW7V4d92EKP?=
 =?us-ascii?Q?CMW/91NOnWt1WqDG5yIOhQzcPdOws67BeoQM+gzurxCfVJMIY1kEgJfOnNkE?=
 =?us-ascii?Q?iyEPLhPfEzU/4SSEfYuMYD6kXoyqabl6TvbCovxQNHKTsZzZLlAWlF+LQbpZ?=
 =?us-ascii?Q?6v0Jcqj6Vv9D/fA1iZb9gelZYTTPNSLgtTeNXAOqI2UUqxe9RJHe4FF9lMEn?=
 =?us-ascii?Q?f6bZwNxMFFaaWHcc5aIFbm4+/sLXNDHqd+G6w/ywQLHZkJS6/Vu/k9e3xDoT?=
 =?us-ascii?Q?vug5WuyJo1lnQLnmFheQnARNkp4HeYIL1FrknslxhA6LQh/erpD3tNgo7vWg?=
 =?us-ascii?Q?JaiMvKKEhrOD/380Wb5Tf28f4SMOfOxKY9yVA4zLUcSA+rJx8AOk6aJd93Gl?=
 =?us-ascii?Q?DhNlK6OF8RnPjO9kkOo3ZPl3THdemigQ/7LL78QGlJA16s86an2DvDtD6Evv?=
 =?us-ascii?Q?EJAb7zDdA75RTRClkeU26zUQAd5UThlOw9U3jtIQTs/q3glc7vV+yHYn5FPv?=
 =?us-ascii?Q?Bq+sX52pOI1xJe4iWkfI5cUtiVSN76XMUiOrrGM4mNg3vJVwMFVbIzFCuB4Z?=
 =?us-ascii?Q?TXzp12MMNRG3rY7qCXW68s4Y2qtVYMBKFq1n4Wbxgk9HYe7CweRxtwcrl/TG?=
 =?us-ascii?Q?U10IlZXrd8kLdRypfjaEHhWwC/Bd28fJQiwa8rA6H6c05wB9OjRU1zyRJdgi?=
 =?us-ascii?Q?kww9ah519h8AE+kusJ/kIpzmR8+JaGwjhtORJIVIdgg48JPrg30buPZ63isM?=
 =?us-ascii?Q?fan3VsX71nsFWugPDz+MtxzpBMIFUALk+fjCLUzoa4ZQF/zS4h71ssrIQKDY?=
 =?us-ascii?Q?4kKJG+ghbLVRph8/80wYAQ6ZC7zyPOwMMVCmqVHfL/jaWd5oG2QLzk8o0wos?=
 =?us-ascii?Q?KaDNz3TI/FIAjzpDKo4lo8K285eBU+6L4CijIqnP3JAaf1HD32fV94E6u+OA?=
 =?us-ascii?Q?JU1Rv4Xgmgi17AEgwLo6SNA7cxvmtLI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bce8477-072f-4601-b4e7-08da184571d9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 03:19:36.9967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7z4HIuRW5zOTYnm/hMTpO4vuTWv+jkeYUlfnyT66exez8dXOJ7CIITksd8DVeQqY0+uYHTF7JUR/z8AslARHH0hcSzhm6hezqxwsLgDYqbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4408
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_13:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204070017
X-Proofpoint-GUID: Cnauo41eLSEi8FKkodYmDkATtkwCXzp1
X-Proofpoint-ORIG-GUID: Cnauo41eLSEi8FKkodYmDkATtkwCXzp1
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

> Replace the open coded offset calculation with the proper helper.
> This is an ABI change in that the -1 for a misaligned partition is
> properly propagated, which can be considered a bug fix and maches what
> is done on the whole device.

Looks good.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
