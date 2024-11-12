Return-Path: <linux-fsdevel+bounces-34443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6FA9C5847
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 13:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1797B38DD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 12:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C276136E09;
	Tue, 12 Nov 2024 12:48:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838C170814
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731415724; cv=none; b=WJ/EHIaYh/WAOiBUYfT1qvtGYOCTQlESwRAQHKSWk8U+gfgIjwxxmVZfJqFAYdRded9qwy/hf175bZxnJqoxNOJQA0gtuIfqWKLIx8UZpzwcJVQ4gxv0WHJkgEXRacMx46/yEWQC3Qta51XOR3zjN6OcvdaJB2bK4acVbFUNL9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731415724; c=relaxed/simple;
	bh=Z43RH5OdHGQj2u1YWQPesXEhxBlvuAilD5+lSZhSkmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4n6jFnjvBfWpOGIuqbelGZHhHrZx4tceqIQ3+YAcX6ijMJut5pzdZzc6tG68dexLzFlqY0zEyfwCtC+aSlftOvvNykv8VPznxEJ05dn+uaacpS22QXpfmwqk4fwmx5sB5DX8sDcrwpRmMUoyjnrzcAaFUTU7u3Rfrqh6NPtWA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6eb0c2dda3cso20169277b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 04:48:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731415721; x=1732020521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvGM/dFC7sceI4qZceCqeynGhYWBOFt56Cn5duEmL1s=;
        b=bN6ZnVXcwz6mcN2W2EpYr8DXV51BVU/AtoZZ4jQ1BBeGZFqjzUH9syQ8bf/k1xGhRm
         fPpF6yXWVzIbsoB9FrRS2XAYz+7MJiFCIfIxSNL3G4dr51ISNtie7W6+/mhg4ThDr5Kf
         cwF/2NmaUKKOvKNsdkRhmb5nHH7ptnh1vLHOoNaade+N/HNpmoQitLA7PuIrApApLh33
         rr/zDk/jZ9NwWLLjoZ9JX7N1WOKKgVhFzeNa7kiJJ88G4GWF0rTxC/LcuiMtswQZSHFd
         0wzEPilS3EBogJ4bB3dFo3OM6/sbECiZsf1pk7YGirX88fhX/I5uA3OUEu3hPaoQcqsz
         3kEA==
X-Forwarded-Encrypted: i=1; AJvYcCX9YkClIzYdP82RxDyms/eMz5Da//K/WOzO2MPn/lc0FfH53p5d53lxtzaAm0QGDxUnJPkdu20ds23krCdr@vger.kernel.org
X-Gm-Message-State: AOJu0YzngF49RfWEy/3X9FpvgfvOfxmilQUqGMdlBpjk/WkVr6HbZI8/
	TK8lVQM0SxEM4tcFL2m+dmdS9aY+DvbQUh+dsWVTaE19rKkRs25yn7AAOJUR
X-Google-Smtp-Source: AGHT+IEcHN3yAhQyT/VM+VjwWNA1ijEV+fyAytNiaO6dNRHdwpFWfzGmVUQRR2jdgDsBDeaHmzAnoQ==
X-Received: by 2002:a05:690c:b8e:b0:6dd:d119:58dd with SMTP id 00721157ae682-6eaddda4d5fmr169551647b3.16.1731415720991;
        Tue, 12 Nov 2024 04:48:40 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eace8f1c1bsm25111397b3.49.2024.11.12.04.48.40
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 04:48:40 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6eacc99a063so54154187b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 04:48:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXNm+4em9hypUVBltYBD4aRg+dODEW936SJ0vFWNwYLlNq7fKJ8WqDe2Y0pBUun6fGDDA2JdC9JqYCbhr3R@vger.kernel.org
X-Received: by 2002:a05:690c:f91:b0:6e3:156e:a917 with SMTP id
 00721157ae682-6eaddda4438mr172338577b3.14.1731415720325; Tue, 12 Nov 2024
 04:48:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731290567.git.thehajime@gmail.com> <ea2a3fb86915664d54ba174e043046f684e7cf8c.1731290567.git.thehajime@gmail.com>
In-Reply-To: <ea2a3fb86915664d54ba174e043046f684e7cf8c.1731290567.git.thehajime@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 Nov 2024 13:48:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU+Lyj3C-P3kQMd6WfyjBY+YXZSx3Vv6C2y9k__pK45vg@mail.gmail.com>
Message-ID: <CAMuHMdU+Lyj3C-P3kQMd6WfyjBY+YXZSx3Vv6C2y9k__pK45vg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/13] x86/um: nommu: elf loader for fdpic
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com, Liam.Howlett@oracle.com, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tazaki-san,

On Mon, Nov 11, 2024 at 7:28=E2=80=AFAM Hajime Tazaki <thehajime@gmail.com>=
 wrote:
> As UML supports CONFIG_MMU=3Dn case, it has to use an alternate ELF
> loader, FDPIC ELF loader.  In this commit, we added necessary
> definitions in the arch, as UML has not been used so far.  It also
> updates Kconfig file to use BINFMT_ELF_FDPIC under !MMU environment.
>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-mm@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> Signed-off-by: Ricardo Koller <ricarkol@google.com>

Thanks for your patch!

> --- a/fs/Kconfig.binfmt
> +++ b/fs/Kconfig.binfmt
> @@ -58,7 +58,7 @@ config ARCH_USE_GNU_PROPERTY
>  config BINFMT_ELF_FDPIC
>         bool "Kernel support for FDPIC ELF binaries"
>         default y if !BINFMT_ELF
> -       depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !MMU)
> +       depends on ARM || ((M68K || RISCV || SUPERH || UML || XTENSA) && =
!MMU)

s/UML/X86/?

>         select ELFCORE
>         help
>           ELF FDPIC binaries are based on ELF, but allow the individual l=
oad

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

