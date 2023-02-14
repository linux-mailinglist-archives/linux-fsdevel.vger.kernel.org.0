Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E42696C66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 19:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbjBNSHy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 13:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbjBNSHv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:07:51 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF9B2FCF4
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 10:07:30 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-50e79ffba49so165970337b3.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 10:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wX05IVkHj3QBCA1mIon81shk3MJEJQ/4hz193u4oHCc=;
        b=Dt+QCXEL/j2OVlYZG+8qwoo88m8d8gSqPp1DJoQ+IGJpPuoZGZ7SYYDdYB8+yJ3eDl
         jeP6IZHDHerpXSU/A3lwaLOqhRFKoFsgEci4P2KArqSNVmooBA2C7+kM9EYWXXJTyLae
         Xg1dZ+EziJ8yGcFploTgi9FMPrPslHsMYXReHQVo9CBAaIj0P6zc7wVMCM6iWLSQwSfv
         rIpX9OdI9ocknhGSMghX+77PCRzZY4cpQYWxW05GrdrgU5xkG+PmVmF6RvgPoyIDvsRh
         kG8ONtGxcufDvuzLkSW/HaWjLqmZO3eUfiS87W6x7qkvY49eByyFST1j571DlgUotIiS
         /nZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wX05IVkHj3QBCA1mIon81shk3MJEJQ/4hz193u4oHCc=;
        b=wfzsuDjzyGihM/iqX+AxymoIDA8lkAxww7qgJRur7YUG0sYibKCKxS5fpenVWqLMFp
         JHoUw1WXRnrfhRv4a/yMOSagy6zQfXB9YLYJARTtX2EO5QWwlaKno4f2H98ZpDEQ4F/D
         ZCxZVkXF8SX1TDfmLbz3vSPzwawkUD9Ubi/aXrZLZfKhcIvJSgT6Gb/2eWfZ06U5dLLh
         wsgpwKrxgSJsiZ5OMpWMV23DWUbt8P9/599F8qTnhRmoM+TVhHT0zzo+Go7jUY9xoSpC
         Q+c41l6FHHCsUigo0eyl6suuUMw9uLAlUkjqOlQQ4YW5gv8TOg1jIMxqed1cq5rt4QMU
         8W3A==
X-Gm-Message-State: AO0yUKVxUdG2lzklHTgje0DA4B2TbmsH49OyBicIskBzujues7J/AH+b
        KTGrM7/DKSlwIS6MX86Q8BwQTj63fTs=
X-Google-Smtp-Source: AK7set+EI7pNBbm5Gukj5zYQbLZVnpf4V0D4zMPyPaLWe/aBZALXoW94wxCwwjPKImE/Ubi3qEmpRmHjMf0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:dd0a:0:b0:52a:9490:4f66 with SMTP id
 e10-20020a81dd0a000000b0052a94904f66mr350779ywn.56.1676398049608; Tue, 14 Feb
 2023 10:07:29 -0800 (PST)
Date:   Tue, 14 Feb 2023 10:07:28 -0800
In-Reply-To: <20230213235343.GC4175971@ls.amr.corp.intel.com>
Mime-Version: 1.0
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-3-chao.p.peng@linux.intel.com> <20230209072529.GB4175971@ls.amr.corp.intel.com>
 <Y+WRUriIoan/XChx@google.com> <20230213235343.GC4175971@ls.amr.corp.intel.com>
Message-ID: <Y+vN4L3N6f3fFlgA@google.com>
Subject: Re: [PATCH v10 2/9] KVM: Introduce per-page memory attributes
From:   Sean Christopherson <seanjc@google.com>
To:     Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
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
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 13, 2023, Isaku Yamahata wrote:
> On Fri, Feb 10, 2023 at 12:35:30AM +0000,
> Sean Christopherson <seanjc@google.com> wrote:
> 
> > On Wed, Feb 08, 2023, Isaku Yamahata wrote:
> > > On Fri, Dec 02, 2022 at 02:13:40PM +0800,
> > > Chao Peng <chao.p.peng@linux.intel.com> wrote:
> > > 
> > > > +static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
> > > > +					   struct kvm_memory_attributes *attrs)
> > > > +{
> > > > +	gfn_t start, end;
> > > > +	unsigned long i;
> > > > +	void *entry;
> > > > +	u64 supported_attrs = kvm_supported_mem_attributes(kvm);
> > > > +
> > > > +	/* flags is currently not used. */
> > > > +	if (attrs->flags)
> > > > +		return -EINVAL;
> > > > +	if (attrs->attributes & ~supported_attrs)
> > > > +		return -EINVAL;
> > > > +	if (attrs->size == 0 || attrs->address + attrs->size < attrs->address)
> > > > +		return -EINVAL;
> > > > +	if (!PAGE_ALIGNED(attrs->address) || !PAGE_ALIGNED(attrs->size))
> > > > +		return -EINVAL;
> > > > +
> > > > +	start = attrs->address >> PAGE_SHIFT;
> > > > +	end = (attrs->address + attrs->size - 1 + PAGE_SIZE) >> PAGE_SHIFT;
> > > > +
> > > > +	entry = attrs->attributes ? xa_mk_value(attrs->attributes) : NULL;
> > > > +
> > > > +	mutex_lock(&kvm->lock);
> > > > +	for (i = start; i < end; i++)
> > > > +		if (xa_err(xa_store(&kvm->mem_attr_array, i, entry,
> > > > +				    GFP_KERNEL_ACCOUNT)))
> > > > +			break;
> > > > +	mutex_unlock(&kvm->lock);
> > > > +
> > > > +	attrs->address = i << PAGE_SHIFT;
> > > > +	attrs->size = (end - i) << PAGE_SHIFT;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +#endif /* CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES */
> > > > +
> > > 
> > > If memslot isn't private, it should return error if private attribute is set.
> > 
> > Why?  I'd rather keep the two things separate.  If we enforce this sort of thing
> > at KVM_SET_MEMORY_ATTRIBUTES, then we also have to enforce it at
> > KVM_SET_USER_MEMORY_REGION.
> 
> For device assignment via shared GPA, non-private memory slot needs to be
> allowed.

That doesn't say anything about why setting attributes needs to poke into the
memslot.  The page fault path already kicks out to userspace if there's a
discrepancy between the attributes and the memslot, why is that insufficient?
