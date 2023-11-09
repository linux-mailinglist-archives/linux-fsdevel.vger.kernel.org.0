Return-Path: <linux-fsdevel+bounces-2457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A147E61B6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 02:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC91E1C20B7E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 01:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F33DED6;
	Thu,  9 Nov 2023 01:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vhiF8HHM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F6D807
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 01:08:38 +0000 (UTC)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8DF25B8
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 17:08:37 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-581f78a0206so165327eaf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Nov 2023 17:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699492117; x=1700096917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QtjMEn3JvZfL2+9Ot0aHfDjSbnUMOfTRHsLPFnN/cE=;
        b=vhiF8HHMq4Wd8cn65pkEiTzZFRa9GxYRRZtdB96C6qVy7NACqOoJzmTeJiZyFWFmny
         ARgHmOhotHju98RUn3mK9d4iZMGNKJSfyyss/ZULOD5dh/i1cx2TfHlRh6O+DVtmQpMM
         Dt9+mi9o2Uj+vEnt84zDOdgT3j4C8Ytibet3WHgzmJX4mfsS6NfgRvq9WRy+yTf/qAvh
         YsWKLLDiYJPc8Mf4hBxb7nxdVGsvuMemWO61R8M5YC8teqz7Nix6usKWXUfc1SdVDT8D
         982RxBjYKNC9vEVJc/xbU8wP/1kBVn2/cSImQD/Lw8E9oMZbOiycrradqa2WkXNsWDVN
         PyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699492117; x=1700096917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QtjMEn3JvZfL2+9Ot0aHfDjSbnUMOfTRHsLPFnN/cE=;
        b=JUtLKAIyVV2cvhEFYKqrSfwR0df0ItcHoAE5PQVXYP4aeoTNI21pF/bNjzntHlSmLL
         ppggNfyugVNoBh6AVlz9uZTPdlTZvfa42g9MuhDkYff3rpLEcYS9ZAfi8h0OevQF2Rb8
         qcM5QZ3RtGNY0bM+Srldz2Lz7CypoyChLqVZ/gFAwfJFGmm2sFaWqm7WJ+hdWdsSciGo
         3xFHEFIihPVSpDIgScS8Ztxo1brKn2VdzjYv0dsX/HzsN4N2yCk5vAjYeQcNQYZXvnjA
         Ku7CXX3tejItEqXlq1b9kcpmVH15zAebsnnzyeh1c5zK7xi+fS4H8mvJJLGaSp5oNpUt
         eMwg==
X-Gm-Message-State: AOJu0YxPPLwGcJY1ngmkro7XD2AN5MaCVJaLurQwh3L0hR2NgY73AAgp
	IjKjXwvnCx6fGblJYUP/ZxZam7KTKcCzUNudiFKTbg==
X-Google-Smtp-Source: AGHT+IFaOEA03XuxazKl3zVOaUpDe2bAHjHbEU9NUIQA9ZcNh5LArgqxcn+4MTtdSbfjNu4oRqbtO3sH2+Wygyf9VBk=
X-Received: by 2002:a4a:e088:0:b0:587:873d:7e2c with SMTP id
 w8-20020a4ae088000000b00587873d7e2cmr3411182oos.1.1699492116891; Wed, 08 Nov
 2023 17:08:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231105163040.14904-1-pbonzini@redhat.com> <20231105163040.14904-35-pbonzini@redhat.com>
In-Reply-To: <20231105163040.14904-35-pbonzini@redhat.com>
From: Anish Moorthy <amoorthy@google.com>
Date: Wed, 8 Nov 2023 17:08:01 -0800
Message-ID: <CAF7b7mpmuYLTY6OQfRRoOryfO-2e1ZumQ6SCQDHHPD5XFyhFTQ@mail.gmail.com>
Subject: Re: [PATCH 34/34] KVM: selftests: Add a memory region subtest to
 validate invalid flags
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
	Fuad Tabba <tabba@google.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
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

Applying [1] and [2] reveals that this also breaks non-x86 builds- the
MEM_REGION_GPA/SLOT definitions are guarded behind an #ifdef
__x86_64__, while the usages introduced here aren't.

Should

On Sun, Nov 5, 2023 at 8:35=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> +       test_invalid_memory_region_flags();

be #ifdef'd, perhaps? I'm not quite sure what the intent is.

Side note: I wasn't able to get [2] to apply by copy-pasting the diff
and trying "git apply", and that was after checking out the relevant
commit. Eventually I just did it manually. If anyone can successfully
apply it, please let me know what you did so I can see what I was
doing wrong :)

[1] https://lore.kernel.org/kvm/20231108233723.3380042-1-amoorthy@google.co=
m/
[2] https://lore.kernel.org/kvm/affca7a8-116e-4b0f-9edf-6cdc05ba65ca@redhat=
.com/

