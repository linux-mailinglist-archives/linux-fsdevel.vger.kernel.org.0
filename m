Return-Path: <linux-fsdevel+bounces-3315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BA77F3233
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 16:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC7A282D24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 15:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C96F56770;
	Tue, 21 Nov 2023 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/Ot7DRs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A129A
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 07:19:07 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1f0f94a08a0so3365108fac.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 07:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700579946; x=1701184746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ouzZJaHmdqZqkZMF9I8bHcphynZsuLF6HgpRgkdlsZU=;
        b=O/Ot7DRsk+COmXFkqvw+qnmgefZ+I//V6tzfjUBPAt62RedBNOOMBXRM/f2GRJlhQ7
         VNGzS8G3szrOkBgUS6kCE+hl/h/lSTqkvD67EaOZVz5JHCL2iuz8XQAc2fdy/7YJb8ek
         jCAVVr6cVhbH1ObM2N9KyQcmji14Iq7wgL04k+Db6yPiFLMGWaR/FKrWbMNz2Qt4e+q/
         H91xmSkoMP2NaD9RFY1/J9z0DH2KAJOFf+rJrcRoh/JZMnbY0DHgpc025uaiGcPwGuT/
         xVx47fe1hzWdQgLFGpYDTbc21zFK5wSiugdZAogVLsOzRT2wC918K1twOfacSe+kzoLj
         pnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700579946; x=1701184746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ouzZJaHmdqZqkZMF9I8bHcphynZsuLF6HgpRgkdlsZU=;
        b=UKANz0qC8djD5MMfTXh7mzRQRbexeY84jq/w3KYwv1HirVaX57rDPCYk8po3TZCGAr
         NMhKr56TVUKGoWPS4/ZcH/Pvt/SbL/uTsNwn3q+uRDAlVWR/c0mMFeBQrm3rNbI8gkNJ
         m5La46U7O7JZtk+9iyrZsHe0J1sFkESat8WGxwczmkc4b4VImbU0E8GaIeUm86c+8vEP
         pf9MEcw/R85IOF3UBx+OmtqlLt6dNaV1v3+nOm9GaUkU1zW6DFRWBu3guP3TkPXHM9fB
         vD3El3qQiw2onfNUdCyHe0fiGD6OueSvL+7wOYDJ5Gt2OUg5FVxPjFRA/mnkabljcVUA
         efsw==
X-Gm-Message-State: AOJu0YywJdz0+6Mvyg2hqdWPXxXKOpHhLCsTA+CrLtXupgqSioQiyRr0
	pGlU2I7GN4wIHBrwrzHjC6N83uP3FM+Cnp9lEj8=
X-Google-Smtp-Source: AGHT+IEvc8ICwbYE75Ku30yxlg3wpW/bGOAy4caC4sBAcPmHk5XWEPBPEweFWDX8ns5/BufZU0o8aIXRSBVgb55gyI0=
X-Received: by 2002:a05:6870:f68d:b0:1ea:7f54:77ad with SMTP id
 el13-20020a056870f68d00b001ea7f5477admr12756586oab.15.1700579946465; Tue, 21
 Nov 2023 07:19:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231114153321.1716028-1-amir73il@gmail.com> <20231114153321.1716028-6-amir73il@gmail.com>
 <20231121-einband-erwidern-a606cece3bc0@brauner>
In-Reply-To: <20231121-einband-erwidern-a606cece3bc0@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 21 Nov 2023 17:18:55 +0200
Message-ID: <CAOQ4uxiExXqwuoPvLQvUj7mgPTkm40H+goLqGCgn8-+wFrOfOw@mail.gmail.com>
Subject: Re: [PATCH 05/15] splice: remove permission hook from iter_file_splice_write()
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	Miklos Szeredi <miklos@szeredi.hu>, David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 4:56=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Nov 14, 2023 at 05:33:11PM +0200, Amir Goldstein wrote:
> > All the callers of ->splice_write(), (e.g. do_splice_direct() and
> > do_splice()) already check rw_verify_area() for the entire range
> > and perform all the other checks that are in vfs_write_iter().
> >
> > Create a helper do_iter_writev(), that performs the write without the
> > checks and use it in iter_file_splice_write() to avoid the redundant
> > rw_verify_area() checks.
> >
> > This is needed for fanotify "pre content" events.
> >
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
>
> If you resend anyway, for the low-level splice helpers specifically it
> would be nice to add a comment that mentions that the caller is expected
> to perform basic rw checks.

Will do.

Thanks,
Amir.

