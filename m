Return-Path: <linux-fsdevel+bounces-8071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD59782F1FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 16:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6D51C224CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 15:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C231C698;
	Tue, 16 Jan 2024 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QBKMT6dU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADC71C686
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d5ebcbe873so109365ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 07:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705420600; x=1706025400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQbY8Mrxi51oRnesHl3OqUsTVue+4Gtvh2bYWjGB6WA=;
        b=QBKMT6dUgLRzgFYYm7KfYvmiVdMDDPRKLRQioHU4Xk4pVe0IR1ntkUAeOccIEMJ5ji
         7U0IIPd8Tf8cHxE8aRBzKv/PKIwaAKdWTm45aH4csGrMqkbUMZoydDqU5liiYI4EnUI0
         lCgCGUg2bwVN8WcZEa2ikKgldhQDRRiATB13oxtaYHd88/5rBzrvQUGKofdqNDHtQR3x
         LErFu/ETXgM+JRSZZ83NRKy8uDE7MLWkR/PLc/1UqvDp4q52G5WEIWNMb0tg/gKwDtDF
         JA+ljdgD8vF4JzW8qf35mi4gNqAj0EAXBKVEVX9G1LTr5fZxHKws7IYTKY5ZcEjm9ltd
         aC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705420600; x=1706025400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQbY8Mrxi51oRnesHl3OqUsTVue+4Gtvh2bYWjGB6WA=;
        b=GwWwovkZ/hWd6RoKyZpJMLCUMj/KdGObu8MuKMWRgu3LNzRS/kYaUh6uQcTlIW1jfY
         JyWn8emU1N7a+QVRDLfajEIZ+hJUt6sgrd8vLJX3tflyhwpCzkRyOI+rwR4yIhDc9Cre
         W7TJncTcQjYFm+mbUc2aih9XMnDyGanmoB8z9mxRYZwfNX/LJID1dpch19npym1tyyYu
         8EKOBpJg6EDgYcMk+o/fEb2eT0Iebc6bqa3f+u/TbXsUVQT5G5yRvKYSgXClsB0n9oPP
         W1dexHTv5DmaP1DH6rBGnWfJmA9dP2Y92OceoiYYZwkhLBUYiTe9RfwxjzI7irDGXRNv
         N4sg==
X-Gm-Message-State: AOJu0Yy51Pv4l/KllDWoo/XzM3wRpUztMVG3LljU1H3videkN1TNZnyV
	h36SuAbLmLbAq5Q1kjjX1vauD5ae1SkAqpOVO2xh+SpppA37
X-Google-Smtp-Source: AGHT+IEFpSNk4yBS3FQmOkIM6MlBaIX6qNQNXfqDHiHknuvALzTkBvr0USexOou2u5DTtKnzkASC4edoT/chV8i6aJg=
X-Received: by 2002:a17:903:191:b0:1d4:ceab:58ba with SMTP id
 z17-20020a170903019100b001d4ceab58bamr6868plg.10.1705420600448; Tue, 16 Jan
 2024 07:56:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000008d00ec05f06bcb35@google.com> <000000000000ac2378060f12234c@google.com>
In-Reply-To: <000000000000ac2378060f12234c@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 16 Jan 2024 16:56:28 +0100
Message-ID: <CANp29Y4J+bAFu5r8-hATpmsyNJ+insC5Qhws_qops5N38+Fiyw@mail.gmail.com>
Subject: Re: [syzbot] [gfs2?] BUG: unable to handle kernel NULL pointer
 dereference in gfs2_rindex_update
To: syzbot <syzbot+2b32df23ff6b5b307565@syzkaller.appspotmail.com>
Cc: agruenba@redhat.com, axboe@kernel.dk, brauner@kernel.org, 
	cluster-devel@redhat.com, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz fix: fs: Block writes to mounted block devices

On Tue, Jan 16, 2024 at 4:54=E2=80=AFPM syzbot
<syzbot+2b32df23ff6b5b307565@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
>
>     fs: Block writes to mounted block devices
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D12452f7be8=
0000
> start commit:   0a924817d2ed Merge tag '6.2-rc-smb3-client-fixes-part2' o=
f..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4e2d7bfa2d6d5=
a76
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D2b32df23ff6b5b3=
07565
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14860f08480=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D174d24b048000=
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

