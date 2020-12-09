Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CA12D3888
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 03:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgLIB7p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 20:59:45 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57278 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725796AbgLIB7o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 20:59:44 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B91w8gn007789;
        Tue, 8 Dec 2020 17:58:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=aydL4QXg8XURDf2KOlBrMWX/E75tPJ8ATtsmVoERNmQ=;
 b=W6kG7UAoQUNYWIJy2WWuZpDxaDsScbR3xDsevQzVfGWYpwKm6VKNruGodRnc2PMNUtj9
 0KEjKZlaWRClv0iwm74V+782zshPt5KKP3IJfdqFwtwjZQLGMWpUtuGQerBNjKrRyGTi
 C/EPky8BHdRLd4bLIbJ56X1ccTcFGlfCYdM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35aj8vhfjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Dec 2020 17:58:40 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 8 Dec 2020 17:58:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFpPyFtoCW/hnFvevdS3uYcAGqPurH8MGQdSCpMTfbawgOqyFnSpfZMQz9tOdEhJnI7MbTFQuQq5zNOU27+DeJWLkr9wbshITZ/5I1vONSt/tYCQGs/g3uiFjcq7hOyheswB94s0KhQlWYEeLzUVjyNdcuJntQYM4noiuY7ZOTb+U0jYvAqSXs3XpheXBkBqoOhWwQ9EUkB68lkyOhqevipK2fukgAkQcZsJA9AELJQWJ/kVcqdgfbm9pb37x/c/2o/INuIGzpYIjua8gzhgkxsYMEsp+XkukDb4YSlipKhEVDetFyczOJFQU1/yTp7G+o9EBqkcGbcEwTIKD++exg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aydL4QXg8XURDf2KOlBrMWX/E75tPJ8ATtsmVoERNmQ=;
 b=Az2GGhwwrzQkFVu2CVFgWXBIYtxhKzyBz800ilcBh9enPG/gSLqmeEJd+ztxwLPqn1iQJ55VCYjHqK5b7Ph4z2zZx5puT9QLE09z2NRrgNjJlE8JzO32DksaeEXlnq4pbbucMr30qAvm35ty5eKxaXf9Vuj9xxjjuJWr6uAD9LzdP5uFVffrKYMzfrvLZrLN1Ox2q5fXYGFkAOd8DYhuoeSr3sD34O8/ueLxgMpYRVIq1UhxbgjDbY4IQkzAqbhtlRNMbotDamw5aQy//G4HCcke3cadhnXO+DILL65+d1JddvZiAV6OARtGnavqYOLrYeFtbE3mosAGkgYKJ88WaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aydL4QXg8XURDf2KOlBrMWX/E75tPJ8ATtsmVoERNmQ=;
 b=UVJV2aSjngkSqBYVhHWAI9HoX73M8/ZzcKGWxENECd/M3B8O9q/s2R/SuBFSVtkCtIxt0+3HOOMo0vPf71Q++31ZjiHNfCdYYPeMQv/QsfBpfgtRAIfdwU+/l/EXCUrHU7DkzGK6ckUzLlXHjRX+cKQGLTNwqjDels6oho5hGrU=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2341.namprd15.prod.outlook.com (2603:10b6:a02:81::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Wed, 9 Dec
 2020 01:58:36 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3632.024; Wed, 9 Dec 2020
 01:58:36 +0000
Date:   Tue, 8 Dec 2020 17:58:30 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <adobriyan@gmail.com>, <akpm@linux-foundation.org>,
        <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <hughd@google.com>,
        <shakeelb@google.com>, <samitolvanen@google.com>,
        <feng.tang@intel.com>, <neilb@suse.de>, <iamjoonsoo.kim@lge.com>,
        <rdunlap@infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <cgroups@vger.kernel.org>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v3 1/7] mm: memcontrol: fix NR_ANON_THPS account
Message-ID: <20201209015830.GA2385286@carbon.DHCP.thefacebook.com>
References: <20201208041847.72122-1-songmuchun@bytedance.com>
 <20201208041847.72122-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208041847.72122-2-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:1a15]
X-ClientProxiedBy: CO2PR04CA0128.namprd04.prod.outlook.com
 (2603:10b6:104:7::30) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:1a15) by CO2PR04CA0128.namprd04.prod.outlook.com (2603:10b6:104:7::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Wed, 9 Dec 2020 01:58:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f4f55bc-0a54-43b5-c6d4-08d89be5f0ce
X-MS-TrafficTypeDiagnostic: BYAPR15MB2341:
X-Microsoft-Antispam-PRVS: <BYAPR15MB234180BF831A9F79BB70BB55BECC0@BYAPR15MB2341.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nIdCjorOJMnVND7UIsvJJy8S8FP1qBCTvmomi6UpnUxjHns1zmou7+furFDUdC3X7THValBhQsxmNM/z56qIE3hU08PrXc02EG6zJJEbaLvL8crcqZQb7P09ddq/26jp2vCx2G9YJVxG4fPUh4kyCqOxWtGGqTbl70graUDIrNo05hHuoLwbJNhCeJY5w2DDUgplcCRgq8vIDovaQIEDjdGdzhk/QZYEeebmGNGTR2r/NCf4sw9e2HWrHnJvHOtPlW+BJnhZ9qLguISmdsq0yAKvQnoWDEqk5QisIRz84WJRoFzRqxVlLGgLnKl+7Ba8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(366004)(2906002)(4326008)(33656002)(55016002)(7416002)(5660300002)(86362001)(9686003)(7696005)(52116002)(508600001)(186003)(1076003)(66556008)(66476007)(66946007)(6506007)(83380400001)(8676002)(6916009)(16526019)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?G87zqvcP4HryEDlslHV1dd+aQUxh6rmu2ipBHbIDXhOQ3HMNK476l/VPr356?=
 =?us-ascii?Q?2KnJqesiin9gseEpsrmTyfBMH/mlkMO7KjG2Guf+jVgMxEnTfDO84sXh/BZV?=
 =?us-ascii?Q?JQ8/FnLZeQB/m1wmx3yfHEz7tbEBOSKcYF2bHW3MOcPkFJvOWVJmSfP3MKqv?=
 =?us-ascii?Q?VN5qm0GedDwEekm0g1+f/Fmy3uEMkBAsJK1WZfBKzIO8XPQpjmdvpfyXv7Hl?=
 =?us-ascii?Q?ZXx+vlk6M6xAXvgE9PbyhJUY7I1PATWcM297KYrx4pvoAcEAPLyFxArPPVKO?=
 =?us-ascii?Q?DdImXUQJef3O9Kk1gSurqEP5AytTl8UFCzlZPX+z746kMD6O97h157jeieez?=
 =?us-ascii?Q?iQDtsPB4MZUUGzkSQJ77AlioGEeqYT8a31xfu1tCpbHAUOloIgJwz7/1vWr9?=
 =?us-ascii?Q?6puSKMoOymgig/cobpYQAZYSRaXuPftJStbIS977dghS4b9ZQLQ8mtonCfDd?=
 =?us-ascii?Q?0C4T0hD3vNuJ2nXSaf9mEaiAcgzbZsUGk45+x89E40/1kI1LpeCSMhstCGNq?=
 =?us-ascii?Q?5WhD/PuEePpiNeVhjEmUVYUBmqO9/aGArKMdK46s2thOm/5pYxNPAeZsCSqk?=
 =?us-ascii?Q?wo7+9DWh6cOuLzBmTWVY+q9D2PZs7qkYLNXh/Hov0rhFZB4EtDrbKQ/Ycjn2?=
 =?us-ascii?Q?wfGNvk2ClXZ8lDjdCnwMsNsw5f4kfFK4PPAILMMyAajJn7AcUSqOEsFh0aWO?=
 =?us-ascii?Q?ZIL2eV+m5a8O4Da6rtXh+KfW4H64vdYlsx7+pUA6wRSk989I6IlFQZaSdB03?=
 =?us-ascii?Q?3TnA7f5rpdzJxQImTG3fWUsPfSAO3CRnUa9/+/ejNTYdNTrnxACFFccXR8Q+?=
 =?us-ascii?Q?X+ugXqMOh5Wd3lIUn2/xvMb/w1Yj5ibU0QmnlshWn0NQasxlkrbFBh2MUrc7?=
 =?us-ascii?Q?P6KmlwmdjSr4lKMX2BDk9zCWVPVz7sL3gOLd+sCYWgISypFmwLPkWwPPpf5T?=
 =?us-ascii?Q?c6dhTgzE7/i9Pm9bDhojYE428Rj1dTtsYIlQBQnprx0Lwml4oqeCaPd815JO?=
 =?us-ascii?Q?dJlapINC7IyAcQbXzL58HoL5ag=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 01:58:36.1894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4f55bc-0a54-43b5-c6d4-08d89be5f0ce
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BfYHU3akEMe65CsozZG1cUWVrKKr9DA70mNjCkeuO9/jgQI40usGjL+WWcQFO4Eh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2341
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-09_02:2020-12-08,2020-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1011 suspectscore=1 mlxscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090011
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 08, 2020 at 12:18:41PM +0800, Muchun Song wrote:
> The unit of NR_ANON_THPS is HPAGE_PMD_NR already. So it should inc/dec
> by one rather than nr_pages.
> 
> Fixes: 468c398233da ("mm: memcontrol: switch to native NR_ANON_THPS counter")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks!


> ---
>  mm/memcontrol.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b80328f52fb4..8818bf64d6fe 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5653,10 +5653,8 @@ static int mem_cgroup_move_account(struct page *page,
>  			__mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
>  			__mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
>  			if (PageTransHuge(page)) {
> -				__mod_lruvec_state(from_vec, NR_ANON_THPS,
> -						   -nr_pages);
> -				__mod_lruvec_state(to_vec, NR_ANON_THPS,
> -						   nr_pages);
> +				__dec_lruvec_state(from_vec, NR_ANON_THPS);
> +				__inc_lruvec_state(to_vec, NR_ANON_THPS);
>  			}
>  
>  		}
> -- 
> 2.11.0
> 
