Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6939315C60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 02:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbhBJBgw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 20:36:52 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43808 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235108AbhBJBff (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 20:35:35 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11A1X9pB006202;
        Tue, 9 Feb 2021 17:34:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=3mCJWurq8u2PKd9a96O1qNWdHlDlpxlJGtncmoGZFeM=;
 b=ha0ZPkk8BfSGWNsYNwPH7hlGcgM9Rlc1EvSDUGho8TJaP+Dcb8YEo9R/9a85SmbHKbXk
 E4jzj2beCaV2OgVTOrSm+6Ovuu6HLpFwkYrEFR7Q1PXXM8I5FuAkP4ehYpkI13c47nbq
 2l/58+85doRJTkKgAnHFcc7nxx3WGycIPto= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36hstphg5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Feb 2021 17:34:44 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Feb 2021 17:34:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8xd6r2iApPZpnkIpodSTt+Tsresf1VKTV1m6CSebM6r77uVhdUZkLX20/79rt+E8YmLj5HOxZ837JyabohummxUBxlLtTqzgvkvIZ7O9SkwTdCRTNsyJbUjOy4J106SRWYVmr59jPc3vtsVrDnErVSPQDyinNLamRWfd1xr16OsPEgOx29gbNLG+J+xmO8mgFrJoPm1OQSLCcRcKjiRtz8WI7FhPcx7iP4bfxbUjRLzXTnL3Q4WaaHO1BmMf+4E8++N33b0uVeZB3FlUQYWpVt1mwU/bDd39Q/+iZTxFItkJJYguXv6kgh8pNSY5K1hUHpNtjmQBDJZN8zVI/3Eeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mCJWurq8u2PKd9a96O1qNWdHlDlpxlJGtncmoGZFeM=;
 b=mweHkvuPQ3gYytAeKcyzDCuCkSMPbJbhNS/Qipj7laNNSs3o8Hx6eGWzHUxXrVcSdlHgq4YF070eFj13glgxHDjSXa3ZBX5lYJKdGy9LGGO1pp/tK4GjN4/za37Fb1vr/eUSN95rkI+t38WRMna6uG8cSA3auctmMeRHKKICUW6Rs1nshax85X92frk+cx1D+k4xYNCQSwkVfqBLC9zt41TmqX9mKQcJSZ8xB4rgadeX/3hv8z5wikFn17b+H9qv/0ARSKvO6CUqngwVgk4mWTBpdckjXOeweA+BUAtnFcdSPquqJKv5ZNNuJ2QYk7zSBxGa/0lPWY9hri61EH7KZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mCJWurq8u2PKd9a96O1qNWdHlDlpxlJGtncmoGZFeM=;
 b=OOqq67pw0djeflZfltYyzis5IWZsHIDE3aAArd4qfkU7R9WYSO2b20ASeTdQJHYswTuZiecKrcNfA8DnHwU0pTfmuH/jiR2k2mqdqD7whrIcxFDG2O7TpNUBdP9rre0TnlJlZjX+eqIF1EIHnm48njeNO2YgeCh3Y3VHsIf45rI=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4758.namprd15.prod.outlook.com (2603:10b6:a03:37b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Wed, 10 Feb
 2021 01:34:09 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3825.030; Wed, 10 Feb 2021
 01:34:09 +0000
Date:   Tue, 9 Feb 2021 17:34:04 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v7 PATCH 07/12] mm: vmscan: use a new flag to indicate shrinker
 is registered
Message-ID: <20210210013404.GQ524633@carbon.DHCP.thefacebook.com>
References: <20210209174646.1310591-1-shy828301@gmail.com>
 <20210209174646.1310591-8-shy828301@gmail.com>
 <20210210003943.GK524633@carbon.DHCP.thefacebook.com>
 <CAHbLzkq2_=b-_4adsf-8vwcG6io6Zx_2o82207S6z8J7ShfTMw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkq2_=b-_4adsf-8vwcG6io6Zx_2o82207S6z8J7ShfTMw@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:781e]
X-ClientProxiedBy: MWHPR18CA0055.namprd18.prod.outlook.com
 (2603:10b6:300:39::17) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:781e) by MWHPR18CA0055.namprd18.prod.outlook.com (2603:10b6:300:39::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend Transport; Wed, 10 Feb 2021 01:34:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 152989b0-4b56-4913-d1da-08d8cd63f68b
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4758:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4758E091782C9AA8BDAAA5D2BE8D9@SJ0PR15MB4758.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AaGqvQ+oTsMy9aVPMHYYASwhHuGQGzov9wzSYPgHcPhYM5Tz8o+JYpJlkjFSA0Ko2mmcYj08tMu01rLezDU4SvsduPxfk+si+GXSmPWSQbqGaDOwzsKk9q7LGbkn9hQfz8y9ouUizqkE2yhCioQ9t6uDkPXJsdxyzhk1dU+X6C52aXwUzEHu4oxO07L2nbhJwSBq1XUWD39wklc1mWEGREmNiab1vNpV93JZtMSc5cSsQc3v6aln479018WdKwInVOIa8AokYoA7gs7oRtIhMoT4199ajgLFhfz8GrgeN4c20NZZ+y1qWft1V4ovnGggymWBXob3CUPSXeY7q3HZhaKDCBkSW8GnirzjFNQ8XHv7adEw53WCEa/wmuUcXyn0PViPe0w/ynulPz7GCdXm79MMavBZHUehk6B2OdBS5POb3fYQfKPG/6WevHxmDZwxBNQlF3CQfgE8mCdEAiYUHyZvZgLkVHxAWqyF596sWefflA3tKwwblN9Ek3/qbaPEcqLfzae9VosXhvnUTzJRiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(396003)(346002)(39860400002)(8676002)(54906003)(7696005)(53546011)(6506007)(52116002)(83380400001)(1076003)(9686003)(66946007)(316002)(7416002)(186003)(16526019)(66556008)(478600001)(5660300002)(6916009)(86362001)(66476007)(2906002)(33656002)(6666004)(55016002)(8936002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0G5cYBRRme0x/nu+Iw8w1Rev14k/wfzheEoaAszzJONlBSdFFrgkQ5AQTjob?=
 =?us-ascii?Q?zGAMn1hA4Uvg1lzfHuXJ1X7m3dxFCU5ndyXKbmUyR+OOmc3BXuIYc/SQawlN?=
 =?us-ascii?Q?53jpH7fEry5yWom8Npxo3ePG6lzzSIwP+wEf/VuYqnPkgyIACXwtdBNAgKjy?=
 =?us-ascii?Q?b/23n5MuGdUuH4McLuJMC7GoaBiVx8ZUaJiMLr1x5d4RJPr3UFb4stFCJtQ5?=
 =?us-ascii?Q?MNBjIj43HAKGbo6tkmVBoZ7MaYAO7rQ2vjLd9NHZkFh00RxSdIuoOxto0u8x?=
 =?us-ascii?Q?Oyd/NLsfUuQFPFO/e2kEz5eAolMQ3a7p9PBlUklsL5X+UGMCa5YyPs7hg8TG?=
 =?us-ascii?Q?0t54cjXwqNuz4tHB+WCzqYxqZwfSp2jDXOVUDsZZzf+LuaKFTPo57hGvKghO?=
 =?us-ascii?Q?trAjZmPNf0hCSb8TFxLDgaO7tBv3Ueh07MP7yRmFsLjMIL71/rrkHS2WLhRm?=
 =?us-ascii?Q?ExeXImjeEczZdfdrf4c1M6mmQjfxy2/o23i6bLKQmT0W/yVDQpRzd8RnDB7d?=
 =?us-ascii?Q?U0KgfUHLGDrNRhDNaosMthwv4ArBGbxjsv9tjSG91d8r0VUEipcwwXBEOhz+?=
 =?us-ascii?Q?yUbkuOkKhJIxxxA5UMl/hWdZFdX4bYmPwAvUiOUWiMNpiFj6DSL5vI7BeIhV?=
 =?us-ascii?Q?Dt1LZQpa/P9LERteiymgxL4wshJ0Q80ByNemEBU3Ku7lf3dIdcaW4FQT8/Xy?=
 =?us-ascii?Q?W0EgTevy0wEU60f0N43KpT35qQoCfJWAeZ14YiZbFzsQwrqx9RHT8YrBilOD?=
 =?us-ascii?Q?KMvcZYBPWbWcOB03ab9BQB425PiEe2kmSXJlEieqopp6bHcri3Qcymk8LCo+?=
 =?us-ascii?Q?m4f127n0zKaOnGOuqPG/0TeNn64HcDjKq8ZSa1SX1cWMyz+wQMIJOWusQgec?=
 =?us-ascii?Q?Ti6DdFfe46EFzW/tK4Nq5A4jAZaG31576tpsh5QyrGHuOOaySzH9N0zxS2IP?=
 =?us-ascii?Q?aPRbEgptwU/udJycn6VOz/yGYxCgwE+z+BZ6AUJ+99LG/f32vuwk+4Pv4sWd?=
 =?us-ascii?Q?a3hjyJIjF9chfU//jD6wR3TNmVBuFR4wHAptftqhqn3B1UuMK9D4oRnCxtur?=
 =?us-ascii?Q?2fiDIeAPYWDv84a5rh32RppNiadBLIcYOmZYOtVWS36SO59kW3q2LvLox7cs?=
 =?us-ascii?Q?/hAltrqBuOQQHG+xTgV0oWHHJSIT68U/LVeCveqm8CKfVnOtEUPDnpGvt1l3?=
 =?us-ascii?Q?gL6FyNmewIe6lKfcM4DpqdzUnWDfDLkd/cvStVKesQM8dmX1qAg1Gl1j3pP7?=
 =?us-ascii?Q?b/CKml2qTBeVEpHj3En5DldlWjGToxKSdAe3+rBm5jErAvYLgI6gtbwIiHso?=
 =?us-ascii?Q?TCw0Ow7pQmz+DntB+LFilL7S0jNkoCWp/+7tVSAgmBdZRabMk+61vORlsCBR?=
 =?us-ascii?Q?Fm4wxaw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 152989b0-4b56-4913-d1da-08d8cd63f68b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 01:34:09.7098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8l1tpBpjfq6kEY9I6+L2RiBAbT9THWE8MD+1z6uWVmhANW6/hKi/wEpO59LzHdC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4758
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_08:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102100014
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 05:12:51PM -0800, Yang Shi wrote:
> On Tue, Feb 9, 2021 at 4:39 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Tue, Feb 09, 2021 at 09:46:41AM -0800, Yang Shi wrote:
> > > Currently registered shrinker is indicated by non-NULL shrinker->nr_deferred.
> > > This approach is fine with nr_deferred at the shrinker level, but the following
> > > patches will move MEMCG_AWARE shrinkers' nr_deferred to memcg level, so their
> > > shrinker->nr_deferred would always be NULL.  This would prevent the shrinkers
> > > from unregistering correctly.
> > >
> > > Remove SHRINKER_REGISTERING since we could check if shrinker is registered
> > > successfully by the new flag.
> > >
> > > Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > ---
> > >  include/linux/shrinker.h |  7 ++++---
> > >  mm/vmscan.c              | 31 +++++++++----------------------
> > >  2 files changed, 13 insertions(+), 25 deletions(-)
> > >
> > > diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> > > index 0f80123650e2..1eac79ce57d4 100644
> > > --- a/include/linux/shrinker.h
> > > +++ b/include/linux/shrinker.h
> > > @@ -79,13 +79,14 @@ struct shrinker {
> > >  #define DEFAULT_SEEKS 2 /* A good number if you don't know better. */
> > >
> > >  /* Flags */
> > > -#define SHRINKER_NUMA_AWARE  (1 << 0)
> > > -#define SHRINKER_MEMCG_AWARE (1 << 1)
> > > +#define SHRINKER_REGISTERED  (1 << 0)
> > > +#define SHRINKER_NUMA_AWARE  (1 << 1)
> > > +#define SHRINKER_MEMCG_AWARE (1 << 2)
> > >  /*
> > >   * It just makes sense when the shrinker is also MEMCG_AWARE for now,
> > >   * non-MEMCG_AWARE shrinker should not have this flag set.
> > >   */
> > > -#define SHRINKER_NONSLAB     (1 << 2)
> > > +#define SHRINKER_NONSLAB     (1 << 3)
> > >
> > >  extern int prealloc_shrinker(struct shrinker *shrinker);
> > >  extern void register_shrinker_prepared(struct shrinker *shrinker);
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index 273efbf4d53c..a047980536cf 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -315,19 +315,6 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
> > >       }
> > >  }
> > >
> > > -/*
> > > - * We allow subsystems to populate their shrinker-related
> > > - * LRU lists before register_shrinker_prepared() is called
> > > - * for the shrinker, since we don't want to impose
> > > - * restrictions on their internal registration order.
> > > - * In this case shrink_slab_memcg() may find corresponding
> > > - * bit is set in the shrinkers map.
> > > - *
> > > - * This value is used by the function to detect registering
> > > - * shrinkers and to skip do_shrink_slab() calls for them.
> > > - */
> > > -#define SHRINKER_REGISTERING ((struct shrinker *)~0UL)
> > > -
> > >  static DEFINE_IDR(shrinker_idr);
> > >
> > >  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> > > @@ -336,7 +323,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> > >
> > >       down_write(&shrinker_rwsem);
> > >       /* This may call shrinker, so it must use down_read_trylock() */
> > > -     id = idr_alloc(&shrinker_idr, SHRINKER_REGISTERING, 0, 0, GFP_KERNEL);
> > > +     id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
> > >       if (id < 0)
> > >               goto unlock;
> > >
> > > @@ -499,10 +486,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
> > >  {
> > >       down_write(&shrinker_rwsem);
> > >       list_add_tail(&shrinker->list, &shrinker_list);
> > > -#ifdef CONFIG_MEMCG
> > > -     if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> > > -             idr_replace(&shrinker_idr, shrinker, shrinker->id);
> > > -#endif
> > > +     shrinker->flags |= SHRINKER_REGISTERED;
> > >       up_write(&shrinker_rwsem);
> > >  }
> > >
> > > @@ -522,13 +506,16 @@ EXPORT_SYMBOL(register_shrinker);
> > >   */
> > >  void unregister_shrinker(struct shrinker *shrinker)
> > >  {
> > > -     if (!shrinker->nr_deferred)
> > > +     if (!(shrinker->flags & SHRINKER_REGISTERED))
> > >               return;
> > > -     if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> > > -             unregister_memcg_shrinker(shrinker);
> > > +
> > >       down_write(&shrinker_rwsem);
> > >       list_del(&shrinker->list);
> > > +     shrinker->flags &= ~SHRINKER_REGISTERED;
> > >       up_write(&shrinker_rwsem);
> > > +
> > > +     if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> > > +             unregister_memcg_shrinker(shrinker);
> >
> > Because unregister_memcg_shrinker() will take and release shrinker_rwsem once again,
> > I wonder if it's better to move it into the locked section and change the calling
> > convention to require the caller to take the semaphore?
> 
> I don't think we could do that since unregister_memcg_shrinker() is
> called by free_prealloced_shrinker() which is called without holding
> the shrinker_rwsem by fs and workingset code.
> 
> We could add a bool parameter to indicate if the rwsem was acquired or
> not, but IMHO it seems not worth it.

Can free_preallocated_shrinker() just do

if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
	down_write(&shrinker_rwsem);
	unregister_memcg_shrinker(shrinker);
	up_write(&shrinker_rwsem);
}

?
