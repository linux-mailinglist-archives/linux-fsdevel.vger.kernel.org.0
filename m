Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CEB628BE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 23:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237670AbiKNWQd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 17:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbiKNWQb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 17:16:31 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7064715821;
        Mon, 14 Nov 2022 14:16:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdIQmPZ6Q9mnNyf+gLjq8zBk8X3Us+HXp1vf+why912TfrXFi9scI1ZtMhQ39LxbZTjxbSxNpTDC5o7SFaYbz17fUiZIy1Exl+qG6Leg9kzmap6ilHiSLbzlYFm7CB/2/eTYVCCas4Ke1uZBH9FMTjfzx/hIO3o0/sXqkGI+EnPmM5On5usSYlZIvk4FojV3gGLuwHKIEialIDuAIBUspgBmqZ6neDx5S5VyZoIDmcGzCvpNqZtPOLt9yqPIgPQDkYrl46VKcJrax9+z0pMjcrQv0/SRTzcavNJrC06aI4Ja9tnFMg5xiCrZf5PhQ7P1P7BmRV6KjoZImJWs4nRFlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InJek31VY/c4wtimma3MIzrEboSoaI0fs6LGKqVdT/g=;
 b=N8oNnNBdhksNlEX7EH5EZBKns8f8U3xjMq2XdwfeJ2m9zcUOJ9WbV6EN8Alb+yV+ot4+813BvHNnwluiiNKESdfirORGyL/TpWsA0dWQKkeZcI+zk+FmBVozuZTgVFNqJNWMhZOclqqRCt8rbHD1X+o1DIBEBxwNzdR7VlB/Rn6B3vwSQjRs8MusQ22MCeRyJzyo/vO+v2HT7zzEf2Pjend1+kc4T8h+Vx/Z1iL9uMBa8vX05gSs4t3ufdr2mQVcj3hSopKGW1WJ8wNBmijujBq+xB7azPA9IAzMQeejn24F1Q0KYo9GEpLxlRWZnbp/Hw1ep0i1UBVBP/Acy4F2yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.cz smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InJek31VY/c4wtimma3MIzrEboSoaI0fs6LGKqVdT/g=;
 b=s1kCqclQwhqxZh71bSxsraq/6cd91nmovJ93Rhte+yi/yGShq3RtAJ+aD217IvqAGakD7PRRAMxOykef7NKw4K66YxHBRwmU/SpRGYGvF/Zd1yRb/ilEHjeuqGgYUYkSXvb+lSQYWyNdpUgRYo2PIxJV6M3KUU5rFb2YNI7OfGc=
Received: from DM6PR05CA0047.namprd05.prod.outlook.com (2603:10b6:5:335::16)
 by MN0PR12MB5740.namprd12.prod.outlook.com (2603:10b6:208:373::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 22:16:27 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::87) by DM6PR05CA0047.outlook.office365.com
 (2603:10b6:5:335::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.9 via Frontend
 Transport; Mon, 14 Nov 2022 22:16:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Mon, 14 Nov 2022 22:16:26 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 14 Nov
 2022 16:16:25 -0600
Date:   Mon, 14 Nov 2022 16:16:05 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Chao Peng <chao.p.peng@linux.intel.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        <luto@kernel.org>, <jun.nakajima@intel.com>,
        <dave.hansen@intel.com>, <ak@linux.intel.com>, <david@redhat.com>,
        <aarcange@redhat.com>, <ddutile@redhat.com>, <dhildenb@redhat.com>,
        Quentin Perret <qperret@google.com>, <tabba@google.com>,
        <mhocko@suse.com>, Muchun Song <songmuchun@bytedance.com>,
        <wei.w.wang@intel.com>
Subject: Re: [PATCH v9 1/8] mm: Introduce memfd_restricted system call to
 create restricted user memory
Message-ID: <20221114221605.bpmalqbehfd4vvuu@amd.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-2-chao.p.peng@linux.intel.com>
 <20221031174738.fklhlia5fmaiinpe@amd.com>
 <20221101113729.GA4015495@chaop.bj.intel.com>
 <20221101151944.rhpav47pdulsew7l@amd.com>
 <20a11042-2cfb-8f42-9d80-6672e155ca2c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20a11042-2cfb-8f42-9d80-6672e155ca2c@suse.cz>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT061:EE_|MN0PR12MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: e978dc4e-1b61-4e81-5731-08dac68ddf6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n/sx+uEQ9by6+BA8G9JdRsa002IbhSe2x14LLpq7ZzgXEWA8xUW/N/0wP+3YODfdZOjVed78dWKmUij5vgP1wEonYZ8H7RQp3pU1SHpXUHmnhd6GnwxWAXsW4FwxwMs2npb5T0N80JaS4a1EP7j8+hRqouzNCKjPIIclqwANWPh+oNgjM2m6YZSQyi8gXzAnQrKFXpq4Js7TwCVXmMUkzay/EnVD9RkquIDqxrizVqPz9dvJ3whUxaSGyZ+ToN6c33QKcPL+oJxPB+wJYkK7KjjNFKmqMaooitPP6PNs8Sin73PIvrUsGwcAtqlyTIgwhgWCde3yfmDcjYO/WUiKofDu5XRbRwfh5Dkr0Be0Di7AUTGk2nstc0wmUQ2RMGATF8W9wrH3ieTQr3kVeAs8N27xPSUTI7h9BgY2hXEqesaRRUFaakSJlpHDjtW8/CHA1Nq/AZ/lj8JxGtzpmMEVk+q9GFirlYNQY9ZJOnA7fvJRJz2EPIRtR6Wor9NhMZodBd0P85efaf5hWXMr4ngVht4LM41GfL3yq1RzqAdDLFGTUz1mLK/Wz9JjXFl5LWqLDTvOZa3VYeazyKvRv0rZfhMqew46ovCQ1m28UKlktCw4KLAYOQeu9DorThdKfk8Jsw/Z3aFBmiZFTdUvdtCtlfCMDa5Ud/9duCN4i/DQVJVyaQ9OQJYQqmgGipfjQq5NYwx1IzjLlpOGTPdaj8hMb912qLh5MedYJyq+ztGWycFv3EM6hZnSWqexN7dHMGYzAQegWh1lhHCYiTqZiz2eUM81D2n9tfolsO3fKR3ciPrxDIschSpNqDJi0JIKkoOlZnx2oTKRgO58oRgRi/EowsSNYMEQvtC3ES8QTcQoso1CEHihRwoL3bpjm/9GFYnTYGtdSXbFiIcDzcpepAMYvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199015)(40470700004)(46966006)(36840700001)(6666004)(26005)(53546011)(45080400002)(478600001)(40480700001)(6916009)(36756003)(966005)(54906003)(316002)(36860700001)(82740400003)(81166007)(40460700003)(82310400005)(86362001)(426003)(1076003)(336012)(47076005)(16526019)(83380400001)(356005)(2616005)(186003)(2906002)(8936002)(7406005)(7416002)(41300700001)(44832011)(8676002)(70206006)(30864003)(4326008)(70586007)(5660300002)(3714002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 22:16:26.6804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e978dc4e-1b61-4e81-5731-08dac68ddf6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 14, 2022 at 03:02:37PM +0100, Vlastimil Babka wrote:
> On 11/1/22 16:19, Michael Roth wrote:
> > On Tue, Nov 01, 2022 at 07:37:29PM +0800, Chao Peng wrote:
> >> > 
> >> >   1) restoring kernel directmap:
> >> > 
> >> >      Currently SNP (and I believe TDX) need to either split or remove kernel
> >> >      direct mappings for restricted PFNs, since there is no guarantee that
> >> >      other PFNs within a 2MB range won't be used for non-restricted
> >> >      (which will cause an RMP #PF in the case of SNP since the 2MB
> >> >      mapping overlaps with guest-owned pages)
> >> 
> >> Has the splitting and restoring been a well-discussed direction? I'm
> >> just curious whether there is other options to solve this issue.
> > 
> > For SNP it's been discussed for quite some time, and either splitting or
> > removing private entries from directmap are the well-discussed way I'm
> > aware of to avoid RMP violations due to some other kernel process using
> > a 2MB mapping to access shared memory if there are private pages that
> > happen to be within that range.
> > 
> > In both cases the issue of how to restore directmap as 2M becomes a
> > problem.
> > 
> > I was also under the impression TDX had similar requirements. If so,
> > do you know what the plan is for handling this for TDX?
> > 
> > There are also 2 potential alternatives I'm aware of, but these haven't
> > been discussed in much detail AFAIK:
> > 
> > a) Ensure confidential guests are backed by 2MB pages. shmem has a way to
> >    request 2MB THP pages, but I'm not sure how reliably we can guarantee
> >    that enough THPs are available, so if we went that route we'd probably
> >    be better off requiring the use of hugetlbfs as the backing store. But
> >    obviously that's a bit limiting and it would be nice to have the option
> >    of using normal pages as well. One nice thing with invalidation
> >    scheme proposed here is that this would "Just Work" if implement
> >    hugetlbfs support, so an admin that doesn't want any directmap
> >    splitting has this option available, otherwise it's done as a
> >    best-effort.
> > 
> > b) Implement general support for restoring directmap as 2M even when
> >    subpages might be in use by other kernel threads. This would be the
> >    most flexible approach since it requires no special handling during
> >    invalidations, but I think it's only possible if all the CPA
> >    attributes for the 2M range are the same at the time the mapping is
> >    restored/unsplit, so some potential locking issues there and still
> >    chance for splitting directmap over time.
> 
> I've been hoping that
> 
> c) using a mechanism such as [1] [2] where the goal is to group together
> these small allocations that need to increase directmap granularity so
> maximum number of large mappings are preserved. But I guess that means

Thanks for the references. I wasn't aware there was work in this area,
this opens up some possibilities on how to approach this.

> maximum number of large mappings are preserved. But I guess that means
> knowing at allocation time that this will happen. So I've been wondering how
> this would be possible to employ in the SNP/UPM case? I guess it depends on
> how we expect the private/shared conversions to happen in practice, and I
> don't know the details. I can imagine the following complications:
> 
> - a memfd_restricted region is created such that it's 2MB large/aligned,
> i.e. like case a) above, we can allocate it normally. Now, what if a 4k page
> in the middle is to be temporarily converted to shared for some
> communication between host and guest (can such thing happen?). With the
> punch hole approach, I wonder if we end up fragmenting directmap
> unnecessarily? IIUC the now shared page will become backed by some other

Yes, we end up fragmenting in cases where a guest converts a sub-page to a
shared page because the fallocate(PUNCH_HOLE) gets forwarded through to shmem
which will then split it. At that point the subpage might get used elsewhere
so we no longer have the ability to restore as 2M after
invalidation/shutdown. We could potentially just intercept those
fallocate()'s and only issue the invalidation once all the subpages have
been PUNCH_HOLE'd. We'd still need to ensure KVM MMU invalidations
happen immediately though, but since we rely on a KVM ioctl to do the
conversion in advance, we can rely on the KVM MMU invalidation that
happens at that point and simply make fallocate(PUNCH_HOLE) fail if
someone attempts it on a page that hasn't been converted to shared yet.

Otherwise we could end up being an good chunk of pages depending on how
guest allocates shared pages, but I'm slightly less concerned about that
seeing as there are some general solutions to directmap fragmentation
being considered. I need to think more how this hooks would tie in to
that though.

And since we'd only really being able to avoid unrecoverable splits if
the restrictedmem is hugepage-backed (if we get a bunch of 4K pages
to begin with there's no handling that would avoid fragmentation), it seems
like we'd end up relying on hugetlbfs support for instances where a host
really wants to avoid splitting, and maybe in the case of hugetlbfs
fallocate(PUNCH_HOLE) is already a no-op of sorts? Either way maybe it's
better to explore this aspect in the context of hugetlbfs support.

> page (as the memslot supports both private and shared pages simultaneously).
> But does it make sense to really split the direct mapping (and e.g. the
> shmem page?) We could leave the whole 2MB unmapped without splitting if we
> didn't free the private 4k subpage.
> 
> - a restricted region is created that's below 2MB. If something like [1] is
> merged, it could be used for the backing pages to limit directmap
> fragmentation. But then in case it's eventually fallocated to become larger
> and gain one more more 2MB aligned ranges, the result is suboptimal. Unless
> in that case we migrate the existing pages to a THP-backed shmem, kinda like
> khugepaged collapses hugepages. But that would have to be coordinated with
> the guest, maybe not even possible?

Any migrations would need to be coordinated with SNP firmware at least. I
think it's possible, but that support is probably a ways out. Near-term
I think it might be more straightforward to say: if you don't want to
directmap fragmentation (for SNP anyway), you need to ensure restricted
ranges are backed by THPs or hugetlbfs, and make that the basis for
avoiding directmap splitting for now. Otherwise, it's simply done as a
best-effort, and then maybe over time, with things like [1] and migration
support in place, this restriction can go away, or become less impactful
at least.

Thanks,

Mike

> 
> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F20220127085608.306306-1-rppt%40kernel.org%2F&amp;data=05%7C01%7Cmichael.roth%40amd.com%7C50b74bc241704885319d08dac648e4bb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638040313701097847%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=iGsgnGccmJrik%2FJqve4NmP0U%2B9cEQBJGDPITynIYZUQ%3D&amp;reserved=0
> [2] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flwn.net%2FArticles%2F894557%2F&amp;data=05%7C01%7Cmichael.roth%40amd.com%7C50b74bc241704885319d08dac648e4bb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638040313701097847%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=W%2BtSXxi%2Bs5RJYxP9BH0%2FiNOfl1FKM9mfw5nEXJO5doU%3D&amp;reserved=0
> 
> >> 
> >> > 
> >> >      Previously we were able to restore 2MB mappings to some degree
> >> >      since both shared/restricted pages were all pinned, so anything
> >> >      backed by a THP (or hugetlb page once that is implemented) at guest
> >> >      teardown could be restored as 2MB direct mapping.
> >> > 
> >> >      Invalidation seems like the most logical time to have this happen,
> >> 
> >> Currently invalidation only happens at user-initiated fallocate(). It
> >> does not cover the VM teardown case where the restoring might also be
> >> expected to be handled.
> > 
> > Right, I forgot to add that in my proposed changes I added invalidations
> > for any still-allocated private pages present when the restricted memfd
> > notifier is unregistered. This was needed to avoid leaking pages back to
> > the kernel that still need directmap or RMP table fixups. I also added
> > similar invalidations for memfd->release(), since it seems possible that
> > userspace might close() it before shutting down guest, but maybe the
> > latter is not needed if KVM takes a reference on the FD during life of
> > the guest.
> > 
> >> 
> >> >      but whether or not to restore as 2MB requires the order to be 2MB
> >> >      or larger, and for GPA range being invalidated to cover the entire
> >> >      2MB (otherwise it means the page was potentially split and some
> >> >      subpages free back to host already, in which case it can't be
> >> >      restored as 2MB).
> >> > 
> >> >   2) Potentially less invalidations:
> >> >       
> >> >      If we pass the entire folio or compound_page as part of
> >> >      invalidation, we only needed to issue 1 invalidation per folio.
> >> 
> >> I'm not sure I agree, the current invalidation covers the whole range
> >> that passed from userspace and the invalidation is invoked only once for
> >> each usrspace fallocate().
> > 
> > That's true, it only reduces invalidations if we decide to provide a
> > struct page/folio as part of the invalidation callbacks, which isn't
> > the case yet. Sorry for the confusion.
> > 
> >> 
> >> > 
> >> >   3) Potentially useful for hugetlbfs support:
> >> > 
> >> >      One issue with hugetlbfs is that we don't support splitting the
> >> >      hugepage in such cases, which was a big obstacle prior to UPM. Now
> >> >      however, we may have the option of doing "lazy" invalidations where
> >> >      fallocate(PUNCH_HOLE, ...) won't free a shmem-allocate page unless
> >> >      all the subpages within the 2M range are either hole-punched, or the
> >> >      guest is shut down, so in that way we never have to split it. Sean
> >> >      was pondering something similar in another thread:
> >> > 
> >> >        https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-mm%2FYyGLXXkFCmxBfu5U%40google.com%2F&amp;data=05%7C01%7Cmichael.roth%40amd.com%7C50b74bc241704885319d08dac648e4bb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638040313701097847%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=GTO73Onun86jZh3PZABQL%2F4Fs5R%2BFZe9gDkOSMoHddA%3D&amp;reserved=0
> >> > 
> >> >      Issuing invalidations with folio-granularity ties in fairly well
> >> >      with this sort of approach if we end up going that route.
> >> 
> >> There is semantics difference between the current one and the proposed
> >> one: The invalidation range is exactly what userspace passed down to the
> >> kernel (being fallocated) while the proposed one will be subset of that
> >> (if userspace-provided addr/size is not aligned to power of two), I'm
> >> not quite confident this difference has no side effect.
> > 
> > In theory userspace should not be allocating/hole-punching restricted
> > pages for GPA ranges that are already mapped as private in the xarray,
> > and KVM could potentially fail such requests (though it does currently).
> > 
> > But if we somehow enforced that, then we could rely on
> > KVM_MEMORY_ENCRYPT_REG_REGION to handle all the MMU invalidation stuff,
> > which would free up the restricted fd invalidation callbacks to be used
> > purely to handle doing things like RMP/directmap fixups prior to returning
> > restricted pages back to the host. So that was sort of my thinking why the
> > new semantics would still cover all the necessary cases.
> > 
> > -Mike
> > 
> >> 
> >> > 
> >> > I need to rework things for v9, and we'll probably want to use struct
> >> > folio instead of struct page now, but as a proof-of-concept of sorts this
> >> > is what I'd added on top of v8 of your patchset to implement 1) and 2):
> >> > 
> >> >   https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fmdroth%2Flinux%2Fcommit%2F127e5ea477c7bd5e4107fd44a04b9dc9e9b1af8b&amp;data=05%7C01%7Cmichael.roth%40amd.com%7C50b74bc241704885319d08dac648e4bb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638040313701097847%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=yYd6lVWEFkffTZnAoFTgoozYxZbxvMXjOd%2BWuP70G7I%3D&amp;reserved=0
> >> > 
> >> > Does an approach like this seem reasonable? Should be work this into the
> >> > base restricted memslot support?
> >> 
> >> If the above mentioned semantics difference is not a problem, I don't
> >> have strong objection on this.
> >> 
> >> Sean, since you have much better understanding on this, what is your
> >> take on this?
> >> 
> >> Chao
> >> > 
> >> > Thanks,
> >> > 
> >> > Mike
> 
