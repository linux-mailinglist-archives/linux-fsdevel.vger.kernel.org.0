Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B0659AA26
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 02:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244389AbiHTAbY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 20:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243430AbiHTAbW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 20:31:22 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B53CD75A7;
        Fri, 19 Aug 2022 17:31:21 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id B568F2B06109;
        Fri, 19 Aug 2022 20:27:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 19 Aug 2022 20:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660955226; x=1660962426; bh=Ez
        /o4Y2tKPtSFWobOA9rtOb1803iS6GsFqfxsG8DlJY=; b=J1sLkmgnpr1IHCnks/
        TncIKoSB2iyU0SQevspoXfStE4ASIgQdckNGUnnM/awsZSGl4C1OntcVqK7/k6GN
        7MSjjDs4ekjAcVE+UiN4FV8UYvaOTuNRtiiNc8A7Gdofv7Wcl8WW4OdSu7hQ5H6u
        87XLbJBCU8T4KH2G+fsweFV8DvsgD+iciohXgKhjcDHX8ltZp+zNkLq27kM76xWJ
        huGQLOI4IkShGKA8o9tEYXYWPU+T3SRdig6WezhCpy2YrI/VHxs3O3U1mctqpx5Y
        oXy/xII3UEv87xctnWoObigXtWZRkBZiSZdc0Zino9Vx5QVaJSszorGVbLYaInZr
        /HbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660955226; x=1660962426; bh=Ez/o4Y2tKPtSFWobOA9rtOb1803i
        S6GsFqfxsG8DlJY=; b=LNehmM1meXB0YoTHnShkMvfy937G8WXxFT7hfxmGyt++
        PDxFoAQ4iSTNBXCIJTcEmSBLxdeOSCW6p0H0vv+vTvpBjtW+faYjtIayEEzIBR3q
        yYLDKoID5MvfhaJ99WM0jq7rE6i1By1VkqeU5vNyspT2RJoU3nHDD8+vrjOfipYX
        HEj9FsycHMbsdze6a489AhRV5IN26Y7/u61+q00CGOH6sPXrBaXEqFp39J3+rO2I
        O2v1SptYfuDPPfsBnsgZHBvq3fAYD/zBtbjWfsUHdmFXZSHFPVmW7kvXBcAGKa6P
        6lnIVgRpdUm1uoSVVSvnGPmE88yqpjg89yYpLqGYaA==
X-ME-Sender: <xms:WCoAYzYYyJ1_A8aO3bPjr6duCBycn0g3AcBLPTdfc6L9WTzaxQUFSQ>
    <xme:WCoAYybvsGHzNSyTiRvcRJbGrj4BvBDntAUHY8KLu7GIdlV1fqIZFpvqAcd3hvxOK
    r8ehKJS_dTdFokEjTk>
X-ME-Received: <xmr:WCoAY19PmvEJ89tphPfNdcXzfc0He-WP8ErI_IqcwrwkS98oDdOBEigKokMjo7oeLURCng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeivddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeethffguefftdejudekgfehuefhjefhhfdthfeg
    ieeuffelieffffeiteejjeekudenucffohhmrghinhepihhnthgvlhdrtghomhdpmhgvmh
    drphgrghgvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:WCoAY5qRelQbeh57Ik8xZ-drGYmnFqmHk8OznvzoIQwedvfRbcEp8A>
    <xmx:WCoAY-oePBlhJPU7QZD9W5q0eF-6ETuoGJzR7DfDVZTNXeLPYMHeQA>
    <xmx:WCoAY_QB_q4ec1TDL0nSLZHaOMCqsMbqI0X-evTJ4FLEWFkbLwvGug>
    <xmx:WioAY5FLZ70rhK9mBhIZFrgqiW3vNsh_ksUFobn7XxJ6IQC0IchE01xMYbE>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Aug 2022 20:27:03 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 3F27B10418C; Sat, 20 Aug 2022 03:27:00 +0300 (+03)
Date:   Sat, 20 Aug 2022 03:27:00 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>,
        "Gupta, Pankaj" <pankaj.gupta@amd.com>
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <20220820002700.6yflrxklmpsavdzi@box.shutemov.name>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <ff5c5b97-acdf-9745-ebe5-c6609dd6322e@google.com>
 <20220818132421.6xmjqduempmxnnu2@box>
 <c6ccbb96-5849-2e2f-3b49-4ea711af525d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6ccbb96-5849-2e2f-3b49-4ea711af525d@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 18, 2022 at 08:00:41PM -0700, Hugh Dickins wrote:
> On Thu, 18 Aug 2022, Kirill A . Shutemov wrote:
> > On Wed, Aug 17, 2022 at 10:40:12PM -0700, Hugh Dickins wrote:
> > > 
> > > If your memory could be swapped, that would be enough of a good reason
> > > to make use of shmem.c: but it cannot be swapped; and although there
> > > are some references in the mailthreads to it perhaps being swappable
> > > in future, I get the impression that will not happen soon if ever.
> > > 
> > > If your memory could be migrated, that would be some reason to use
> > > filesystem page cache (because page migration happens to understand
> > > that type of memory): but it cannot be migrated.
> > 
> > Migration support is in pipeline. It is part of TDX 1.5 [1]. And swapping
> > theoretically possible, but I'm not aware of any plans as of now.
> > 
> > [1] https://www.intel.com/content/www/us/en/developer/articles/technical/intel-trust-domain-extensions.html
> 
> I always forget, migration means different things to different audiences.
> As an mm person, I was meaning page migration, whereas a virtualization
> person thinks VM live migration (which that reference appears to be about),
> a scheduler person task migration, an ornithologist bird migration, etc.
> 
> But you're an mm person too: you may have cited that reference in the
> knowledge that TDX 1.5 Live Migration will entail page migration of the
> kind I'm thinking of.  (Anyway, it's not important to clarify that here.)

TDX 1.5 brings both.

In TDX speak, mm migration called relocation. See TDH.MEM.PAGE.RELOCATE.

> > > Some of these impressions may come from earlier iterations of the
> > > patchset (v7 looks better in several ways than v5).  I am probably
> > > underestimating the extent to which you have taken on board other
> > > usages beyond TDX and SEV private memory, and rightly want to serve
> > > them all with similar interfaces: perhaps there is enough justification
> > > for shmem there, but I don't see it.  There was mention of userfaultfd
> > > in one link: does that provide the justification for using shmem?
> > > 
> > > I'm afraid of the special demands you may make of memory allocation
> > > later on - surprised that huge pages are not mentioned already;
> > > gigantic contiguous extents? secretmem removed from direct map?
> > 
> > The design allows for extension to hugetlbfs if needed. Combination of
> > MFD_INACCESSIBLE | MFD_HUGETLB should route this way. There should be zero
> > implications for shmem. It is going to be separate struct memfile_backing_store.
> 
> Last year's MFD_HUGEPAGE proposal would have allowed you to do it with
> memfd via tmpfs without needing to involve hugetlbfs; but you may prefer
> the determinism of hugetlbfs, relying on /proc/sys/vm/nr_hugepages etc.
> 
> But I've yet to see why you want to involve this or that filesystem
> (with all its filesystem-icity suppressed) at all.  The backing store
> is host memory, and tmpfs and hugetlbfs just impose their own
> idiosyncrasies on how that memory is allocated; but I think you would
> do better to choose your own idiosyncrasies in allocation directly -
> you don't need a different "backing store" to choose between 4k or 2M
> or 1G or whatever allocations.

These idiosyncrasies are well known: user who used hugetlbfs may want to
get direct replacement that would tap into the same hugetlb reserves and
get the same allocation guarantees. Admins know where to look if ENOMEM
happens.

For THP, admin may know how to tweak allocation/defrag policy for his
liking and how to track if they are allocated.

> tmpfs and hugetlbfs and page cache are designed around sharing memory:
> TDX is designed around absolutely not sharing memory; and the further
> uses which Sean foresees appear not to need it as page cache either.
> 
> Except perhaps for page migration reasons.  It's somewhat incidental,  
> but of course page migration knows how to migrate page cache, so
> masquerading as page cache will give a short cut to page migration,
> when page migration becomes at all possible.
> 
> > 
> > I'm not sure secretmem is a fit here as we want to extend MFD_INACCESSIBLE
> > to be movable if platform supports it and secretmem is not migratable by
> > design (without direct mapping fragmentations).
> > 
> > > Here's what I would prefer, and imagine much easier for you to maintain;
> > > but I'm no system designer, and may be misunderstanding throughout.
> > > 
> > > QEMU gets fd from opening /dev/kvm_something, uses ioctls (or perhaps
> > > the fallocate syscall interface itself) to allocate and free the memory,
> > > ioctl for initializing some of it too.  KVM in control of whether that
> > > fd can be read or written or mmap'ed or whatever, no need to prevent it
> > > in shmem.c, no need for flags, seals, notifications to and fro because
> > > KVM is already in control and knows the history.  If shmem actually has
> > > value, call into it underneath - somewhat like SysV SHM, and /dev/zero
> > > mmap, and i915/gem make use of it underneath.  If shmem has nothing to
> > > add, just allocate and free kernel memory directly, recorded in your
> > > own xarray.
> > 
> > I guess shim layer on top of shmem *can* work. I don't see immediately why
> > it would not. But I'm not sure it is right direction. We risk creating yet
> > another parallel VM with own rules/locking/accounting that opaque to
> > core-mm.
> 
> You are already proposing a new set of rules, foreign to how tmpfs works
> for others.  You're right that KVM allocating large amounts of memory,
> opaque to core-mm, carries risk: and you'd be right to say that shmem.c
> provides some clues (security_vm_enough_memory checks, memcg charging,
> user_shm_lock accounting) on what to remember.

That's a nice list of clues that would need to be re-implemented somewhere
else to get competent solution.

> But I'm not up to the job of being the one to police you there,
> and you don't want to be waiting on me either.

> To take a rather silly example: Ted just added chattr support to tmpfs,
> and it fits in well.  But I don't now want to have to decide whether
> "chattr +i" FS_IMMUTABLE_FL is or is not compatible with
> MEMFILE_F_USER_INACCESSIBLE.  They are from different worlds,
> and I'd prefer KVM to carry the weight of imposing INACCESSIBLE:
> which seems easily done if it manages the fd, without making the
> memory allocated to that fd accessible to those who hold the fd.

From a quick look, these are orthogonal. But it is not your point.

Yes, INACCESSIBLE is increase of complexity which you do not want to deal
with in shmem.c. It get it.

I will try next week to rework it as shim to top of shmem. Does it work
for you?

But I think it is wrong to throw it over the fence to KVM folks and say it
is your problem. Core MM has to manage it.

> > Note that on machines that run TDX guests such memory would likely be the
> > bulk of memory use. Treating it as a fringe case may bite us one day.
> 
> Yes, I suspected that machines running TDX guests might well consume
> most of the memory that way, but glad(?) to hear it confirmed.
> 
> I am not suggesting that this memory be treated as a fringe case, rather
> the reverse: a different case, not something to hide away inside shmem.c.
> 
> Is there a notion that /proc/meminfo "Shmem:" is going to be a good hint
> of this usage?  Whether or not it's also included in "Shmem:", I expect
> that its different characteristics will deserve its own display.

That's the hint users know about from previous experience.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
