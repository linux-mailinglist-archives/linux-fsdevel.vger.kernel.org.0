Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB64622F68
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Nov 2022 16:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiKIPyR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 10:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiKIPyQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:54:16 -0500
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4584DC7B;
        Wed,  9 Nov 2022 07:54:15 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id 34A082B06016;
        Wed,  9 Nov 2022 10:54:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 09 Nov 2022 10:54:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1668009250; x=1668016450; bh=H8
        kAV/CE2ghhRaBccYp9I0jjnZy3RFX2eXZbgxEIOcI=; b=jYsBBMC74+WS9Qdasq
        wMNLHIGiDVSgrzZY0ZZcOhQaSoY9+jgaNfcBHvli2fxtPvKu/o752qZIoecJm9t7
        q3iK4BRv4zhO+tj/o1rg3+gpNd17oVbQdEOep/3lxK88bw32ivYQGgQhE3llAfdW
        bFNPr2KasrDPoDYt9pA2ewg/lTaftbbXjXt1wMzGaicVGOxM4RZnMZ9u/DrgVCU5
        GSsg8BfpxtW1s3tqj/jJYib9h7nXO9ZxDy75XeqKoX/qaoX0tREp1DZwsTxDFYG7
        Jfn8TOxfsH54SipmyGUjIeySSH/AeP84n/0fS7FQBYJ4IuXQbLWdwdvOcFk/0s2v
        RyHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668009250; x=1668016450; bh=H8kAV/CE2ghhRaBccYp9I0jjnZy3
        RFX2eXZbgxEIOcI=; b=sJn22iXFueTNEANRK/zyJZClFypl1maVA2Uvf4doanX8
        QzbyCtmWFsSSFmz+vplYCXT0E165iQBG9su9MAVamut1B+PbE6+WRbQ67esTdM4f
        0UwEziQwhkK+ARLr/aYvrQE0+Rdf5wsj9PHYPHjMGhiJZaFAXq7G2pslVuJi2iqm
        73XLjGpcQ4oGp0z9/WPaeUSniOfei31oJZek9LqZwxRu0u808EUTgX7b6/cazaQ1
        0EFL9wKepNeWfs00YaNOODjRSWG4xaxonYoL2DN4lNsTC3usU8yAMtB3MvkvWr4o
        11gWkmOKqdD7fCMmdCdgQ9628fPgm9JR6InJHVeUYQ==
X-ME-Sender: <xms:Ic1rY0EVG3F5LakisuAUrAOLmZVsE35ulRvyUmYllPKHKW4mPcyTWA>
    <xme:Ic1rY9WOgrsfkD1DaJRXPGEs_wRp4kjBFxcPaLenEnjP3D5wkZF4F2UDEecMxFc7u
    U2-TP3k0gK_SqA7Ge8>
X-ME-Received: <xmr:Ic1rY-KGpnx0srAAs2HbQ8HWjzXNxQMUOjovPclU15PcKcP2JaNzmXxZEjckHs6Rzq3S9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfedvgdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueehtedt
    tdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:Ic1rY2HmUUl-sJKqyvgSao6VrbrsACcsh7Tq1tDm6bcqZTu-jtXUpw>
    <xmx:Ic1rY6UBiogYMYGuiPP6gbHe10QEnFpJi2cMBzmKOOapBGA7HYsrrQ>
    <xmx:Ic1rY5ONPzs7lY30EH-lC7PaXTcRtZYaTMnv18x_sh2CjcYjCZYFkQ>
    <xmx:Is1rY3llS2AO7Kt1-eytrKad3FIIcb8_wYMoBLb-RZabFlJAYZIsvh8iQnY>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Nov 2022 10:54:08 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 7FF36103D85; Wed,  9 Nov 2022 18:54:04 +0300 (+03)
Date:   Wed, 9 Nov 2022 18:54:04 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Isaku Yamahata <isaku.yamahata@gmail.com>,
        Hugh Dickins <hughd@google.com>
Cc:     Vishal Annapurve <vannapurve@google.com>,
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
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v9 0/8] KVM: mm: fd-based approach for supporting KVM
Message-ID: <20221109155404.istawiyvwr3yffag@box.shutemov.name>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <CAGtprH-av3K6YxUbz1cAsQp4w2ce35UrfBF-u7Q_qCuTNMdvzQ@mail.gmail.com>
 <20221108004141.GF1063309@ls.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108004141.GF1063309@ls.amr.corp.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 07, 2022 at 04:41:41PM -0800, Isaku Yamahata wrote:
> On Thu, Nov 03, 2022 at 05:43:52PM +0530,
> Vishal Annapurve <vannapurve@google.com> wrote:
> 
> > On Tue, Oct 25, 2022 at 8:48 PM Chao Peng <chao.p.peng@linux.intel.com> wrote:
> > >
> > > This patch series implements KVM guest private memory for confidential
> > > computing scenarios like Intel TDX[1]. If a TDX host accesses
> > > TDX-protected guest memory, machine check can happen which can further
> > > crash the running host system, this is terrible for multi-tenant
> > > configurations. The host accesses include those from KVM userspace like
> > > QEMU. This series addresses KVM userspace induced crash by introducing
> > > new mm and KVM interfaces so KVM userspace can still manage guest memory
> > > via a fd-based approach, but it can never access the guest memory
> > > content.
> > >
> > > The patch series touches both core mm and KVM code. I appreciate
> > > Andrew/Hugh and Paolo/Sean can review and pick these patches. Any other
> > > reviews are always welcome.
> > >   - 01: mm change, target for mm tree
> > >   - 02-08: KVM change, target for KVM tree
> > >
> > > Given KVM is the only current user for the mm part, I have chatted with
> > > Paolo and he is OK to merge the mm change through KVM tree, but
> > > reviewed-by/acked-by is still expected from the mm people.
> > >
> > > The patches have been verified in Intel TDX environment, but Vishal has
> > > done an excellent work on the selftests[4] which are dedicated for this
> > > series, making it possible to test this series without innovative
> > > hardware and fancy steps of building a VM environment. See Test section
> > > below for more info.
> > >
> > >
> > > Introduction
> > > ============
> > > KVM userspace being able to crash the host is horrible. Under current
> > > KVM architecture, all guest memory is inherently accessible from KVM
> > > userspace and is exposed to the mentioned crash issue. The goal of this
> > > series is to provide a solution to align mm and KVM, on a userspace
> > > inaccessible approach of exposing guest memory.
> > >
> > > Normally, KVM populates secondary page table (e.g. EPT) by using a host
> > > virtual address (hva) from core mm page table (e.g. x86 userspace page
> > > table). This requires guest memory being mmaped into KVM userspace, but
> > > this is also the source where the mentioned crash issue can happen. In
> > > theory, apart from those 'shared' memory for device emulation etc, guest
> > > memory doesn't have to be mmaped into KVM userspace.
> > >
> > > This series introduces fd-based guest memory which will not be mmaped
> > > into KVM userspace. KVM populates secondary page table by using a
> > 
> > With no mappings in place for userspace VMM, IIUC, looks like the host
> > kernel will not be able to find the culprit userspace process in case
> > of Machine check error on guest private memory. As implemented in
> > hwpoison_user_mappings, host kernel tries to look at the processes
> > which have mapped the pfns with hardware error.
> > 
> > Is there a modification needed in mce handling logic of the host
> > kernel to immediately send a signal to the vcpu thread accessing
> > faulting pfn backing guest private memory?
> 
> mce_register_decode_chain() can be used.  MCE physical address(p->mce_addr)
> includes host key id in addition to real physical address.  By searching used
> hkid by KVM, we can determine if the page is assigned to guest TD or not. If
> yes, send SIGBUS.
> 
> kvm_machine_check() can be enhanced for KVM specific use.  This is before
> memory_failure() is called, though.
> 
> any other ideas?

That's too KVM-centric. It will not work for other possible user of
restricted memfd.

I tried to find a way to get it right: we need to get restricted memfd
code info about corrupted page so it can invalidate its users. On the next
request of the page the user will see an error. In case of KVM, the error
will likely escalate to SIGBUS.

The problem is that core-mm code that handles memory failure knows nothing
about restricted memfd. It only sees that the page belongs to a normal
memfd.

AFAICS, there's no way to get it intercepted from the shim level. shmem
code has to be patches. shmem_error_remove_page() has to call into
restricted memfd code.

Hugh, are you okay with this? Or maybe you have a better idea?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
