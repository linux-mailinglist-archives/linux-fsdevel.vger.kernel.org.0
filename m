Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6620F48B7BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 21:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241359AbiAKUAs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 15:00:48 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45974 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241239AbiAKUAr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:00:47 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20BJO18g015930;
        Tue, 11 Jan 2022 12:00:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=lIpzTo9KWrCrmafnbDyvx8Aq37PFwj21Qfi7FTNrOW4=;
 b=rSk6U4EZ9L823i9y43/k4QdCVeHgctV2H49SZorWWCqY09Bkv/sDYJ3z9N1loKB+91wy
 ki3u3o1/pHHBndWW6E6YKIUSvgVKtSbrAqm6gupk82jw8xEeOgxB2BnZWINOV8V9Jdla
 5HV+gLxukqHwPIKmFyZP47y29o+lB6b8h+U= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dhg0v86rx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 11 Jan 2022 12:00:34 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 11 Jan 2022 12:00:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9gw8wT7jy0L5JCBj5tOgP068XxVGAQmtP4xRPVYqBzTOBOz5gQ1425aoyzDdFhIREdo+odJgyk1WtQfNOuXwTmoN/XCmF5XYNaUuOBja54H9Pns+Zo9ONMkj2Akb6BfNwLJrV33+qZhANJwuufRFQB0JxffW09wCMSX2yysdE8JKxw8ky2sQeHRHV+Cd1RmGTLsYamV6r5kkWEZTRfhJ1Z+O59Yt5fD6siNHV/Z8LpqV2PQ40WWLiiSQ6zORsNWpBiqba6mnsJiEqFWi/9TH4B/aCwBv5lRqtcQvxm4QzGGzuLfj+6Q+Ee7M0LrVsrUTQbSw8AoLE5HUmIbPQBjaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIpzTo9KWrCrmafnbDyvx8Aq37PFwj21Qfi7FTNrOW4=;
 b=VWIk73bSp2/LHzp63Up/jeURu3UPbpGhv0tC+kpDT2KKBkf826QDpUx1j9XLF1R04Gj9DjxuaVVLfyiTAx2hBPW49J1IBypMSF0b1mzG12xKT/IzxrWnXuqC4m6+OTn/TI7fZCa/AixiOZRC6HpU6QDV5zXifXdNafEZe/FWS3S7lQ4t2k3YWpwY8NCstb5mnXRrPcdxC3PcrhdMxJr85lVRvZm24a9WLojuY5QbsL2A/ASYVYZmMlbbty+YiGwzUJOpdfPKNdLUTjmKtgxJzxGSbtxs5IMVPdGbMsoIZtLDAfG1P3oirBiRY9ak1mm1p9p1BUhugofRM0xQ36KKOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3125.namprd15.prod.outlook.com (2603:10b6:a03:fc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 20:00:31 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913%3]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 20:00:31 +0000
Date:   Tue, 11 Jan 2022 12:00:25 -0800
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
Subject: Re: [PATCH v5 10/16] mm: list_lru: allocate list_lru_one only when
 needed
Message-ID: <Yd3h2YwGIZs1A+2s@carbon.dhcp.thefacebook.com>
References: <20211220085649.8196-1-songmuchun@bytedance.com>
 <20211220085649.8196-11-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211220085649.8196-11-songmuchun@bytedance.com>
X-ClientProxiedBy: MWHPR12CA0054.namprd12.prod.outlook.com
 (2603:10b6:300:103::16) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63165696-02de-4a48-4afa-08d9d53d0564
X-MS-TrafficTypeDiagnostic: BYAPR15MB3125:EE_
X-Microsoft-Antispam-PRVS: <BYAPR15MB3125BB7CD010A38F57D8EB2DBE519@BYAPR15MB3125.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M1P3gkvvNNy6LGr3tTyjg39Uo0xfxTOHKr/w/1IegvMJJJq/SBfagLsVBBwAV5zxh1laViTFTUw2aXfjpbMb2sXT93DCysquhmDCITgE0LM9q/8gvH6FCj7Rfe5h4/wS6l8xyCSRF6I8z/U3HVmx0skpNqeoEAO5lykoes2ZeEg238vYPxJbzEziymDgTnRnwkQijHTswQcNbfv0nfZ+DP5NBtmfqp5unLcW2wkvUNoFZD1uSz3viLeTHT3bCsXAplWUAIPcjiRnaGCn+WrdiyCA0lW1/pDG+KbyxhMFFyLocNyhuZlVV/3tlF0CQa89lYTB5ESnzk3Rak+Jj2BVZdx0eYcWY750pA20bOZh+68Bo5/2zYcwiA5sk+vMNGGpA9Yoq2VoULzODLEDtouus8PriKiAzWHAOynUqF2hII7pPX7BjnURlbQyejUOLtaAoDhlIZikVaX1goPoJDLhJJWKrAvUxYOHC/CEJyqphs18bXY3qtWtSRBT+nNu8vtCmu7sBIzbBvFhSwTGcxQ47jjVJ7P6OBewuhrjP9GI4A5QVrN5WAH++Xv/MfhT8d7N+pWAT6MENTzo5TV2HT/abXLgAqfdgPUGcchJnz+vvR8khP9nab5QiBseijOk0O+OCXzyx+QATiAaYCkNcdR1Texk2ys0FAhwe9e3KPsC2mRJdbJffqMQqHrB2BIUrzrc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(8936002)(316002)(83380400001)(2906002)(66556008)(6666004)(66946007)(5660300002)(8676002)(52116002)(4326008)(38100700002)(7416002)(6506007)(6486002)(6512007)(6916009)(9686003)(186003)(86362001)(508600001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qxd9HYN66bOS0O1JalOWUXsbvedp81X9hdcKxUUclLlugrq2WnPl5UXEssFd?=
 =?us-ascii?Q?M/5QABebkdwYDxoasgQc64L5DsLHgeOW1uz/QfeWv1drevSpGBPwfJsuwwep?=
 =?us-ascii?Q?vRMMHXXyIK5QbMEJF6x2rIJR5sLmR2WJdA/d47+Mu0LI6B/OB0ADvhFSAwSB?=
 =?us-ascii?Q?OCzJRVw73Z0052U5ewFzP0KvZlvP0zCcWWAhb9UXU+e5I2sSQ7InsJsnRt2r?=
 =?us-ascii?Q?Xn9Ar7Biuv0tCs3PWII/qFCnlbS4MxqDXl5cUlkDsEdj8Mr4Ly7rNEajXTGR?=
 =?us-ascii?Q?lEK6iwW7wlnSlYzxhw6uBMOdbJdo+k11Y6ukDz6VjwylArYkZhWSYbFJ3Z6c?=
 =?us-ascii?Q?uyfDdEGW7htaap8Le1X2lp311ttU/ozR+SUynArzS/dEaBHzelAai0glZnE1?=
 =?us-ascii?Q?wpuK/7QlWDJUlmuo8T5VKjtsHfCU27RSKl6k9YSMZ0kJShuv+wRJY+PdYZDc?=
 =?us-ascii?Q?/rl/VzitEtstl9Zia/JFu5ocm9v/os6DjEWJPzelU5jYm35nNm/RzHBMioyt?=
 =?us-ascii?Q?LZio2EzAaNs6WVHb7GXhH8TpjY6jn2Z5826bsdn+zt36lk628x1mvHJ4pwZm?=
 =?us-ascii?Q?bum9HFQpIMXeUP/TU85sjuhAed1baqHqByeJn2Mtpx8MMyLFPT0Ero/CUAg9?=
 =?us-ascii?Q?yQkVjvdUyO8iG6WnUNFTMqnpMqCurJv5znPnS3aRztb9mrJLAe9ZGwO2FKCF?=
 =?us-ascii?Q?SM3qN6dq+UMpFoeoO0VxEX+vARvb4tMTg8EGsph82REMXFkfh00J/0NSCnPz?=
 =?us-ascii?Q?XHA76aNn5a61EwpR+4lwJW7cn4qE/ujpn8D7e1bmn7f86sMN33ttggXtPYa+?=
 =?us-ascii?Q?IQICw1sIq9QXiS+aZoiDZ1cmAfaA4wqdsSe0PxOmEeQJRkW60ikFwqQFMDnt?=
 =?us-ascii?Q?oIw6cFbxw6Je0qHtI4WHEX/HoZFYSdIWgi56SXNbUKfiXN0/5VrLkMhhaeT3?=
 =?us-ascii?Q?ZfUo6Fj0xB7XIKjxI5r1B24uz235l3j2KwZH5yaU3Z7zTINCqthmE+9CHnVe?=
 =?us-ascii?Q?dLbk0V3YBQnKSjf8DlgYqLKsrLTjVRSHO+c1GEwnITU1VaN/PzG1l5sME9TL?=
 =?us-ascii?Q?fTI6fe1H5rWeB3zj01KuY7jJY+tZfSZBKsqOIe8Q5nPHYj2c9x+NoKSQ+QfI?=
 =?us-ascii?Q?Y64hZjQisLTA6Mu/8HjosdhctoFPW2LxztwdMjjqfAALkupK7ISZUdPTpo9X?=
 =?us-ascii?Q?FXiRFrPl8ve2LkLea4nbWOJb62qRWDH+cEOPH8KDyW3s+909qqgi+YbozG1T?=
 =?us-ascii?Q?RB4pZmmQmNvYqiB9t8e80S/q916R2Vm0x97weAJl5aNOUHAb3/U/mH53Qmqj?=
 =?us-ascii?Q?4EA7Y/V6iigym1/I7G0jZ3mEOZs42EBn5CJ4eeI77KRaMrTDzOp5Uorzk0Aq?=
 =?us-ascii?Q?0pdasKs2i8OMbhGYyDvKjiCG0EDedfMH6TKMKZ/ZaBTffR2PUQtJJwIJ+KAB?=
 =?us-ascii?Q?VvoSdPeHUXAHPCu4xMZufno8anPMVZlx/MtT5EY+hnMSFhpiC6NkivLigbHG?=
 =?us-ascii?Q?zW4GvUqWgzB5yA6AKtG951aXZepj7AA8zq5m3zqVBAs5UMODWdoPr2POAnh4?=
 =?us-ascii?Q?WUXwaEJVU3655Ih4voU4BwA/iNozxIffuZm+vuK+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63165696-02de-4a48-4afa-08d9d53d0564
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 20:00:31.2940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IHHJILAXVzfqFWszHVRfwX8gz3PRttP9Od5FY5Xeu3Sc2o8Un3tVLsL6kPn11v6f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3125
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: bFokckKKrQ5YAOzxicQTugdD-CDDwhhA
X-Proofpoint-GUID: bFokckKKrQ5YAOzxicQTugdD-CDDwhhA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_04,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 mlxlogscore=740 priorityscore=1501 clxscore=1015 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201110105
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 20, 2021 at 04:56:43PM +0800, Muchun Song wrote:
> In our server, we found a suspected memory leak problem. The kmalloc-32
> consumes more than 6GB of memory. Other kmem_caches consume less than
> 2GB memory.
> 
> After our in-depth analysis, the memory consumption of kmalloc-32 slab
> cache is the cause of list_lru_one allocation.
> 
>   crash> p memcg_nr_cache_ids
>   memcg_nr_cache_ids = $2 = 24574
> 
> memcg_nr_cache_ids is very large and memory consumption of each list_lru
> can be calculated with the following formula.
> 
>   num_numa_node * memcg_nr_cache_ids * 32 (kmalloc-32)
> 
> There are 4 numa nodes in our system, so each list_lru consumes ~3MB.
> 
>   crash> list super_blocks | wc -l
>   952
> 
> Every mount will register 2 list lrus, one is for inode, another is for
> dentry. There are 952 super_blocks. So the total memory is 952 * 2 * 3
> MB (~5.6GB). But the number of memory cgroup is less than 500. So I
> guess more than 12286 containers have been deployed on this machine (I
> do not know why there are so many containers, it may be a user's bug or
> the user really want to do that). And memcg_nr_cache_ids has not been
> reduced to a suitable value. This can waste a lot of memory.

But on the other side you increase the size of struct list_lru_per_memcg,
so if number of cgroups is close to memcg_nr_cache_ids, we can actually
waste more memory. I'm not saying the change is not worth it, but would be
nice to add some real-world numbers.

Or it's all irrelevant and is done as a preparation to the conversion to xarray?
If so, please, make it clear.

Thanks!
