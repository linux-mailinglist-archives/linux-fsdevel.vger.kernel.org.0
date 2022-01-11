Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C3948B678
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345967AbiAKTFu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:05:50 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20542 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243166AbiAKTFs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:05:48 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20BHRiMj014670;
        Tue, 11 Jan 2022 11:05:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=gMp0mSj6rRQ4vl+zhxXauyXdqDOZegIVvN8LXJQ5lGY=;
 b=q1c5byqTY1ttilrLC3YLdgdbI4wCuyW2rxiYbOHDR5zfaZNjsPNCHKUoCAJhhu/D5Jyz
 blXW1m6DPpoDCAQJdzZz4mUQ+sgOlM5GggqOJCRvA3h0OSr20MZCmvIeyG3U7jLCqHQK
 //E2IpH1kFVaccM01e2QZqUm9/jQPW+hu2k= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dgtffg0aa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 11 Jan 2022 11:05:37 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 11 Jan 2022 11:05:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3aMGq9l8mJzSEJNCntTx2uWjsvI/nJDN/Gsq/vAnDSv+YQ/m0WCzdm6sv94Drfb4THT7ch12eov+a8JpbjA7VU8Fnx22X9X+fX/e2SYcV04o8KLgnc4I4efLGDy3/+24uIsn2Rk18sVrTllWy8kwI60bIsGDAIwftPntkFIvOX0RVI7iE//SEnVf3sPvl1OV1gDGA9IBwamDUthm5V6ZnZBuz1qYIa6PzIioV4Zoxxrm4YNS3TlGpQ4RBpzAwraloeHGZCkZ/vnOC8UJOjuIYx4zlPO8VhvMz5DWkgZCDjRNRz9t9ockC74M7VjPzYRZSNlHgKze4otemy9B4Nbqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMp0mSj6rRQ4vl+zhxXauyXdqDOZegIVvN8LXJQ5lGY=;
 b=IvJzFA3Ax2kJRkfwfm9Xm1p9dsoy+itA2WeJnKb5yYcU0w2DQMyOclb5D8eSxUrwX37cBW2hBr9A1C6xABjcjlfZjVV4W3BtZ1sdveIj9oNnEoKAoInCYiRxXNTVivP2sENHYB0VIpJvEWMVKoRPz4oSfItR/mszImEf0nTiBQMFKvJ6dhXmGvB6hhvc0+MOE/aU60/e/BH4PA6Tb/CTAb8ZoOSte0Xw+ZWfQHaRj4+vQvmLmWAjPNqaba+VvEJVNA8G1eXcdYosMY3AVaqgRTG5x4izAn+wwlBdJRWrSMCzNDdBuUdJlUaXmok50/ag5bm9BuGx36jYA2DRcWuLKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2600.namprd15.prod.outlook.com (2603:10b6:a03:150::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 19:05:34 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913%3]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 19:05:34 +0000
Date:   Tue, 11 Jan 2022 11:05:30 -0800
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
Subject: Re: [PATCH v5 07/16] mm: dcache: use kmem_cache_alloc_lru() to
 allocate dentry
Message-ID: <Yd3U+jr7gFXlTYTK@carbon.dhcp.thefacebook.com>
References: <20211220085649.8196-1-songmuchun@bytedance.com>
 <20211220085649.8196-8-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211220085649.8196-8-songmuchun@bytedance.com>
X-ClientProxiedBy: MWHPR18CA0031.namprd18.prod.outlook.com
 (2603:10b6:320:31::17) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f931779-853e-4f7e-dc48-08d9d535588d
X-MS-TrafficTypeDiagnostic: BYAPR15MB2600:EE_
X-Microsoft-Antispam-PRVS: <BYAPR15MB2600200FA352566399FC0B18BE519@BYAPR15MB2600.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /O8Xc2+ZHC3ACSgpfPFRUEaCfFXcTbAR4A8J3MRTuDdAdFIJy7vu16ZdKMW3QXbjUw37ZPi48g4TIgSBG9TkYM2nuPistkj2tQOunYk8ZIVoOJIyrGWUNzi2kKCM/0wSr4rZ5tdxZqOICNZUgJVbQSjo8q5OiPGOWPU/nUy7Lt00IYUYGj7Z2zEmx6Mue0upa9W+EEdlk69vpp9F1JV9XExQwbOoLlro/q2dLDbhe80gTb8Bss2mABqREf0qqmRpMZ5PyC43wCetQ8kK3AJOaTsgdIOrR0QcL1bgAGXIa/ZTUyDao0eLXIUM3HxreCfwGfBBljnYkxVENpXS1YHiAFECByIY1hf93efTCEmJQ2BqJenbO1dvGc6HHNiqCYDFcG3/7qELWpwu3bHyhKOXV4lZGMTGdiLmDr7J/+4sc/TvzsRLiV3aKR40SY1sQnfDAY/z6yVwHBeVhwR/WI4MsnuxoX4RF6JZEmXD6braadbiNbbLQ8rrUK+BKUCL3nUSWITT7Vlm7vIRTXhFCggwHLtNFt2XeSJDFgxcSeC9RPtQWndT6ijLBKzqVs7DRBFs2e+jLFZtUsei66SAGyejiXyJUbd3V/7OLUMWO6Ekx3JL90l6Mc/IUhmQCsSrH82fIChoRC8bjp6cIXO4if7GkAsLqXkssmMicQCIwgt80tZpNxA95Ph7S9jQPWlrdB1e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(6666004)(9686003)(6506007)(6486002)(52116002)(66946007)(66556008)(4326008)(66476007)(86362001)(186003)(8676002)(6512007)(2906002)(508600001)(5660300002)(316002)(38100700002)(4744005)(6916009)(8936002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ti2yoURZvJNrzPBiaTuz7i0tztIIbcdCiNk62zGnbehZZLix/fYbZV/dqNib?=
 =?us-ascii?Q?KrZqLb/jpYIcjFRrx+pKFMvenh4mbo6JCZTPjiDiNOX07djpIOYfBYjsGE7C?=
 =?us-ascii?Q?/72NSE1yyzmthO3QdeM0yIrpMPN+s6uxhjJzXu758EwTTpdPWPwOBpz4OXJw?=
 =?us-ascii?Q?AyHo7zYm4lVXwsZe5Buxlf5YYi2ldX0tNiPTf3Hl4VkA9h0zebk8EOAv+dEs?=
 =?us-ascii?Q?JfMIn0wx9crYH7iftA4hCRnbhDXvMA9lSyN6p6CBuJoIBB2oeXSrJLDh5lBm?=
 =?us-ascii?Q?jAqW1/erNBoN3Mag1T2uDwa/Noo/NjFnzVZ1cqA0OhpDQksuLK/htsqZB7e7?=
 =?us-ascii?Q?jnMCbMyYOd0ne/d4tVbddqJwv9Ol2vLsrQC3wjykWNgtFP0a7b+3CFFLszeE?=
 =?us-ascii?Q?44txh5OJmvFC8SFauxxdflUbGTfMJb3wXdyFO02jbJU3Os/+SChf7g9WBduu?=
 =?us-ascii?Q?mWrzdqzETqNGg3jl/D/isJgY29uppSrF9KYh+1Ru43oY89JjpAUsvNN+7scr?=
 =?us-ascii?Q?9glCg9xvpCcmkIY7D4U78d8MvFCBTdDKSo19+o0jeuSGcAv3bzdMZ+vT8vsN?=
 =?us-ascii?Q?GnXmlNhWKaY6W6EVu1WtKT5i+apHCBpXpjhWLr+6hy0DAVG911uplxbHECYy?=
 =?us-ascii?Q?vKI2yK4PAzAWbLNSfsYGX/R3lf5VmAcShTq9lOp//NeqmgXdCVEZd1UbwjlU?=
 =?us-ascii?Q?ig+aI9vpbWfrtRPuXMeZAnLq3G9JZOn04Fu2xb8tnFQpO/7Ufxt50LNjSDZy?=
 =?us-ascii?Q?dT7fNGkHxcfXG73OFuEMYskrcsuGSGBfUjmG9eNMPrOnm1MP6USSCABXU23R?=
 =?us-ascii?Q?rTfKk/z1iTpWVBkjfBiG+EBZstfkGmdQRATgjNAOmz4xGEbl469Nu1bemYLB?=
 =?us-ascii?Q?xmUIpyHYuLo1yUzttUHEpHXMl02lKh35CS4QhUvWmWqldnj7PZA1gU55mSDH?=
 =?us-ascii?Q?aHiS9Lbrjb0GFq7ehFOYTfnO9Oy/U+FuodwDw6iTL9gxzHp2u3GtuTd0AOYt?=
 =?us-ascii?Q?KaiqGaKQsq+Uj0UBW9nqILD50PlAJCisB9RzI4yA3mTWjGx6ReBTU9bLMXr4?=
 =?us-ascii?Q?zvTem8jjNRKgwb8KtfHX05V/kFDFxcu1XbMqUaXeLNqRR/CBq97ui1Uils/P?=
 =?us-ascii?Q?oQc3WDEvgO1qJSbyVgMxgLjrwQEdwsc28DKtmovgsvwSC9lC1x7CUVIopWyz?=
 =?us-ascii?Q?TQGOLmt2Z6QfmvQsC0lHgUiattJAgrh1u8qAfJiLsawIXAevUuDh1DBRfFJI?=
 =?us-ascii?Q?3IpmGi2JQmnQJm81nq2I2Ce6BnieEzoE4sVXOfCAI10LdkmUUtPT682WngZc?=
 =?us-ascii?Q?YinTjB2k+Bv0ZdNeJw5mQ43z18HOHfk3zyNSs/Hos2iuoPma5ethLzXUYXCA?=
 =?us-ascii?Q?KNw0R6fE5ZlEV8JR3MErdw+zqAOWTbKTbeQNd2tcGprGRpKW+OdI5FV/6ViZ?=
 =?us-ascii?Q?SkYJoLaTqN7zZYs36Jsy++surchq/cZ/j0fPEW5YmDb5AGG7figjZDdKvrJq?=
 =?us-ascii?Q?2Xti5g3Oxp6ZN+5wNS2VzZmZTwrFMpCyVjNokppragsoXMufgFytyG8XfHRh?=
 =?us-ascii?Q?oIioPs+1ZVk+gbjca42IeKZe68UuCiq6Dq+7Q8VB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f931779-853e-4f7e-dc48-08d9d535588d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 19:05:34.7654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WMj1ZPCnR6n1nZmQ0U1rOPAZ9G3iWZYIqqBLkBox3DDKzYhL52nLBRxfSuDFhx7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2600
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: uNBdWnFOz8yTRJL12ctZVoTyBEJ3nZsy
X-Proofpoint-ORIG-GUID: uNBdWnFOz8yTRJL12ctZVoTyBEJ3nZsy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_04,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=664 impostorscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201110102
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 20, 2021 at 04:56:40PM +0800, Muchun Song wrote:
> Like inode cache, the dentry will also be added to its memcg list_lru.
> So replace kmem_cache_alloc() with kmem_cache_alloc_lru() to allocate
> dentry.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Roman Gushchin <guro@fb.com>
