Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD945EABDB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 18:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbiIZQBV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 12:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbiIZQAj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:00:39 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632F45FAB;
        Mon, 26 Sep 2022 07:49:02 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 032D7580B47;
        Mon, 26 Sep 2022 10:49:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 26 Sep 2022 10:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1664203739; x=1664210939; bh=hj
        yaiyVncGPyAcE40V9D6BFeUzHrJx4Z5KsQEWvTx6U=; b=BLkeAJVrmw7qkBJfm/
        r53DCtBwngiqsuCp5gakhvZnWCECk6zFydkZLbd6I8KxKeonxY3Gm2ku4yAZq3DX
        mPH+dIkbEqtuCewZbPVPywT1t0sXTaj/vq5aWDsA3hnT3F2YHzOqpGx2urUlL2EE
        U/hsjExpJ6BXKte28MPI5f1X6kuOVEYyYkbgR5w4fjqPJgjr0ryrQrGWgyK8slPz
        V/GfWGk7sO7BfhbizEnnaZSoWp2rG5Ulecm6xMUgTQ/3Ts/kUndBbbKfd96QtbpK
        y35I54Zb50espMcXYT+wIyCvf2tgXT1nBc1qW+qbQ7b9KMnF2w45hTyMQ89w4C0O
        Z9XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664203739; x=1664210939; bh=hjyaiyVncGPyAcE40V9D6BFeUzHr
        Jx4Z5KsQEWvTx6U=; b=BaxqKASgIiPw7rncxCNijATsatPiyiSIoD2+I/65CLct
        UspOGb5FxKqzGRfzDSh/1qeoclfaerzVKVPkO7dTdAv6IAGsbKNmy/SPFTmF7jhG
        Exx30tbN5Diyf5+E0W3bbdGQCcMN7mN/w6o2fRRAfCHlkk8Xue3EdsTbGmzJ62gQ
        gYN7Xpcg3R0YPsq5pkPdB0omh+B0Bunz5x5wCqzDQx8hectKi6K7L8H2ynFFDGWH
        VoDwHTyQpwEIBYhcy/LGZUvL4O6aToBkJ3zMlQsX5z51hh8mbTuDd5nIXCjXUStv
        nChvh3skGQpP75NdIiZ8rjn+N8NVQM/ev7r6o/yLaA==
X-ME-Sender: <xms:2bsxY-fzVVgOSVkALZI2OVCKASwpUjzbjR6aAGpsnVyW63SMm5Vtug>
    <xme:2bsxY4N_pEiU97FgSNW0GriJk0H3G84tHuEVpxndgJMxnEIIYmtaU4MR3e4dAbwPI
    sv-S1KQMJ7h2dBbTHg>
X-ME-Received: <xmr:2bsxY_hUvtYjlt7DSbTT3VXW4DBkdShIS8oE1NjaR3uPbwqkWUXDbNtAH_JA71VGuD1gYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegvddgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeelgffhfeetlefhveffleevfffgtefffeelfedu
    udfhjeduteeggfeiheefteehjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhl
    sehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:2bsxY79p5Bg7bBcj2zf51nOCacE_d6LY_iKftMbFR0YSBz7P1oPu4A>
    <xmx:2bsxY6tkmioEyZ3Xt6KMXykJ_l9Z6Kx88E2ToRh1Gd2TnUpV6JSkdg>
    <xmx:2bsxYyEbuXJ92o_6TphZvfKQchwxuaRYR7_NS3gg_W9x_iLq1h20xg>
    <xmx:27sxY5qnsOBTDIeLJkdMV8asI5QTcnn829r0jRRM6aS0fx6f6qZmYw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Sep 2022 10:48:57 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 03E28104928; Mon, 26 Sep 2022 17:48:54 +0300 (+03)
Date:   Mon, 26 Sep 2022 17:48:54 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
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
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        aarcange@redhat.com, ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
Message-ID: <20220926144854.dyiacztlpx4fkjs5@box.shutemov.name>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com>
 <d16284f5-3493-2892-38e6-f1fa5c10bdbb@redhat.com>
 <20220923005808.vfltoecttoatgw5o@box.shutemov.name>
 <f703e615-3b75-96a2-fb48-2fefd8a2069b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f703e615-3b75-96a2-fb48-2fefd8a2069b@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 26, 2022 at 12:35:34PM +0200, David Hildenbrand wrote:
> On 23.09.22 02:58, Kirill A . Shutemov wrote:
> > On Mon, Sep 19, 2022 at 11:12:46AM +0200, David Hildenbrand wrote:
> > > > diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> > > > index 6325d1d0e90f..9d066be3d7e8 100644
> > > > --- a/include/uapi/linux/magic.h
> > > > +++ b/include/uapi/linux/magic.h
> > > > @@ -101,5 +101,6 @@
> > > >    #define DMA_BUF_MAGIC		0x444d4142	/* "DMAB" */
> > > >    #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
> > > >    #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
> > > > +#define INACCESSIBLE_MAGIC	0x494e4143	/* "INAC" */
> > > 
> > > 
> > > [...]
> > > 
> > > > +
> > > > +int inaccessible_get_pfn(struct file *file, pgoff_t offset, pfn_t *pfn,
> > > > +			 int *order)
> > > > +{
> > > > +	struct inaccessible_data *data = file->f_mapping->private_data;
> > > > +	struct file *memfd = data->memfd;
> > > > +	struct page *page;
> > > > +	int ret;
> > > > +
> > > > +	ret = shmem_getpage(file_inode(memfd), offset, &page, SGP_WRITE);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	*pfn = page_to_pfn_t(page);
> > > > +	*order = thp_order(compound_head(page));
> > > > +	SetPageUptodate(page);
> > > > +	unlock_page(page);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(inaccessible_get_pfn);
> > > > +
> > > > +void inaccessible_put_pfn(struct file *file, pfn_t pfn)
> > > > +{
> > > > +	struct page *page = pfn_t_to_page(pfn);
> > > > +
> > > > +	if (WARN_ON_ONCE(!page))
> > > > +		return;
> > > > +
> > > > +	put_page(page);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(inaccessible_put_pfn);
> > > 
> > > Sorry, I missed your reply regarding get/put interface.
> > > 
> > > https://lore.kernel.org/linux-mm/20220810092532.GD862421@chaop.bj.intel.com/
> > > 
> > > "We have a design assumption that somedays this can even support non-page
> > > based backing stores."
> > > 
> > > As long as there is no such user in sight (especially how to get the memfd
> > > from even allocating such memory which will require bigger changes), I
> > > prefer to keep it simple here and work on pages/folios. No need to
> > > over-complicate it for now.
> > 
> > Sean, Paolo , what is your take on this? Do you have conrete use case of
> > pageless backend for the mechanism in sight? Maybe DAX?
> 
> The problem I'm having with this is how to actually get such memory into the
> memory backend (that triggers notifiers) and what the semantics are at all
> with memory that is not managed by the buddy.
> 
> memfd with fixed PFNs doesn't make too much sense.

What do you mean by "fixed PFN". It is as fixed as struct page/folio, no?
PFN covers more possible backends.

> When using DAX, what happens with the shared <->private conversion? Which
> "type" is supposed to use dax, which not?
> 
> In other word, I'm missing too many details on the bigger picture of how
> this would work at all to see why it makes sense right now to prepare for
> that.

IIUC, KVM doesn't really care about pages or folios. They need PFN to
populate SEPT. Returning page/folio would make KVM do additional steps to
extract PFN and one more place to have a bug.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
