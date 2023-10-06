Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2427BB809
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 14:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjJFMrl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 08:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjJFMrk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:47:40 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3D7C2
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 05:47:39 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d81dd7d76e0so2403681276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Oct 2023 05:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696596459; x=1697201259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kE5lcMpcuRWxeOB9S6L9Si7YaWv5hLYl1VeNlBZzT/8=;
        b=wXitWH63YyQNrPPne4or1YDsmFgI2V8pRMPSMT6yXVEdd/leOukdoJiEdLKrL+7aag
         zoga0bm8D+JRbO8cZmC9DSGJSgd/fFZSGCQJApcWPuHk2kA9MES1gm2V8pdNW7h6g651
         vmxjn7YuHleZhMefL4xVonsLKfAlMhXpOuUmzj4OvRdDoqiglD6jSVEtAPZ7rSn9fM41
         T0/Iq2DJZ1x8sI/PwN7cFQQfSyDzOXGCs/lFBcDIURojuB+25CxbAyYS2oZfhdxXnOrL
         XZUhW1H4GpAboykPvZxM6DGZytw7ITTziMMurbnnOX7V2/FMNAvDXc1zioGobpuap4qK
         v47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696596459; x=1697201259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kE5lcMpcuRWxeOB9S6L9Si7YaWv5hLYl1VeNlBZzT/8=;
        b=UPtGGLHg0y9QdClNcG66Jvohz5XkPZFLTfovfbS/pdn8OM72cJvq+24v4Zz/dkLBin
         wU71c6obS1P2jG303dzXfLEb5PwHMdq9wXw1VPuKE2gjAZOIixrDmTZvuOf0g23oshBS
         wHzpgcpU+RgwZS1UbX8dRI9rI38yJe1+EPeYA5iHwr3/tZhKgHEOIzbJrh9mHaixWnJm
         Pljez6i97QrQGCGdSenlwR66ksSQEg5nJtgXdeEqGXtAFcc+FIZ3N+LwU9e6LwqrVgx+
         PyFXEYQzlPRXs8Sc+B/uvuWLbd+BC91hjBaC/Q6wd+msf4sZcCqWO0WZVCdPVF5iaU3h
         BYhw==
X-Gm-Message-State: AOJu0YwFFP1dUYqYVxtIT46jxSAZVIxm5j3bpABEAspN4xklC9S5zShy
        TT9HC7CuJY7ernulPjKRCDo7jgDF6JFqvrm8Vv4Vtg==
X-Google-Smtp-Source: AGHT+IGILgsJf+f8eayHVHqX0rISrGr9tP06v0nLvKR1oTcr5riaw9zUWCGoAJpDUWeKMDK50UY6pLVZ+E+8O7Aw+dY=
X-Received: by 2002:a5b:807:0:b0:d47:8db3:8bcf with SMTP id
 x7-20020a5b0807000000b00d478db38bcfmr7283393ybp.49.1696596458614; Fri, 06 Oct
 2023 05:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <CA+EHjTwTgEVtea7wgef5G6EEgFa0so_GbNXTMZNKyFE=ucyV0g@mail.gmail.com>
 <ZR99K_ZuWXEtfDuR@google.com>
In-Reply-To: <ZR99K_ZuWXEtfDuR@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Fri, 6 Oct 2023 13:47:01 +0100
Message-ID: <CA+EHjTyDPEY7B_a8GC7RS8gzfoT2q9kJqJPuHB58ZXQ_61NGkQ@mail.gmail.com>
Subject: Re: [RFC PATCH v12 11/33] KVM: Introduce per-page memory attributes
To:     Sean Christopherson <seanjc@google.com>
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
        "Serge E. Hallyn" <serge@hallyn.com>, KVM <kvm@vger.kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        KVMARM <kvmarm@lists.linux.dev>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Chao Peng <chao.p.peng@linux.intel.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Sean,

On Fri, Oct 6, 2023 at 4:21=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Thu, Oct 05, 2023, Fuad Tabba wrote:
> > Hi Sean,
> >
> > On Tue, Oct 3, 2023 at 9:51=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
> > > > Like I said, pKVM doesn't need a userspace ABI for managing PRIVATE=
/SHARED,
> > > > just a way of tracking in the host kernel of what is shared (as opp=
osed to
> > > > the hypervisor, which already has the knowledge). The solution coul=
d simply
> > > > be that pKVM does not enable KVM_GENERIC_MEMORY_ATTRIBUTES, has its=
 own
> > > > tracking of the status of the guest pages, and only selects KVM_PRI=
VATE_MEM.
> > >
> > > At the risk of overstepping my bounds, I think that effectively givin=
g the guest
> > > full control over what is shared vs. private is a mistake.  It more o=
r less locks
> > > pKVM into a single model, and even within that model, dealing with er=
rors and/or
> > > misbehaving guests becomes unnecessarily problematic.
> > >
> > > Using KVM_SET_MEMORY_ATTRIBUTES may not provide value *today*, e.g. t=
he userspace
> > > side of pKVM could simply "reflect" all conversion hypercalls, and te=
rminate the
> > > VM on errors.  But the cost is very minimal, e.g. a single extra ioct=
l() per
> > > converion, and the upside is that pKVM won't be stuck if a use case c=
omes along
> > > that wants to go beyond "all conversion requests either immediately s=
ucceed or
> > > terminate the guest".
> >
> > Now that I understand the purpose of KVM_SET_MEMORY_ATTRIBUTES, I
> > agree. However, pKVM needs to track at the host kernel (i.e., EL1)
> > whether guest memory is shared or private.
>
> Why does EL1 need it's own view/opinion?  E.g. is it to avoid a accessing=
 data
> that is still private according to EL2 (on behalf of the guest)?
>
> Assuming that's the case, why can't EL1 wait until it gets confirmation f=
rom EL2
> that the data is fully shared before doing whatever it is that needs to b=
e done?
>
> Ah, is the problem that whether or not .mmap() is allowed keys off of the=
 state
> of the memory attributes?  If that's so, then yeah, an internal flag in a=
ttributes
> is probably the way to go.  It doesn't need to be a "host kernel private"=
 flag
> though, e.g. an IN_FLUX flag to capture that the attributes aren't fully =
realized
> might be more intuitive for readers, and might have utility for other att=
ributes
> in the future too.

Yes, it's because of mmap. I think that an IN_FLUX flag might work
here. I'll have a go at it and see how it turns out.

Thanks,
/fuad

>
> > One approach would be to add another flag to the attributes that
> > tracks the host kernel view. The way KVM_SET_MEMORY_ATTRIBUTES is
> > implemented now, userspace can zero it, so in that case, that
> > operation would need to be masked to avoid that.
> >
> > Another approach would be to have a pKVM-specific xarray (or similar)
> > to do the tracking, but since there is a structure that's already
> > doing something similar (i.e.,the attributes array), it seems like it
> > would be unnecessary overhead.
> >
> > Do you have any ideas or preferences?
> >
> > Cheers,
> > /fuad
