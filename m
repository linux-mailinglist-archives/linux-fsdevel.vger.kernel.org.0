Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FE1597A73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 02:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242251AbiHRAAz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 20:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242209AbiHRAAx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 20:00:53 -0400
X-Greylist: delayed 603 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 Aug 2022 17:00:52 PDT
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D2496FC2;
        Wed, 17 Aug 2022 17:00:52 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7B68B580556;
        Wed, 17 Aug 2022 19:41:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 17 Aug 2022 19:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660779685; x=1660786885; bh=NI
        aAYd9poCwuCaReO0KiItjGT5b3278AiQgPlMaoGH8=; b=PuKLpG0lACFDSWgEO8
        rwPWX4M0HQpSuEdYRtGzQptcaolkieS2EgsFIwpoZyncFWpZckNeFIzIIYOqO8zc
        9BpZgvlyinTevkQRn/C/ka6JMZsh8Ts9cHQWdeYq9ybnuk1SQZpubaUGZQB9t1lM
        qk4rSx6j+tUOfRKOd3g94hTTtthwjyy2FqigUkFALmNMXV3xaGruqjoeP5+34xuk
        J1Cinr4a4qem9KNGhx+lzwXQAr8UJisToeNsfhj8HLQwy0xeOfa5U42VQCIa7k9W
        qZ8iK9otGm9LKKwttomxp7Dv3pSQF6Et1ZTaIBSz7M8flKM1wmlzQBaAB4PFaBIk
        k9IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660779685; x=1660786885; bh=NIaAYd9poCwuCaReO0KiItjGT5b3
        278AiQgPlMaoGH8=; b=WGuGDaggU/a6pga7pL9w3WYTfRF/tux3G1kX0A3mQjNG
        OC+VxEFGbO+smOA+p7iGMZ3GoMIsMcaWl3/NDeaFMGDz77QMAzUSQkUiUmCGJkRW
        xHDUodL0TH5AF7G//emEtkunMR0IZ4l2d7XmME00+CIEmSs0g9HkS3qnHI4slsRN
        HLEINl4PWiLW8DvpQUTe/0aF8/PdVhKDH0qkmMtKQaNXy1O+iZNm5MWAKX+BYowx
        KuXbnGKaeKu5x2AZgYGthwUdYmgJrzE5cQQyW5v4ZXRMkJgZP9HwjqtkEwDmOL4I
        VHlt+Z4I/oeTtr+VVKyUXBqBYFKb61xw+pnbo22rNA==
X-ME-Sender: <xms:pHz9YkXNQXrutmOXLT8qKC8bAkDrafNZwTbHHUvk4uGruAWRz8lSXw>
    <xme:pHz9YomAAobQndykgGisfSvrEaUbnwRxPnhjaRnRKcy7rwe8iA--U-9p8AJVY1ht3
    CHYDQX82TnQfowOqrY>
X-ME-Received: <xmr:pHz9YoYoOJJ3U6PUwRm1npi6IHWY-81B3GDPi_Hh-Sh04EiF8v9DMalIOFzMmXc0odStsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehjedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:pHz9YjURvYrPk7ln2G6y5jzbE1QNYYzGLgRztyxiICy4kfvUbUjaNg>
    <xmx:pHz9Yum1Ff9XGpoiOlx7NWmi_AWkZcUFRDXkPoeuriI3uxXSxr406w>
    <xmx:pHz9YodmYF_t-pLZ3YNAgjRYP3doKC47u2BG16XkOANkKS6FtmEg2Q>
    <xmx:pXz9YoADMoiV4yerQswAA91U22gwFiEMHVgZT94HO2C4gO2O9zUMXQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Aug 2022 19:41:23 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id E5075104A77; Thu, 18 Aug 2022 02:41:20 +0300 (+03)
Date:   Thu, 18 Aug 2022 02:41:20 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
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
        ak@linux.intel.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v7 01/14] mm: Add F_SEAL_AUTO_ALLOCATE seal to memfd
Message-ID: <20220817234120.mw2j3cgshmuyo2vw@box.shutemov.name>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-2-chao.p.peng@linux.intel.com>
 <f39c4f63-a511-4beb-b3a4-66589ddb5475@redhat.com>
 <472207cf-ff71-563b-7b66-0c7bea9ea8ad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <472207cf-ff71-563b-7b66-0c7bea9ea8ad@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 05, 2022 at 07:55:38PM +0200, Paolo Bonzini wrote:
> On 7/21/22 11:44, David Hildenbrand wrote:
> > 
> > Also, I*think*  you can place pages via userfaultfd into shmem. Not
> > sure if that would count "auto alloc", but it would certainly bypass
> > fallocate().
> 
> Yeah, userfaultfd_register would probably have to forbid this for
> F_SEAL_AUTO_ALLOCATE vmas.  Maybe the memfile_node can be reused for this,
> adding a new MEMFILE_F_NO_AUTO_ALLOCATE flags?  Then userfault_register
> would do something like memfile_node_get_flags(vma->vm_file) and check the
> result.

I donno, memory allocation with userfaultfd looks pretty intentional to
me. Why would F_SEAL_AUTO_ALLOCATE prevent it?

Maybe we would need it in the future for post-copy migration or something?

Or existing practises around userfaultfd touch memory randomly and
therefore incompatible with F_SEAL_AUTO_ALLOCATE intent?

Note, that userfaultfd is only relevant for shared memory as it requires
VMA which we don't have for MFD_INACCESSIBLE.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
