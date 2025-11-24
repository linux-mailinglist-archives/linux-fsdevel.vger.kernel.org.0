Return-Path: <linux-fsdevel+bounces-69634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3122C7F5B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 09:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2883C3424B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 08:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1892EBB9A;
	Mon, 24 Nov 2025 08:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZ4SK1Xx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB392EAB83
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763971689; cv=none; b=a5zJ7iuY45/o2OZt0AiH1ly0FA+iWGkaBtJLEg+5e8vL8XSwoXiiOfdopEAlVrzeDbvvc9S868Zn74huyATOneHAe1F099+Hzpb0izd2liBAxE8KZPwrFZHJooXSYQFBPoKNWIdhqBI8gTSSx3cThUli5u0JJ4AQfkRlO5H1ECw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763971689; c=relaxed/simple;
	bh=lv+AEbEO5IfBluOI6lN3XPIKGE9a0yctf/Cn6smugBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzqz3J5RLX4sE2wFt4+ojbB+jMa6qXwE2i3h9xlahOlNzuXqDcXQzfGcHyXURhpmPfycKF6NJs6KsQETmbgNsQegLpgcsyk9UibtzwY9dbGLm4lJ2f6p6MrUj5vIEIDNlYKajXMteSvYQbCUfQVsdzTyGNgUtZ7NLXbcbUfaWoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZ4SK1Xx; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7370698a8eso515033466b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 00:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763971686; x=1764576486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YLf2E3nOZAEZ9lLAngAWJ9piteS0oS4r7Jb/uJKZm84=;
        b=IZ4SK1Xx7gPnoWDndAzVWocnAxgVDgGX+2qyFPC/t0cbfCIZKtbpGxr8EwPoouwY2M
         zBgmS8xYMcNa5i+jlTP7B6KdSsyzjhs5P9dPAlHPUa5+Ng27OJVkSglQB9jsqzumu0er
         4JcxcCQAsz5I5pCH2VBeKwaqYxy0tnZdHOpuSEsVmbxBNX1O96QKzoFjJ/qHIORMDcYG
         LORJfuTZMEhL75ljiHi6ZgMSYnWAvYEkOmVr9q5xrehheNOkbD3zAgve5TVYpY1p1p3r
         7tzejLaysfyzAxbZ6Ss7w1M8c/EhB4pSdQTkr5+xtlHcBZbTuN6z/u5ZiPPdBq/4EvQr
         XoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763971686; x=1764576486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLf2E3nOZAEZ9lLAngAWJ9piteS0oS4r7Jb/uJKZm84=;
        b=Wq2mY8uwIvNEqJNt2NE39+4es9oL5L5KQR0evBt9eeurgkZlwgyFB00q46k2sE/npJ
         kurWGDsc4o3dAQcB6pBnrzwuFUr/w8+pGVyCkpBSetNOpXpOFsTsIlps7ET9GLSdWPRA
         p4ULYuKbHJ10RcpUpvXdtjkLoQLABBtvGgV6lO5+BSnmEFS5ipgl9A3jvBYWSrJITs1Z
         ia7BrbXU7hC8B6SibysQGHhmM/o/M0MOlylP/Rnd0UPo11Tp3HtmgcJA3V6CDcvWKSbk
         6nkvBudKwyYxmDhs4kqH9LLaJpy0FZnxviKgIijlku6/rzNmU9YSNcbSsAF7sQhR/hx3
         jbTg==
X-Forwarded-Encrypted: i=1; AJvYcCXRcJzNaLLxa55sRdAhdYBJ3BxUGzNWRZK9B5rPb5k1X+FA6eAOWa8oDO5XK7zIubqpbfjOB8VU/LQQTKg0@vger.kernel.org
X-Gm-Message-State: AOJu0YySWbBWnhqQDY6XFTH0desCi3jTY4vFQBgnCViD7nVKpgfKb8Ps
	LKHf9zjr9pIJVdS9OkuNbibWVjb5z327vvFlyE/V0rjceVLyle+WQXOn
X-Gm-Gg: ASbGncvpyttwhuvzJGy3IzggBrESyyaXOBfqdnea0DDOAUAEXe+d9legrvMp0FZ0xAe
	EV6fvr5Am6/TcQkXQQVz7Xha8Rn5cdZXSRn2yS7fd5EvIDoCOSVw01h6nY+/DWdgfI1C6+JvKIq
	8+l0yyC9oyLMGp+QkyHApmMnKQec85Svd8AOFclchE2/nIKlPvk42rDlHFbdH8t4Emx3uq92H3L
	M8qL6HvyR+I1DH/KeJUetCcGzSk0ynbbKM5cCuF+QPwx3zi8TUwX52MBDO46555x1z4+Ns77KG2
	DPMBksJ7GyzqXrVl+DzU0imT5cBftkZ7gEWnAPmHSRvRIjNvhmJkl7bByH3zVpo02KKr5EIfEa7
	B1Zrymnd6SOTt5L4FnQo6+AKT6JZfJ1xIXDi+geks4r2nS4bgNWW4kyYX/lUmJ6H8R0jDdB9iiF
	QHNg5GKaApKxd8F/sWpACElR4IT0spfGBLmpyHdi8ZfoxSDwHwLeCzEs0Y
X-Google-Smtp-Source: AGHT+IFtSDCdQoEJDSme9cNU9H3jXN99Pr9VF8AAs0+V0hbQXcsw7JNTw9He4Bb9bU9ZG0GgB3qehw==
X-Received: by 2002:a17:906:d550:b0:b76:630d:fd27 with SMTP id a640c23a62f3a-b767153a62bmr1142202666b.5.1763971685814;
        Mon, 24 Nov 2025 00:08:05 -0800 (PST)
Received: from f (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d502cfsm1215050966b.19.2025.11.24.00.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 00:08:05 -0800 (PST)
Date: Mon, 24 Nov 2025 09:08:00 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: syzbot <syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com>
Cc: agruenba@redhat.com, almaz.alexandrovich@paragon-software.com, 
	brauner@kernel.org, dhowells@redhat.com, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	marc.dionne@auristor.com, ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [ntfs3?] INFO: task hung in __start_renaming
Message-ID: <v6f6kfeeur7hhpj74za4larguj2jdhz652cwvmxu5o32ivkuso@cdpkqhx5gt7j>
References: <69238e4d.a70a0220.d98e3.006e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69238e4d.a70a0220.d98e3.006e.GAE@google.com>

On Sun, Nov 23, 2025 at 02:44:29PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    fe4d0dea039f Add linux-next specific files for 20251119
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=142c0514580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f20a6db7594dcad7
> dashboard link: https://syzkaller.appspot.com/bug?extid=2fefb910d2c20c0698d8
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11cd7692580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17615658580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ce4f26d91a01/disk-fe4d0dea.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6c9b53acf521/vmlinux-fe4d0dea.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/64d37d01cd64/bzImage-fe4d0dea.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/a91529a880b1/mount_0.gz
> 
> The issue was bisected to:
> 
> commit 1e3c3784221ac86401aea72e2bae36057062fc9c
> Author: Mateusz Guzik <mjguzik@gmail.com>
> Date:   Fri Oct 10 22:17:36 2025 +0000
> 
>     fs: rework I_NEW handling to operate without fences
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17739742580000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=14f39742580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=10f39742580000
> 

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs-6.19.directory.locking

