Return-Path: <linux-fsdevel+bounces-7121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5B1821DCD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 15:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89FCF1F22D50
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 14:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278BD125B5;
	Tue,  2 Jan 2024 14:38:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8208311722;
	Tue,  2 Jan 2024 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dbe344a6cf4so2910306276.0;
        Tue, 02 Jan 2024 06:38:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704206310; x=1704811110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AObwZt7UaKxT4p/1Mc6Gm1CxPN5HAmUYwmfKr7LdX4E=;
        b=HCs35ZYcJ3Cl0q39Hx3v56JwtNjrRm5UpvUfM1xTbl4L7XQtkCYVygHhEbyPh27hhn
         TSLvYQmqA4kPEF+gdTTJ66CgXwvjIOoj40faIq8/8lZjaf+f2NUVM54z/aer735WLn8/
         ZSMIQtyot0RABKP+KTe1T1Fij+HHfLBOXGzX9e9NjlpDLHn0tTLw2JoAFlwQWpgXu2cp
         RvpSRHPlGPXaXBABXmlseX5YMhqRlmZVM5oVgUVkK9RJyrfviLn8ypI5oFNc010tl3P/
         /LWJCQmL3jhDtX2unhmqjdPx0a1sIjdARvjrQ37Fwhv50QL3WqIMNpLLAHLQQg6Dh7bb
         EeOA==
X-Gm-Message-State: AOJu0Yz+jitWoUFmPaWqxV/WhN2u4454MkqdpHIpnldLDTCyrzC9Iegt
	bmpPh4ObTn4iZ4BOgS1+jCm6i8ifc+d/iw==
X-Google-Smtp-Source: AGHT+IHpwoMJxkzddqYzlbmp30hA/Wm7Bk7Qjql2+o4qZxLYPIbpaG2ucyxYAh3smW/9bB/1FrJu9w==
X-Received: by 2002:a25:ada5:0:b0:dbc:ec6b:3e47 with SMTP id z37-20020a25ada5000000b00dbcec6b3e47mr9878503ybi.33.1704206310511;
        Tue, 02 Jan 2024 06:38:30 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id v17-20020a258491000000b00db5380fc1absm9962074ybk.19.2024.01.02.06.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 06:38:30 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5edfcba97e3so47552437b3.2;
        Tue, 02 Jan 2024 06:38:30 -0800 (PST)
X-Received: by 2002:a81:88c1:0:b0:5d2:5caf:759 with SMTP id
 y184-20020a8188c1000000b005d25caf0759mr12335901ywf.22.1704206308913; Tue, 02
 Jan 2024 06:38:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223181101.1954-1-gregory.price@memverge.com> <20231223181101.1954-9-gregory.price@memverge.com>
In-Reply-To: <20231223181101.1954-9-gregory.price@memverge.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 2 Jan 2024 15:38:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVur0O-Df1jN8SC0wbfPv7o7yZNt2UsupAw2NJjz-bWSw@mail.gmail.com>
Message-ID: <CAMuHMdVur0O-Df1jN8SC0wbfPv7o7yZNt2UsupAw2NJjz-bWSw@mail.gmail.com>
Subject: Re: [PATCH v5 08/11] mm/mempolicy: add set_mempolicy2 syscall
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
	Hasan.Maruf@amd.com, seungjun.ha@samsung.com, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 7:13=E2=80=AFPM Gregory Price <gourry.memverge@gmai=
l.com> wrote:
> set_mempolicy2 is an extensible set_mempolicy interface which allows
> a user to set the per-task memory policy.
>
> Defined as:
>
> set_mempolicy2(struct mpol_args *args, size_t size, unsigned long flags);
>
> relevant mpol_args fields include the following:
>
> mode:         The MPOL_* policy (DEFAULT, INTERLEAVE, etc.)
> mode_flags:   The MPOL_F_* flags that were previously passed in or'd
>               into the mode.  This was split to hopefully allow future
>               extensions additional mode/flag space.
> home_node:    ignored (see note below)
> pol_nodes:    the nodemask to apply for the memory policy
> pol_maxnodes: The max number of nodes described by pol_nodes
>
> The usize arg is intended for the user to pass in sizeof(mpol_args)
> to allow forward/backward compatibility whenever possible.
>
> The flags argument is intended to future proof the syscall against
> future extensions which may require interpreting the arguments in
> the structure differently.
>
> Semantics of `set_mempolicy` are otherwise the same as `set_mempolicy`
> as of this patch.
>
> As of this patch, setting the home node of a task-policy is not
> supported, as this functionality was not supported by set_mempolicy.
> Additional research should be done to determine whether adding this
> functionality is safe, but doing so would only require setting
> MPOL_MF_HOME_NODE and providing a valid home node value.
>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Gregory Price <gregory.price@memverge.com>

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

