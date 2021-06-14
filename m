Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB6A3A71EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 00:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhFNWdc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 18:33:32 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44602 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229499AbhFNWdc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 18:33:32 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15EMV0t0028968;
        Mon, 14 Jun 2021 15:31:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=5U4Vh6qgy/SF1g3ZOHpA/sja8X6TK/7mT5tgAAssigA=;
 b=TtmszXN2W3ROxhCvWU7F8QTc3pAXldu5eGETK4TQlXPxHIv30Nj50PpH+IAJAzEkB78S
 sUOSX1sA6zgdWm998TRcQ6LFA3Gocl7BKscWUjrjXZGOLD2MD88FSZCuW1DOl7NGML7T
 QatHkf579+zXLtQ0db8HUO5wZLYVZISznn0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 396d6e8y9u-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 14 Jun 2021 15:31:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 14 Jun 2021 15:31:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMlXCN00XKN7Ie9+p5aAErslicv+6JMKh/5Q5zq1b7wytUr8I8ZuIZOc9QEuiiObGqJ/DnS8qRAIracV0068VOVNO4rGkvsvusNC6LLeSxhRKxUbNVGvmx5b5jod+R5TnSvXV9ugbwMPHPKLOy5o/Dj8LBpQtT7XCc34zAYhAJrpTjgqsk3KSrzLqdB9401ZDn1WUhnmYzuHLFj/tEN/WynEsLoAWbWT40w3voy2oZLaIxjrTti6RIR+xMAx934c8CtzfETrgnu1KLGwcjRu4wfs5r0xsWNLvcutaRNw086RQerXuYSPl05niM15lh7mqZOii+G8SPkd4I5P8M6iFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5U4Vh6qgy/SF1g3ZOHpA/sja8X6TK/7mT5tgAAssigA=;
 b=A8EU+oElnlj2a7dCsLt/BhnPFFsHNmFxG7MOjPkIXQDmv6Wszz7mXF81Gw2lZUolc8L19cULp8iaWwD5dpuETt47VZSu2ulonMQOQoHZtN8XqNn0Z6BG75x+qx1IWgYO/+mVDC4VVop7B+7DYNgY5tTz4vPy0E2TU9hPcW0oYo2OQMhRNuqhxI6PSac4MV0Wzu3PBKzqq147euhddHozViYZC9E3SzmSIXArOqMv2tfOO8rzUWmMP2NAn0TQajahghpRbOecQRc5EIA2uUQ336251j0Fv0cgHmHE01qdwn0b9PLLkulMFRo3wm9unYpVjxaZ42w0bPHvGAYx0P6Zkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2983.namprd15.prod.outlook.com (2603:10b6:a03:f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Mon, 14 Jun
 2021 22:31:23 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 22:31:22 +0000
Date:   Mon, 14 Jun 2021 15:31:20 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH 2/4] fs: drop_caches: fix skipping over shadow cache
 inodes
Message-ID: <YMfYuOJDAqrNyDiV@carbon.dhcp.thefacebook.com>
References: <20210614211904.14420-1-hannes@cmpxchg.org>
 <20210614211904.14420-2-hannes@cmpxchg.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210614211904.14420-2-hannes@cmpxchg.org>
X-Originating-IP: [2620:10d:c090:400::5:bbd0]
X-ClientProxiedBy: SJ0PR03CA0113.namprd03.prod.outlook.com
 (2603:10b6:a03:333::28) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:bbd0) by SJ0PR03CA0113.namprd03.prod.outlook.com (2603:10b6:a03:333::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 22:31:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30df90c5-1f6e-4bf2-36f5-08d92f842341
X-MS-TrafficTypeDiagnostic: BYAPR15MB2983:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2983D960DBCF280287FEDB83BE319@BYAPR15MB2983.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q3DUG43GXA6itUcQa/kBoqXMGuRAxIBtSbsIIGL7CdY4Ub8bBEA+An5e2/LSlMJ22U9KQTmH4YtKVR2OztkiE2xB5Yz+jEhaGBWvZwogUUzGJF/rdaHWyruEfzdJCUsLhKxpK6WVLsjpv0Mw/IWRN6X67kAHDC96yV1OQK5eirlZehRehip9M4rdJ2roFrqD+T6Iv6erk2GerZ501zZGcEa4Qdi7Lpi/ZE3JhANA4QxuWK37oD2Lh9+gywuv5mKZRi/QqeSK0Y6AboWtTKxoaoaai1ac59XvgVc+Kg5i6TPMCnHPRCF/ID2w7OkMUyi7n8Eq8ZKjoZsm4eokgSPco6Osw53fTHDQhKsKm+AOcK5FEhulJzwu7dlmOY+5QBcF3Wimi0S0EsxhXo64U7nLMSkGiObDb3RTOxXds/yer11sWBIQ1k5w7MbKXzQOEDkS7YT5BWYnW6l+NcVGm1qZ/HTzV930j6ejzFHsNLZ73LuSz7cWo3xbekChbhKmiC3NTQHGV5+jSPhvZze6CkKwRa+LP7vt78eNg0Sm8moePsXYJFhOFVcqxipUB+sYdPwJMdmWVKvnjln8FtjKfEWnZDRkul++8pVWJz7PMFYIiO8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(186003)(66946007)(66476007)(316002)(8936002)(4326008)(6916009)(16526019)(66556008)(4744005)(5660300002)(38100700002)(2906002)(478600001)(52116002)(9686003)(7696005)(55016002)(86362001)(8676002)(6506007)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KocL4gw+kNnn4YgDDC6BqFyzIxYFlABB0tXCUd9fHcOIl/VlXeUGiPY/Fex9?=
 =?us-ascii?Q?99kSw9mUqhMrmXPxGt3eSzkdK96CJtSHWblk+UO1WFIbn4dUs9kdrePtMZFZ?=
 =?us-ascii?Q?698eC2tvRSiE6gk4OLlI+lhYoqssUa3NFrBfunmr2FRhWIHB/ut/8/lu5BXx?=
 =?us-ascii?Q?bIc6qvT9ofQgiW5iX+rshZv26t407kvsgUidWjFtGXqiqDxg7BOAPuRPo4uZ?=
 =?us-ascii?Q?XyR1PClbQzrKnx/qo4QSGNTvVV7pFE6MFCItLfhLDKX4qxXYXDH1t+nZz2cr?=
 =?us-ascii?Q?VwR1t3PShJANomHRKkvzPrWgvJDxhDb5e2tH0rUn+CuiP17Zb8mUQLIpV3cQ?=
 =?us-ascii?Q?ejIov0uSky91FMBV6uSs8UbHHeQK5L6vaAxCTcIkCMdjBmQrijGAAMBzyKZ7?=
 =?us-ascii?Q?OJVohleNyJDBBc5LbhQyTCxZp5MGLpEr2PWKVOIyLuzzOtHvZGdliw9ZnovQ?=
 =?us-ascii?Q?bPQ6C3PKJupreIDd7b2T9NnyKr/6+a4d32+JwEzqeI/N8GHVyULfgqCaPMSb?=
 =?us-ascii?Q?GuuDLleSLT9J9Jw7GemhWktVVwoAWDh5PwRDkVtngeI1oF8q24Cav9Tqq/vn?=
 =?us-ascii?Q?rnI2fWzOcYeMPmM0za0R0t6lnYtmescIqS4xfY1lJyb+Rz6wXN7suI7BdmE6?=
 =?us-ascii?Q?5cFYQlqVgfj79cyI7uPhihXAaw+Lf9UVkUBSPTW0KjYgI5RkHABoPGtxVEcH?=
 =?us-ascii?Q?sQp3cag3u7S8wyIbxM2/FxDwM9qeEVqQEt3nODss2QAnfuDNWity8AEVYu0Z?=
 =?us-ascii?Q?zueKAV/RsbRe+xb58OirthjViOodKqtgBrPnLf3iu/qyD/iFj1BRgkYJatul?=
 =?us-ascii?Q?3zG85c7U1tmPo8l96IMw7e+kjaRoi2NkZqds3ApTf7zHmCLVcXu1Y0EJHxxJ?=
 =?us-ascii?Q?3j4VGab0dkeqrMPbwE4tcumwnVcdvlaIU+BpQukCmPZSSA3HBeErgQ6a0htL?=
 =?us-ascii?Q?C6YotQJEZZ/QR96OFBurn5bcZ0qXsTBg77TDSE5FhIesEAPkZJSWjOtWJN9F?=
 =?us-ascii?Q?vgw2JAHB2HftQM485xrmETCrM20gtOYkBwU4sIuldAvzA9eK1mADhRPapnQn?=
 =?us-ascii?Q?iioGfN+brBG7S/fyQcFHn/Sv+TR6hjChl+6CYGp4K6Lvfxjzg904K8sOJsqN?=
 =?us-ascii?Q?Cqhm4yv/qiE+QwrJWljKAq8yDjvd7yzxwDM4iT6hzW9qPU6g8QxXbTxmyRdJ?=
 =?us-ascii?Q?LqMu417xHhxYoxXYXsnlnNQ/fDGqzWqU0IIIPLbPK72z9dcZVhVkR9eLEaGz?=
 =?us-ascii?Q?7tKFS2gs08ME/S/GCilFqri5qot+yD3BatrkdLhKGEbHlIsgbUsiwvbxmRzK?=
 =?us-ascii?Q?Fcswqa7pwAAHBqyRWoec4wlgp83XvQ+ZZw7RjyPX7z//0g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 30df90c5-1f6e-4bf2-36f5-08d92f842341
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 22:31:22.5806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Om77JLSiQWXjTr8BLu1qb8VTSacDbqsccY5IJGrjML8F3hApbygXOcfz55PO9g0r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2983
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: UWsJUC9B4Qu4BGNdu8DaqraNJ7s5Cy9A
X-Proofpoint-ORIG-GUID: UWsJUC9B4Qu4BGNdu8DaqraNJ7s5Cy9A
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-14_14:2021-06-14,2021-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=814 adultscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106140142
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 14, 2021 at 05:19:02PM -0400, Johannes Weiner wrote:
> When drop_caches truncates the page cache in an inode it also includes
> any shadow entries for evicted pages. However, there is a preliminary
> check on whether the inode has pages: if it has *only* shadow entries,
> it will skip running truncation on the inode and leave it behind.
> 
> Fix the check to mapping_empty(), such that it runs truncation on any
> inode that has cache entries at all.
> 
> Reported-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
