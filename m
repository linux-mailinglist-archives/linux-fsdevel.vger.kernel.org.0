Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B080A48B68D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350392AbiAKTOx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:14:53 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36698 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243270AbiAKTOw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:14:52 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20BHS579028136;
        Tue, 11 Jan 2022 11:14:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=zK8DYImIyjKdHu+0t7fnHAp+LPwJYn2ydR1hVIZKtUQ=;
 b=mW7NHrWQ6B+z1uYFlfKUl0uMlsWldGvWPlofjEYIrQv/zBNL3OJhCTcw/YtpuIVl6aHi
 OODtIpIRjp0KA0lI80hTB1dkgmC8Ga1Q4B5Ugx9aY8f9MiCNzhLI4B1MgBoP4Mdpb1x9
 bFhAqrZYBC/z7OcpmOXZN9Fy6QNntmcDC08= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dgtps7wbg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 11 Jan 2022 11:14:39 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 11 Jan 2022 11:14:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJJWynWHAfvNlh8R4vfPJtqZsIZNGLbhmb4V9k0qvH3XM51hoxL9wddAU9RCckWxTawoGyWVI/Q4ltmw0TWxO0RZjWC/7ab0sxXWNQRQNoqoE+lwoLVDTQBwwpE03nNTOl6Rdz4sKy/4sVp3K9ncDi+JjDsnZxrx8zYECYhaSaM4bm0Poi+nK/URUZYb4NBTdVBueR0jhytKbC+sSf6HV5/wqSHGpsBOd9D0ezt3aCEgAFokFce5nORFDDrl0VI0oS7Ngdyrbq6jDYVNWyPxOVnudhzrcxP/uXxo85C3QUrwwiGjyb6yrQuO9xRfAGaFbpMaR+SbUraMmDwaHQHo3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zK8DYImIyjKdHu+0t7fnHAp+LPwJYn2ydR1hVIZKtUQ=;
 b=FAeg1RtZXcxYn7qw3fUangEv2WD1/T5dDHGQZrlu9xDbYDCQ3DAeR4cd8YGmJJr3RJWF1WHhcYsjFDtQ92GRBE9dD0qvbbjyvcLamWaDGCh7Pws/+uhxobTrOYUDiBaE7h82D+GdiTz7ddBN02h2xGWo7QpHmJLeK9RrN77UdJAdjFqAaYDD0xQcDfyxvLKe++HONIZrLQjOrA6MyAMRhBHyt09yekKdTE+BtYUluO/bW2pXkucTzAgGZx6lkZ/W2kfLVMDM9XdOjmYRQI8f8hD0KO1miQWiyC0X7dCWBc3QmeiWft07OimODNtEKZSPT4aEpYN5wmPoWvXaNI80xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4186.namprd15.prod.outlook.com (2603:10b6:a03:2e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 19:14:35 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913%3]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 19:14:35 +0000
Date:   Tue, 11 Jan 2022 11:14:30 -0800
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
Subject: Re: [PATCH v5 08/16] xarray: use kmem_cache_alloc_lru to allocate
 xa_node
Message-ID: <Yd3XFjz9eKVpYHsM@carbon.dhcp.thefacebook.com>
References: <20211220085649.8196-1-songmuchun@bytedance.com>
 <20211220085649.8196-9-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211220085649.8196-9-songmuchun@bytedance.com>
X-ClientProxiedBy: MW4PR03CA0178.namprd03.prod.outlook.com
 (2603:10b6:303:8d::33) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cd0c55e-c171-40d5-5d3c-08d9d5369a86
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4186:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR15MB41865E0613CD7D9A5E978E70BE519@SJ0PR15MB4186.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yze/uRwtLciLRLK6mmbKkduBxJcwqWqLQ5BRp1/ajJoQhLJ/6sD6dYK4FfDBAgAT4FCPZXWDXUbzioqcDKOktDTMObmBuOp1ApgTvIVKQshdzwqKJzSHSv0XjD/CIkTDlOhfmk2TE94KTeROlIUibYllWg8YJweq2fk+KHeyAjoKG7pT1l18vPwHc0Ukph7czHj1TqbEAmE9hw1oxcbpV31+E9rgdq89uqT9edQIjaAli6PdE88iGcmS7roHoJ6/m0KMLbOb1C7YZeKXXWrF0cClfNKY3syQz/SArhekSiDESb5k8nrDIt1FHHNYYuaTc11pHIaOm3rsysGan0GHxNxupJFGhENSzYY6JwfTay/vAv+Q1kf8d32IBfwSZjtWjKyNIJf7DSQL9y8yGuYxMIJpqt970I7k+ncqMaxnL7H5UxqhOd9kkVFZx/t0XQR19hKuQNE7RjBvrAzmGm7JIZvGUm1a3Ugxh//xWFoE4SDwfYmQFgEl2S2KoJO+Qh540KOilVDzwgLOpbImXQG09kztjrVqT06LYqaK/gjHVegVfV9FGgKQGoX4oMP6HJn+p/57vZ6yNXKKkZSNcR5onENjvnDrbEs2CQz8r8PArBbEv6W7VzsTbG/VmpES19qvsGOwt68xXJ0sTrffZnL7lQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(4326008)(2906002)(6512007)(9686003)(66946007)(8676002)(8936002)(6916009)(186003)(508600001)(4744005)(316002)(5660300002)(66556008)(6506007)(66476007)(52116002)(7416002)(6486002)(6666004)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xego0Q6EYABl2lBN6TW3FySh52iSNgkG0CK8y/f2mvU3WqNI3sUfLHl2Oa1U?=
 =?us-ascii?Q?nnbsyI6mgDdJijsiSfd/H4r3nLOFTHhS8dxheljMluUOqCwHeQZoUZCsUl4c?=
 =?us-ascii?Q?oxMsCm0aswq7UWij6CvVcrhELcbn8aozmOLOs8NocsQNTfxCDYGLba6NvRK2?=
 =?us-ascii?Q?yuGOmZFW5ssOL3O+PqhqdcAUB6yKEGr1MFcCJC264YnzMzpuhu5daC0HX+QK?=
 =?us-ascii?Q?5+KSPWAJHsHzEO2Tugz2jkbsCw2nFAmyhkHdP0CVJCUcszPUltpsapNNXIEn?=
 =?us-ascii?Q?Wdh62SXFsYtDR6r2Mon+2vEGLv5MmlUcnuXHhcAn+d72cGJIDyvpFX+CrEsg?=
 =?us-ascii?Q?0tII97e/deYQs1Snf7skWXAXgDTDMxU+04F6g6pRXITarapydJR4fpEi96a8?=
 =?us-ascii?Q?dMAUN3cnw2Kp/Wc8FWDSTysIrqZl5Sp8fYcw6R2BBhfwNOv2aDr58WicWwsq?=
 =?us-ascii?Q?K6xaPANPDfuM+OXBkrX+BCUjh5R0cEmZXHleNtkEMdUB4eif7MdIP/x+uMIQ?=
 =?us-ascii?Q?791fKHIjMjBaZiLFMstTryDa0poUtqfFyHtPZdx4UISixiY+oi7mr62QQK2I?=
 =?us-ascii?Q?uXmcKxkUaj0hSLEJ8gmgtGnug8Mxe9XQ7LDjfVClsPBqrkaHocueEriirqAN?=
 =?us-ascii?Q?VKnkaR7EveqBwlbrnLiPLUh6WMKnadBeUp+c+OR/JU9pkcZmhANV5QvTLCgo?=
 =?us-ascii?Q?RpEJ69UIlH0ZEGxQjwpHanalmFohwKhuWDpftcU6zpoZDjr6oLH6BomTPsNf?=
 =?us-ascii?Q?oCtBVuCOEuC9+t5MKO0OqlzVOHFeyZNkf7DX/jHBTeqUrJfwUhABD4DTsNGG?=
 =?us-ascii?Q?2Ml72WLXvGUsh0IN+mJcBTuCcrQ4lV/ptPeRqfSCYskF38cCOJ5vC4gtoFQV?=
 =?us-ascii?Q?lLB3VsezajuX0QUgbPPIronnCpHljAj8+QcQWRuWZDr0ntzjTBNrrmynbeA6?=
 =?us-ascii?Q?gLxxMpXyWy55NuEuSKOfK7BYMZjrBw5BlLDXfjYSacp4zfc0rC6YbltJ6xbw?=
 =?us-ascii?Q?LGzOiFhiCgDMW8ICQ6eWWIpt4zygxOopQ2J1yVJ8uDkJn4VSJTfsh5DZ5k/i?=
 =?us-ascii?Q?OD74UkiAVhbs6g+V6DWk85sydCCv7QjaKmFTkqkRyRkr02GEfhlQUo33/A7W?=
 =?us-ascii?Q?9DPHBlf7kCPjw42zZihkrDPRzWEVkFzpluCZ09PEzoqkjUMCmF0d+biEtTwL?=
 =?us-ascii?Q?FlRyO2W3Ia3MagQccQKWS55gtO9aPiUQUDMEWyGHpzAdHzcjYct1UBGKfBAe?=
 =?us-ascii?Q?/1mH/Ck5gKakvBWMNJbsLh46rBc4P36oS4DVi/mBx31e0bhhEv+Uds00mWvP?=
 =?us-ascii?Q?NmbQG4isbG2cmD8maq+hA7mpTE0sEcc7hM3oa8xum4cahyTxqLjvSXjqMDs0?=
 =?us-ascii?Q?ATTRwJbwCpv7hRAwpQO4FTO81+KcGoUDWSAKGzDY4GQE10kj5h1uWR49uwU0?=
 =?us-ascii?Q?c4Lvd2N8mMq4gTGiEME3QFCidgCDFNJVnFtUW7EzSwFzMkzu1K/Im4oDxLyr?=
 =?us-ascii?Q?V3fxbuRQKTa7ioNzVzN+5KTA1AhRsGVTXxMdn22GW4uXyeaiaOpyXFJ0Lpp0?=
 =?us-ascii?Q?HDEV+mnHCqg5paJM4rfvTtIWpstSPf7oz4VUt0F9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd0c55e-c171-40d5-5d3c-08d9d5369a86
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 19:14:34.9582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SNNMo8oE1VpcdKFt7/HLP0GGHWATwxvQ6jBd/ottdc6meDAV7q5TNB2jNW/G1xpO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4186
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: eFig7PQ_fiOZi3spK6EgAHobmZyH5V-7
X-Proofpoint-GUID: eFig7PQ_fiOZi3spK6EgAHobmZyH5V-7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_04,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=949
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201110103
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 20, 2021 at 04:56:41PM +0800, Muchun Song wrote:
> The workingset will add the xa_node to the shadow_nodes list. So the
> allocation of xa_node should be done by kmem_cache_alloc_lru(). Using
> xas_set_lru() to pass the list_lru which we want to insert xa_node
> into to set up the xa_node reclaim context correctly.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
