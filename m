Return-Path: <linux-fsdevel+bounces-2108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6847E2961
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 17:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0061B2106E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 16:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE9928E35;
	Mon,  6 Nov 2023 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wFpslrgm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F4328E3A
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 16:04:23 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C35D47
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 08:04:20 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5afa86b8d66so64245407b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 08:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699286659; x=1699891459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBcfSXW+7b0RYZr/CwodaGuIC1t2rSK8z82L7NdJqdg=;
        b=wFpslrgmIgIbaZOnLmqhhsJ9lDbgt0QTYXsM/t9b7FrC5cgpaymNsWQX/WWEoi7FQr
         E/bE/k+zCfeCsDQ6kp5smusq2Mr+EUiKnNmREGKBUaW+YC3SO+yS8VAGYnKZsvJ77fOE
         fMAnL0JHqR6sUtdNJjBm8Aik+fy2iGwNJW9rhJx2SBQ4S4UM5m/tLtDrWXuhjn3+ZHrm
         06Afvfng0cn8QBQcKGDsPnW+8DCJJpE4VHZCoiIaWRFxleb/9ugM75rY0RRFQSVvHZYx
         CeVPu3Fh483VCoEqrQSAnCd1jwLIhpCHNNho6qiGzNqwXXphlYb7mMh8JmrGlazciaNh
         sIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699286659; x=1699891459;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vBcfSXW+7b0RYZr/CwodaGuIC1t2rSK8z82L7NdJqdg=;
        b=MfRsf102il+CHyIb1UlQoI+rWvFiBDqfPeKW4HZk9+XkMpkPS2VarUS1t9qdyTTOzK
         n7n1Th1q+UJ26IdpRSffTEBMxbRhgi/DR7Pa+Fp29MKVP04iqGQWszVYk04vPegl2dHX
         S3e2c65Xdw34ZDkhLJx2yAyr/2XbZoxFZ97EtsfRmCZtLTvUeOuXkNlpFW39r4VBxeUt
         1aK7uqNrOkAMxWCZvGarTZghvYAjJAbe6XhNUEyGNcjI8mz2akZlFwphZzrxLv3nMljl
         edl5nAfxtThN1wB4sP7hMus3CIewwhGI4YVk7rTvVwkXBb/PPYgtsShtCAxL/YwKzldK
         1cRA==
X-Gm-Message-State: AOJu0Ywu/sn989d/lJt8/4+rVIeLl7tHaE09m77AqYBEN1bf6hZlM8s+
	/3gH14dSg768u8CG4JJghheg8CF87hs=
X-Google-Smtp-Source: AGHT+IG4M/eznhqFxpL/eWUumIXP2aANvxiOg95OzhM2lh4aiDVuodrpXWON7UbLhWxQPiRYqqCoKKt9NcE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:830d:0:b0:5a8:6162:b69 with SMTP id
 t13-20020a81830d000000b005a861620b69mr214046ywf.3.1699286659321; Mon, 06 Nov
 2023 08:04:19 -0800 (PST)
Date: Mon, 6 Nov 2023 08:04:17 -0800
In-Reply-To: <CA+EHjTxz-e_JKYTtEjjYJTXmpvizRXe8EUbhY2E7bwFjkkHVFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231105163040.14904-1-pbonzini@redhat.com> <20231105163040.14904-28-pbonzini@redhat.com>
 <CA+EHjTxz-e_JKYTtEjjYJTXmpvizRXe8EUbhY2E7bwFjkkHVFw@mail.gmail.com>
Message-ID: <ZUkOgdTMbH40XFGE@google.com>
Subject: Re: [PATCH 27/34] KVM: selftests: Introduce VM "shape" to allow tests
 to specify the VM type
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
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023, Fuad Tabba wrote:
> On Sun, Nov 5, 2023 at 4:34=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
> >
> > From: Sean Christopherson <seanjc@google.com>
> >
> > Add a "vm_shape" structure to encapsulate the selftests-defined "mode",
> > along with the KVM-defined "type" for use when creating a new VM.  "mod=
e"
> > tracks physical and virtual address properties, as well as the preferre=
d
> > backing memory type, while "type" corresponds to the VM type.
> >
> > Taking the VM type will allow adding tests for KVM_CREATE_GUEST_MEMFD,
> > a.k.a. guest private memory, without needing an entirely separate set o=
f
> > helpers.  Guest private memory is effectively usable only by confidenti=
al
> > VM types, and it's expected that x86 will double down and require uniqu=
e
> > VM types for TDX and SNP guests.
> >
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > Message-Id: <20231027182217.3615211-30-seanjc@google.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
>=20
> nit: as in a prior selftest commit messages, references in the commit
> message to guest _private_ memory. Should these be changed to just
> guest memory?

Hmm, no, "private" is mostly appropriate here.  At this point in time, only=
 x86
supports KVM_CREATE_GUEST_MEMFD, and x86 only supports it for private memor=
y.
And the purpose of letting x86 selftests specify KVM_X86_SW_PROTECTED_VM, i=
.e.
the reason this patch exists, is purely to get private memory.

Maybe tweak the second paragraph to this?

Taking the VM type will allow adding tests for KVM_CREATE_GUEST_MEMFD
without needing an entirely separate set of helpers.  At this time,
guest_memfd is effectively usable only by confidential VM types in the
form of guest private memory, and it's expected that x86 will double down
and require unique VM types for TDX and SNP guests.

