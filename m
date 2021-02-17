Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9B131D3E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 03:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhBQCAa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 21:00:30 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38408 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229480AbhBQCA3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 21:00:29 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11H1ufnV009926;
        Tue, 16 Feb 2021 17:59:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=4Ga88FzI4NJRx6dnQeOdZOB8l6a/ymhoYyaMEorCHgk=;
 b=AIZMenHycEiU8yxdMHvEiUnSs/WupoA25aBISeQNBqRsfTN9g2+09QVsbWoI6cymlmmI
 phWKBnvIqLRYxyEZTURpEvkm+novE7taU0JIVuYQcspYFUujCDUw1W3WgMvcs+lr9Dbl
 YpxPtrBZ033gxwP2F/jcBruoiN/8UwR1TV4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36rhbyk1vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Feb 2021 17:59:29 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 16 Feb 2021 17:59:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyLxo4P9G6psMLLNE1o3RIhdyseMGF9T5U7eBdgn8+1LgylNHqqCcM/wrIv5ZHlx5lnnWpuvrdV22GidQWo111N6fpxlnjMbu1P3zCc33cJv2ekDujIciPvz0N0TarYONk1QTM8FMPE1M9KNl6JfRIUPFQdU6xwrUsB6WuPPVGdeyjRIjvF8TwZmE9hCuvtJupQ9s1SPZ3Wiuq9k/ls97xDuylgo/+bxdOYZjl3J/rhszIak+den56dXySXotOU38vgU1MatVw57EwaIGLswnoCqz8tHNe/CzQB3nkdqHSwOQVrCv7x6BrdCssSUHl0i9D3rb51pYAVBbNP6oCDzTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ga88FzI4NJRx6dnQeOdZOB8l6a/ymhoYyaMEorCHgk=;
 b=Zd4cGn0qI+GGghzejwJJR1DdRj9EQOlQLxWGR73L3ZKn2iGFJbmbrhddmrngpgpKpmVeG1pIUKK+BU07/Wngex4jP2bMq2LCoLNXgg3E3oB1hAk1X16eumwhYiX1ZBWsvhvMKRLIKF8NFTzD5bRTyvsrRSGIcaoNc5cK8/YDw+LfGtBI1Olx8IV11A82fADFeRyGItahjwTQJOHPMEA0AUjJP8YI4ncdCDnQFoVXNuvrta+5x90NIT/01vO2GsEI0tsZnpJKYJD7rYcxVqxHnzL1kk3JW16H2nSGFKjzja5WTXJizX/ETOWWPJ1Cm9KHb6V9pN1GX759OVvvbCttAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3143.namprd15.prod.outlook.com (2603:10b6:a03:b5::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Wed, 17 Feb
 2021 01:59:26 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3846.043; Wed, 17 Feb 2021
 01:59:26 +0000
Date:   Tue, 16 Feb 2021 17:59:19 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     <ktkhai@virtuozzo.com>, <vbabka@suse.cz>, <shakeelb@google.com>,
        <david@fromorbit.com>, <hannes@cmpxchg.org>, <mhocko@suse.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [v8 PATCH 05/13] mm: vmscan: use kvfree_rcu instead of call_rcu
Message-ID: <YCx4dz/Fg/4iT584@carbon.dhcp.thefacebook.com>
References: <20210217001322.2226796-1-shy828301@gmail.com>
 <20210217001322.2226796-6-shy828301@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210217001322.2226796-6-shy828301@gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:ed2c]
X-ClientProxiedBy: MWHPR2001CA0005.namprd20.prod.outlook.com
 (2603:10b6:301:15::15) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:ed2c) by MWHPR2001CA0005.namprd20.prod.outlook.com (2603:10b6:301:15::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Wed, 17 Feb 2021 01:59:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0082e667-a8fb-4c3f-3c80-08d8d2e7a759
X-MS-TrafficTypeDiagnostic: BYAPR15MB3143:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3143A39218D123632F7FB60CBE869@BYAPR15MB3143.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v99QiBDsnGxNztXHcz9sljRITCaeQJ6SqzcvC6QOLjNrL6rZjrINn2ngsqwnLMhLBPAGGyl19D0E2ULwfSU7U0Fhoj6fEkxyLFPr2QV10G3TBAIEF4Hxsz2S6LzHVsCx2aKFV/caOL+K7vF60pWOfaZYxLHVlONBI4wr26Z5g0EjPi0O6OYE1/Fn4puRR9nS6nEv+7/eKYRR99elSWoZrpfL3gNYCwHuAHLdmGi1dfddKG0vzjUkKEXr+zgb4xkpVIR1unAmLLLPuMLLAR/IUdwMwHDUod60AfgBgCfC+cR0sKXgjMaOyos8Qr2w1O0+o+poMDemTQ+7An97EV/R7LXiyPmAUraOeJXkEPJAxxsifV3VMHHJOxZvzqEw+c+FTA/KtFSSL89nuCdKQa2p0D1GDzrxv24j1fH/iQo+uhdG6aBmRDVd5eKfsbAo6zAlTlewCUepyXPg++ExgyY4OmLrhq2Kk0QtonSZz7FYDcN1ySWnDKtfYQltpL+5sinJWNi8GHYumSS5/Xj2qurPXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(396003)(346002)(376002)(8676002)(8936002)(86362001)(7416002)(66556008)(7696005)(66476007)(83380400001)(5660300002)(66946007)(52116002)(478600001)(6506007)(316002)(4326008)(2906002)(186003)(16526019)(55016002)(6916009)(9686003)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?os3O+Gipr9Q+Ox/yTizhJpjQ65jpdN15879FMjzpy5fjD9P08pweda5e+Lc3?=
 =?us-ascii?Q?VD+Afyhb7uPbwS23Xr8eEkMhOTObefyZU0GqAessyIB5TONzdbtCW3VYUVPk?=
 =?us-ascii?Q?i0WseAC9OMG0qbLSIDQCHZxk2rPXSWyVYNrsO2Ka2CKQdpxOuTCPUtoE+f+r?=
 =?us-ascii?Q?1G7Bn0Qp8LfHLDn8LaKbNcysAhnl/mHW1GxNdl7UDoLG3YU7OSwnzjineqjp?=
 =?us-ascii?Q?2oCzIDJTrLiQsD3qJIuMF43I/F0VbqgNKiSCyr6AVv8m6ifL1bjfYAo59rpu?=
 =?us-ascii?Q?oYKV3HgSrr4t2uB/kygxZd7aAu6Qt+QotJAOvMPvHLobPa1mbbRsAaYH/dwA?=
 =?us-ascii?Q?9on04X+lsTelJHYQeCCyO5jPdX4IE55nUJhr/c/YBcglfwbFDrMtI/gWuj+s?=
 =?us-ascii?Q?/m6tKPqP0eagJ4Lmqia981fNGXMjcPUjB5w/bNMRK4YNgWSt+LLYTv1fuqSV?=
 =?us-ascii?Q?oW1yQfR2BjD1I9+lWVONA1Xt00Uuglkz1VSGFQMg834Yt+po6RlJUhOXK2rg?=
 =?us-ascii?Q?F4/LmhBOAl4kuL174WQDueVf218xrqir6jYLFMcV98geOn+Ly53OpLO8DfvD?=
 =?us-ascii?Q?MCBPyxh11r87qSMXTCC5aSTXLez92eKGea2e+5LrTCmU9bbRXU85wl/rQCEl?=
 =?us-ascii?Q?2UPvRH4nfO6ze48es1x86u6lNuwQ8erxGEF+gpUQB9cKva8QAvtpmUm5b6Fa?=
 =?us-ascii?Q?sE7chfcdN37yxOnQp4qVUk8dfSOUue4++HZw3sEDBdtwcdw4eu3QChX6hw/T?=
 =?us-ascii?Q?BhAye9pLyZZd9R42+9xDJUuD+VgP4TQXp3Z5ruH0HcDRcaK6vQDgrUKJorVZ?=
 =?us-ascii?Q?IRxBmOdSun9I9mHIGEFfMb3aJ2twa9wtLx2HO7sWAd693uMJIu6GGsMeLUKp?=
 =?us-ascii?Q?7XlBDxS+2xcQjh2Om7yOSfq+72mwEAvxFlPjSViYbLELBBBRqpC50U0WJg8o?=
 =?us-ascii?Q?gjBqE0ttWzEwc8DdZwT+wk4giMKMk/WMtSJk/YkCBBRGUUPUVuxWgxMDq/Oi?=
 =?us-ascii?Q?FFNIZ/pSD1WYQBJXe5T7WLL8BM+iXYhLLfn//ft4Z0Wv84y5kSNrDbq0VSrG?=
 =?us-ascii?Q?lZttt2GuWj497ewBHAWb6dtLFS6hniNhdqG7EDnqsUbWDFENviSkAMlZE3p9?=
 =?us-ascii?Q?hA1+ZFOgmzrOXJhn1fLNxEcakhEv/8b5vwdKfqbH5nB1Adhx8Q1EJR6aOkMx?=
 =?us-ascii?Q?qLsyEpk2OfMybqNqC1o7FzG8LlSI0o9Yz+dbwIkPgKCtjlxuxwGrN4lr+tqh?=
 =?us-ascii?Q?u0avoADySMG5RBOsqcd5CGPel5W510z8UyLnsv6+43LDn+sBFDobEFcUIz/k?=
 =?us-ascii?Q?IBYGjMELHKTTppgrjTQR6SKnsYTj7nrMcBdFVTp2x1r/iA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0082e667-a8fb-4c3f-3c80-08d8d2e7a759
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2021 01:59:26.1665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWpn4kouRloi2yfA14nkzFg4cl68jSeM5GqhnR+Ze7i2hmk7EsMY4s1934Nca/SM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3143
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-16_15:2021-02-16,2021-02-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 mlxlogscore=929 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102170010
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 16, 2021 at 04:13:14PM -0800, Yang Shi wrote:
> Using kvfree_rcu() to free the old shrinker_maps instead of call_rcu().
> We don't have to define a dedicated callback for call_rcu() anymore.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!

> ---
>  mm/vmscan.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 2e753c2516fa..c2a309acd86b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -192,11 +192,6 @@ static inline int shrinker_map_size(int nr_items)
>  	return (DIV_ROUND_UP(nr_items, BITS_PER_LONG) * sizeof(unsigned long));
>  }
>  
> -static void free_shrinker_map_rcu(struct rcu_head *head)
> -{
> -	kvfree(container_of(head, struct memcg_shrinker_map, rcu));
> -}
> -
>  static int expand_one_shrinker_map(struct mem_cgroup *memcg,
>  				   int size, int old_size)
>  {
> @@ -219,7 +214,7 @@ static int expand_one_shrinker_map(struct mem_cgroup *memcg,
>  		memset((void *)new->map + old_size, 0, size - old_size);
>  
>  		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
> -		call_rcu(&old->rcu, free_shrinker_map_rcu);
> +		kvfree_rcu(old);
>  	}
>  
>  	return 0;
> -- 
> 2.26.2
> 
