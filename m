Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2056F778466
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 01:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjHJX5w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 19:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjHJX5u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 19:57:50 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDD92D47
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 16:57:49 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99d6d5054bcso205560866b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 16:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691711868; x=1692316668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhMgA7qBPuApMhQ4h1vJKFRA4DNp+2B2aFxUktI7jpQ=;
        b=fSbsTlZ9eRUEq1oc0qlT9VA71infat9B81M3qAFGPQLw+6DiL/k6IQBVuLqYpfm6zc
         JPbbQuf/OXWE0DDR3Vty3P+Ga7xRDAZJPbwv8Rh6DllYU5zj15degN0az+fa1E+ZZKui
         Zid/yQ06BXhwoDugW7aU7NJA5d/c3xUSIByYDVFEbgx0r3ZtD20CbtxCBNcFSIJefMq1
         tRA4cZrI4/sEiaraxlYyAq+sL65bMfdUmaPLsXuLObrwqiszX5v1AaY8IXbz4ltMaoUI
         FDZXJTolroDTYu55EKXzdNQ57eJWghsSQRQDYygik7m8uY2F9+yL1a51YFkAYkFi+S2u
         5sVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691711868; x=1692316668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhMgA7qBPuApMhQ4h1vJKFRA4DNp+2B2aFxUktI7jpQ=;
        b=He8HfxWFgi33XhCTwi9r0DeQI3VLyYunC4q1WG/CwCHIZm4UdHHagwlvshvr1XEtBX
         tUCq1O3a54aUlvh7Pr8vngZ3iCv7ie7nbth10vSNZzNq0Q+Aiccv22DXfGKyXcbbpEcK
         G3y5kAHXqKAWOwxHUBpHm8sS0YAxSVP0Kx4/WBhOVbyTelwQYVzd96imJoYiY7t3ZCpJ
         6k8TG3QWl8YQaxjUpBUTkSLc4PGhMZk4woFTapDo2HDUjKfGxaAlLb7yBY8JgVay/+kH
         /RxSwCiU+22uqpHEkr8lWcHelTYkb6WPcbABL73GbSGupauMYsNuY/091ycmX6LRcthI
         Rv8g==
X-Gm-Message-State: AOJu0YxY9dvxPoyu4cLbFKCpz/oEv0eaHqiZ4/CIAjxZppJ/vgs+hPvB
        d12IVHESXyE/JmgvVhpEe9COtxQ8sFHgKKAX25Z9gA==
X-Google-Smtp-Source: AGHT+IExGyX6IQpw7nkPj/Oj8ZdeERAHUNFikZIEbAqLbQU3zHzZ+Xb2mqkLRl/UdYIm3ylJUJ+cypBkqHv5r6CLu/8=
X-Received: by 2002:a17:906:1d1:b0:99c:55c5:1c6e with SMTP id
 17-20020a17090601d100b0099c55c51c6emr519636ejj.8.1691711867870; Thu, 10 Aug
 2023 16:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230718234512.1690985-13-seanjc@google.com> <diqzv8dq3116.fsf@ackerleytng-ctop.c.googlers.com>
 <ZNKv9ul2I7A4V7IF@google.com>
In-Reply-To: <ZNKv9ul2I7A4V7IF@google.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Thu, 10 Aug 2023 16:57:36 -0700
Message-ID: <CAGtprH9YE50RtqhW-U+wK0Vv6aKfqqtOPn8q4s8or=UZwPXZoA@mail.gmail.com>
Subject: Re: [RFC PATCH v11 12/29] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
To:     Sean Christopherson <seanjc@google.com>
Cc:     Ackerley Tng <ackerleytng@google.com>, pbonzini@redhat.com,
        maz@kernel.org, oliver.upton@linux.dev, chenhuacai@kernel.org,
        mpe@ellerman.id.au, anup@brainfault.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, willy@infradead.org,
        akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, chao.p.peng@linux.intel.com,
        tabba@google.com, jarkko@kernel.org, yu.c.zhang@linux.intel.com,
        mail@maciej.szmigiero.name, vbabka@suse.cz, david@redhat.com,
        qperret@google.com, michael.roth@amd.com, wei.w.wang@intel.com,
        liam.merwick@oracle.com, isaku.yamahata@gmail.com,
        kirill.shutemov@linux.intel.com
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

On Tue, Aug 8, 2023 at 2:13=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
> ...

> > + When binding a memslot to the file, if a kvm pointer exists, it must
> >   be the same kvm as the one in this binding
> > + When the binding to the last memslot is removed from a file, NULL the
> >   kvm pointer.
>
> Nullifying the KVM pointer isn't sufficient, because without additional a=
ctions
> userspace could extract data from a VM by deleting its memslots and then =
binding
> the guest_memfd to an attacker controlled VM.  Or more likely with TDX an=
d SNP,
> induce badness by coercing KVM into mapping memory into a guest with the =
wrong
> ASID/HKID.
>

TDX/SNP have mechanisms i.e. PAMT/RMP tables to ensure that the same
memory is not assigned to two different VMs. Deleting memslots should
also clear out the contents of the memory as the EPT tables will be
zapped in the process and the host will reclaim the memory.

Regards,
Vishal
