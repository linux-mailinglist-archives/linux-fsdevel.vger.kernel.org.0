Return-Path: <linux-fsdevel+bounces-76448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEDVNVeWhGk43gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 14:08:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB90F2FF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 14:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35E7030428B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 13:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB133D523E;
	Thu,  5 Feb 2026 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFj/Wgov"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCBE3B8D5C
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770296696; cv=pass; b=F2r71Ey4O1+wAPS2N3XHXSd+6bl4PPIuE/OX9EiNARn8K9urwaFCUHp26sJDSzjK74yZkDhyC/h7axGGdeP7kOBI3jyCbFXOs7tL6a2cusRr0eGqeiCOWFTL6nwydvVioc3/xgkDMGI/R3uu3z7iJsR8Z1bClwSQlBe1EpQ7DeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770296696; c=relaxed/simple;
	bh=N2c1RM0b4ERNHu8Wc50fN3R9BsKRWCfa11p9n8FFco4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eok5C+7ffALHn+vK+LUNGzMJRcGbFUsSdo8UJSz/5WlLjcetqaE39uZ2E8AjMbOUSW36BYagf0Tp7/ckuc6BjOTKz9NnXc4kpJJ36qwDziz0PgMXD8f6DPkaWCTdiYDU3u4dlsRRg+M6hksM/7RcLsV7WhE3FujonheQYhSOjSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFj/Wgov; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-435a11957f6so680291f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 05:04:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770296694; cv=none;
        d=google.com; s=arc-20240605;
        b=SXxBb/8WHy24+qcjw9IYme5JlrH8Bfk33NNdjUggourBj0QUSlJcDJLh07UmPhKab+
         jSmnhfk7RkliLR9HLEGS/JGB0qXyawnB1+eqpu9mQ4WV9qThyr9tRmtTGwwEjvWQ/CmY
         cQyKigLHHnnEvh1bkacq9337Nu7mdc+pTxtNV+mLnuRIodbNxnB7lpVYDKQxQpbotDQq
         P5YbB9N9ahtmY4E/OUH4WgynWqv4KjhgPt1LMgMFcXW4NO3n9h6DFlG+P7C4kQlOae/Y
         2bsK0PEdls9dEviGZ464FyTy/SfHymJccQVDCoQ0+XFLveWdUlKunQTRXi56342Q8bS/
         DgIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5QIFMxkl9qDrU626LjrUWWxNqKmOaBddIPVVlA8pXoo=;
        fh=V8VAE105abqrGpam92mCVxv37c3pA76SxMEnGtEV/tw=;
        b=D4yhAQfzuzYSt10t+UgVArSgVhcH1rH93J8U+vu2bQOCrd9e6HPdauNTyzm3KsBT68
         Y2kRhB6WzlUjTmunsqc6cEvYeUremWXTiWBhdSWrQfebt0o6msHJunDu0iSyl1ifUc23
         54i88GV+xKLLeYgBQdzjSWMMdXF3INN495FQrqvQwN4ccXj3rGADelgep7qyWSUTSgUF
         6B4fhDMe098gMnJAy9V4iYLDu03B5iwZD4K7c98xqnHgM7A4ykS3l9BwIeVR8MNDOnSd
         tUE7iUJbKyl78mHyf/S7gOayUaVUenJjBpaoHedyazDqa2YqBxRT+0iUZEl0S6qTOyFQ
         Vm2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770296694; x=1770901494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QIFMxkl9qDrU626LjrUWWxNqKmOaBddIPVVlA8pXoo=;
        b=eFj/Wgovw5nx28AuntEcmYhTLWrcShD+FEPlxv8t7bORKwNp4fZgpa1A8jYpx19B7V
         zpkQAXJ4K4F1Rv7pM72BhwnMUSRonxs65fpBhDO4SGuX0qAlWPM8t4D5sePSeStUIeFr
         q/hMmt72lMyU9ipFKtciig6U6q4SzUh9UN7CUoRKLW2gH8q1i1KthFAMEUcimBVmwnkX
         fbv53HjAq8YAWe/nohi9dOQlYvBcBwPjRxIto8GV/ST/gaM13N9HphSRgAZAg+w0Rq6K
         YgOePfLA4Z3vgrxDj4Z5paCLoAaxyEGqvGJgUxqAYNThBSY9LBmewV+08tHdpfqS5uF6
         B8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770296694; x=1770901494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5QIFMxkl9qDrU626LjrUWWxNqKmOaBddIPVVlA8pXoo=;
        b=wMSAoRpNkEKXGlRBf7691sAXtiFJHFbMr6eZ/Vr5QGwCE3Dva7sYcFL4XWoX7eJOIS
         Kg79UqxwwEphADPX5oS3eQ9Z18u/AfGyls5Bj7q1ZIUk4aCJlGkY9/Vu1AkuOB906i6u
         Ux/04ByDDgzJRtwM1ar4w3SE/EzQTGoeg8ztndy8G0/R/NpRP5DgnJGWAkc2S5AmlB2c
         PlZnhvOTlMPpgFd/MxDgxo3Kn2bpgsrWEZLACIr0iBqMdd+1vkV7OpCmaY82B5bw06Pm
         Pm0qkLlydUFrEZdF+erQRRpOH6fPBgY+dVwxhQo9DPaQyafvgp8Zn3SVdAHmNuAvQM/a
         QQMA==
X-Forwarded-Encrypted: i=1; AJvYcCUKotvcJmGo/lhzyt5UtqIfbv0zZTgt/LoVBHRMykBp4CmtVDe/scF3+VWFYErMec7pl6FqEgotXtJc8V4m@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxi7HRf1eBGLG7k/nQ0CymgWpKUW3Jv4sIue6iJeNT9Et8EOfq
	tjLp7T7Zd1k20AB/xAEIlodMjcocRqCqS9ErhRr20/PwyD1taLFrQOufEe0EL3xYJH+xJnhIoA5
	d8yROCz5PnlK/CTS1WJUxbTAFYcy+wfU=
X-Gm-Gg: AZuq6aKwMVwBUKeUFfZdImq7n5Vv6H7owohVhEJVrdyosjCDMYaGv3w2lg8pJdrnszZ
	nsskyFy5M10FtO85GroiLtImvVF8+Uun+56NXl52VNZmdeEgpY+IBWklv0J8wufsJrIK+K4rLE8
	EuoTOQH4F9bOUn2Am4DI1daJJBFKF76X8sjDMZD7Bbs/m/ihCM8acSibUeamw73ZIQ0MNsqkBCS
	q3zniOk9n776Z9v9XsBnPOuMf7F77Ap59magIhvkL3FsUP23c3qPGIppPqqi8IDIjMLHwpo3eIb
	I56Iz29zUCg5hLnx7bftLayCFMQOig==
X-Received: by 2002:a05:6000:1acb:b0:432:5bac:3915 with SMTP id
 ffacd0b85a97d-43618053bc4mr9962281f8f.39.1770296693827; Thu, 05 Feb 2026
 05:04:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204050726.177283-1-neilb@ownmail.net> <20260204050726.177283-9-neilb@ownmail.net>
 <5d273a008fc51a2fded785efbe30e5bd2a89b985.camel@kernel.org>
In-Reply-To: <5d273a008fc51a2fded785efbe30e5bd2a89b985.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Feb 2026 14:04:42 +0100
X-Gm-Features: AZwV_QhEkTNuUX-zP-udJB3TTtiGdaNYEr11QFKjoqWXaHOUCtxdu5bQUZv0f1A
Message-ID: <CAOQ4uxh_Ugyy9=Vx_XOzWMTdhqVx6kAu43q+F+afhNF_Zv_9TA@mail.gmail.com>
Subject: Re: [PATCH 08/13] ovl: Simplify ovl_lookup_real_one()
To: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76448-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[brown.name,kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,canonical.com,paul-moore.com,namei.org,hallyn.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,brown.name:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DAB90F2FF4
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 1:38=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Wed, 2026-02-04 at 15:57 +1100, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> >
> > The primary purpose of this patch is to remove the locking from
> > ovl_lookup_real_one() as part of centralising all locking of directorie=
s
> > for name operations.
> >
> > The locking here isn't needed.  By performing consistency tests after
> > the lookup we can be sure that the result of the lookup was valid at
> > least for a moment, which is all the original code promised.
> >
> > lookup_noperm_unlocked() is used for the lookup and it will take the
> > lock if needed only where it is needed.
> >
> > Also:
> >  - don't take a reference to real->d_parent.  The parent is
> >    only use for a pointer comparison, and no reference is needed for
> >    that.
> >  - Several "if" statements have a "goto" followed by "else" - the
> >    else isn't needed: the following statement can directly follow
> >    the "if" as a new statement
> >  - Use a consistent pattern of setting "err" before performing a test
> >    and possibly going to "fail".
> >  - remove the "out" label (now that we don't need to dput(parent) or
> >    unlock) and simply return from fail:.
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/overlayfs/export.c | 61 ++++++++++++++++++-------------------------
> >  1 file changed, 26 insertions(+), 35 deletions(-)
> >
> > diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> > index 83f80fdb1567..dcd28ffc4705 100644
> > --- a/fs/overlayfs/export.c
> > +++ b/fs/overlayfs/export.c
> > @@ -359,59 +359,50 @@ static struct dentry *ovl_lookup_real_one(struct =
dentry *connected,
> >                                         struct dentry *real,
> >                                         const struct ovl_layer *layer)
> >  {
> > -     struct inode *dir =3D d_inode(connected);
> > -     struct dentry *this, *parent =3D NULL;
> > +     struct dentry *this;
> >       struct name_snapshot name;
> >       int err;
> >
> >       /*
> > -      * Lookup child overlay dentry by real name. The dir mutex protec=
ts us
> > -      * from racing with overlay rename. If the overlay dentry that is=
 above
> > -      * real has already been moved to a parent that is not under the
> > -      * connected overlay dir, we return -ECHILD and restart the looku=
p of
> > -      * connected real path from the top.
> > +      * @connected is a directory in the overlay and @real is an objec=
t
> > +      * on @layer which is expected to be a child of @connected.
> > +      * The goal is to return a dentry from the overlay which correspo=
nds

As the header comment already says:
"...return a connected overlay dentry whose real dentry is @real"

The wording "corresponds to @real" reduces clarity IMO.

> > +      * to @real.  This is done by looking up the name from @real in
> > +      * @connected and checking that the result meets expectations.
> > +      *
> > +      * Return %-ECHILD if the parent of @real no-longer corresponds t=
o
> > +      * @connected, and %-ESTALE if the dentry found by lookup doesn't
> > +      * correspond to @real.
> >        */

I dislike kernel-doc inside code comments.
I think this is actively discouraged and I haven't found a single example
of this style in fs code.

If you want to keep this format, please lift the comment to function
header comment - it is anyway a very generic comment that explains the
function in general.

> > -     inode_lock_nested(dir, I_MUTEX_PARENT);
> > -     err =3D -ECHILD;
> > -     parent =3D dget_parent(real);
> > -     if (ovl_dentry_real_at(connected, layer->idx) !=3D parent)
> > -             goto fail;
> >
> > -     /*
> > -      * We also need to take a snapshot of real dentry name to protect=
 us
> > -      * from racing with underlying layer rename. In this case, we don=
't
> > -      * care about returning ESTALE, only from dereferencing a free na=
me
> > -      * pointer because we hold no lock on the real dentry.
> > -      */
> >       take_dentry_name_snapshot(&name, real);
> > -     /*
> > -      * No idmap handling here: it's an internal lookup.
> > -      */
> > -     this =3D lookup_noperm(&name.name, connected);
> > +     this =3D lookup_noperm_unlocked(&name.name, connected);
> >       release_dentry_name_snapshot(&name);
> > +
> > +     err =3D -ECHILD;
> > +     if (ovl_dentry_real_at(connected, layer->idx) !=3D real->d_parent=
)
> > +             goto fail;
> > +
> >       err =3D PTR_ERR(this);
> > -     if (IS_ERR(this)) {
> > +     if (IS_ERR(this))
> >               goto fail;
> > -     } else if (!this || !this->d_inode) {
> > -             dput(this);
> > -             err =3D -ENOENT;
> > +
> > +     err =3D -ENOENT;
> > +     if (!this || !this->d_inode)
> >               goto fail;
> > -     } else if (ovl_dentry_real_at(this, layer->idx) !=3D real) {
> > -             dput(this);
> > -             err =3D -ESTALE;
> > +
> > +     err =3D -ESTALE;
> > +     if (ovl_dentry_real_at(this, layer->idx) !=3D real)
> >               goto fail;
> > -     }
> >
> > -out:
> > -     dput(parent);
> > -     inode_unlock(dir);
> >       return this;
> >
> >  fail:
> >       pr_warn_ratelimited("failed to lookup one by real (%pd2, layer=3D=
%d, connected=3D%pd2, err=3D%i)\n",
> >                           real, layer->idx, connected, err);
> > -     this =3D ERR_PTR(err);
> > -     goto out;
> > +     if (!IS_ERR(this))
> > +             dput(this);
> > +     return ERR_PTR(err);
> >  }
> >
> >  static struct dentry *ovl_lookup_real(struct super_block *sb,
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Otherwise, it looks fine.

Thanks,
Amir.

