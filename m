Return-Path: <linux-fsdevel+bounces-77584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOsAFqTZlWmmVQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 16:24:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DE41575F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 16:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D432302713C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 15:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD7E33EAF8;
	Wed, 18 Feb 2026 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQ8yC+mQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC5D2DC76C
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 15:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771428225; cv=pass; b=ETNkxEhdZygQlLKgRAD/6q5CMhxgMcTphDLmE04zQPWYd5jZw+CD8ORq05QIGTMlQy4rbpzExz0s+QwWGXNrgo9KsUmonM95oRqJKamosIynDBPGUZ3QkY6BwLObxzEQRd3dxNiMqo3bPTnjvvK1jaxLdMTJLRNNuomo206cfZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771428225; c=relaxed/simple;
	bh=MLAFpdatXTRp++a+/4+RFNNQ16WX3zuO/92pj5GDMqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/pTPlCu9btDJNJ/8McapzJUk6t/75z8QS+0RrK1X/zS1D1IDpG4kFhnGXYDkKTso+C8tyeHRZMu2rZj+T2BOa4fM8DLuroGYMcYtSlE4/b/fG9jmCliqrz9OyuPvKJOtdQrhLbuWPAw/DtkHxTH1TRWEgvMoMT19t6TpVr3RVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQ8yC+mQ; arc=pass smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9489d087bcfso3048717241.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 07:23:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771428223; cv=none;
        d=google.com; s=arc-20240605;
        b=ArKOgfGVm33NzIsoWyCUO6UGh9DSa1y9tgzEFnTeqby3mGPBRemz+W6Y5KM3lWwH47
         Sb+KJM/kT3TwQsp9pXH2gXtS1VSJvcGsveec8CEqU/AHCP3+zscmFpzUMWMGnLHACLlL
         Q27J0Fo/iN7GQ10rv4qyUSIa0YIK0mK5ePz7XmwAJ63h8CPYAt6ZsnwRiHeAXLJI1eG6
         wM8OG8/wVrL2ntLfObjpTs4lDmyU2e0sq8yn2P/WLUotZHNw5YCvxufHip/WF0LU27q9
         s5umotB9Ug6N4cI+QmtmUtJOZ4NlI6KVRDMt8CF9gMSvwpndrd6//ElsQyjUeT66V6sp
         iy/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BrpuM94oAOfpTYXOCv2xq6TljXxkBT08znddu5hFCuA=;
        fh=ycnk+DzZGjHB/nOiT9vhJr1YYXt7FXpBcfzKzRRZQfQ=;
        b=F9BLNYh8pAvuN8SM7G5hmqgAexXR0p+rAUmdRUAZC1cN+xXZh9rUrdE7qEDF407R6y
         RQDQtifpIDwQPkmkTk5UlahGbhHOcHxxvBia4XConDVG5YfzvnjPPUAuLGrH2UHf6R73
         ePf8HxUZgVX8eqOhoyULixcJXypsGjKaKMNwPIeJjEh4aHFsujdX0y4kkb1AWCcCdRp/
         t5XKo4keoxgShLBVo1SkddDffvwpMoSS2SZ3EJsNVLdTHyrHOlSdfzdwX2q/Qj6U/Lc2
         pHKdna+1TSvt5HeIxGhVTTdO9gJCDAo1z+d09WSybRFETJu8v0RE59FnzWrrcykRvo/q
         Wk2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771428223; x=1772033023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrpuM94oAOfpTYXOCv2xq6TljXxkBT08znddu5hFCuA=;
        b=XQ8yC+mQGht/A5h+XpbWazSDpcwH7PxoYhkulK2Xf0iKLAQBpdXbtg+eTuMqPE/Cnn
         htAsbdK4y4PbxAG1RnagS6lvs/9cTPV/te7w6D6XxnYNYAzHl6a9rhqMeAE0fgUpOMFT
         eB1Un6D3Ux4ZX7YLIMihuvBGRRB/sl7K2/1qFv0r+4764jemrFWTz514J892upnh/oLM
         p60fICWEKMf2BcW7Y/5aGbAK7bEkk3Es1WS4+7O1k835EcXDwFX9g4HVGSyuP3EpNtbl
         /Y7F7wikDHtNVSQ6CelUH2n4/EDU1lS5f4cfx93kKIZDxjJTA9F+R3+LklnYv4oN5qgZ
         kfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771428223; x=1772033023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BrpuM94oAOfpTYXOCv2xq6TljXxkBT08znddu5hFCuA=;
        b=vyPdEr97kYmB/ix7xA8WeGI1gaXAU8xQWcmoJLAXsG+Zj23QmPbCGpg2OBUq7h6Xl7
         m7zYVBWGcG06U5l58+5aPQwuHaq8fjoQDhuzNCIs15rXLscL1V53DaPIwmE1r1Xim/KD
         RSlca+Ajjot72UPNtWF0Vpcab9w8rCjJQ7DbZzhVblh9LDAnJvyml+9qCDAX+IgmR9uD
         bEZhEbX8y+QT4r6DLsEaOYG9Y8o9gylj8w0tWCaZTYpqjbUde/NldPsX1YB7mqy5b441
         Pn43ug7axBGx2Jrmv71OYLaDCKc2eVCqA7Ofpmntjpn1e19KSq/BRbPyTCgzZbtq7irU
         /HvA==
X-Gm-Message-State: AOJu0Yxpzu6VMYnGmRv7TEKyNoU1E4kWYoSeIbMWHCidZ6IXfiBx7A0M
	vGTKI4GKeVmbO3RxiyRuS5I61MmDomQfABt+YhlZUhRCw0dJ/CNH1EZS0IAsiAlAB0uPFHXrHTX
	Ghd9eGEG9B0kJI5j880HxYgpH5XAMpvp2RjaA
X-Gm-Gg: AZuq6aII24arqxaz9AAxY+xUBKpLztlHhnZSRCkw4tIk/4gcDvnZ18hIb8xTtnrMGo/
	h3/ARZzcMPPaqv1v2Az+3NdJ0fXhc1Cfz+2pHRKJUw5C/IbJrrrih9s6SvtvJIBlByLAqoxBS76
	bmHXInaexCPRd4qZaomCwJJ3GC/wKXsbL9TD8dneVPa4DvNBgJDoHFKjlmVZLrklISCwEYD+WcN
	AOj6z7YEVlQGeofpmny4UIPRmna1WNBexpwRnZem/Ocp8YKZat5B+J/1+huvo5DvIkc8yoDay6O
	WR+SrWSWopPyzEmVgZtQt3lFx02ESyw4SBG1Uyqhusw0Q5VfkMjHJA==
X-Received: by 2002:a05:6102:d8d:b0:5f5:3dbd:7007 with SMTP id
 ada2fe7eead31-5fe7fb38697mr1043191137.4.1771428222488; Wed, 18 Feb 2026
 07:23:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206190536.57289-1-dorjoychy111@gmail.com> <CAFfO_h4Hw5Lu-PQn4C31Cdzcz2AH5zmWa-TB8ocdci5K=F8m7Q@mail.gmail.com>
In-Reply-To: <CAFfO_h4Hw5Lu-PQn4C31Cdzcz2AH5zmWa-TB8ocdci5K=F8m7Q@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Wed, 18 Feb 2026 21:23:30 +0600
X-Gm-Features: AaiRm507b4XILK_obFq6jnn_sPZjsQmZpqwNkJiv1DnZEwJr-9zXrYRefiQAPSY
Message-ID: <CAFfO_h4x84-=YSt9LMi4PzokdmVNZThah8s0sDEBHM2mUvddMQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] openat2: new OPENAT2_REGULAR flag support
To: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jlayton@kernel.org
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77584-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,file_operations.open:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B0DE41575F0
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 10:05=E2=80=AFPM Dorjoy Chowdhury
<dorjoychy111@gmail.com> wrote:
>
> On Sat, Feb 7, 2026 at 1:05=E2=80=AFAM Dorjoy Chowdhury <dorjoychy111@gma=
il.com> wrote:
> >
> > Note that in v4, for now, I have returned -EINVAL from the atomic_open =
codepaths.
> > I do want to make this new flag properly supported and proper api behav=
ior, but
> > last time I could not quite understand what should be done for the atom=
ic_open
> > codepaths. So to have a more concrete discussion, I have included the -=
EINVAL
> > changes.
> >
> > Changes in v4:
> > - changed O_REGULAR to OPENAT2_REGULAR
> > - OPENAT2_REGULAR does not affect O_PATH
> > - OPENAT2_REGULAR with O_DIRECTORY will open path for both directory or=
 regular file
> > - atomic_open codepaths updated to return -EINVAL when OPENAT2_REGULAR =
is set
> > - commit message includes the uapi-group URL
> > - v3 is at: https://lore.kernel.org/linux-fsdevel/20260127180109.66691-=
1-dorjoychy111@gmail.com/T/
> >
> > Changes in v3:
> > - included motivation about O_REGULAR flag in commit message e.g., prog=
rams not wanting to be tricked into opening device nodes
> > - fixed commit message wrongly referencing ENOTREGULAR instead of ENOTR=
EG
> > - fixed the O_REGULAR flag in arch/parisc/include/uapi/asm/fcntl.h from=
 060000000 to 0100000000
> > - added 2 commits converting arch/{mips,sparc}/include/uapi/asm/fcntl.h=
 O_* macros from hex to octal
> > - v2 is at: https://lore.kernel.org/linux-fsdevel/20260126154156.55723-=
1-dorjoychy111@gmail.com/T/
> >
> > Changes in v2:
> > - rename ENOTREGULAR to ENOTREG
> > - define ENOTREG in uapi/asm-generic/errno.h (instead of errno-base.h) =
and in arch/*/include/uapi/asm/errno.h files
> > - override O_REGULAR in arch/{alpha,sparc,parisc}/include/uapi/asm/fcnt=
l.h due to clash with include/uapi/asm-generic/fcntl.h
> > - I have kept the kselftest but now that O_REGULAR and ENOTREG can have=
 different value on different architectures I am not sure if it's right
> > - v1 is at: https://lore.kernel.org/linux-fsdevel/20260125141518.59493-=
1-dorjoychy111@gmail.com/T/
> >
> > Hi,
> >
> > I came upon this "Ability to only open regular files" uapi feature sugg=
estion
> > from https://uapi-group.org/kernel-features/#ability-to-only-open-regul=
ar-files
> > and thought it would be something I could do as a first patch and get t=
o
> > know the kernel code a bit better.
> >
> > I am not quite sure if the semantics that I baked into the code for thi=
s
> > O_REGULAR flag's behavior when combined with other flags like O_CREAT l=
ook
> > good and if there are other places that need the checks. I can fixup my
> > patch according to suggestions for improvement. I did some happy path t=
esting
> > and the O_REGULAR flag seems to work as intended.
> >
> > Thanks.
> >
> > Regards,
> > Dorjoy
> >
> > Dorjoy Chowdhury (4):
> >   openat2: new OPENAT2_REGULAR flag support
> >   kselftest/openat2: test for OPENAT2_REGULAR flag
> >   sparc/fcntl.h: convert O_* flag macros from hex to octal
> >   mips/fcntl.h: convert O_* flag macros from hex to octal
> >
> >  arch/alpha/include/uapi/asm/errno.h           |  2 +
> >  arch/alpha/include/uapi/asm/fcntl.h           |  1 +
> >  arch/mips/include/uapi/asm/errno.h            |  2 +
> >  arch/mips/include/uapi/asm/fcntl.h            | 22 ++++-----
> >  arch/parisc/include/uapi/asm/errno.h          |  2 +
> >  arch/parisc/include/uapi/asm/fcntl.h          |  1 +
> >  arch/sparc/include/uapi/asm/errno.h           |  2 +
> >  arch/sparc/include/uapi/asm/fcntl.h           | 35 +++++++-------
> >  fs/9p/vfs_inode.c                             |  3 ++
> >  fs/9p/vfs_inode_dotl.c                        |  3 ++
> >  fs/ceph/file.c                                |  3 ++
> >  fs/fuse/dir.c                                 |  3 ++
> >  fs/gfs2/inode.c                               |  3 ++
> >  fs/namei.c                                    |  9 +++-
> >  fs/nfs/dir.c                                  |  3 ++
> >  fs/nfs/file.c                                 |  3 ++
> >  fs/open.c                                     |  2 +-
> >  fs/smb/client/dir.c                           |  3 ++
> >  fs/vboxsf/dir.c                               |  3 ++
> >  include/linux/fcntl.h                         |  2 +
> >  include/uapi/asm-generic/errno.h              |  2 +
> >  include/uapi/asm-generic/fcntl.h              |  4 ++
> >  tools/arch/alpha/include/uapi/asm/errno.h     |  2 +
> >  tools/arch/mips/include/uapi/asm/errno.h      |  2 +
> >  tools/arch/parisc/include/uapi/asm/errno.h    |  2 +
> >  tools/arch/sparc/include/uapi/asm/errno.h     |  2 +
> >  tools/include/uapi/asm-generic/errno.h        |  2 +
> >  .../testing/selftests/openat2/openat2_test.c  | 46 ++++++++++++++++++-
> >  28 files changed, 138 insertions(+), 31 deletions(-)
> >
> > --
> > 2.53.0
> >
>
> Hi,
> I would appreciate some feedback on this patch series. I think there
> are 2 things that need definite feedback.
>
> 1) I have defined OPENAT2_REGULAR to be in the 32-bit space. At first,
> I tried to make it the 33rd bit but then realized, there are existing
> structs like (struct open_flag and others) where the flag (or similar)
> members are of type int or unsigned int which get passed over to lots
> of places. So I ended up making it a flag in the 32-bit space. I guess
> it's okay as it's not easy to add new flags to existing open syscalls
> due to backward compatibility anyway.
>
> 2) For now, I am returning -EINVAL from the atomic_open codepaths.
> What would be the proper way to handle this? And is there anything
> needed for the file_operations.open codepaths (right now, do_open
> already checks and returns errors for the new flag before we reach
> file_operations.open)? I am a bit confused about the new flag and
> network filesystems where obviously the new flag won't be recognized
> by the server. So, if we want to handle the new flag properly in those
> filesystems, does the flag need to be masked out? It's a bit hard for
> me to understand the right thing that should be done as I am not
> familiar with all the code so I appreciate any help and suggestions on
> this.
>
> Thanks.
>
> Regards,
> Dorjoy

Hi,
Gentle ping for review on this patch series. Thanks!

Regards,
Dorjoy

