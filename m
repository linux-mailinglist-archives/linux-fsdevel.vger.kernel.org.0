Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC33D2D1A0A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 20:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgLGTxH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 14:53:07 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54006 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725774AbgLGTxG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 14:53:06 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B7JiVEj022227;
        Mon, 7 Dec 2020 11:51:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=ApH9spN0E9R4hdJB2VpBfFP9PfbnPsafyCHQUiddqR0=;
 b=FkJlnRn13qM2/kEazcX7qrWzMV5MN0aTky0zy8EqasQNqWmP3SgTwa8a3VpcyjdmLmtH
 qX6usjb75l+aUi0R5ROwHPqJKtIfqZdDv4OJ/4SLdlN0mO91UJReLJBB/5Bwl19KMs/D
 lzI3KOV51xkiNmnhejlHPwgYIj0tkF2H/GY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3588ktud15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 07 Dec 2020 11:51:47 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 7 Dec 2020 11:51:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ypcq/GLNdT7s7qYXohcjIKQnM9irxnlY8/xCg3UgCvLIRZT6FmwA64xuj2Ma/mf9mriwr0e65z/YV8+94Xy9ZiFex5wAzP8YdKURx+PY0QnsI6i8z8FGVtmdgcYwv2BGwVucJJlYlMFNbSe3BrphPQoP28GifHFNe4JFE9oBKR0mnxmh5PcVsBl7BmtAUXyag/AfSxxx7gChxD1rCHze6gn6RytEmSceAS2TcJol3ObHQkB7F92m9XSXfQqvCH9d7Q9M4TF5tGFYaxnvmkRMf79htNeMjijSEDbOoChvxjukPEDF57cuBqnJ9TMu51d2B6S6quFJlu31rlSWuNxeLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApH9spN0E9R4hdJB2VpBfFP9PfbnPsafyCHQUiddqR0=;
 b=jsqlEoPymO1PhZEG86Oe4aHd5pluc/OAjwUlZ/nXnSdu8qLx1KzZ4J6tPUcmN7g46ehMmKwEcdi3YJuwb4SmUIV7p4YR6fShslo3x0gfVR+FkOKz9DcsMlyaWbXnnIKSLfhE5VixOxCqoASm+hURczBPR/Jr6xqFYjjSAk5KeJGwR3ZHgZNescZDlcskFmUn5tPOY7zRJJL9sLPwTYBuANv4HBB8MsmFc2nvf1h3BWRK7PTjbyuTBChYd6wgaiLeLBCUMSrtYdCV3/4jqrA47cESWXaMLM3SiB+qE08HS9y2X47hpKPO1t7scWpesJVCdoFhgnp0/WFVkIJFwkZFiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApH9spN0E9R4hdJB2VpBfFP9PfbnPsafyCHQUiddqR0=;
 b=JHcY7Zo5fH17knmY5ekt7Ua+hSWWgabripmN9XUsnuc77auYnR316pOXrtYRA5xySYg2fv6/CpguaJE9RNenQ5tI8A6Ug4LvI7T2vjybWF362wzi4s2AY4wEAs5LbTahGQtkxJA0gt6T2LtYKAdm+StcDPLj/wY4zG6dDNG79QY=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2437.namprd15.prod.outlook.com (2603:10b6:a02:8d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Mon, 7 Dec
 2020 19:51:45 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 19:51:45 +0000
Date:   Mon, 7 Dec 2020 11:51:41 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     Muchun Song <songmuchun@bytedance.com>,
        Greg KH <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, <esyr@redhat.com>,
        <peterx@redhat.com>, <krisman@collabora.com>,
        Suren Baghdasaryan <surenb@google.com>, <avagin@openvz.org>,
        Marco Elver <elver@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [External] Re: [RESEND PATCH v2 00/12] Convert all vmstat
 counters to pages or bytes
Message-ID: <20201207195141.GB2238414@carbon.dhcp.thefacebook.com>
References: <20201206101451.14706-1-songmuchun@bytedance.com>
 <20201207130018.GJ25569@dhcp22.suse.cz>
 <CAMZfGtWSEKWqR4f+23xt+jVF-NLSTVQ0L0V3xfZsQzV7aeebhw@mail.gmail.com>
 <20201207150254.GL25569@dhcp22.suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207150254.GL25569@dhcp22.suse.cz>
X-Originating-IP: [2620:10d:c090:400::5:ef79]
X-ClientProxiedBy: BY3PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:a03:255::35) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:ef79) by BY3PR10CA0030.namprd10.prod.outlook.com (2603:10b6:a03:255::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Mon, 7 Dec 2020 19:51:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8de8cf2-4f4e-47b4-4fe9-08d89ae986d2
X-MS-TrafficTypeDiagnostic: BYAPR15MB2437:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2437EBC6B257876CCA8EC797BECE0@BYAPR15MB2437.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ht5psdtYzMZf8WzEPwzkiR0ZDgjDzRurmUif7yw2aHOl7PHFDh/A/NYxNL+KRsa6kVrRmM/BudEI7iLY++Y5IBX8ooIF4WETL7PnROwfDbJDnBR1b8r3+PLBgk7UnSfmP6Gveq7jmqMFoZ5RTTFPjDRyHiutvqfO7VbVEw/XG6ksMsIfddU4ZouWu9PL3qVtVI1315BsqaxcuOUS08u7NBqjf0YUE/6bcRLTpIzLObl1xDNjAYtom4HPlQfMb5X4IPgRM2QUqjFG0he+B/4UJfIwJ192m5xkaSwOZbPUiBMy36tXSKN+HBZSKtSppc4LYXC/l9BNc3ms/dvzakb2CQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(376002)(39860400002)(136003)(66946007)(2906002)(4326008)(6916009)(9686003)(66556008)(5660300002)(478600001)(8676002)(54906003)(52116002)(8936002)(7416002)(186003)(66476007)(6506007)(83380400001)(55016002)(7696005)(33656002)(53546011)(86362001)(1076003)(16526019)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4dNylUm+r6ZOoMbStv8Qg0BjIvMYgDcmP6t6j4xnPEo8RQkcKkdFjZBoBX9y?=
 =?us-ascii?Q?H5lTTDqdgM6pK0c/WLAqnq1fNLQ6U/6F+5Odt35wH6VLl0mUUubXfgbZ81Yw?=
 =?us-ascii?Q?db5zMlkTtyFE/d/qgD4g5toz9gTyz5lAbkMoSTDETkSWvpC+H6RvWDQDAkIY?=
 =?us-ascii?Q?Zbgh1CDBfUig5qbjfGCeoUKIlDmHbJAcje5WeiKU3nqPY4l5d5Pg5smU1C/7?=
 =?us-ascii?Q?QKp2cI1SmDMx/j/jVzpIGhcAYyI0M8bCWAPUlefFIK8bt1WwtH7h12FN2zCK?=
 =?us-ascii?Q?gowJfBfoc4f6k+m7FfX1cVn60JJ/eAivKAuv5o8/J8kQVAL5puG85nSo52kW?=
 =?us-ascii?Q?buQ91yVz3bfMJBKt6bzjA0Y55Yt65Wv1bo32rtXws9tL9oXVHGQeNJE5GCEq?=
 =?us-ascii?Q?82JdbTC4fP53HMp0PQiwDHbjbNgoL6n0MAMVi0nn57s1N9ot2Qaf2DH0C76N?=
 =?us-ascii?Q?31rpR90ihAgxxDlyggSxXib3sVvxUytLL+m37Iwq64+kzi2VI95b3iGXlTy3?=
 =?us-ascii?Q?nTjOqCo7eAo4qs/D4SaPduraUO/hGOoHUOsBWOinsbkGGW/+c2OuKfIWITGr?=
 =?us-ascii?Q?imdDGg66H/2QfFAOcbQXptCQ/BXGkCHWN0nV1BpTU5BGvo/ErmJn9X+IQwas?=
 =?us-ascii?Q?uwuju5Gdo3ItE1XEaluKYAjcscWfXAznlIzLmBtvdEXQZRG79W3pdXzhn8sR?=
 =?us-ascii?Q?d7xZtZCV0YAQN9yX1lo4Sp5C/oEp9KFokjrEtDoLq0gpwp1XqaYQYsOtCrtw?=
 =?us-ascii?Q?yxKkHdxKEm0qMLZrb4Wq1L7Kj4LA8MnvCM7aOVvYjDmFPJw6E96vJWt5ottd?=
 =?us-ascii?Q?bP6ssllnX1yt0Oai2rQ4WGVZV7iKrrrCeZOtp1G0C44DomgCtpfMUKKt4Are?=
 =?us-ascii?Q?Dj0EpUcHyGLaUdUaZN9r3a/WRMkZ9qyTQNe5c/NXQe5HNakZc/t4P2cEv3yf?=
 =?us-ascii?Q?j7ubnUe372iwP3lUnKyuEQ6IKsLCwNqqzJqB1k0Hn9rRweBsEQZtg5332cnQ?=
 =?us-ascii?Q?uROPqP+361DRuWddhUf7prsaOg=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 19:51:45.2213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: f8de8cf2-4f4e-47b4-4fe9-08d89ae986d2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SG1T7aV9O/vLndw1RZLVOfPIm43qEK8vMJ1vOYvXvc7k0IMTX8Iv+34xet66A8k0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2437
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-07_16:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=1 clxscore=1015
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012070127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 07, 2020 at 04:02:54PM +0100, Michal Hocko wrote:
> On Mon 07-12-20 22:52:30, Muchun Song wrote:
> > On Mon, Dec 7, 2020 at 9:00 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Sun 06-12-20 18:14:39, Muchun Song wrote:
> > > > Hi,
> > > >
> > > > This patch series is aimed to convert all THP vmstat counters to pages
> > > > and some KiB vmstat counters to bytes.
> > > >
> > > > The unit of some vmstat counters are pages, some are bytes, some are
> > > > HPAGE_PMD_NR, and some are KiB. When we want to expose these vmstat
> > > > counters to the userspace, we have to know the unit of the vmstat counters
> > > > is which one. It makes the code complex. Because there are too many choices,
> > > > the probability of making a mistake will be greater.
> > > >
> > > > For example, the below is some bug fix:
> > > >   - 7de2e9f195b9 ("mm: memcontrol: correct the NR_ANON_THPS counter of hierarchical memcg")
> > > >   - not committed(it is the first commit in this series) ("mm: memcontrol: fix NR_ANON_THPS account")
> > > >
> > > > This patch series can make the code simple (161 insertions(+), 187 deletions(-)).
> > > > And make the unit of the vmstat counters are either pages or bytes. Fewer choices
> > > > means lower probability of making mistakes :).
> > > >
> > > > This was inspired by Johannes and Roman. Thanks to them.
> > >
> > > It would be really great if you could summarize the current and after
> > > the patch state so that exceptions are clear and easier to review. The
> > 
> > Agree. Will do in the next version. Thanks.
> > 
> > 
> > > existing situation is rather convoluted but we have at least units part
> > > of the name so it is not too hard to notice that. Reducing exeptions
> > > sounds nice but I am not really sure it is such an improvement it is
> > > worth a lot of code churn. Especially when it comes to KB vs B. Counting
> > 
> > There are two vmstat counters (NR_KERNEL_STACK_KB and
> > NR_KERNEL_SCS_KB) whose units are KB. If we do this, all
> > vmstat counter units are either pages or bytes in the end. When
> > we expose those counters to userspace, it can be easy. You can
> > reference to:
> > 
> >     [RESEND PATCH v2 11/12] mm: memcontrol: make the slab calculation consistent
> > 
> > From this point of view, I think that it is worth doing this. Right?
> 
> Well, unless I am missing something, we have two counters in bytes, two
> in kB, both clearly distinguishable by the B/KB suffix. Changing KB to B
> will certainly reduce the different classes of units, no question about
> that, but I am not really sure this is worth all the code churn. Maybe
> others will think otherwise.

Even if it was me who suggested it, I do agree. It's nice to have a smaller number
of units, but if it creates a lot of hassle, then it makes not much sense.
I think we need to look at the final version of patches and decide if it
worth it or not.

> 
> As I've said the THP accounting change makes more sense to me because it
> allows future changes which are already undergoing so there is more
> merit in those.

+1
And this part is absolutely trivial.
