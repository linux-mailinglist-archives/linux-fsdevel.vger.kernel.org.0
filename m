Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682FD63BECE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 12:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiK2LV5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 06:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiK2LV4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:21:56 -0500
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F67F53EF9;
        Tue, 29 Nov 2022 03:21:54 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 2533C2B0677F;
        Tue, 29 Nov 2022 06:21:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 29 Nov 2022 06:21:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1669720905; x=1669728105; bh=at
        8ufqDNaxbmVHg+nxQPls4+sUqFCV/uGf26OnoE264=; b=Uj0LUC+Th7V+VSL3Wv
        EdqIQhblOE9VM+4KQiTy8MVpYzh8ghDALZwrhRGXHOI41QY5rn86ft3C4ExaJyFw
        tpZeWaahScbyUrqpTrXSNOt014NNHT58TDP2ao1Wb8+zhuAMCd3tKvbmKq5xEZvw
        GRQNm0PlT5nV6l/SQmT1WSgtxEzBzyg7Uw76OZaEbeZlr0RR1N7H0qU2xhe25qz3
        nTwhHj01In7y5FlApU2+5t/BrzszBnn8zjqUmq+gYMh5HF69wbQRGbiMModAc+3r
        cbwLnW72xQF6j87tlPn2Xd7bgEpwCWRQu6wNpPmYi6Jhqvyd/OXiUqiykUpgjcor
        EgIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669720905; x=1669728105; bh=at8ufqDNaxbmVHg+nxQPls4+sUqF
        CV/uGf26OnoE264=; b=TuZpLKLMppDOmkhizhwn1gXseM7dGDauNCFvwOOmVHx8
        pnYle/wmPZ1A+qeWsnf+7PZ8+lMCV3kMizSjcRfwnDjo05HDZwKa2TeI7ZwH+eoO
        YzoXC72/rc3zc9dOzTRT/HcIcdhxZcFN+v0cnq26O/FyC56F0qdhPTvGWdY6X5Qa
        Hv8jlMOos5zuYL9IhpNNgcitN3LW5+LGtB9JddVw58/wT4IYapD832z243xQj7sn
        qs2hNx6vJs1mUi6fBWSiihWL29Z7Ilg5XOPf+mMhSvZ4mmdiLYySRjCaFuWk4qxg
        LgDouMrJdkLCqppqW881D8aWLT+dgl/3Rjaqsw4IpQ==
X-ME-Sender: <xms:R-uFY0QzbLeoSKoAlkAq6pdKJ7HpMrLqiWy3118_gmS3L3bA0Pmd7A>
    <xme:R-uFYxwIx9EyfMUsYG0cW3-FsW47K_fzK_YlcLJJ1BwdfQ4BDoZkkNMoTlQ6cwP5c
    LiB-wsvYS2yStuFvv4>
X-ME-Received: <xmr:R-uFYx30N9zkFU7156fAB07S_Cv9qNI4M7a1qLZPCcwEfrBVbaXsxkztIaS0Dx4-k_sOxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrjeeggddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueehtedt
    tdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:R-uFY4BqxH63XPqRmjg_R04J8UTRl_p20z9c5BYg744mlIjKWEYdBA>
    <xmx:R-uFY9gclNuv-uxuE7QdwizjoOG-LQKbWfndnp9ime1Ke4uaddCbLQ>
    <xmx:R-uFY0r0APjq-Sa-AeWZeqZNUjzmln5tKTwYBQ_0JYJoWZhr2aow3g>
    <xmx:SeuFYxc9K6tiHQdiGlqUGR-x_tz5oQblJEYLMmc2RXaa7pgtSMi6l7xkSCw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Nov 2022 06:21:42 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id A8A4810454E; Tue, 29 Nov 2022 14:21:39 +0300 (+03)
Date:   Tue, 29 Nov 2022 14:21:39 +0300
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
Message-ID: <20221129112139.usp6dqhbih47qpjl@box.shutemov.name>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-2-chao.p.peng@linux.intel.com>
 <20221129000632.sz6pobh6p7teouiu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129000632.sz6pobh6p7teouiu@amd.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 28, 2022 at 06:06:32PM -0600, Michael Roth wrote:
> On Tue, Oct 25, 2022 at 11:13:37PM +0800, Chao Peng wrote:
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > 
> 
> <snip>
> 
> > +static struct file *restrictedmem_file_create(struct file *memfd)
> > +{
> > +	struct restrictedmem_data *data;
> > +	struct address_space *mapping;
> > +	struct inode *inode;
> > +	struct file *file;
> > +
> > +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> > +	if (!data)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	data->memfd = memfd;
> > +	mutex_init(&data->lock);
> > +	INIT_LIST_HEAD(&data->notifiers);
> > +
> > +	inode = alloc_anon_inode(restrictedmem_mnt->mnt_sb);
> > +	if (IS_ERR(inode)) {
> > +		kfree(data);
> > +		return ERR_CAST(inode);
> > +	}
> > +
> > +	inode->i_mode |= S_IFREG;
> > +	inode->i_op = &restrictedmem_iops;
> > +	inode->i_mapping->private_data = data;
> > +
> > +	file = alloc_file_pseudo(inode, restrictedmem_mnt,
> > +				 "restrictedmem", O_RDWR,
> > +				 &restrictedmem_fops);
> > +	if (IS_ERR(file)) {
> > +		iput(inode);
> > +		kfree(data);
> > +		return ERR_CAST(file);
> > +	}
> > +
> > +	file->f_flags |= O_LARGEFILE;
> > +
> > +	mapping = memfd->f_mapping;
> > +	mapping_set_unevictable(mapping);
> > +	mapping_set_gfp_mask(mapping,
> > +			     mapping_gfp_mask(mapping) & ~__GFP_MOVABLE);
> 
> Is this supposed to prevent migration of pages being used for
> restrictedmem/shmem backend?

Yes, my bad. I expected it to prevent migration, but it is not true.

Looks like we need to bump refcount in restrictedmem_get_page() and reduce
it back when KVM is no longer use it.

Chao, could you adjust it?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
