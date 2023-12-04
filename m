Return-Path: <linux-fsdevel+bounces-4778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF1380370C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 15:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4C31C20ABD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 14:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139D628E18
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bn0ForX3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEFBD8
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 06:29:14 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1f5bd86ceb3so2494687fac.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Dec 2023 06:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701700154; x=1702304954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1mzcUcdIhX4XjigbGQvM+k2DG2zRM9tGnCLPvXKu20=;
        b=Bn0ForX3/o8HyJ09ZUpmO+u+q6+mQuLgR1VbDd4lJcQMm1m38m7yGS+Rx/bGpabBTR
         fDJR5D3jNfufOExq1efXKgsx98VX3GjtqPGtY6BoKsqgGpCN6Gn7CRF9JxgNPfUH3FmV
         hrWutIbR4A/VxXTuD5DekPsJn61olyDrJpLSCR/CogYyU1BmtEVz5B75sEBywU8L7hOu
         8d5De4WJnNxGXQwBMmkQ/qi8S5g9LZEAxlzZZzqUmLyy9bHftJTVCQ0evdZfvgRQiLIW
         F8kAF03O/2nlKzinqQzNiH/xuHCL+Q9rwdr20iG2wzF0S2HN/I6re/SjQ4gaYSr10WI7
         tY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701700154; x=1702304954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1mzcUcdIhX4XjigbGQvM+k2DG2zRM9tGnCLPvXKu20=;
        b=M2Msk6ziiaR+tu0QJ5gO2sstZ0Kwu1GO74ctlGmc9uQJ/Tgzm0yI9CVpK2sBL6V2vQ
         nt6UwrnPENd0oTnT4P2KAvP9OzuElw2Ch7bYDOLJ3KPwXzlmVWD/UjXkkui8975nF9KZ
         v9xMXQFSZorXAPyzrydDRPpomhPtotsWyZajn2fuy67uKR/n0IX4srlDel8xHzWHCcWz
         s7+PQLIJm9YPNZfMhpxIVqAPYroWENBygVFeQPQrTJJ7ATAS1iqmecrVY03GlK56OG07
         HPLddRgVjVo5OM/Td5oMQoUOxVVAAqKXTPhmwDEbA1+twXHoHAEGG8EXHI3CFYoeUEq/
         q/kg==
X-Gm-Message-State: AOJu0YwDW1autyKgR6VADLurSLy4UTIlu6rVOsfUNNmmM1EuOjN5Xcjn
	u1lApmMZVQcMsdxjEto2kKVbuD5NXPrQ97XYmBo=
X-Google-Smtp-Source: AGHT+IEiSZlBxyvoY5GwFbPLNKC4YBmNt39GKIDN8LrK6lOkPBz1fqKVdzZmXwRXgjIJCan6QdUUc6ZWuWBP5qoypQk=
X-Received: by 2002:a05:6870:1713:b0:1fb:75b:2fc3 with SMTP id
 h19-20020a056870171300b001fb075b2fc3mr5245687oae.90.1701700153786; Mon, 04
 Dec 2023 06:29:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130141624.3338942-1-amir73il@gmail.com> <20231130141624.3338942-2-amir73il@gmail.com>
 <20231204083733.GA32438@lst.de> <20231204083849.GC32438@lst.de>
 <CAOQ4uxjZAjJSR-AUH+UQM3AX9Ota3DVxygFSVkpEQdxK15n_qQ@mail.gmail.com> <20231204140749.GB27396@lst.de>
In-Reply-To: <20231204140749.GB27396@lst.de>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 4 Dec 2023 16:29:02 +0200
Message-ID: <CAOQ4uxg+agJ7ybOHfY5bKk_oi=f11zvPLzgnNF5zqZxnkTsUCA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fs: fork splice_file_range() from do_splice_direct()
To: Christoph Hellwig <hch@lst.de>
Cc: Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 4:07=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Mon, Dec 04, 2023 at 03:29:43PM +0200, Amir Goldstein wrote:
> > > > Shouldn't ceph be switched to use generic_copy_file_range?
> > > > That does the capping of the size which we want, and doesn't update
> > > > the file offsets, which would require recalculation in the ceph cod=
e.
> > > >
> >
> > IDK. I did not want to change the logic of the ceph code.
> > I am not sure that we must impose MAX_RW_COUNT limit on ceph,
> > although, i_layout.object_size may already be limited? Jeff?
>
> We better don't go beyond it, as it is called from the copy_file_range
> implementation which is expected to never return more than MAX_RW_COUNT.
> So either it is a noop change, or it fixes a bug.
>

ok.

> >
> > > > But this could avoid another exported API as splice_file_range coul=
d
> > > > simply be folded into generic_copy_file_range which should reduce
> > > > confusion.  And splice really is a mess for so many different layer=
s
> > > > of the onion being exposed.  I've been wanting to reduce some of th=
at
> > > > for a while but haven't found a really nice way yet.
> > >
> > > (and generic_copy_file_range really should be renamed to
> > > splice_copy_file_range and moved to splice.c)
> >
> > That depends if we are keeping two helpers.
> > One with a cap of MAX_RW_COUNT and one without.
> > If we are going to keep two helpers, I'd rather keep things as they are=
.
> > If one helper, then I personally prefer splice_file_range() over
> > splice_copy_file_range() and other reviewers (Jan) liked this
> > name as well.
>
> Well, splice_file_range makes sense if it is a separate helper.  But when
> is the default implementation for ->copy_file_range and matches the
> signature, naming it that way is not only sensible but required to keep
> sanity.
>

It is NOT a default implementation of ->copy_file_range(), but
a fallback helper.
Specifically, it is never expected to have a filesystem that does
.copy_file_range =3D generic_copy_file_range,
so getting rid of generic_copy_file_range() would be good.

Note also that generic_copy_file_range() gets a flags argument
that is COPY_FILE_* flags (currently only for the vfs level)
and this flags argument is NOT the splice flags argument, so
I intentionally removed the flags argument from splice_file_range()
to reduce confusion.

I like the idea of moving MAX_RW_COUNT into splice_file_range()
and replacing generic_copy_file_range() calls with splice_file_range().

I do not feel strongly against splice_copy_file_range() name, but
I would like to get feedback from other reviewers that approved the
name splice_file_range() before changing it.

Thanks,
Amir.

