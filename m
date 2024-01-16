Return-Path: <linux-fsdevel+bounces-8038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D660B82EB6C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 10:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6396B1F23DF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 09:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A1B12B82;
	Tue, 16 Jan 2024 09:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1UCSgVcN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA8312B61
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d47fae33e0so355635ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 01:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705397100; x=1706001900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKa6o7frE7cAq4cWeMN0RRhba2ve9NcMTWMZZZ/7rLg=;
        b=1UCSgVcN3J5ZBZyv0E6V74mSHAYrBp6qhfr/3qW+E6PC7WCnO5PFeRkzWD+oxULWrH
         1i31SnfhhleHzQ98BEHpHxcn1IUTGGrmHgp3tWTzW/veRxUezN8WFRwTbpAQw+fzS4UT
         gEfvc9tPpWzz//8nIjU37vFoiigkt3ffF38RWWRtGC7YcSNz4xqrBcvWgjR+xmzicN5I
         cp/CRVwqlGqqtLTfaO5VWsN8m9a9tcptp4GaFWXS39winiv/ga20xO8K5PsKnkHaBcQH
         ZuaRZo0TG55nfRb0Jpi53ZuNmijz8m72xy9XZE5pvMHuAkFDK2CuNw3i7BTNVzaJliD4
         /jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705397100; x=1706001900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKa6o7frE7cAq4cWeMN0RRhba2ve9NcMTWMZZZ/7rLg=;
        b=CP8Vpp49zK3aK2cdWAnJ7lUMdiaMRb2wRj9SXnJsHXJl2/PWdYq8Ar6VIJLfsg8Jee
         0a9Pr94slqUp5YilICgwwwLjvMuE1ge+gB2ajiAaNyHIC2jR6kV97Qf/NlPjF0hyavf8
         uhSIFGbHqs+LVZbVpl80r7vlIkg9ptqf76lZt6cERWi+thEetQo6axKcDWUuhUHy3ojX
         ahtCWyfPjadaztZnabvUsthoXBgVzvX/gCNuym+GCZhp2V9svdLds7aDV1UZ/zQHwQ6J
         LOS+DIz5BO/uUBjWZzIGxvgDLUAWoLqWmTQW8xrg9noD4tDjkai+gANTNxA8YzYFZMNe
         ILVQ==
X-Gm-Message-State: AOJu0Yx10wgzNwrczD1ikc8kY21MdkN6QsjBFKU+KI8OUb/tHnMGHlUg
	C20ARq5YJRoVRysn1p/vj2sWS1FAYqvcbc8dcYSZC7ivubY3
X-Google-Smtp-Source: AGHT+IH2N+LXlQ1VOCyauXZQF1qVOnbGiJyJ6dzx3F/X3/F1giNPKttpEmDP+89ak1lCUrtIkPCBp85ezYuDsYasAK4=
X-Received: by 2002:a17:902:fc46:b0:1d5:ad0f:7354 with SMTP id
 me6-20020a170902fc4600b001d5ad0f7354mr508581plb.21.1705397099900; Tue, 16 Jan
 2024 01:24:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000653bb6060afad327@google.com> <0000000000004d67e4060f0bcc7b@google.com>
In-Reply-To: <0000000000004d67e4060f0bcc7b@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 16 Jan 2024 10:24:48 +0100
Message-ID: <CANp29Y4Aq4SteF7HqnexK4azquKrUbV9-dcfBqsxFf3snMJrew@mail.gmail.com>
Subject: Re: [syzbot] [bfs?] general protection fault in bfs_get_block (2)
To: syzbot <syzbot+dc6ed11a88fb40d6e184@syzkaller.appspotmail.com>
Cc: aivazian.tigran@gmail.com, axboe@kernel.dk, brauner@kernel.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yuran.pereira@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz fix: fs: Block writes to mounted block devices

On Tue, Jan 16, 2024 at 9:20=E2=80=AFAM syzbot
<syzbot+dc6ed11a88fb40d6e184@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
>
>     fs: Block writes to mounted block devices
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D16c3c513e8=
0000
> start commit:   98b1cc82c4af Linux 6.7-rc2
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Daec35c1281ec0=
aaf
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Ddc6ed11a88fb40d=
6e184
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D16783b84e80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D165172a0e8000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: fs: Block writes to mounted block devices
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>

