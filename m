Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207C9616F7E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 22:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiKBVO3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 17:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiKBVOY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:14:24 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AABBC8C;
        Wed,  2 Nov 2022 14:14:14 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id A8C8E2B06827;
        Wed,  2 Nov 2022 17:14:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 02 Nov 2022 17:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1667423649; x=1667430849; bh=ya
        z7HB+tA0RP33F5tMpk/jLLItyrZaFvVEGA2nFMTHI=; b=Ky05TEuWIr83oUh3MP
        VKNL8ENuHV9gUlhetBL9nyBnWkmhW3b7eJIJQvsEX4i8mrWKj7fAD2YoYyBb89E9
        ISKn14UJ31abDLZFWzZCCaQnTLi78oerrmjr+5hmV9sA3hFI3L8ZV1Kiu7AX9QXR
        PDBaluynehd9n3eiw+gtrXx+RWa959jyR7nphlxGnum8rHgJTzq02ZExi1nIGFid
        EJO+kCiPv0YbKVpF7c2OrK1fuI/2gu/r+1T0aqwqS9P/ypb1+DPbh35ga9d9WHYp
        FylKYS+Rg2UR7pBcU7lZ5OPVMq4ERDjJJCu0ll46FiB93Ht82Uh6f5WuN9oIyHug
        tC5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667423649; x=1667430849; bh=yaz7HB+tA0RP33F5tMpk/jLLItyr
        ZaFvVEGA2nFMTHI=; b=kXuKgSJSeQyH8zkQnQLj2ogT1FjQ404UQUbzOXrHjtoL
        O5jybhnZTvUTvWSm0JarvjTauAp3ZsZ+r+wmdYPHpVddWzaXL8v+kKFMg4LptKuU
        za4Nn6AFZHdJ8Ew6kOJjOVtyV+RbvW0VGJP+2xRX3dEy0QIR7itrmJOonvxViJoT
        AoF3E4PNZiUZ9aaP1YucG7Uv9v8Eqwth9//su3HfO8kpjAFt2r6d9BaJJidv+bKw
        mNZEQxt0P2yMJj0u53Zl8vkHso9nSQJzXMgYh5xL1AvTD3D0XGhltZ2SmyCHlpRE
        TQHb95HDxl2N1T/q559g2R0z+nX6Aaenk06fEmM9mA==
X-ME-Sender: <xms:n91iY-Xiau9PyhDECPWzFgSUDYb5YvoQDfa-aFayS-W-TkmT-EE9PQ>
    <xme:n91iY6l1bgFgvYiO7TIQuOyH8InOlHtvWmclxCUM0Brvq0SEJSum6PG8m5a0XQRlh
    XyrODlUak8pt2VGdKM>
X-ME-Received: <xmr:n91iYyZH6tYal8m3G_iR8obDtjV5uHdUdfR2NM2ruYYM4CfTnC6uoZBViw5Wcm_5RZe2Bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudejgddugeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:n91iY1Xbl82GIObQKlhVWjYLikh-vdemfP8sXrF8OKJdnJGBq_55bQ>
    <xmx:n91iY4mFVh0Wa1sREv4w7MfcVUVMVuR6uCI7ESrbU6QB3ckNyn8ixg>
    <xmx:n91iY6eNAqPKPeE5l9TMMHmoRplO_cTttQ8P4OovIUVmAbCtz4rcFQ>
    <xmx:od1iY_xvsCuIie0PpHuS7NS8eqps2ru8p5ovcRyadUjFuTveg1l2617acAo>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Nov 2022 17:14:06 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 5751D104449; Thu,  3 Nov 2022 00:14:04 +0300 (+03)
Date:   Thu, 3 Nov 2022 00:14:04 +0300
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
Message-ID: <20221102211404.l5whyif3j3k67fv2@box.shutemov.name>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-2-chao.p.peng@linux.intel.com>
 <20221031174738.fklhlia5fmaiinpe@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031174738.fklhlia5fmaiinpe@amd.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 31, 2022 at 12:47:38PM -0500, Michael Roth wrote:
> 
> In v8 there was some discussion about potentially passing the page/folio
> and order as part of the invalidation callback, I ended up needing
> something similar for SEV-SNP, and think it might make sense for other
> platforms. This main reasoning is:
> 
>   1) restoring kernel directmap:
> 
>      Currently SNP (and I believe TDX) need to either split or remove kernel
>      direct mappings for restricted PFNs, since there is no guarantee that
>      other PFNs within a 2MB range won't be used for non-restricted
>      (which will cause an RMP #PF in the case of SNP since the 2MB
>      mapping overlaps with guest-owned pages)

That's news to me. Where the restriction for SNP comes from? There's no
such limitation on TDX side AFAIK?

Could you point me to relevant documentation if there's any?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
