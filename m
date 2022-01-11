Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A97D48B633
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 19:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350299AbiAKS4L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 13:56:11 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33596 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350286AbiAKSzy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 13:55:54 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20BHRk48018380;
        Tue, 11 Jan 2022 10:55:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Tn8fDBTZXSj3cbksFu1mnhx0sJxlIHvVbgi47Mq/0BY=;
 b=Qg+EB185rxoAjFVCdmkHxvAX6usqOfgtfBXY+MlmPn7ZAyaZ1oKg3RDibHlLeEJdWaEx
 HooDe+DJNUHsM7XOIXgTYLtpHXxuD9Nv6hj9GvBitZ9B2zfd5jR9XDPqUrZeoef1Wkmb
 DSTegkGq7G2ltohaXCVlihvV1wnmpFWXB0o= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dgt008854-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 11 Jan 2022 10:55:39 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 11 Jan 2022 10:55:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtvjqGFz/AJNAX/BmT0VQ2r8v9E7vfZEQkfZ9xmFUPJgAT1qLF5x+kag12kqd/4B5B/vaaojlTw5UpGIXJ0x9aENe0arvs34l2QjbtBEfV7vMIn37dw3W2Z9j+3hhIWx/t8DPk+Aj6uVGspRFJxtXTOp+qladElKTxqU91MVVjCxW3P4UyaVVMbvOlklnyDKj0BDyYkfzJZguqhfFVpiCCCDVDn3c/nzNBpr5oqLEXX2iVHsHJjOaZDoUknfgl1SqZP1DiMd4WFt9fuyJ6K73ahQ8rA5bgyjA6kGgMZ0lsVIlzkf5qGbstRhouGpUJGvAArV3+BOIWXgIXdfFvIHxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tn8fDBTZXSj3cbksFu1mnhx0sJxlIHvVbgi47Mq/0BY=;
 b=b0IWWNi19bWBHb15xD05UBLldgxpnhOpLFaQPU5CAG070XGXk9It35Tl+VAp9d2tXbZZfrpfiRGbAKRzIOUIbpoa0v5BGnEPx4kT+PGeKyVZsbNa1kkm38YfpmsWzO2yhP9iOpLvvPLj61SKCuWuFSs7lKuJ/pqo1WXEUnHF7FW1bX6JcnO6uz1VRCJrBGxaz+w23Q5UDMcsa4DehFpbeLIKruZ52P+7J3+6J8mCZSEbzvxOcB96J8DsEVvquqTbBFDfMlwBb7CG4G2JtW4M5kvGiEKuKGJxIdZIKUY/8wdE/u/DbvlTHQaZ+Qll/WWsaHYB9eTZP+wKIxjhRJ+Qhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY3PR15MB4802.namprd15.prod.outlook.com (2603:10b6:a03:3b5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 18:55:36 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913%3]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 18:55:36 +0000
Date:   Tue, 11 Jan 2022 10:55:31 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <willy@infradead.org>, <akpm@linux-foundation.org>,
        <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <shakeelb@google.com>,
        <shy828301@gmail.com>, <alexs@kernel.org>,
        <richard.weiyang@gmail.com>, <david@fromorbit.com>,
        <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <jaegeuk@kernel.org>, <chao@kernel.org>,
        <kari.argillander@gmail.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-nfs@vger.kernel.org>, <zhengqi.arch@bytedance.com>,
        <duanxiongchun@bytedance.com>, <fam.zheng@bytedance.com>,
        <smuchun@gmail.com>
Subject: Re: [PATCH v5 03/16] fs: introduce alloc_inode_sb() to allocate
 filesystems specific inode
Message-ID: <Yd3SoypOW0EBZj6K@carbon.dhcp.thefacebook.com>
References: <20211220085649.8196-1-songmuchun@bytedance.com>
 <20211220085649.8196-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211220085649.8196-4-songmuchun@bytedance.com>
X-ClientProxiedBy: MW4PR04CA0324.namprd04.prod.outlook.com
 (2603:10b6:303:82::29) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df22f2f7-1484-45e4-1f6f-08d9d533f38f
X-MS-TrafficTypeDiagnostic: BY3PR15MB4802:EE_
X-Microsoft-Antispam-PRVS: <BY3PR15MB4802C7E24906993127F36CD9BE519@BY3PR15MB4802.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xxv1yOuar9HgdHQwjt9JqGKbzzLKsmVbq4G7i00PwG1vFsQnZZMk8rxBj0uiNcCiIP7BK/m/2xG1tThUK3ThBPfV+LxgUFh7dY2PN07Y5YMtLWvahi/hI0jBcWlS1FDWV6JtFv6ArTsDWWGVwgDfZffOxCqrgaBv7e7VY8GvPoCG8OWm28YwRVW1MGz1ACm4eoHBQfBszQ8cZHcD5HFYvSe8MiWmg76SkcRfeWhaBz/1G9QoaMQlp8EkaPVBb31VexGxLdTGPex2UMDFt4KrHPxkJlgWiVyK+y8jzAyhCo7Ku3vZ/zYULrG66kzuL8lYYynwopjekjevtQPIpXHhk5EnncHGFCggSxALePiBY45vK9gPNvlAbtuEfU8ZPOOTo+4cc6imMoL6aef3rDz5sBfgs6CbgxVfbN2fvQRjM+48BhbWefaUAAQ9XyK2hJjMcbR9pTQTUs9/AWwnLjtmU8TUXjBalX2pAXcsEWIdPTlWnDaHt4oA6zCoeoVZBoImC8g0yDoZC7Yb+N0uAfkQdNKQbypLkYINlM2SMHMFQs60NqV0iStQ97b2R9J2BsA1+2FQxldilT+kJ3mr06MISy9ThAN3ENePq62Z9mg0dOe58vlRKkDN1zznLWGfBBqqP4w48VL7JBtCRMwv2Y7fhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(83380400001)(6506007)(52116002)(316002)(7416002)(6666004)(6916009)(86362001)(8676002)(66946007)(5660300002)(508600001)(66476007)(2906002)(6512007)(8936002)(66556008)(186003)(9686003)(6486002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gTcTuUujrtvhFrQQcuscoDF3V9YKLIj8gYosiecpiULsZ7TXJqKWfX+/oGEc?=
 =?us-ascii?Q?1h9oKrDLkZMVYHS+0tUzqS7gnHu4e4N9wWUP9enEdIloV8wyAbdioxqSHox9?=
 =?us-ascii?Q?xQT/cIGUqrFPHXsqoV5ksGTjuWl7fBsvRc4qAWhw2T5IF4yyzusjsBP05Dzj?=
 =?us-ascii?Q?4xfaG62+Bv0OePMHuV41VnOYBmESYJUf1AetABhdDMnUKZT8M0SBDuB1Io67?=
 =?us-ascii?Q?twFlNkZtx1rpcXRjr2J2Ua497mCLIVfbtSzbHFcENFW/mNiUCJfDA9oxmSkU?=
 =?us-ascii?Q?O+3oeBcPcaRt8pVqT9ZhcbbLL2Dik4sEs91zJX3Cgqij/mZi28emV7BmXh2W?=
 =?us-ascii?Q?zQ2yGhpilejMplDftDOtoUKzm+gnS2F2hBU5n+QXJbwbTp963tYPfuUHFHTV?=
 =?us-ascii?Q?lZ+OVjMXRMY24iPfnMSU1ynGryZvG+9Rw+BpMGjxCCEAlG+MX4wX80eb7oKN?=
 =?us-ascii?Q?h+VpWD+8upFBAQB3kLdA29FdNbN4bbrxFtB25IQxH4paD8W7PbBh5WYMEe7t?=
 =?us-ascii?Q?I12V90FVniOhw1fUFSr5maCAkJK8antjqBiA3hB3qPgq7nOvxZpFQSzP3+V+?=
 =?us-ascii?Q?alLys7afW2SYRrr41S+8GhzMQuig6vTFOcCK6LARgxiskYVD5LhQ4tbH5t21?=
 =?us-ascii?Q?4TEBr6EKi8ptnQhtVcuxlIgdDMQmy60QbH96PxB6YlF9hpl17AXB26zh2N8l?=
 =?us-ascii?Q?4v6dVw27TsNAI4UwauPLpNYdODnTf4vrsYdzR+G0h9ciL+TewTB9FJS/akGR?=
 =?us-ascii?Q?jDYibLa3by61MQG59mYY5BfAjkj1ZCuQiVDZYTFOw0+Z1Bk1HkjSxok4eA4g?=
 =?us-ascii?Q?b9NVtU9NKZRR6X3JOH6sU2OSOXEqZUOXybKJIycTbC1/hHRTZ4tmzlc95NMV?=
 =?us-ascii?Q?Sq2HMFRFhd7iIk0zG83zfjksSFXCrSAfi9og4jLOko0FK5AAdiPBLd7JoT3r?=
 =?us-ascii?Q?na4Q5PaQRm+H6fc7wMaYl6GmkOxrnm8qW4XIHI81aWWVJDWLOYalqBE46Oxv?=
 =?us-ascii?Q?S04qU0y/G5X6Kzz8fJzMSH13s3WC+nxDjoiGVXueJzyn+Novahkgwbd/5bin?=
 =?us-ascii?Q?C2KIv5p02Vs+NQX0zocc0Rit16Gc2rlcmH38cPmOoyDYBdVPGKvshOnQhdiB?=
 =?us-ascii?Q?Y7z26hTlryo4S61UXkWTxViRUjN0l5QgkfvuQbcVlxI/gc8IT8lCkG7U6NdV?=
 =?us-ascii?Q?d9Uzy9H0TO+0sLhLEaJ9IXRpwuII+dtEBZAqbYpr8iTYQSnuPQN5Usds7qkD?=
 =?us-ascii?Q?x7dCYcOUJW/HbESa64GwfMgf6eNM2FmWsxK+ntSoyihSoPjYzUKjQGGOW6P6?=
 =?us-ascii?Q?oK1PkUNE6ZLLEh909agSW5Q3b5R3QQVOVRpjwK90QKCz7qK2H9rapG9SZ0dF?=
 =?us-ascii?Q?4oXbMTZqEukGyHcjH3OzEtJ9tV8oVjdDZ8p7gjYuMIxNxn8MLnQV47RMv5xL?=
 =?us-ascii?Q?JCwbpTKE6TizSE7KGH30xWGN8U8MRcig0PindyJhJhB4J3n/38HY5KAru0h8?=
 =?us-ascii?Q?nyy6N/6d9vN9ZIjcZFt5oAOhdf0Y2X0MJbGxVw+4gLmZdEa/ETd2YWLs4iX0?=
 =?us-ascii?Q?wP8Z8IAwa1uDGwsqy41jWXmTLagojfijYh+/tJe5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df22f2f7-1484-45e4-1f6f-08d9d533f38f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 18:55:35.8739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A9ZJ2Qf85+BXtRib8AvGJC3XGzHJsPfoSt/cY+ZQf/XXQWC9pCZsWXocRq83u0gR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4802
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: CgMtw1C0EAhOQVeZ4eq5M4uzTBbpNE00
X-Proofpoint-ORIG-GUID: CgMtw1C0EAhOQVeZ4eq5M4uzTBbpNE00
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_04,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201110101
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 20, 2021 at 04:56:36PM +0800, Muchun Song wrote:
> The allocated inode cache is supposed to be added to its memcg list_lru
> which should be allocated as well in advance. That can be done by
> kmem_cache_alloc_lru() which allocates object and list_lru. The file
> systems is main user of it. So introduce alloc_inode_sb() to allocate
> file system specific inodes and set up the inode reclaim context
> properly. The file system is supposed to use alloc_inode_sb() to
> allocate inodes. In the later patches, we will convert all users to the
> new API.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  Documentation/filesystems/porting.rst |  5 +++++
>  fs/inode.c                            |  2 +-
>  include/linux/fs.h                    | 11 +++++++++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
> index bf19fd6b86e7..c9c157d7b7bb 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -45,6 +45,11 @@ typically between calling iget_locked() and unlocking the inode.
>  
>  At some point that will become mandatory.
>  
> +**mandatory**
> +
> +The foo_inode_info should always be allocated through alloc_inode_sb() rather
> +than kmem_cache_alloc() or kmalloc() related.

I'd add a couple of words on why it has to be allocated this way.
> +
>  ---

Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks!
