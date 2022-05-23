Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FFE531313
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 18:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237788AbiEWPWr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 11:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237757AbiEWPWj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 11:22:39 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936F75DBEA
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 08:22:37 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id nr2-20020a17090b240200b001df2b1bfc40so17813470pjb.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 08:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=alhazuhH7tTd8Xd528vjQZhEVIVEKAWK4HCLXZDJ228=;
        b=FY+eaeQn0QSUHoJZ1pIFqwwhEngjriob9gD9u/B6V7NGsK628vXfe9OaR7V+ivQcG7
         oUq06I8eW7HBIntiAx8hVuSzVcI4o08UOO8rnlQzh+q3k/m/WbEVxbdOUyjyOCwOE937
         A487RWEuR49BgO5YHvoZXJYj8YibiJbikPaMzwoJU6XjJBkkBT4zo6LA0wUkZ+xe+wVv
         u/5J4TUl1BPNy5wFyQRJj+jpLzLFkAgws5kcfohn0eOOtgmxkfKFRb1vx4U7mxSjIxMa
         n0m0TkhMSmH3C563bTiPkClwsxB2JnwTw2UxQ027A0jTP2RpKPm9+cBoqaLh2XhDQs3i
         KbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=alhazuhH7tTd8Xd528vjQZhEVIVEKAWK4HCLXZDJ228=;
        b=X4143yNzikEeDeyoP+b4vmoDjYr3kwDZwqSQItbfLBxsLbQRW5qJIWAcACuonMJR1Z
         io4eukppFfoEYiAFhNmGXjRkOWpoSgA3Jy8zW4lPT0Uj1peR37uep6GCZ2XL9pLgWI2v
         F+58ng7lzAN26ADX6KeBErNQqlEUvY91PT75hpYOCsAQawFoUaNZannClTCz85XhtmMd
         RS7A+rZQR+GXxDa6pFoLpQmGBDJeU1QSD84CsHGxl0D4jn6/IuT3psOmbBJbCa9CRL7U
         HJMkxnKtG2bXe/PUDW8Xqt33HgZuV9ai86m7TxoV6Rwb9Vy8ObHb9Z5pSRarYOJda+f3
         /fzg==
X-Gm-Message-State: AOAM532G9ZtkwypHPISc59FmOcNAwXXet/r1M2wZ397PPJWEsAwsEYab
        Fr9wohJvYgC5HZmM6S3oXPlrxWtKoIOOkw==
X-Google-Smtp-Source: ABdhPJxMnuGcLeXNmgvjCrimkV9tdjgzm2jljb8i5xr1qPYZt2WYeIGCUhIkYo7TSWGZfmskKdgJKg==
X-Received: by 2002:a17:90b:3884:b0:1df:db8a:1fcf with SMTP id mu4-20020a17090b388400b001dfdb8a1fcfmr24013896pjb.217.1653319356845;
        Mon, 23 May 2022 08:22:36 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id q22-20020a170902789600b0016230703ca3sm1655647pll.231.2022.05.23.08.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 08:22:36 -0700 (PDT)
Date:   Mon, 23 May 2022 15:22:32 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com
Subject: Re: [PATCH v6 4/8] KVM: Extend the memslot to support fd-based
 private memory
Message-ID: <YoumuHUmgM6TH20S@google.com>
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <20220519153713.819591-5-chao.p.peng@linux.intel.com>
 <8840b360-cdb2-244c-bfb6-9a0e7306c188@kernel.org>
 <YofeZps9YXgtP3f1@google.com>
 <20220523132154.GA947536@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523132154.GA947536@chaop.bj.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 23, 2022, Chao Peng wrote:
> On Fri, May 20, 2022 at 06:31:02PM +0000, Sean Christopherson wrote:
> > On Fri, May 20, 2022, Andy Lutomirski wrote:
> > > The alternative would be to have some kind of separate table or bitmap (part
> > > of the memslot?) that tells KVM whether a GPA should map to the fd.
> > > 
> > > What do you all think?
> > 
> > My original proposal was to have expolicit shared vs. private memslots, and punch
> > holes in KVM's memslots on conversion, but due to the way KVM (and userspace)
> > handle memslot updates, conversions would be painfully slow.  That's how we ended
> > up with the current propsoal.
> > 
> > But a dedicated KVM ioctl() to add/remove shared ranges would be easy to implement
> > and wouldn't necessarily even need to interact with the memslots.  It could be a
> > consumer of memslots, e.g. if we wanted to disallow registering regions without an
> > associated memslot, but I think we'd want to avoid even that because things will
> > get messy during memslot updates, e.g. if dirty logging is toggled or a shared
> > memory region is temporarily removed then we wouldn't want to destroy the tracking.
> 
> Even we don't tight that to memslots, that info can only be effective
> for private memslot, right? Setting this ioctl to memory ranges defined
> in a traditional non-private memslots just makes no sense, I guess we can
> comment that in the API document.

Hrm, applying it universally would be funky, e.g. emulated MMIO would need to be
declared "shared".  But, applying it selectively would arguably be worse, e.g.
letting userspace map memory into the guest as shared for a region that's registered
as private...

On option to that mess would be to make memory shared by default, and so userspace
must declare regions that are private.  Then there's no weirdness with emulated MMIO
or "legacy" memslots.

On page fault, KVM does a lookup to see if the GPA is shared or private.  If the
GPA is private, but there is no memslot or the memslot doesn't have a private fd,
KVM exits to userspace.  If there's a memslot with a private fd, the shared/private
flag is used to resolve the 

And to handle the ioctl(), KVM can use kvm_zap_gfn_range(), which will bump the
notifier sequence, i.e. force the page fault to retry if the GPA may have been
(un)registered between checking the type and acquiring mmu_lock.

> > I don't think we'd want to use a bitmap, e.g. for a well-behaved guest, XArray
> > should be far more efficient.
> 
> What about the mis-behaved guest? I don't want to design for the worst
> case, but people may raise concern on the attack from such guest.

That's why cgroups exist.  E.g. a malicious/broken L1 can similarly abuse nested
EPT/NPT to generate a large number of shadow page tables.

> > One benefit to explicitly tracking this in KVM is that it might be useful for
> > software-only protected VMs, e.g. KVM could mark a region in the XArray as "pending"
> > based on guest hypercalls to share/unshare memory, and then complete the transaction
> > when userspace invokes the ioctl() to complete the share/unshare.
> 
> OK, then this can be another field of states/flags/attributes. Let me
> dig up certain level of details:
> 
> First, introduce below KVM ioctl
> 
> KVM_SET_MEMORY_ATTR

Actually, if the semantics are that userspace declares memory as private, then we
can reuse KVM_MEMORY_ENCRYPT_REG_REGION and KVM_MEMORY_ENCRYPT_UNREG_REGION.  It'd
be a little gross because we'd need to slightly redefine the semantics for TDX, SNP,
and software-protected VM types, e.g. the ioctls() currently require a pre-exisitng
memslot.  But I think it'd work...

I'll think more on this...
