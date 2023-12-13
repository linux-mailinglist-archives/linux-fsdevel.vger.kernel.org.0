Return-Path: <linux-fsdevel+bounces-5910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB928115D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 16:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55C3E1C20F6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 15:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB9930F84;
	Wed, 13 Dec 2023 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dn3VE/CQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35F5EB
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 07:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702480234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/uSB49jsn0w9wzpuib1HRs5w7XO+B0YoYfbjQMuHLo=;
	b=Dn3VE/CQnQjHUehAcHj4SRLDjXQb8I67SAP9C/zuQL71MQTZtyHXHQXWSW/nzQa1G9EkVV
	aJo27X65AJK5p0Z09W4GlIv/r2AnHHyvItKSBcPy07CSf3/+ZEKOTsAK0iYRDKRvvsSR+A
	M3AwDWoa5k1zx0w+UxT6EMxUWKtMFIc=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-iK10D9_EOKqXTad3dIgi0A-1; Wed, 13 Dec 2023 10:10:33 -0500
X-MC-Unique: iK10D9_EOKqXTad3dIgi0A-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1d2e29bd3ddso37113175ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 07:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702480231; x=1703085031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/uSB49jsn0w9wzpuib1HRs5w7XO+B0YoYfbjQMuHLo=;
        b=B4+sO7tNZRStIRh4AzbCCzpuG/InPGTErZnA2xrWISqiV20huGfQ/qaXn87XoHDv7n
         GoefYxEypYagHQuECvGWM30axmYlBJj1Da8AxA+4fQT9VPLDnuepk+OvRxWgv5m1XAwR
         ytzV6vwYKJoWpan9xlVgyjUhnJCILWwWmdwAf4Qd22HODyrujttHVm8DvJ92kiYZCbyN
         DycrgW8M9U+T0D7uTF79Gsld61vKO1vZTCdTwfBwt//xRpV5ySWEX7BeDjVqYl39etBF
         AgXFy5sGkBQ5Wv5J+hfaARLrptDDEgRBRas3aEV8+jcpMp9zzYTWaNFpWU8DnVSxJzEL
         US1A==
X-Gm-Message-State: AOJu0YwRsQTxIvOJDN1LcmHaAlQspzxuhcqt0VsS2M2rwRTMVAYlNXIB
	MyctCwe+SkRdc1WE91GNOKWg9w91RHNUs1V5qUYjnebnHfdOr9szYPjs/hBpmrDkdus+uYW0udL
	YRhkKo8ZLX91tpinEJsytcuRPVCSpV65odBwZAOshKzUxkudfqGC7
X-Received: by 2002:a17:902:bb16:b0:1d3:5020:4afc with SMTP id im22-20020a170902bb1600b001d350204afcmr303175plb.23.1702480230758;
        Wed, 13 Dec 2023 07:10:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJQDiEHxH6Fv1FyPFGmRNRbnncBiOQLr0KIXQY/DKLNknOl95kj0L0XwwAX71BDrStiAwKvwIrPtESW2mwPGE=
X-Received: by 2002:a17:902:bb16:b0:1d3:5020:4afc with SMTP id
 im22-20020a170902bb1600b001d350204afcmr303160plb.23.1702480230460; Wed, 13
 Dec 2023 07:10:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABOYnLwGoNXXzvvn+YmCcjLu6ttAJGGTaN8+O_tNdPqcjHnfUA@mail.gmail.com>
 <20231213-drehen-einquartieren-56bbdda1177e@brauner>
In-Reply-To: <20231213-drehen-einquartieren-56bbdda1177e@brauner>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 13 Dec 2023 16:10:18 +0100
Message-ID: <CAHc6FU7R+mb3Eh11oOfvDVNg-Zsb-zE9CLEhr4yDKJKU5+ABHA@mail.gmail.com>
Subject: Re: [syzbot] [gfs2] WARNING in vfs_utimes
To: Christian Brauner <brauner@kernel.org>
Cc: xingwei lee <xrivendell7@gmail.com>, 
	syzbot+0c64a8706d587f73409e@syzkaller.appspotmail.com, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 11:45=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> On Wed, Dec 13, 2023 at 02:35:58PM +0800, xingwei lee wrote:
> > Hello, I reproduced this bug with repro.c and repro.txt since it
> > relatively large please see
> > https://gist.github.com/xrivendell7/b3b804bbf6d8c9930b2ba22e2dfaa6e6
> >
> > Since this bug in the dashboard
> > https://syzkaller.appspot.com/bug?extid=3D0c64a8706d587f73409e use
> > kernel commit: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds=
/linux.git/log/?id=3Daed8aee11130a954356200afa3f1b8753e8a9482
> > kernel config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=
=3Ddf91a3034fe3f122
> >
> > my repro.c use the seem config and it crash report like below, and
> > it=E2=80=99s almost can make sure it the same as bug reported by syzobt=
.
>
> Uh, can you reproduce this on mainline?
> I so far fail to even with your repro.

I regularly run afoul of not running "losetup -f" before these
reproducers and so they end up doing nothing; see here:

https://lore.kernel.org/all/CAHc6FU7b-BaBXrMR3UqbZGF3a_y=3D20TKkCNde1GvqbmN=
2-h1xw@mail.gmail.com/

Andreas


