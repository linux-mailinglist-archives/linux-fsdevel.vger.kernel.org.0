Return-Path: <linux-fsdevel+bounces-1674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A9F7DD81E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 23:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E444CB20FC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 22:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC1627445;
	Tue, 31 Oct 2023 22:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/HXjC4K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8874C22311
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 22:18:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B44ED
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 15:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698790699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kfYGCdpNkdX5yz1jUhkJ/3qqRF866UiTHuuzMPk/uy0=;
	b=U/HXjC4KoPV/Btr64/oDMmCFswL4JdEWUn4iFg7PbR6UdUT1dd6oFwZb7jZHNNWz7DNOLc
	IJOCnsxuYILAR6fmdvARcSHeDfsbBnkn+LUGE/ZMRrZUi0MZcHESk15m8WxqI5yX5haiHd
	rYEWAv/sukBArIm1PoLdvJz0Oh2u6PE=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-Z5g8-2OVPCeGRnlS3FGDlg-1; Tue, 31 Oct 2023 18:18:17 -0400
X-MC-Unique: Z5g8-2OVPCeGRnlS3FGDlg-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-7b9b70dd2beso1338039241.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 15:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698790697; x=1699395497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfYGCdpNkdX5yz1jUhkJ/3qqRF866UiTHuuzMPk/uy0=;
        b=KSUxT4vC/+gVY4gv8t1TU7t0pff9fGdNrfZug2BCqAJjhjAOv78OhRuotlVz5rEYPi
         89e1fXtf25fZOY3P0HY4YWf2RC74JPddnYehlT3GebFvIuHh1Mrn+kFF3TBeWXmmbT/K
         oerijNzBod1gnoWLmMbzFCTzklYn0VrSpJDIsCp73c1D+nzc7U0oDYOA1/GFLUmkjk9V
         OeCqHn9eiChDB/MKINnsrYFV7aUId4VoIkkSeLFYrm5Bnty1QjOhFkLcRqBvDDi+5v9n
         ffRma5/+AmY1lMB01bxaQl6CbrJM9+o3Q6/XWMZmoGdl+VHPX1B6BaJMEQFU+CQx04Sy
         hVbw==
X-Gm-Message-State: AOJu0YxDG9cj4WBdLvhSK5X6sRuKS+d/Ammbdzifg76kpLWZIkdJqDqn
	nsozCkKE6aTQlyxEFEPuMPFH1XUVlVAV8GZtMPWa6djkiCx3n51ggclhfOL+GMqH4sCJfSDs6SU
	yT2MgDi1wCQpzOwC/r3lrdS+KQtODdCf5MEYktbJVlg==
X-Received: by 2002:a67:c218:0:b0:44e:99a2:a42 with SMTP id i24-20020a67c218000000b0044e99a20a42mr9981758vsj.11.1698790697103;
        Tue, 31 Oct 2023 15:18:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQrBiQJHLqXrbYP+Ue59NphHDME9ef8CfXr1engDM3UMhS/wxqjXJBm4DCAAdJKCtZSXIUO7Qf2zwxIf8biNY=
X-Received: by 2002:a67:c218:0:b0:44e:99a2:a42 with SMTP id
 i24-20020a67c218000000b0044e99a20a42mr9981736vsj.11.1698790696825; Tue, 31
 Oct 2023 15:18:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-17-seanjc@google.com>
 <CA+EHjTzj4drYKONVOLP19DYpJ4O8kSXcFzw2AKier1QdcFKx_Q@mail.gmail.com> <ZUF8A5KpwpA6IKUH@google.com>
In-Reply-To: <ZUF8A5KpwpA6IKUH@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 31 Oct 2023 23:18:04 +0100
Message-ID: <CABgObfbLonVYk2WE4TC6-J_0ShanY7TbcLXStxji=XDU+9qQ7g@mail.gmail.com>
Subject: Re: [PATCH v13 16/35] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
To: Sean Christopherson <seanjc@google.com>
Cc: Fuad Tabba <tabba@google.com>, Marc Zyngier <maz@kernel.org>, 
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
	Isaku Yamahata <isaku.yamahata@intel.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Vlastimil Babka <vbabka@suse.cz>, Vishal Annapurve <vannapurve@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Maciej Szmigiero <mail@maciej.szmigiero.name>, 
	David Hildenbrand <david@redhat.com>, Quentin Perret <qperret@google.com>, 
	Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>, 
	Liam Merwick <liam.merwick@oracle.com>, Isaku Yamahata <isaku.yamahata@gmail.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 11:13=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> On Tue, Oct 31, 2023, Fuad Tabba wrote:
> > On Fri, Oct 27, 2023 at 7:23=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> Since we now know that at least pKVM will use guest_memfd for shared memo=
ry, and
> odds are quite good that "regular" VMs will also do the same, i.e. will w=
ant
> guest_memfd with the concept of private memory, I agree that we should av=
oid
> PRIVATE.
>
> Though I vote for KVM_MEM_GUEST_MEMFD (or KVM_MEM_GUEST_MEMFD_VALID or
> KVM_MEM_USE_GUEST_MEMFD).  I.e. do our best to avoid ambiguity between re=
ferring
> to "guest memory" at-large and guest_memfd.

I was going to propose KVM_MEM_HAS_GUESTMEMFD.  Any option
is okay for me so, if no one complains, I'll go for KVM_MEM_GUESTMEMFD
(no underscore because I found the repeated "_MEM" distracting).

Paolo


