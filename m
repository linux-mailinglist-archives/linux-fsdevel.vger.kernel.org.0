Return-Path: <linux-fsdevel+bounces-8073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC6C82F206
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 16:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A549FB22A7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 15:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419111C69C;
	Tue, 16 Jan 2024 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e5Mt1Fjv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA431C686
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705420693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j3+81Y370yZULKu921Q3F9OVI+1X1VMWHK6XvqAJu5s=;
	b=e5Mt1FjvTy+1SgzUPyK+AsXiz5mJAMj1FQ62FSNL06+t/gj8wMCBvk58dke2iVvQBWHHAL
	dHQDRIBKPp6AkKWcNN0Z6epaPxxkW98TmKc4V4t7/84S8lysCTJ/xQxUfUUrLTEuGrlSPT
	5QndeBrjGnlArz1oAc8/4oqtwWn3YVg=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-4A8ZmLCjO2O8SDKljC1-xQ-1; Tue, 16 Jan 2024 10:58:11 -0500
X-MC-Unique: 4A8ZmLCjO2O8SDKljC1-xQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1d5e12eb40dso8352095ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 07:58:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705420690; x=1706025490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3+81Y370yZULKu921Q3F9OVI+1X1VMWHK6XvqAJu5s=;
        b=HhWV6AeGkEBUSpIGIgeYmfgI+4uFwlIUsrqPjTF9/mzRTo2NSWazQK5osweXRxtAOF
         WQrLkz3uTtbpJg5HBdOdlrKeiD/dsaeg/j5Mf3s3qnB3PjJmY+bfNhnh4P4ih5cpv2Ap
         n2o1cQEzHXJhd7TyT3JsEMPkBhwWzRZN0oo/CaoJUOPt02EqiZ1S/VZX+tN5Z0VeDS7l
         xBWX4KWQFjLr4d2bnfcDMjx6C+a6hvpBCyVDKZilyvAs04X0ZZtDsEoZvxHNlc1zraYX
         32DNyTKAJpROTgnCt8mlq1RasJh8clp7SONa2ao5TiI0hojgk0hdNI5XceshwAVvqHEJ
         VoZg==
X-Gm-Message-State: AOJu0YxCZ2qMYQ33Auehoo/7/VijcEubyvc+vUAiWtyugYLVxqZbuRDH
	e9D1cju0IrwfoomLngIjfSiV6S/ZLiQ9sTBC6Wzp2gI8MgvoRk+01r+JJIQ3HgStl8Z/3Ob+abD
	yIjLM7QlnMy/spS/bZLlcy8vFBep6tro+p0tdBjmKnShE8PWcqw==
X-Received: by 2002:a17:902:860a:b0:1d5:6648:a7c2 with SMTP id f10-20020a170902860a00b001d56648a7c2mr8407121plo.65.1705420689954;
        Tue, 16 Jan 2024 07:58:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/5NEy07nCVG6NnmBEYEpT6FFnmHrRdkz28cHmFwSkUBCszqq6bHwK4J8ZyqQ2XTkNvDPrrn/xVsSj8tGGBic=
X-Received: by 2002:a17:902:860a:b0:1d5:6648:a7c2 with SMTP id
 f10-20020a170902860a00b001d56648a7c2mr8407109plo.65.1705420689693; Tue, 16
 Jan 2024 07:58:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000008d00ec05f06bcb35@google.com> <000000000000ac2378060f12234c@google.com>
In-Reply-To: <000000000000ac2378060f12234c@google.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 16 Jan 2024 16:57:58 +0100
Message-ID: <CAHc6FU5iG_tAOSaxzRdri3gugmxgu=Hx3VEYcNRbg2h34k3EuA@mail.gmail.com>
Subject: Re: [syzbot] [gfs2?] BUG: unable to handle kernel NULL pointer
 dereference in gfs2_rindex_update
To: syzbot <syzbot+2b32df23ff6b5b307565@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, cluster-devel@redhat.com, 
	gfs2@lists.linux.dev, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rpeterso@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 4:54=E2=80=AFPM syzbot
<syzbot+2b32df23ff6b5b307565@syzkaller.appspotmail.com> wrote:
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

Another one to go away.

#syz fix: fs: Block writes to mounted block devices


