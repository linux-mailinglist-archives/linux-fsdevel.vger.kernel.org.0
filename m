Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73CBD45984A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 00:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhKVXNU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 18:13:20 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55580 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231479AbhKVXNS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 18:13:18 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AMME1Rr028780;
        Mon, 22 Nov 2021 15:09:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=BkK5WLPTTuCyTs1nNkYx/jkwh80Bof3H3+aAhxv31XI=;
 b=Z+d2S0e+3YNNEe42/lz83HORn4kLY5Ntl0CpATc71puCqparEwJ7W+6rn7FH+oSF4Euw
 VetlL3gpBrQtdoFFzwIvU2B0+zlMI23U8fW9UWUqYBVue4JoR1UfBudUNCerLk9NMphv
 yi88pNFCAEdM2lrBf8JPP9bXZtC896C6BVk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cgbsvc51g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Nov 2021 15:09:44 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 22 Nov 2021 15:09:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrnY+oLBBrL4NX/mOMcYB7c56+pSYCnBIU0/M7Bc2kZh/pkaBL+IcXQbMuAC5DNSq7iQV7Wahg8p0K3wz86cwX2uiPwk1LPnQTm60NKhunPt6B9l+Z5KaJTwvTqajGZnLnypPT1C0mdVxHvwIT4Q5/xh6CJdHo8gnp26aoMhCnezHtfoyZjxKB3TObdSxFuftLVt18CD0zuZ03NrPsKyKte+zXesJ6AKnjTRt3tXun2LxchEyI930GkIHG8Pz+P+hfRNgCuKAkCo2DaHybHwLDn5Q1hmkI3QPC5Y6n6KIQePl553GKW0/1lRXY9rMxBAd8UAUAzkM65vUFTNKLPD9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkK5WLPTTuCyTs1nNkYx/jkwh80Bof3H3+aAhxv31XI=;
 b=dwuDwhTww6hA8s9UprmqZeQSDQhnd7j8XeJczy2r1OsIg6MokZCi70cjzExaPxp+kolttT9ObjgIRh8eDOfhpHu1Xmy3eqPl2iicQUwu7Q2FN64L8btpshbYCrw4b98mvBIiSR+t/7ZBfSjxuMwt7AR1+8rpNngt30MW9YPdMyYVpnGaKI5yWjvIy4NMg2MV3hpn7MnmvT4itEE4KrN6DFQTIbVdxZIEtkqd3raAFMm/c+CEFiYOCchV6lqF3HdQFvcuK8U9yPtyzRXaqZ/2SJNwmThHWOZhTmviUcZ2bjkU/ykoQDrlNVEeXup7u4dytzTcA50od21/ROl31JkR/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3127.namprd15.prod.outlook.com (2603:10b6:a03:b0::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Mon, 22 Nov
 2021 23:09:31 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::849b:56cf:6ec:633b]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::849b:56cf:6ec:633b%2]) with mapi id 15.20.4713.025; Mon, 22 Nov 2021
 23:09:31 +0000
Date:   Mon, 22 Nov 2021 15:09:26 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Mina Almasry <almasrymina@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Shuah Khan <shuah@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH v4 0/4] Deterministic charging of shared memory
Message-ID: <YZwjJjccnlL1SDSN@carbon.dhcp.thefacebook.com>
References: <20211120045011.3074840-1-almasrymina@google.com>
 <YZvppKvUPTIytM/c@cmpxchg.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YZvppKvUPTIytM/c@cmpxchg.org>
X-ClientProxiedBy: MWHPR1701CA0022.namprd17.prod.outlook.com
 (2603:10b6:301:14::32) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:dfcb) by MWHPR1701CA0022.namprd17.prod.outlook.com (2603:10b6:301:14::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Mon, 22 Nov 2021 23:09:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b1e4417-31b9-4ca4-fb35-08d9ae0d23ee
X-MS-TrafficTypeDiagnostic: BYAPR15MB3127:
X-Microsoft-Antispam-PRVS: <BYAPR15MB31278AF42F53797BFFC813BBBE9F9@BYAPR15MB3127.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ajLabFBviG3az42tKbYQFtouwwDjCTRW2rGhgRlTOUyo0kQxNDphQG7Nu2zlY3OtVBaIBrSe4Gycotm0bqzR/ZU/T1vfKDtkvvcZvENM29o+Mx8vc0H+QBozj+Wx63bW0SpUhMI0i7xmdA68dbXcFuiV7w9u2TGKkloZaVQ2Vwo7AYpS2ZnRDXDTpPgZj1CvvLSgQ7xSIAck+glHc4xTn7QiISi/7iESEAGqaEKCSJ5QSfbdK96oUY1XN7Xf4ZR5ArTb3ZFRTfkUdD0W66aRByQHQRJmAzG2mDxFKRsB2u/WHx0ThglesUeiBEuec3maaMn1R9gUOCIkTPeYvJ/+945dzvsis/vlEUhumXaTnQ61gbCDrAzXb2VroikpN0jBzg35tMSoT6kukHH87nf6Rdm07P1xFb7L9Pr8uKnDaaBNeg3yIUtTscOrXtEeiq525OKzI/1NX8Y7DpNIUgT5My1z2d+k+fN4Kkl4iWyY0MsTEyxurhkAN5NACofZ2DqnItwxOJ9ufxhXD5jcl1NXlMO722TCj6D3yS0jQlepDwXb5/U58F69OTXYw9RqurHtfv7bTpFAZBRuBMry7oimE/VZS3chE0T1MuaMxNt+Gbu+KmhMpAR1kBqrgsTCQHfNprYIBzhKHI55KWbAiDAlzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(52116002)(66476007)(6916009)(5660300002)(6666004)(83380400001)(7416002)(186003)(66946007)(66556008)(8936002)(316002)(8676002)(9686003)(55016002)(508600001)(86362001)(2906002)(54906003)(6506007)(4326008)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S09zKzhNVEZxOW5UV0JML0tXYXpKUkVKU2ExNXgzc1VMbm12MzZSbGh0dVlN?=
 =?utf-8?B?cHVwa1VXbWRGMnladng3RmsyRmZQMEJnTVNPR1ZwTkpoVGhlZkVGcWt2bzI4?=
 =?utf-8?B?YVEwOE5MeGRlNEdnZk9XWTQ5bWtXazN2dTBRU0RMby94dWs0S2plN0JHbkxB?=
 =?utf-8?B?V1BnYnZwUVErL0hiM2xSRkU1ZTJibmk2aGYvWlVSTkVLTkZpKzJ4MkU2MzlI?=
 =?utf-8?B?UjZyRkNydnBvTXoxTjRqUFBnbVI0clZvejcrRTdIa1MvOFdRYWdwZVB2bUJJ?=
 =?utf-8?B?YkxKbWM4dHViQnplelFZL0J2aElKYkZZcXlMc3F0cEpFdWp5Z1VKMWN6eit4?=
 =?utf-8?B?djBFeUhXRjF2UXlQWEJJbUhVTXNYTmplMTlUVHpiSys5RmdjNHVGcGZ4ejkw?=
 =?utf-8?B?WWtaN2d1VG5DTFNkNzFsVVJaNGYzWEMzQVJab3VDUjF3d21hYVBmRTg1YVZQ?=
 =?utf-8?B?anI5MXN0R1pPUnBVelJIY3VNNHJ5ZGlmUlBxT1ZWMnU1UlkvQ3NwR0thZnln?=
 =?utf-8?B?MWFjdVUyT3V0cDlOTDZxZmlhekpIakhlZlZKKzJ0bDBaR1hpaThHL3AzS21i?=
 =?utf-8?B?TU5UV1paTGlOcVA2SFJ2N01hd1RjVFBiNW1kZ1l3eWc4dURqU3FHMHk0U1Bw?=
 =?utf-8?B?TWdoNGJYYzM1SU00QTh6aFJUMDhmc1pESTdYNG00YXRQSlExM3FUM1Q4S2lK?=
 =?utf-8?B?SWR4R1o0Nll2UkFSMlVnQWFjSDVHQTIvSitCcFYzTFRKZnJSeEpKOHNlNTcv?=
 =?utf-8?B?UllYVi9BRjNaSklWS0FFZHo0MTBlbVRVOTloY2ZJbkNUUVJCRVhjeDUxU29l?=
 =?utf-8?B?MEFYZ011Y1BIa2lpdzNObk9hMGdvQXdZNzhJRGdxVTNFdFNvRi9YNUJCWUE4?=
 =?utf-8?B?Z3J5bURRNTh5S2VBMk5qOWpUQWRJQkdzNDdzdWpFelhxcWcrdFZOUEtwMklG?=
 =?utf-8?B?MjhYMUhsbHp5V3ozSU13elVpQUtnOVFYR2xzSEx5V0h3ano1QkVQSHl3UE5o?=
 =?utf-8?B?cFR3ZFJKU0pTalYrd3dFSnd4aUtPZ2t4ZUJjWEozYmQ5RzByOTkvbXhXeDJU?=
 =?utf-8?B?bjdpTmNUcm9RYkNIUDFoYWhFcHNyYlBVWERPWVhDUVR1VDZiRk9BQmt4anJZ?=
 =?utf-8?B?YnVHU3hKejNtbG1QUmhwMXFTYmxtcFBIUDgwRlgxQ25nczhQYXJhR0F0clFw?=
 =?utf-8?B?UWpYNUVCVHBxd2VPaG1Wa0h0S0JPazQ0U2NKSFpJLzZtci9aVU1hL2FNL0tr?=
 =?utf-8?B?cEM2VU15YkxDRUN1RElBZUpaNXlsck9BV20vM1JzVlFIQVF3QUpYZm5Dekxy?=
 =?utf-8?B?QXNzdHVrTG9OTkhyUW5WZHpJb1NlRVNkMjZ5UE56Mkllb2lxcmxOUTN0WU5V?=
 =?utf-8?B?UGRxMUVOdjUwYndnek9rMElKV0hLZi9UNjgwRUxDcGNyZjZyUnlSektYLzRW?=
 =?utf-8?B?c3ZDczM2KzF4NUg2V1NOUnBsdmxXeUxrZENKMi9PNkc0ZzgyMTlTYzlhUkdJ?=
 =?utf-8?B?WHhpQ1RpbHBIS3dRaCtxZFpCNXR5RmJ5MTdoRCt4ek83bk9nZ3laMXlJOG1h?=
 =?utf-8?B?RE16WGZ2MUxKMTJHVEQydFp2UjNWRU4wM3lWRnlReGQyMGg3T08yUDJXNjUy?=
 =?utf-8?B?eHl4K2RjYlNyRkk5MUgzR1oyZGdqV3JPTGxxc1hxTWtIZWEybEp5RzNEYXp1?=
 =?utf-8?B?ZkJpWlF1YzdJbExaUUV3UElhampQR3laZlIveVYzdSs1VWxuUHcwRGxERy9k?=
 =?utf-8?B?eUJuazB3clVNWGlrSnB3YjdOQUVseXJmdm53MS9WdjJHeWhIYWtwYUxxRkhR?=
 =?utf-8?B?Y3JJaFlGL1RLS3A2dFJNTTg0aTVXNnNKMzV4Wlc5U0IveG1HajNOWDd5K2N3?=
 =?utf-8?B?d3ErUFgyVnh2R2ZCTUVWeU9mTGdCOTlzRlh0WTkzUTE4czIreU9za1dOOEVF?=
 =?utf-8?B?VkVhZkgrczM2eEJWQW5PQ21Pc3RXSkFEK0crYS9ueVpwQXF2Zzg2bS90cDVG?=
 =?utf-8?B?Mm9VanVJdDdxaGtKVlh2eEl5ZDkyK1FhQUJLRGw2b2gvN0hUY1ZzamVrTXd5?=
 =?utf-8?B?eFYxYU8xdFFSYTQ0TnB2eHRqNHNyNCtnREJ0YVpTaDhjQ1VHUmtpazRpL1hY?=
 =?utf-8?Q?RSLS2Zn4Z6eYadoEqgTzpAPAt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1e4417-31b9-4ca4-fb35-08d9ae0d23ee
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 23:09:31.2856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4dObVA78KygKPDcDZ4hV1LB2/wyo+faw4pAqG8n4qIP66VKXsTDhb+IUpqVgIf5k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3127
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: Yrn6hCiUKI2Etq8q4gsQAqAsOk9oCUTy
X-Proofpoint-GUID: Yrn6hCiUKI2Etq8q4gsQAqAsOk9oCUTy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-22_08,2021-11-22_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011 bulkscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111220117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 22, 2021 at 02:04:04PM -0500, Johannes Weiner wrote:
> On Fri, Nov 19, 2021 at 08:50:06PM -0800, Mina Almasry wrote:
> > Problem:
> > Currently shared memory is charged to the memcg of the allocating
> > process. This makes memory usage of processes accessing shared memory
> > a bit unpredictable since whichever process accesses the memory first
> > will get charged. We have a number of use cases where our userspace
> > would like deterministic charging of shared memory:
> > 
> > 1. System services allocating memory for client jobs:
> > We have services (namely a network access service[1]) that provide
> > functionality for clients running on the machine and allocate memory
> > to carry out these services. The memory usage of these services
> > depends on the number of jobs running on the machine and the nature of
> > the requests made to the service, which makes the memory usage of
> > these services hard to predict and thus hard to limit via memory.max.
> > These system services would like a way to allocate memory and instruct
> > the kernel to charge this memory to the client’s memcg.
> > 
> > 2. Shared filesystem between subtasks of a large job
> > Our infrastructure has large meta jobs such as kubernetes which spawn
> > multiple subtasks which share a tmpfs mount. These jobs and its
> > subtasks use that tmpfs mount for various purposes such as data
> > sharing or persistent data between the subtask restarts. In kubernetes
> > terminology, the meta job is similar to pods and subtasks are
> > containers under pods. We want the shared memory to be
> > deterministically charged to the kubernetes's pod and independent to
> > the lifetime of containers under the pod.
> > 
> > 3. Shared libraries and language runtimes shared between independent jobs.
> > We’d like to optimize memory usage on the machine by sharing libraries
> > and language runtimes of many of the processes running on our machines
> > in separate memcgs. This produces a side effect that one job may be
> > unlucky to be the first to access many of the libraries and may get
> > oom killed as all the cached files get charged to it.
> > 
> > Design:
> > My rough proposal to solve this problem is to simply add a
> > ‘memcg=/path/to/memcg’ mount option for filesystems:
> > directing all the memory of the file system to be ‘remote charged’ to
> > cgroup provided by that memcg= option.
> > 
> > Caveats:
> > 
> > 1. One complication to address is the behavior when the target memcg
> > hits its memory.max limit because of remote charging. In this case the
> > oom-killer will be invoked, but the oom-killer may not find anything
> > to kill in the target memcg being charged. Thera are a number of considerations
> > in this case:
> > 
> > 1. It's not great to kill the allocating process since the allocating process
> >    is not running in the memcg under oom, and killing it will not free memory
> >    in the memcg under oom.
> > 2. Pagefaults may hit the memcg limit, and we need to handle the pagefault
> >    somehow. If not, the process will forever loop the pagefault in the upstream
> >    kernel.
> > 
> > In this case, I propose simply failing the remote charge and returning an ENOSPC
> > to the caller. This will cause will cause the process executing the remote
> > charge to get an ENOSPC in non-pagefault paths, and get a SIGBUS on the pagefault
> > path.  This will be documented behavior of remote charging, and this feature is
> > opt-in. Users can:
> > - Not opt-into the feature if they want.
> > - Opt-into the feature and accept the risk of received ENOSPC or SIGBUS and
> >   abort if they desire.
> > - Gracefully handle any resulting ENOSPC or SIGBUS errors and continue their
> >   operation without executing the remote charge if possible.
> > 
> > 2. Only processes allowed the enter cgroup at mount time can mount a
> > tmpfs with memcg=<cgroup>. This is to prevent intential DoS of random cgroups
> > on the machine. However, once a filesysetem is mounted with memcg=<cgroup>, any
> > process with write access to this mount point will be able to charge memory to
> > <cgroup>. This is largely a non-issue because in configurations where there is
> > untrusted code running on the machine, mount point access needs to be
> > restricted to the intended users only regardless of whether the mount point
> > memory is deterministly charged or not.
> 
> I'm not a fan of this. It uses filesystem mounts to create shareable
> resource domains outside of the cgroup hierarchy, which has all the
> downsides you listed, and more:
> 
> 1. You need a filesystem interface in the first place, and a new
>    ad-hoc channel and permission model to coordinate with the cgroup
>    tree, which isn't great. All filesystems you want to share data on
>    need to be converted.
> 
> 2. It doesn't extend to non-filesystem sources of shared data, such as
>    memfds, ipc shm etc.
> 
> 3. It requires unintuitive configuration for what should be basic
>    shared accounting semantics. Per default you still get the old
>    'first touch' semantics, but to get sharing you need to reconfigure
>    the filesystems?
> 
> 4. If a task needs to work with a hierarchy of data sharing domains -
>    system-wide, group of jobs, job - it must interact with a hierarchy
>    of filesystem mounts. This is a pain to setup and may require task
>    awareness. Moving data around, working with different mount points.
>    Also, no shared and private data accounting within the same file.
> 
> 5. It reintroduces cgroup1 semantics of tasks and resouces, which are
>    entangled, sitting in disjunct domains. OOM killing is one quirk of
>    that, but there are others you haven't touched on. Who is charged
>    for the CPU cycles of reclaim in the out-of-band domain?  Who is
>    charged for the paging IO? How is resource pressure accounted and
>    attributed? Soon you need cpu= and io= as well.
> 
> My take on this is that it might work for your rather specific
> usecase, but it doesn't strike me as a general-purpose feature
> suitable for upstream.
> 
> 
> If we want sharing semantics for memory, I think we need a more
> generic implementation with a cleaner interface.
> 
> Here is one idea:
> 
> Have you considered reparenting pages that are accessed by multiple
> cgroups to the first common ancestor of those groups?
> 
> Essentially, whenever there is a memory access (minor fault, buffered
> IO) to a page that doesn't belong to the accessing task's cgroup, you
> find the common ancestor between that task and the owning cgroup, and
> move the page there.
> 
> With a tree like this:
> 
> 	root - job group - job
>                         `- job
>             `- job group - job
>                         `- job
> 
> all pages accessed inside that tree will propagate to the highest
> level at which they are shared - which is the same level where you'd
> also set shared policies, like a job group memory limit or io weight.
> 
> E.g. libc pages would (likely) bubble to the root, persistent tmpfs
> pages would bubble to the respective job group, private data would
> stay within each job.
> 
> No further user configuration necessary. Although you still *can* use
> mount namespacing etc. to prohibit undesired sharing between cgroups.
> 
> The actual user-visible accounting change would be quite small, and
> arguably much more intuitive. Remember that accounting is recursive,
> meaning that a job page today also shows up in the counters of job
> group and root. This would not change. The only thing that IS weird
> today is that when two jobs share a page, it will arbitrarily show up
> in one job's counter but not in the other's. That would change: it
> would no longer show up as either, since it's not private to either;
> it would just be a job group (and up) page.

In general I like the idea, but I think the user-visible change will be quite
large, almost "cgroup v3"-large. Here are some problems:
1) Anything shared between e.g. system.slice and user.slice now belongs
   to the root cgroup and is completely unaccounted/unlimited. E.g. all pagecache
   belonging to shared libraries.
2) It's concerning in security terms. If I understand the idea correctly, a
   read-only access will allow to move charges to an upper level, potentially
   crossing memory.max limits. It doesn't sound safe.
3) It brings a non-trivial amount of memory to non-leave cgroups. To some extent
   it returns us to the cgroup v1 world and a question of competition between
   resources consumed by a cgroup directly and through children cgroups. Not
   like the problem doesn't exist now, but it's less pronounced.
   If say >50% of system.slice's memory will belong to system.slice directly,
   then we likely will need separate non-recursive counters, limits, protections,
   etc.
4) Imagine a production server and a system administrator entering using ssh
   (and being put into user.slice) and running a big grep... It screws up all
   memory accounting until a next reboot. Not a completely impossible scenario.

That said, I agree with Johannes and I'm also not a big fan of this patchset.

I agree that the problem exist and that the patchset provides a solution, but
it doesn't look nice (and generic enough) and creates a lot of questions and
corner cases.

Btw, won't (an optional) disabling of memcg accounting for a tmpfs solve your
problem? It will be less invasive and will not require any oom changes.
