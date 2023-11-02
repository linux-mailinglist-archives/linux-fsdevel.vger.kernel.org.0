Return-Path: <linux-fsdevel+bounces-1830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDF47DF4C0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 15:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446F7281BA8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 14:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0D91BDEB;
	Thu,  2 Nov 2023 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OsLIgabC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E32D1B285
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 14:17:27 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA37185
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 07:17:26 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-66d13ac2796so5626296d6.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 07:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698934645; x=1699539445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7O2KSplInLsDb19B+zn/jm8iaKKD/NZ+yWSezVEL04=;
        b=OsLIgabCoGKVlVZSp8tm2b2oZ9ZHoUwL2ONfJDXKG7vLOh9Gy0Q7creS9+9vSDkWXo
         J4xO3IfflUSoz3agNqV8SLG0gC3te/x7TZ6sYp2bdeugnbXNHrdXCRBRSWhOzHl2XBY7
         wGZgK9FUiGVmDp3dikT6mr4V2SLGfpYH3fJHliQdXLxkK67GEghvvvL9gs168X/DP0Gi
         3e/4Cvdsx7r3PCHKdyc3vDTgChBRl+AE0wFDw/BxswdRpDyk/eUcDLWQUAL3WRayU5k7
         Z8q5wNFPiOne9g28KQTrHgWxLH4nylI+k2KnZFOk1VzNYCJERVO5Qw6Bos7EnD7outx6
         Gcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698934645; x=1699539445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7O2KSplInLsDb19B+zn/jm8iaKKD/NZ+yWSezVEL04=;
        b=w8c9kTCcMsm51mGbrj8ZvhQutAleOTHgJ7tP+wvsvf0YWDE4mtgafPL4KgG5kyDydl
         MXZApi5FvxB4WYfM2KKFkoARohPhskEVqBuuHpj+59JOIOZpJYeDf+XWBBDiPIADPeLG
         9Hk/kh76bPY7j2npHREnHZ71ZqyBdS6uYiLGj1FrgQDwKva6Rjgd6S19xTon/XfdYuzZ
         XDDeN/MZeE8QcdQCkNmIDrOircOGFdNZI1kzTJwkkATKGR/fXR6euL/pyk+bNuOLb52C
         B4H/the6SnwS2vSBsIb2g7+ZuwQoJcGETw/S8WzrAtWVyqf+QwRgTmOhwQwG5dl9GmP3
         dnBQ==
X-Gm-Message-State: AOJu0Yyj12py17Qi7VLjS6diF2rv+h73bK09kg5Yt3zf6GdFvkShe0oC
	PmrDkaYT93Fnq8yPTTOYmBAr1REEWz8WKpgbS1OhnQ==
X-Google-Smtp-Source: AGHT+IGAosxm/0woyiCy5wtpQ5hw9PNiMnNT8Y+nXK7zRiDLlPKvw69895suNy2q5wz5DwPz9Dn0X+ha5Vtg4tVBUZc=
X-Received: by 2002:a05:6214:d88:b0:66d:3a0f:97a with SMTP id
 e8-20020a0562140d8800b0066d3a0f097amr20020837qve.6.1698934645120; Thu, 02 Nov
 2023 07:17:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-19-seanjc@google.com>
In-Reply-To: <20231027182217.3615211-19-seanjc@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 2 Nov 2023 14:16:49 +0000
Message-ID: <CA+EHjTwXdntKGMjb8Zj1M3iVVN5NX6iLwbzJjE72j_eVczTQYw@mail.gmail.com>
Subject: Re: [PATCH v13 18/35] KVM: x86: "Reset" vcpu->run->exit_reason early
 in KVM_RUN
To: Sean Christopherson <seanjc@google.com>
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
	Isaku Yamahata <isaku.yamahata@intel.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Vlastimil Babka <vbabka@suse.cz>, Vishal Annapurve <vannapurve@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Maciej Szmigiero <mail@maciej.szmigiero.name>, 
	David Hildenbrand <david@redhat.com>, Quentin Perret <qperret@google.com>, 
	Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>, 
	Liam Merwick <liam.merwick@oracle.com>, Isaku Yamahata <isaku.yamahata@gmail.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 7:23=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Initialize run->exit_reason to KVM_EXIT_UNKNOWN early in KVM_RUN to reduc=
e
> the probability of exiting to userspace with a stale run->exit_reason tha=
t
> *appears* to be valid.
>
> To support fd-based guest memory (guest memory without a corresponding
> userspace virtual address), KVM will exit to userspace for various memory
> related errors, which userspace *may* be able to resolve, instead of usin=
g
> e.g. BUS_MCEERR_AR.  And in the more distant future, KVM will also likely
> utilize the same functionality to let userspace "intercept" and handle
> memory faults when the userspace mapping is missing, i.e. when fast gup()
> fails.
>
> Because many of KVM's internal APIs related to guest memory use '0' to
> indicate "success, continue on" and not "exit to userspace", reporting
> memory faults/errors to userspace will set run->exit_reason and
> corresponding fields in the run structure fields in conjunction with a
> a non-zero, negative return code, e.g. -EFAULT or -EHWPOISON.  And becaus=
e
> KVM already returns  -EFAULT in many paths, there's a relatively high
> probability that KVM could return -EFAULT without setting run->exit_reaso=
n,
> in which case reporting KVM_EXIT_UNKNOWN is much better than reporting
> whatever exit reason happened to be in the run structure.
>
> Note, KVM must wait until after run->immediate_exit is serviced to
> sanitize run->exit_reason as KVM's ABI is that run->exit_reason is
> preserved across KVM_RUN when run->immediate_exit is true.
>
> Link: https://lore.kernel.org/all/20230908222905.1321305-1-amoorthy@googl=
e.com
> Link: https://lore.kernel.org/all/ZFFbwOXZ5uI%2Fgdaf@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>  arch/x86/kvm/x86.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ee3cd8c3c0ef..f41dbb1465a0 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10963,6 +10963,7 @@ static int vcpu_run(struct kvm_vcpu *vcpu)
>  {
>         int r;
>
> +       vcpu->run->exit_reason =3D KVM_EXIT_UNKNOWN;
>         vcpu->arch.l1tf_flush_l1d =3D true;
>
>         for (;;) {
> --
> 2.42.0.820.g83a721a137-goog
>

