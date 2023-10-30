Return-Path: <linux-fsdevel+bounces-1585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D16BE7DC18E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 22:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E0C1C20B74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 21:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9082A1BDE9;
	Mon, 30 Oct 2023 21:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bEW+nkfR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA341C28F
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 21:05:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA5EED
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 14:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698699915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1JmURPcvLtSqLUUbFA7SrmnbERd26AC5lme3Qx7nOkM=;
	b=bEW+nkfRZw1fTRzn6LzOi+Dq+Y0lvS7dvJ78R5MV8IRVQGo5QiY5IoE4wZ3V7wdbcMogEp
	iU8e+Q8GuD67t7tqpqXRS5doZRP+4NDg1u0td4IdT1u49omv6pbLzI7SV1QDW5F3tn2Njw
	10hCaqFea/MJ+SbkvYPD7p4LukN+3DA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-JGg-KlClN1y1wCX4VCYyhw-1; Mon, 30 Oct 2023 17:05:14 -0400
X-MC-Unique: JGg-KlClN1y1wCX4VCYyhw-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cc41aed6a5so11566635ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 14:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698699912; x=1699304712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JmURPcvLtSqLUUbFA7SrmnbERd26AC5lme3Qx7nOkM=;
        b=wcLwBiiIEtBKx3CRyluiDYfH1QoXe/HP9NLy/DblsIxgxAbyXovioD+dykeSxrmbkD
         qtLlGVQx2qcOIy759vtNsR1ZZBd45xaJWP3+/DtrmRR+LOTmdZK4MYs7pvup9ZZ9TR7P
         YXnWzi8PGNjvXihje0vUI/TcS2JX/mY0hh0Xa0R//Hbmxw9KjoRxmYlNfc6+xucdVp01
         o1Nw6dQpR7oFnMtetK2MikfXSu2luxuvW7eGBN9BfWQgeWeO7CmFYkIR8+Wfudd14/wL
         hgiMOSZyczIbhntuPb3ugTtXdqe/GzrwCWx38M69GvTWHVDCa9enEDvBkO5m9lZRWn+E
         uCnQ==
X-Gm-Message-State: AOJu0Yzbzl7x4aSC4Bo6KqZI+4QfZofTlAMYNPMD6VUWmTb4+bR9QmM5
	ZM0ng1OKwhOqsqhhl1jOQ6BNyR+5LM31aeZsyRH1oPjPhmjQKstgrTiMiXzLfk0Nocb9rb+tZwf
	0zil9ksQ/mC4tE3Z6q5pDZuPdgjymS+D3H+fCzpPNhc5wueF12nBN
X-Received: by 2002:a17:902:bf44:b0:1ca:c490:8537 with SMTP id u4-20020a170902bf4400b001cac4908537mr8378139pls.14.1698699912570;
        Mon, 30 Oct 2023 14:05:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzbZk3QaOS4ZLoC9Xi0ie7QckJKqDxiUMckdm8KX4ydz1J+XDcKYN3ZT+xrDzl974H1L6JMnNQ06VhK1wjIKY=
X-Received: by 2002:a17:902:bf44:b0:1ca:c490:8537 with SMTP id
 u4-20020a170902bf4400b001cac4908537mr8378130pls.14.1698699912248; Mon, 30 Oct
 2023 14:05:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000000c44b0060760bd00@google.com> <000000000000c92c0d06082091ee@google.com>
 <20231025032133.GA1247614@ZenIV>
In-Reply-To: <20231025032133.GA1247614@ZenIV>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 30 Oct 2023 22:05:00 +0100
Message-ID: <CAHc6FU4Zd0szGBzZBx212K4MgjFJAEMwD1jbTraw0ihMG14Z2w@mail.gmail.com>
Subject: Re: [syzbot] [gfs2?] WARNING: suspicious RCU usage in gfs2_permission
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: syzbot <syzbot+3e5130844b0c0e2b4948@syzkaller.appspotmail.com>, 
	cluster-devel@redhat.com, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, postmaster@duagon.onmicrosoft.com, 
	rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Al,

On Wed, Oct 25, 2023 at 5:29=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
> On Fri, Oct 20, 2023 at 12:10:38AM -0700, syzbot wrote:
> > syzbot has bisected this issue to:
> >
> > commit 0abd1557e21c617bd13fc18f7725fc6363c05913
> > Author: Al Viro <viro@zeniv.linux.org.uk>
> > Date:   Mon Oct 2 02:33:44 2023 +0000
> >
> >     gfs2: fix an oops in gfs2_permission
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D10b21c33=
680000
> > start commit:   2dac75696c6d Add linux-next specific files for 20231018
> > git tree:       linux-next
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D12b21c33=
680000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D14b21c33680=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6f8545e1ef7=
a2b66
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D3e5130844b0c0=
e2b4948
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D101c8d096=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11a07475680=
000
> >
> > Reported-by: syzbot+3e5130844b0c0e2b4948@syzkaller.appspotmail.com
> > Fixes: 0abd1557e21c ("gfs2: fix an oops in gfs2_permission")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bise=
ction
>
> Complaints about rcu_dereference() outside of rcu_read_lock().
>
> We could replace that line with
>         if (mask & MAY_NOT_BLOCK)
>                 gl =3D rcu_dereference(ip->i_gl);
>         else
>                 gl =3D ip->i_gl;
> or by any equivalent way to tell lockdep it ought to STFU.

the following should do then, right?

    gl =3D rcu_dereference_check(ip->i_gl, !(mask & MAY_NOT_BLOCK));

> BTW, the amount of rcu_dereference_protected(..., true) is somewhat depre=
ssing...
>
> Probably need to turn
>                 ip->i_gl =3D NULL;
> in the end of gfs2_evict_inode() into rcu_assign_pointer(ip->i_gl, NULL);

That's what commit 0abd1557e21c6 does already so there's nothing to fix, ri=
ght?

> and transpose it with the previous line -
>                 gfs2_glock_put_eventually(ip->i_gl);
>
> I don't think it really matters in this case, though - destruction of the=
 object
> it used to point to is delayed in all cases.  Matter of taste (and lockde=
p
> false positives)...

I don't understand. What would lockdep complain about here?

Thanks,
Andreas


