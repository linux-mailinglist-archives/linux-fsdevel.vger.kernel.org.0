Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC65530074
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 06:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbiEVEDf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 00:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiEVEDb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 00:03:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DF93E5CD;
        Sat, 21 May 2022 21:03:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74D05B80AC0;
        Sun, 22 May 2022 04:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279FEC34116;
        Sun, 22 May 2022 04:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653192207;
        bh=H8VxeRRGU1YvvB/gDGQdsDIur//wMHZ+GBccWBSTA4s=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=ogO7bURGMZjZY7Se7Ca+PlvmooeylSGOcmEVhlOvBfxQ6eNBOuYSlc7lye/lzX1gw
         oSZpH68lcUNhCGBQPbOoCPttQczz9lqiGvLSS7zpjlBVCKhlvLJT8sgEYqFORXxr88
         LMa7WENGD63Rs+0T7UBliYzNh0naPxCDjvfVYxbFM53JAyW+3GAlREGLSiBfnCMvU1
         LRmIXsOvNqqm3Z7p8jDzMg8ntEJaWd8QxCHVKjPWh48mnpAzrD3Va7p6rC5eMABYu0
         X/VekAVyZqB/w/yNgdEOTq2RhTUrVFjxKVBv0le1cPXUJ6sXoz0egBoAsTMe93KYsW
         vVtz8zIpWIjmw==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id E57B027C0054;
        Sun, 22 May 2022 00:03:24 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Sun, 22 May 2022 00:03:24 -0400
X-ME-Sender: <xms:C7aJYqXjGfM4wQuodo607NjCU7PYVCu2Nf4CmUoeKrg1BJLSx7XzZg>
    <xme:C7aJYmlHnv72dQ8EoYnKirE_LOZ3kTXO40X-kdOe5RXnWn49nNecmEywlY7yQopLh
    28ExrBKGpBdj_3Cstk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrieejgdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedvhfeuvddthfdufffhkeekffetgffhledtleegffetheeugeejffdu
    hefgteeihfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeeh
    ieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugi
    drlhhuthhordhush
X-ME-Proxy: <xmx:C7aJYuYVuXc6-n2rtnHJr-4hXRuGMt2-n6Fi-6i-PRQbwWRrklD5pQ>
    <xmx:C7aJYhVjZixJLh_aI5dYUZ-ppl2q-9UUAw-iaNwXiutFsbo6JXT1jg>
    <xmx:C7aJYknSPK7hrO2kEN3oZsQQWBSL9WHgDO8QD1SQXxvC326OwMbEKA>
    <xmx:DLaJYuvHWMkfc_q-57cYIYJF2SXVodDLkZm9p2keZbWlQiDzjMXLE8biMqU>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3F6EB31A005D; Sun, 22 May 2022 00:03:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-591-gfe6c3a2700-fm-20220427.001-gfe6c3a27
Mime-Version: 1.0
Message-Id: <f0f9c66d-ae94-4eb1-b7e5-6a0a9f0d4798@www.fastmail.com>
In-Reply-To: <YofeZps9YXgtP3f1@google.com>
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <20220519153713.819591-5-chao.p.peng@linux.intel.com>
 <8840b360-cdb2-244c-bfb6-9a0e7306c188@kernel.org>
 <YofeZps9YXgtP3f1@google.com>
Date:   Sat, 21 May 2022 21:03:01 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Sean Christopherson" <seanjc@google.com>
Cc:     "Chao Peng" <chao.p.peng@linux.intel.com>,
        "kvm list" <kvm@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        "Linux API" <linux-api@vger.kernel.org>, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, "Paolo Bonzini" <pbonzini@redhat.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
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
        "Mike Rapoport" <rppt@kernel.org>,
        "Steven Price" <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Vishal Annapurve" <vannapurve@google.com>,
        "Yu Zhang" <yu.c.zhang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        "David Hildenbrand" <david@redhat.com>, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        "Quentin Perret" <qperret@google.com>,
        "Michael Roth" <michael.roth@amd.com>,
        "Michal Hocko" <mhocko@suse.com>
Subject: Re: [PATCH v6 4/8] KVM: Extend the memslot to support fd-based private memory
Content-Type: text/plain
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Fri, May 20, 2022, at 11:31 AM, Sean Christopherson wrote:

> But a dedicated KVM ioctl() to add/remove shared ranges would be easy 
> to implement
> and wouldn't necessarily even need to interact with the memslots.  It 
> could be a
> consumer of memslots, e.g. if we wanted to disallow registering regions 
> without an
> associated memslot, but I think we'd want to avoid even that because 
> things will
> get messy during memslot updates, e.g. if dirty logging is toggled or a 
> shared
> memory region is temporarily removed then we wouldn't want to destroy 
> the tracking.
>
> I don't think we'd want to use a bitmap, e.g. for a well-behaved guest, XArray
> should be far more efficient.
>
> One benefit to explicitly tracking this in KVM is that it might be 
> useful for
> software-only protected VMs, e.g. KVM could mark a region in the XArray 
> as "pending"
> based on guest hypercalls to share/unshare memory, and then complete 
> the transaction
> when userspace invokes the ioctl() to complete the share/unshare.

That makes sense.

If KVM goes this route, perhaps there the allowed states for a GPA should include private, shared, and also private-and-shared.  Then anyone who wanted to use the same masked GPA for shared and private on TDX could do so if they wanted to.
