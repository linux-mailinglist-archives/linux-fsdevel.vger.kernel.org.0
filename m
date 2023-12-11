Return-Path: <linux-fsdevel+bounces-5468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A452680C8D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 13:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D651F21750
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 12:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB2538FA0;
	Mon, 11 Dec 2023 12:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TquFb+AL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF809DF
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 04:01:10 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6d9f7b3de20so1802424a34.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 04:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702296070; x=1702900870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+HnaJP6QXrKlj9D5+yrXsWwNk7GXY8pXGa09rSMN6M=;
        b=TquFb+AL/xo6UgdQnMW25jP3JK2jVUxNoYd4gmPZ+HiLNkIXt5fdz3/chDRKiw7//8
         jXtbcLyXB5DZDEvnMA//lfaMFwvYLb4vmY7zeStz21xlyyIfrHlnLptRsljnn1RabeA1
         UISbFXKrwtDoaJWzSWIstOPR3YvEhvoVOmQlkJNJit0bvLqhYjhoVNPcf6eh7SefvVB+
         +60GWkiw9f49dKAeh/zmZc4Ul+QfpoFOlEtRYtfJteYjZvJQABB4OFBtDZytJ34RavP5
         utlG8MaCUxV2zI49ryyx5KWSbYTfdd6vSm99BgYB1lcztxdcYUQLmVSDstI8grKFEpLQ
         YZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702296070; x=1702900870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+HnaJP6QXrKlj9D5+yrXsWwNk7GXY8pXGa09rSMN6M=;
        b=KqPZjRmNBEML5f+cvyyLNdPfCmOHRZHMIAwbKUtXZJBLdaSobYFQx9iVE3oQ85Bp9C
         Nfyw0QvrH2epbDGU6ucEmM1UJKbC/tNucpNAfvMS9k4QlvfPVRKQGvrHaWFxDwvYEZo1
         OKsPU3SkfPqrwYATtb6cIpELhfusd1kUtEW03oCs8hpaFpsoxkg5uNkTnEK/esYC7f+s
         ivypOPnBA9KkczFYN6lMY5GqlfJmxszErKLx0zvN/gkKB778oYbx8/3NsQ0RQxBFyjOi
         z6256Yz33jbL0ajGL4fRHN54hiH6SW7NJ56FMUEHQTDa4F1kckFQ3ZQDE2yih6WLtNYz
         UG1Q==
X-Gm-Message-State: AOJu0YxaXsZUkytaUF1YKLaT+DgI6aukSBBnTEuRLC57MufgWpyNKnSy
	7TxTj8+luj0PpoDdjiGs9np+9z85fRxef7SdE+u3Ezea
X-Google-Smtp-Source: AGHT+IHKQILy+zjokgRkTeSqfwYbf4XCaFPVe98Eifnz82Tgf5L+PBv7Thshzwkp3XgUW3Rakw0WaS84D0DStgMwL1M=
X-Received: by 2002:a05:6870:164c:b0:1fb:75b:9992 with SMTP id
 c12-20020a056870164c00b001fb075b9992mr5627046oae.65.1702296070097; Mon, 11
 Dec 2023 04:01:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207123825.4011620-1-amir73il@gmail.com> <20231207123825.4011620-5-amir73il@gmail.com>
 <20231208185302.wkzvwthf5vuuuk3s@quack3> <CAOQ4uxi+6VMAdyREODOpMLiZ26Q_1R981H-eOwOA8gJsrsSqrA@mail.gmail.com>
 <CAOQ4uxiLtwp1QLQN1VBa10kLf4z+dx=UiDtB_WSqNXcoLYbvfw@mail.gmail.com> <20231211114905.jbmm7oxlmh3nt4j7@quack3>
In-Reply-To: <20231211114905.jbmm7oxlmh3nt4j7@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 11 Dec 2023 14:00:58 +0200
Message-ID: <CAOQ4uxj7zbC9ue7oZyzSY4u3rwTSNkW2VpLeXCuLPtzhyVtrzg@mail.gmail.com>
Subject: Re: [PATCH 4/4] fsnotify: pass access range in file permission hooks
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, David Howells <dhowells@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 1:49=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Sun 10-12-23 15:24:00, Amir Goldstein wrote:
> > > > > diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> > > > > index 0a9d6a8a747a..45e6ecbca057 100644
> > > > > --- a/include/linux/fsnotify.h
> > > > > +++ b/include/linux/fsnotify.h
> > > > > @@ -103,7 +103,8 @@ static inline int fsnotify_file(struct file *=
file, __u32 mask)
> > > > >  /*
> > > > >   * fsnotify_file_perm - permission hook before file access
> > > > >   */
> > > > > -static inline int fsnotify_file_perm(struct file *file, int perm=
_mask)
> > > > > +static inline int fsnotify_file_perm(struct file *file, int perm=
_mask,
> > > > > +                                  const loff_t *ppos, size_t cou=
nt)
> > > > >  {
> > > > >       __u32 fsnotify_mask =3D FS_ACCESS_PERM;
> > > >
> > > > Also why do you actually pass in loff_t * instead of plain loff_t? =
You
> > > > don't plan to change it, do you?
> > >
> > > No I don't.
> >
> > Please note that the pointer is to const loff_t.
> >
> > >
> > > I used NULL to communicate "no range info" to fanotify.
> > > It is currently only used from iterate_dir(), but filesystems may nee=
d to
> > > use that to report other cases of pre-content access with no clear ra=
nge info.
> >
> > Correction. iterate_dir() is not the only case.
> > The callers that use file_ppos(), namely ksys_{read,write}, do_{readv,w=
ritev}()
> > will pass a NULL ppos for an FMODE_STREAM file.
> > The only sane behavior I could come up with for those cases
> > is to not report range_info with the FAN_PRE_ACCESS event.
>
> OK, understood. But isn't anything with len =3D=3D 0 in fact "no valid ra=
nge
> provided" case? So we could use that to identify a case where we simply
> don't report any range with the event without a need to pass the pointer?
>

IDK. read(2) and pread(2) with count=3D0 is a valid use case.
and we have reported FAN_ACCESS_PERM for those 0 length calls so far.
reporting those call with no range would be bad for HSM, because all
HSM can do with these events is to fill the entire file content.

Filling the entire file content is a valid action if the backing file does =
not
support seek or if it is a directory, but it is not a valid action for
an application
induced pread() with zero length.

Did I misunderstand what you meant?

Thanks,
Amir.

