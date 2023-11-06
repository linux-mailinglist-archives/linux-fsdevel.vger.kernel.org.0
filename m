Return-Path: <linux-fsdevel+bounces-2079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3947E2041
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 12:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A618B20DE4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 11:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1232E19BD1;
	Mon,  6 Nov 2023 11:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VNbdkXhi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248FC19443
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 11:44:54 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B752DB
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 03:44:53 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a7af20c488so52160727b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 03:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699271092; x=1699875892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DX7ek6JbnQBP3kmz+KR8GNUYI0kM1PtX+UUHfn3vax8=;
        b=VNbdkXhidZPy2jyspbi+mWrdtQTAWbWJMGSXLu11+BoTws5mX97/h8fnfNA2YHtR5S
         pnSp6VIcooBGySQ96XECwJsRn8RkrAcwbf3JvjIjxo64IBBjH/0Zu9xnHEBEONaYyOLj
         vYNm4iuT6bI/bFTiOGU7PSeQbSxO6+teJD5HvjyRtsnE8XVrbM/dzsrEr3Wpj8dvrZJk
         xFnBnhx+hcTEr4GABAKg8/+16QKYDcjnPmmWrFTXhEpt52YBY12duJbTG+Fve8R7qKlr
         cLgqhf062bF0xiH5sfOKCGAkieIs5cLBUFyjGkEBC/yUPlx0auzSTpJa1FXbpwwTqgB9
         pbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699271092; x=1699875892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DX7ek6JbnQBP3kmz+KR8GNUYI0kM1PtX+UUHfn3vax8=;
        b=UYZVP3LakM1gYuefIsrHC0x5pHUHMBO/FZxip0JNiObFiG28xpdEuzSQE2agoSnaxt
         pDDTLNM3u1f0Thidmam97I2OSO5FThvAFwqiu7bEeBYYFTcQy62hE4NliQgRfwk2FJCk
         25Ay5IxBMHpPPKdBKf8kU12+iTCySxq7ULA15sccqlZpJ1yNYz03H3nip8zPIKr7WcsA
         LSQ5asVeWUmM23Cc7aea5yP3RW/8TgaQqM/ELTMXkKj3uvmm32ci0uShjNGKH124+X9h
         rSU8MJ5sfNBHrTLjOagqXYZqvYT+NYKiCQMpWi8AYR/Frwb/9HttiBeV916+1XisDEQH
         c/Hw==
X-Gm-Message-State: AOJu0YyP5BDSYk3+IhW/DksVaW65myCe07r2vhKwF9nc/cijw23EaEOM
	Le7BNb7pKG2/SAS5DIAmTVygqGtbFMrWGncIGfNLHA==
X-Google-Smtp-Source: AGHT+IERnN25ZpQWhSoveHYhjH1bHINt0TuAVLiTz7wZcF5ueihZgXoSAZV3dV6i7b/f23cd983VPNMQFTyQCDpDsN0=
X-Received: by 2002:a0d:ccc5:0:b0:5a7:e4fe:ea3 with SMTP id
 o188-20020a0dccc5000000b005a7e4fe0ea3mr10768851ywd.22.1699271092440; Mon, 06
 Nov 2023 03:44:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231105163040.14904-1-pbonzini@redhat.com> <20231105163040.14904-27-pbonzini@redhat.com>
In-Reply-To: <20231105163040.14904-27-pbonzini@redhat.com>
From: Fuad Tabba <tabba@google.com>
Date: Mon, 6 Nov 2023 11:44:16 +0000
Message-ID: <CA+EHjTymGLsfHvdP4fPOFWTtaRwbtbCOBZ0XOC3gsX+nYm-cZQ@mail.gmail.com>
Subject: Re: [PATCH 26/34] KVM: selftests: Add helpers to do
 KVM_HC_MAP_GPA_RANGE hypercalls (x86)
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Huacai Chen <chenhuacai@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Sean Christopherson <seanjc@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
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
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 5, 2023 at 4:34=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> From: Vishal Annapurve <vannapurve@google.com>
>
> Add helpers for x86 guests to invoke the KVM_HC_MAP_GPA_RANGE hypercall,
> which KVM will forward to userspace and thus can be used by tests to
> coordinate private<=3D>shared conversions between host userspace code and
> guest code.
>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> [sean: drop shared/private helpers (let tests specify flags)]
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Message-Id: <20231027182217.3615211-29-seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>  .../selftests/kvm/include/x86_64/processor.h      | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/too=
ls/testing/selftests/kvm/include/x86_64/processor.h
> index 25bc61dac5fb..a84863503fcb 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> @@ -15,6 +15,7 @@
>  #include <asm/msr-index.h>
>  #include <asm/prctl.h>
>
> +#include <linux/kvm_para.h>
>  #include <linux/stringify.h>
>
>  #include "../kvm_util.h"
> @@ -1194,6 +1195,20 @@ uint64_t kvm_hypercall(uint64_t nr, uint64_t a0, u=
int64_t a1, uint64_t a2,
>  uint64_t __xen_hypercall(uint64_t nr, uint64_t a0, void *a1);
>  void xen_hypercall(uint64_t nr, uint64_t a0, void *a1);
>
> +static inline uint64_t __kvm_hypercall_map_gpa_range(uint64_t gpa,
> +                                                    uint64_t size, uint6=
4_t flags)
> +{
> +       return kvm_hypercall(KVM_HC_MAP_GPA_RANGE, gpa, size >> PAGE_SHIF=
T, flags, 0);
> +}
> +
> +static inline void kvm_hypercall_map_gpa_range(uint64_t gpa, uint64_t si=
ze,
> +                                              uint64_t flags)
> +{
> +       uint64_t ret =3D __kvm_hypercall_map_gpa_range(gpa, size, flags);
> +
> +       GUEST_ASSERT(!ret);
> +}
> +
>  void __vm_xsave_require_permission(uint64_t xfeature, const char *name);
>
>  #define vm_xsave_require_permission(xfeature)  \
> --
> 2.39.1
>
>

