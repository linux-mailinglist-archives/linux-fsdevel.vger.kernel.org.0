Return-Path: <linux-fsdevel+bounces-4770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95A18036EF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 15:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94201280C83
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 14:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0FE28E08
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 14:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjAV93dx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EBF1BEA
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 05:29:55 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-679dd3055faso26862676d6.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Dec 2023 05:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701696594; x=1702301394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DV/jIKZL4w5nykUw7wBTSyepxbgDjiH7aDRICTJCsyA=;
        b=hjAV93dxtkICGALKDdEmJhixEdhblQmuDFXSAqzzo5sKpzU+NVeRGZeSK+BfyG/3zc
         fwQjuk272tbZ3UHw2Zedeb74w0DSyAXZIvgC5S1D4bKSOV7jOLpShzgiurvXPd7elcE6
         fZvIyqq8TVcP9cK0UR7at/ycchhhLrl7OOlkbsoO4zwOB8jzEFNAHnTrBOU8gRN9767k
         K1CrjW+zIm6kjFXkSamDmGkfLkPvQLNnAFBDb5UR7jIAgI1eHlAeJMoPJeVte5LLPejd
         OBwSLO96rtwPxyfzBdXcJ5heDh5HvbV5/odeBuamKajJqEvRM+wxiyT9QjoglM2q/vJr
         n5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701696594; x=1702301394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DV/jIKZL4w5nykUw7wBTSyepxbgDjiH7aDRICTJCsyA=;
        b=XFq8WPzotiqxCVab8Tz0ncjUibsAfiU5vVVbmO5AhT3f3Xa6/vD4dArRm5Z8RmSPh7
         /RfY/Xlyga3qVQbByCTvqTeip44EFVRk+BIF3W/YNLLrexBTgysrrTZIRkI+P/BjaBp4
         V+Nq2WTt7dx06OlaFnRqVlI38g80671VILdqwq+424F6HrYbxvFsYpHKmyygwSXy9Q7f
         3EOEZ6UrceVIP01PGp2XPzeVRpg0gMOBVaLd2Tzyz6VXzyCRKHr6iINZaxGNlfNfRfea
         qHq3kv9zearrVGngMkhBpLDWI0mbnuezXPf3MCgZdiwZMlIQZ3lj5tS02H2elFb8ImQC
         XMWQ==
X-Gm-Message-State: AOJu0YzunW+hLA29rem8rneiq4ANI3lcgBHEjxve/KL1y+zkzQAm1QVF
	szWtusV4NMOYfTkSwb0XAXkT5t73hkulEG/NB6w=
X-Google-Smtp-Source: AGHT+IG0YZHy9ZyKAodu4a6u6HGyodrpVgNKe2a1hft4xiUV4xVwq1JiIZZAT1tJHe3ZulXEf7K7jUTMKZ3WciFeBpE=
X-Received: by 2002:ad4:410d:0:b0:67a:a12a:2304 with SMTP id
 i13-20020ad4410d000000b0067aa12a2304mr3784154qvp.41.1701696594353; Mon, 04
 Dec 2023 05:29:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130141624.3338942-1-amir73il@gmail.com> <20231130141624.3338942-2-amir73il@gmail.com>
 <20231204083733.GA32438@lst.de> <20231204083849.GC32438@lst.de>
In-Reply-To: <20231204083849.GC32438@lst.de>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 4 Dec 2023 15:29:43 +0200
Message-ID: <CAOQ4uxjZAjJSR-AUH+UQM3AX9Ota3DVxygFSVkpEQdxK15n_qQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fs: fork splice_file_range() from do_splice_direct()
To: Christoph Hellwig <hch@lst.de>, Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>, 
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 10:38=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Mon, Dec 04, 2023 at 09:37:33AM +0100, Christoph Hellwig wrote:
> > >             put_rd_wr_caps(src_ci, src_got, dst_ci, dst_got);
> > > -           ret =3D do_splice_direct(src_file, &src_off, dst_file,
> > > -                                  &dst_off, src_objlen, flags);
> > > +           ret =3D splice_file_range(src_file, &src_off, dst_file, &=
dst_off,
> > > +                                   src_objlen);
> >
> > Shouldn't ceph be switched to use generic_copy_file_range?
> > That does the capping of the size which we want, and doesn't update
> > the file offsets, which would require recalculation in the ceph code.
> >

IDK. I did not want to change the logic of the ceph code.
I am not sure that we must impose MAX_RW_COUNT limit on ceph,
although, i_layout.object_size may already be limited? Jeff?

> > But this could avoid another exported API as splice_file_range could
> > simply be folded into generic_copy_file_range which should reduce
> > confusion.  And splice really is a mess for so many different layers
> > of the onion being exposed.  I've been wanting to reduce some of that
> > for a while but haven't found a really nice way yet.
>
> (and generic_copy_file_range really should be renamed to
> splice_copy_file_range and moved to splice.c)

That depends if we are keeping two helpers.
One with a cap of MAX_RW_COUNT and one without.
If we are going to keep two helpers, I'd rather keep things as they are.
If one helper, then I personally prefer splice_file_range() over
splice_copy_file_range() and other reviewers (Jan) liked this
name as well.

Thanks,
Amir.

