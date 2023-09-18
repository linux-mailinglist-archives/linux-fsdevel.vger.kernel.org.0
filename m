Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DFC7A4F53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 18:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjIRQji (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 12:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjIRQj0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:39:26 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B4C10FC
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 09:11:13 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id af79cd13be357-770ef0da402so645107785a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 09:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695053469; x=1695658269; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s17YssV/eLMk3v6BQw21PztJLVQ1uDSUDnGyHA0nJic=;
        b=Pf0uantrF+RzAFRz1qpK4UaMwpYPF17vcpE3tC0+3Q59OE56AN5m6O7zE+Cwlt1Uir
         +r3LlvxyYYV950xXlHBLcF0eOdlzI8rW6saruEAmkW1LTiFlG/I0Vd67chRj7ZO20m6F
         U6gp7WwTt7JHS/ldMNHgUKMTH9cUHGA47dyev/mgBerwaCDIiBM5t3QrVfZdWmAX35nU
         6/vMIfqdKZW7oQpuEj5Ptr9CPDZZxChgYNPl+JiqG1dk6sSQs+RBg8eo8peEEDCxcigW
         iQCMguaAv116nhVzkBnGoaM6n700d+zSu5S50b3wpgZn3yCDF19+ib49cN8T0vyC4Itq
         6urA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695053469; x=1695658269;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s17YssV/eLMk3v6BQw21PztJLVQ1uDSUDnGyHA0nJic=;
        b=gjFU+/ESIquZ2Kgg6F0D9DAOVxZHeNvNOwaeZc9AcRlBN2XACKCZsFqvpAJPQ/O5GG
         pRpul0CfyRO1aZTpTo/bfsdLTmkjnKO6pXt9fiEwv5BiND293jls8J2zZE3YB0XMuZ5K
         Sw1H/FUnDCQOZEFLxUWGQSLWQhNcPVhT2vHsXC5oWgmsyCe6D0mz2gJeY/89G+sULuBL
         kYbmp0kyiktTFOZ4LP1MOsBuf37dKE+9MuSkOmOVx8/0U8tMEVEhpWkyyVC36XRwOZjE
         LZNwrvk53aj8z3W6CNk+ZjhlP/HoMN+ytb6fZoCE9B/dehXQPb89PrG3+Zx+wofCVOyI
         /75A==
X-Gm-Message-State: AOJu0YyoASaEE1oW+ebl7TjOLdaos/Clakn7qXkvnU9Eic1YV+wY5aHh
        yuG6sx2tq8Nb24OCdMnc60j+ke0vXDw=
X-Google-Smtp-Source: AGHT+IFqXVMaW5EWUR3sn7RRHAULv1S9Ax+JzluU+Y462jgw29bgpZAEkbL739S68Hx7QOlYkiFqSLcGAUw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:4cf:b0:d7f:f3e:74ab with SMTP id
 v15-20020a05690204cf00b00d7f0f3e74abmr227961ybs.1.1695052667494; Mon, 18 Sep
 2023 08:57:47 -0700 (PDT)
Date:   Mon, 18 Sep 2023 08:57:45 -0700
In-Reply-To: <9925e01b-7fa9-95e4-dc21-1d760ef9cde4@linux.intel.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com> <20230914015531.1419405-11-seanjc@google.com>
 <9925e01b-7fa9-95e4-dc21-1d760ef9cde4@linux.intel.com>
Message-ID: <ZQhzeQLbB5zz2yIc@google.com>
Subject: Re: [RFC PATCH v12 10/33] KVM: Set the stage for handling only shared
 mappings in mmu_notifier events
From:   Sean Christopherson <seanjc@google.com>
To:     Binbin Wu <binbin.wu@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
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
        "Serge E. Hallyn" <serge@hallyn.com>,
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
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023, Binbin Wu wrote:
> 
> 
> On 9/14/2023 9:55 AM, Sean Christopherson wrote:
> > Add flags to "struct kvm_gfn_range" to let notifier events target only
> > shared and only private mappings, and write up the existing mmu_notifier
> > events to be shared-only (private memory is never associated with a
> > userspace virtual address, i.e. can't be reached via mmu_notifiers).
> > 
> > Add two flags so that KVM can handle the three possibilities (shared,
> > private, and shared+private) without needing something like a tri-state
> > enum.
> 
> How to understand the word "stage" in short log?

Sorry, it's an idiom[*] that essentially means "to prepare for".  I'll rephrase
the shortlog to be more straightforward (I have a bad habit of using idioms).

[*] https://dictionary.cambridge.org/us/dictionary/english/set-the-stage-for
