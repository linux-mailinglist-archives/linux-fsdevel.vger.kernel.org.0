Return-Path: <linux-fsdevel+bounces-6599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A08081A666
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 18:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E52E1F25236
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 17:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BF647F47;
	Wed, 20 Dec 2023 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLX0NpJq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26745482E6;
	Wed, 20 Dec 2023 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28b406a0fbfso4669033a91.0;
        Wed, 20 Dec 2023 09:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703093482; x=1703698282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GOQSGuLsz771RYNTMKWdSp/bMbMlN6H5YkTpswowWQ=;
        b=cLX0NpJqbLtc33nQBnGB0yq+awzn9lHGzCGi8rTWVRVPYecossqjKlRlmyfRGOxAA+
         ScTQrF7aKwF3QjCcZJUaraJ8b1VPdbvwtQmBK5ld9pL3gwcXaujWfP74FFv3nETeCL1H
         ZahegnRrR8JaVCPs/zltxwoLbo66Mgbf1SZ2ZsL5oTfW+LxRsENp4X8LTHLX/ASnk1Gv
         rSI4+huVvya7RrhdtqDFRQ3JeSQjC2IkTAKD1bd5BJRs39gX2KdMcdCFrCdg/VkyjVI1
         zR/hp3gnyvcCYB1Jo6PaVcXqsRlAbc6U+Yu0kG1NQ94IxdLx1wvOA4oH+Qrs0dApZ2r6
         Dg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703093482; x=1703698282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GOQSGuLsz771RYNTMKWdSp/bMbMlN6H5YkTpswowWQ=;
        b=vclYoJeO/RRs0nSZxoYmSJQ/Mg9vztHAZ7ax0ZpiCy0YMicRkB6U+u/cNKB3TiMDNu
         8Sx6NnoUawzrY8str6ikXJYNXBUFuuQWDEcYX/9OIZTgTv09Mzpqsnvp40+qRS6YSPyW
         zFMn32JRQPKG9+rNnztPZ5TA6qDqDb9v0KNLCGcbVBtqwzFZdZckPGJtwJHbonL549sq
         z8xK9152rCBqqajc7rnoozFMagupz94wRwZgXWkczIcEISIzpMwcjYAQPypxPOIHQ8nS
         nkXNAbfXR2Lzr2uGQHHxpooAs3EAmY4sRXmsYptfnHeCViPA/1Z8lQktaq19zqwgd5sL
         c9Tg==
X-Gm-Message-State: AOJu0YxHwV0AtZR6AMpjDzSLShgnwEyJToJnbAdsiIWGh8MbPCjDcLdg
	rNXSdHPYxNVSMwJBRTsItT9+6qpWiZtVmRXds2g=
X-Google-Smtp-Source: AGHT+IGIIjWSVlyaXApNA9NWUkUN66FGqrw2kFgVqiFQoLzYtRcq2vgGiL4dBXGhnSVh+6tzfvi4HL4ZeeoYBzJbFkw=
X-Received: by 2002:a17:90a:e651:b0:28b:af80:ad5a with SMTP id
 ep17-20020a17090ae65100b0028baf80ad5amr3105519pjb.16.1703093482294; Wed, 20
 Dec 2023 09:31:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230906102557.3432236-1-alpic@google.com> <20231219090909.2827497-1-alpic@google.com>
In-Reply-To: <20231219090909.2827497-1-alpic@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 20 Dec 2023 12:31:10 -0500
Message-ID: <CAEjxPJ7h+fDRgBqktXZmQCoZWV3xSHy=PaW=DNVjfGH=dB=WMg@mail.gmail.com>
Subject: Re: [PATCH] security: new security_file_ioctl_compat() hook
To: Alfred Piccioni <alpic@google.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 4:09=E2=80=AFAM Alfred Piccioni <alpic@google.com> =
wrote:
>
> Some ioctl commands do not require ioctl permission, but are routed to
> other permissions such as FILE_GETATTR or FILE_SETATTR. This routing is
> done by comparing the ioctl cmd to a set of 64-bit flags (FS_IOC_*).
>
> However, if a 32-bit process is running on a 64-bit kernel, it emits
> 32-bit flags (FS_IOC32_*) for certain ioctl operations. These flags are
> being checked erroneously, which leads to these ioctl operations being
> routed to the ioctl permission, rather than the correct file
> permissions.
>
> This was also noted in a RED-PEN finding from a while back -
> "/* RED-PEN how should LSM module know it's handling 32bit? */".
>
> This patch introduces a new hook, security_file_ioctl_compat, that is
> called from the compat ioctl syscall. All current LSMs have been changed
> to support this hook.
>
> Reviewing the three places where we are currently using
> security_file_ioctl, it appears that only SELinux needs a dedicated
> compat change; TOMOYO and SMACK appear to be functional without any
> change.
>
> Fixes: 0b24dcb7f2f7 ("Revert "selinux: simplify ioctl checking"")
> Signed-off-by: Alfred Piccioni <alpic@google.com>
> Cc: stable@vger.kernel.org
> ---

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

