Return-Path: <linux-fsdevel+bounces-79193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBnmHW3IpmkaTwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 12:39:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E74C01EE23F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 12:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F21D30C1BAD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 11:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E46D47ECF4;
	Tue,  3 Mar 2026 11:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFtB+TMn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7773C3C0A
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 11:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772537262; cv=pass; b=Bvg2xbnE5h8RTTbYBvbio7nali2FL+RTYQ21QkUVIiV5LQ8aCLKIkkGABWClDNdWVzmcaRIfZLWAtatWIKA4duIlyya7jTdAtgWx0EEAy61suZ8sD+ajeaUHtyeGHzPgsqqzSDCol7YwjiXsYLi8LEeWMxQj2J7HDTzUawOXOpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772537262; c=relaxed/simple;
	bh=5mXcbTkuufop5uhTKOhembeC2DRfSRMAFASfr58P0QE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAHFHtcGRImMfZnHXNepg1xdEOy2PmWlVXmQdXk9/DLifYoQfJLxjjiBo2+rMW+kBu/sj0z8TDlkkFHJX/2D4/fbMJSvApqUWAX48V2B3kMvnMe7WawjbFnUF//8fz/1apYFc7jbsvPzGIsSeTgChh07teU1W1KD8QR0cZXpqMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFtB+TMn; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-65c187dfc82so8668761a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2026 03:27:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772537257; cv=none;
        d=google.com; s=arc-20240605;
        b=Gwj+iutEqgAbNgx1URJSxcrKA8hudd6iWu1WDtkz4DDXbK7mNqViQdOxY5PzV/sXWI
         EKe/DPyPwCJ19qs81brqIqGUC40TbAkol+Z9VL3YeslPa8lEVkbqdFlt0rnpNBHwyRJO
         UVxaJfzqvrVWEdQQNaj6QTYb5fSd3r+Nxi9kUXAMKVdq6mHVJVOR/JBCadnNClN7VHYZ
         aQaB9/qXAc5HLeHJh3JbeyGC64Ohc3wvbGxTFNtafZm1dHkcTNgy3z3GxKk4+MQkClnX
         GvKNWO8kHrXOahFCm9+CS/IuUH+Xg7ZzUcQWbg/JadOwEHySmK/vvFhKsFVr4tIARLZ9
         70lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LH7NnVAg6YNTo0ag1UC0RiHGEjqmdXJI3aP1t2KH4+Y=;
        fh=Wq/7+NUYj41gtIE8KP8EEGQ4koz+oaO5v4Gm6iyMtfI=;
        b=TZ3vAkHRvYCORuTij/jQWlm+0mp/2OJFZJyiZIOMz4TSqSxlooYRzYNRkkdqoe7TEe
         uoVvug0x9GBnPBeoGGaXgKBgIx0/bDBweZNDOLWb5cXsspQM7JAVTZzaOPcrTDnYPmoM
         165tR/Ri3xa8OXinCi5/V10VcnokOCWUDXwgNBMs3tQaU7k24SvQ2CJ/Bkne8tLGMixa
         p86Dt4p/6yHTUB0cgYuoZhP4jpVIa5Gjm1Z4BvNsx2xukotbNeFV8hNtPHT3PpklhxdR
         Csixv1SnzNijZASTWTZpG9aJv4tYWSbZwP5C/5LXOtYaYKgrIN6Iixd1ui9ufOeEPSS6
         rAsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772537257; x=1773142057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LH7NnVAg6YNTo0ag1UC0RiHGEjqmdXJI3aP1t2KH4+Y=;
        b=dFtB+TMn3m5ffnvoNz/q0iRI3ZVA9iKP1RghiZ0PgDSpm4SV6J7Dyg8A+Gk1hKMIgn
         oy9iDMicfAYrtqEUdBIFFmJwieVpCjfw2ZlmCIC5nS7kxxtWW+ExPmRoYt2y65q8x40N
         9qtZGQEES2SueAvtIod1DLDWdTY409QjNZ9JPcu8HrE6qkZ+zJF8i6713ZmABdFGIYbk
         qz3QclbFnWKIyhGF1MzD9liCoXXuImrvD3wFfnRCDJcKGsGN2L/0UZMvB/06kG+vJcnH
         3bjYrboQuFTl9BmiCDQ8LVEFA3jS/LDUbkyDF2vyOBmi64/mqJzMEaaQUZ5PE0KxyI4c
         4ATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772537257; x=1773142057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LH7NnVAg6YNTo0ag1UC0RiHGEjqmdXJI3aP1t2KH4+Y=;
        b=Vz2mhNAprhNHqBcEobhY9Shg1q1kSfS5C3Z7Qvzmk2DXROsyN1WuycUF9DB7VD+bMt
         ZoUAAV4XdF7i54Xvl+pPaISO1hhyjI1Hiqo+vInAJ/d2dBsrDHhByoDv74XqnBURZv1d
         6dfpWxcoZBQ+VUqKUC4Ns/XH/GFkGXB49n+ju5hELpvH4NincJv38CMNMQz3ZyBNrnoa
         XKte0olOfeL5IIZedb0SaKg6TH/1QiZgUeciZx/wR49NEDySpZsgcs8sU+27fm9v89ma
         1Z0kNqkQUOjT8skUgsTmoDuXY53m56M5twbBVIl+vmr3SJzsJcZL5bPFB5LjzR5Ke6Kb
         j7CA==
X-Forwarded-Encrypted: i=1; AJvYcCV/PrQhn6ZHJL3PMCTg0JXIx8OV5fLRC0JX9tCFn3ndQgERZzCIstR55cIIGZ/sAiTky4QTwfjdP7NU2nR2@vger.kernel.org
X-Gm-Message-State: AOJu0YxIIOzagK7koDOjoOYMxTRdYkjVvTLTV/aElK/zXE9rJ0a/YmyC
	ApQomZvMt7Evc56wusCTwEFnLsezFqnLILDbkfgnJXn0HCb1OOE06GeGDW5stqaf0X7QcGZ/rnK
	HPczqJBJcJMGa1XuP9mrcgqhhKQBb9bv4aF3TOPI=
X-Gm-Gg: ATEYQzwzKI9yDKHQcjy7QunkdH+IO/L9EmoNk5SmfuIjlV7JRzk3kd6tGF+7PJRmuvp
	v/Z2bkFf7IpR94sgN22K8XjLBLgSbD7BJFbRxgAD77hue3TVT6rNMHD/4jn9dvJOgQG0zRRJhmW
	fjXjclaeb/MMiRKrgsET/12nBaUGw5fYkcgpFWzkGPJQD3vauL6j+3A0K/HTnwQJu/P5vMOZmAA
	2h5Yy07xBSCzjw/p6XeaJjyb/0p5pvqSRf9ANpwubaTWWby7cYDCnj8Z1oxSXu7H/f+oYny/4oQ
	8NN4N6QxFtop/ooC/R7d7Gw6Mmic9rGX3Ma5CVcQ
X-Received: by 2002:a17:907:6eab:b0:b93:c7f7:b456 with SMTP id
 a640c23a62f3a-b93c7f7c67dmr285319766b.18.1772537256476; Tue, 03 Mar 2026
 03:27:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302183741.1308767-1-amir73il@gmail.com> <20260302183741.1308767-3-amir73il@gmail.com>
 <fc9c776f-bc8b-4081-ad9e-b4ebc40b9974@oracle.com> <CAOQ4uxjHeUBfFLwahmaHj+ZKq=CxQGShi1-m_HQuWSjMa=f1-A@mail.gmail.com>
 <177253370359.7472.12148587434874484168@noble.neil.brown.name>
In-Reply-To: <177253370359.7472.12148587434874484168@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Mar 2026 12:27:25 +0100
X-Gm-Features: AaiRm50cRIuXdfbL9xRJn8TkCXeNKHwcdbGIoRTEKg1o76DeY5Go-Cexr9cP4bg
Message-ID: <CAOQ4uxj1P6snjRq3Z9qiks2LjdzsAg1d8m5LetrJ1yJ+ibeVGg@mail.gmail.com>
Subject: Re: [PATCH 2/2] fs: use simple_end_creating helper to consolidate
 fsnotify hooks
To: NeilBrown <neil@brown.name>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jeff Layton <jlayton@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E74C01EE23F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79193-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 11:28=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> On Tue, 03 Mar 2026, Amir Goldstein wrote:
> > On Mon, Mar 2, 2026 at 11:28=E2=80=AFPM Chuck Lever <chuck.lever@oracle=
.com> wrote:
> > >
> > > On 3/2/26 1:37 PM, Amir Goldstein wrote:
> > > > Add simple_end_creating() helper which combines fsnotify_create/mkd=
ir()
> > > > hook and simple_done_creating().
> > > >
> > > > Use the new helper to consolidate this pattern in several pseudo fs
> > > > which had open coded fsnotify_create/mkdir() hooks:
> > > > binderfs, debugfs, nfsctl, tracefs, rpc_pipefs.
> > > >
> > > > For those filesystems, the paired fsnotify_delete() hook is already
> > > > inside the library helper simple_recursive_removal().
> > > >
> > > > Note that in debugfs_create_symlink(), the fsnotify hook was missin=
g,
> > > > so the missing hook is fixed by this change.
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > >
> > > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > > index e9acd2cd602cb..6e600d52b66d0 100644
> > > > --- a/fs/nfsd/nfsctl.c
> > > > +++ b/fs/nfsd/nfsctl.c
> > > > @@ -17,7 +17,6 @@
> > > >  #include <linux/sunrpc/rpc_pipe_fs.h>
> > > >  #include <linux/sunrpc/svc.h>
> > > >  #include <linux/module.h>
> > > > -#include <linux/fsnotify.h>
> > > >  #include <linux/nfslocalio.h>
> > > >
> > > >  #include "idmap.h"
> > > > @@ -1146,8 +1145,7 @@ static struct dentry *nfsd_mkdir(struct dentr=
y *parent, struct nfsdfs_client *nc
> > > >       }
> > > >       d_make_persistent(dentry, inode);
> > > >       inc_nlink(dir);
> > > > -     fsnotify_mkdir(dir, dentry);
> > > > -     simple_done_creating(dentry);
> > > > +     simple_end_creating(dentry);
> > > >       return dentry;  // borrowed
> > > >  }
> > > >
> > > > @@ -1178,8 +1176,7 @@ static void _nfsd_symlink(struct dentry *pare=
nt, const char *name,
> > > >       inode->i_size =3D strlen(content);
> > > >
> > > >       d_make_persistent(dentry, inode);
> > > > -     fsnotify_create(dir, dentry);
> > > > -     simple_done_creating(dentry);
> > > > +     simple_end_creating(dentry);
> > > >  }
> > > >  #else
> > > >  static inline void _nfsd_symlink(struct dentry *parent, const char=
 *name,
> > > > @@ -1219,7 +1216,6 @@ static int nfsdfs_create_files(struct dentry =
*root,
> > > >                               struct nfsdfs_client *ncl,
> > > >                               struct dentry **fdentries)
> > > >  {
> > > > -     struct inode *dir =3D d_inode(root);
> > > >       struct dentry *dentry;
> > > >
> > > >       for (int i =3D 0; files->name && files->name[0]; i++, files++=
) {
> > > > @@ -1236,10 +1232,9 @@ static int nfsdfs_create_files(struct dentry=
 *root,
> > > >               inode->i_fop =3D files->ops;
> > > >               inode->i_private =3D ncl;
> > > >               d_make_persistent(dentry, inode);
> > > > -             fsnotify_create(dir, dentry);
> > > >               if (fdentries)
> > > >                       fdentries[i] =3D dentry; // borrowed
> > > > -             simple_done_creating(dentry);
> > > > +             simple_end_creating(dentry);
> > > >       }
> > > >       return 0;
> > > >  }
> > >
> > > For the NFSD hunks:
> > >
> > > Acked-by: Chuck Lever <chuck.lever@oracle.com>
> >
> > FWIW, you are technically also CCed for the sunrpc hunk ;)
> >
> > BTW, forgot to CC Neil and mention this patch:
> > https://lore.kernel.org/linux-fsdevel/20260224222542.3458677-5-neilb@ow=
nmail.net/
> >
> > Since simple_done_creating() starts using end_creating()
> > so should simple_end_creating().
> > I will change that in v2 after waiting for more feedback on v1.
> >
> > I don't want to get into naming discussion - I will just say that I wan=
ted
> > to avoid renaming simple_done_creating() to avoid unneeded churn.
> >
> > Thanks,
> > Amir.
> >
>
> Thanks for the Cc.
>
> Would there be a problem with doing the fs-notify for *every* caller of
> simple_done_creating?

1. simple_done_creating() is also called for the failed case, where the
fsnotify hook is not desired. I am not sure if failure is always equivalent
to negative child dentry.

2. I assume you meant the simple_done_creating() calls in other fs that
do not have fsnotify hooks in current code. This is a valid point.
I am hesitant to add the FS_CREATE events for *all* the pseudo fs
dentry creations.
Specifically, I think we need not send the events for init/populate of fs.
It's worth nothing that some of those fs do already send FS_DELETE
events via simple_recursive_removal().

> It does make sense to include the notify in the common code, but having
> two different interfaces that only differ in the notification (and don't
> contain some form of "notify" in their name) does seem like a recipe for
> confusion.

Right. I could make it simple_end_creating_notify().

Now where does this sound familiar from?

Oh yeah, my old fsnotify path hooks series [1] :)

Cheers,
Amir.

[1]  https://lore.kernel.org/linux-fsdevel/CAOQ4uxi-UhF=3D6eaxhybvdBX-L5qYx=
_uEuu-eCiiUzJPvz2U8aw@mail.gmail.com/

