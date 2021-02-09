Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1142315A5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 00:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbhBIX44 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 18:56:56 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40882 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234369AbhBIXDK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 18:03:10 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 119JJOX4025210;
        Tue, 9 Feb 2021 11:21:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=AZedllcecjKd+/1Y2zZbildVzqGohDi1Ivufb8o0Fas=;
 b=cJRAix42F0fMAHfAukXla6wtpWY2SxZTPNfsvHGr67kZvzNJyo0p4jhRx+kBTUMACw43
 uIJ8LyrUZW3DLvvyaubVQGQ3p84TryoGXSsoU9mexRiHMTCFJMUGhOIYG2GZsDeihiDz
 KxoYYuACDLpcT8FYDOgCVqxiR6hujMkghCI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36jy96t8sv-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Feb 2021 11:21:38 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Feb 2021 11:21:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Crx2Urz9AJY9QzfkBwHIiTQ4EXu7iOYiiY7mpQIzVTE0W9JqTlUpWFWofM8wRM+HPkFtrzjQrCqZ4Gg/9Jjvs7/3FpnHgoSiU1bYQoc335onGYvOfktAWtsW1DZqfstqE8vAe8dLLWz/Z1gqqintg/BKbrMFuk9SZRDu5X/ExL+lX0lPksw7AtLSuJSzOz0nbAWBLuv1uSiQMANA4v2yf80rPpRedRzyggFUcf4rky81i0PoajasPbjbKlSXq2pHNIRQDyqoWn8fCvl+1sJrUjlKoXNi2WAwyGY+9R8JKvRDS0vxyaHHlNpdJShauwdhbyw8Kzmn3maiCYbYOShCdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZedllcecjKd+/1Y2zZbildVzqGohDi1Ivufb8o0Fas=;
 b=GItEodBORoBGPYztKzwr7A+u4t8W9rSvtLUuvzY4d9XLvNZS+SfRseso91VxUybdJafyjOMy+UUnbVPz7nEeXLQK2VPfw7Vqhw+3P1ahJdenBpE2IfNWW/YZVY6ITUuZFt73la0qJPf1ild8UhNL/tJagfkKbTWgnQJBcndcv5sh1mIhxPvNlHBYsvWUEZnt37DjiDN5p70EYsliaSpbm5RpJk8CCI3JISktXMOccADfqzzNx3vjL+uzQSfNAg+6DoRzFB800VWsIp84Fh2MIF8dd0spjpQ5M0jczJUvNjRso0pdQmNovdl3VbKFpmajcq8Lx8lZ/LBHarfjUa/uog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZedllcecjKd+/1Y2zZbildVzqGohDi1Ivufb8o0Fas=;
 b=Fjs79tW23oSiY7fbAmVBfccPXpkxxbvZb7zvwLrc7nz9UrEv2lOSR+OSBLd82oPqpefJkIXdZahPc6aUXpnS8adBTrIxh+JqV7XTovsb7F4Uoem7VaHRonoa9rJrsgczjcxp3XO3QUeFXO/J3EWMkUWIJYLzWLVr+Z211IIzX/Y=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2709.namprd15.prod.outlook.com (2603:10b6:a03:156::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Tue, 9 Feb
 2021 19:21:33 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 19:21:33 +0000
Date:   Tue, 9 Feb 2021 11:21:29 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     <ktkhai@virtuozzo.com>, <vbabka@suse.cz>, <shakeelb@google.com>,
        <david@fromorbit.com>, <hannes@cmpxchg.org>, <mhocko@suse.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [v7 PATCH 01/12] mm: vmscan: use nid from shrink_control for
 tracepoint
Message-ID: <20210209192129.GB524633@carbon.DHCP.thefacebook.com>
References: <20210209174646.1310591-1-shy828301@gmail.com>
 <20210209174646.1310591-2-shy828301@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209174646.1310591-2-shy828301@gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:90a5]
X-ClientProxiedBy: MW4PR04CA0282.namprd04.prod.outlook.com
 (2603:10b6:303:89::17) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:90a5) by MW4PR04CA0282.namprd04.prod.outlook.com (2603:10b6:303:89::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Tue, 9 Feb 2021 19:21:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56fd645b-f3a8-4517-4380-08d8cd2fe970
X-MS-TrafficTypeDiagnostic: BYAPR15MB2709:
X-Microsoft-Antispam-PRVS: <BYAPR15MB270957754DA59317249C6E15BE8E9@BYAPR15MB2709.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X6ikNc7JOIPxgFCtlLCSqzkjYKdKRbZxvqwwF+r1u8aSlJE47jJVxWD5BjiJju8oPUaAVkRR7lW+m911WfYniwhdtau9KAL2TMFcsx2ol+KCRSsFGjyj9GmdkEHbmSvolGw8GAwn65MTMwT8cuB/IRfVr4IaKC3/byM/g2eNSJxstZkYGgfDOlkrILTUINXqKP8dnxONTfm48YWzkYRja3/aFjFps5UUoxQc8yY8GoWQgUKlTe+C9XDoO+jdtwroy61Nbx4VY5zdajEwxxf3dzBUT/wrTthYdq7PRgqBW8Yzfm5oQNtiYX6xGQs+zqeYw0Llg7B5hYqFWb3Su+eKDhEBbIW/mkqnHSyYicVGt5lV6ov0nXSaYqLLzvdBR9wTiE7QDVtwgtkt36rph7xbgmtzxShOkLikwHTg5yS9txE/rwMq8o9pKkvwT9QCmNmroecJ9Tc+qWNYJRAu+7CjRcerznpi52ehbJRt9AU/cT05f8ZLJUiO82UY+I4dhQJtgpnOm0gAszFEAQ2N9ybqkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(366004)(39860400002)(346002)(7696005)(52116002)(83380400001)(86362001)(16526019)(186003)(5660300002)(1076003)(2906002)(478600001)(6916009)(4326008)(316002)(8676002)(33656002)(66476007)(66946007)(66556008)(8936002)(9686003)(7416002)(6666004)(55016002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2pCicyvdpHbkwCvJStvc+uZ/7ElIx7ZnyOYQILnURfyFykIszXN+pNVLEuT+?=
 =?us-ascii?Q?38Gm2PVH9wPjJXKpZ7coOox2AwTcfEYUpBkPhvpEZ1ayVx/JYCYWz8DB8yhh?=
 =?us-ascii?Q?M5rcRCRmoPlPnSMYm5uMMihLSa6DpiDn2dRi3bPWkIuAoUv+BZs+YT0CGSCe?=
 =?us-ascii?Q?/Qy3jxPIpbXD9+pLfm1LbKDtM7SVWmdyD5nzTtDXRpyNOlCeU5sFeplaoBbj?=
 =?us-ascii?Q?/clfiRFORzwMGhQqcL3cDdPQu7gGYBHT+rI7veGbVCYeojQfb5EUIAYk7vOs?=
 =?us-ascii?Q?FBc75ukbcs6rpeSYwkpQldffFc8OscUvKrJF4ShPjinQDpJYTiiAFISRsaA4?=
 =?us-ascii?Q?P0UESylYLUzjqcMv8NuDk3Scf5XAQSn9cHo0SDUEXRPHGepyjFp8Ls9FeESh?=
 =?us-ascii?Q?CW4iU1pU/1iaKuzbSJUvw6UgRKAuVBV/r17lurVcsuWP8xy/9H3mwV7oTLO7?=
 =?us-ascii?Q?MWaK+Gi50MxXpZlK1SboT2G2/LmWmGM40owszfP1oq+nzSKKygo4zY0MOL5Q?=
 =?us-ascii?Q?+mPAPgUZ04H5tLgFnCHp/jgMhqO4O2qjcKe7xOzmXiZoCSI4idkKEDIqNjKB?=
 =?us-ascii?Q?9H7FfbJODAXT1nH7nWW4slLnkR2wQfXUXZsVNXwiYmnLd4fOyV/cDjXKUxfD?=
 =?us-ascii?Q?d2ypanVD1aK3ACqWYgA05JbDXYvWhNRLSin16zhk5g0mgon7ZRnRoaXYBxoB?=
 =?us-ascii?Q?IHTVxpvCeANyHXT6xcoSZ9anf7vkN7Ahv405asym2ZrU1nNpwDCSFQNz628A?=
 =?us-ascii?Q?r1AU/XJXxLx1vSk+gzZLNN7aCODl4s+zDWVDJ9V4oOtTT4ARBh2egNoklbIl?=
 =?us-ascii?Q?gZlsmPfIFaUryP0BiTptqQnzBm8hJ6E2dompPIthBmfpaYxsPWohgsXV/JHq?=
 =?us-ascii?Q?QA1sPQXbjIJ6wJgXn5CrPdpj5OwWz0Qc0cBBQZL6+mFhNVp4Q84w1BX9BeSk?=
 =?us-ascii?Q?+gi1XwO0Q2YF8ev2ZE2v12i6kd/MBB+pzXhie8XN7kGjL0w34pDH/7+F9Unn?=
 =?us-ascii?Q?E6aAIv/NR3pKhMqcmMqqOlvpyL21RmYZ3lBsYDcO+JHLgcwncrYsgahWtlEw?=
 =?us-ascii?Q?oL4JFLGbh3x4xZHk1+VxFH6CJ8QOhlidvCmAmxXb49n115/NEzoSvgRhEDGN?=
 =?us-ascii?Q?RmNKAdZBJ3kaJwG0BOJyET32kUvXPRndAG73ugF8kfIHvE8QAcGcybvTnEsW?=
 =?us-ascii?Q?tuuCvVWmZfLzad7KLeh7C+P3znzx55Rw1B/5J3nTDViHSdrTQ2WCnj6Je9as?=
 =?us-ascii?Q?yO/jX5OjuKrWQ9QPdDhhyOY4kjaXv21eAgbF84wzTCQLtW4rsnDzywyFZ0Rb?=
 =?us-ascii?Q?jlgAKT4H4zpBlqtnZrnnqU2n4UabLFHK2I4hkeBSz4P23Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56fd645b-f3a8-4517-4380-08d8cd2fe970
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 19:21:33.7959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3UTNkc1PeoiwMFET9tTRpYg4lgMAEJ2Qmr8IwJ82oMae38OZLU+2v4yR4RJBYnr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2709
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_06:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=862 clxscore=1011
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090092
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 09:46:35AM -0800, Yang Shi wrote:
> The tracepoint's nid should show what node the shrink happens on, the start tracepoint
> uses nid from shrinkctl, but the nid might be set to 0 before end tracepoint if the
> shrinker is not NUMA aware, so the traceing log may show the shrink happens on one
> node but end up on the other node.  It seems confusing.  And the following patch
> will remove using nid directly in do_shrink_slab(), this patch also helps cleanup
> the code.
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Roman Gushchin <guro@fb.com>

> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b1b574ad199d..b512dd5e3a1c 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -535,7 +535,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  	else
>  		new_nr = atomic_long_read(&shrinker->nr_deferred[nid]);
>  
> -	trace_mm_shrink_slab_end(shrinker, nid, freed, nr, new_nr, total_scan);
> +	trace_mm_shrink_slab_end(shrinker, shrinkctl->nid, freed, nr, new_nr, total_scan);
>  	return freed;
>  }
>  
> -- 
> 2.26.2
> 
