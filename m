Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F003C315C50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 02:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbhBJBcs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 20:32:48 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60264 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234905AbhBJBah (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 20:30:37 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 11A1Rjml022070;
        Tue, 9 Feb 2021 17:29:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=rvS8m/OZfe3xoVbz9OdPiBteV2pJOn030SHgKciycb8=;
 b=lG6imbrjtFHdW2Z4B50GSt7EKv8v9t8QsDYb02PEN2zMLOWkOT57kfJ0ACeOR/zt7loe
 dZjDZLzrEp23LPgUv/jk5S84qd2pNEYnKPdV+tolIfrT0F8xnCiSQfJNpcOq4/JPxbjN
 Trpy1DZX3wfHZEbI68jdQM0T0iCAuX47VUg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 36hqnthuja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Feb 2021 17:29:38 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Feb 2021 17:29:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNHyzt2ajePis3M6eAdnMcOS74INW1J5/5NF15eabiCvetLwRlWQG6U5gKKu1s7pe8D9Ps43Sxfz1G2VYJ1xZroDMT3pWgxDMVJK32aiQM5qZhqPWS1joyQ/u9rd2+OFJxwsVnhTSG21hgSTPP10anMh6XmyWWG602erxIufEt9RCexwEhaCNjcvIebXlbr4tZmyLkTIt8/BOFvLwsjgxWxKfUDi74wcwiEMJy4lNkykhtzO+2YeIWoHoz8aUdvF0DEu0vCKxm2jp9zW3swu6+V/azr6xAN00ySff3qIL6SICwONywYG0ihOOD6ipHBHMczk0i05cYF2Mix13a3wyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvS8m/OZfe3xoVbz9OdPiBteV2pJOn030SHgKciycb8=;
 b=PIYnWB1EvFGaPSOokUN4q7O6iX7MnVB5ahjymAZp+zI5MfG/uL74PZkHzhntpRA4DGRObT1mPbuC3cFkWSigjQaxYGEpk1Fw/1Ree7L4/m9wGtcgiS3pJsdq4bvVuqATSAgo4InFZEIxbRsLGP5tLmE3gUWlzM/rh9QGgp93cveDAT37Pokj43txwWgEbbCElhWnTVEtpb5uJnyeXHCE2+QQKNLICc4Qjcmwg1Mvuv6ngEtJvYIAJSM1EWIxPW1AB91+kqYR0GrYg9Zaa1ae+tHSonAJ/li4Uym5okddGth110oSucnqMCBY3vjqjIWGlDw/W6N0k6QDMIrAybF8Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvS8m/OZfe3xoVbz9OdPiBteV2pJOn030SHgKciycb8=;
 b=JgSUJRUkHxDfo18RVmLTSyFF46Nm1vgodSXRR9ibDmXfd6E6dMZkEs20cU1ylShE5EsqclvNUejfkJNsCfHDteHbcAiOU6hCZi1t8aLGCzVFPvqZKuRSznco96bk2FWBB0kRnHEI19AjN5/CfMdDbCNbhjGrwHZwbTAxBAM54T8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3350.namprd15.prod.outlook.com (2603:10b6:a03:109::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Wed, 10 Feb
 2021 01:29:36 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3825.030; Wed, 10 Feb 2021
 01:29:36 +0000
Date:   Tue, 9 Feb 2021 17:29:32 -0800
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
Subject: Re: [v7 PATCH 06/12] mm: vmscan: add shrinker_info_protected() helper
Message-ID: <20210210012932.GP524633@carbon.DHCP.thefacebook.com>
References: <20210209174646.1310591-1-shy828301@gmail.com>
 <20210209174646.1310591-7-shy828301@gmail.com>
 <20210210002218.GJ524633@carbon.DHCP.thefacebook.com>
 <CAHbLzkp6q60pGBGKB-H6k5YoCy8ZHcLVj4rrZOsXi3=jOfbGzQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkp6q60pGBGKB-H6k5YoCy8ZHcLVj4rrZOsXi3=jOfbGzQ@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:f6e4]
X-ClientProxiedBy: MW4PR04CA0249.namprd04.prod.outlook.com
 (2603:10b6:303:88::14) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:f6e4) by MW4PR04CA0249.namprd04.prod.outlook.com (2603:10b6:303:88::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Wed, 10 Feb 2021 01:29:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ced2486d-eb3d-4a31-2d21-08d8cd6353e8
X-MS-TrafficTypeDiagnostic: BYAPR15MB3350:
X-Microsoft-Antispam-PRVS: <BYAPR15MB33509A5A9A7F323923F1A78DBE8D9@BYAPR15MB3350.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vs+0dTOKr+JtDMN14tclktEesjN49Xqrnh3a1mgld1dx8yNKjMU+i5GFdNut4kR++jlmcqCXSd0O2/HtFsMy8NS8ud585fXJrIzZSdoDfo153b4NcO8wPaUwKnF0K2T7VCpKOJY/oe8lo1eVK5Y+5ymBqW9obsS/BpOJtjdykkWi6Rv3Afz1njv9oyzP+rfSpYJOiR+5eSaAmvaZgMGWx7ume31Xrusm1hrlfd3eKhe1qRA4rPcWrYLsjw7mmjHqoosAdj/PR8PMpCSZQ7VTUzhp3WbRrsclnoRPDchjzgIauXpo5FwE1SFt9C0TyI4yonc+tyz5JSvh7BDyrSS+xaM1QuOB4HCTrVWXjRG67ESVR0d5Q6T6i45/9aLfqXGV5nfjkjXhDUEYpQJhZ5m0xeYBJnoLq5OjlfP/V75PtOIO9c0boTNQsSYWWP3xjyvm5Jmdmqe4C1WAf4s/HJt+xeQfrg6c9Z8acRJR4UFeaxrVIVTN6DQDG4Tv8ycHCi6DvQIKPUiRry3cPgYuZSm8rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39860400002)(346002)(136003)(366004)(66556008)(8936002)(4326008)(86362001)(9686003)(66946007)(66476007)(16526019)(186003)(55016002)(478600001)(7696005)(52116002)(6506007)(8676002)(2906002)(7416002)(1076003)(53546011)(316002)(6666004)(5660300002)(6916009)(83380400001)(54906003)(33656002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?CKIiY9FL0ha2H2zoBglQW+SIGItkvUSK34BH5rKO6zsW+ygDs+hPu9OvAPbM?=
 =?us-ascii?Q?d1+umDFI99znFu3lqblTpm1IocRYBHRes5aHhSfSXljamSxWlKZBpL2UnnQQ?=
 =?us-ascii?Q?vaHgvXDhhWYDVLPZdNvOTr32oH2lYd58alu3t4Ke/dm4Zn8rLSrWhMxThyNb?=
 =?us-ascii?Q?y23Rh/G8If440DBOcThZmwa3r99b5y5IWofN/4myg2i2Nxgwew1WZWek+dxI?=
 =?us-ascii?Q?DDul++okVh2Jx3GA5c2rOI/BMEBBJzcE+VIvVEVpBSU80n0z18rmDLukZSfA?=
 =?us-ascii?Q?74n3GgdXpi/VaDnEeRX1iRQ6fMedAHW3JJTNsINztiiMOTQmXIUrTTi76H3r?=
 =?us-ascii?Q?zBB43W6p1nyQGu8sHYYWrTOX7bu43Ne3RmCscoUhi1rH2QGHMtrLevM5evp2?=
 =?us-ascii?Q?V32lNWnhC3ac4Ptxm5cTm59neWmbVpC250Qfo2vlA4VKv1ueMlTZcUpSrroG?=
 =?us-ascii?Q?vmlvqdpY3RTxbY4O8wNsinxM5PUwEOsRi/6pXarQ6IqupqLouq0mQYMad63O?=
 =?us-ascii?Q?2v8Ng9c4eEkx+d6T/mlLcdZ8yigjg0vUNhN18kvlwTg+X5kCv3Ik6c5rsALg?=
 =?us-ascii?Q?351xRdd75hXiuO7EBTMul5pqbsB0ahjhxzIuaBi27qryRSRC9kUtiBHIuyxC?=
 =?us-ascii?Q?UOWFOpd0isQohQVsf8PzNcNrXuHAKuUu4MkhM8O1CsZRiEkq5VOju139Tbzq?=
 =?us-ascii?Q?t34C5dCQ0EX3aSfDksuQ74j2tIRbL8qBxso9GQ9xEBhHtN3fRJWFEWcMA0S3?=
 =?us-ascii?Q?pzxArY/AheoHWBb5Z4jFG+MXd5jR00KrnYX2EY3kTxYr+9OnRJt4W6HzJw0s?=
 =?us-ascii?Q?xxmVFefTYLwOyJQgi4N2Cg/BEK+hNccEme1mOeeTQMrMq7zdQ6dV0rsSE1Si?=
 =?us-ascii?Q?3OA1thgXf3Kky/m23Gd1XV/YFfOcjjiSb7q631dUBcOibZtb3uYr8YYQ4CKE?=
 =?us-ascii?Q?dkTVXh4VdCYMDZj7p4y76h62tcTNyECJF64g+eTixNxx68D55FIyq5bYUURe?=
 =?us-ascii?Q?cV6TSXzn9lg7qDNNrqvkBUMJWAkLVa+lJVvLQJbtzIsVZjoo7lVf/mDOS1dX?=
 =?us-ascii?Q?bVGV88qCcl/l2o8gFSXzQAv4881oiFhHfOWqDWQrGA9aKMVy/4xd+at83i7g?=
 =?us-ascii?Q?u3Ih2w+nK7eVhaiyB6oTx6PAPskk3M2qBGt6+ePnChQ/DrQ7KS9MYABc8IOW?=
 =?us-ascii?Q?4vVWRk4tkxE5qZUIpdX74x1PbWuTuUXBSuXEhge1BDKoLrXX3pOWULIV1xsE?=
 =?us-ascii?Q?nAPd3Sk1BIS02jj5nPwPT5sRj1HdikqgfXlcekPjn96Hs4+M3PfRIbjG0FPx?=
 =?us-ascii?Q?ofpKPFO/uZ+/wec9Avbx/8ZAoT3G2FKpGkXYTgcfEk2d7ldvhQ2ecDg9VsZI?=
 =?us-ascii?Q?c8/vWaw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ced2486d-eb3d-4a31-2d21-08d8cd6353e8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 01:29:36.7355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMDDxpLkiKIMGtzDMZfhW/AsFqyzHR0D0XkfwLKJ3SSBqhBMWMmYWIgGgvm5aCA6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3350
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_08:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=867
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100012
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 05:07:07PM -0800, Yang Shi wrote:
> On Tue, Feb 9, 2021 at 4:22 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Tue, Feb 09, 2021 at 09:46:40AM -0800, Yang Shi wrote:
> > > The shrinker_info is dereferenced in a couple of places via rcu_dereference_protected
> > > with different calling conventions, for example, using mem_cgroup_nodeinfo helper
> > > or dereferencing memcg->nodeinfo[nid]->shrinker_info.  And the later patch
> > > will add more dereference places.
> > >
> > > So extract the dereference into a helper to make the code more readable.  No
> > > functional change.
> > >
> > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > ---
> > >  mm/vmscan.c | 15 ++++++++++-----
> > >  1 file changed, 10 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index 9436f9246d32..273efbf4d53c 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -190,6 +190,13 @@ static int shrinker_nr_max;
> > >  #define NR_MAX_TO_SHR_MAP_SIZE(nr_max) \
> > >       (DIV_ROUND_UP(nr_max, BITS_PER_LONG) * sizeof(unsigned long))
> > >
> > > +static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
> > > +                                                  int nid)
> > > +{
> > > +     return rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
> > > +                                      lockdep_is_held(&shrinker_rwsem));
> > > +}
> > > +
> >
> >
> > I'd probably drop the "protected" suffix (because there is no unprotected version,
> > right?).
> 
> No, actually there is one "unprotected" call in set_shrinker_bit().

Ah, ok. Then it makes sense. Sorry.

> 
> >
> > Other than that LGTM.
> >
> > Acked-by: Roman Gushchin <guro@fb.com>
