Return-Path: <linux-fsdevel+bounces-1963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD92D7E0C0A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Nov 2023 00:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F922281F60
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 23:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A77525116;
	Fri,  3 Nov 2023 23:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y34aghm2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2111524A05
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 23:17:28 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B868ED62
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 16:17:25 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5b064442464so36270467b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Nov 2023 16:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699053445; x=1699658245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wL2niLMenc8rXWamhCVdrH1GL3hMVyvGfUspx7X4DS0=;
        b=y34aghm2O6SNvK8GRGqx/sn9ZtIKtyEKMe8V+/zJansECIFreEzwNQdaN7qaCTMxno
         iQyNclZxVpo458htEdZJR3G15cLAf//+VCR0X7Bb9mY8NQfPYk2RLQxot9vowL58J+WQ
         5hHhx/vsC4Fi5BrmYkOcz2Ry0VrZACj8kcr2w0P5oaF34k83fCp/HQQiRzJGW8Gpgnpt
         LE8G4T/CWtPumWqO8WdX3VhR7PfMiIcBYnlzl1o/d6i7pLaKqyDczwP5Xg+Vnz46J/mp
         wCPQ54D8JTsXgyveHL72zftw7M4doAMgz1QNm9HMEpFyaIBnh8OXueGidAopbHc09qPm
         VOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699053445; x=1699658245;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wL2niLMenc8rXWamhCVdrH1GL3hMVyvGfUspx7X4DS0=;
        b=JPbDi2F1LmDEdBKIKiTcIhWQLuYvWhbJDhLn0K4Z4r7+5GLjz33UDaN2vzI6gsHEhu
         AadtuINLqaV6MYwr181YIdiVNzsxaWgi8hsBua9/bxO8nDREs+OwrnNOx1Z7IH4KBXzv
         Qxqkfm/65HoXdwe9lZfkfpPAM3M2kJLqULJJ6thgKDHPgs1sev2nE1hBzKXZDT5UXLbP
         /JsdhppZRWNVlcQjS7h4raiNxx7WV9zpbLNwuz/oERgs+XOL4LWL+YitaaNaqozNfnDw
         NWhJPfBsZvLzSvWiHZIrakQDO84gLCJhFLBWPpfZfn0T2rp5lI5ZipmVvg2nE243jZTY
         d0jA==
X-Gm-Message-State: AOJu0YxeUafvIRZsBdvJ+d7BvJvaIMhskUgCpmgbwf25bPYA6fJ7ZtvO
	6TAvgMWcLDWtQT9nHvHGqeYBhlS1jok=
X-Google-Smtp-Source: AGHT+IGJDyi83TwJx+I35GsLQytKZmA4RJCyClEGAPsqdhhOEgS+Lm1oHaoRVNSHVuwQA3+7WVp40Ul4xUY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4958:0:b0:59f:3cde:b33a with SMTP id
 w85-20020a814958000000b0059f3cdeb33amr84737ywa.6.1699053444944; Fri, 03 Nov
 2023 16:17:24 -0700 (PDT)
Date: Fri, 3 Nov 2023 16:17:23 -0700
In-Reply-To: <CA+EHjTzGzXnfXHh0m5iHt9m3BxerkUS56EVPDA_az6n2FRnk3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-17-seanjc@google.com>
 <CA+EHjTzj4drYKONVOLP19DYpJ4O8kSXcFzw2AKier1QdcFKx_Q@mail.gmail.com>
 <ZUF8A5KpwpA6IKUH@google.com> <CA+EHjTwTT9cFzYTtwT43nLJS01Sgt0NqzUgKAnfo2fiV3tEvXg@mail.gmail.com>
 <ZULJYg5cf1UrNq3e@google.com> <CA+EHjTzGzXnfXHh0m5iHt9m3BxerkUS56EVPDA_az6n2FRnk3w@mail.gmail.com>
Message-ID: <ZUV_g1_3pj62OgF-@google.com>
Subject: Re: [PATCH v13 16/35] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
From: Sean Christopherson <seanjc@google.com>
To: Fuad Tabba <tabba@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Huacai Chen <chenhuacai@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Xu Yilun <yilun.xu@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Anish Moorthy <amoorthy@google.com>, 
	David Matlack <dmatlack@google.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, Vlastimil Babka <vbabka@suse.cz>, 
	Vishal Annapurve <vannapurve@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Maciej Szmigiero <mail@maciej.szmigiero.name>, David Hildenbrand <david@redhat.com>, 
	Quentin Perret <qperret@google.com>, Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>, 
	Liam Merwick <liam.merwick@oracle.com>, Isaku Yamahata <isaku.yamahata@gmail.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2023, Fuad Tabba wrote:
> On Wed, Nov 1, 2023 at 9:55=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> > E.g. a misbehaving userspace could prematurely delete a memslot.  And t=
he more
> > fun example is intrahost migration, where the plan is to allow pointing=
 multiple
> > guest_memfd files at a single guest_memfd inode:
> > https://lore.kernel.org/all/cover.1691446946.git.ackerleytng@google.com
> >
> > There was a lot of discussion for this, but it's scattered all over the=
 place.
> > The TL;DR is is that the inode will represent physical memory, and a fi=
le will
> > represent a given "struct kvm" instance's view of that memory.  And so =
the memory
> > isn't reclaimed until the inode is truncated/punched.
> >
> > I _think_ this reflects the most recent plan from the guest_memfd side:
> > https://lore.kernel.org/all/1233d749211c08d51f9ca5d427938d47f008af1f.16=
89893403.git.isaku.yamahata@intel.com

Doh, sitting in my TODO folder...

https://lore.kernel.org/all/20231016115028.996656-1-michael.roth@amd.com

> Thanks for pointing that out. I think this might be the way to go.
> I'll have a closer look at this and see how to get it to work with
> pKVM.

