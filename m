Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EEA7BB075
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 05:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjJFDVX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 23:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjJFDVV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 23:21:21 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E669E4
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Oct 2023 20:21:18 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f8040b2ffso25256457b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Oct 2023 20:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696562477; x=1697167277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+GCfD3J/utVXt7fNFcXS7tndSxc76Lg25lhLquZNVGo=;
        b=hrtpfTHdnDlVQOSCXorsT/aQpCWyDltEjd8ggllmcRKf0hehE+I3NnH7FBjDok1ZhH
         zxiW3QeU7M+QnZdyltwO1UIpQuMKmo9EQEhNWpfk6pSMe/HEt+4b3rNW8zjTdMQg/B10
         iZCLZl51zE9bQUpUbrhdEF9Fmxm16pzP4f8ofIJuXk4gLecrkB9/Q9kxBHT8rugTv8s/
         bNMRxJ7Ujm366qW+kXMXoWNpdDO/O2Ot3Am4VUOq6Zgsd/yx/oiEIVzi0LddaCdnW98k
         ehUE5i2UPtmnCpl8Hmq2OcMNaedBdRXW8yU7hbzO+v/QqNJ1b108X36Fx61ihw91uxsp
         thqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696562477; x=1697167277;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+GCfD3J/utVXt7fNFcXS7tndSxc76Lg25lhLquZNVGo=;
        b=garDNU6u30iLgc+FeJghgfjVET/y9KXlX7rKv+XPRoty0feZO/w5JhqugpuOihnsgV
         Y/ypfN2LCjR6ad2EOM2r9m03ZHoUi9NAvn39RTVwTJOoySahBpZ7jeCLHx7EBrDM8+IG
         vdDi+rAXp8d8R8blJJ+kSdhjVN1/rtn5SbFkK/4aRq2E9p7cgXuyJgArSAmjlkN31ckh
         uOoNFVbVZBGLI5WOXcR+mbMCuSui9NRf0y+MgiqN5gVMDvyRfmQV8Nxv88PhyVbdMwD1
         WaGKA8mHZpAPQ+0KKauuwBLiKdyKz4AJaDJ35XiOP0ZC6vydOt7+kRo5iuivmyvY8QSA
         pd+w==
X-Gm-Message-State: AOJu0YwkAQwzc7FnUD1HmEpeGFhi1oBw4pGrSx5NhB6qrskU3VQcVmS2
        6a+T1D57Yyy7Zn/Oq6qfDXYdKZ9AxbU=
X-Google-Smtp-Source: AGHT+IHbgJX1dul2brLKqtxy3zNH4Wq8osuz6z+RCm0MrNAV7Qoo4mqOPY/NVTlIcosnwAkmq4EHKfjNEDc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ae41:0:b0:d78:a78:6fc7 with SMTP id
 g1-20020a25ae41000000b00d780a786fc7mr101904ybe.6.1696562477545; Thu, 05 Oct
 2023 20:21:17 -0700 (PDT)
Date:   Thu, 5 Oct 2023 20:21:15 -0700
In-Reply-To: <CA+EHjTwTgEVtea7wgef5G6EEgFa0so_GbNXTMZNKyFE=ucyV0g@mail.gmail.com>
Mime-Version: 1.0
References: <CA+EHjTwTgEVtea7wgef5G6EEgFa0so_GbNXTMZNKyFE=ucyV0g@mail.gmail.com>
Message-ID: <ZR99K_ZuWXEtfDuR@google.com>
Subject: Re: [RFC PATCH v12 11/33] KVM: Introduce per-page memory attributes
From:   Sean Christopherson <seanjc@google.com>
To:     Fuad Tabba <tabba@google.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 05, 2023, Fuad Tabba wrote:
> Hi Sean,
>=20
> On Tue, Oct 3, 2023 at 9:51=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> > > Like I said, pKVM doesn't need a userspace ABI for managing PRIVATE/S=
HARED,
> > > just a way of tracking in the host kernel of what is shared (as oppos=
ed to
> > > the hypervisor, which already has the knowledge). The solution could =
simply
> > > be that pKVM does not enable KVM_GENERIC_MEMORY_ATTRIBUTES, has its o=
wn
> > > tracking of the status of the guest pages, and only selects KVM_PRIVA=
TE_MEM.
> >
> > At the risk of overstepping my bounds, I think that effectively giving =
the guest
> > full control over what is shared vs. private is a mistake.  It more or =
less locks
> > pKVM into a single model, and even within that model, dealing with erro=
rs and/or
> > misbehaving guests becomes unnecessarily problematic.
> >
> > Using KVM_SET_MEMORY_ATTRIBUTES may not provide value *today*, e.g. the=
 userspace
> > side of pKVM could simply "reflect" all conversion hypercalls, and term=
inate the
> > VM on errors.  But the cost is very minimal, e.g. a single extra ioctl(=
) per
> > converion, and the upside is that pKVM won't be stuck if a use case com=
es along
> > that wants to go beyond "all conversion requests either immediately suc=
ceed or
> > terminate the guest".
>=20
> Now that I understand the purpose of KVM_SET_MEMORY_ATTRIBUTES, I
> agree. However, pKVM needs to track at the host kernel (i.e., EL1)
> whether guest memory is shared or private.

Why does EL1 need it's own view/opinion?  E.g. is it to avoid a accessing d=
ata
that is still private according to EL2 (on behalf of the guest)?

Assuming that's the case, why can't EL1 wait until it gets confirmation fro=
m EL2
that the data is fully shared before doing whatever it is that needs to be =
done?

Ah, is the problem that whether or not .mmap() is allowed keys off of the s=
tate
of the memory attributes?  If that's so, then yeah, an internal flag in att=
ributes
is probably the way to go.  It doesn't need to be a "host kernel private" f=
lag
though, e.g. an IN_FLUX flag to capture that the attributes aren't fully re=
alized
might be more intuitive for readers, and might have utility for other attri=
butes
in the future too.

> One approach would be to add another flag to the attributes that
> tracks the host kernel view. The way KVM_SET_MEMORY_ATTRIBUTES is
> implemented now, userspace can zero it, so in that case, that
> operation would need to be masked to avoid that.
>=20
> Another approach would be to have a pKVM-specific xarray (or similar)
> to do the tracking, but since there is a structure that's already
> doing something similar (i.e.,the attributes array), it seems like it
> would be unnecessary overhead.
>=20
> Do you have any ideas or preferences?
>=20
> Cheers,
> /fuad
