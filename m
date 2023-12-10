Return-Path: <linux-fsdevel+bounces-5427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B735180BA19
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 11:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6256C1F20FC1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 10:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401CD749D;
	Sun, 10 Dec 2023 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtO12dK9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86ABB107
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Dec 2023 02:07:23 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-59067ccb090so2072962eaf.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Dec 2023 02:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702202843; x=1702807643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ze/j9rFp4TC/GjFPUj8dYB8wBXgoNgahTYZIMcA6+W8=;
        b=jtO12dK9zTarxKsIOxIGEFVPnAZU+OW8rI31y6xyrqL+Ad1JO1y1scksS4jhnZfI7H
         KwxoZGNuvUcZtHQgL6h6NA+qheinrOV+ROuVu8Nec27Bd/yYVtsScPccJn3mpFn7GCn6
         CNV5vq/7qhDblOv/n38LipGp0cGjftylCWBF7nkcHhuURH3bQmJF5IY/ll5Z7kKOF27W
         TNPUEmBGmLREWm+7Q6ag/YFFF7C/GC7lNws+snpnA+NOmkVag118UtM64XIiDe/YjeVY
         MOmwJBAfTMZTCI4YIgmCSlsxfbmdvF9xOQYkG995mzuVR5e1eKqsn93FTA2OCDZDYfr9
         DOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702202843; x=1702807643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ze/j9rFp4TC/GjFPUj8dYB8wBXgoNgahTYZIMcA6+W8=;
        b=qJq58PJ6yNUqhDiyiO/PynORh474BLmdIhsEF2l+z6IkM7sD1la/ifFKmsFieAe0kQ
         sprt2TRLrtqKD6QCpqExS6RY8trN+kWnBtDReV+4uHv82vcUQHUZG8QZaKawxaFlNQGv
         YU9YwxI0Dvmj+NYGe2dVYPSbnviW1Qq7WNdIu0+1Vs7JRrG6cNjCNSGcHMqB5gGqksj5
         aCYSOM+C0oIiwY7f7tabGlxaTSRkJ5I4ESuZIhVRBNXClxy9uCMzIRPhxpxpEK7ki0nV
         GydBT2F8B25QehWrOmSCLz10L1lruXfthq/SOIynMR9ChLCoxeoyMvhjO2Wiy7zRKvn1
         Q60g==
X-Gm-Message-State: AOJu0YwtroH4bCBpx2JnJGRL8OKU4jBdMRiZWoj9DcJJRCJHrNxaUOTB
	lbmQncNtoLmQu4EjQzWiKKjQ0pEerArtmI9oess=
X-Google-Smtp-Source: AGHT+IEl5ySX8uoQTqd17ErndWvpRTtqtFi9lUcwWWH8hvOdkgXPd2NlejCIjX0X8+2BAu2K+6Nsy601ssJLLOgaLa0=
X-Received: by 2002:a05:6358:c8b:b0:170:17eb:b3b with SMTP id
 o11-20020a0563580c8b00b0017017eb0b3bmr2959508rwj.37.1702202842671; Sun, 10
 Dec 2023 02:07:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207123825.4011620-1-amir73il@gmail.com> <20231207123825.4011620-2-amir73il@gmail.com>
 <20231208-horchen-helium-d3ec1535ede5@brauner>
In-Reply-To: <20231208-horchen-helium-d3ec1535ede5@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 10 Dec 2023 12:07:11 +0200
Message-ID: <CAOQ4uxgPyapyW-ahpcPiAXxkU=FN2H8FKwroejMOqogsjCNYyA@mail.gmail.com>
Subject: Re: [PATCH 1/4] fs: use splice_copy_file_range() inline helper
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Christoph Hellwig <hch@lst.de>, David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 7:33=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> > +static inline long splice_copy_file_range(struct file *in, loff_t pos_=
in,
> > +                                       struct file *out, loff_t pos_ou=
t,
> > +                                       size_t len)
> > +{
> > +     return splice_file_range(in, &pos_in, out, &pos_out,
> > +                                   min_t(size_t, len, MAX_RW_COUNT));
> > +}
>
> We should really cleanup the return values of the all the splice
> helpers. Most callers of splice_file_range() use ssize_t already. So
> does splice_direct_to_actor() and splice_to_socket(). IMO, all of the
> splice helpers should just be changed to return ssize_t instead of long.
> Doesn't have to be in this series though.

I agree. This is very annoying. I will add this cleanup patch to v2.

Thanks,
Amir.

