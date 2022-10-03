Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBAA5F2F3B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Oct 2022 13:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiJCLBo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 07:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiJCLBl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 07:01:41 -0400
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D102711;
        Mon,  3 Oct 2022 04:01:40 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 1427B2B0693A;
        Mon,  3 Oct 2022 07:01:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 03 Oct 2022 07:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1664794895; x=1664802095; bh=zW
        dvG4+iogw6diIyocCUGRkeH6TacYI7IEyT3UtjbNg=; b=XW0tQq+0FScqGFQ+dF
        EG6F8k62Rsx9LqjjPoMSaTzwILoz+/n7fDSAlh7WYeR96n8T61QlRplQ1RwjHMcl
        5yeu/5/d9DsmVOkrwscLBOVYwK//hEwVRqSGfyOxvyaN6fDU3U9/Ul0OAyquCK4L
        zRmP8Y/FYnAIVSX/EEgAEL/OVuR+e1x1q141vTbhzYa4Xr1+1qkB9dSxrZodeJSv
        47Gsq3Ji5dnuN5ybt15lYTZBO4OY32j0R3nw90tsm7yRM3eI40KVNN4uiQQID7lJ
        hQ73LO0XlNe44SV2CPb3saKmbWbVBGNI34ILjrBrcE4C2D0m6MgnGajRH8sJJMcx
        k74Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664794895; x=1664802095; bh=zWdvG4+iogw6diIyocCUGRkeH6Ta
        cYI7IEyT3UtjbNg=; b=1sNbOr+reC4ozopaOlqM0nB+iKaIJWlgEvuSnvehqupR
        +mlBVJgNgylpAZCIvqFPaIK2WPBApah/unlsgtS4kvfqTaq0BXfmuOgDyqL7ZnIQ
        N4SHAmIclsBSegb6mvH9c6U6qgmglracDnl3H9l2JEzJ06uiMWBbM0OB6YGGTfWD
        xnzX8C09pcaBkEsrBGKxi6+eppftTXbcrP0y67raFiRetpglM6SEeybTggLt0Jxu
        nY7ma+CNPCBaDHOqaNh+TyiGfPgg6QbqgPqtYrZHB34i7u4TRk5W/6Bl6YElrJmP
        flUk+OkuovZLsxzhxLvWeLYpKvAWNhY6chI73rMRtg==
X-ME-Sender: <xms:DcE6Y6f52k5yy0Jlg1AeQ7dDWJCrmyiSx6kROu3hIkspfTGHK9TTRw>
    <xme:DcE6Y0Nyco_uRp-K-WwZKELvbqi_T8WM-Zrx3OOkmBhxAu7gSWznB0GrnN29DXbFT
    2-3FfUfe9_RpTMbUxY>
X-ME-Received: <xmr:DcE6Y7gwh0050G_SwvT6qpZdBhwZjbBFjdHUuyL-6_rWH_mMo2iv_wfLg4oCQTj36_KCxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehledgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:DcE6Y3962DbaiPjQuEqjImm6i_1iQb_fS9v9CvfrtqHzYR-gAxDkXQ>
    <xmx:DcE6Y2sGkiMEPQ8rZ-eMFeI2-zb7XvW71RUslSW8I3M3jgj-wl-pxQ>
    <xmx:DcE6Y-F5e4wRoyMQiP3Pv56Fi1Qf4Te9r2uZ0-YIquinDsLq-5Ao1w>
    <xmx:D8E6YzreQvrnUZwE5JTwmdtxSOE-mJJ5MYLVoAkceXUT8tLhySzNUatLQXA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Oct 2022 07:01:33 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 87A6C104CE4; Mon,  3 Oct 2022 14:01:29 +0300 (+03)
Date:   Mon, 3 Oct 2022 14:01:29 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Fuad Tabba <tabba@google.com>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
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
        Hugh Dickins <hughd@google.com>,
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
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
Message-ID: <20221003110129.bbee7kawhw5ed745@box.shutemov.name>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com>
 <CA+EHjTyrexb_LX7Jm9-MGwm4DBvfjCrADH4oumFyAvs2_0oSYw@mail.gmail.com>
 <20220930162301.i226o523teuikygq@box.shutemov.name>
 <CA+EHjTyphrouY1FV2NQOBLDG81JYhiHFGBNKjT1K2j+pVNij+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTyphrouY1FV2NQOBLDG81JYhiHFGBNKjT1K2j+pVNij+A@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 03, 2022 at 08:33:13AM +0100, Fuad Tabba wrote:
> > I think it is "don't do that" category. inaccessible_register_notifier()
> > caller has to know what file it operates on, no?
> 
> The thing is, you could oops the kernel from userspace. For that, all
> you have to do is a memfd_create without the MFD_INACCESSIBLE,
> followed by a KVM_SET_USER_MEMORY_REGION using that as the private_fd.
> I ran into this using my port of this patch series to arm64.

My point is that it has to be handled on a different level. KVM has to
reject private_fd if it is now inaccessible. It should be trivial by
checking file->f_inode->i_sb->s_magic.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
