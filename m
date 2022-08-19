Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AA35991D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 02:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245211AbiHSAka (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 20:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241426AbiHSAk2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 20:40:28 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E810D7D3C;
        Thu, 18 Aug 2022 17:40:27 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2A636580E5D;
        Thu, 18 Aug 2022 20:40:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 18 Aug 2022 20:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660869625; x=1660876825; bh=p4
        mrdAhfuXrXkbUMCbpYFq9iim/KI6Q1KeIWNni0Pu8=; b=NmfuW1+kY6jqCU+SOB
        OECgLcjgfa/gkmj9WAQWHrJD2/c3qc7nnUazVUk975wdVftGPDZXi2dYd4VJlXps
        pRzBpT25IAYRcsHhb7UXxtcuflc66clE4gkYqkYMfuIGsxGOO4Mo6n9vy4TbbePv
        yBvxD+OcV+nUrqJdK4J4VrhHOn6Dh4g3iWomVQfeY1QK/C5oo0Oh6tr+ERqPQMm/
        i7WrGOmMzO20ibGuUivoDpDcehqVDc1tMFLXwnSCECRO27CUzxCo+ikHKB84LSj0
        2YqTH1XDybKxylJkysD/9Vw2GqO6En0Zr+bxEgi2mulkmu4V1uTFB42pTofZ42y7
        pOBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660869625; x=1660876825; bh=p4mrdAhfuXrXkbUMCbpYFq9iim/K
        I6Q1KeIWNni0Pu8=; b=zxN4ID6gqcZMZFi8RRRCqCJJz67/hlDBmIXr5jMDNL7J
        Vwlbb+o3pWLxQLrkZKs73qUn9/G22KzobJM2Jl9O3KX7JfWy8k8c1xkZpCxVN9WN
        c00bSD4/geEGawIMVcoMPAkKeghrFaVGsJA3qfQJ+oRqw2xSLwBMFIZpRH3IVJG8
        Zt86YzEpUzOJMNgH0PLfyvpiIbmSH7yVHevlA/KJ6yD2K4mMagqIDeKaIPrcMCR+
        M/ji5zqZU/m+yB8GLeVVmDfdSJ/wcNIGTd6h+ZgRK3B2Zu9Bup7h2qXawrZCQQyC
        fjNPXMtQFfPMWzHkfo+l1ZWfQYMTSh0d9NDp8BLonQ==
X-ME-Sender: <xms:99v-Yguo4sXKdcYloGScFZLpjFVcdsWZEue-M1d_aSugtfVgFE0PgQ>
    <xme:99v-YteKlaDAXzZrY5Q7ajRii4Spnlk3QnOkHFRj7meDmdCXaXBQ3dL9-ckV7WqnB
    xnWlyo3ThZy_C2RBU0>
X-ME-Received: <xmr:99v-Yryf_SG4XVAtEfsYgZcJ3dxZwV8_ZLtSRV-uOvVorPrG9mI1zqhG9KlR3myN6ZGf_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeitddgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:99v-YjNXs-TyttYJAcbSZqpXqruhIjPf74NygKPH72sFr0vzEnXA_Q>
    <xmx:99v-Yg-3-1lIdhYqJkEpnHGqR3EY0j38u01Fr5ghV6lowELnpxWTIw>
    <xmx:99v-YrUHX7v-hUiBnmBx_peHkRqQJLNybs1S_IxmlhX7GebIRTLP2Q>
    <xmx:-dv-YszGL-rTfN2_TUO-BqTH0iFUn_7vbveOClqgPpv1wXSMp-azIw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Aug 2022 20:40:22 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id CB4DD104AA5; Fri, 19 Aug 2022 03:40:18 +0300 (+03)
Date:   Fri, 19 Aug 2022 03:40:18 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com
Subject: Re: [PATCH v6 6/8] KVM: Handle page fault for private memory
Message-ID: <20220819004018.mgdvxhl6dj3ujl3f@box.shutemov.name>
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <20220519153713.819591-7-chao.p.peng@linux.intel.com>
 <YqzyjZnflCMPo8b/@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqzyjZnflCMPo8b/@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 17, 2022 at 09:30:53PM +0000, Sean Christopherson wrote:
> > @@ -4088,7 +4144,12 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
> >  		read_unlock(&vcpu->kvm->mmu_lock);
> >  	else
> >  		write_unlock(&vcpu->kvm->mmu_lock);
> > -	kvm_release_pfn_clean(fault->pfn);
> > +
> > +	if (fault->is_private)
> > +		kvm_private_mem_put_pfn(fault->slot, fault->pfn);
> 
> Why does the shmem path lock the page, and then unlock it here?

Lock is require to avoid race with truncate / punch hole. Like if truncate
happens after get_pfn(), but before it gets into SEPT we are screwed.

> Same question for why this path marks it dirty?  The guest has the page mapped
> so the dirty flag is immediately stale.

If page is clean and refcount is not elevated, vmscan is free to drop the
page from page cache. I don't think we want this.

> In other words, why does KVM need to do something different for private pfns?

Because in the traditional KVM memslot scheme, core mm takes care about
this.

The changes in v7 is wrong. Page has be locked until it lends into SEPT and
must make it dirty before unlocking.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
