Return-Path: <linux-fsdevel+bounces-6339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A13815E44
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Dec 2023 10:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CDA91F22002
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Dec 2023 09:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878031FD7;
	Sun, 17 Dec 2023 09:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhiE4dyK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAF71FAD;
	Sun, 17 Dec 2023 09:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-67f30d74b68so6712856d6.1;
        Sun, 17 Dec 2023 01:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702804580; x=1703409380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbSaVhmyYdnzBKhQuQo4oOm2wwCddJ5JEF6JG+CBOso=;
        b=YhiE4dyKZ74ndk3X+elukB6TMcNajSxLri+W74tuqnLLmhS7L9oZDG4VPIZA+M2c26
         OGJpUofT3GZG431tidkWedDUZuj2LiyYsWWg7lBa7ww1qbjOE/iY60RanUaiNkOnukyv
         G0W4QD20FZsVYCL+Bef9fpvw9xEXFpklMsK7HFI3KDjzyZCTPh+8Rip6Rtj4i4+tyHkM
         gQI5Obx7/wZlbLvtvq+sahRwKTfJMw7yIS+KusftGOwGPL/oIq+OKq2nDhRJPRRkGi6V
         KccpjbXj7aI3G0DNTDHovuNWluVLqoe2Ngchhi0KAJtwQQ8LU5u0Kqh6oOkPKB2D730S
         eM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702804580; x=1703409380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbSaVhmyYdnzBKhQuQo4oOm2wwCddJ5JEF6JG+CBOso=;
        b=SKMJ4za3ZXClOWtTVi4i4/4KPcyza1R70PRWSIgIbBUCw4dN/tZrxY4fWel3MlRfTt
         KjuOnEzbNiDu6Yfu4mQkCM7QjUh1fXTajSGG9cQ9CSccAGGME5+Xi6A44uDeTe9IMFRI
         PuUW0b2R3xg+TQnB4P81sWZ3RkUPjuNjJNyERbwRCPm4nwQSM3vWRs2dfpY8QZ6maFWJ
         vZ5TBr1P4+JzygSjWhl0obnZXCNlhLM0kXrZRQdk/sSVFTorxJqFoQXjXpK2U39L1EPK
         TEfKBcI30one95FdsE/5KIaH+AobA8uPCYnqeE5Di/2HcL8qP+YEl3jXm1s9ZTmnzv2M
         RdGA==
X-Gm-Message-State: AOJu0YzPX2VDNMHan+4qvLxKAxRZhofgEknpOLdIAakaPgg/Mfy3UwuH
	eceK/iLlXVIj622srRrBpfZbi2NxuhB7sNuVclU=
X-Google-Smtp-Source: AGHT+IHWOIfOlkls2hz3KVLlwe8JW+6pkguQ1zCX7LCxKZDQCCA11G0G/5+r6L2wIwK08YmDAXAa2IcIHeIQDTXrv3M=
X-Received: by 2002:a05:6214:1c4c:b0:67f:2541:1b6a with SMTP id
 if12-20020a0562141c4c00b0067f25411b6amr4585014qvb.17.1702804580557; Sun, 17
 Dec 2023 01:16:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000863a7305e722aeeb@google.com> <0000000000003362ba060ca8beac@google.com>
In-Reply-To: <0000000000003362ba060ca8beac@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 17 Dec 2023 11:16:09 +0200
Message-ID: <CAOQ4uxjjo=qwwWcRXhv_D+KFfnPa_CEOrPbbZtzLroiOO7eYDg@mail.gmail.com>
Subject: Re: [syzbot] [reiserfs?] [squashfs?] BUG: Dentry still in use in unmount
To: syzbot <syzbot+8608bb4553edb8c78f41@syzkaller.appspotmail.com>
Cc: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, phillip@squashfs.org.uk, 
	reiserfs-devel@vger.kernel.org, squashfs-devel@lists.sourceforge.net, 
	syzkaller-bugs@googlegroups.com, terrelln@fb.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 1:19=E2=80=AFAM syzbot
<syzbot+8608bb4553edb8c78f41@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit c63e56a4a6523fcb1358e1878607d77a40b534bb
> Author: Amir Goldstein <amir73il@gmail.com>
> Date:   Wed Aug 16 09:42:18 2023 +0000
>
>     ovl: do not open/llseek lower file with upper sb_writers held
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D13723c01e8=
0000
> start commit:   3bd7d7488169 Merge tag 'io_uring-6.7-2023-12-15' of git:/=
/..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D10f23c01e8=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17723c01e8000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D53ec3da1d2591=
32f
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D8608bb4553edb8c=
78f41
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D17b8b6e1e80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16ec773ae8000=
0
>
> Reported-by: syzbot+8608bb4553edb8c78f41@syzkaller.appspotmail.com
> Fixes: c63e56a4a652 ("ovl: do not open/llseek lower file with upper sb_wr=
iters held")
>

#syz test: https://github.com/amir73il/linux ovl-fixes

