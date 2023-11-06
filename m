Return-Path: <linux-fsdevel+bounces-2080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590B77E2045
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 12:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8951F1C20B83
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 11:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569E01A5A4;
	Mon,  6 Nov 2023 11:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4IwvNUR5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2DA1A596
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 11:45:26 +0000 (UTC)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F466CC
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 03:45:24 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-66d0760cd20so36241176d6.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 03:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699271123; x=1699875923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3+w7KiTzzQhCpJeg/0ek2R61CW1ssLM/7mTLxlOjqg=;
        b=4IwvNUR5qOPvn1KUD3+tl3uxvbjObIJMmG7O40nSKxNFcgMPoKK4MylCFywjpLnL6D
         CmFllknfWqjSUUI24y0/vVnrW23F0TciCzyTQ6EC74Sy2kgi8ZRg9ith8W2cAvMT/VtC
         DGwrVxqW2FT8pumfrCbLfJha50h5gSVuv+3ndrtxkKKSOv4H22ypNPsA8Fvr+bDMD6VA
         VrjsakR+SrzRRDUh/Tx/3hHz1viVqHAL4eNfrgVC3N1vAJ4bAYh+u95Cy6FOpuniWoP1
         9npXtgTaqaYJiaM8m4XVOZAS6IE6y2tLReV89otrKduKzHF8ThDRw+tUJhXsxM1+kQqh
         k0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699271123; x=1699875923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3+w7KiTzzQhCpJeg/0ek2R61CW1ssLM/7mTLxlOjqg=;
        b=iBlu8zi1rQL2pYpaLgSAc38qFjDcW7TRlkexlLLD7Vdz9mlWDVvUieH9vBfVoh/cG9
         +GeaK8CgJIOM7orzb1Jwv92XQItdKp0sx7rWTqNKZWxgea1aKhoJY3UNSBDunadK24Qm
         0d4WiUGqkOPYA7MtbTRBDIuo9iX63Z1fyosHAWwH9EY7wVqT+rEmQEBvka8airQoRyhL
         MZFU9jZlvuy3NUaApdbtYVxpcp/nZNBLMK0FsCr4xVDBgTOaBwKzt1NTvGeuQmZnyaMd
         ujQ1Nm7H5nJ8AiLs39JWXjmRwI5UhsvzAWBPN3xR8oj+cGFoUwz5mI0nuiVlCic+JjwQ
         aD8A==
X-Gm-Message-State: AOJu0YwLhNcUo28DAKBRekSy0mZSj5HO7abcdQIuFlxLLLEfWTqT97lh
	KUrG4n2PgtaugyqSpY2zO0fMOkZyBrPkC2VvXRo2pA==
X-Google-Smtp-Source: AGHT+IEl8/TeQ8yyhv97l+6UdWpd06zPBShx21QRSHFWAyL7jvCOyQqirpZN3XS/gBNGYYwpqQ32Yp/yP3xLHN3ZnjE=
X-Received: by 2002:a05:6214:252f:b0:66d:13c2:1c31 with SMTP id
 gg15-20020a056214252f00b0066d13c21c31mr13196146qvb.24.1699271123298; Mon, 06
 Nov 2023 03:45:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231105163040.14904-1-pbonzini@redhat.com> <20231105163040.14904-29-pbonzini@redhat.com>
In-Reply-To: <20231105163040.14904-29-pbonzini@redhat.com>
From: Fuad Tabba <tabba@google.com>
Date: Mon, 6 Nov 2023 11:44:47 +0000
Message-ID: <CA+EHjTyxH9JNL67Kz0y90CjrP_HMhmePav7qukJvMOcJrk81pg@mail.gmail.com>
Subject: Re: [PATCH 28/34] KVM: selftests: Add GUEST_SYNC[1-6] macros for
 synchronizing more data
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
> From: Sean Christopherson <seanjc@google.com>
>
> Add GUEST_SYNC[1-6]() so that tests can pass the maximum amount of
> information supported via ucall(), without needing to resort to shared
> memory.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Message-Id: <20231027182217.3615211-31-seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>  tools/testing/selftests/kvm/include/ucall_common.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/include/ucall_common.h b/tools/t=
esting/selftests/kvm/include/ucall_common.h
> index ce33d306c2cb..0fb472a5a058 100644
> --- a/tools/testing/selftests/kvm/include/ucall_common.h
> +++ b/tools/testing/selftests/kvm/include/ucall_common.h
> @@ -52,6 +52,17 @@ int ucall_nr_pages_required(uint64_t page_size);
>  #define GUEST_SYNC_ARGS(stage, arg1, arg2, arg3, arg4) \
>                                 ucall(UCALL_SYNC, 6, "hello", stage, arg1=
, arg2, arg3, arg4)
>  #define GUEST_SYNC(stage)      ucall(UCALL_SYNC, 2, "hello", stage)
> +#define GUEST_SYNC1(arg0)      ucall(UCALL_SYNC, 1, arg0)
> +#define GUEST_SYNC2(arg0, arg1)        ucall(UCALL_SYNC, 2, arg0, arg1)
> +#define GUEST_SYNC3(arg0, arg1, arg2) \
> +                               ucall(UCALL_SYNC, 3, arg0, arg1, arg2)
> +#define GUEST_SYNC4(arg0, arg1, arg2, arg3) \
> +                               ucall(UCALL_SYNC, 4, arg0, arg1, arg2, ar=
g3)
> +#define GUEST_SYNC5(arg0, arg1, arg2, arg3, arg4) \
> +                               ucall(UCALL_SYNC, 5, arg0, arg1, arg2, ar=
g3, arg4)
> +#define GUEST_SYNC6(arg0, arg1, arg2, arg3, arg4, arg5) \
> +                               ucall(UCALL_SYNC, 6, arg0, arg1, arg2, ar=
g3, arg4, arg5)
> +
>  #define GUEST_PRINTF(_fmt, _args...) ucall_fmt(UCALL_PRINTF, _fmt, ##_ar=
gs)
>  #define GUEST_DONE()           ucall(UCALL_DONE, 0)
>
> --
> 2.39.1
>
>

