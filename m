Return-Path: <linux-fsdevel+bounces-7123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 460D6821E17
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 15:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A5CD1C22205
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 14:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857B712E60;
	Tue,  2 Jan 2024 14:52:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10CD12E55;
	Tue,  2 Jan 2024 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7810827e54eso923560985a.2;
        Tue, 02 Jan 2024 06:52:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704207120; x=1704811920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RgMSQI9ztusESa2/dVb2946CGIyB/32Wyc20atk9ulA=;
        b=iqycHvx1x1TFxvSKLR8yYJjR7T1rqF7HIRB0HHlCwS0ZKh2ETP59K/2Mh+2yeZq55v
         Fe6wqhJBLfPSsarwviFCeEDHHNN0Vu++TD+zIIu60dAknXaKx+yoJoEwt/bldnr8W+FA
         VDuESk7qmopK4fX1V9Hmtrs8embXS9DT/Pd0XVas/BT9WTuuDyPUNVgQ29gmyLisiEa3
         QsAafbimZoWhB9kFxF3Yi0Ycxtf2iZC3MVUT/iP60lZlMiExouvcc2f74EHxUbYPSKmT
         dY3rtKdvhtgVcEQ6++uI2bIIwr91nhd7+hln6L5uYaHNTy/mTE5cznyJkPLMak52r/dq
         TH5g==
X-Gm-Message-State: AOJu0Yyib69+GiAzxXOrZbccHiDPM1iGfYRIT1ou82UgqmmCmi/bU6c7
	Gr9Kg4zT0yMahRS5N3kHXPPa6Qm/i6KxAQ==
X-Google-Smtp-Source: AGHT+IFos4iNAPSqsAS+F6KLhX3+0g/FBL90JvWJONV2ThJJnQEGp2m1MDBGfJGvbEkDoL66em/P2A==
X-Received: by 2002:a05:620a:384f:b0:781:1adf:f030 with SMTP id po15-20020a05620a384f00b007811adff030mr18675560qkn.91.1704207120346;
        Tue, 02 Jan 2024 06:52:00 -0800 (PST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com. [209.85.222.182])
        by smtp.gmail.com with ESMTPSA id oo25-20020a05620a531900b007815c45cdc5sm5127462qkn.95.2024.01.02.06.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 06:52:00 -0800 (PST)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7817070291eso406788985a.3;
        Tue, 02 Jan 2024 06:52:00 -0800 (PST)
X-Received: by 2002:a0d:eb15:0:b0:5e8:4f42:fe with SMTP id u21-20020a0deb15000000b005e84f4200femr10739224ywe.50.1704206798019;
 Tue, 02 Jan 2024 06:46:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223181101.1954-1-gregory.price@memverge.com> <20231223181101.1954-10-gregory.price@memverge.com>
In-Reply-To: <20231223181101.1954-10-gregory.price@memverge.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 2 Jan 2024 15:46:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVN2-=Poa_tm5jr_tUE=iDh57hFF-bDpaf7hJiJi9Gtdw@mail.gmail.com>
Message-ID: <CAMuHMdVN2-=Poa_tm5jr_tUE=iDh57hFF-bDpaf7hJiJi9Gtdw@mail.gmail.com>
Subject: Re: [PATCH v5 09/11] mm/mempolicy: add get_mempolicy2 syscall
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

On Sat, Dec 23, 2023 at 7:14=E2=80=AFPM Gregory Price <gourry.memverge@gmai=
l.com> wrote:
> get_mempolicy2 is an extensible get_mempolicy interface which allows
> a user to retrieve the memory policy for a task or address.
>
> Defined as:
>
> get_mempolicy2(struct mpol_args *args, size_t size,
>                unsigned long addr, unsigned long flags)
>
> Top level input values:
>
> mpol_args:    The field which collects information about the mempolicy
>               returned to userspace.
> addr:         if MPOL_F_ADDR is passed in `flags`, this address will be
>               used to return the mempolicy details of the vma the
>               address belongs to
> flags:        if MPOL_F_ADDR, return mempolicy info vma containing addr
>               else, returns task mempolicy information
>
> Input values include the following fields of mpol_args:
>
> pol_nodes:    if set, the nodemask of the policy returned here
> pol_maxnodes: if pol_nodes is set, must describe max number of nodes
>               to be copied to pol_nodes
>
> Output values include the following fields of mpol_args:
>
> mode:         mempolicy mode
> mode_flags:   mempolicy mode flags
> home_node:    policy home node will be returned here, or -1 if not.
> pol_nodes:    if set, the nodemask for the mempolicy
> policy_node:  if the policy has extended node information, it will
>               be placed here.  For example MPOL_INTERLEAVE will
>               return the next node which will be used for allocation
>
> MPOL_F_NODE has been dropped from get_mempolicy2 (EINVAL).
> MPOL_F_MEMS_ALLOWED has been dropped from get_mempolicy2 (EINVAL).
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

