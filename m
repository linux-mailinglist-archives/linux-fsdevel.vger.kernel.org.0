Return-Path: <linux-fsdevel+bounces-8070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DB382F1FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 16:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB661284FB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 15:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBAA1C694;
	Tue, 16 Jan 2024 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUuys75n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CBD1BF3A
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705420558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EkaObLRiZU2WVUtOEp3KCOMnmv+FaFDDWJ1dwMpQFZ4=;
	b=UUuys75nzd0ticNVRFUOAow5I4Y6pue7CxfVAR134eZlmYIREULnggiDUNNgFDdFTf0m3e
	/Bg8SSQDcjhNbbcUb8TeVseFu7mCrVb6GdrA/QpqhzQ/yJrT6VzhlT8Krfn01/R0MNwyjr
	7x0Smcuy2YinVUww945BjTLxGjc+t1A=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-Kr0BV9oMN6WD-pINyyPXqw-1; Tue, 16 Jan 2024 10:55:56 -0500
X-MC-Unique: Kr0BV9oMN6WD-pINyyPXqw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5ca4ee5b97aso3873925a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 07:55:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705420555; x=1706025355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkaObLRiZU2WVUtOEp3KCOMnmv+FaFDDWJ1dwMpQFZ4=;
        b=CXXeJIxy4i0qzziq8eHgb7KfIGWT03YEFXWwYws44fQagvxdrNUDLGK1qahB/+KTAG
         dvyJB0jaVK2epp9CP5PVp/zrKNL+8AnW9/zDZNStIYO2Y9c/iYdMkL4HBzRFlx78X7YA
         NVT1WA2d0Y64G/5Ly//vbAXvz5LQ04uNbZ+9MFKEfwHEJEsE7MpgWHcjdoXTDcLEMg3u
         OpmAfcdIZogai5uMTNV6qU/btxXAFz+K5Kkp15rfm8A2ht9LHwyn4HGmUvsTp5Cb5a0m
         WPMBURVnuAmDFXhK7zhgQfFscMuf5uMOx4ik3dQPV1xzpo2ivBdvaSLB7E7GfEQZqtnK
         HoAg==
X-Gm-Message-State: AOJu0YyCjSZ0mWC/QboI03+S85C8Nr96q8IQUsBBhSrjYVogQ3sQzol7
	o4B2BVz0prYWhyqRTs8aU7GRgKlowMQyC0NZlGGIYTJXB08Ha+yFP3nOBVSHFcQp2aV3VEqtTyE
	/LvSsmaJb5wUnJdsuk11psk2BWtodQMP4nLwULriJxG/r0NzrTw==
X-Received: by 2002:a17:902:a98b:b0:1d4:672f:4809 with SMTP id bh11-20020a170902a98b00b001d4672f4809mr3966894plb.129.1705420555678;
        Tue, 16 Jan 2024 07:55:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZQrzkzOTwvJXIqY16Mk/9F/L79khIzMK3iukN9JqmT78QTW3UdlrX8fmF1HTGkx/EuRv2R27m2byQtY34e3Y=
X-Received: by 2002:a17:902:a98b:b0:1d4:672f:4809 with SMTP id
 bh11-20020a170902a98b00b001d4672f4809mr3966881plb.129.1705420555426; Tue, 16
 Jan 2024 07:55:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000057049306049e0525@google.com> <000000000000fa7c3b060f07d0ab@google.com>
 <20240116103300.bpv233hnhvfk3uvf@quack3>
In-Reply-To: <20240116103300.bpv233hnhvfk3uvf@quack3>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 16 Jan 2024 16:55:43 +0100
Message-ID: <CAHc6FU6wzkniuMormDzthUpj3fCap-iFFRfa_skEAvp6fwBOJA@mail.gmail.com>
Subject: Re: [syzbot] [gfs2?] BUG: sleeping function called from invalid
 context in glock_hash_walk
To: Jan Kara <jack@suse.cz>
Cc: syzbot <syzbot+10c6178a65acf04efe47@syzkaller.appspotmail.com>, axboe@kernel.dk, 
	brauner@kernel.org, cluster-devel@redhat.com, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 11:33=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> On Mon 15-01-24 19:35:05, syzbot wrote:
> > syzbot suspects this issue was fixed by commit:
> >
> > commit 6f861765464f43a71462d52026fbddfc858239a5
> > Author: Jan Kara <jack@suse.cz>
> > Date:   Wed Nov 1 17:43:10 2023 +0000
> >
> >     fs: Block writes to mounted block devices
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D165bebf5=
e80000
> > start commit:   3f86ed6ec0b3 Merge tag 'arc-6.6-rc1' of git://git.kerne=
l.o..
> > git tree:       upstream
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dff0db7a15ba=
54ead
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D10c6178a65acf=
04efe47
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D13e4ea146=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13f76f10680=
000
> >
> > If the result looks correct, please mark the issue as fixed by replying=
 with:
> >
>
> Makes sense.
>
> #syz fix: fs: Block writes to mounted block devices

Thank you, Jan.

Andreas


