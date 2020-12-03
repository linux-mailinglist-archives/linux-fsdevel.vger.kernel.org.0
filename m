Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5112CDF64
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 21:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbgLCUJs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 15:09:48 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23520 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbgLCUJs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 15:09:48 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B3K06qs012089;
        Thu, 3 Dec 2020 12:08:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Is2+NdJa0eWS61RYEeqewGSQDeD1ig8nvfe+k/dbVQ4=;
 b=IOCSKxTUvL85RAY4Fvsh3Gdi0KAPYG2VkQFHCVjhh90VBFoQ9f27lts8M4HIZddrVjDa
 GFSt4Z4PXBOJVhnW8adDYyrCaS1+LuL5Ghk7rbQnQ9/JWSdZVYdLLUaO7ZosJoZtqF6r
 0gQ7yWncnN2fJJqtlDli9edwB+681hCvapM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 355vfkgavj-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Dec 2020 12:08:56 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Dec 2020 12:08:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzZR5wwEZC/nhsNVR/0W/LNArfYQa5KFJZwMJ3+QY8nJARbMRP/iWt8kuvdI1mO3QdIukv+qUL10XxLM9jAcgffTGBGra3Gv2edrpYGjg8D+ljahxt/GHaNS4Qrl7L7vzFqDGcpDVVyZ0hXP1noSKa6Ro34cTFPfmtkunVGkTy9aj0XDxiH95bTqskiD5NCW9nDwuQIJfRBRCmeTBqtnMRXIkClDt/cdrK0/WZ4yy+FA+ToRm9pbS90DZdE/DPexIa/v1TdwT2Rk/M2twnPEhG5X95zKt2RkJ4RQkkhs8YjmmXRi5M/Vu1cdP4JSh0lBJTRSzNCIRSfOvWxp51xSMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Is2+NdJa0eWS61RYEeqewGSQDeD1ig8nvfe+k/dbVQ4=;
 b=is2qELXsnt5xAX9j0apjU1JXGdfoPj8T6RXJQaqBTa7a5IDj9WUjFxuG3UDLXI/gNny1amFdGfnaBBjs2unNSUH5YpcoEmQcwmhCvl1hKYfa/Fe7GM6N2ygHbo4+fqRLQb735qQthJ8ZoLQSG66bGj/MyHAW4XJ7sh0F4/6jZJoeuS9uEyGEl9eQvq0wMjiulMFE65ZVmrLJaQnp56MUmvKbQg4VE/zitGK+NdU2IDo40l4bGYUDUSd9vWWG7CxNBW42URvhO29lKZlU2d/MDWPfoLPTT8uEJQktdLaJ0Cu5L76i5qX1AvV0PgiajeevOBqwK7Ku6iKa1me1bJHcvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Is2+NdJa0eWS61RYEeqewGSQDeD1ig8nvfe+k/dbVQ4=;
 b=Bun5BsztXYUrVG/kfkEt37lbY64YaSzjdlp/i+bMZEJcJGEiWtFrYI/QCBwOaNbN/xLiwoTV1jD1zviv71oO1YlvKzPRD16m4PkDENPWIKdKra7fbJDdwifzEQ5HnsHMhLLZ0iN5kK4bvGRgAj0tqq9FGvPFGJTaN3TsBvpbdEU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2630.namprd15.prod.outlook.com (2603:10b6:a03:14c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Thu, 3 Dec
 2020 20:08:30 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3632.019; Thu, 3 Dec 2020
 20:08:30 +0000
Date:   Thu, 3 Dec 2020 12:08:20 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/9] mm: vmscan: use a new flag to indicate shrinker is
 registered
Message-ID: <20201203200820.GC1571588@carbon.DHCP.thefacebook.com>
References: <20201202182725.265020-1-shy828301@gmail.com>
 <20201202182725.265020-5-shy828301@gmail.com>
 <20201203030104.GF1375014@carbon.DHCP.thefacebook.com>
 <CAHbLzkoUNuKHT_4w8QaWCQA3xs2vTW4Xii26a5vpVqxrDVSX_Q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkoUNuKHT_4w8QaWCQA3xs2vTW4Xii26a5vpVqxrDVSX_Q@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:506c]
X-ClientProxiedBy: MWHPR22CA0072.namprd22.prod.outlook.com
 (2603:10b6:300:12a::34) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:506c) by MWHPR22CA0072.namprd22.prod.outlook.com (2603:10b6:300:12a::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Thu, 3 Dec 2020 20:08:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87d903b2-603e-4bf2-a491-08d897c73456
X-MS-TrafficTypeDiagnostic: BYAPR15MB2630:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2630A72EA3AE28F932E42E56BEF20@BYAPR15MB2630.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XI5gbKOCrXhpVHUzlW4X2/+U0AwPER3TUsMGbuBc6I/Jm8e3X12KgDrftsLX7heyGN+ArDAwdp89aGBnTz+JQ0ZdYgZ9cXP6gw5jhi6hU6ekLA2NI24Y13oYzURliSQn8MnD7nh4Xk523/dr55WGmRzitbLAFSUiaScmcrOHDaeMgyEDeHcahgerzinAwnPW25cWKXr28VI3kF7DJ4Fgd5qAyArAD5TnJVSVryWK7Z7XtG103BZJtntFrON95rmIWxt8UimCiS+SB5kWFDJ1g3Y58OLe0b5qqI2CgPhguBkL2fJ63vQLp9ty+Lm+IWWrDo8xgoySouZgZp/Pnk1jlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(39860400002)(346002)(366004)(6506007)(53546011)(7696005)(52116002)(54906003)(16526019)(6916009)(1076003)(2906002)(4326008)(478600001)(5660300002)(6666004)(9686003)(55016002)(316002)(86362001)(66556008)(66476007)(66946007)(7416002)(83380400001)(186003)(8936002)(33656002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?JVNcVVVJKIkVlVS2OfxMj2y9kBhazmvYlwCUG5C6ghEBg7gNzMocmlV9nU7A?=
 =?us-ascii?Q?S8nFNAnXIvf4b7jkK1Of3O12gHQ1HRZuKfAiIR0pHenuV3iKn4TzXpn/fjCK?=
 =?us-ascii?Q?miXP9lXci7+qUrTYEEe8luAsZlYdyXMjTvHv5cTPnpXyUcHgrJcgGfdrXlqk?=
 =?us-ascii?Q?pwCwdbPQdXO8W74LzkFmBsVaBzCde5E0x870WMyd+GiojFJhSBPUeUNmeV9k?=
 =?us-ascii?Q?Chlj8Un8OuT1wvWmNqE8I7hf+EBJBxO2LKPkDupDcxr95FnsLY9nDHjLm0ny?=
 =?us-ascii?Q?uQNOHUh5BH0jPptC5cm1Vj47jUQN3G50NVDJjutdXLO2juzRHmAOaUDZilV2?=
 =?us-ascii?Q?RFcsXGPQONXLotJYP/upUM5rLYRlGbmV0ct+lDYvKetNZO5qa+TRO6ZlZH/x?=
 =?us-ascii?Q?B5VLQplN+KIfs5LOGQOiZgLSOzj1MbpYEEUn+oqwDIp2ITJXFOvrFCKjl2dO?=
 =?us-ascii?Q?Tf6OZIQOYmbLzyx8QZq3oLz9ZhvbO1zNH3MlKWz0tx5Y4RFteojA+lI7FtRP?=
 =?us-ascii?Q?qhUU2GvFAHtcC5vI47yuQmsClcW09PG2oBKq85L4JtbydMXoty9SHtdlRcJ4?=
 =?us-ascii?Q?Eknh98OedrJRmoyPmbHrQBLuls85H+0tZSch4w02aTn1Hs4dc2Q7g2ZmVHmM?=
 =?us-ascii?Q?8c9khG7fg6ETaY9Rd87+FzKwXZf0MJIcDDf4+aHD/2S84V5taJqYOt+qp/zS?=
 =?us-ascii?Q?Lzcfj78ENmtL/8e6mQYiQJX4YPGBacjIzdR1TBGQ62MaNHNtt3P/GASLuivy?=
 =?us-ascii?Q?SVNPtAT1ag438Rqfh7Of3WobMYpq+Fa+bIBHxFUGBzZZ5R2p4DRmEj17DiI8?=
 =?us-ascii?Q?/UigE598iecLTBwdjpEHZZ2FcbLlwRT4paybEBLPxltuHvoxjnDzrtnj1lh/?=
 =?us-ascii?Q?N68sZElwbtn9YL6Unt7AN0h7dIH1WFewTepVyB49u34OtmkO/w2MFypYH+fY?=
 =?us-ascii?Q?TsZJxiiX75z7Hft0pfQER/3M93lT4cfY0gGodq1y5I2sJgyv6bDYoBZvgMpd?=
 =?us-ascii?Q?2khWNqQcN13n30zlQs5G904aGw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d903b2-603e-4bf2-a491-08d897c73456
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2020 20:08:30.7613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /gslv5eZkY/0ZFLzQbjGrBtLRXOY97IUecs/ZE7YVlLb228IbSrWSIc/S2TcSuRP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2630
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_11:2020-12-03,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=5 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012030116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 02, 2020 at 08:59:40PM -0800, Yang Shi wrote:
> On Wed, Dec 2, 2020 at 7:01 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Wed, Dec 02, 2020 at 10:27:20AM -0800, Yang Shi wrote:
> > > Currently registered shrinker is indicated by non-NULL shrinker->nr_deferred.
> > > This approach is fine with nr_deferred atthe shrinker level, but the following
> > > patches will move MEMCG_AWARE shrinkers' nr_deferred to memcg level, so their
> > > shrinker->nr_deferred would always be NULL.  This would prevent the shrinkers
> > > from unregistering correctly.
> > >
> > > Introduce a new "state" field to indicate if shrinker is registered or not.
> > > We could use the highest bit of flags, but it may be a little bit complicated to
> > > extract that bit and the flags is accessed frequently by vmscan (every time shrinker
> > > is called).  So add a new field in "struct shrinker", we may waster a little bit
> > > memory, but it should be very few since there should be not too many registered
> > > shrinkers on a normal system.
> > >
> > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > ---
> > >  include/linux/shrinker.h |  4 ++++
> > >  mm/vmscan.c              | 13 +++++++++----
> > >  2 files changed, 13 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> > > index 0f80123650e2..0bb5be88e41d 100644
> > > --- a/include/linux/shrinker.h
> > > +++ b/include/linux/shrinker.h
> > > @@ -35,6 +35,9 @@ struct shrink_control {
> > >
> > >  #define SHRINK_STOP (~0UL)
> > >  #define SHRINK_EMPTY (~0UL - 1)
> > > +
> > > +#define SHRINKER_REGISTERED  0x1
> > > +
> > >  /*
> > >   * A callback you can register to apply pressure to ageable caches.
> > >   *
> > > @@ -66,6 +69,7 @@ struct shrinker {
> > >       long batch;     /* reclaim batch size, 0 = default */
> > >       int seeks;      /* seeks to recreate an obj */
> > >       unsigned flags;
> > > +     unsigned state;
> >
> > Hm, can't it be another flag? It seems like we have a plenty of free bits.
> 
> I thought about this too. But I was not convinced by myself that
> messing flags with state is a good practice. We may add more flags in
> the future, so we may end up having something like:
> 
> flag
> flag
> flag
> state
> flag
> flag
> ...
> 
> Maybe we could use the highest bit for state?

Or just
state
flag
flag
flag
flag
flag
...

?
