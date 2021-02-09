Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0517315881
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 22:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbhBIVUM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 16:20:12 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40356 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234237AbhBIU6V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:58:21 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 119KRBKc011720;
        Tue, 9 Feb 2021 12:27:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Nk84wawx7HTe7PcDtPHLZ2VKxr7DyhtChRKwQ/J0ZTE=;
 b=MsGuErBgyWbpyShtm/vSrFdZjTLTMyiTAT49zHFhZe6jRB52QT00Oc6bPljgunfvafeM
 +cTmlSgr0yvzMiJOcKdOgIS+HKs0CxcX+ktYxab92yZFlifTlyq4rFNk9LgBAy2Ub65f
 cmZ4pNto4q0zaCczhaqPS6C6PGZ/Tpevu/M= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36hstpg32g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Feb 2021 12:27:25 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Feb 2021 12:27:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZLrRnRsHNigBFYbXaOpA0/tJUeUJcR6zAoaqPCyVxfrPkmBDpCR9m6+kMddhJZ7Q3eHXRIw5frcwaa+ycYGzjc+l0o3W8Sr6VQ05+kLP4Wx1JRGedcdco9JloEqiA9Cjr/vPuJGj19aEUEOga4HDJ1JtXOJ+BCu8+sJkQEBiBIsJVBmGMw6OHHXUZzoZupKR8IlU1+b+Rmw5oCx11gyn5LuPiL3HTMucn3xMrOv9sb7cJrLWgIBTfI9dDm7DzH1wQkpl8u35DmtBe+sy1k2Cs7muVF5JC0K6DGIHqALAEz16jQyQ/rbYYpeGKyp7Mp8xNw18JPOnRR0HDgtUieDvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nk84wawx7HTe7PcDtPHLZ2VKxr7DyhtChRKwQ/J0ZTE=;
 b=dCyxyg2CipLUIorQB4TpnohVJoKlzzQZCeo3KTLCHZ6iXHHOTBb8GfDVGrP1Zh/4YdG71RkvgiXsUupxqVpVesmi068sv8KFahm2WISAbzXW3mbxh+hpUzMbcqjLexhQnREdTbxLDlHZEQ/V8PN1Vb9pBpa0tYuiCP7fsv+Pws7WtQV34x8uUyx9Pbt/3X438X3ixYJ1SiTUXVc/ekUm4Tw/4+7jZbFjQ5C1H8ylbAFvSYTW6jnjIh4MuN6YCsiGNIWmewnb2BC0x3fD021JrkY7E2bEcWj6GFdhiymTD3g/mpbt6oL52Cs8kNzVhxp7skj367IUt5iCdZkHCF7omQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nk84wawx7HTe7PcDtPHLZ2VKxr7DyhtChRKwQ/J0ZTE=;
 b=cbHH6aB9ahHU8iTVxtl6fGhhY0U6kF00/K7OZRw3cfP/VMdtDNnlciPFhmqy+RIDFoFQvrpLIhI6PbIZs0QQsAW8N6+bs+CYBHggn8ORq+JOuJpV0Pe81pnJKj6qNBRo2FRuftfW7yDP8r71mdR+SrnPMBTnNFnBoaIys3LvZWI=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2758.namprd15.prod.outlook.com (2603:10b6:a03:14d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Tue, 9 Feb
 2021 20:27:22 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 20:27:22 +0000
Date:   Tue, 9 Feb 2021 12:27:18 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     <ktkhai@virtuozzo.com>, <vbabka@suse.cz>, <shakeelb@google.com>,
        <david@fromorbit.com>, <hannes@cmpxchg.org>, <mhocko@suse.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [v7 PATCH 02/12] mm: vmscan: consolidate shrinker_maps handling
 code
Message-ID: <20210209202718.GE524633@carbon.DHCP.thefacebook.com>
References: <20210209174646.1310591-1-shy828301@gmail.com>
 <20210209174646.1310591-3-shy828301@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209174646.1310591-3-shy828301@gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:ed49]
X-ClientProxiedBy: SJ0PR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:a03:331::26) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:ed49) by SJ0PR03CA0081.namprd03.prod.outlook.com (2603:10b6:a03:331::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.21 via Frontend Transport; Tue, 9 Feb 2021 20:27:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75b520db-cdbf-40c7-39e3-08d8cd391ad8
X-MS-TrafficTypeDiagnostic: BYAPR15MB2758:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2758ECC90DA9AE5E4F4DF90BBE8E9@BYAPR15MB2758.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tfe8eNt95ahD8LGRMzwamA3M55VjdTo4hRSsPAM8NGu1Wi9xfqWhXrCA5JeZk0LaKEI63Y+Z1EdZIC7yaA7hlEZch6esEaYa3UpRLvQ0bLuAhZ3yfjfMjOg76EZe6P2ZDKxIIfn40R/1ns3vhwY1McdeYwEy7HWrdLx5ThFN700mhQbuU9EabCJ9Mxtd7dBGPhm+q7eiq7u90xLPcpJ+55Y3FOvcCpk98nked1v93gNVTL0HxSMFAQAPeXWXhPm8eFx+9VPBFUpl0nWJo82rQKMUZbHrl3Wmr0KD6cr9p7XuOqYlj4LxORebu55JQkJbcMvpDQoDAy8jFwLVsENrROTyk++uMbUL2X9UyIoQkQxkj1w8K4POBHMGT597yKUNFTgsQO2xVK7jYXnSqaF50b3ra26+fTaCpNXH3OcBgFx2qIoNdX+J2ji0lVmU29bSdIEAxu7qDoZ0LwC5C1ZEqSDk6Y068yNoGp7ZQgiQCJwNkrCdTZdscDGl9q0D/BWEVsWTPRiZOG4X2twGcKPOLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(396003)(136003)(39860400002)(8676002)(8936002)(52116002)(7696005)(478600001)(6506007)(9686003)(316002)(6916009)(16526019)(6666004)(86362001)(186003)(7416002)(55016002)(66476007)(2906002)(4326008)(66556008)(66946007)(33656002)(1076003)(5660300002)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?WWDuhP0vELIdEsKzlhlVSJ2KYKkfptpFH20fkkWxb/spiTAnXOjiMSfmlSmk?=
 =?us-ascii?Q?/YIKO/ZroFTigxDamyABEtnht+bmngMXjK4d7sdQ0qi2gQzdhMJpWlbPUNWC?=
 =?us-ascii?Q?AmcjgSWF4a8BSZXvnX+R/ko9UFNzdyDTr41MDEMcgr+lOi8CCFPKmFqGT4g1?=
 =?us-ascii?Q?WE6tnXhk+EgeMhEloqnnXWr+i2PG/bViwavRm1GRo5S3ovie3mwXyJjMsLgU?=
 =?us-ascii?Q?Mlu8qap5xWS5Q6JtnIav2hgUR2xyA/zFTLZaO6PM6iKqFYWIQ7gdDiBMnl4x?=
 =?us-ascii?Q?8Iof+pZbD9+clSPKEerH0fKM/8xt+xET8Md5ha6uEuv0SXZz+StOAH2kWKLj?=
 =?us-ascii?Q?tQtnuRwqmqq/ChHYxGpWakgkbnRrzvfTDJo2S8S//9sFIPTAOyjecPoFLSaO?=
 =?us-ascii?Q?+nYCVJl/pwayuZtCU934NL2CoMUay0isMNPjEk4CT4sWoAeMWPPLplrSpY0d?=
 =?us-ascii?Q?c/DNoBxllfLCuFys9dauhwbiLwogjMQ+CLETN/9h+3X6vwDJWcMAQwInvYQh?=
 =?us-ascii?Q?XTk+G2q8ejQUQ4brP4+eVCwYTmnbUMsAG+RexkfiNoDys8XDGum4/kEOaOP9?=
 =?us-ascii?Q?M5G9+FVYH7G3xo0cQ/WcBhZ/MaGVNsQy3NzwXeCFZLNXdZnpkXyfJ7BO4YX9?=
 =?us-ascii?Q?GdsWMg4S+lgpcb055Rn3tXYhQwq45dDyih1oaVGh9MhazG7VpZQgi4iLbytj?=
 =?us-ascii?Q?Sw6UF5NDpBw6XjU2rr1q2A8jEY532s9/sKhLXWEWD7vaAOnNzs4s57cAdAHw?=
 =?us-ascii?Q?9/N1npYn1W4EyArm/3szyuZX9+EBVr/Rk8hSaCURoQWM87qtFQ2yS4SWiYGF?=
 =?us-ascii?Q?EBljHSFqjp7UrwU+u4Q3znRnNdrYirnqY9gd5B4yka++4y7MruBFVlg31/e3?=
 =?us-ascii?Q?nujLprt/esXC+jm5IVm9I00+wnE1gKQkHXDTK741SKs54GT5HMBuaLC51xTG?=
 =?us-ascii?Q?duGx+vTdQEG8xjw9DzlAEZ9svkRPG3Q0N9sfmqEtfki17kbbs7nWUfdpeQO9?=
 =?us-ascii?Q?c1rS52h9vFrzQ4TskOl8kjwupbd6OJTg7ajr4qoIe2gogjBirWmCF/MfBylI?=
 =?us-ascii?Q?DVbfuRDEC09umlO1qkIcMXvpt2w8ab40A+FGrYS2CMEr3bV3267RXrSHc4dw?=
 =?us-ascii?Q?qijLHqpfSESWbAiv69K5cysM17P19q4Gc+VEhOmWhkti+RkMyscg9NaagXlU?=
 =?us-ascii?Q?v/alkYkrXvUbQ5rDuA4vDMKjGdt4MhRfN73exPsKl6PzW/oDpOLRGvRV/xHY?=
 =?us-ascii?Q?kP6mJ4xUfdxsFx71EGLerRGR2HSVlms9QmLD+8RohhpqGKsaVAh+XhhzYmv3?=
 =?us-ascii?Q?uLkXR3oKohBiHiahURYnT61ToJ6fVmR+yeNHK+J3mHiTWg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b520db-cdbf-40c7-39e3-08d8cd391ad8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 20:27:22.2022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l61KqNROo7nA7mTS/0fDta14ZC7DYrgDtFZmCP/bzww9lNFpb4JW5OuUFDTIoKcw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2758
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_06:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=774 mlxscore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102090101
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 09:46:36AM -0800, Yang Shi wrote:
> The shrinker map management is not purely memcg specific, it is at the intersection
> between memory cgroup and shrinkers.  It's allocation and assignment of a structure,
> and the only memcg bit is the map is being stored in a memcg structure.  So move the
> shrinker_maps handling code into vmscan.c for tighter integration with shrinker code,
> and remove the "memcg_" prefix.  There is no functional change.
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
