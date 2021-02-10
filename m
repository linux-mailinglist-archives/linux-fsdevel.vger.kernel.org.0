Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06F7315C46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 02:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbhBJBai (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 20:30:38 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45676 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235138AbhBJB21 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 20:28:27 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 11A1Nlwm012312;
        Tue, 9 Feb 2021 17:27:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=nEyyOcjfAkEszv+LmE4DI+TS1pI9ng/a0uGNiwZeftk=;
 b=bRwtEPVGZK0fUOeQJjsCf2Q/t27xk2ub+5guTeJ/8PN/DqnCAs3JVyfkwK/gpECiXssQ
 M8gcy9cBF6HrtR2tODDQQJfopfMZXwln9cRH4TsFiif9yiT8E04qVueFuJ4on+XB2cHl
 hR3Q1YgAEAHyclwbsNr5pKPsZJyozqPDLD8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 36hqnthub9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Feb 2021 17:27:34 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Feb 2021 17:27:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aqm73DCalLXLuY/1ScKBdq1sgj5E1YfxCXcPo/Gx4WbV1XZ7o9nYoOut5O8FTOqOSxwiNmnB/hnTL7UBRlquBtBFpYWC2cNZ0F4SzjBSzUwspjuo85+MiAMPjcHxJ9Avc2u47Q9GC1a6GwQA8SkgNOpAtEBMjrIuedt6/b1rubqflVvfk0S+Oo/+lcq7Ctzx2jMo5nboKrA0r3qBrkdu6AO/HvgPn436VPgwsegb7F9GMaMFgOULAOpyyBtlD37i5QlMKWblWEdM50IoYzdemRN9mkcoQ9nodFpmIYEr76o33Ce2kzie3ubPdLYNT/J6GEsVu1yYRdcjYsNe6c2WwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEyyOcjfAkEszv+LmE4DI+TS1pI9ng/a0uGNiwZeftk=;
 b=I66fSMp5KaHi0bHyEYNa1dr0pBdFS/1BUH3RAKtBRPkJOdI9ExGzDuOUzRuLUxQ1jVUrosMKfaLvNBNqrCAb6viVktuIxyfP5ilGwxgdapyCZpSq21dT9CQwz0qGV3Ja54k5EaM33sTGivTfRd/p/Jtq9WbSmbdaWAioPEisa/ebfDwYFY/QrWmVS0ZRq5hCrngp2HBbULSw6QA04i2CdKV9/usQrdQFB0OD3kOucCdko4De6gpdFgyCCI5swNBNuEHDhmYS7/mG/Zkya5UNMbJZRJAxry2nKpI83yPeONxBkNIEQlPZZeGN3Mm54B1DUrdb9OcRhqoUk9yfLdVCXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEyyOcjfAkEszv+LmE4DI+TS1pI9ng/a0uGNiwZeftk=;
 b=bIZttEBK1PfwMWJiMOND/Ra2KANForuamTYM6mVc4i8SQUkV29suy3bM0o5vKgxAek9noGmHGczveuIwenq5z3OOraf9bGIOX1mSeGAJET/fM4GhoQrYrIu4YGqSG2/aJfH9RzgZ7HSJp8NVKaK0cREBDDHj5so0M8UqrVuOCg4=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3350.namprd15.prod.outlook.com (2603:10b6:a03:109::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Wed, 10 Feb
 2021 01:27:32 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3825.030; Wed, 10 Feb 2021
 01:27:32 +0000
Date:   Tue, 9 Feb 2021 17:27:26 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     <ktkhai@virtuozzo.com>, <vbabka@suse.cz>, <shakeelb@google.com>,
        <david@fromorbit.com>, <hannes@cmpxchg.org>, <mhocko@suse.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [v7 PATCH 09/12] mm: vmscan: use per memcg nr_deferred of
 shrinker
Message-ID: <20210210012726.GO524633@carbon.DHCP.thefacebook.com>
References: <20210209174646.1310591-1-shy828301@gmail.com>
 <20210209174646.1310591-10-shy828301@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209174646.1310591-10-shy828301@gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:4589]
X-ClientProxiedBy: MWHPR12CA0037.namprd12.prod.outlook.com
 (2603:10b6:301:2::23) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:4589) by MWHPR12CA0037.namprd12.prod.outlook.com (2603:10b6:301:2::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Wed, 10 Feb 2021 01:27:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43da27e7-2f25-4365-1f98-08d8cd6309bf
X-MS-TrafficTypeDiagnostic: BYAPR15MB3350:
X-Microsoft-Antispam-PRVS: <BYAPR15MB33501634EEB049F41B9A8281BE8D9@BYAPR15MB3350.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LlAzZvfVAg/jp/cp7TPF1ftWxkIffH56onqTf7RQ9+T412jY4c1AqF9ApcckqFgssqciVvQ/foO2lf+DN7k2n26G6S6FuO6WKH0vPgQFzNgpFFszD24Nq+NIIFzz5abKwoti5io80xKVhmSj0aQBvMplyh6X9bPgqO9AdOqx0phnUV8zyFi5J9gdT6wEavVTWrPTxyuGl99HfEJjPeaprjEE0BQ2CdvHI1kSdDc0sc4iJ96e0jmshatetpdu+oKx6Q3myMcdjUgg7xre3iLUiMy3pYbqFD9gyAYUo8/bAub2ECSCQPwEHPLUEv8YGJXfrtJ2b19jpItW8H+ClPo+Uy3lAIAsH4ZMf9ib8Km+tZ29GWyb8zrNxDNpyf1eTubQPGq7w6kIfjMT2nadCWlLZwI6azUHbND8G5PkxsPf9DW5zQhXaASoe9oo8OjdVUvQUD8mH1yaQEg54x9qebhdMsRFr5FdBkLK4CyL2qiO3knj7UiroS2i0Bkx7J3QKtWl75lbW3P+qHujzEa5WNl7pA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39860400002)(346002)(136003)(366004)(66556008)(8936002)(4326008)(86362001)(9686003)(66946007)(66476007)(16526019)(186003)(55016002)(478600001)(7696005)(52116002)(6506007)(8676002)(2906002)(4744005)(7416002)(1076003)(316002)(6666004)(5660300002)(6916009)(83380400001)(33656002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1PBsLsrUfAkO4czA5BbcNwG+FV1qZm5BiuSPdVvlCggTfcv4ktWhUEfKbhw1?=
 =?us-ascii?Q?3QBKxrzlGTu+jY0JdOcOXuNa/XNAwz2GU9taBAFMEwgL/5koRkz4HKKSiHbE?=
 =?us-ascii?Q?FTQpCtlQSixwOShHMBj9aM58ruhewMiCFABaPCu/pEWWAeIxOGPNieIVrvqr?=
 =?us-ascii?Q?uFZ6utObiEtF64RQ7TIfC2TMhJCv2q5KBt3EhQpQbe9xZUgP7F+i4HqtudB/?=
 =?us-ascii?Q?Lx6/6QNaJoKFh1nHPVdxLYyPkF626IxL2X0XKYr3Q19YYXNCx57Xbj6wHw9h?=
 =?us-ascii?Q?h8lQGFFiTdiowhp8LIY4cttgviA4bYvZ6JiR4nrXd4P8/YqtJFb5AXTxKyYD?=
 =?us-ascii?Q?D2q3CvADleEnv2NZAlP2QTGeoI/Nf5u5s/v3XpanoHYQVTQkFugk6fCn07wu?=
 =?us-ascii?Q?+nWpcRQeRosvHuBK7wGBLcjEGENEGAiyHAxnaxshqfg9rP7Mpldq6koLLv/S?=
 =?us-ascii?Q?lfBeIpQWl6AlrK5FblWpR4D6q6B0Oo3glNQH9FuBfiPTgq9lIu/0QurCvpo+?=
 =?us-ascii?Q?93A+1dE7bwfM90DM7D571peF3ICYknQu5I1rLWnFiSNnrVQQqbiAYUAiel84?=
 =?us-ascii?Q?ZDoJw0aatNMcQvN+lQSM/+UYvjsE4Gn0ACFCm7j2D0fo7CF3JlNIl/OoomEh?=
 =?us-ascii?Q?1RAMUG35J6eN5OR23m63TlxBRwPxojAxjUVd8rMaCisBX1XsvyE0c55v7/5b?=
 =?us-ascii?Q?cElo1c3HWg6WSDu3K4buHmyEfM4TVJsUKI6pGeG4KWhN7s9cmQq+kDFy5quH?=
 =?us-ascii?Q?FjBO/XnhP361Pot/qXMgF3fCoI7DxU7FyOUk8LNL6OSuMizIVDiMTMYByWob?=
 =?us-ascii?Q?qRPen2e3K71KHx0eaPxVGHiXj/JZigDRp84jtpbUWvnxv7eYHY//CvHH4lfr?=
 =?us-ascii?Q?NtmsmFWs62Vx0pyR2+epI8/7uMlSa/Gp76xF0Aj22IeNYW9Plwu1IYOLMgQI?=
 =?us-ascii?Q?7atNcLmhtwuWOsjVSqYVy8DCQcx8McyJTOqRW3ehtR7Fdw1rxLIMOKtzIay6?=
 =?us-ascii?Q?3N86SAO7oKfQZthwE6yk4uq9Inx8C31gJ6B394J6H7A7MFpaJ7znfiaETE05?=
 =?us-ascii?Q?AOdSo7nAnfagXeRHqH+s5L48lp0TijUACXFPIe5QTQhMhoTdTUjZPS8P+PJe?=
 =?us-ascii?Q?4g3+04tiHSqbOhJpqxhlTvcJIvNyAZUq5dUnKzJrF/23LwKsI7Sy89afvTfW?=
 =?us-ascii?Q?6yhv3yvFlxKy2Ahd6Y5IKWzUnI8WBZ4JCaOKCkHBpiD0On1xMtemNOGtypmW?=
 =?us-ascii?Q?K2KaaJEID5fw/T6qwYdEBzad3XYqajLMptUAptrTYTM+bnaedXcdxvguasGL?=
 =?us-ascii?Q?8xIzq8ATz6/M5dipYi4xQk56PwpbUl3RIMvPrclwISxUu2FJ3ZDP70lcdJKr?=
 =?us-ascii?Q?XuKR9N4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43da27e7-2f25-4365-1f98-08d8cd6309bf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 01:27:32.3571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LU3X04Fcj9YAqbC5JRslZPQk4KV0+YxLxx5c7CyIyeFhy5P1eE9Zb3/55lAm7la+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3350
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_08:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100011
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 09:46:43AM -0800, Yang Shi wrote:
> Use per memcg's nr_deferred for memcg aware shrinkers.  The shrinker's nr_deferred
> will be used in the following cases:
>     1. Non memcg aware shrinkers
>     2. !CONFIG_MEMCG
>     3. memcg is disabled by boot parameter
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/vmscan.c | 78 ++++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 66 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index d4b030a0b2a9..748aa6e90f83 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -368,6 +368,24 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
>  	up_write(&shrinker_rwsem);
>  }
>  
> +static long count_nr_deferred_memcg(int nid, struct shrinker *shrinker,
> +				    struct mem_cgroup *memcg)

"Count" is not associated with xchg() semantics in my head, but I don't know
what's the better version. Maybe steal or pop?

Otherwise the patch looks good to me.

Thanks!
