Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98444F7404
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 05:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240620AbiDGDhG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 23:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiDGDhD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 23:37:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCAE2335EB;
        Wed,  6 Apr 2022 20:35:05 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2371SjDl024505;
        Thu, 7 Apr 2022 03:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Dhl90G26tVGJN6+0kzY1Z14efJgXppesGyE9OgKXAkk=;
 b=PmWQbEvT5swaS4vnVygPu92hJ8vj9PPRJ35STBFd0uTjMDBtw30xhHvAiJruGGpVwLHx
 ti2/8OaT253Rw0q0jzCD2wpbGM3BMDOFI7D/udzPEa4HSjqaeXyQag5ZE3xeO/dX95CU
 N2FMQ7BsIMJyIrvO/Xzwub/4DYYUneLv17TqrrGGBhssbQHb/hJ713GcdcGwZGtx5zuE
 3eXhwo6t8CtBWgTHg4Zcg3CTGaNd/mzT6rssskQYsimiO7iUoi93FNQp2FOV83z/seNf
 8+2eoefhbeNKaoMOCxk6Zp+fwGSExFkW7Ur+QewXYs6KWMVcbTN2Fw9//5ZNE+Pu0v2J 9g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1tas3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 03:34:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2373HEhx034877;
        Thu, 7 Apr 2022 03:34:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f974dk6x6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 03:34:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOk4aVboSNEiOVvt5d2tKYGLeSgkmQTKostxebcRNgrp119qVqncIukXwV5Wjvia5zU9uww0HSJpL0mq5GI8YQRgB5WgS7tYQmYGaQMJochVuOsjER6VcNh9TXfBVg02K4McOkueYDkOwXJRJLMXcj/c9dpCvl5rG1rIY38Teyut644XqDH+ExOu9u515E9nvi/QlDzx1e9OLKJTpC0pSUFpdtXhDS4Oxv70AhgK8PrYL48yJ0NoV2OMEESxb3QiDNqXUmd07V3Ql7h6ZgoCFkqUAKw7drckXY6/I/XB9Z1s7RI/uHw3beTqcf7dBKj5mhjmnQQh+Vwc5NrLrxBv1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dhl90G26tVGJN6+0kzY1Z14efJgXppesGyE9OgKXAkk=;
 b=UPY0UCyYL32Z7ruDgiQ2xg2ki4MLYgtfofxOxbt4GX2cpRZIByQ9WEkkwdGSOCyDxNCtWAI/ouMrQpij94i7Aebk8sXhssGz6okTAc8t+L8IZjpg1obJHFyFtVhttenTU6ZQUTFB1pIov+2mxTmONtsY9L+hVw1GUAqvlZZ+rhHxddvbVhFe0kxBJ+H0zBg6xMb1+46J5aWWwjLvGm9Ge8Nq9x3LDIIhq+s+y8sOAbLmMRu8HKsd1M0OJP2Qlpjh6Umh4hkYozqf/FkorYT6hYJe72VHvFf3NTfC80VF4d8d35cjJf5FnC5FI9ZPSw/ScNxIBNRIJvXE2Msi7W6fUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dhl90G26tVGJN6+0kzY1Z14efJgXppesGyE9OgKXAkk=;
 b=bbbgNyIljIcOvP0CAmqNL781dot/1GdZD9tp2eIl5aKJv159Bhyu3ODqvRl45+A7QOmIuzTOkP+qDyrDyLBT0F6nIE/Azeg98DJWxwxhzgvonyBMX/vu+NouUF2/m6QNYdfNN1AtL6CVkWGzZVJ6kxG2+3jmThaq/sptFlG0m98=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY4PR1001MB2200.namprd10.prod.outlook.com (2603:10b6:910:3f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Thu, 7 Apr
 2022 03:34:30 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 03:34:30 +0000
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
Subject: Re: [Ocfs2-devel] [PATCH 25/27] block: remove QUEUE_FLAG_DISCARD
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1wng1fu00.fsf@ca-mkp.ca.oracle.com>
References: <20220406060516.409838-1-hch@lst.de>
        <20220406060516.409838-26-hch@lst.de>
Date:   Wed, 06 Apr 2022 23:34:27 -0400
In-Reply-To: <20220406060516.409838-26-hch@lst.de> (Christoph Hellwig via
        Ocfs2-devel's message of "Wed, 6 Apr 2022 08:05:14 +0200")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0045.prod.exchangelabs.com (2603:10b6:a03:94::22)
 To PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d446413f-1c36-4dd0-b7ca-08da1847869f
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2200:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB220039B1E7C83FCF44C38F6F8EE69@CY4PR1001MB2200.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kQXOcZRdSEjuaBtDcjetAtqBll8S+8aGRn8Hv9IKXz8u61VNfWBvl/0w2Xu2iHpc8otKBZJiSgSqudn9fjyPJ/XzZ524umM+F4BenIFUJ94hXXK9YNkXOyear3/COPiCq9u95FNMu1OT2/HdvfTXcRMjYpLKpOJa+98C0nFGD0vZlNlkRh6fwOHDhAssU2yu5hw8xvoaei78y9SMcvtsrkcMHHnL0G9Zz2gKNE+UZ2Wt2NI4X47yd7YTuRetVXDlbUNxu9tIGzxJo5E9QwCtt+Nc6Szv4l00dVHUCO+VE7e7fWSbxRcEX8ncD2f7Qvbt6b5Qk48qxl9M7pQmZMtu9QMXHQfty0LRIMbN3ipdrzwYHVTE7Uh6VqXLa01r7NcnPT38ik7iYy6J9jSZEvx3kUNjygySDJknKU/2x6EiOyxLE7d4qiBkDIXdXaHT5Owiy5Zgf21vpFqA0XBSRcNAYf1u5iKZKe1nE0MV1LH4CoTqpDVp/3VItQFuY3gfqX3Jm/aDpd9DAUJqYD7nr6TxlWCsWAwJ1DeV1fNJOMn4puOJ/hfN5mngEwxLLRxOjJW6K3ZoS5J1mjGFczi3V7yDy9Z6DFfoDdNKBXJb9yBLFtAPtNmFotrbcf5w0dX22BposfSbPQdfy73SLwPvoeo+ExRydbheeO6Ng7NJc1xaCCCUgYU5uO+wqLD/Vsqq3jtLsEsHPiZe8YA6DVAo16hkFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(26005)(52116002)(186003)(2906002)(8936002)(8676002)(5660300002)(6862004)(4326008)(558084003)(38350700002)(66476007)(6486002)(38100700002)(36916002)(66946007)(66556008)(6512007)(6666004)(508600001)(316002)(54906003)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OClvsL1mJtH76eGWXfATOm5aZvAfetUXgIZor60KTFybLgfxxK/y07VPVSLS?=
 =?us-ascii?Q?a1FTh3dx8XuT2m2WqzHGDG69aZ8Fe6jYriY7iXIlNPErk3iEsOJRcFueuQrB?=
 =?us-ascii?Q?2g4XpyaowygMNy5TltYQ/7RMxb8CYfs4hSpXpqR3Txyk9egnq4JvffKEimKu?=
 =?us-ascii?Q?U6vJGNNRoZ5+UaVIvh4UnVOlkkXnQTkTuJ3KZT2znzQcTVJXCMqK05p24lVW?=
 =?us-ascii?Q?r3Ainz2tYkwHfKAcQkHs2Q5Os04vpI882kemelEApSxTIpV0ygGrdLS8IHCr?=
 =?us-ascii?Q?sTE4P4GHoKLJepSjLYIATT64pcZrOSQ3VjFtbx9nzTzMeJtUrkx/ROOWAZ9y?=
 =?us-ascii?Q?pBe/chsV/splOJccdHkOASWqgwMG6fhZML9fT9CgUcM/Fj1tRgyH959+J9UN?=
 =?us-ascii?Q?XrJspaaehtQTCsTqX8tPEL/E5e/Uvy5mZ4lyebNiBUgRhNvGZwHvU7HNr6mW?=
 =?us-ascii?Q?rlbHhAGvrPi2b7Se0rOUo4cF9Jl4UwUatBnyWzJhVw6xICiBQcnVKYNZ/J7c?=
 =?us-ascii?Q?np1TGbblrBIu5buBoPistvLnCb3VUyTNKcKtrg5nLFJsO/TlrcTEhcmGwWDV?=
 =?us-ascii?Q?Y9qO4u17CWMXhJH/eKVlu1hoYmWebi7jIEVILpBjK2CSH2fmdYTVM/sLbWKM?=
 =?us-ascii?Q?+gPHxQ7EJ6cYcrVW12f+v2GouYJKYWljh2xNzRN+CQnjnOqDDy7ZCa5kaM+q?=
 =?us-ascii?Q?6s/IhLCROIQzG+GUCYYWVA7c7j72Lc9uBzAwnxhLZwkLQEFleFsO3sCnj/mT?=
 =?us-ascii?Q?0ZflMKos4evIAWCiHZWcFlnRaRc74ILi/y/cndHD2SAoNI+zFg6DlIy4J1w8?=
 =?us-ascii?Q?LwX7IDk+ia0ArR0O/TXjHW+8KP0lVPw37QWATrN5BfqA+9RK/c3VVPE/BB34?=
 =?us-ascii?Q?s4Vx4RTkqxVic+DHa7M7DUJ2c5QTxL71AuoJ7Z2aW5J/wC6pXtC/hEXZfh74?=
 =?us-ascii?Q?juAiBmHnTsJLXvQL9qcTrZgf/85DSd6L+K6soXRvRaoXFs8PskMZQiNMuBGu?=
 =?us-ascii?Q?u4V/9zCS7fYyU8wG1yvbzkJ93NcjOldptn3JaNuYtTnxWFvja3GA/+fE83kJ?=
 =?us-ascii?Q?W01aUJtIljIonH+l3eOXxF8RRmxsQRa2NSobCM+GZ1Yzw3sB45PNUUGhFdJv?=
 =?us-ascii?Q?3iZBLkzd8AUEdL4ZSllZ383vttQhTg8UUEPbC5rWNYAl6R5RZk+7VMoXIgwG?=
 =?us-ascii?Q?FKDqrtvtUHaRPTjb7phi8rTVNWz+D5Nc+Irb7ig1QGNCspfmdzp7ZvEJzLmS?=
 =?us-ascii?Q?GF+t6Q9Buf41WxdwYHOYcDYdgr3I+eKvSdO9Jc+ORIrmeY/fuh/YY6kHt6x+?=
 =?us-ascii?Q?1bxXm0w/avAB8TqReBmm8pH8Vu7Jn+5tYjYSp1skFasrcr7Eu8Y3GDsig2sL?=
 =?us-ascii?Q?jB/CCOxr7hHWS6/K/zE/xa1Zpiz8kSZQBvvxQwUh37FdN/GfzJBOdxcIZUh/?=
 =?us-ascii?Q?bFuwglqOu6DCeR+UxcZYSPerXd19A4jsUS0u75w0Evv3dPLMXAI8PCK6lg+Y?=
 =?us-ascii?Q?09SXCdTua5x5Qttm0BUoALA+nrKF91G7E+9WNAMtYIq0SlhO+ezV0kCYBD5B?=
 =?us-ascii?Q?RLQL19cvDpoR9TISYvDiHUgWC+ayYSxwW2HaSPYHz8VNIxdw7pyVAgqGBuFD?=
 =?us-ascii?Q?sXR7Nn9Jjy78d/O2JwNRqNKz5etuVZs4Lm4pKmPcIJUUmJyhmem7Ays7N2w9?=
 =?us-ascii?Q?X9JFHY7xSYpC4nbVtOgzXbKEorxkJgALvQxkaLhJgXpInT1GlP/CceITi1Uv?=
 =?us-ascii?Q?il/H+EL5eoA4PPzqwctHlWgNEN8eZtw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d446413f-1c36-4dd0-b7ca-08da1847869f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 03:34:30.8111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qi5ZBTiCMEHI0hzCpuN8Suykv6oircyOFfbm9FhjnlsASopNs/FgELDlEAXqhXKCWz04v0TbcTa07lyOWMxCueyQiz/XeHZ45dT9SsSwQvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2200
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_13:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204070017
X-Proofpoint-ORIG-GUID: KYaZ3coqmCT5WsXPVPLzqm4zdv8P9wTl
X-Proofpoint-GUID: KYaZ3coqmCT5WsXPVPLzqm4zdv8P9wTl
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

> Just use a non-zero max_discard_sectors as an indicator for discard
> support, similar to what is done for write zeroes.

Very happy to finally see this flag removed!

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
