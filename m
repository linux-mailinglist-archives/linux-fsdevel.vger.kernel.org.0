Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092F748B671
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242950AbiAKTD1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:03:27 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:64580 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238845AbiAKTD0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:03:26 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20BHS4ux028114;
        Tue, 11 Jan 2022 11:03:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=B+/Xf5wTOhUIK+JiJvkHc8Oo7pC2Yh8OU6WrQcbIMTM=;
 b=Nmz+cydoXl2NKD5IzfneSwwLuAbJ8lmXV3NqhTUILQkOc8cUtjbwdlJUwcNkMY8Rvs3c
 W+tIqW3vWPzLSNoeU4I9oNmlGe+kh31wq8DG8ZRV1uihel6bp4b50eq/5CUN4b/7MXKP
 hfU+3CPMV6S9DvW0a2gyP8Ne1CmhngAvrLQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dgtps7u25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 11 Jan 2022 11:03:11 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 11 Jan 2022 11:03:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQn3SESMCqCNPVkeo54ftC3z2+HcPfItT24/nPkz3zdet+Y/HDQ4ePfcThjGfd1XVCi0T1snf+ruVikMO6PJ6nZTN5IHd/O5dxqbH7dPdl93mrqIrJ7GSqJkwLk7RF26Byvi1dWMx+6QiAIUYDIucQwNTM9QhiF4a8udjQleZG/wRIKkVNcBLO4bOE1HgGmwaGS6qwmcMDyItNiXZX/Y2IAmpCa35NdWVw5+biEVyLJ5x3yTkVA+enhKL7NWAl+eedlh+YGBQfiMgviXsFeAiPcuOUtjDOm3INIO0vPrPfWFU1J97zVRUTJp36Fx+anULQf/x8LdMEW+4ps4/A5pNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+/Xf5wTOhUIK+JiJvkHc8Oo7pC2Yh8OU6WrQcbIMTM=;
 b=Kc9Bp/inmpkP8qwRgO8nlpCtM+2j7Ysa0YFzckqqs4I+NxbNk3Axbr8fZhMetB3uHm2WB70oUMzqJmHh9lxy2d+NEgMjs1FmTSAwZ3F4ydIUYMTHqnHKGtjG0KPE5ugVqS8eQCjDcNe9ZDov5sNiiwOheSeD9sO/b0mruS6myC2FIG/ep5TlECjBuLcB2ZJkqySRSo0jxjx4JsFz95zQ/sWMVlY+86GnOotxp1bcB00BZsZ5w1w/52lxDncdhzQk7CLxObUiSInlzEdTozE1DKHV4liBLKR2+JllmWsCYgYqBgAorWmW8KlEHZxGX22wERLWBQCUbCNXapPn4x6iRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4373.namprd15.prod.outlook.com (2603:10b6:a03:35a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 19:03:08 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913%3]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 19:03:08 +0000
Date:   Tue, 11 Jan 2022 11:03:03 -0800
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
Subject: Re: [PATCH v5 05/16] f2fs: allocate inode by using alloc_inode_sb()
Message-ID: <Yd3UZyhGiACHgBah@carbon.dhcp.thefacebook.com>
References: <20211220085649.8196-1-songmuchun@bytedance.com>
 <20211220085649.8196-6-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211220085649.8196-6-songmuchun@bytedance.com>
X-ClientProxiedBy: CO2PR04CA0115.namprd04.prod.outlook.com
 (2603:10b6:104:7::17) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bca41da-0be0-4213-aadb-08d9d5350176
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4373:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4373C225662353D877A76827BE519@SJ0PR15MB4373.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:580;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sIy0CQ8/pOrXMxTP6+Ngu6O0ebqLFWQvj210/SGwkc9rj0+Eu7CrnuRr2FDDjxHRgRalx7w1JoKtCVwyTJ5CMkv5F3yjJTGOc72X4HAhPFmpwvWizhcdX+KGYM7XmjgW1qRMWPXyxZ5JHvVTx0byC9EsXnk63lWPyzgp9zYATMhGli1/98pbWDmLf1GHsuM5WuYq6cmx9ARoTLvXQ4xlG5RUvle/au89zganmCaJ0tuH7aBgod/AvsRWMlUzNurtCgw9+pnxAaTVyJMp3F9q2Qh72cdnTbkccoOBxyUwtZtYBKTQpvbTiKZ5ncjADiN+QGHaBNrSkthb8nGWg4jHEAfbJyPVJvJxXa9kKOYxoYblju6SvT0/AZbBZySw/jf1gBkGiqLF3xyG2RkSEWr6XnM5e/5LPIMuZi/caqjYWTB7yy5fGRr65tq8VCTI8p4a+sLt8DcP6zf6qy3IwJ3rfxG0oSEp37bluBe3FHHeQfKq2YZOJtVxC+NtswMq1y1bj+uscoyx19g2ERo2LXLUwfzTcb+m92TA4ouBnIZ4ng4YfAigJ5Nf2+ulc6Aq9srUQvun2hNAGp00V7UdqyqxJg9zay8aq0/CkCr8xAgUsJdk1V0S+mR1Befyxww/5j2JjrQpvbKUdd/cL9Fu3G12aQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(6512007)(52116002)(86362001)(38100700002)(66946007)(6506007)(66476007)(7416002)(83380400001)(5660300002)(4326008)(6486002)(4744005)(8936002)(66556008)(8676002)(186003)(6666004)(508600001)(316002)(6916009)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PttLO13CQiN5zAJoumJcBsxhtZBuxYkTnEvk4nJthwdXsy7nwCLHqaHAd6B/?=
 =?us-ascii?Q?4r1fpRkqAWOJLBoHXVD4fRcDUev6rbh7whC6aUr+1Q9IDRIhaFQii/Pytlh+?=
 =?us-ascii?Q?yfmr1JhCFCFx3u1Tm/2BeK0Vjx7MfPWMfjMlm7HKwgmJdFB4tS5bKKNk8+cV?=
 =?us-ascii?Q?b6RLz3vh5C1jHNcrSmOgcX1Rnp523iooR5A2EZvDhStGy6XuRqdcMI0jSR7X?=
 =?us-ascii?Q?29IoiLC5yJMsNuR0uGozfxXSttg+s5Aqp4lV9gFXWLCjzcZOU4ub5Rha7ABm?=
 =?us-ascii?Q?rzHbGdARmbeOUjjqPLXHtXa5JNNMKHHteiJne0XtESNgyQA5t0X8NJjACaeG?=
 =?us-ascii?Q?JPhnK0UY4vRIaiPSzdEz7tinJzUHELsoC5R3CXxub+h8xg/o52jjIKVbcVzO?=
 =?us-ascii?Q?biZcTiMiVxm+VTCZZLj652Ll9usYe4PGwadxp0eHUu2D66vSLhyE+YtQ39a2?=
 =?us-ascii?Q?ZCH9SuroWvZiK7sBz7UVSKYIOm20XlymLv84q7eioWsLUq+x11Nd1y2QsrRk?=
 =?us-ascii?Q?GGogy720MAFTwIl0zILFXQxx450hW0S2Qt5XdiwjEu8TPVGYt9qGwONP/69O?=
 =?us-ascii?Q?QZzs8W84wZq/uEcWUfxUHGJxlVU5T8MzxKH/PVrWrdI3WCy7HoR+d2y5m/yx?=
 =?us-ascii?Q?fYPQb2bbSCSm6Hl6jjg1eFNuGPKZG7JO40fZOiEU/ZGqV+MNwi+SelHulOOT?=
 =?us-ascii?Q?Y0T705fOOJnG1tIZmqqCKwqvR3eQuiI9pHNpgBBiHs4+1/8TVfD7UrCw6qNd?=
 =?us-ascii?Q?eicCoJ6fiqMVNDNI2gkJ4mXMRLXiq9jt4GTgqrOy/9xFBrHN8ZHtYxK9dFOu?=
 =?us-ascii?Q?h6gbOSxiwdb4Oq6OAJ2u0yq3Kj/NAHH7cZ54u2G6nd66dgjo6V0LsYQgCfD1?=
 =?us-ascii?Q?81Ncn0CbeddQNSrwZJRgjlBurpzFvZ/3WMySqZVA+Qrq4HZdw8AoZJFrsCUM?=
 =?us-ascii?Q?DFHu1HvU3p9KDuFnLKJYUBim/4is3tH+wKURCLqeBdIyTQFabEf1CX8Bv7QB?=
 =?us-ascii?Q?8+BTjimQPW7YmW6dQUuMDSxnzylEltnwp8bmWs2LVOhOPp3tNQEtxTFrNE6W?=
 =?us-ascii?Q?ESqII91ntKSBFdZ2ih0Fe4k7YYBc4p0MX1Bh6iht9qoSsKWiIuIDMC5dYBuP?=
 =?us-ascii?Q?2VdNmLPuZVEHrVWY1SYs8nUkvMrjet1FW5DdJ0JmfdhlAdiCNnLKfXu5k4uZ?=
 =?us-ascii?Q?Q4PtmeuDchNxPnUnwORzuqVDdGOVv8TQx8yqwh/n7CkAB1tIpaBLqDpV9Zyx?=
 =?us-ascii?Q?E1Aj+11oLJY62oLuT1ZBCtr49ZO/gtGmx6fVczXRCP+hbYBPB0TXGNz8qiJm?=
 =?us-ascii?Q?daxJbXgb5GhuLSF2VR34PQNsjrRlK2EnPAyKbnBn1JqCEb9hb9M2dFVZZmOG?=
 =?us-ascii?Q?G3Hj11YRIFOPRUHjn93wWGLyTswqzZzyRLinTa0HIo6UxFWbdQyGUTXY0P+S?=
 =?us-ascii?Q?HNjJLblHI+hyT09uInqz5qDE1fwIgNM4W/V1M2E2iUzipusNJfaUvO0SN7DP?=
 =?us-ascii?Q?3faAA0S57h0om9qdwzGlRCPdE9yJcdxwbj8XWlX2Ku9o8BY8ABcFsv0yLa6A?=
 =?us-ascii?Q?dV9havauDnjP9U1CkEpKPBaks0iKTOlXwc11bqfB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bca41da-0be0-4213-aadb-08d9d5350176
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 19:03:08.6360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5jMdzlwORXqCPyQFwQE+h25BlnR58gczPtOVilfxk16sHwgZIVHwC5QolgWWoCX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4373
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: EvD5xK_fdARI1DvVbK91iRPtmS4I7a2U
X-Proofpoint-GUID: EvD5xK_fdARI1DvVbK91iRPtmS4I7a2U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_04,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=979
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201110102
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 20, 2021 at 04:56:38PM +0800, Muchun Song wrote:
> The inode allocation is supposed to use alloc_inode_sb(), so convert
> kmem_cache_alloc() to alloc_inode_sb().
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

LGTM

Acked-by: Roman Gushchin <guro@fb.com>

> ---
>  fs/f2fs/super.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 040b6d02e1d8..6cdbf520b435 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1311,8 +1311,12 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
>  {
>  	struct f2fs_inode_info *fi;
>  
> -	fi = f2fs_kmem_cache_alloc(f2fs_inode_cachep,
> -				GFP_F2FS_ZERO, false, F2FS_SB(sb));
> +	if (time_to_inject(F2FS_SB(sb), FAULT_SLAB_ALLOC)) {
> +		f2fs_show_injection_info(F2FS_SB(sb), FAULT_SLAB_ALLOC);
> +		return NULL;
> +	}
> +
> +	fi = alloc_inode_sb(sb, f2fs_inode_cachep, GFP_F2FS_ZERO);
>  	if (!fi)
>  		return NULL;
>  
> -- 
> 2.11.0
> 
