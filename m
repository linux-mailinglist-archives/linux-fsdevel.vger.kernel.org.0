Return-Path: <linux-fsdevel+bounces-6593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 727E881A2C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 16:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1358D1F25726
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 15:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0BB405F0;
	Wed, 20 Dec 2023 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enogq4AA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2EF40BE8;
	Wed, 20 Dec 2023 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-28bd09e35e8so493397a91.0;
        Wed, 20 Dec 2023 07:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703086491; x=1703691291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKFnX4CJVbWZh50vYqLqudxSDwEYO4UT48j3QGNennM=;
        b=enogq4AAbXXlnLcWN0UWih9GstGT6T7gC6RcebIlDYKy+mEUMpvKKjIYg3d4S8jLPp
         RZGWNHO9n0HLxy2QIjxqmqbOrXo2GeIPa6PjwvN048MzC+jpVutDs9jrM5/2RqvHjbYw
         h6OcE9Hyby5FbIrn1GShzlw9MXx+I8TFdeqo22WgUk/JyCb0HAhEa2RGzzxEzPO/68PE
         nKOvOIV6aABAGXHcEQUjTiO9G0NSLer4Qs7yRArmFgz4iql4VTcFxVHdQzsdAhrBq+jV
         Lnb4FsMnRlG6eHynxrnQq1foYOTAAvUp46ThnL0bu69nfEetr7fP5MDoE2YfdR+mejK/
         3bRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703086491; x=1703691291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKFnX4CJVbWZh50vYqLqudxSDwEYO4UT48j3QGNennM=;
        b=NLUhV9dmgpfwjzVsaUUSZgzeGhau7whaBviLXol/ZL+gssgvhiSvp49PlrZ3yMCeXv
         09SEk2p+Lz+NKR+lk1xN8g8YouQd4b0Mzim8PTx0hqpAboLoAOrheauWURpjjSwIqBWu
         087mRvWQqEesFgvoyYCh9bwcdS9PG7TdDG3jbh/ojbRL4hJBm5DC2V7qOUYsTna2D469
         Diohu99BuidNnNIUqKqAbxbcrxfKGoLUWTSUcpU4XNUXv6utuIisjHFcGYTebBTWDGwl
         VGCXVCAjbN5PP2Sf78QQuwNooWtfLWngViTXN74qBimy35pqRwqr100bb6eUux3gi+Wp
         16fw==
X-Gm-Message-State: AOJu0YzO+B+jLcXZHiNJr8/sc3vUHTf6MEt+bzUYH0jRE4PxQ6Ejz1TE
	W1cxoQN8NPc+xKyNveRpJcPLtwpliJDf/guS5mjjoxxPaBg=
X-Google-Smtp-Source: AGHT+IHD72x6lp5w65PvqqD7hpY3DZmaKFJFG3kRX0NfBAMXfvVyPVSUZunqqNiSyoH2/9WURpfCeJDQLmkLVtmv+hQ=
X-Received: by 2002:a17:90a:1049:b0:286:e125:1a3f with SMTP id
 y9-20020a17090a104900b00286e1251a3fmr8461526pjd.5.1703086490897; Wed, 20 Dec
 2023 07:34:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230906102557.3432236-1-alpic@google.com> <20231219090909.2827497-1-alpic@google.com>
 <CALcwBGC9LzzdJeq3SWy9F3g5A32s5uSvJZae4j+rwNQqqLHCKg@mail.gmail.com>
In-Reply-To: <CALcwBGC9LzzdJeq3SWy9F3g5A32s5uSvJZae4j+rwNQqqLHCKg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 20 Dec 2023 10:34:38 -0500
Message-ID: <CAEjxPJ7kLwQAee+J1RJ_AvoVLkJR2L5dyZ0jFJHbazZANWgeyQ@mail.gmail.com>
Subject: Re: [PATCH] security: new security_file_ioctl_compat() hook
To: Alfred Piccioni <alpic@google.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, stable@vger.kernel.org, 
	SElinux list <selinux@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 4:11=E2=80=AFAM Alfred Piccioni <alpic@google.com> =
wrote:
>
> Thanks for taking the time to review! Apologies for the number of
> small mistakes.

NP.

> > Also, IIRC, Paul prefers putting a pair of parentheses after function
> > names to distinguish them, so in the subject line
> > and description it should be security_file_ioctl_compat() and
> > security_file_ioctl(), and you should put a patch version
> > in the [PATCH] prefix e.g. [PATCH v3] to make clear that it is a later
> > version, and usually one doesn't capitalize SELinux
> > or the leading verb in the subject line (just "selinux: introduce").
>
> Changed title to lower-case, prefixed with security, changed slightly
> to fit in summary with new parentheses. Added [PATCH V3] to the
> subject.

Patch description still doesn't include the parentheses after each
function name but probably not worth re-spinning unless Paul says to
do so. I don't see the v3 in the subject line. Seemingly that in
combination with the fact that you replied to the original thread
confuses the b4 tool (b4.docs.kernel.org) such that b4 mbox/am/shazam
ends up selecting the v2 patch instead by default.

> > Actually, since this spans more than just SELinux, the prefix likely
> > needs to reflect that (e.g. security: introduce ...)
> > and the patch should go to the linux-security-module mailing list too
> > and perhaps linux-fsdevel for the ioctl change.
>
> Added cc 'selinux@vger.kernel.org' and cc
> 'linux-kernel@vger.kernel.org'. Thanks!

Just FYI, scripts/get_maintainer.pl /path/to/patch will provide an
over-approximation of who to include on the distribution for patches
based on MAINTAINERS and recent committers. That said, I generally
prune the set it provides. More art than science.

> > I didn't do an audit but does anything need to be updated for the BPF
> > LSM or does it auto-magically pick up new hooks?
>
> I'm unsure. I looked through the BPF LSM and I can't see any way it's
> picking up the file_ioctl hook to begin with. It appears to me
> skimming through the code that it automagically picks it up, but I'm
> not willing to bet the kernel on it.
>
> Do you know who would be a good person to ask about this to make sure?

Looks like it inherited it via the lsm_hook_defs.h.
$ nm security/bpf/hooks.o | grep ioctl
                 U bpf_lsm_file_ioctl
                 U bpf_lsm_file_ioctl_compat

