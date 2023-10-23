Return-Path: <linux-fsdevel+bounces-925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 918A67D3815
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 15:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2394BB20D58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 13:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE2219BD4;
	Mon, 23 Oct 2023 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A1P0mZ0i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2AC3D8F
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 13:30:32 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA0010C
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 06:30:29 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c9d4f08d7cso306205ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 06:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698067829; x=1698672629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRJoIZwads+nO8MENW8StdsOtBrARPpfCP3zhmQYmss=;
        b=A1P0mZ0iKLYsXN7+xwGMtF4TFQjWE2OcfjWz4yedv+F89mZknFVJTVMZTJJ0/wKlfO
         B2DMwdp4zIyDBtX7HC02OT0m6E4KnHX4943gZ1kxoDnCmQhlW3dgmxtCxrEFLcRkiYkO
         UV72j/aJG3TCyei4pEjf4Bu8+Y+8bOfd6V9LWjbGqfIGnDIgM7pW9vubNtf3rVCTzJ82
         HWj7+YVhjM1ZTwsS8E8uHvlMDGRVKnNE3Q7oCfZi/4aIKNSl1ClGBBPmTRR6cHdivmWt
         CtUE731knUhwI06HPk1MMbEtHm+9ruFljLoMmb1gHE+7AlktWPfuADB4ny9bTibop7nQ
         Drrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698067829; x=1698672629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRJoIZwads+nO8MENW8StdsOtBrARPpfCP3zhmQYmss=;
        b=kx7eGFtPMRc83OE1ldnJtdReBg6isrN/ilaSNcLaZaYnMhT7UV+TUbCopHN6NNlLfL
         fkd+rSBOhWstqFXju0rpvJhomf8ZVnsk08ZVmlf/jnoDx8fUjTvTafuxg2y9Im/U4x9w
         BxUOOTxHXqKxbUflKjrI6TUsCqI6JeYSLuXCFBxvlQ03is1oh279j3GGY/KglLz4gGfs
         wm2yR58WFyg8eQ+cQ56nlZz+TaUhny8LzZsoVPY57DKdYroQMvCUeGxv5Wgucd/BgSPb
         geyoD8uy6fDiQH+YfpQKZRiMNa48vCStCbFntOTs9a+VENpbyEsM+Yu9GpZi5MshfUzN
         0oCg==
X-Gm-Message-State: AOJu0YxAFwcLU7A55H+yCPu5qedxu3E6XmAzjTmHPmpSjXwZwsfdNndM
	2M92WtbNgQFw5DnB8HxsO5CB4OL+oT2R2+LE+v9owQ==
X-Google-Smtp-Source: AGHT+IESETBifZ4eSnvOE1cPciShA0cCrQKjMCMyn1hOOR1b3j7Kn4EcGIyWkQnjhcU9/NScE5h0KW2KUsh0yiwRNNw=
X-Received: by 2002:a17:902:ab5c:b0:1c9:e48c:726d with SMTP id
 ij28-20020a170902ab5c00b001c9e48c726dmr573411plb.4.1698067828483; Mon, 23 Oct
 2023 06:30:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000d005440608450810@google.com> <20231023130830.GG26353@twin.jikos.cz>
In-Reply-To: <20231023130830.GG26353@twin.jikos.cz>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 23 Oct 2023 15:30:16 +0200
Message-ID: <CANp29Y4VNqAX0oPiGy557ubwQKjhWVbwjT7xdCBGLricJPJ5Yg@mail.gmail.com>
Subject: Re: [syzbot] [btrfs?] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (4)
To: dsterba@suse.cz
Cc: syzbot <syzbot+b2869947e0c9467a41b6@syzkaller.appspotmail.com>, clm@fb.com, 
	dsterba@suse.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 3:15=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Sat, Oct 21, 2023 at 07:40:53PM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    78124b0c1d10 Merge branch 'for-next/core' into for-kern=
elci
> > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/lin=
ux.git for-kernelci
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1557da89680=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df27cd6e6891=
1e026
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Db2869947e0c94=
67a41b6
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> > userspace arch: arm64
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D137ac45d6=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16e4640b680=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/bd512de820ae/d=
isk-78124b0c.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/a47a437b1d4f/vmli=
nux-78124b0c.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/3ae8b966bcd7=
/Image-78124b0c.gz.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/d5d51449=
5f15/mount_0.gz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+b2869947e0c9467a41b6@syzkaller.appspotmail.com
> >
> > BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
>
> #syz invalid
>
> This is a frequent warning, can be worked around by increasing
> CONFIG_LOCKDEP_CHAINS_BITS in config (18 could be a good value but may
> still not be enough).

By invalidating a frequently occurring issue we only cause syzbot to
report it once again, so it's better to keep the report open until the
root cause is resolved. There'll likely be a report (5) soon.

We keep CONFIG_LOCKDEP_CHAINS_BITS at 16 for arm64 because (at least
in 2022) the kernel used not to boot on GCE arm64 VMs with
CONFIG_LOCKDEP_CHAINS_BITS=3D18. Maybe it's time to try it once more.

--=20
Aleksandr

