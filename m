Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB2C3313CC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 17:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhCHQt4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 11:49:56 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36602 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229463AbhCHQte (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 11:49:34 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 128GXrQv013465;
        Mon, 8 Mar 2021 08:49:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=eg+FSrpZw3soHN3ZU4gpns9WOSXD5tKQpiViYHZ2znI=;
 b=innAshlX/1yP1hGiYkyNzh/Q/M35bbBjfDoILE7mlJ93Bp4fMl3a3Z4z2OBK3qmSG3LN
 /LdAFRoTvLCMYLfmZZam+O9ZkOcXlXJH7U6pt9URydOmaxFTIKxe92R0YumEg6xIO2Xi
 /L+ko1DCrT6ZyAqxtcjnCOlq9ESubIIoYcA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 374tc0wdxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 08 Mar 2021 08:49:16 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 8 Mar 2021 08:49:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2wUx3rRScw52D3RPipanddNcsDYixoUUa2+v1ygbNxWOyOindNT3ioktjPKln+CN/6q22uf7RoTAXjuEC1GEhBfr7DFQzMcEXZORyIRLgUcGSvGOS8y25LnH9ouh9hFPGYrg2Lnmzz1gJ0ednHn/axS3HkRPlELu+b7ACtwnGbXVmg0+cT6mAom86w7B+7Yos/UB0AW24xuY3KXbh6XcDcSv4uWiuayOK6PYzdwK8hQO/KGq21rJaRPWZZQPcluXed2YRq8/LVzJ+MzEliNYq1ire73fxk/gX9Reap63B5qIXoYXpvXemnut+sEN2l295KkDfcSBRcrJuec04ghxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eg+FSrpZw3soHN3ZU4gpns9WOSXD5tKQpiViYHZ2znI=;
 b=n73yYN3KcQb0SPRNuydm/a2k7TwOTiKjiO6d0GUDqsVOARdxVylUTZbjYhDgs3zvSCAGoMBwlgn9eiQSM5FhF8FujGVi4GjyARk77GM7NVX/jlOsvLb0EXt4A3XF6F4A6Xk1YpfohB1hyrao9IFgiqPfOcbfZJj7v0DD70Xkk14rE6KXuuTA56iecPu8Ug8HIIjILS3RIkcoVvfCjECdHd1+jZhJvUd86keawEw3X6Z68NtY3nGmb2oFfP3DtJS1WZ36GI6KptLX1LkcxyX4AI7MmLbPq5+l+8Z9g0e/Egy8+FiOo3MNTdEcN2llNgSyBHULlF6Tam+I2vVy0s4mGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3157.namprd15.prod.outlook.com (2603:10b6:a03:10b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Mon, 8 Mar
 2021 16:49:13 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 16:49:13 +0000
Date:   Mon, 8 Mar 2021 08:49:08 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Yang Shi <shy828301@gmail.com>, <paulmck@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v8 PATCH 05/13] mm: vmscan: use kvfree_rcu instead of call_rcu
Message-ID: <YEZVhNhGqV33lPo9@carbon.dhcp.thefacebook.com>
References: <20210217001322.2226796-1-shy828301@gmail.com>
 <20210217001322.2226796-6-shy828301@gmail.com>
 <CALvZod75fge=B9LNg_sxbCiwDZjjtn8A9Q2HzU_R6rcg551o6Q@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALvZod75fge=B9LNg_sxbCiwDZjjtn8A9Q2HzU_R6rcg551o6Q@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:7d61]
X-ClientProxiedBy: MWHPR10CA0067.namprd10.prod.outlook.com
 (2603:10b6:300:2c::29) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:7d61) by MWHPR10CA0067.namprd10.prod.outlook.com (2603:10b6:300:2c::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Mon, 8 Mar 2021 16:49:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbada67e-a5c4-4ad8-62a4-08d8e2521a68
X-MS-TrafficTypeDiagnostic: BYAPR15MB3157:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3157D48CA16A30E7A5265189BE939@BYAPR15MB3157.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wIAwfQfVpKvWs7h3NFZorijIjq6vVPvixrvxy/sm21A3M1udzOsWWzPSC7umIuMKFDgcZ/yc9+D4sezigtmuy+PY8+FjSE3SAwgGo/P4X0pRpUrmudTZVR8tGiFAWTZIYAGCq7+lfW4zcCCHWiYGyho2rDjrQJs2MXUsvn3ZXPo0l55m5E024Y5tx7grk48DTosaF9WW/+yAdvBEH+bPevGxHWdekc67YtPVZxmoxDh9Kv4chExsIx9mMpzgq9RQPBUua5HvXU/lOSpUBvrCr7JlNMtDguCy6ezu1FU7q9zPk1hT8a5xCSFqLWMlIzLd2zEG+3NmJjg8mfhmUAygCpkL2DQL6V93aNSU67Qv4UnrpVUuFI6ITx8oDc4FlXCJqPQF1hUXKI41z/Z53rRlzTGN6iFzHDLX0R7Ok2gUXP4wWt8xmYncZ3G9QizH05QJW3gQCDGPpuSpwLY17mZCL/pGhsCsJ38L64Chn+A0WrRHsPBNVmnWNGby9LB7cji5ECGP82h/BjHx2uBAdXFzQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(39860400002)(136003)(366004)(54906003)(6666004)(316002)(55016002)(6916009)(83380400001)(86362001)(52116002)(66946007)(2906002)(7416002)(16526019)(7696005)(478600001)(66476007)(66556008)(8936002)(8676002)(186003)(4326008)(5660300002)(9686003)(6506007)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Jqti4Me8vZ47jewsrYALTjLABy8s7RsAgkR5VTI1T1fJw2aXm2S6+daJQIV0?=
 =?us-ascii?Q?ABpqZxK4/MRSlKQmXaHT2iqXLdYlOzReWKolz+3RwOrhHtCO3Tj8VVQBPdtC?=
 =?us-ascii?Q?BMrUqLDjWc/hqRHIfMsjUxEM7aqOsP+XRRPqYW1/zSs9ErF5PAA71e62HbN9?=
 =?us-ascii?Q?z4LfweD/RE71HGY6uIqIqHgUcXZT7b/adgvNO8JNSOOSigXrCtOXcx3I7bjF?=
 =?us-ascii?Q?SmJkJ8nCklPnU4jBPlwwA4DXF5OhpoaMMkvVZp14fYYicRjiLcTihZvtdc8E?=
 =?us-ascii?Q?Bu8ZJbtgjHHAuLhmCFzpBJA9iC5lgaOVMtmsZfLKtvtpGXT6L+Vxw/n7PV1x?=
 =?us-ascii?Q?53J1qec9Oy2z1avF6OFCPr2mZ/Bs9QieZF5mTeliTaJgW9TA9shBp+Ajhucd?=
 =?us-ascii?Q?WD4DlyexEsfW2rkvpUi1dGGko0RKV7MnO+JBO05/ThlvXadA72uXRFlr9N55?=
 =?us-ascii?Q?3k+W3QvqcBpnRRRbydn3NOqHbAIjIHxpi/7MoY965+IA2DzZUXmtWbV/np+0?=
 =?us-ascii?Q?D0sjhaeo58jZt5CoDPWa0YZhZU73azgD9mXodDUqS3GZhNp2i6J92w1hQsDl?=
 =?us-ascii?Q?ItQQyzGmbPV9sjcn8cnP4hq3seSXduCqMC3bPW/f+uCswdmcu/LAoXijoHCg?=
 =?us-ascii?Q?N5Oz7QoZCnu9BSXpVctn0E/dut1Y/ie+qxfPeh1q4tIA03u9i0BJ4A9mcsXQ?=
 =?us-ascii?Q?aGgHmORJWuk1C++50ZPWXYoxsNqlfnPrQAQRARiXSElGlzFnxwv/jB/JK2fd?=
 =?us-ascii?Q?eKB2V9BtLHlkbvN565H/xE624dddWO29H1YRLFhnlcFxaNi+sbHz+YmjRGPY?=
 =?us-ascii?Q?wVV0AdtdB8+jor6I3fVarIa/vAkDxJNJWhXQMf9CAfKmJRGBkdP2M38e3FAo?=
 =?us-ascii?Q?guqzPVA9aM6ZRTmP0fN+XqnFwR7C+T0585JUd2t+6yDNkseeZ8ruXf8eQyk7?=
 =?us-ascii?Q?iymht8jeNO7g/U45hNernHTM23GftdkFkhkMYzf52dr3v/B5fB9nSruWsjjP?=
 =?us-ascii?Q?xFTAhkduS1/bJbdUibB+nl9bGQ54wlt1GrNmJDDPlId4v5M6suuuCo6BVVoj?=
 =?us-ascii?Q?1CgYUJWgI6PDiGYNj1nbWaaWgfq/Y8iyV8cB/dLkN4RsJb2YC45d60bhh/mp?=
 =?us-ascii?Q?VG4p4/g2EoqeE1Y9gU+IeY1e77jVHW1qOiICYnyoyYRsQvEuItOhvQp9pxF1?=
 =?us-ascii?Q?xh3iUjn36KPE/BeaE96OOSIkavltsmmU+vxlfViLzf7whwktkz0YbIQV7Fed?=
 =?us-ascii?Q?4D9+cfuFRE76Zld+uKBATcKny3hKoDVnxMhnAPVFRT/1h7i6e//6yBDvjDap?=
 =?us-ascii?Q?Wy7aY5rZNmK2DMCn9ValIRSPO05cclLpDEo0vQuZnRMNRQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fbada67e-a5c4-4ad8-62a4-08d8e2521a68
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 16:49:13.3228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTmiSwmiQImxYbeETUkK+tE2zcGc5vUZXxMl+SRQGLxdZuIoMbCN4Na56D3GjSVG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3157
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-08_11:2021-03-08,2021-03-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103080090
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 07, 2021 at 10:13:04PM -0800, Shakeel Butt wrote:
> On Tue, Feb 16, 2021 at 4:13 PM Yang Shi <shy828301@gmail.com> wrote:
> >
> > Using kvfree_rcu() to free the old shrinker_maps instead of call_rcu().
> > We don't have to define a dedicated callback for call_rcu() anymore.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/vmscan.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 2e753c2516fa..c2a309acd86b 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -192,11 +192,6 @@ static inline int shrinker_map_size(int nr_items)
> >         return (DIV_ROUND_UP(nr_items, BITS_PER_LONG) * sizeof(unsigned long));
> >  }
> >
> > -static void free_shrinker_map_rcu(struct rcu_head *head)
> > -{
> > -       kvfree(container_of(head, struct memcg_shrinker_map, rcu));
> > -}
> > -
> >  static int expand_one_shrinker_map(struct mem_cgroup *memcg,
> >                                    int size, int old_size)
> >  {
> > @@ -219,7 +214,7 @@ static int expand_one_shrinker_map(struct mem_cgroup *memcg,
> >                 memset((void *)new->map + old_size, 0, size - old_size);
> >
> >                 rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
> > -               call_rcu(&old->rcu, free_shrinker_map_rcu);
> > +               kvfree_rcu(old);
> 
> Please use kvfree_rcu(old, rcu) instead of kvfree_rcu(old). The single
> param can call synchronize_rcu().

Oh, I didn't know about this difference. Thank you for noticing!
