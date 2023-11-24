Return-Path: <linux-fsdevel+bounces-3655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FF47F6DF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 09:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B446EB20CA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 08:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B80E9479;
	Fri, 24 Nov 2023 08:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayDy9pA8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C0FD4E
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 00:20:39 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-543c3756521so2193766a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 00:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700814038; x=1701418838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CkX+SKqovzRofo236rCVyHnWXcY/dB0yv4gjNDr9EM=;
        b=ayDy9pA8Hz429tCKl8TQQqiavzSBhj5zf9c9BIZoQchI3eaxUu4X3fOeH/v8Mw0r+J
         a4RDWkJmWHkoKXrD6T702aSr86hiFo+wH4BRKubjoXaWZYaOm4fgYrO47jjUWhWBmgNp
         K0REXtN4lKezF3ixKSpPOeYgcfbeF5SU5iHx0lNnmoEbqEUtd6nCEGSy2ySkyXeOII3P
         23tYrcL7dkyeD7+I477KzuUPRAIXw0rMytovYPqRf5lUYS4ZMxuokV9rg72XZQffP/Bx
         r70OLSiQ6LECMfG1ivDiDVkbKM9ONxU/RGUk/pwX/DkRf//oHRysevSlxbjha1Wyqx+g
         mJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700814038; x=1701418838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CkX+SKqovzRofo236rCVyHnWXcY/dB0yv4gjNDr9EM=;
        b=b/4c42/lH3QnVuhe5f5G6cG0fAPp/UwbnVxNJdDma+RTxsf9Pyacw9PICXTPKaIyaK
         aqbdwrMjaH0SycvEVwHrPY80IxdDT1E9+2dp93yQPPJ2dofRBb+iRNKpdJ5V9RE8XLGB
         Exw7FbLckr3jYedANYL4KtyzDH12LMq8TbzQvf96YU0mbK9zaHCJgYP+BACz9b8riVWS
         NtXv0iCdpRQmO7V4K8dWwxOWPVd7EUXasjJyz+OokGG/1W8gY0SCQhSB0TxOYYLuIkkQ
         +5WkWStzNzMQENq1aNLnrWESFkqVUcgjVzj7iSRzKzBn57LMc8XmQdWXmr41BwaP7ztY
         qGgA==
X-Gm-Message-State: AOJu0YyEK+Q2FgydHJL9YQ5pFDzEBdJbHc2ulBqEhPjUIxwikCeoq3rd
	mSP4DOSTA41MREKiFAQoAzxbW3ambjpLGCCwb2V+OzoAmfE=
X-Google-Smtp-Source: AGHT+IF6xG20OJsGaZyFKGGllDr3RP29PcQUp428x8TZwfTBouSSH2lwv98l0UK3BbINUQWnlef85yobrjBXjQaTqJ8=
X-Received: by 2002:a17:906:a1c9:b0:9be:2b53:ac4d with SMTP id
 bx9-20020a170906a1c900b009be2b53ac4dmr1258757ejb.74.1700814037824; Fri, 24
 Nov 2023 00:20:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122122715.2561213-1-amir73il@gmail.com> <20231122122715.2561213-17-amir73il@gmail.com>
 <20231123173532.6h7gxacrlg4pyooh@quack3>
In-Reply-To: <20231123173532.6h7gxacrlg4pyooh@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 24 Nov 2023 10:20:25 +0200
Message-ID: <CAOQ4uxjrvWXR6MwiUUfEQdw1hDNmzO6KfhzWjc20VYp9Rf_ypw@mail.gmail.com>
Subject: Re: [PATCH v2 16/16] fs: create {sb,file}_write_not_started() helpers
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 6:17=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 22-11-23 14:27:15, Amir Goldstein wrote:
> > Create new helpers {sb,file}_write_not_started() that can be used
> > to assert that sb_start_write() is not held.
> >
> > This is needed for fanotify "pre content" events.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> I'm not against this but I'm somewhat wondering, where exactly do you pla=
n
> to use this :) (does not seem to be in this patch set).

As I wrote in the cover letter:
"The last 3 patches are helpers that I used in fanotify patches to
 assert that permission hooks are called with expected locking scope."

But this is just half of the story.

The full story is that I added it in fsnotify_file_perm() hook to check
that we caught all the places that permission hook was called with
sb_writers held:

 static inline int fsnotify_file_perm(struct file *file, int mask)
 {
       struct inode *inode =3D file_inode(file);
       __u32 fsnotify_mask;

       /*
        * Content of file may be written on pre-content events, so sb freez=
e
        * protection must not be held.
        */
       lockdep_assert_once(file_write_not_started(file));

       /*
        * Pre-content events are only reported for regular files and dirs.
        */
       if (mask & MAY_READ) {


And the assert triggered in a nested overlay case (overlay over overlay).
So I cannot keep the assert in the final patch as is.
I can probably move it into (mask & MAY_WRITE) case, because
I don't know of any existing write permission hook that is called with
sb_wrtiers held.

I also plan to use sb_write_not_started() in fsnotify_lookup_perm().

I think that:
"This is needed for fanotify "pre content" events."
sums this up nicely without getting into gory details ;)

> Because one easily
> forgets about the subtle implementation details and uses
> !sb_write_started() instead of sb_write_not_started()...
>

I think I had a comment in one version that said:
"This is NOT the same as !sb_write_started()"

We can add it back if you think it is useful, but FWIW, anyone
can use !sb_write_started() wrongly today whether we add
sb_write_not_started() or not.

But this would be pretty easy to detect - running a build without
CONFIG_LOCKDEP will catch this misuse pretty quickly.

Thanks,
Amir.

>
> > ---
> >  include/linux/fs.h | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 05780d993c7d..c085172f832f 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -1669,6 +1669,17 @@ static inline bool sb_write_started(const struct=
 super_block *sb)
> >       return __sb_write_started(sb, SB_FREEZE_WRITE);
> >  }
> >
> > +/**
> > + * sb_write_not_started - check if SB_FREEZE_WRITE is not held
> > + * @sb: the super we write to
> > + *
> > + * May be false positive with !CONFIG_LOCKDEP/LOCK_STATE_UNKNOWN.
> > + */
> > +static inline bool sb_write_not_started(const struct super_block *sb)
> > +{
> > +     return __sb_write_started(sb, SB_FREEZE_WRITE) <=3D 0;
> > +}
> > +
> >  /**
> >   * file_write_started - check if SB_FREEZE_WRITE is held
> >   * @file: the file we write to
> > @@ -1684,6 +1695,21 @@ static inline bool file_write_started(const stru=
ct file *file)
> >       return sb_write_started(file_inode(file)->i_sb);
> >  }
> >
> > +/**
> > + * file_write_not_started - check if SB_FREEZE_WRITE is not held
> > + * @file: the file we write to
> > + *
> > + * May be false positive with !CONFIG_LOCKDEP/LOCK_STATE_UNKNOWN.
> > + * May be false positive with !S_ISREG, because file_start_write() has
> > + * no effect on !S_ISREG.
> > + */
> > +static inline bool file_write_not_started(const struct file *file)
> > +{
> > +     if (!S_ISREG(file_inode(file)->i_mode))
> > +             return true;
> > +     return sb_write_not_started(file_inode(file)->i_sb);
> > +}
> > +
> >  /**
> >   * sb_end_write - drop write access to a superblock
> >   * @sb: the super we wrote to
> > --
> > 2.34.1
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

