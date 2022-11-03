Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFE661846E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 17:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiKCQaW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 12:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiKCQaV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:30:21 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A039E68;
        Thu,  3 Nov 2022 09:30:20 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id B39505802BB;
        Thu,  3 Nov 2022 12:30:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Nov 2022 12:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1667493017; x=1667500217; bh=z/
        C3hpsaAUauBg1lNZ7x2lDFowPPF1DONENeXdvNlHg=; b=cJt3hR7v7SCNla7eXQ
        i90372/VJvPGU+ek4EklPY7Z1h9eNHAS6q98C2Pkp/Ks5TkT/I6+O+oiLSzUi3qG
        YQMXVCqPCd853tICbc9Ot5iuYoTcY9sDj153nfGnceQroa51z/zyStTVx6kKk+qk
        swy2GVse/rzWnvNiZyrkq9+QKIkMO6c+HBDbcT5815ZqaSg+CqMieNF+suoTkG9q
        d35+VbbvhhxHny0REo2fqtAFKjWH69jfafARLlrDEkwPR5G+OeeWexyMY69xWTQs
        9hG31aLQZ1NBst4OsgmoFm7sgmmNccS27ItzTJewBOjAI1mf3W5sYVfz7O2QQkH2
        KECw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667493017; x=1667500217; bh=z/C3hpsaAUauBg1lNZ7x2lDFowPP
        F1DONENeXdvNlHg=; b=Xp/UUWwX3MA3A3FhOL+uUmo98+p/mBAOVE6y3oteimnp
        BGsyKhPGyDalEGVnTkf9KbzLLGczmkIRzvTCBCbaWYaYtZJ7s5wGS5ox4pse97E8
        ItmT6KnFilBemeBsPjQnDXYjjEjoHoULHaLQ5ONvcVTOm++bj/0zi0P2ns0QvcPP
        cS23hOm5hfOhMomcRE7PFy4MEYmjfnQ+MjemMLurvahmVpbBGyjQ/6JonkxsSyqd
        mpJ1O2FcOAHrD7eaBmcAr7R0mLw53nA40XEYmYrMS73USeELLLLl1ODQZhSxynXT
        atH9QYZog6S+m644Se0gu6hLvqJpioy/eHJRfVxNzQ==
X-ME-Sender: <xms:l-xjY2y2hvIUc2gnuKmrrWWgeYya4CvqS9xJWrYD_Y-xuI4mNmjJSA>
    <xme:l-xjYyTQxmaFzyvy445bumuVSyUrIFPKtLq4mk5xop0IdzEhsisFjkoKABFLZueIJ
    _ZKaVY9Hldx5BNRbsI>
X-ME-Received: <xmr:l-xjY4VPN3ITYs_DHTBDcn0JNGi4bFeXCmQaCWWhWxcF7179z9Avu7Aj4w18LzVT5te7CQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudelgdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhephffgffehieelieefveeukeevtdevvdfhtdduvdet
    vdffhffhfffgieehfeehvdelnecuffhomhgrihhnpegrmhgurdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhu
    thgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:l-xjY8jFfTy07E1c7ongwMhBptl1nbLk6rZYXP8u8pvzK_kobDzp7A>
    <xmx:l-xjY4Cq4sEeo9PzVqE0bdOqfmBEOuz9ttBC1q_GaEfz2uCOh3GTHA>
    <xmx:l-xjY9I0mOHHOewyM90VoMTKjcRtGwCR02bJND_jqEDOfMUVKD57NA>
    <xmx:mexjY98KrJllNKgIt3jvB18QJ7eC1KSYIZeGELfE3xb7jcLc6UHJNQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Nov 2022 12:30:15 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 1EC92104769; Thu,  3 Nov 2022 19:30:12 +0300 (+03)
Date:   Thu, 3 Nov 2022 19:30:12 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michael Roth <michael.roth@amd.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
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
        Vlastimil Babka <vbabka@suse.cz>,
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
Message-ID: <20221103163012.25zof5lyxvizltwl@box.shutemov.name>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-2-chao.p.peng@linux.intel.com>
 <20221031174738.fklhlia5fmaiinpe@amd.com>
 <20221102211404.l5whyif3j3k67fv2@box.shutemov.name>
 <20221102220700.5u4mj7fm37m6ust2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102220700.5u4mj7fm37m6ust2@amd.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 02, 2022 at 05:07:00PM -0500, Michael Roth wrote:
> On Thu, Nov 03, 2022 at 12:14:04AM +0300, Kirill A. Shutemov wrote:
> > On Mon, Oct 31, 2022 at 12:47:38PM -0500, Michael Roth wrote:
> > > 
> > > In v8 there was some discussion about potentially passing the page/folio
> > > and order as part of the invalidation callback, I ended up needing
> > > something similar for SEV-SNP, and think it might make sense for other
> > > platforms. This main reasoning is:
> > > 
> > >   1) restoring kernel directmap:
> > > 
> > >      Currently SNP (and I believe TDX) need to either split or remove kernel
> > >      direct mappings for restricted PFNs, since there is no guarantee that
> > >      other PFNs within a 2MB range won't be used for non-restricted
> > >      (which will cause an RMP #PF in the case of SNP since the 2MB
> > >      mapping overlaps with guest-owned pages)
> > 
> > That's news to me. Where the restriction for SNP comes from?
> 
> Sorry, missed your first question.
> 
> For SNP at least, the restriction is documented in APM Volume 2, Section
> 15.36.10, First row of Table 15-36 (preceeding paragraph has more
> context). I forgot to mention this is only pertaining to writes by the
> host to 2MB pages that contain guest-owned subpages, for reads it's
> not an issue, but I think the implementation requirements end up being
> the same either way:
> 
>   https://www.amd.com/system/files/TechDocs/24593.pdf

Looks like you wanted restricted memfd to be backed by secretmem rather
then normal memfd. It would help preserve directmap.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
