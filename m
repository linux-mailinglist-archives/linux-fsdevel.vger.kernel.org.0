Return-Path: <linux-fsdevel+bounces-1317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0913E7D8F42
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 09:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A01EB213BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 07:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9496B650;
	Fri, 27 Oct 2023 07:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwGPArsZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57F6947E
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 07:09:16 +0000 (UTC)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C43D42;
	Fri, 27 Oct 2023 00:09:14 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-66cee0d62fbso12756166d6.3;
        Fri, 27 Oct 2023 00:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698390553; x=1698995353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgKgAyxqT9YDrCSnqPSnqf0SatxgPSFF0ABDSieqF/A=;
        b=cwGPArsZBYMimcKmuxdCFSSw0S0e7LMGxTmKyx3cZkiEyTnLil/3vxnLyi3O3v5uhI
         7seRIwom3F40okYwpcG+3uF70mUSI9Nhsdn+Bl5qK1wyPx7EIy0aYGmz1IxDeIxnGGXu
         EdLvGGj4wBbgIzh7i7kyW5uWGUtTblABXNfnPIehO+LS4AxaBEfGxV1zgQP7s06LTezy
         FFZZS6VdCBihISTJdT01tPWErZnoftwWsyTkZrpltUa2WWtomIUrUiHTngKB10LhXmQ1
         fgJlJoiWli22KtBSKUvCKLEpn0dlaXvYqgel+Y82AO3Sbi+naHsoX54hUmVNOfuNnn7T
         icOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698390553; x=1698995353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgKgAyxqT9YDrCSnqPSnqf0SatxgPSFF0ABDSieqF/A=;
        b=bTZzNJv/xJNGX3F88EqwMZb/9ebjc4RUyrcT8coB+BEX+Q+/0q4U9bxOoahWNkOKdk
         l3Vm6OpzVn6YNyk8jRPsqeUg4tsfSZSubam76OTUHoOCWH0ZzQscZxIsw2+/MrEeiVi9
         IVEvPkS8RkGbR5TgEVwtXyxkeCL5QtkNTEKMrmPj+0ZZkpS5qXJhTXWrZqqJYh5XnYNY
         E3hiaAWwbT53/SzFnlJZIWOEes2LDyUYPP9Pnk823pv/myZe2eC8Cw4sPP7cAQxDrMsj
         yA73s/4Iz3U1usnVBfRrYEO63AhUYBMElQQiKD0dthF67yvaq5Yu1ndIilBrH99/peFA
         oSlQ==
X-Gm-Message-State: AOJu0YzlxkAIfTYCyLLNi3PX5djin4VrPY30oKnpANA8sRyLK4bWpWfw
	IHoBMKJT8Z46vRspS1toSOwjdcp4zgy+FVmAHDw=
X-Google-Smtp-Source: AGHT+IHSRMu1lz12/ULhNgz5Q/0KOfO7MdIFjkVDnhT0uVRtK5u/r8+XvP6SSiym7zKmrqD/s6e++6yQlxx9ZefpPAw=
X-Received: by 2002:a05:6214:2688:b0:66d:9f40:4792 with SMTP id
 gm8-20020a056214268800b0066d9f404792mr2628718qvb.26.1698390553605; Fri, 27
 Oct 2023 00:09:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023180801.2953446-1-amir73il@gmail.com> <20231023180801.2953446-3-amir73il@gmail.com>
 <ZTtSrfBgioyrbWDH@infradead.org>
In-Reply-To: <ZTtSrfBgioyrbWDH@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 27 Oct 2023 10:09:02 +0300
Message-ID: <CAOQ4uxj_T9+0yTN1nFX+yzFUyLqeeO5n2mpKORf_NKf3Da8j-Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] exportfs: make ->encode_fh() a mandatory method
 for NFS export
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
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

On Fri, Oct 27, 2023 at 9:03=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, Oct 23, 2023 at 09:07:59PM +0300, Amir Goldstein wrote:
> > export_operations ->encode_fh() no longer has a default implementation =
to
> > encode FILEID_INO32_GEN* file handles.
>
> This statement reads like a factual statement about the current tree.
> I'd suggest rewording it to make clear that you are changing the
> behavior so that the defaul goes away, and I'd also suggest to move
> it after the next paragraph.

Ok. will send v3 with those changes.

Thanks,
Amir.

