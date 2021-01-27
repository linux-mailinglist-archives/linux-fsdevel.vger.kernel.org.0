Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A168D306377
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 19:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhA0SoH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 13:44:07 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60660 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229950AbhA0SoD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 13:44:03 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 10RIWBHc028368;
        Wed, 27 Jan 2021 10:42:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=TjQ++rUxdLeyDl4rEaotnq3GKb60Ln8eHrnzPg+IH4A=;
 b=kMBSDNtXc3wiSTtxKpjCyHT9XXBWokKlgMgatgtTC3Uh7Isu7I253+2H/WyLLGWf7ODb
 QIAYv4Mt2qCNkpKy7an5H81EQXWBE8lR56s45k3uyt31UEhm52vjh7GHQm2FDxezr0ev
 Ww5az7yUNcYEge7C6dh3jKIanCiPFZ3cRQc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 36b4ws2v3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Jan 2021 10:42:23 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 27 Jan 2021 10:42:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0tuJfoXnDJuoTiomplzOB+Dkropf6WRrUlHDtjprikrSF9q9h8Bz/+qJSt48mH8irMEIC+FMvePdO85khrikioZir2qipdU6gFjk0luOFzaFhuDxe/zcMcr8wegfUrYpVBQ/iCAx96nRZs3gcwT1iyGGvAsXJuHdcySa24tH2NAm/V0DCpcrd7T2q6FsUIs8Uv/gIH+YW9TOc9bdIb1/d+goV1/T0WaiCIvLztcOtl9Jpp7ribimIFxl1jC7XbOErcYwE2/Z/CPAMx8YS4xCiVFd6QvdEg3X+0XSXqKcKUzb03tNhIBY+vi+ed8miblxTwCO98/0azuqnPclG6Olg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjQ++rUxdLeyDl4rEaotnq3GKb60Ln8eHrnzPg+IH4A=;
 b=USPUluPvybRnM72MvToiCDFE5K7yGrotMXf2HtgUSb0eaC6WQRTuIKNnxqlLIhF0yOckpgKgCRW/SKefQA68L/I+QnpDEOPHSEeD4CEB9wzmQUKluD4bNw+o6cab5W98FOlusa1P7bNZHGbB+I3ElSXir7FtyQyWA+vYncJ6Ul0HPjBDNcR34jJI9JsTnP43jfz//tFH9WuOcCaEB0tb8T1KPZS78qimTIPeMhSDzVMtqq1nEBhRPuwKyvivlMbq8SST0HxnZ6SRZNfOiIZDth+rHP2eI8b6alej6WvGsktFqzanv604mc8D4affHtWsr/3NcVQoYqyVrqPIL+Oveg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjQ++rUxdLeyDl4rEaotnq3GKb60Ln8eHrnzPg+IH4A=;
 b=PauCxEW9riHHAIlvnPRyhjJtGUEQyEnYMWb7q1PDQyU0sr4NN6OmQMBN54mO6LDGKo1R7NmkOSvG6UlmEfQ8ARu2Js+aoWqJ3aDuTUNGvAq5gxWX7s/cc+zIgYxh8UKze/r/76nnSBeiLxnbJM72pE0T5V46zEJs3npwrWMr4Q8=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2982.namprd15.prod.outlook.com (2603:10b6:a03:f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Wed, 27 Jan
 2021 18:42:20 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%6]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 18:42:20 +0000
Date:   Wed, 27 Jan 2021 10:42:13 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        <linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-riscv@lists.infradead.org>,
        <x86@kernel.org>, Hagen Paul Pfeifer <hagen@jauu.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH v16 08/11] secretmem: add memcg accounting
Message-ID: <20210127184213.GA919963@carbon.dhcp.thefacebook.com>
References: <20210121122723.3446-1-rppt@kernel.org>
 <20210121122723.3446-9-rppt@kernel.org>
 <20210125165451.GT827@dhcp22.suse.cz>
 <20210125213817.GM6332@kernel.org>
 <20210126144838.GL308988@casper.infradead.org>
 <20210126150555.GU827@dhcp22.suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126150555.GU827@dhcp22.suse.cz>
X-Originating-IP: [2620:10d:c090:400::5:f9eb]
X-ClientProxiedBy: CO2PR04CA0056.namprd04.prod.outlook.com
 (2603:10b6:102:1::24) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:f9eb) by CO2PR04CA0056.namprd04.prod.outlook.com (2603:10b6:102:1::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 18:42:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b9e29d8-618e-46ba-7a56-08d8c2f3472a
X-MS-TrafficTypeDiagnostic: BYAPR15MB2982:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2982726890473C2565332491BEBB9@BYAPR15MB2982.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hnNnD/yrkdgN2OEnGn/QCygDGF4pOKcNT1UoqyrNZBGPPSjupNwx5uP3Br1GThmIBvkuoTdmhtFM0tIoOrajg2U6PUdjq4/pDojFYgteWurzXdNHkajO/uL92KLW5EIPM/Uv9Hj6rJKqjRodVJHQs2+ev+S+AgyAvhfx6pcOIzTrqoxgMd+qyjCaH1IscwDVDz9XHQoPajZQtZXdrJF4INlJA7sfC8KfxjETVebuiKBIsJBak9LYd9qd2PViAHvIIm8W2U/jJBpk9UgQh8GAWgUnrTQbnMRQidbAGaVEj88u47HbrxzM5iTXxCc2gu4Q5U++xTlgYyp7HNSpkoxare6iF0WLQlYQpP0Po7vUmg1OMwXa+lv1Tt/iXrufroj2PEt/AmdYJTNY0i8xLIJX4QM5FT6xIofSAmQOZCxLmDKQQRl3rtF8lylmZXCA7CYRI5g6EMCIEEldjKXYvkLJ+yWstLUGTrFF2RWM+QxOK/k+Im1wzqUokjp43aOIDr0XBfxlW7B0fAcqymFr3aUjpRiu5d9lw3Bu6iNM/VGltiEBvj/nvjZ58iKyvLtdJE+RsqbLY1mgss01fn6qYW9zrPBy8h67dEMH6Wj9Jr0Avz0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(366004)(39860400002)(376002)(83380400001)(7696005)(86362001)(54906003)(55016002)(186003)(316002)(8676002)(7416002)(8936002)(15650500001)(66476007)(6506007)(5660300002)(66946007)(52116002)(4326008)(9686003)(66556008)(1076003)(7406005)(6916009)(478600001)(966005)(2906002)(16526019)(6666004)(33656002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gfBSiGG+O56oJz8wXUfz9mkRnm8/2FJ/t1jXq+ByUmdwbWt7HleNsg3+xLFt?=
 =?us-ascii?Q?Hg0hN5Vs9ttA8o3jTBC6Bqn+AKAormqZF6CYE1OqPuMEawQrNaXednwz3mcA?=
 =?us-ascii?Q?N/86RbffTqOourzOwW6LfEKdzEvugEvHuLqHMYENysdc0We8nZ2Rp3X4WiTL?=
 =?us-ascii?Q?qZLkuBi2ZMklFBzaNAsch+xZjQY8OKVYqTidhzYnKJq4Elo7x16qnbUMdMZU?=
 =?us-ascii?Q?Y/0q9kHIBC0yWT+SMz/B4miZF48MvDqGQzbSCUer9UibLUPbkPnDFArSAKHE?=
 =?us-ascii?Q?bNsC1zjwdQqgOjGwWG1PVBokcQKLRawlBi7lDKOX1igDGxO+iP1tpM5QY2cT?=
 =?us-ascii?Q?JCe/GsVf84FVqCc/GWOsJdGqHwnWz8ftVLm2yuKZja8RNhHZ+OgS/D/Mzr9j?=
 =?us-ascii?Q?XIGe3+l1PUSP3PEKJbmS29F4Pdc7PwcFxcGsPNwRkupwpdZBQ7E8TinXjW8M?=
 =?us-ascii?Q?EXs2U6ZWSkFi2CQ9PzCgE+RTqGnvQj8p96JUN1C1TiyOg8siIwlvTTo2Decg?=
 =?us-ascii?Q?zSlkr8UyMu7roJfRDzKh7nP5nhhj1zLtykHpO1/KIKt/eI8KRgW/bVf+M9kq?=
 =?us-ascii?Q?CLH8aJW2xJwbykcBAiyo7NLp+nCpaWwAhdY50dYHwsC2CVtJwBXQNjknRlWI?=
 =?us-ascii?Q?jOV0QZ0jvnLwpvdQ/wlcXJnotPDBQ60RLDgGS5dMLY6pelHkfrAaJBc21KJ4?=
 =?us-ascii?Q?/MTzeaPN5u5UC45P8f7pjwHTvDxMGxxQT+y9WsTZ8dVShJSfEVO12pPW6TzA?=
 =?us-ascii?Q?/Hqc65pbmS0tzzgO+4ZGpAVYR9gQlDV5qj0Yopwa9FnUrh30+nykprjDcAwQ?=
 =?us-ascii?Q?/XzYuvlNN/cQqDWIw2qubfwWcNFv9KeMUsZ4mXkHyz0q9jsc1MMyOvpamRRw?=
 =?us-ascii?Q?JUjKW4QdJeN6JwUIuy+COaYgqfefmY9/pUFYTnDUmBWtKw7BFQLsbgRipjB/?=
 =?us-ascii?Q?IHXtQxTBdgHrWM6ysxqeyjoPHJXT9jQPLlnBI2K7kk2htCzWmB2HxhXE783j?=
 =?us-ascii?Q?VaUDIlILvKKjS1QOnMSpzm3owJJeZ2TW9Pb4egeG2CzUHjUInbULiAK3yk4C?=
 =?us-ascii?Q?6bFJMy8bQAr8Jfvc21JoYTseGFGwk22szvJQfG3DRF356oD1LU4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9e29d8-618e-46ba-7a56-08d8c2f3472a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 18:42:20.1871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EP+7jXHooLBLtpv3a64Y0S1zsaS8d0VwwUXIWGX6fm7BldNT0Kxx+DC8Sm+952E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2982
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-27_06:2021-01-27,2021-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 clxscore=1011 phishscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101270092
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 04:05:55PM +0100, Michal Hocko wrote:
> On Tue 26-01-21 14:48:38, Matthew Wilcox wrote:
> > On Mon, Jan 25, 2021 at 11:38:17PM +0200, Mike Rapoport wrote:
> > > I cannot use __GFP_ACCOUNT because cma_alloc() does not use gfp.
> > > Besides, kmem accounting with __GFP_ACCOUNT does not seem
> > > to update stats and there was an explicit request for statistics:
> > >  
> > > https://lore.kernel.org/lkml/CALo0P13aq3GsONnZrksZNU9RtfhMsZXGWhK1n=xYJWQizCd4Zw@mail.gmail.com/
> > > 
> > > As for (ab)using NR_SLAB_UNRECLAIMABLE_B, as it was already discussed here:
> > > 
> > > https://lore.kernel.org/lkml/20201129172625.GD557259@kernel.org/
> > > 
> > > I think that a dedicated stats counter would be too much at the moment and
> > > NR_SLAB_UNRECLAIMABLE_B is the only explicit stat for unreclaimable memory.
> > 
> > That's not true -- Mlocked is also unreclaimable.  And doesn't this
> > feel more like mlocked memory than unreclaimable slab?  It's also
> > Unevictable, so could be counted there instead.
> 
> yes, that is indeed true, except the unreclaimable counter is tracking
> the unevictable LRUs. These pages are not on any LRU and that can cause
> some confusion. Maybe they shouldn't be so special and they should live
> on unevistable LRU and get their stats automagically.
> 
> I definitely do agree that this would be a better fit than NR_SLAB
> abuse. But considering that this is somehow even more special than mlock
> then a dedicated counter sounds as even better fit.

I think it depends on how large these areas will be in practice.
If they will be measured in single or double digits MBs, a separate entry
is hardly a good choice: because of the batching the displayed value
will be in the noise range, plus every new vmstat item adds to the
struct mem_cgroup size.

If it will be measured in GBs, of course, a separate counter is preferred.
So I'd suggest to go with NR_SLAB (which should have been named NR_KMEM)
as now and conditionally switch to a separate counter later.

Thanks!
