Return-Path: <linux-fsdevel+bounces-76583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBKiLJDuhWlvIQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 14:37:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69620FE3EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 14:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 362443022926
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 13:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D5D3DA7D3;
	Fri,  6 Feb 2026 13:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8ekIMW4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2139393DDD
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770384939; cv=pass; b=SHyzZbBiCL/Oj6+LnuLeQQYVwm+IZpr10P4DdLc0QyeUYgcebwVIPk6ED1U8WcJNcoIfWWbXVk9JkVzyag7de/L62i5M0A6UnWAIZoSeaBs9gB1wKVLeFWFe6LAemxXNPBfm98qrVh2MyvCBhcXweJsnWWWmPrjr0CGB2T/Vrow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770384939; c=relaxed/simple;
	bh=RxTY2ZddbzZaifKXYPGFFlp4mavJ0NrEEi4EM4pjmj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEHzs/ge3WV0KoA+tjh8gWh5Od6sMCsJYXXPf47eCf7rYiRM8gPLNm80oqB8pOm7of7r7gcgDQNEC8ypSBTufqJGPE1MLRq3Uz5OX9/jqWRCy+gpGq4JEfG4EfH+Eis4hBWFVhRp7DIQcEXMTEnp0Xhp0X8pbAF8hndnBv7F1+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8ekIMW4; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-658cc45847cso3133236a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Feb 2026 05:35:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770384937; cv=none;
        d=google.com; s=arc-20240605;
        b=VaX5kZntphyrXhBlE+HUCTGs/PO3I/7bxP9D8kdN8hBJ9nZfXm1Z3MPXLijyUXZoxZ
         VMih77FRKa9XZO6X9wDSjqxCiyJD5G5qZDHnGzUNxPUUkw9ExtZwJ2ZYKrxXExbkl7Y4
         lMweuZI6y7uLl3/Gul81qbelQZfVTn6wy0833ReEOYtM8SOjp2Szz4HvCJLUGtiXSiTQ
         bgYujxj3cCoCecPbBbFl9Lnlj8PSlIWJx+nr5KJWGd89w5FzzsOUiOsz8tyPlVW7Q+g8
         kKbDNcG1x4Hmsxmvq1SUAhPluSI1zLN72Ork/JmjdgWRIBgwURcEcsuSc+2xNqh9CObU
         BHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EpmWnKuQAvcxfN2n9Aws3fxLD/5TLycZ+iQI8ZhYj4E=;
        fh=5UNMMz6OCHSjzR48g3t6d4MP0U4s2qtgPOC6dch/YaA=;
        b=ZZOmUktMEBVY5TJgmC2i4OIq5jOioMx8cbymwd1LEK1l6ICwMwdKtvKkge0bNz177d
         LOFMS+jP8Wol1wVHmJoKie05QwdUZEpQbjZunPGTe2XtNb2oWKNobtSMrqNfXq3JkdZR
         QjdAIyHYojlBOxWtILMQJx42o5CpTs3EB1JyBGLm6wxzQ8fPPUPrh4Wg06kp9J5lvxTG
         J1jnXKbJ6jYlDNBKalTThArBlB1ypdyW+O6pE7/6e6t9pkebX7dTPoA7d2APWWbXf7bo
         CgIoxZDOX3HGERSWQs9vjppNlSDVSPY7ag9hEhz2A7JmUTg0lNsSLxu8Oj+tAJx6tVG2
         hqtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770384937; x=1770989737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpmWnKuQAvcxfN2n9Aws3fxLD/5TLycZ+iQI8ZhYj4E=;
        b=G8ekIMW4Rdfti92YPZTjnFCLgDeLQsQHUoyr2TCfEQZQCVb2c5M0+6TtOw0kY1Q8Dq
         Zwsgc5IHRrC4+tiEcyZfpbeNxRSa8S1XeY4M0IEFpO5u3HYsFfPtY2Iyf6Y4cFvl3bBW
         0WaeRK9TSDIMbSsRkVPrveGXRINO7LkR7MPN++bwTK5jQPOcRvKW6XAo4YpEpefzRchr
         CHKCNtKhjFPRXMgwINs7cqLC+ctgxPTkv5XV/dQUt9LQywZGXWp7GRq1iOy4FEmJ/2Sn
         S00BW1/MFWgFOOGOg4hTQ4zHqu8AM64BwotbYNzlMqPYxDoJyE44thsYEvydDdRMfZDl
         pCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770384937; x=1770989737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EpmWnKuQAvcxfN2n9Aws3fxLD/5TLycZ+iQI8ZhYj4E=;
        b=AO6uMlps2BEJE+UCEYm2uBveBG4Msb2UCi7nUvRMIBMZi+qPcK0mOgNFS/vw3IMr/W
         uMU5uRotT+bzsmPL5W4/n7KBBrzszB1fMUuhZdPlfGXL8Ovsz3fRv6g0gEYqenwdSwHC
         A+a+d1xGRvDXco6DwPIWlqY1oumzWmHxu4Ku7YUTW9JPyTjGclP1DU4W9vZXJ6apd/BA
         t8FwkgqfuRp7XEfSdm7uwbkLQ4NPaTxdXdHQyiE6oXIEWe0G8BSJHfJCvtOEOLQmGFHr
         aEnSQQ9em8Ln4YeNL4qnqpeR1pSYFPDISVGvgCjcQaw9a515aF53fnlMzQ1uWvNKi8Uj
         U7Iw==
X-Forwarded-Encrypted: i=1; AJvYcCXVpn1P+R4YaBzvLq9+WoWSvKZYVXEb5covyfXIU+yPWElcEtUktXFWwNF3CN3JDmKF/byzka0DJul2xFHB@vger.kernel.org
X-Gm-Message-State: AOJu0YznoDeu2VfeMH5m60FgPD0Tda8q7v9ezffhdP3rJkRgk9puCjUm
	EBAlWH0NcobjiUvRomvlXYL//ZiGfHNrmX2WzjM7HOP8j8NCU2HpFRygff6HGLuRQp9uCQBTmQd
	tuHEeBNgaVs51QQqLkXhIu9IfaDE1T/Y=
X-Gm-Gg: AZuq6aLJDy/ns9Jwd6M220TH5ApYyiyNE7/QOad90gqY+nqteK7GIMMNWZea8q3hc3A
	TWmt+FJ7vpR3TFqIEG/ZXOGhB/FJHWZpnyJXKVMBi6zTyP6nmolhHLqzD0VjHe010XbdXMy43fQ
	0sgMJRf2IdXb0mZjOZ9XPXIsL1wLD3If4O7JJS9nkqSV/oQEGwZKuQC/cQmkakaLXWSj+O5LH3p
	s6k4+TiaOZT2bCkHV2FO5je6nT8fBXE/geKOsQACK/LXi6T+kqq4qW2sziiB3nj4SiNuOf5kLcd
	IFbCJDYjnP/shPP04ylLZyX5AzqPlKb2jfA6Bzhz
X-Received: by 2002:a05:6402:518f:b0:658:bd60:43e2 with SMTP id
 4fb4d7f45d1cf-659841692cdmr1419837a12.17.1770384937041; Fri, 06 Feb 2026
 05:35:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204050726.177283-1-neilb@ownmail.net> <20260204050726.177283-11-neilb@ownmail.net>
 <CAOQ4uxh-MLgwZCstwr6HyPXHVRmtj2F_=xS8pE3FN6Ex-wex4w@mail.gmail.com> <177034031005.16766.246184445940612287@noble.neil.brown.name>
In-Reply-To: <177034031005.16766.246184445940612287@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 6 Feb 2026 14:35:25 +0100
X-Gm-Features: AZwV_QjjYiogfyc5arz_rTitKV8bnytIdEM4CjRfI_5mGtvMvwFYoZk4un_zak4
Message-ID: <CAOQ4uxiWE5eVTrL-2EWVHGQEpEX7HSstj_+kEp-b7xZrnfoXMA@mail.gmail.com>
Subject: Re: [PATCH 10/13] ovl: change ovl_create_real() to get a new lock
 when re-opening created file.
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76583-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,canonical.com,paul-moore.com,namei.org,hallyn.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ownmail.net:email,brown.name:email]
X-Rspamd-Queue-Id: 69620FE3EE
X-Rspamd-Action: no action

On Fri, Feb 6, 2026 at 2:11=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
>
> On Thu, 05 Feb 2026, Amir Goldstein wrote:
> > On Wed, Feb 4, 2026 at 6:09=E2=80=AFAM NeilBrown <neilb@ownmail.net> wr=
ote:
> > >
> > > From: NeilBrown <neil@brown.name>
> > >
> > > When ovl_create_real() is used to create a file on the upper filesyst=
em
> > > it needs to return the resulting dentry - positive and hashed.
> > > It is usually the case the that dentry passed to the create function
> > > (e.g.  vfs_create()) will be suitable but this is not guaranteed.  Th=
e
> > > filesystem may unhash that dentry forcing a repeat lookup next time t=
he
> > > name is wanted.
> > >
> > > So ovl_create_real() must be (and is) aware of this and prepared to
> > > perform that lookup to get a hash positive dentry.
> > >
> > > This is currently done under that same directory lock that provided
> > > exclusion for the create.  Proposed changes to locking will make this
> > > not possible - as the name, rather than the directory, will be locked=
.
> > > The new APIs provided for lookup and locking do not and cannot suppor=
t
> > > this pattern.
> > >
> > > The lock isn't needed.  ovl_create_real() can drop the lock and then =
get
> > > a new lock for the lookup - then check that the lookup returned the
> > > correct inode.  In a well-behaved configuration where the upper
> > > filesystem is not being modified by a third party, this will always w=
ork
> > > reliably, and if there are separate modification it will fail cleanly=
.
> > >
> > > So change ovl_create_real() to drop the lock and call
> > > ovl_start_creating_upper() to find the correct dentry.  Note that
> > > start_creating doesn't fail if the name already exists.
> > >
> > > This removes the only remaining use of ovl_lookup_upper, so it is
> > > removed.
> > >
> > > Signed-off-by: NeilBrown <neil@brown.name>
> > > ---
> > >  fs/overlayfs/dir.c       | 24 ++++++++++++++++++------
> > >  fs/overlayfs/overlayfs.h |  7 -------
> > >  2 files changed, 18 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > > index ff3dbd1ca61f..ec08904d084d 100644
> > > --- a/fs/overlayfs/dir.c
> > > +++ b/fs/overlayfs/dir.c
> > > @@ -219,21 +219,33 @@ struct dentry *ovl_create_real(struct ovl_fs *o=
fs, struct dentry *parent,
> > >                 err =3D -EIO;
> > >         } else if (d_unhashed(newdentry)) {
> > >                 struct dentry *d;
> > > +               struct name_snapshot name;
> > >                 /*
> > >                  * Some filesystems (i.e. casefolded) may return an u=
nhashed
> > > -                * negative dentry from the ovl_lookup_upper() call b=
efore
> > > +                * negative dentry from the ovl_start_creating_upper(=
) call before
> > >                  * ovl_create_real().
> >
> >
> > According to the new locking rules, if the hashed dentry itself is
> > the synchronization object, is it going to be allowed to
> > filesystem to unhash the dentry while the dentry still in the
> > "creating" scope? It is hard for me to wrap my head around this.
>
> It can be confusing....
>
> It will be important for the name the remain locked (and hashed) until
> the operation (create, remove, rename) either succeeds or fails.  So
> leaving a dentry unhashed will be OK providing a subsequent lookup will
> also succeed or fail in the same way.  The caller must be able to use
> the dentry to access the object (i.e.  the inode) on success, but they
> is nothing in POSIX that requires that the object still has any
> particular name.
>
> >
> > Or do we need this here because some filesystems (casefold in
> > particular) are not going to support parallel creations?
>
> There is no reason that a casefolding filesystem would not support parall=
el
> ops. And it isn't just casefolding that acts like this.  At least one of
> the special filesystems (tracefs maybe) always unhashes on create.  You
> only ever get a hashed positive dentry as a result of lookup.
> (overlayfs would never see this case of course).
>
> >
> > >                  * In that case, lookup again after making the newden=
try
> > >                  * positive, so ovl_create_upper() always returns a h=
ashed
> > >                  * positive dentry.
> > > +                * As we have to drop the lock before the lookup a ra=
ce
> > > +                * could result in a lookup failure.  In that case we=
 return
> > > +                * an error.
> > >                  */
> > > -               d =3D ovl_lookup_upper(ofs, newdentry->d_name.name, p=
arent,
> > > -                                    newdentry->d_name.len);
> > > -               dput(newdentry);
> > > -               if (IS_ERR_OR_NULL(d))
> > > +               take_dentry_name_snapshot(&name, newdentry);
> > > +               end_creating_keep(newdentry);
> > > +               d =3D ovl_start_creating_upper(ofs, parent, &name.nam=
e);
> > > +               release_dentry_name_snapshot(&name);
> >
> > OK. not saying no to this (yet) but I have to admit that it is pretty
> > ugly that the callers of ovl_create_real() want to create a specific
> > stable name, which is could be passed in as const char *name
> > and yet we end up doing this weird dance here just to keep the name
> > from newdentry.
>
> There are three callers of ovl_create_real()
>
> ovl_lookup_or_create() does have a "const char *name".
> ovl_create_upper() has a stable dentry from which it can copy a QSTR
> ovl_create_temp() would need some sort of dance to keep hold of the
> temporary name that was allocated.
>
> If it weren't for ovl_create_temp() I would agree with you.
>
> Though we could have the three callers of ovl_start_creating_temp() pass =
a
> "char name[OVL_TEMPNAME_SIZE]" in, then ovl_create_temp() would have
> easy access.
> I could do that if you like.

Yes, considering that two of the callers are from the same function
(ovl_whiteout()) I think that would end up looking nicer.

Thanks,
Amir.

