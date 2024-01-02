Return-Path: <linux-fsdevel+bounces-7122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 466BA821E07
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 15:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E465B28385D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 14:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F8314A98;
	Tue,  2 Jan 2024 14:47:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8533E14278;
	Tue,  2 Jan 2024 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dbd5b96b12eso6941852276.2;
        Tue, 02 Jan 2024 06:47:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704206843; x=1704811643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekkdo/2BplW5G1QGE0ZikpIwpoAMXqmEuZbikDyIFz0=;
        b=eEDV/TA+yDi9rzS4d29cEX3zzSXoVNRJNzDoGuysOuxpEJEowFV5cGTWrhRu0xSwW7
         QmWsoZyMIPschgscJszqoLfeFv4XxDsQ33aYgdPlJTgwqfu/+P9iYiXq9nLvE23SUxjP
         6+mZklDokedEVLK27xGuVT5AxW9BFLVnTR+WwMsxh6nMFNhhcxyy/OTE2Tdre5Se8lYg
         eMBCvW4SaKM/FgtRDz9wSMTVLUeyEWS3Sy8oTfK86uJPkK2CqNlwiZ6jMxeWVVlqQPOc
         UaGQ9f4KBe+mmtAs1xlOxh8Z68/X5u6T4GHo94+9jIEidX7pkyPfVZAQwp6j3Jo5j6J9
         +f3Q==
X-Gm-Message-State: AOJu0Yzhr/YDWPmrTX0sCNouEozaAkf4LJCFWStKzeAr5UYUD9pvUhtU
	ubOspSxvGMPYz8VSy0cSmsHGrHuA3WY+Dg==
X-Google-Smtp-Source: AGHT+IHPLkt35W4v1MnRFFxzaqNEdOiSs5acLz4CQokv3q6zjgT8/l430U6zonddl1yPA24q8/ZR8Q==
X-Received: by 2002:a5b:752:0:b0:dbd:bc3e:55e3 with SMTP id s18-20020a5b0752000000b00dbdbc3e55e3mr8097056ybq.69.1704206843323;
        Tue, 02 Jan 2024 06:47:23 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id 204-20020a2501d5000000b00dbdb03e146bsm10210496ybb.51.2024.01.02.06.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 06:47:23 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5e7bb1e0db8so73378307b3.0;
        Tue, 02 Jan 2024 06:47:23 -0800 (PST)
X-Received: by 2002:a0d:f6c2:0:b0:5e2:5d71:56c with SMTP id
 g185-20020a0df6c2000000b005e25d71056cmr12772287ywf.32.1704206843051; Tue, 02
 Jan 2024 06:47:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223181101.1954-1-gregory.price@memverge.com> <20231223181101.1954-11-gregory.price@memverge.com>
In-Reply-To: <20231223181101.1954-11-gregory.price@memverge.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 2 Jan 2024 15:47:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXgteq4FSM-ugahDtZq_swM_jFMMonB=K4+A1VjTansLA@mail.gmail.com>
Message-ID: <CAMuHMdXgteq4FSM-ugahDtZq_swM_jFMMonB=K4+A1VjTansLA@mail.gmail.com>
Subject: Re: [PATCH v5 10/11] mm/mempolicy: add the mbind2 syscall
To: Gregory Price <gourry.memverge@gmail.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, x86@kernel.org, akpm@linux-foundation.org, 
	arnd@arndb.de, tglx@linutronix.de, luto@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, mhocko@kernel.org, 
	tj@kernel.org, ying.huang@intel.com, gregory.price@memverge.com, 
	corbet@lwn.net, rakie.kim@sk.com, hyeongtak.ji@sk.com, honggyu.kim@sk.com, 
	vtavarespetr@micron.com, peterz@infradead.org, jgroves@micron.com, 
	ravis.opensrc@micron.com, sthanneeru@micron.com, emirakhur@micron.com, 
	Hasan.Maruf@amd.com, seungjun.ha@samsung.com, Michal Hocko <mhocko@suse.com>, 
	Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 7:14=E2=80=AFPM Gregory Price <gourry.memverge@gmai=
l.com> wrote:
> mbind2 is an extensible mbind interface which allows a user to
> set the mempolicy for one or more address ranges.
>
> Defined as:
>
> mbind2(unsigned long addr, unsigned long len, struct mpol_args *args,
>        size_t size, unsigned long flags)
>
> addr:         address of the memory range to operate on
> len:          length of the memory range
> flags:        MPOL_MF_HOME_NODE + original mbind() flags
>
> Input values include the following fields of mpol_args:
>
> mode:         The MPOL_* policy (DEFAULT, INTERLEAVE, etc.)
> mode_flags:   The MPOL_F_* flags that were previously passed in or'd
>               into the mode.  This was split to hopefully allow future
>               extensions additional mode/flag space.
> home_node:    if (flags & MPOL_MF_HOME_NODE), set home node of policy
>               to this otherwise it is ignored.
> pol_maxnodes: The max number of nodes described by pol_nodes
> pol_nodes:    the nodemask to apply for the memory policy
>
> The semantics are otherwise the same as mbind(), except that
> the home_node can be set.
>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Suggested-by: Frank van der Linden <fvdl@google.com>
> Suggested-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
> Suggested-by: Rakie Kim <rakie.kim@sk.com>
> Suggested-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
> Suggested-by: Honggyu Kim <honggyu.kim@sk.com>
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> Co-developed-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>

>  arch/m68k/kernel/syscalls/syscall.tbl         |  1 +

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

