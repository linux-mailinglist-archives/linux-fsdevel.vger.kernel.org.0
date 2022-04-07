Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40274F73CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 05:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240483AbiDGDas (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 23:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240610AbiDGDaS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 23:30:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD021BD9B6;
        Wed,  6 Apr 2022 20:28:13 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236LH0PF004957;
        Thu, 7 Apr 2022 03:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=jtZFiukrDrNaKwudMOYgmK4y6ZDoL7W+5uSf9uS4Pw4=;
 b=syOONMklItTPSXz7KtfaCFVFE5ivjGKYsK8owDdJX+p3veRe56GBeWrYdskEry8eGz2Z
 c9zdGKmBs2gZ2XoUbepmD7qQNBxG6tQ5j2ZUx60TtC8+OdqTmLjVFPsmu3BiSk4h2g9t
 iWHcR7KAWHZCsLBwzDWPwabAUA3V8+/vKC252bPJ1HkIMYaLe74IPGnWTpuUh6GI0b2P
 Tje7hyIT9B3Go36b+Kc8u8F/RbQoq1L2rEe93W5y0GZpNb9PLi1p1XDiIvz+wyNt01yZ
 eONd83VdVCQnI483aopIRy7FIm9GO4/Z/SyF64TYHe5SJpXrPVZUZw5fskMd8zi7M+Az RA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d932mvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 03:27:47 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2373KQcJ014140;
        Thu, 7 Apr 2022 03:27:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f97wqsqmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 03:27:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9TZnLPriT0nVopc6LN0PYhEoK3lmS7AaNWeqhG5LvWs021seVGbcwAFIsnCksfrqDyKDwOH0Hy/2RD+OWoWERmmUwNhIS9MHmakX6AQbrQV1VITLzHj+gLnFC8m7Pb+YJexO/amZReAiXmAbRJeBd3a9lIp4sjSkKmx7MoeF4Xv5lsHpmoHQNhFPluUuq7o+0PwdvZiRg4QhPqWuLRpaGd91wDuBJ7EMYN4zvKwfr66VHBIzkPoxLWP0RxCEDfKPF7JQcWWJ66OZ6GSs+CZVzKo35jS/F9LoDcZRtbGEiTU6lwBRgmOVBk7WYTgb41Ooib7SWuBaNn7PpFxQTBE+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtZFiukrDrNaKwudMOYgmK4y6ZDoL7W+5uSf9uS4Pw4=;
 b=MmrpUPnu4UHo+3QzuJPyWKtbOTDvP6MWvbApRIzcMXlBxTwNkRfqHnZxhZWTpmI/YdOz/ygGRyf4N3Ya4BaSu9dkeEasWepaotPlQljL70d3irEbkFZr2qQCigniqjY6GB5m+cPlTlidHVC1Onrg29vPBOTRO1lMjUaytSmBqBoS/jy0CKsd2wcEyjHdkE6cQ/mvTgjnO+pVYsijnjU8E8WqnTbXA3SamvLmlHgur/XC672MOS3DF9Rlqd8W/ZW/0W76KMZS/nGOnI7gritwBJzWOqcOXzZ7LdOkZrUuwMFyQ88cZAxGbTmQIQ2FrZdaeb+Wz8uTM5IgCxPlsl+VAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtZFiukrDrNaKwudMOYgmK4y6ZDoL7W+5uSf9uS4Pw4=;
 b=vuBysj3Y0/+eXCH5ZS/chYtrN3+muZXWmhOCpB/xsf7NoXSCf/3vEpQMNch5Ur9r6rsK34Pi20wMCNJ29aTdL6uEEu7WI0Vqq9dVOFtbU00VQcA24EjTcgcb42dwOk/rwLYGr0OH620LYgGh1VqJ8BpFXmGir4EOIwE5J6IregM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (20.182.127.76) by
 SN6PR10MB2637.namprd10.prod.outlook.com (52.135.81.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.31; Thu, 7 Apr 2022 03:27:44 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 03:27:44 +0000
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
Subject: Re: [Ocfs2-devel] [PATCH 21/27] block: move {bdev,
 queue_limit}_discard_alignment out of line
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1k0c1h8w3.fsf@ca-mkp.ca.oracle.com>
References: <20220406060516.409838-1-hch@lst.de>
        <20220406060516.409838-22-hch@lst.de>
Date:   Wed, 06 Apr 2022 23:27:40 -0400
In-Reply-To: <20220406060516.409838-22-hch@lst.de> (Christoph Hellwig via
        Ocfs2-devel's message of "Wed, 6 Apr 2022 08:05:10 +0200")
Content-Type: text/plain
X-ClientProxiedBy: DS7PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:5:3af::26) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3cf4a52-2840-46fd-60f0-08da18469423
X-MS-TrafficTypeDiagnostic: SN6PR10MB2637:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2637242310AFCC3ED6A78FCE8EE69@SN6PR10MB2637.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 80ZcmGqzlbvvIyV7lPcstKvNsrhiQ+bTVR36mE6L60RiIGEC93HNm6rYQA65jPsqgEKYSz/hJ3t67uqkuqt61mVjzzhobGZ10ZEq33oarwh4MAMyI6hYCB82f7BiGXv2LTleB5utnhrSVG0tk7xMZw2+gG+gUwC7yWWgYDMJN3vpUZA7I6JkDhVxRGhEHzRMsvQR4gLCN+qouUbtAvdLK9QiZSTsxdV6yVDPDr1YKigKrDzn3pLiv+aXKqfW/vUTPVpeyel4gm6MW9yPmyZ+KYAQvwOMG9h4iwALBSDWnN7uveJ88l2+v9n0mqciYAA6tftgdKyM22kACSCsqFS0Q70xz8VSilUl6gfFosZEH3IkO1YZpmrfvSh6RgUPSxE5MSWsNuyIUpeq2CONtLZKyFbT5AztxmjBHQverJyDXWKnddK6nIMFE7BWYo8A1vw7jZxZh/knSpZ7q8nvSxBZnWyCYvrrpsGUiitGDil/5ixUBqRPlhUnx/51aWqT6DV+kbVCql9HQCoNpyXXOavwHQVkGozrVIkZswcmuoQnIl9/cDSoAyiBtS29eZVUwm7vzuRUfC3lwnKbeInwpuDjwjxbebPLEWyuZp456PM5DTFjhbAR/YxRgKcs3HdTxmL5Iq+TyRHX6axPRAgxUYvSz8SfQj5qFg6cUCLRML3Ir6dGXP69fPxeAkGNlgz+f9K+rF3hY7+rzYPSoT9ePzGiVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(54906003)(6506007)(52116002)(186003)(508600001)(6486002)(316002)(26005)(8676002)(66556008)(4744005)(8936002)(38350700002)(6862004)(66946007)(4326008)(2906002)(5660300002)(7416002)(38100700002)(66476007)(6512007)(6666004)(86362001)(36916002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u9k/spZLbn35lT2rj7uUyrSkLUM4QiWXwjvis3+AG0O06OXk8hxpjp13E5Q9?=
 =?us-ascii?Q?jCKmVAKJjK0b1BqKmFPPsrjNsRSZviGmhLxN6AVHtny/+V+UP/7gGo1BR5wD?=
 =?us-ascii?Q?BAh46yeBvQX+QeX+oHB1p+38lFDByoJJoA/AfA2p2GNgG1p+B4EpLjvVNtKc?=
 =?us-ascii?Q?d3Z3TDMWuXi5dFo2nF07J4HJpCzYA7d2ZJNlU5D47DotVoOByyPWuA2bbCd/?=
 =?us-ascii?Q?5f3AY6gj+nMHGlD6W67B3a+RqOakF1rxuErIDKzf6GQJEd2q1FprBe/Bjfsw?=
 =?us-ascii?Q?kkVuY1hCUNF5s1jdULq9/yr4YajldxnidRM1WFauudLKW5MEXIIywFT9fBTt?=
 =?us-ascii?Q?ZsZZElyn7gmeuCC5TUu2XWTEZegoO/4Dl094c5feMU1VOlHGnoxs/WQ9iJYi?=
 =?us-ascii?Q?sYnC9C4E3rvF9ndecbvvw76RkpMRT2lRr5m6GWTeVZ1sphOOTpV3BpViJo22?=
 =?us-ascii?Q?GDv0S6sa6Dgyd3GeHrVyK8jEmqk9EdeEHnjMqFc7L1JmgnGQLAOoVJSF8mb7?=
 =?us-ascii?Q?dZS2VgI5mrDDBUtAbwwVwwWGMhSZHQMZUA1IWlKtLlZpMmycmiuo2+bDLCSv?=
 =?us-ascii?Q?4xfJqT7vEABOffMHtpa1yqhdnvWiKFui1CjnHEZy7kpgo3UoaNamzKf/NB08?=
 =?us-ascii?Q?KhcRK4yxS7MRllUNu6iqtTc4JAIrLsPAlgpfvZiF5+Flj7iivGfhrc2PX+8l?=
 =?us-ascii?Q?oPNyvTU9hUUxGboynV3yD0SPtJTa7rNkqv9NGbv7BbKmJCqPD5rlXxjohONG?=
 =?us-ascii?Q?XdCtSpqCK+sSVGoHzsQF+CzCk9TO1OKXFfi0XaaF9eLCu7FvSg7KDcnJsAq3?=
 =?us-ascii?Q?GDnySRzucIC6Nx+DBThslp6PSwk4EZ0hrRRbni8Xa2dg2QwRW8aFejKJUsOw?=
 =?us-ascii?Q?J6G74oCF1YEVfGLmfAQvkL8UrTKvrXqlyPDL5zYak+xAHHYp05fOg4I6twxe?=
 =?us-ascii?Q?iucRkGVoYX+WHalcQrE3ZYXn4XabiYqkR7NBp4W+gKdE8L/I1qH4DVDX4Auj?=
 =?us-ascii?Q?HDu+bMxbOhSjRfox2eUzooAq2sGT/s2+DsRq6fjfIQzIZHdjVW9KQDX4f+nT?=
 =?us-ascii?Q?xlWYc6NA8ZoOTI+0eLLN+wD8yVbn0uDalJbHClE4Lk6+KE04EuMApdKLUC8e?=
 =?us-ascii?Q?L2H+6mw6O2h3eYyNUwuyXb/BwAxJiM3QQAvNksD4EjhdzX7HfME0jUW8TFcE?=
 =?us-ascii?Q?2GpmDgoOrz+NNYAxkIn5mfXrnwwEJlrcUE06GRf1pXSf7F4qllOafQ/gYmuf?=
 =?us-ascii?Q?+vshV+DgeTiLK6UJZtovoqF9uI8D53/qwm9hl07ki3JvBOVtv+PWtU3y2wRl?=
 =?us-ascii?Q?IKcf0rXMuxbrDnyr+YMgvREl/5SCmnbSLaaz4AQ5A3f144r2GU5g40rJugMo?=
 =?us-ascii?Q?hHcl5j4Ld9WABou6McobvaFoQmbM6zctXNTsWZWKwC5ce0A+SD7cx1hP5Id4?=
 =?us-ascii?Q?ThHzD9s9xsyYa+RUQN0Thj9eOeQEPyLYpWJcWRiGFJ6LGtfwT/Pb/rdaesrN?=
 =?us-ascii?Q?xQATOdCzRdltOgP4hFPyX8KnN/gX5xPdV6RmmZLd575yIzojrDPTsUtnT0uX?=
 =?us-ascii?Q?0jnOoAJVefp1NTRFWcC3XdMM/yqcF4k9FA0EF+OWZr5fSVCUf3g2fylwjOds?=
 =?us-ascii?Q?n3E4C40X3NBVKuY6X2BBhydGqEZwDWtS3MAcrR6DaQ75ackm8rxoSUA2okCy?=
 =?us-ascii?Q?qQoMKf4QkZI8o54TodyBpPwHKrRwD/febLODZeN2gknDIy6RYu74Q4ALNBmG?=
 =?us-ascii?Q?t+EtYOfH/GlA8kNWzOd59B58dsZKFc8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3cf4a52-2840-46fd-60f0-08da18469423
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 03:27:43.9876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eyUcy9/MGctZOofiA5xyPFtM1nZ908KVPJjnyQfCHQlpI4CSGsRtGP5YZVc9zUFfqAJB8w5g9VIHZ4PeBrVg8TSsYaV90Ss0i8yVCGDR2d8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2637
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_13:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204070017
X-Proofpoint-ORIG-GUID: _zEf6t9FfwbB1Zj1bWzsrGq7918sG9Hn
X-Proofpoint-GUID: _zEf6t9FfwbB1Zj1bWzsrGq7918sG9Hn
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

> No need to inline these fairly larger helpers.  Also fix the return
> value to be unsigned, just like the field in struct queue_limits.

I believe the original reason for the signed int here was to be able to
express -1 for sysfs. I am not sure why I didn't just use the misaligned
flag.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
