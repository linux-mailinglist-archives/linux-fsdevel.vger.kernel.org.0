Return-Path: <linux-fsdevel+bounces-5428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A0F80BAE4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 14:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57DD1C2091F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 13:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F2BC2C4;
	Sun, 10 Dec 2023 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMbxR9d+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F2B10B
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Dec 2023 05:24:12 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-59064bca27dso2091511eaf.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Dec 2023 05:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702214651; x=1702819451; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X++IaS3u8l0Oe7uSZY8tik/EztLEZ/j0FuQZXVJm6uk=;
        b=YMbxR9d+MHI6KFMqxdteetRv03IXi8s448lo/PV/7VASg3SRaCuO0blw02ewSjhP5P
         i+YeapisKLA8Xv3VSXkBpiD13yaaSXLs8NOR2H5qXz6XIiFeattjWKkJSTSHPNpWZQd8
         bB3pA2bCCnLmf5r+bru+0XKOSKJV5al/4aVIxxuPUVJ8aswD+6G1MseIi6qH/UVjLbYO
         j7hSxlT7VbOJJ9kW1d4ml0H+GLZQvEGTPmuFClIkDg0GiJr4BmODdlXTTTAfCwt9/LJ8
         VDbZEZ3oT+RHTJ/wQZvwKknJduLy/wP8KFRor9Fvyy6UlwARKSl3Ryn+yWq+EHyMS5id
         ARSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702214651; x=1702819451;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X++IaS3u8l0Oe7uSZY8tik/EztLEZ/j0FuQZXVJm6uk=;
        b=ZgqoOjdst2lSNFWoITyQvTpVYB4Kt/GcvTNjjtbISMejK+EX08TukKKXSbAr21HIb3
         BkZQGC7s+Izymi89LM3gqoTOX/DBE6yFWPWekbJfLIh49hrEoghcaNUbqO8FsALJUnN7
         hcrp6iC0+V3QBs2u+GTaWTBQ8ftZIWgX32v0g21smoq2S/xVzj4FE0hXi45cWqA8Za6D
         PRqWJd5z5Qnu0Vj5I/3CwqJDo21mVZO7WJgpxtg4rybQVudPX46yjfSb/EvaGBLaUoR/
         ko9tagnNbSdfJwLvmC9JWrz0aPjIXHXTCoY49x5nFl5VCNrAIcYv2KSlFUIU0fdOxPVl
         hOOg==
X-Gm-Message-State: AOJu0YwDVN7WUKYdjPz9a87bkPahpL/cebHLg/K8KyUYHuCnPWgzshcG
	/9Oho9fGWPGIK7JA8LHgrbY98dmcR/BTlFD703MsyYYGB88=
X-Google-Smtp-Source: AGHT+IHgy+Fnkk3m7IDJi424KLpdHiSxrYVrhBH8z7LBNsg2/k1VY9vKRQr/hMS2Lp83s3Ob/Y7FGVZoLeZr4YvVnpI=
X-Received: by 2002:a05:6358:4291:b0:16e:783a:eb66 with SMTP id
 s17-20020a056358429100b0016e783aeb66mr2477034rwc.0.1702214651396; Sun, 10 Dec
 2023 05:24:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207123825.4011620-1-amir73il@gmail.com> <20231207123825.4011620-5-amir73il@gmail.com>
 <20231208185302.wkzvwthf5vuuuk3s@quack3> <CAOQ4uxi+6VMAdyREODOpMLiZ26Q_1R981H-eOwOA8gJsrsSqrA@mail.gmail.com>
In-Reply-To: <CAOQ4uxi+6VMAdyREODOpMLiZ26Q_1R981H-eOwOA8gJsrsSqrA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 10 Dec 2023 15:24:00 +0200
Message-ID: <CAOQ4uxiLtwp1QLQN1VBa10kLf4z+dx=UiDtB_WSqNXcoLYbvfw@mail.gmail.com>
Subject: Re: [PATCH 4/4] fsnotify: pass access range in file permission hooks
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, David Howells <dhowells@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > > diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> > > index 0a9d6a8a747a..45e6ecbca057 100644
> > > --- a/include/linux/fsnotify.h
> > > +++ b/include/linux/fsnotify.h
> > > @@ -103,7 +103,8 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
> > >  /*
> > >   * fsnotify_file_perm - permission hook before file access
> > >   */
> > > -static inline int fsnotify_file_perm(struct file *file, int perm_mask)
> > > +static inline int fsnotify_file_perm(struct file *file, int perm_mask,
> > > +                                  const loff_t *ppos, size_t count)
> > >  {
> > >       __u32 fsnotify_mask = FS_ACCESS_PERM;
> >
> > Also why do you actually pass in loff_t * instead of plain loff_t? You
> > don't plan to change it, do you?
>
> No I don't.

Please note that the pointer is to const loff_t.

>
> I used NULL to communicate "no range info" to fanotify.
> It is currently only used from iterate_dir(), but filesystems may need to
> use that to report other cases of pre-content access with no clear range info.

Correction. iterate_dir() is not the only case.
The callers that use file_ppos(), namely ksys_{read,write}, do_{readv,writev}()
will pass a NULL ppos for an FMODE_STREAM file.
The only sane behavior I could come up with for those cases
is to not report range_info with the FAN_PRE_ACCESS event.

>
> I could leave fsnotify_file_perm(file, mask) for reporting events without
> range info and add fsnotify_file_area(file, mask, pos, count) for reporting
> access permission with range info.
>

I renamed the hook in v2 to fsnotify_file_area_perm() and added a wrapper:

static inline int fsnotify_file_perm(struct file *file, int perm_mask)
{
        return fsnotify_file_area_perm(file, perm_mask, NULL, 0);
}

Thanks,
Amir.

