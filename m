Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C867597EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 16:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjGSOQ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 10:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjGSOQ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:16:58 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24DC8E
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 07:16:56 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-262c77ffb9dso5333083a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 07:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689776216; x=1692368216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ply9vOQ7PKiPIjqcvpgXEIwEBxatqkRJB2ZRy5lS2Xc=;
        b=QCgn5pm8yPPImP/ZfLF2Ea0jJXDpcGNQ/LF2jNeNTBG71TLZwae17UnwEuo78ONGHP
         atCG9sArqHfv277Ky9HWUevcQtozR/I9rfoMFWMGzH2p/tn1UptotifJkTzwcjUzjGM4
         2mRccC+Qe6eelyvVpzgsii1Dz38eewFROpWBRyPZo22w72yv1RXU/kRjiIgbgdf4vOiO
         m+eFtOZOtzemALwYg0UpO5hPIX4qNwingmWVGWsEqCwrs8u/CIQrQXsRy9c4nWVOA7nY
         TgAf9p3r7jbBOiu0L+1TlKBrMt3e7HNn72eYqwvkzNmnIVVzm8emG5isi9/yOnMB2w1e
         eLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689776216; x=1692368216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ply9vOQ7PKiPIjqcvpgXEIwEBxatqkRJB2ZRy5lS2Xc=;
        b=KpDYd6Ugb0NzDJ0GE7Mk/o2WA3ZdeZ43vB36HKhhRvl3So5sxr3e+UlGy7QSW4MMMZ
         sVMsEgjcFU9rfGQsC8Nqv+MF0qnGTn1WIWy2mEjcAPJ15H3RhcSdDFIyENBE2tdI8XZP
         568Nbr4CobD5pPu59USazaQysnUzpoiTYBRBkENuUfjb7sBPLF/W83oDu701t/1UBucd
         JSHJmmBr/2BYrvNKFL88jCSJOfExCl49y0r1Pz1As6Ree53EoTM4G0ET9MAZKoTCI9Fn
         ZiIirHZcAHjCZzMjdw0Y4hHOLGLU1eBuP54yj2oDYsOD8XPbnGrm/0FXRaeVw+aiToY2
         rS0w==
X-Gm-Message-State: ABy/qLayyOwL+50K9iilSyazOC3EnfWyGpnvLSYf229VJxC7PVoTgKM2
        Y1PwrAL+g1pfF1SJ1YxrHuqmO2shhCg=
X-Google-Smtp-Source: APBJJlHe5KmJdZof+vQtZ6M87xlqjK1Ejx8t4AB5DMX6de6h21FipxJ2lQkyFnlQoXRyf3eYpC2jq3S2bQ0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:e542:b0:25b:f9e3:deab with SMTP id
 ei2-20020a17090ae54200b0025bf9e3deabmr136275pjb.9.1689776216142; Wed, 19 Jul
 2023 07:16:56 -0700 (PDT)
Date:   Wed, 19 Jul 2023 07:16:54 -0700
In-Reply-To: <20230719075440.m3h653frqggaiusc@yy-desk-7060>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com> <20230718234512.1690985-8-seanjc@google.com>
 <20230719075440.m3h653frqggaiusc@yy-desk-7060>
Message-ID: <ZLfwVki27oLBGO6D@google.com>
Subject: Re: [RFC PATCH v11 07/29] KVM: Add KVM_EXIT_MEMORY_FAULT exit
From:   Sean Christopherson <seanjc@google.com>
To:     Yuan Yao <yuan.yao@linux.intel.com>
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 19, 2023, Yuan Yao wrote:
> On Tue, Jul 18, 2023 at 04:44:50PM -0700, Sean Christopherson wrote:
> > From: Chao Peng <chao.p.peng@linux.intel.com>
> >
> > This new KVM exit allows userspace to handle memory-related errors. It
> > indicates an error happens in KVM at guest memory range [gpa, gpa+size).
> > The flags includes additional information for userspace to handle the
> > error. Currently bit 0 is defined as 'private memory' where '1'
> > indicates error happens due to private memory access and '0' indicates
> > error happens due to shared memory access.
> 
> Now it's bit 3:

Yeah, I need to update (or write) a lot of changelogs.

> #define KVM_MEMORY_EXIT_FLAG_PRIVATE (1ULL << 3)
> 
> I remember some other attributes were introduced in v10 yet:
> 
> #define KVM_MEMORY_ATTRIBUTE_READ              (1ULL << 0)
> #define KVM_MEMORY_ATTRIBUTE_WRITE             (1ULL << 1)
> #define KVM_MEMORY_ATTRIBUTE_EXECUTE           (1ULL << 2)
> #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
> 
> So KVM_MEMORY_EXIT_FLAG_PRIVATE changed to bit 3 due to above things,
> or other reason ? (Sorry I didn't follow v10 too much before).

Yep, I want to reserve space for the RWX bits.
