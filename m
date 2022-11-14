Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7156283DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 16:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbiKNP3O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 10:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236934AbiKNP2z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:28:55 -0500
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A79E09C;
        Mon, 14 Nov 2022 07:28:52 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id BD4962B067C3;
        Mon, 14 Nov 2022 10:28:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 14 Nov 2022 10:28:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1668439728; x=1668446928; bh=Nk
        bbGytzJ7I7fdZjJ8Fl0BV2oDQacMuRT8wrkqNypwg=; b=L+fg9psCjGWR+Q4jar
        Mh8WPN0CCVKtE8QULFZl/REBBGfEYLOoG5tTfwzN2fLvRfihDZ0CUPaHxOTUYHgN
        +f0XudZX5n2uU9Zk262NyzcpFGRRDtJoWAoc8JwvaQmfWt8ENHQA6z/bl7D7zv1j
        stjmAjSQgumSVaN7IVmX7VjTeL7anz0EPhVYEJbMwNJF0wgd5r6RGPz80nDeGRIS
        5U9ySXNkmdE/w/yBigY3Rx3yFbACIc4cb0hBrdw/YOLobVtkqXvHu1Wc+/Tc+Mo0
        TsAi0HYkU2U+JWkiZhU99J/Rd1WejZwmC3+i8aR3e2dYkVY3CF08l1y9hbmQUXj5
        XQoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668439728; x=1668446928; bh=NkbbGytzJ7I7fdZjJ8Fl0BV2oDQa
        cMuRT8wrkqNypwg=; b=OSToxW/AKRZaXNJ4BEd/AfCajCfbDqN1unwhNaXMlb9t
        gBO67tNkQ7mqXA1AQ+PhqQadLiKZ6cu5xEbfTKv1UtTrVeWL9sP4ytoewiuSj1Ks
        BBC694bRwD2HHIJeQSaeEBV2jt9gSr7nEGve1a7AVzb3q2yf7pOa1kMcencyzD/z
        3DFaSyJ7bmfdtINjvmK8PGAsAt9Yq9t5XdVVz6oLDmHHq+3tD+atDSuLlkEUfNWG
        r0CU0ehV3Oq8cdxwsBSBfEkWuWaYR8G1HRnSlk1MucqsgCqrtCknz01vR9JGWymU
        ec23kvRXthssYr0nlcCFXMk42bb8tf09b03GWaO3aQ==
X-ME-Sender: <xms:r15yY_0QRYhyAkn-aGlVslxWDhm_9bvHMBd6L_bA6_qmkRguiYaqfg>
    <xme:r15yY-Gl3WluqhzR5HczYZyXS396xm8TKAb-aw0uzyy_Lwjlq_FFDx78c9GcSLxVg
    omFr3Xg_KAP38qJKcY>
X-ME-Received: <xmr:r15yY_4eNDfu6njZp1k19j2OAE3egUL8KFpHjFGbrTkXA6fmmfh5gR4fdxZPNA5MVmYq0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedvgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueehtedt
    tdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:r15yY03SFHC1V2ev4RxYj9TRgPZ9wbV1HZ2kMPfVye6Ouoozly-5pA>
    <xmx:r15yYyF9Dk-M3xacDgcx9XiIc2UyNRI_n1wX8zQbg2MGr7E4GWvUYA>
    <xmx:r15yY1-J6Sa29ay92N9akyCSYEV3nNXagqOnIPGeHpRBz_8zvlV44w>
    <xmx:sF5yY3QIa2TGTJD3XJpjfYjCXVPw48yakbN9YPL0_2IRk6C7cvZVbImWW3U>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Nov 2022 10:28:46 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 18B2A109875; Mon, 14 Nov 2022 18:28:43 +0300 (+03)
Date:   Mon, 14 Nov 2022 18:28:43 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Michael Roth <michael.roth@amd.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
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
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        mhocko@suse.com, Muchun Song <songmuchun@bytedance.com>,
        wei.w.wang@intel.com
Subject: Re: [PATCH v9 1/8] mm: Introduce memfd_restricted system call to
 create restricted user memory
Message-ID: <20221114152843.ylxe4dis254vrj5u@box.shutemov.name>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-2-chao.p.peng@linux.intel.com>
 <20221031174738.fklhlia5fmaiinpe@amd.com>
 <20221101113729.GA4015495@chaop.bj.intel.com>
 <20221101151944.rhpav47pdulsew7l@amd.com>
 <20a11042-2cfb-8f42-9d80-6672e155ca2c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20a11042-2cfb-8f42-9d80-6672e155ca2c@suse.cz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
> maximum number of large mappings are preserved.

As I mentioned in the other thread the restricted memfd can be backed by
secretmem instead of plain memfd. It already handles directmap with care.

But I don't think it has to be part of initial restricted memfd
implementation. It is SEV-specific requirement and AMD folks can extend
implementation as needed later.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
