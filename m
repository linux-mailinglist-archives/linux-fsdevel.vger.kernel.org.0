Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E86E31D3E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 03:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhBQCLu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 21:11:50 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34846 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229480AbhBQCLt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 21:11:49 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 11H22apE015977;
        Tue, 16 Feb 2021 18:10:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=+ZMwn7qtPQpoDXeQJDiatuSWsIFWlzAdW3lknY80Rbw=;
 b=mqGv7eksra4shaD8Rl5TdJsp2SmjHPIJB/4a2227iC3zys4K1DByn/+MvH6+TkJRq7Ie
 jW6LxKJxVFcv8Uu7s8oHuKuFiU9kKLSFkZdZWG4RjIvczRXXHjOZMswTg30weWG8tCf8
 LKpgLQHd78SQpu/8UovpVNZfOFqNyWowqdo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 36qvcn0s7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Feb 2021 18:10:58 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 16 Feb 2021 18:10:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXIlDopoLv3IoA7BmCDVX3qMGwuZm6mn+KlFcSQKymGCWjwDkTREQxTGSS8WQrvBWcgnIN+ettC2G7CpGN6VUTonoHVZ0ov58vMwtffMdORGYCfGgHR9oJApsCyMu4nwrD5qwdXQDSFiWC67tW51iPvFoXSlxqTw5u32sNpkfAC3lUydCnErG01CIKVhFFXIURR7JGeky5GbLNyaVkdz214+Nl/rCowN/9fzMSEU8vp22xRmkcMZweTsAI6MpRVFsIzO3zDxP8/hhcPeaS+OjoxWFGAsQUJk6LRFnMI6LiBLQ61Q37JJ4JPk966WYOYHhZ/YL/KlLWP6qtMloJcn1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZMwn7qtPQpoDXeQJDiatuSWsIFWlzAdW3lknY80Rbw=;
 b=NiUUl6ytTZMzl41LlgpCBzatLu8SbgQV2bDuPsTpp+ana6ftGFq/kN/q17gchduyHQiGoxkqXi5+fLGuAt38VCk5m0oGKzrH8Vt1KX55E45vklf4P0MhEBkmAleMYGiTitQhIDShXPyX53bLEQSV5bAohYz6/cKbalb/lm3Zm2FJy85wXsCgwVJsr/oirroSi3VgD7/FoATv2cheWvBLVrFtq7wCdTuQBpWPSVvnP14mnb1OryCA/4G/MmJAnuV+dGeGxG+shy51sQk+gS1hF8tQKtcWpR+AOmSk2332WKRt9ovzssSV2M5JkynPKsAKdSdkeOv/ElmdkAmIFKWdAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3521.namprd15.prod.outlook.com (2603:10b6:a03:1b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Wed, 17 Feb
 2021 02:10:57 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3846.043; Wed, 17 Feb 2021
 02:10:57 +0000
Date:   Tue, 16 Feb 2021 18:10:52 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     <ktkhai@virtuozzo.com>, <vbabka@suse.cz>, <shakeelb@google.com>,
        <david@fromorbit.com>, <hannes@cmpxchg.org>, <mhocko@suse.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [v8 PATCH 10/13] mm: vmscan: use per memcg nr_deferred of
 shrinker
Message-ID: <YCx7LHKp8tMOmXCH@carbon.dhcp.thefacebook.com>
References: <20210217001322.2226796-1-shy828301@gmail.com>
 <20210217001322.2226796-11-shy828301@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210217001322.2226796-11-shy828301@gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:ed2c]
X-ClientProxiedBy: MW4PR03CA0183.namprd03.prod.outlook.com
 (2603:10b6:303:b8::8) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:ed2c) by MW4PR03CA0183.namprd03.prod.outlook.com (2603:10b6:303:b8::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Wed, 17 Feb 2021 02:10:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10985dab-ef5b-423b-b8d8-08d8d2e94338
X-MS-TrafficTypeDiagnostic: BY5PR15MB3521:
X-Microsoft-Antispam-PRVS: <BY5PR15MB3521BAADBF7B144316B0ED8DBE869@BY5PR15MB3521.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gwux2ASqFbxz6pb3Dc8VkKoWH18AtqyO190ioR1rPngkgNsk59FOzTGO+WLWzkDIowMVBdHt1mPM8KhEeqf0THbUvcwemA6ywuiaVMevavRQQwGEyJ1PXWLq9vIdekQewaQFEU4OM8OsKuRnugERxzJzlL8hsHBjDyfAoJYrQ56CqC41NNVtRpmFoYZJ5EKEvKARDI6Q2mDfro1YOr2z3NZdHPKGFMSWlHWpVJVvnSSZNZO89cA/8m6m0JVTAgWvhJcitmPzOj2QOQA51Ug/KJSAFc3CZ5tXGgO0828hOgnuzfyrHuv36yr4s37uZo01YsgoVq2lythaFB5ujcxJM9gNKXwyTcWWsY3lYKIgPJShgFAJTSEN5t7zdd2FOZf5ZxhFEJYFPPwawVRZ0RqKx0oxL0Xt2B9cZr7WmCudn+MRrH1fIChUTc0oGgt0z8HnQH/F17xvqdwIKgHWC3qF/NNdd8a4vj0OeoFtiGzV2VXeXbfyfH7xdFBghRSvxB+iefMAhRWTRiMfaHxlzCqyWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(396003)(366004)(136003)(6506007)(316002)(478600001)(6666004)(4326008)(55016002)(16526019)(9686003)(6916009)(5660300002)(4744005)(2906002)(186003)(86362001)(7416002)(8936002)(8676002)(66556008)(66476007)(66946007)(52116002)(83380400001)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FxAUWP87PeNqZWUT7hcG/zUqC0yHTAovq9wgYOa2624nULEsX+PXlH2oZB74?=
 =?us-ascii?Q?53pdS6civCWehaXnt/gxfv6GzPNHiBvZWvuZormqGWcRFjWWn6bTByGfozGr?=
 =?us-ascii?Q?oGl8k2ALVe1SeIPFZZ4CZlsq7VxXQpaklohpIINUlx5CsOtOUK7wX5nCV7h3?=
 =?us-ascii?Q?6FXkSeIK7F7CHKZT7lSoq/lBr5Xg2O02yAdEPA0SVZ4ow1yN3cXq80s75UMl?=
 =?us-ascii?Q?KJ98GoV+w7oIJHahOxnsgteWo2j6z+fn0YbbLcg3Lnli7ofHfjfPpzCd/Et0?=
 =?us-ascii?Q?14lzO7N5fZVO6qndY4INedgx9lef6NkgW+gh8CpfjgvJv7JAgwZZJzEzGGCa?=
 =?us-ascii?Q?kgQOy3ppqBepHWdIvB+kVPedVUJLET+ADSLNbRBGLiNP4WSm54cQX6QEh7Me?=
 =?us-ascii?Q?tXBUgYHMCHNHH0mKjhHNVa8BYYckv0Pdk6aJMXpZ0e6yu7gIl0JKNXsqQ9a/?=
 =?us-ascii?Q?7TWO2KR28Kx/nRrK2sRrq0jMkxbKPJ3+9dft7zTXIYF5QiJ1tQO5Eu8wjX8c?=
 =?us-ascii?Q?Fo6ioPo7aCl+VHiaenka/yozRPqxCNxNFMISWtLBWRXZWLSGHd+bDGMfVhB+?=
 =?us-ascii?Q?itmmbK5i1S9Lp5enQQ2pLeA8dnRLHIZ99+wRCpGSVw4xNuWIxr0WX9KHF6Jz?=
 =?us-ascii?Q?cVXLXv0tj3vImN8TRtXcuNZERuJ4u6P77AfMlwB0bHknGmSg5qzwDbkjm23/?=
 =?us-ascii?Q?CGIQ2vwtLWzznnW0BxBKhR7dqEYLkSbD4BGNjxnay9AU7Pl2R7bWULI7rRIO?=
 =?us-ascii?Q?Q5HUyFDyByfMiqD5jhkDapf4Pe79m/AZdqBFVJ+qoeDt2Lv/m7WvblXDpLyK?=
 =?us-ascii?Q?7uxR1RKicqRlvV8VxcPN/tviXjwt1d9ho14rxV68jRof1alf6ql9kmFnGKXL?=
 =?us-ascii?Q?tiFLgIarSFXp09jwF22L/gpmjiCW9DsHQ9khZyrFLGTM2XlskHzbpMMo+KuX?=
 =?us-ascii?Q?diTzw4PaU0eLLrlA2//SiG5ksRtJfozFK4UqbFI95v8WgIw/DQCAgZ11W2nW?=
 =?us-ascii?Q?ZZP0+MD68nl1cRGCla7sKTurERel6It5B5+MhTJYplRpWKqfpMi/0mpO5f1S?=
 =?us-ascii?Q?WMRAkN8KU1/CHFOorqLkESHDqhD0NKgL4hJhZvlegLF9mDDEtRUFX1UDkQRv?=
 =?us-ascii?Q?9abVz7Ylr6kZR0IeMe5Iz2MWeNZTxKFDhA+oCcRNLfbgrxf7BztS4GSKiPTH?=
 =?us-ascii?Q?KppCCcN03M4pimT9reFNP74AMaBy6rUQIrbXGp5haHj0ivDlewvwNN/0Fe6T?=
 =?us-ascii?Q?OFV+wCinKyJLMmzwo8xTVKT3mfiV5MZIwblec4iESZYI2We/YG1AY8PP7jkq?=
 =?us-ascii?Q?txgJJhanFvYrZfdW4PG13p6a9vuk6N7s6qroQ3Fk+7Sq6w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10985dab-ef5b-423b-b8d8-08d8d2e94338
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2021 02:10:57.1807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92g5x7/rLBDnTZwHzK790bffXDfbKYdG0JuGolFDJptCfBXeJqU+HEQTG7LpF86f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3521
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-16_15:2021-02-16,2021-02-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=712 clxscore=1015 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102170011
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 16, 2021 at 04:13:19PM -0800, Yang Shi wrote:
> Use per memcg's nr_deferred for memcg aware shrinkers.  The shrinker's nr_deferred
> will be used in the following cases:
>     1. Non memcg aware shrinkers
>     2. !CONFIG_MEMCG
>     3. memcg is disabled by boot parameter
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>

LGTM!

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
