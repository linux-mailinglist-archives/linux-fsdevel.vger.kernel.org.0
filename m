Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E46236F3C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 03:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhD3Bk6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 21:40:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11128 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229519AbhD3Bk5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 21:40:57 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 13U1Y6jd000447;
        Thu, 29 Apr 2021 18:39:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=9pKLuu6qVKJN+NaLSAhORU1c12kF7rjFqvqB27StyFI=;
 b=aDe+IdRG8YUpJ9gClrkbj2R0b8bR1Sq4GOIlA8SrBflp50T39FglfDgK13cY0aEFxKTd
 7FzKRw0xomrXryzVvg9cYAoYuqL21nph+qAZ2YnescO2Lm9rRMeaPlkEuTjTIRPh90sN
 yAmaFpnrhdHEZQQOlLWf2Jrlxzce/ejNB0U= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 387ppap869-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Apr 2021 18:39:48 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Apr 2021 18:39:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1hVBBkIktGaCTWBb9Ner5ImzQBvykNYCw3nTNN1sSmvjxDf26GuwOYxVEe/QX6LG3V1CHmBbKcfO8Ihr3rCiyx9/70L/NjbVQaBNJ93FNMlCDXXT6tov8bX+LntOBMecsss7yGd+5FNXIprsjlTwImMIA/7dUPdMCknD+NzG6BEDZbwMp3MA4coF3NyOxPvyqlWYKq3lEhrns1xq908uS0kYK/u3p7M/+LDRoczxqMUAUljmA1TU64P8Oaec9LSig1zxwWDZD6kU/4fdJCL3Ju4NQ+Vm729TL3at4cT2ZmEJHYBc+2gSF7Acv2WQyWUcKAWLNyOb8NPm6jNp5dIlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pKLuu6qVKJN+NaLSAhORU1c12kF7rjFqvqB27StyFI=;
 b=DYng9F+ZwglB8UrmGQgILkpWcJDUH+nxVV1aGYkbjP1g+HQsw8qVX3IJs9oKwj/iwUwwth81FaVG5uc6lDrMMVliMdnf3M/4KwO8Zo9Vfzjq5DkPZMf8ys3v9qIm0FjPSRUN/9JuyeLh8iilAmJtqBmTu3MFXoTTyxqdX3mzLY24UZDizpraz8NEY3tWQPG5M7L7qyueyHVXfTg2s61hrPhxnDJFG9xApKTYe9zRayNFLGsAcqHhMECrqlkhn6gCQP3G2XuQApFWlO4igYVLgz9tfvcTfwzkF8UNO7J6NfNp1uDjWQiIwJlXq9r+IAsIMfRJ4mN2CuIFlY1tbQ8fhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: fromorbit.com; dkim=none (message not signed)
 header.d=none;fromorbit.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SA0PR15MB3807.namprd15.prod.outlook.com
 (2603:10b6:806:82::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 30 Apr
 2021 01:39:46 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::b802:71f2:d495:35eb]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::b802:71f2:d495:35eb%7]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 01:39:46 +0000
Date:   Thu, 29 Apr 2021 18:39:40 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     Muchun Song <songmuchun@bytedance.com>, <willy@infradead.org>,
        <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <mhocko@kernel.org>, <vdavydov.dev@gmail.com>,
        <shakeelb@google.com>, <shy828301@gmail.com>, <alexs@kernel.org>,
        <alexander.h.duyck@linux.intel.com>, <richard.weiyang@gmail.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH 0/9] Shrink the list lru size on memory cgroup removal
Message-ID: <YItf3GIUs2skeuyi@carbon.dhcp.thefacebook.com>
References: <20210428094949.43579-1-songmuchun@bytedance.com>
 <20210430004903.GF1872259@dread.disaster.area>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210430004903.GF1872259@dread.disaster.area>
X-Originating-IP: [2620:10d:c090:400::5:75c0]
X-ClientProxiedBy: CO1PR15CA0071.namprd15.prod.outlook.com
 (2603:10b6:101:20::15) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:75c0) by CO1PR15CA0071.namprd15.prod.outlook.com (2603:10b6:101:20::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Fri, 30 Apr 2021 01:39:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b774137f-21b7-4eb8-1f1e-08d90b78d5c0
X-MS-TrafficTypeDiagnostic: SA0PR15MB3807:
X-Microsoft-Antispam-PRVS: <SA0PR15MB3807AD795C76BA3C5E9614E4BE5E9@SA0PR15MB3807.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qE4nkb3pXeg0/kVp70yZ3u4UKXmEbLHP9iKN0VcCvywIef44m8xJqqiTmTyP8wDaKkQJWdGp9eO61n2Hv+KFrTl7yHMJgUlO+eecLU0QV8XDvtFL9/fD28bCQf+LUB+BaIHDFF+wGnSzOJqU92JPj2lRH3E+yGERh7jFTsI5Pq/kgzIlr1Xe1Y/RM0tY076/6CUSp5mrJ1FBybaAIGzGQR5x1xG3kmZbQMPwPZKa9d7zSr3PHfxt2Kt8RiOUQbtA2194imhdxEinxBl9jfGPQLZ38/Bp+j8AlmkzD8CKsN/3DtSShSHLv+2HC9aj8juXSlGUY96edDRTNh540YVwVAI+TccHaKiDvsxPzDHYV/uozUhXeMYDsef5q+NKzi4TRlHpSut3IBwSCOC5PDFMfLgHOm2PHpM9tLBolxR5Ad4Iv8Y6jidLT9hbys9G4/Mj+0SsmuEPKCkheRGp4DJuPaxk5Eh5yDYg5J0cKObejqy6crmQVaPnXSnKIBp/shLUS05RSfV79GLwDjS5B360fPwd8XUg/3PZvjI5/3bDgOyptSO6PcobTWyFzlNo7qpfMBJtnzlEVfIMnH2OuafAlSgfWOBQiIrO4GJ1dyw0roQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(55016002)(9686003)(7416002)(6666004)(86362001)(4326008)(478600001)(16526019)(7696005)(8676002)(38100700002)(6916009)(52116002)(2906002)(83380400001)(316002)(6506007)(66476007)(66556008)(8936002)(186003)(5660300002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?iZM4msBJzj7xIk+4mzeUAZTl18Ndcy9Cw2fGT3s3//92PxxNbzFQsMgbSmpk?=
 =?us-ascii?Q?P1CWJo00EA7CayXRccFErtPkbHdZ4NuCVVqKLFLRx8BQDE7rTmFr/J+5VN6e?=
 =?us-ascii?Q?t262+G5GzH2uK4chMpKSZAj7dfFUUShKiz1L1raygA+61e7I4A0usjkbBiRL?=
 =?us-ascii?Q?sEu6CN9c+ASv1C+9vy+rXucTpc6myUZghYK5QnELi1cHVEGgNHQ3HwhUFDkV?=
 =?us-ascii?Q?PrLt25lqG4f68hLcTEeYHLZ3LiPOVxiXgJ35GnGnecganvkl0G8qnaG21EZG?=
 =?us-ascii?Q?doqJuvVHkBqAGTHDN8TiTfziVwdnulA7YFgYb9XccebxYAXNFOV+oYYOHLAC?=
 =?us-ascii?Q?j9PnOnIR1xXdPD9h51L98+ngnwgxiexap9fXK6Ln0S64fVYh3T65KGGQmy5S?=
 =?us-ascii?Q?V+hS63rOqSbkWOLN24QkS5Om9los55WXxiV4jDN90mELrckKR6+8CZ2TBZWA?=
 =?us-ascii?Q?vXk1D3BzgIRt8l6DfxUbHv8eU0BCdoh9G5IW3f4/D62NEEU6yHtP9xnRwkFF?=
 =?us-ascii?Q?g4wt447viYmxbP+hWITAz4pjp93jda+UjvozwjE28QyEKZY8HC5bhsLte2ew?=
 =?us-ascii?Q?Rbyg+cBEtJouw4iBZfgJC6nTSeHbB3XOQ9Xv6t+TM8wMrKJl9xR++2TAUDZj?=
 =?us-ascii?Q?FadFyh9RSfWARNohxO6NnmBFnUj+ht3pu6q6AZjDOWPjDuViq6cQRrGSiWem?=
 =?us-ascii?Q?mEiZs4poBnFFo30YqaUCVn2XECBNzo0+ljM35EbLgzyzT4MdscGnqKoW8KzX?=
 =?us-ascii?Q?ueZPGdNoSyXe1nZUOtvfwEb0sTmSKKJ8XTDOS3RpnzTmTKep+0I8L8a/UGz9?=
 =?us-ascii?Q?va3NdRPMr4iArRxgd2Sd5EFUWk0UJcEPnzh5AAc5R8+wm+nXWPzQol1Mb+pv?=
 =?us-ascii?Q?3bnZnky2fkSG1hEawlIfOSaCnHpNy/iQ7sFjuZ1fhi8k1tqf0snIjdfRkkTn?=
 =?us-ascii?Q?EKnYuWFTtsAibBd1e90lNBMnjNo5PS6C5T0oxU2QRnHvvKtK4Y6dEtr9hyUR?=
 =?us-ascii?Q?J72RSXq1t6aXirLxpA+A5NBTAnpIBvGgaUJNXDopnPCUj98KMr1fQ493sfLe?=
 =?us-ascii?Q?cn19XoJZCqmN0GS1wWMBikOE7op1Dp6KK2J7pQ+tVAODX5wB2ttSm4wHWpWr?=
 =?us-ascii?Q?jWCSXblT18wGvKch+9xWOKiuodgwqGnjkQSpZaBNwNZUdSWTW8MSWbSYpZvU?=
 =?us-ascii?Q?uOENN4h96iFUk1fbeOraZ0WNygrqgYZDNlazUUNF46VCM2oauWyISeQ8gQ2i?=
 =?us-ascii?Q?lzDIIvgmwnMyuMn0QQRI1Ne0ssOLnaIae9zEE/WKafix9TBSLiZ93ijgfE67?=
 =?us-ascii?Q?j4PYqYpLtoW6S6rVxY2E6Ok03Pv9hvPvrvSgG5D5svk0pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b774137f-21b7-4eb8-1f1e-08d90b78d5c0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB4141.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 01:39:46.2813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQS4RcFx7SgWrzPktjOHlscfo+B4sg2voiFXyLoQPCm4DMHyUJCvUc16xONPzKns
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3807
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: ijbAF-c7XEtlet3EsFl8Od3ojZ6txGnq
X-Proofpoint-ORIG-GUID: ijbAF-c7XEtlet3EsFl8Od3ojZ6txGnq
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-29_13:2021-04-28,2021-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104300008
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 30, 2021 at 10:49:03AM +1000, Dave Chinner wrote:
> On Wed, Apr 28, 2021 at 05:49:40PM +0800, Muchun Song wrote:
> > In our server, we found a suspected memory leak problem. The kmalloc-32
> > consumes more than 6GB of memory. Other kmem_caches consume less than 2GB
> > memory.
> > 
> > After our in-depth analysis, the memory consumption of kmalloc-32 slab
> > cache is the cause of list_lru_one allocation.
> > 
> >   crash> p memcg_nr_cache_ids
> >   memcg_nr_cache_ids = $2 = 24574
> > 
> > memcg_nr_cache_ids is very large and memory consumption of each list_lru
> > can be calculated with the following formula.
> > 
> >   num_numa_node * memcg_nr_cache_ids * 32 (kmalloc-32)
> > 
> > There are 4 numa nodes in our system, so each list_lru consumes ~3MB.
> > 
> >   crash> list super_blocks | wc -l
> >   952
> 
> The more I see people trying to work around this, the more I think
> that the way memcgs have been grafted into the list_lru is back to
> front.
> 
> We currently allocate scope for every memcg to be able to tracked on
> every not on every superblock instantiated in the system, regardless
> of whether that superblock is even accessible to that memcg.
> 
> These huge memcg counts come from container hosts where memcgs are
> confined to just a small subset of the total number of superblocks
> that instantiated at any given point in time.
> 
> IOWs, for these systems with huge container counts, list_lru does
> not need the capability of tracking every memcg on every superblock.
> 
> What it comes down to is that the list_lru is only needed for a
> given memcg if that memcg is instatiating and freeing objects on a
> given list_lru.
> 
> Which makes me think we should be moving more towards "add the memcg
> to the list_lru at the first insert" model rather than "instantiate
> all at memcg init time just in case". The model we originally came
> up with for supprting memcgs is really starting to show it's limits,
> and we should address those limitations rahter than hack more
> complexity into the system that does nothing to remove the
> limitations that are causing the problems in the first place.

I totally agree.

It looks like the initial implementation of the whole kernel memory accounting
and memcg-aware shrinkers was based on the idea that the number of memory
cgroups is relatively small and stable. With systemd creating a separate cgroup
for everything including short-living processes it simple not true anymore.

Thanks!
