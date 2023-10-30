Return-Path: <linux-fsdevel+bounces-1557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95F37DBEA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 18:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 462FFB20CAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 17:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F9619473;
	Mon, 30 Oct 2023 17:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWdPtsVM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4968E15EA1
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 17:18:16 +0000 (UTC)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8D999;
	Mon, 30 Oct 2023 10:18:15 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-6711ed1a64cso13820436d6.2;
        Mon, 30 Oct 2023 10:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698686294; x=1699291094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bcQoOnM8NFST22lR8EyRdsJ3jqYdJataIZ4/fckVWo=;
        b=AWdPtsVMHb6F5Aakbn/y03P/4o3qYsR1dZSAGT3c5lcZ8TP/2qv/ayJVtuBxeCfzzy
         nRskUyfNNE/C4ges6JHgXKhPxv9SuZCjJsaDdYV4ax3ywX4nZqizP687BnlB2MLvN3cP
         hCUyiLrigkFTysjaGO0ELHMHcMH99s99PF1EuDLjrL+LKHk2MjP1lnfV6sMhNZLIpaA5
         hedOdVtzkAkKQfZ+bU8or9kjqU6y0zM8rr2SfLnQdhRSu7J17MwPYxgLHhqZQSlRVNh+
         u2z7q+uuUvRySx5q08znefygiyJ+p3AiniG9KmUVKt2DtyWbyDF/cR9tfICpiZfqTcl8
         ghdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698686294; x=1699291094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bcQoOnM8NFST22lR8EyRdsJ3jqYdJataIZ4/fckVWo=;
        b=CtzTPU0AYREmRCUegRr1wTx6p52BlTml+zUIGtDiRc7FwVz2BG5nuvRM5dX0oNOsdd
         TmzqukQaD9Wv4xH81ZtAl16fYFlQPiG1uy3re3T4zpgmvIlBb41oDeSRTnt6HIuaYfu/
         YxTtRw63wH+I/7Uwa39g2IIJTcVHIYVyKQUIC6Wz8RI7zcJaRjL1YYT48r1KhBsQ1myF
         TySg+RaMHjKGoXa5O6z90FqZ37/HAi3/E/Vans9owxCNRhu5MneOc9sd4QgQEBchZSfQ
         NuYgYRQ6Hck45WMPpCm/6ToecSllhKRWzk+2nOMVoADsEaPHLJIS3WZmHvEWxcpkYkwb
         U3lQ==
X-Gm-Message-State: AOJu0YxXLVC5wi2CI0xoY8f9IVyNpzpD12Qfa9A+zVSV6eBQeHkcMBza
	J/YfL2MjToGLO5JJVhkoPwW5KVvPalqV7jAg8S0=
X-Google-Smtp-Source: AGHT+IFsPaxyANlWGGM5sB582yDeWOqQk+L7JeSqA3Zw8w7vkdRe3SHVHLQ14ozL8HJFVqI4lxHmWsNyeWTo5NT9SvA=
X-Received: by 2002:ad4:5c89:0:b0:671:2c4f:3e2e with SMTP id
 o9-20020ad45c89000000b006712c4f3e2emr8273321qvh.61.1698686294056; Mon, 30 Oct
 2023 10:18:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023180801.2953446-1-amir73il@gmail.com> <20231023180801.2953446-3-amir73il@gmail.com>
 <ZTtSrfBgioyrbWDH@infradead.org> <CAOQ4uxj_T9+0yTN1nFX+yzFUyLqeeO5n2mpKORf_NKf3Da8j-Q@mail.gmail.com>
 <CAOQ4uxgeCAi77biCVLQR6iHQT1TAWjWAhJv5_y6i=nWVbdhAWA@mail.gmail.com>
 <20231028-zonen-gasbetrieben-47ed8e61adb0@brauner> <CAOQ4uxh3y1s90d9=Ap2s1BknVpHig7tVX58-=zn=1Ui8WcPqDw@mail.gmail.com>
 <20231030-zuhalten-faktor-e22dccde22cf@brauner>
In-Reply-To: <20231030-zuhalten-faktor-e22dccde22cf@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 30 Oct 2023 19:18:02 +0200
Message-ID: <CAOQ4uxi2FNCOQ-ShwgdYK=y=LFOgDCeCkkrXPehLRdZz3TNR_g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] exportfs: make ->encode_fh() a mandatory method
 for NFS export
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	David Sterba <dsterba@suse.com>, Luis de Bethencourt <luisbg@kernel.org>, 
	Salah Triki <salah.triki@gmail.com>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Dave Kleikamp <shaggy@kernel.org>, David Woodhouse <dwmw2@infradead.org>, 
	Richard Weinberger <richard@nod.at>, Anton Altaparmakov <anton@tuxera.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Steve French <sfrench@samba.org>, 
	Phillip Lougher <phillip@squashfs.org.uk>, Evgeniy Dushistov <dushistov@mail.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 12:26=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> > > Done, please check in vfs.f_fsid and yell if something is wrong.
> >
> > I see no changes.
> > Maybe you have forgotten to push the branch??
>
> I fixed it all up on Saturday but then didn't push until this morning.

Looks good.

Although kernel testbot just complained about the CONFIG_EXORTFS=3Dm build =
error
in the bisection of the current linux-next, so maybe we should squash
the fix patch.
I have no strong feelings about it, so whatever you decide.

Thanks,
Amir.

