Return-Path: <linux-fsdevel+bounces-1505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D05D7DABED
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Oct 2023 10:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5675281699
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Oct 2023 09:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E538F7E;
	Sun, 29 Oct 2023 09:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNa/8tK5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EA720F5
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Oct 2023 09:50:16 +0000 (UTC)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEBABD;
	Sun, 29 Oct 2023 02:50:15 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-41b406523fcso27207371cf.2;
        Sun, 29 Oct 2023 02:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698573015; x=1699177815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P28X6pfw1YMZ50dMj1Z2ceMTILza4KIjApTCmG3AzCw=;
        b=ZNa/8tK5loXuQdzdFRMKwZx6OxvXWVypBdiwDguYYvj1M1/ikN/NoqjtlSyagY00QW
         MXIMDWjKHFnU9dS8aBts4MIgzfL99HpphDU3Kkx6MNGbslz5gvq1fy8P6DVh/h1vH5nM
         zrZGTEkV67SiFoKoBwwNYCIZZDRsccksqGWfJfCoY6LsyiyP1RuXzbqqN8rBpNRg4JSt
         daYRuyDZIdYeYd6dRYWy7d1Nm6SFeWYsFhPfdo1GMzFB0zMe8sTIMgrjtqNWZoi7Ms9w
         JXfyPc7ud4sxDKb2tFPXS7x2gQ3XjTvf3jt9Qx6CjyZ4Ott4IS1wreouKZteAEBSCUom
         suxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698573015; x=1699177815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P28X6pfw1YMZ50dMj1Z2ceMTILza4KIjApTCmG3AzCw=;
        b=XXog1V/z0LEKaWywjEPtEm/P+5xlfwulywfygRayTAjM6qjcBeNBsTsK/LnkApk9oU
         HrOFdmhrL8n+nhWtGXMomnWyTYFj6D2vra21u2jBaSMEMVvI+CLNXeTIi3G1TNvI7oo5
         W+FoOENsIEJKFZrEOaZg3CVWXrOk4vElwOy0QhiqQ49jV++VttWxJ6cuEAhcQpAr4ivM
         L3zzVxDXNryDucv/S5ovlirwa+BvJDE5nXifFdARb8Mah6TajTK/0ldbQvqidG8xkHYz
         7kO2BdarFTBD2oLTl3ZkRAbUUStqTnSRVjGgoT6H9SZQsu8bxXD35FP5AiUYKWjW6gha
         tJ/A==
X-Gm-Message-State: AOJu0YwhTFJRtDTCwQGj+Ul9bXPKV1XJwsEKahpqVbqs8oK3BuAn2FF9
	N1GBInOQekeoE9+7nQ8dwEB+vtsYZ/p4L0SsEs0=
X-Google-Smtp-Source: AGHT+IEhLT56WPc+S0TNKePzSMVDfhsAdj3oeTPdHRnCAiMo6VgkOFkDEQZ9MGCGaGgSplkOdtT4/IKvtd8c03fauz0=
X-Received: by 2002:ad4:5aea:0:b0:672:24bd:3e3f with SMTP id
 c10-20020ad45aea000000b0067224bd3e3fmr969544qvh.31.1698573014724; Sun, 29 Oct
 2023 02:50:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023180801.2953446-1-amir73il@gmail.com> <20231023180801.2953446-3-amir73il@gmail.com>
 <ZTtSrfBgioyrbWDH@infradead.org> <CAOQ4uxj_T9+0yTN1nFX+yzFUyLqeeO5n2mpKORf_NKf3Da8j-Q@mail.gmail.com>
 <CAOQ4uxgeCAi77biCVLQR6iHQT1TAWjWAhJv5_y6i=nWVbdhAWA@mail.gmail.com> <20231028-zonen-gasbetrieben-47ed8e61adb0@brauner>
In-Reply-To: <20231028-zonen-gasbetrieben-47ed8e61adb0@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 29 Oct 2023 11:50:03 +0200
Message-ID: <CAOQ4uxh3y1s90d9=Ap2s1BknVpHig7tVX58-=zn=1Ui8WcPqDw@mail.gmail.com>
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

On Sat, Oct 28, 2023 at 5:16=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> > Actually, Christian, since you already picked up the build fix and
> > MAINTAINERS patch, cloud I bother you to fixup the commit
> > message of this patch according to Christoph's request:
> >
> >     exportfs: make ->encode_fh() a mandatory method for NFS export
> >
> >     Rename the default helper for encoding FILEID_INO32_GEN* file handl=
es
> >     to generic_encode_ino32_fh() and convert the filesystems that used =
the
> >     default implementation to use the generic helper explicitly.
> >
> >     After this change, exportfs_encode_inode_fh() no longer has a defau=
lt
> >     implementation to encode FILEID_INO32_GEN* file handles.
> >
> >     This is a step towards allowing filesystems to encode non-decodeabl=
e file
> >     handles for fanotify without having to implement any export_operati=
ons.
> >
> >
> > Might as well add hch RVB on patch #1 while at it.
>
> Done, please check in vfs.f_fsid and yell if something is wrong.

I see no changes.
Maybe you have forgotten to push the branch??

Thanks,
Amir.

