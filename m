Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C6C5B7784
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 19:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiIMROx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 13:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbiIMROS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:14:18 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F4A101D4;
        Tue, 13 Sep 2022 09:02:58 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id CC1605802D8;
        Tue, 13 Sep 2022 12:00:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 13 Sep 2022 12:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1663084851; x=1663092051; bh=nR
        H4z7e+oXA2SkZv/m8JgJqSDk7nulXrp2QoWv1YEN4=; b=XM4CuKJtTWDLoARjMU
        ZEoD6wB5FqnJdSnY3AUy+IO++7ZeMKuIGV7uzlq8uSGUd+dk9chibkWCsvDK8GNY
        lUXAlf7MPuPfea2V80ipCokGbqWGe90/O4izA17lU44CEqmslzDymGWi8CmFigUv
        /1pt2fDthxiWGh3J8mgjWfumcmOTyZXvfPJoP6Id6cvvaavU+5xrsA9EhZpt5Euf
        aywjzWe1+3TbO7Nv8QkUYFPgV+AlIEB+1KFSYXFxjZDIPVazeJogLXHgNC4ex0Ea
        /IlPGW+cYL0/VjUf6NiNk6Okczw8aRTkqyNAGpU2Ezuj6KQd9nYmPgjUi1it7PhV
        upFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663084851; x=1663092051; bh=nRH4z7e+oXA2SkZv/m8JgJqSDk7n
        ulXrp2QoWv1YEN4=; b=L9Yl22VBFNLeetc6fSQgTPfXDMKU/Un/Nk3+eIFVPVGM
        jXoMC62j/pqiRCZhTsfDKXXjDf0pwGuFtuMs1+x5MjSaHS9RqdS4IdUUxa93GbGA
        kpWwa4xQFzg0GgHggZDoI/hD1+DFTJ8Y554qKeRFdOTrWvQf98vrayUX4L3sBVbf
        uF2qW1fujBLU6PEAPaHmqdw/urgqhR4LySbsxm1+RXzmoNNVO2rXx1nfscmcdinv
        GAoZo5+589NE8/kQ5NTX+lIcLX4szCiqfW2jXy0gAXNFnk8Eide20Iu/gvidC+XI
        00H5SJY8aaxn8RExcr8e6V6nkwTTQXr4g+Y4SDFVqQ==
X-ME-Sender: <xms:MakgY8Bb_c1hF-G-V0xWPp6v2tFFK59WYo5RW7yO9_bo81elPeCgoA>
    <xme:MakgY-isRLK2xNjFVddU3SuO8bJG_C6SNZa4RK15I9d4SP_yc0hvI3va7iWTOsVZo
    3FaCARM6L7l1xyd5Zk>
X-ME-Received: <xmr:MakgY_lm1icemmPyCRuc9L2e_WJ__1iRM-x3EYy78zCdcr1QKV3cVpWOP2lYACbn3DOrxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedugedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeelgffhfeetlefhveffleevfffgtefffeelfedu
    udfhjeduteeggfeiheefteehjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhl
    sehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:MakgYyz6PLeOqvzrzN5MSngKpLn4PepAjtzzW3M8h49ivJQx919_Qg>
    <xmx:MakgYxTRjdKN_AfcWIfFLJ3MShKx3UaKy8i5hyCqMXeqjxeGHGl_eQ>
    <xmx:MakgY9aZkKdjYf2ydxmqv_7Rz2mI3q82LHYS_E-o9H-iPrDI0ym8hA>
    <xmx:M6kgY4M0E0kvqk7pyaWP0fDgJCM7yLnmmneraumr2YriAtgMkDNi7w>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Sep 2022 12:00:49 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id CDFF310465E; Tue, 13 Sep 2022 19:00:46 +0300 (+03)
Date:   Tue, 13 Sep 2022 19:00:46 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Sean Christopherson <seanjc@google.com>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        "Gupta, Pankaj" <pankaj.gupta@amd.com>,
        Elena Reshetova <elena.reshetova@intel.com>
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <20220913160046.rkz7uh6cpwy6wyzg@box.shutemov.name>
References: <ff5c5b97-acdf-9745-ebe5-c6609dd6322e@google.com>
 <20220818132421.6xmjqduempmxnnu2@box>
 <c6ccbb96-5849-2e2f-3b49-4ea711af525d@google.com>
 <20220820002700.6yflrxklmpsavdzi@box.shutemov.name>
 <c194262b-b634-4baf-abf0-dc727e8f1d7@google.com>
 <20220831142439.65q2gi4g2d2z4ofh@box.shutemov.name>
 <20220908011037.ez2cdorthqxkerwk@box.shutemov.name>
 <YyBQ+wzPtGwwRB/U@google.com>
 <20220913132821.3ch5cv3rgdxqgz3i@box.shutemov.name>
 <YyCZZSyCrwXLLCD9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyCZZSyCrwXLLCD9@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 13, 2022 at 02:53:25PM +0000, Sean Christopherson wrote:
> > > Switching topics, what actually prevents mmapp() on the shim?  I tried to follow,
> > > but I don't know these areas well enough.
> > 
> > It has no f_op->mmap, so mmap() will fail with -ENODEV. See do_mmap().
> > (I did not read the switch statement correctly at first. Note there are
> > two 'fallthrough' there.)
> 
> Ah, validate_mmap_request().  Thought not implementing ->mmap() was the key, but
> couldn't find the actual check.

validate_mmap_request() is in mm/nommu.c which is not relevant for real
computers.

I was talking about this check:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/mmap.c#n1495

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
