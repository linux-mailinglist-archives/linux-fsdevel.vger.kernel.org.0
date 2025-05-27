Return-Path: <linux-fsdevel+bounces-49913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E36AC504A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 15:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB08817C0E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 13:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F71A276051;
	Tue, 27 May 2025 13:55:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790CD2701A4;
	Tue, 27 May 2025 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354107; cv=none; b=uLVHfutd5Fb6/hkf5G3Ps++Q3QUNbARvn1dFqu42wYeS6B1/vq7Eqwr+30nlFqfmWxyLAzEqLbxK8tfWgvBhJcv0eAjVfidqbIaOHFAD2LWkUiTiMuWctQQe27pBo1TIFvvpq4mkh5eesyXQWFX0qxBxc8sERIK+nxQSwwu8kKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354107; c=relaxed/simple;
	bh=4/SGG2Bk0JiQCCOE/gDVKw4qap5CovIpn4iXb2SrN8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vAKofP4IucW4YyRTAyJ/IIDUDGN3Hnx4Yf6RObFNTd/O/+Sz+THgoeT4LCJgp90cKrHe2L9mwazg2/a0W6YXfsifbr6QJHcCNpr5l0dMF9CHdbuplfrtbugvL3HatYbnxc50PQ28c6ah6O/6bb3oVg69RwPZVyxPO18e/lk8Nsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-87df3dffe63so735261241.3;
        Tue, 27 May 2025 06:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748354104; x=1748958904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/Vdr1VTrt5GYAjmcNgZJxbWiv4qDWgZ9ZhfhAkHC1Y=;
        b=B2nblaN7g/yptyo1npxQwfNICWlXIAtPZwz4kZTxux2TAbtQSdaZ/9hF2dbWBWmSyd
         wqEu5KDTL4t/X7MFi68vkESUEVmxqG0w9UnEmjXR2zQcPZQzF2qc89ReB8EB+RcApJVS
         vfVCTfL79+izCbgbciJG5S03R3Dp1DXNCDU4IlnnhiAxRcVwLp3rH3rQA1RwO/Gk0fZF
         9Wzy1K/pcBq0DuFwcaodvwyCvLgwEVKOFH5PFgm52W/8p1pPEQRZW4xmgMg3T4wdRHWT
         BL75nYMHQlkh+achtlxhtfd7L1jf4J944bMhbop/Dp8I2atVB/J9fXDrvvskp5wpVU0+
         IstQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBJj7mKxd1VDZpxbqAXIwcxA5n8gYxP4iHdFqG1dm88KuWaYfBxkAfFcWDfWJDWL+rqLvHbfyfNkNSntU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxTz/ObKSXym9jjp2mmgElsLMJ4EsrBsNjOnhYjnu6ISavZycy
	bw/kpKni3ebJdAinFLazcX0HYzJFZ5zWUbdumKvRCCLLkqK/NR5m+rJX6gTP4dOa
X-Gm-Gg: ASbGnctktTTzNRr+xpr3RMCNg1SKmGUM70ThrHupbLkZEj00FhB6hk1q7SN7L1BPhVc
	A429umD2imgAR2nkCW/DuwuM2qUKM/6LMQn+SEDW+3/taPhdngM/WZvX6vQ57BxLvSPvju7XnRP
	tnr23vPW6YYWpk7JFWkugZHkltKOtbzYpscFO27fLKpA7DL8iJyOITuT2IFwxjSB5T6ZfL6mNDM
	mWSvwQFIrj5nBxkfteg2ZSHhWnJT1Dn6SFl0vgw0/pxzZ/Is7sT4Lf8EhvIaaPSaYQmm3a5iCJp
	44v73QOc0tY9QQqthrdE+xA6wyPvMr+6eOnCpsWbL0CFgg1UE5wo+X/eFmv4f4H2lCiq9KsXFqq
	eS56iJDSMoQIMfgsRba859PM/
X-Google-Smtp-Source: AGHT+IEur0XS+glvvRe2RAFGHFB4R/j50UQGtdYP0Lx0mKcLnCVH/UpkTVcgLBC8/vfygWvtgAcdsA==
X-Received: by 2002:a05:6102:32ca:b0:4db:154f:46c2 with SMTP id ada2fe7eead31-4e424069c04mr9785834137.1.1748354103868;
        Tue, 27 May 2025 06:55:03 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87def1c1f2esm5041046241.34.2025.05.27.06.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 06:55:03 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4e2534c08a5so913248137.1;
        Tue, 27 May 2025 06:55:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW4984DcZYQn5ToA7rRbA4sMnqWIO206atR+ulvIZCL8MaEVhMJDEQVyGr5nln/roBfHqE1mNZCfpsdshc=@vger.kernel.org
X-Received: by 2002:a05:6102:418c:b0:4e5:9380:9c25 with SMTP id
 ada2fe7eead31-4e59380a399mr1083782137.3.1748354096301; Tue, 27 May 2025
 06:54:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415-kanufahren-besten-02ac00e6becd@brauner>
In-Reply-To: <20250415-kanufahren-besten-02ac00e6becd@brauner>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 May 2025 15:54:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWG5WRf2iP7UABCXMfdy67QHnwPbTEiqt47_7L3=T6jEQ@mail.gmail.com>
X-Gm-Features: AX0GCFv80_VToSfGTvb_hzSwaPcwWfiShLhbpKQer9N8hFIm4Nc_itXj0xnmNpA
Message-ID: <CAMuHMdWG5WRf2iP7UABCXMfdy67QHnwPbTEiqt47_7L3=T6jEQ@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: remove uselib() system call
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

Hi Christian,

On Tue, 15 Apr 2025 at 10:31, Christian Brauner <brauner@kernel.org> wrote:
> This system call has been deprecated for quite a while now.
> Let's try and remove it from the kernel completely.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Thanks for your patch, which is now commit 79beea2db0431536 ("fs:
remove uselib() system call") upstream.

> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -479,16 +479,6 @@ config CROSS_MEMORY_ATTACH
>           to directly read from or write to another process' address space.
>           See the man page for more details.
>
> -config USELIB
> -       bool "uselib syscall (for libc5 and earlier)"
> -       default ALPHA || M68K || SPARC
> -       help
> -         This option enables the uselib syscall, a system call used in the
> -         dynamic linker from libc5 and earlier.  glibc does not use this
> -         system call.  If you intend to run programs built on libc5 or
> -         earlier, you may need to enable this syscall.  Current systems
> -         running glibc can safely disable this.
> -
>  config AUDIT
>         bool "Auditing support"
>         depends on NET

FTR, after this m68k machines can still boot the good old
filesys-ELF-2.0.x-1400K-2.gz ramdisk (containing libc5 and these new
kind of binaries called "ELF" ;-) from 1996 fine.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

