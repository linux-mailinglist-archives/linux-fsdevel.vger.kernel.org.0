Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C986A588ECE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 16:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbiHCOm3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 10:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235971AbiHCOm1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 10:42:27 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE5629811
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Aug 2022 07:42:22 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso2234899pjq.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Aug 2022 07:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=WbLojLDf4bnSMua5Syjpq38ZqCfDt7KDJFslMAkFjxI=;
        b=S8oyKUBy69riYkQuhYnwr0bc7Xvahe0VOOFXz4BtcQ0Obxpsdkj/f3ARt4Mt/OUsCb
         DsrJXH1aF/JgDNByaDUbxmaljW2v3JxByMH8iLWSiayTU5HbZCNMaZqiqvwzNiTOjjYT
         dSe2qtNn5OyY/2iIiipeDJWnj9+8KugXVn/Gh1KEZyNk2izo4jPnWiscetPUQPS9YA5a
         KuaMdniensvSwTajg+cFCupR8Fse6ozUzNza11V9wBVMEgrMl8EoawPzLyociiYgPofZ
         qs4D88AaLCVfbZBTf1QVpfkIjxi1VjVXMa7LR98wadzIA8n6LRzLHGWMpdZ6eyKnF0ic
         g4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=WbLojLDf4bnSMua5Syjpq38ZqCfDt7KDJFslMAkFjxI=;
        b=I4RiR4a0HOaZ6q0TG6HHJ2J5oIKQTzrc1wieUtkXxCWqQvZa9dZVa3dzoeeLX+XLIW
         rKZQrCMv839eJH6gTSRQdtJcuAp88Sr6qsWFuFNtuI9sOMsVkmY1ROaOzzLKlyTFjwZL
         /q3azYh19oOabxsYM/fBNYaWFqCW7DgHS4l79EGB6njMollfwp+7rQf4CNGIJqJrZtxe
         gLys9Rvyy88+Lg2eu5xc42ULVCp8QUgh6eSPxZXNra1wyz5zm5biCer47MPhY8FBO0Ex
         O3ZGhNWXygWiy4KrDykIAuj0N06/XkRrRsuzKbL3T1kM0GE+Cx2EIT1xybln9q0o94Vv
         bPEg==
X-Gm-Message-State: ACgBeo0gMsj83tizZX1pwp/SKZ4/gOngiCEvYK2xn7JqxuylpCc8eCrP
        XBQRVvH6eOZ4gVP2ZoakSrjtGg==
X-Google-Smtp-Source: AA6agR4YfMFOGAmga5CfWpVWHyya4teDhnGUJy+qkkGHA09bRr9mP40ayb7pIQHXCvX5PQKdF82pIw==
X-Received: by 2002:a17:90b:350c:b0:1f5:e4b:2884 with SMTP id ls12-20020a17090b350c00b001f50e4b2884mr5338018pjb.46.1659537741705;
        Wed, 03 Aug 2022 07:42:21 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id u62-20020a627941000000b0052ac12e7596sm3118097pfc.114.2022.08.03.07.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 07:42:20 -0700 (PDT)
Date:   Wed, 3 Aug 2022 14:42:17 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org,
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
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v7 09/14] KVM: Extend the memslot to support fd-based
 private memory
Message-ID: <YuqJSQI3gas/k56X@google.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-10-chao.p.peng@linux.intel.com>
 <YuQ6QWcdZLdStkWl@google.com>
 <20220803100835.GD607465@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803100835.GD607465@chaop.bj.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 03, 2022, Chao Peng wrote:
> On Fri, Jul 29, 2022 at 07:51:29PM +0000, Sean Christopherson wrote:
> > On Wed, Jul 06, 2022, Chao Peng wrote:
> > > @@ -1332,9 +1332,18 @@ yet and must be cleared on entry.
> > >  	__u64 userspace_addr; /* start of the userspace allocated memory */
> > >    };
> > >  
> > > +  struct kvm_userspace_memory_region_ext {
> > > +	struct kvm_userspace_memory_region region;
> > > +	__u64 private_offset;
> > > +	__u32 private_fd;
> > > +	__u32 pad1;
> > > +	__u64 pad2[14];
> > > +};
> > > +
> > >    /* for kvm_memory_region::flags */
> > >    #define KVM_MEM_LOG_DIRTY_PAGES	(1UL << 0)
> > >    #define KVM_MEM_READONLY	(1UL << 1)
> > > +  #define KVM_MEM_PRIVATE		(1UL << 2)
> > 
> > Very belatedly following up on prior feedback...
> > 
> >   | I think a flag is still needed, the problem is private_fd can be safely
> >   | accessed only when this flag is set, e.g. without this flag, we can't
> >   | copy_from_user these new fields since they don't exist for previous
> >   | kvm_userspace_memory_region callers.
> > 
> > I forgot about that aspect of things.  We don't technically need a dedicated
> > PRIVATE flag to handle that, but it does seem to be the least awful soltuion.
> > We could either add a generic KVM_MEM_EXTENDED_REGION or an entirely new
> > ioctl(), e.g. KVM_SET_USER_MEMORY_REGION2, but in both approaches there's a decent
> > chance that we'll end up needed individual "this field is valid" flags anways.
> > 
> > E.g. if KVM requires pad1 and pad2 to be zero to carve out future extensions,
> > then we're right back here if some future extension needs to treat '0' as a legal
> > input.
> 
> I had such practice (always rejecting none-zero 'pad' value when
> introducing new user APIs) in other project previously, but I rarely
> see that in KVM.

Ya, KVM often uses flags to indicate the validity of a field specifically so that
KVM doesn't misinterpret a '0' from an older userspace as an intended value.
