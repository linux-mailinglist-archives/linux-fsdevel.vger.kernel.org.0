Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704094BA94E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 20:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245013AbiBQTKR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 14:10:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243867AbiBQTKQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:10:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5ED385678;
        Thu, 17 Feb 2022 11:10:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 431D761C7B;
        Thu, 17 Feb 2022 19:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A45C340EB;
        Thu, 17 Feb 2022 19:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645125000;
        bh=ak4f1IR3JDauRmqw+Ocnj7LciaJgX2pj5SekEDDFUWI=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=lvU0WOO7K9Hu3jpQEoQdykFWOeJkwK5YSzfr3pjVbg1el5417PRg02Pick+MlEGpN
         MEpDmxkNmZrSTji+4ogBj2o2IbCelGEu036iVOdZXEkPdHdZ2glKe6ogosYUm5F9HT
         gDM/BdAuWREwPXQ95pWYd4GdFZ3+k/DOUtEbXcTSSBRj9CrZcC43BdffBWtNxM8YeC
         6yq8iOdFwmjojXKG9BCONmQDeR8kW5H9TOY63x2JbOZ3SsxVOEuNlnbFSzLO8rRtJ9
         B6NnTxNVZnUWBrpO7D/xkCA/CAbXn4aQruPnMT1/fPRsSMe7g5lExjyihShVILWY7G
         jcgxVgwJMEg+g==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 22D2E27C0054;
        Thu, 17 Feb 2022 14:09:57 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute5.internal (MEProxy); Thu, 17 Feb 2022 14:09:58 -0500
X-ME-Sender: <xms:hJ0OYhfhcmP29_Nr736Rf_VR4Xx9AacSXN14ybFA7qE5VnfQw2k6UQ>
    <xme:hJ0OYvOcTkmAsvXFyzQM7abAFdGjOKqUwdKUufgnJTzNWmIqVnsewZPeBu9zKKj7i
    UP8-svOYeSuuoTfYFo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeekgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedthfehtedtvdetvdetudfgueeuhfdtudegvdelveelfedvteelfffg
    fedvkeegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeeh
    ieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugi
    drlhhuthhordhush
X-ME-Proxy: <xmx:hJ0OYqh93zilhV36T3x1IBn9k-SuRB2m7ja01WV-VG3usyRPRUjl4w>
    <xmx:hJ0OYq_c0M0zS_-AqS7M6zHUbF53D4l6HsGQ7ZYCK1rxjXgarQM5bw>
    <xmx:hJ0OYtv0yrfYhSsvcFG55K3UtDbwJrTNB47JETg155Pixxqq5yvUJg>
    <xmx:hZ0OYhDilIaXT5yqAtBRSRwJg78QQdEAKf1oXJTOOymblLEqORlaWM_YpTY>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3BF2F21E006E; Thu, 17 Feb 2022 14:09:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4778-g14fba9972e-fm-20220217.001-g14fba997
Mime-Version: 1.0
Message-Id: <2ca78dcb-61d9-4c9d-baa9-955b6f4298bb@www.fastmail.com>
In-Reply-To: <20220217130631.GB32679@chaop.bj.intel.com>
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
 <20220118132121.31388-2-chao.p.peng@linux.intel.com>
 <619547ad-de96-1be9-036b-a7b4e99b09a6@kernel.org>
 <20220217130631.GB32679@chaop.bj.intel.com>
Date:   Thu, 17 Feb 2022 11:09:35 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Chao Peng" <chao.p.peng@linux.intel.com>
Cc:     "kvm list" <kvm@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org, "Linux API" <linux-api@vger.kernel.org>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Sean Christopherson" <seanjc@google.com>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        "Wanpeng Li" <wanpengli@tencent.com>,
        "Jim Mattson" <jmattson@google.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Hugh Dickins" <hughd@google.com>,
        "Jeff Layton" <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Yu Zhang" <yu.c.zhang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        "David Hildenbrand" <david@redhat.com>
Subject: Re: [PATCH v4 01/12] mm/shmem: Introduce F_SEAL_INACCESSIBLE
Content-Type: text/plain
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 17, 2022, at 5:06 AM, Chao Peng wrote:
> On Fri, Feb 11, 2022 at 03:33:35PM -0800, Andy Lutomirski wrote:
>> On 1/18/22 05:21, Chao Peng wrote:
>> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>> > 
>> > Introduce a new seal F_SEAL_INACCESSIBLE indicating the content of
>> > the file is inaccessible from userspace through ordinary MMU access
>> > (e.g., read/write/mmap). However, the file content can be accessed
>> > via a different mechanism (e.g. KVM MMU) indirectly.
>> > 
>> > It provides semantics required for KVM guest private memory support
>> > that a file descriptor with this seal set is going to be used as the
>> > source of guest memory in confidential computing environments such
>> > as Intel TDX/AMD SEV but may not be accessible from host userspace.
>> > 
>> > At this time only shmem implements this seal.
>> > 
>> 
>> I don't dislike this *that* much, but I do dislike this. F_SEAL_INACCESSIBLE
>> essentially transmutes a memfd into a different type of object.  While this
>> can apparently be done successfully and without races (as in this code),
>> it's at least awkward.  I think that either creating a special inaccessible
>> memfd should be a single operation that create the correct type of object or
>> there should be a clear justification for why it's a two-step process.
>
> Now one justification maybe from Stever's comment to patch-00: for ARM
> usage it can be used with creating a normal memfd, (partially)populate
> it with initial guest memory content (e.g. firmware), and then
> F_SEAL_INACCESSIBLE it just before the first time lunch of the guest in
> KVM (definitely the current code needs to be changed to support that).

Except we don't allow F_SEAL_INACCESSIBLE on a non-empty file, right?  So this won't work.

In any case, the whole confidential VM initialization story is a bit buddy.  From the earlier emails, it sounds like ARM expects the host to fill in guest memory and measure it.  From my recollection of Intel's scheme (which may well be wrong, and I could easily be confusing it with SGX), TDX instead measures what is essentially a transcript of the series of operations that initializes the VM.  These are fundamentally not the same thing even if they accomplish the same end goal.  For TDX, we unavoidably need an operation (ioctl or similar) that initializes things according to the VM's instructions, and ARM ought to be able to use roughly the same mechanism.

Also, if we ever get fancy and teach the page allocator about memory with reduced directmap permissions, it may well be more efficient for userspace to shove data into a memfd via ioctl than it is to mmap it and write the data.
