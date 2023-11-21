Return-Path: <linux-fsdevel+bounces-3331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5EC7F352D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 18:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E26D1C20D6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 17:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A4920DCF;
	Tue, 21 Nov 2023 17:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeVr6hmR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603B1F4
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 09:47:01 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-778925998cbso376022285a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 09:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700588820; x=1701193620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9wsdge09l5QnSkeKHf+3lfKKJVT2uRDLUybqKIlMd4=;
        b=MeVr6hmRQE8SGb6iECoAWastPu2Qn9v/8KfDu1IlbPGzg84YYdrFsQpQ9rErFTFUNm
         Yj1PAOqJOiqnn9Azggi/wxtrEsF7i++MS7s17cOTA9TzAq6zvziHBle2ybAi9QeBhjrf
         VY05h0WFokOykMfixd5KAZBCj3aA2yQnXLTM2Bq3wYvdldshGsj1GV1/Yu9wPIw/IKFc
         hNrUNw9nZKDLeYn3DfMXOJ06HaBeY3bCHKEuewuEkOJrbkeT34GLKWSrf47LV9IMlLpp
         bROCDlIqMGfno+LRQ62IPTOPGoyA6UQMvtyR7UZyrzWK5FH0/cMb+4Wit9Qa9FScp67Q
         Sf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700588820; x=1701193620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9wsdge09l5QnSkeKHf+3lfKKJVT2uRDLUybqKIlMd4=;
        b=Rljt5hk1wCzH5/1vMObsupJ3OTi75ykU2K+9KorpHeXNUk2LnPwStIYWpEbA1Yqaoh
         8ud09sPqIeYi6Hoyy7h9Xymfd2GPOJRh1N22P5Sh6jPAIqiEfdLEGCxGHk7wQeSa9zHz
         /CStbsMvuTjRANTV4x4RNVoDPAZKh+zjgGg6jE9U/WUaKCIidXRJjCXb5Oi+MYfYqBTo
         pFy0Lqw7VJz5dpxU02HoWiszLTO1Ps3zUGzKUCHXFas+GIkZUfMcDq3pKnHJzy3lzdew
         XgacuC/qWSikWYgyXo5K0bnVIawbIWHMGV/h7C0ZxvzVUXnqEhBsdYhyxSEJS19S+N2J
         xEBA==
X-Gm-Message-State: AOJu0YzD0a1bghEgg7lBeW+T3qIbq1F8ppLtcGICMsMgUu8U+xCN7HfB
	tUlrdP/Q0CVGq9GcokMik/fQV17rE60arc2xVDu0N4JizW8=
X-Google-Smtp-Source: AGHT+IFbosDz9/1nsXgQToskec+V4E5nfSgFmrFupX49xWoKUoi39+qLdpgO1CIkgqX7hrbEF6heyuuL2kmOabFhV4g=
X-Received: by 2002:a05:622a:800b:b0:423:6e27:adfa with SMTP id
 jr11-20020a05622a800b00b004236e27adfamr2933952qtb.42.1700588820419; Tue, 21
 Nov 2023 09:47:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231114153321.1716028-1-amir73il@gmail.com> <20231114153321.1716028-12-amir73il@gmail.com>
 <20231121-wohnumfeld-zerreden-26405deaf7da@brauner>
In-Reply-To: <20231121-wohnumfeld-zerreden-26405deaf7da@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 21 Nov 2023 19:46:48 +0200
Message-ID: <CAOQ4uxgFjAG4T-W650YV4qudGBqpWxn6JYMMqgD6KqSQh96SUA@mail.gmail.com>
Subject: Re: [PATCH 11/15] fs: move permission hook out of do_iter_read()
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	Miklos Szeredi <miklos@szeredi.hu>, David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 5:28=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> > +ssize_t vfs_iocb_iter_read(struct file *file, struct kiocb *iocb,
> > +                        struct iov_iter *iter)
>
> Fyi, vfs_iocb_iter_read() and vfs_iter_read() end up with the same checks=
:
>
>         if (!file->f_op->read_iter)
>                 return -EINVAL;
>         if (!(file->f_mode & FMODE_READ))
>                 return -EBADF;
>         if (!(file->f_mode & FMODE_CAN_READ))
>                 return -EINVAL;
>
>         tot_len =3D iov_iter_count(iter);
>         if (!tot_len)
>                 goto out;
>         ret =3D rw_verify_area(READ, file, &iocb->ki_pos, tot_len);
>         if (ret < 0)
>                 return ret;
>
> So if you resend you might want to static inline this. But idk, might
> not matter too much.

There are more commonalities with other helpers,
but I don't want to "over clean", so I'd rather leave it like that.

I will remove the else in do_iter_read().

Thanks,
Amir.

