Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5243548B644
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 19:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243093AbiAKS65 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 13:58:57 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62754 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242717AbiAKS64 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 13:58:56 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 20BHS37S025914;
        Tue, 11 Jan 2022 10:58:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=bY9HytqaR7D0E+IPLxDHLj3F6UQ4BukuqjiNtRVo5QI=;
 b=jP4+YrVLSUSQOr6gAacyqzQQUyWxGgXh1T4zo7hYzWxU+7b+s+/cJ7FZ0z5XQzSm8pSH
 LGd/e3/n7XT4Tr3Pf+feybIGQVw3iySilIM5KimpotvaGttwbD9vhAyq4VhuZ/JPvXpa
 RTHc/Itatv0NmESHq5gMmljVqhd79VM8974= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3dh2hmcx9q-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 11 Jan 2022 10:58:42 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 11 Jan 2022 10:58:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joVs+Dp/VyyKBF6IKkLB0RwpFhF3tXTQ5DDOpw3UeRD8JB8WKqekMPHYw2qpP2cOQUE+D46VjxDTYSm6zNC3wsz3YxC7ymU383v08s5hzORTO+lIyDvEgVpcaGdfNDtOiJio87I7d8qRf4AyeSgoErTLc2cJUljW4DJdMHvZsPoQI3zDbOe4WC6oKq5Dl0nfbI8IBrdgR7qDZ+F9KtjmxbGHq2ZqZNtGbuj/dml4pjCXPw1jqBk8riDKfBjR/kQVVUtR/ZoyZrFJxBTbuP1G/Tk2chE95FfF3rRKujIKKZ+y0jHwtempKV1I2BCi+navzo2N5bOhshVak1O0g4Mm6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bY9HytqaR7D0E+IPLxDHLj3F6UQ4BukuqjiNtRVo5QI=;
 b=IcBuhfwc5w6eY0GNuYvJWc60zmtUUM+/J28kS+fywhV//GfYCDXbtwhgA3DGOBH3X+FivqVWfkITgv6RbaZsyBsLopfvNr+VAZ3xUPTfaAdichuAGAYOlsTe7RN0iZL9KzcLFH923yaRmvIN0iRvCWjJkivOqqJOdY9euRwILvOkPvHDh+LEVySZ/AdynuxClInuhFRKOIt1gOOCfjlTQgupxlr5ZhSMTRT+8R9PnSzCZJ034jtVXwAM/BXxRr+eOLlh0kF3IXkFmHzPQ48m6awHzwoL2wrGrgBAYxL26FzWNvqFAiphiRkItX25IoJclb7TDtQt40h77bqfkghGPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3683.namprd15.prod.outlook.com (2603:10b6:a03:1b3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 18:58:33 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913%3]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 18:58:33 +0000
Date:   Tue, 11 Jan 2022 10:58:28 -0800
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
        <smuchun@gmail.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v5 04/16] fs: allocate inode by using alloc_inode_sb()
Message-ID: <Yd3TVKpvsBmZM51k@carbon.dhcp.thefacebook.com>
References: <20211220085649.8196-1-songmuchun@bytedance.com>
 <20211220085649.8196-5-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211220085649.8196-5-songmuchun@bytedance.com>
X-ClientProxiedBy: MW4PR04CA0197.namprd04.prod.outlook.com
 (2603:10b6:303:86::22) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd83de91-29ec-4c48-26a6-08d9d5345d7d
X-MS-TrafficTypeDiagnostic: BY5PR15MB3683:EE_
X-Microsoft-Antispam-PRVS: <BY5PR15MB3683EE79D439E600B30759F4BE519@BY5PR15MB3683.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s2jzJD55pXwS/u3BuDwAMRTVt1qcs33AdCQ0QEbFdvNBq8YsBTjcGABm5bzJ1jv4J97uO8Pqrowlh6St9YxLM8T7YcSJ8UNnQAsTjr7W6LYRDJRq5HgK8fA/pdFdgFmJPjWRK76zrErVBgZzekxWaT2TgkizBbvhFz3Nqhf6Ii51ej9wc7hTaiRgmj7Qy1DNyxhAXqqWDtbtZR+3RyP0nlnOAEn2IIN/gEKNlQh08OchcBgtgTbEMsjWjElm68U20/kjgJo3f+cem8MEb1K0bDWuXPxMaQwaDsGKRjUTSw7XRNc9zlHVf4Rupuh3NCtTZroej8JAmP2nbzs0x8gr6lVb3lvYFqG6w7OCjj3CeiE/magoPeqgD+m7PnH+5K3kYkzFOsw09zGA803Pz85PJlVYgcXl5zLjcV4rDJw0ClS8t2+ClQG3lbGnSkMkCJAWDtBLinKBXYMhbpjNsrenYtQNxDV4BhrZcuGB7gn1ir//nAbNRb/k2Nbdly6qNRKdmOK4my7nYXkacnHplq9bT2sc9M0Eb3lRNFIl+NOv7/XRK5lvtUGeSg4cZpJzil7lp6Gx041gQwUvCa1j/id5pb2FbUyHK0zsT0gJh384lPDq0CTPpXEK6Hh8ul8sLRFo35deihhCNwg5LByyL3sSaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(2906002)(186003)(8676002)(8936002)(6916009)(66476007)(6512007)(6506007)(9686003)(66946007)(7416002)(4744005)(6486002)(4326008)(52116002)(316002)(86362001)(38100700002)(5660300002)(508600001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rOpV2mUq8J5R7g3AGVlFqnuUwkFF0+O/DCCg4oy6TaxzfFG55dcuHOzbzoZp?=
 =?us-ascii?Q?ExgynluDKDARF2w8mgoFEQ3ypL2B7Gvqr4fOLZ0SnZFf2IqWC40lcYxvFerJ?=
 =?us-ascii?Q?pDNolmsr902IiLs2D4h5ptC5ceohCjL8/XuocNfmC9fn7lTs8zjsWT9F9cdR?=
 =?us-ascii?Q?RGD9iFLOq6o9CJDTtWrHIq/SQ4a/t9yAzWb7+nCmeCRYQ8wYve+BGpp39/uP?=
 =?us-ascii?Q?eRomdkL+dmX3pXhM3t1Rwf53Jbbbx7KJLsPXrXwTn4U9mNlejf418c0KMqx1?=
 =?us-ascii?Q?0bfcdvpWLTwV6hqaN32jV8aCDIE+MOJ60yg7TreSy7nhrLrf7w3JyIYHdFwn?=
 =?us-ascii?Q?651U2JHZ3QRRAMJA6go5sIU5RG94f77wpEhLl/TmJO1EoECN+/9sViEVQ2Ap?=
 =?us-ascii?Q?tx1UGIiVDs73sSsKApQEQA2zF1MZrpc0xJiz4nBwOY9zgleEZYU6afpqDjxQ?=
 =?us-ascii?Q?TMAij7UoZcP2zCtERELqSLLNqtvPCHL/7mvUGe/y8LbRO2DC3hxo9p6mA75u?=
 =?us-ascii?Q?pGd7SWcYpjw0S0acEqGRnrXRkYXcp/8GWVy4zCVMtvvkmR1m/IgIiE4ZG1U5?=
 =?us-ascii?Q?YE0F2HDPxsLTaGGyEOOE15/J/MrVrSCsyNPA05FeW6I6cVbGlS0IBG8uvs4Y?=
 =?us-ascii?Q?vEVL3nNOkGbMXpdDjluHcfK8+71IWx/Pcb3MyfGcgZYf8ZYPBifcH03C7Xgl?=
 =?us-ascii?Q?Q5cVJJ1GV3TUQIU3UHmMf9tuhIuwbMQXNo3uks7AlCstNdpwT0XjBIJg4KjA?=
 =?us-ascii?Q?B/FO6N8eI+qKm0JlV40pVd+JLuWWB10YufEDUpPiVaZ7gcQ/s9Irz6YEDjsp?=
 =?us-ascii?Q?sQUGKPCB357PUl5LbUeh7mj2OKzPd3HgCXLWBdEzuKE+PrdoYDovWv0tfy5V?=
 =?us-ascii?Q?SNK7LGeKceU8prZ2pih5LEZAzgPwwHwhCEHnazSXDfCQCkZrOFkk00pgLS53?=
 =?us-ascii?Q?pow//ClJyodrowQ+4+r91OpzsX2qNs9sUrloluKbJO6ZO4+2zlty8gcuq4kZ?=
 =?us-ascii?Q?HwZVXq3aqz9u2N+3sUB4o68SKs9Y7w3Ti9n1w/j4aKzNyLMQBDw+6L8ROsya?=
 =?us-ascii?Q?uc9jSOn69rHxbE/Pz/0FeMQbJmztnvwfRRK8OW6d4VSVJcUo9gTWdJ/ppx+H?=
 =?us-ascii?Q?e5XPfSua5tCSle1/pruisKfM3P41Tpw/lGvrTKZ3apkUaOsDpKsTJVOjG9ad?=
 =?us-ascii?Q?OO7Hhtr+lURUTgIca/6qmkOvk+7BwdLGv8WpYiC+Y9oWgN1gW4IJV/OkqxiS?=
 =?us-ascii?Q?F2tL9+vMXiV8x1ZxV3izskuQLMWhHyg+yT8RyKkv8ygDvXmCvtGE235iKOpP?=
 =?us-ascii?Q?iUqh01L6txGQAKvUxK+UJEEynmHVQMq1KCj/4XyctGvI+mHdi0j1rCxffcQK?=
 =?us-ascii?Q?2ubQNRsfua95gr+x9KAcVAc3Eo/AoMkLn4HRmIJyaOiu1qL/uJHXXUpWGqJZ?=
 =?us-ascii?Q?ydBD0H8UAsroUC4tNRZvBlBlR3fJnQqw8aAl53kcUbrV8BX1L+4DndtvajZQ?=
 =?us-ascii?Q?fZFP0ohxD5r+LEyPTO7N79OlzeLjaXsUn3gRW8CLn8sb4xRM8mxt1vbZP9Wg?=
 =?us-ascii?Q?qCBxMB4G7kfisSQx504go7we14D6o/BvFKWGA5tX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd83de91-29ec-4c48-26a6-08d9d5345d7d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 18:58:33.5165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TPyawRzs72MGQhT1loT+3URH5k8IVHc/2af8CdgNFExPMiKQ3BjP7N6DQvJIGvn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3683
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: Zb4T-NJrrWHWPOptw5qOaJEJfloaongh
X-Proofpoint-GUID: Zb4T-NJrrWHWPOptw5qOaJEJfloaongh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_04,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 impostorscore=0 adultscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 mlxlogscore=816
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201110102
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 20, 2021 at 04:56:37PM +0800, Muchun Song wrote:
> The inode allocation is supposed to use alloc_inode_sb(), so convert
> kmem_cache_alloc() of all filesystems to alloc_inode_sb().
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Theodore Ts'o <tytso@mit.edu>		[ext4]

LGTM

Acked-by: Roman Gushchin <guro@fb.com>
