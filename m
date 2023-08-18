Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0E878159D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Aug 2023 01:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241952AbjHRXD7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 19:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241918AbjHRXDo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 19:03:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFFA421F
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 16:03:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d6ce0c4489bso1736379276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 16:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692399822; x=1693004622;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=28NglzIO6cp/vzLfU4W3yc26zb3SzMF2NIoeJVJxjcQ=;
        b=EVGfgwe5loZZR0WMUgpJEOZteslGNWIqlIRhDe/gbts+F4/yw7LopoWIr9pAXN/gct
         vmDVXSSz1qYQsgmOG56EVjufIZ8uHJIc0K2fjYh54YGOjsi7Y2c13ZQR7k+mneDCdJ6K
         fzW5DxeEtavJtj3e3uV6c2SWgwD/YmEbj2Rv9dwQ6wRuQzmdnahyzKBwtcnM92PUpCV2
         6SViYhyQd8PzIgA5SnclKlRnW0JgjAUS06yCK7QyV0vkFW6Zt0VuYiJbLr9XMzWwR30M
         Wq85gyIx9s0/FGvGJHcq/Jks4zP9GUvni76QMTBxGvpnvPGwvzqq5FqhBNo14dUbWrMQ
         g0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692399822; x=1693004622;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=28NglzIO6cp/vzLfU4W3yc26zb3SzMF2NIoeJVJxjcQ=;
        b=YC3836qEr1m3uJX6zM/uq8tmboB5HFUcajxYZG2ZExeOCePDuc/FL0k2bj2FfqCMB3
         HB3hC+BPV6sQPwRPn9XdhetPZpDTyai8xraZ+cEsElHF2qGf04M0pqEeXwHafA9pMEu2
         RlTlM9G2QFbFB22j4eE4TQqaMNSHTMCEFsGjuhw/Ihigm83XPQmEB0PNreGBkN9VYxpw
         KFctIDm3urEoFhJ38fjU0GYhi7gDEdUFh2y8slVMG6RjDg59GRzTsqX+8qGfxRFi2pQv
         SbrB/SdSgSkDJ4zdLyvuNkAQTEjYwr/fIkW+HQuaaPpBw5iSSR5YSnv3Q8oVT7cMj1tD
         YHlw==
X-Gm-Message-State: AOJu0YzKsv3zv3x+SzxbTjV0h8/hpGP+AUxDB6HIx1EG11f9JsxxA2C2
        MyrEXghAp3x5CYbf6e5f2BiG0nI2oQk=
X-Google-Smtp-Source: AGHT+IEiW/RghuqZOFRro09VfZa9EIt3/32aXeBy5eI/raBp2zbRsudvcD77PZeJQ//x65k1pSmrq3qMqqs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d149:0:b0:d4c:2a34:aeab with SMTP id
 i70-20020a25d149000000b00d4c2a34aeabmr6800ybg.11.1692399822583; Fri, 18 Aug
 2023 16:03:42 -0700 (PDT)
Date:   Fri, 18 Aug 2023 16:03:41 -0700
In-Reply-To: <diqzo7ji30eo.fsf@ackerleytng-ctop.c.googlers.com>
Mime-Version: 1.0
References: <20230718234512.1690985-29-seanjc@google.com> <diqzo7ji30eo.fsf@ackerleytng-ctop.c.googlers.com>
Message-ID: <ZN/4zZFrsPdh/mLo@google.com>
Subject: Re: [RFC PATCH v11 28/29] KVM: selftests: Add basic selftest for guest_memfd()
From:   Sean Christopherson <seanjc@google.com>
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     pbonzini@redhat.com, maz@kernel.org, oliver.upton@linux.dev,
        chenhuacai@kernel.org, mpe@ellerman.id.au, anup@brainfault.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, willy@infradead.org,
        akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, chao.p.peng@linux.intel.com,
        tabba@google.com, jarkko@kernel.org, yu.c.zhang@linux.intel.com,
        vannapurve@google.com, mail@maciej.szmigiero.name, vbabka@suse.cz,
        david@redhat.com, qperret@google.com, michael.roth@amd.com,
        wei.w.wang@intel.com, liam.merwick@oracle.com,
        isaku.yamahata@gmail.com, kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 07, 2023, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> > +	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE, total_size + page_size, page_size);
> > +	TEST_ASSERT(ret, "fallocate beginning at total_size should fail");
> 
> This should be
> 
> TEST_ASSERT(ret, "fallocate beginning after total_size should fail");

Roger that, I'll push a fixup commit directly to kvm-x86/guest_memfd.  Thanks!
