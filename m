Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629C664540D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Dec 2022 07:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiLGGeQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Dec 2022 01:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLGGeP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Dec 2022 01:34:15 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA34B532F9;
        Tue,  6 Dec 2022 22:34:14 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so598173pjd.5;
        Tue, 06 Dec 2022 22:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C15cHp35UgTVcGwyWVF0FgqoGcE+bZVU/5tK1HiVhGg=;
        b=CKqZ/l9PnwBZEtXNtp4aPBttpJeA89ZaQxsLN+jKw3eUVeg9N70IqMgdpBhfmoMdRN
         wnNcjMkoLzHDq6uSVjjvzsYnerZjG1HIAwRJ1o5QS5Yp8oNstErg28aAus8PdaoLeqx3
         f2++jCdgHb8lDQ6ETyzyDMSqpkHcnxdDTU7zRBcFo3QBH9uNzewTIfvJ1efH8a1UHYv+
         dz6o9xbAOwTWr7xaQjDIg+nKseYPUY71PlOmzpnNJTkqlzgQvjmD1yQTL6sJfRdqQoUC
         XKpDVo69w4cJKZZVhcBHWOWsfC+8Xh7NT3VFznBfTVfB1ab0ptONygi3M5nMJitgBbY6
         fyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C15cHp35UgTVcGwyWVF0FgqoGcE+bZVU/5tK1HiVhGg=;
        b=2Ek8fGIey6iriKjVEhl0pi73rfM2kp/BVpFOJbNUiFJF6OwsXAyLIusb5D0TO9CsTR
         q97ZGmrrAP85ulnVE0XL8G+7vyPDMCq8lggDHkYKQfeciE+QivCJuk2RbjDU9ZNn+eKA
         hp5zPByqrCxrApDEs0T0AibL9eWpUgr7roF+9KvxN6Be5TOr2lHOxhPRSmAmOAZJQfFV
         mCR3Wt1YVPttwVQJklgcf5npVxSx2AeGQL69dIPgy6/MiyyKnyJqjfX+TxHjiRXr0JuJ
         P+PRrGhNtW+/eTCEAcE9+BARt+ZxeheocYty391Y4aD912PYuodInZ0Vx0lCgZYMxIuI
         FElg==
X-Gm-Message-State: ANoB5pll+U0ThoCRxfPTtUeuDt2Y9Oq4ZAuCoRTzHDFegSNEWJLkqGyT
        LRNttswfmWNzBU1RqEdyiJ4=
X-Google-Smtp-Source: AA0mqf7ST4xuwmjyV+Fg/LkYpzDRbEp/+IDjSth6MZo3us+POloNmlOnA05Cq/8ntpMh4DvZF8JHuw==
X-Received: by 2002:a17:90a:9313:b0:213:2168:1c78 with SMTP id p19-20020a17090a931300b0021321681c78mr99342910pjo.72.1670394853895;
        Tue, 06 Dec 2022 22:34:13 -0800 (PST)
Received: from localhost ([192.55.54.55])
        by smtp.gmail.com with ESMTPSA id x6-20020a623106000000b005745eb7eccasm12686643pfx.112.2022.12.06.22.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 22:34:12 -0800 (PST)
Date:   Tue, 6 Dec 2022 22:34:11 -0800
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Fuad Tabba <tabba@google.com>, kvm@vger.kernel.org,
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
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com, isaku.yamahata@gmail.com
Subject: Re: [PATCH v10 5/9] KVM: Use gfn instead of hva for
 mmu_notifier_retry
Message-ID: <20221207063411.GB3632095@ls.amr.corp.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-6-chao.p.peng@linux.intel.com>
 <CA+EHjTy5+Ke_7Uh72p--H9kGcE-PK4EVmp7ym6Q1-PO28u6CCQ@mail.gmail.com>
 <20221206115623.GB1216605@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221206115623.GB1216605@chaop.bj.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 06, 2022 at 07:56:23PM +0800,
Chao Peng <chao.p.peng@linux.intel.com> wrote:

> > > -       if (unlikely(kvm->mmu_invalidate_in_progress) &&
> > > -           hva >= kvm->mmu_invalidate_range_start &&
> > > -           hva < kvm->mmu_invalidate_range_end)
> > > -               return 1;
> > > +       if (unlikely(kvm->mmu_invalidate_in_progress)) {
> > > +               /*
> > > +                * Dropping mmu_lock after bumping mmu_invalidate_in_progress
> > > +                * but before updating the range is a KVM bug.
> > > +                */
> > > +               if (WARN_ON_ONCE(kvm->mmu_invalidate_range_start == INVALID_GPA ||
> > > +                                kvm->mmu_invalidate_range_end == INVALID_GPA))
> > 
> > INVALID_GPA is an x86-specific define in
> > arch/x86/include/asm/kvm_host.h, so this doesn't build on other
> > architectures. The obvious fix is to move it to
> > include/linux/kvm_host.h.
> 
> Hmm, INVALID_GPA is defined as ZERO for x86, not 100% confident this is
> correct choice for other architectures, but after search it has not been
> used for other architectures, so should be safe to make it common.

INVALID_GPA is defined as all bit 1.  Please notice "~" (tilde).

#define INVALID_GPA (~(gpa_t)0)
-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
