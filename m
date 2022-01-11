Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6177748B730
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350727AbiAKTSk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:18:40 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58916 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350434AbiAKTRs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:17:48 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20BHRjnJ014692;
        Tue, 11 Jan 2022 11:17:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=hZQiIJUm16CqibqNVksTqdV5uktE9Nw2soHeyOqscYQ=;
 b=KzXgSvzNe9y9tDpB9uWr1lJwTFNXPkfADbn/pq4RjvYgQRjPiQ67plwUYT+BEUWPUS7c
 eZpn7dhnhr87fYRgEKc/IgOuVVQ5pa9XA+EYlnBdDAsq4+ukFaK/4P7lAFqLnx7gpy76
 Is+PaS3wFZ9wa0yaEp7nR5HDSF6weY4KOZA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dgtffg2p3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 11 Jan 2022 11:17:34 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 11 Jan 2022 11:17:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqR7+tdk6eUC/ft60N/eclc+I83dt4lpEjUW8/Tr9kZXNZFdzW/qj0EihFKTcit3n3Um/F9r0ztRS4HQWNmEdYy02ggquqHwZuDAT01Vl+toqX9aSIuPbNXYhBV0VBR8bNAdqTP8Ki7EKMU8ZDJkeV/eRls+m87Zcx+YDcqO+o59BQ7BmhincNX4AozV9l1L8B/i5o0T0gjpByDAtXpGRYcfWaMmQ2f8siBGx3n+RSwFQe9QsNCuWNE6a4AZ9HnRYuCc4MDlCjvRsxjaqlS7K59wi+GHHeUDwvoMJRmUb97B8ZNBXaCGwmrLSx2DXc9vHKuFJKcvo4wE6aSqBP5CXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZQiIJUm16CqibqNVksTqdV5uktE9Nw2soHeyOqscYQ=;
 b=mWgF0pfqPNSX3EiaLuimByGKAEt0gNM7wlLxZrLmeUtLwDy8XszEqzuLuDooNS+FeMJafjxOcVbqlp5LNWjmqYUmPdl3mlunLVHDL7gAvX8QStx+WIBYk8oPBTG8xcC8CiXg7AK9sCi3hGArxXKcQmlHQcTmn8c6//zlpDqnXbqNLGQkWQXPTDMgeA4alkdhPWjXFh8PcKDqMqk7jcXsH6DD/P2xupoz4w3pnSuZuJbIOgQ96y+vnX1ONq79f6wbMJq05YLqFHDZraJ4tF6mTl6P9T2tiST5ZsbA1SUQTrUB+47shqcRBCWg4GLCATXrObnv4cJAcr1bk2pVWUsKRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4758.namprd15.prod.outlook.com (2603:10b6:a03:37b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 19:17:31 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913%3]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 19:17:31 +0000
Date:   Tue, 11 Jan 2022 11:17:27 -0800
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
Subject: Re: [PATCH v5 09/16] mm: memcontrol: move memcg_online_kmem() to
 mem_cgroup_css_online()
Message-ID: <Yd3Xx/ZX0CY68bEv@carbon.dhcp.thefacebook.com>
References: <20211220085649.8196-1-songmuchun@bytedance.com>
 <20211220085649.8196-10-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211220085649.8196-10-songmuchun@bytedance.com>
X-ClientProxiedBy: MW4PR03CA0249.namprd03.prod.outlook.com
 (2603:10b6:303:b4::14) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d794c050-54f7-42e3-4659-08d9d53703f1
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4758:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR15MB475842E4894106947638C585BE519@SJ0PR15MB4758.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5PenNlAd+7RyDttUJ9YEyWz7AxPNkOYV3xxfpRuMtR8R2rAPaJ6cIid1Q7pHNlGHCII9XDyuDmPeG/S8y88cHsyF8kP2+jMNkkqhefRYI/sVSWQEKUeqKxajGzFvV/L6lppS43zXn7Xb8A1sMZrmxR8BZAiMoi1vEVnapDzRA508jU4nd5SdnfJ3QRmGVh4pm9jNU025UeDp7vW1KARnqUVn6SOfElB/jJ5Pmr2pxbgy+SFg32V8Nbal4Zcf/UIBoQUyEfDco62/MBlqRPhapcT6KE85v8tw9xwKXtZxAszCBu6WE4xE2hRJMaTdfM6xnnANyvv0KlMaF7SpytRvbkRo7eRUbowLXMl6k5EK6mN04/DSsr2Zx0DyivHoMcaJ9/B9hZeUEE9LdTSAFNJlH95ZhM1vumoB37tlIE4h3BqPvQ5JixTUwDMHWLIEjc09ialV4EE/IJO2mkFkrcEmyug1kGZZ5CLo/CPqjhT50NNPAkvpjNzjVlE3gOcb5mdU6JL8uPBgjM1tW3rtUgoNIdzBHJ8FHQuKR+NEQ1F2jemA0LAcqaxFZNiPs9vkwblEzxENa36kyuHSXETuZgLCG/Dv1SSM2/J9gsKoKFExDzd/7uirz+JjOv7ZkIrZLf9rsMOnPX24VdFNBT2JF56f2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(508600001)(6506007)(6916009)(8936002)(66946007)(38100700002)(7416002)(6666004)(4744005)(83380400001)(2906002)(9686003)(316002)(6512007)(186003)(66556008)(5660300002)(8676002)(4326008)(86362001)(66476007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gsWujptz58ELMLJC9z7hOBAZMgXtrXLI201wwyGtxHPJqC7zMzqVgPl/fGBN?=
 =?us-ascii?Q?Bd+oP1XochIkAzGSdiMkCNczFB89T3cKFQtKpl4qNHYrh0u1Ul+Z0SjxxyUB?=
 =?us-ascii?Q?QtqKoT/4gZ+AzjAMYXOmiLVgQLgL0Vhlrnhnei8zc3cKFTsH86X4+xxwz6JW?=
 =?us-ascii?Q?XxXT8NbB/nkd6/6OY7SQatAM79VYNGyC9iwRfETnBeYC0xHsXrXOkGglgqJO?=
 =?us-ascii?Q?Un1FbOzhcjYkWOYJCJhxvINlwIddtIofdDnUQxPXVRjxkozgOFZjFTM79VIb?=
 =?us-ascii?Q?VMrbhhNA29fWh3usCvP9TBUmhHpRgxGJh5EiXmRRrYKnlEfZheZwUBEUf3P3?=
 =?us-ascii?Q?DwPrLVCFqDOYdCHAJ7/cHvpSBoC2KFqkzlXhfsmdzOiT4bUCVPuk9CIwFTVo?=
 =?us-ascii?Q?w9g9XenIhwQEQVQzu6lD2K2ebpO+bGp95QyGuLSlKS1luwpTp6nMLLimyUzF?=
 =?us-ascii?Q?R4XEKNrq4YFWDtTMjvGydRVLHJfHpE7rxHdpRbuRVj9eFC9/nvJ1rkY9k7wH?=
 =?us-ascii?Q?aDXuzNg1UlC8giKVtvNboUQ/ToqEJZnWkKA8uXAN3/SeeNUad1GnXT4RykNP?=
 =?us-ascii?Q?iWDoKegLLPlFL+eCw/IXIspyFzSnCyRpPm31khuLdVeCFYF3LP6S6SiNcq2a?=
 =?us-ascii?Q?ZgvMD2K19giLxglVM2XlEu5gnb3vxMNqv0Sc/HPPQ7Ft5ALw2lhV8oU2Bwln?=
 =?us-ascii?Q?2hi9LlrLg3RltwX4rmrsnOOmkwMYawJiR58gWbJoL3fBLBEFEAI52cbZHbaW?=
 =?us-ascii?Q?klS3KlZL63o9pLGDliYq2N/gHNqyreTi0wEG0Pys/H0sbTVG10rduaXkR1hr?=
 =?us-ascii?Q?JKz957+nvDbweohap4ep1BE0R8jcg8ntKZIXAPUOy/YjI2+3pzsHZxgNLqgB?=
 =?us-ascii?Q?RBlhronOFa92fCbuyNwy9pjwVIm8MxJoYVlrADqohS8pkcGqMWpFNuC20/pr?=
 =?us-ascii?Q?2p7g5B5KW4HW/c8N4uKJig+oJkGnKBB/ekA9UlMjxjIWfTiY4F4OMIqdNue7?=
 =?us-ascii?Q?791N5ZtIfZ9xcKT/iQUiq4o12sc1s0ToBF9Z/xeJ5AtCVozQHjwGye3FQ/VP?=
 =?us-ascii?Q?BJUJmq1+he6ZM++HkwQKclShtI7JU6n+km0g5nDeT5xsuuZql0wjM7NoU49j?=
 =?us-ascii?Q?D4BgEXQve72X4P3Odkjd/yjE9qTatvfhEujfBsA0EgDKiSNJrwl9u2x/4bGL?=
 =?us-ascii?Q?OUtvEl10n6ZPvxcq56cOOiua69Wp6a7gso9XkAgxBK0f83BD5Tpb3g+w6/qg?=
 =?us-ascii?Q?IpqA04M8nnjDNVgRHSs+kkednjSJCTCTo52g16uFq7meQU7J0o5mjRDQ2om3?=
 =?us-ascii?Q?IfhYbzxS76U1uYE1Ad6KuefBsDcFD2jpoG3gRmSpiFmDi6ALWandnmVptjTQ?=
 =?us-ascii?Q?oLJkXNPPQg90Bha5wsinP0RHAkVyvdIekVyg6BoFXK8NcwPGHIOdK4hCDVOU?=
 =?us-ascii?Q?KKbjn8bSnrNz1hotwnb3/SFsvjLwOWqZeplqRcmu7p9VAtVPwoiISQxkWg4G?=
 =?us-ascii?Q?tU/Y/c7YC42c3bORkefir44P/zDSPBXYJUTDXc9ku3h8RLPNiAQhPmfej/M3?=
 =?us-ascii?Q?hDu7/qTDVx+p5j3jwEucxfNYy499FnjKW+y4NQ/O?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d794c050-54f7-42e3-4659-08d9d53703f1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 19:17:31.8040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqAuhyvy4kgNv3nf+TluuOkYIS8PHDvhTeAcbq3Dmj+GLiRWO+UUacMcq9ZIAkEX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4758
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: Q-S_8XBAe6d4fMyq8vlnx7YaQKlr3DY3
X-Proofpoint-ORIG-GUID: Q-S_8XBAe6d4fMyq8vlnx7YaQKlr3DY3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_04,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=660 impostorscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201110103
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 20, 2021 at 04:56:42PM +0800, Muchun Song wrote:
> It will simplify the code if moving memcg_online_kmem() to
> mem_cgroup_css_online() and do not need to set ->kmemcg_id
> to -1 to indicate the memcg is offline. In the next patch,
> ->kmemcg_id will be used to sync list lru reparenting which
> requires not to change ->kmemcg_id.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Nice!

Acked-by: Roman Gushchin <guro@fb.com>
