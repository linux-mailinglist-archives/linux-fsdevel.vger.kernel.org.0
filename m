Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8119D7AB3AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 16:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjIVOas (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 10:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjIVOaq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:30:46 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501C8C6
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 07:30:40 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1c5cfd475fbso16984605ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 07:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695393040; x=1695997840; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KA5pwz3/DRQHr6a2ee4M3bjnbEYA57TwsoBM67hI6zU=;
        b=KasGxCGhlZLETJKdrWXwCt6Sdf48q70UTGzJbwZWC64s/HsrhafPEns5rIOCSmMzCF
         Z5vslQF3uqwntveLyJRT9X55sm2SN9LTyROw1FjsOmgBxDplUWBzYf6ax3BA5UjL4ELb
         YJsPknZYvqdQlxlzPz5zEqhGnX9Tu6BG6ioY3BFN0N3mSdjWPjyuvkUiP6pxEe6NnfWJ
         PLkmtSJXOkV0KCojJ/JCp+rGSD8krrci1aKN7jafsYbX+RWwpM95HeeOfmLnmkf1PMs0
         7NxA3aqKWL8UbhrNt+pus28C2KMT02kQ3ra3JKNW0AJ2IeAxWRuxOn4ft3DclAvaZpdM
         jwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695393040; x=1695997840;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KA5pwz3/DRQHr6a2ee4M3bjnbEYA57TwsoBM67hI6zU=;
        b=U1o0BqKV4OWfMo228h6k7URJ8tSLc7ayZzHD6+vae9EPUc8IAl8qJYjH3AqQDXBiBF
         bIHckxHB4f9x6lKACWoZ4fPcNYC957s5v1MIcq4dpd1f7gQuGMRKqcGHl03ZGgblFcta
         D/J1QVaW599YFu3e0Xn3b5jXTHcNTvmdAymlP7EN2ZZ49K4f2uRCa5ek149rrS+lMk0J
         BYk1vDH8KJJEZMJGQFlGouQg67sXwvoQo+Mrl11L70TOSeXyhOxdXJyee+/8U6oLfhtk
         GsY3yvZ17VeWDuq4ZwYnFM+8+ReHkU/bdfDk2+pUGH/QiabzOV61VAr4A6Nb79DuYe4i
         72Aw==
X-Gm-Message-State: AOJu0Yz9LnbzTp2TZODqvedcPMTUYnmZ3CLFpW5qLh4tPTJ8xA35mwDt
        1nlqTb2LJ+0jeIEJ3zuxF3jE2CSAvuM=
X-Google-Smtp-Source: AGHT+IE7TdAMSox3QZ9i3XY42vmW+YqwJtHLDXCrkzOQDSyIHqr/K/m4w9DaaKuedrPKXRX2zXN/sfp+lRA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:1cf:b0:1b9:df8f:888c with SMTP id
 e15-20020a17090301cf00b001b9df8f888cmr102903plh.8.1695393039713; Fri, 22 Sep
 2023 07:30:39 -0700 (PDT)
Date:   Fri, 22 Sep 2023 07:30:38 -0700
In-Reply-To: <117db856-9aec-e91c-b1d4-db2b90ae563d@intel.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com> <20230914015531.1419405-8-seanjc@google.com>
 <117db856-9aec-e91c-b1d4-db2b90ae563d@intel.com>
Message-ID: <ZQ2lDk3iOEz8NNg0@google.com>
Subject: Re: [RFC PATCH v12 07/33] KVM: Add KVM_EXIT_MEMORY_FAULT exit to
 report faults to userspace
From:   Sean Christopherson <seanjc@google.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 22, 2023, Xiaoyao Li wrote:
> On 9/14/2023 9:55 AM, Sean Christopherson wrote:
> > From: Chao Peng <chao.p.peng@linux.intel.com>
> > 
> > Add a new KVM exit type to allow userspace to handle memory faults that
> > KVM cannot resolve, but that userspace *may* be able to handle (without
> > terminating the guest).
> > 
> > KVM will initially use KVM_EXIT_MEMORY_FAULT to report implicit
> > conversions between private and shared memory.  With guest private memory,
> > there will be  two kind of memory conversions:
> > 
> >    - explicit conversion: happens when the guest explicitly calls into KVM
> >      to map a range (as private or shared)
> > 
> >    - implicit conversion: happens when the guest attempts to access a gfn
> >      that is configured in the "wrong" state (private vs. shared)
> > 
> > On x86 (first architecture to support guest private memory), explicit
> > conversions will be reported via KVM_EXIT_HYPERCALL+KVM_HC_MAP_GPA_RANGE,
> 
> side topic.
> 
> Do we expect to integrate TDVMCALL(MAPGPA) of TDX into KVM_HC_MAP_GPA_RANGE?

Yes, that's my expectation.

> > but reporting KVM_EXIT_HYPERCALL for implicit conversions is undesriable
> > as there is (obviously) no hypercall, and there is no guarantee that the
> > guest actually intends to convert between private and shared, i.e. what
> > KVM thinks is an implicit conversion "request" could actually be the
> > result of a guest code bug.
> > 
> > KVM_EXIT_MEMORY_FAULT will be used to report memory faults that appear to
> > be implicit conversions.
> > 
> > Place "struct memory_fault" in a second anonymous union so that filling
> > memory_fault doesn't clobber state from other yet-to-be-fulfilled exits,
> > and to provide additional information if KVM does NOT ultimately exit to
> > userspace with KVM_EXIT_MEMORY_FAULT, e.g. if KVM suppresses (or worse,
> > loses) the exit, as KVM often suppresses exits for memory failures that
> > occur when accessing paravirt data structures.  The initial usage for
> > private memory will be all-or-nothing, but other features such as the
> > proposed "userfault on missing mappings" support will use
> > KVM_EXIT_MEMORY_FAULT for potentially _all_ guest memory accesses, i.e.
> > will run afoul of KVM's various quirks.
> 
> So when exit reason is KVM_EXIT_MEMORY_FAULT, how can we tell which field in
> the first union is valid?
> 
> When exit reason is not KVM_EXIT_MEMORY_FAULT, how can we know the info in
> the second union run.memory is valid without a run.memory.valid field?

I'll respond to this separately with a trimmed Cc list.  I suspect this will be
a rather lengthy conversation, and it has almost nothing to do with guest_memfd.

> > +Note!  KVM_EXIT_MEMORY_FAULT is unique among all KVM exit reasons in that it
> > +accompanies a return code of '-1', not '0'!  errno will always be set to EFAULT
> > +or EHWPOISON when KVM exits with KVM_EXIT_MEMORY_FAULT, userspace should assume
> > +kvm_run.exit_reason is stale/undefined for all other error numbers.
> > +
> 
> Initially, this section is the copy of struct kvm_run and had comments for
> each field accordingly. Unfortunately, the consistence has not been well
> maintained during the new filed being added.
> 
> Do we expect to fix it?

AFAIK, no one is working on cleaning up this section of the docs, but as always,
patches are welcome :-)
