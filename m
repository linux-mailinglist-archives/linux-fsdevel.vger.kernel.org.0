Return-Path: <linux-fsdevel+bounces-77957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOr2GKlZnGmzEgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:44:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5CB1772A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AFE823043BC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 13:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DEE2367BA;
	Mon, 23 Feb 2026 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxwDdZG9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C63923C4E9
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854157; cv=pass; b=fTloKIZl4+cbwGX4oHBNOhKZP++17z6/tSROFAb9+th5jN2Qrnl0SlfN1WocuC0dp6ZQ/hof4ypO4mtfRPS/Dx5QLAjIQvSXQbf1vhiKmE5M4Oi1Se/Ba5+iM7f9cNPkF71PxiUjlsi6a8oBsdYiMBLgcvvecM8SIxakZzBUBhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854157; c=relaxed/simple;
	bh=3vshmxc5tGDcDwufTtgEK5XIRPq/zCoj7NLZuvL2OUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J9z2CmNXk/TLGUENu4166iuj3JQriKpAMvyHNtHVhGgxkkDwNF7b41QBSsXjJ4GbH0bCKl4ZkjYv2ux0jQhENX1tJZgvcPSh3Su5o6cZWl5B34JZ+2EYftG/KvQKmY2k7ugjbnD866iex7+NiM+6rhvmDwq7GEb6FfTER0kUUUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxwDdZG9; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-65c5a778923so6576501a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 05:42:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771854152; cv=none;
        d=google.com; s=arc-20240605;
        b=VZrjllu1hmT6rZdHxPcKnvugSUIIY3o1TBkWg/x2X7Gb4SP2LANzsBXmiv1X33TKAh
         ORMQREc9rjxVDxM6hjzNrwFBSm/qbMupVfrFhWMqqNoOUzPYcrvTVOcWfrtR5fsCJJMA
         IV1tIS1ur0arvwpuDKh6m3ppBODAXAcstJQ0KrdgSbhGWPVh3KpQ81UE+TPsYr1RCAQp
         BixB4R22Rk4ti6pxIQyiCGUn6dBI3DF5t25ZicZ6IJd6ACbvo8TBA+Ldmc5tjnyGy5l7
         0WCj7LhKaP9PcEpEh3LGRfj73ajcoz7yN3RXKclQ815jJzzjqmmfIjvMjWcLGR2EL29x
         re2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RYqIR5a+IIRIL9B6CcCBN1lSzoy1pmPgI7+7PRVLxeU=;
        fh=QisjoYD1+0YcarrRPskVpeNqjmWB0quxH90pIiewRjM=;
        b=ji58WL4Vg1Hj1qwgcgaaeDBg+C2hH9LlVN/Wb6JJuUf+IQ1OW/jkxZ05h53GY3P/nz
         GdkO+jPACOmXHkRtOu5gl9Zg0Gb/IwN7ZiKxjlwDP4cNMWkMXDSoTI2SR0DN3J5O+Zs/
         EJxB/8G+rd79j7ZRcbPPmep4nx+dAUGLIp3T5NUIz5VAjvDyW2o+vbo+x9iTK4nQZ0Wm
         W2N+I1UO7JQuyBIBqMoQlZsGSYsu7ebEcRM60l33RdsKwHNoZV1aD6ytn/+qvymXUH3Y
         MwnYEri25yx/197rnsNdTVKI67R0e09jlot5MqI5ktv89DdAX7D6zhtdJMnUPfKJIGlL
         adMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771854152; x=1772458952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYqIR5a+IIRIL9B6CcCBN1lSzoy1pmPgI7+7PRVLxeU=;
        b=CxwDdZG99TeHt4hb/Q2hzUmmbmTVOYWOhNE6JJzF0mo5xDoqFbKL5ZYz5NmdRdVu9+
         qPAj41/mjRug2h3KECWrNunHtWcQZlZS0qOJxJWFQ2QKiopt63u05CX62G1EfwckGNQN
         CFbzH27gDeTt94JPBHpnrfo5DVhKhonYnavaQSih0rlU2Cq+RW6TVBHdCIPU4Bg3P5WG
         BnNWYeexue9dLsQ3jxINWnDCOig18smScRk3UEFzEUV5rppYBoZK6Tj2ABsREUtZ39Uh
         I/b3943DJwf7bQb3EUppdtXLMhJ3vHB5gA5WJIh27VJFfsQ2bw643y+aKnXEPZfX1PkM
         wWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771854152; x=1772458952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RYqIR5a+IIRIL9B6CcCBN1lSzoy1pmPgI7+7PRVLxeU=;
        b=MILtqJj0oeszSpgo+LJ+S1vC/rhY2/cKHR1P49/rUJK0G/gIPcYyO8iEq3PK9WqYd7
         sCOIaUQ58ziwFzh9FLPSpN7k2h/EMXcBIxFmzbjGXFA3DgPGiK1x3bbu3IjTzLm65XT6
         4eWrjv7Yv+ZG9XusTwPys8s3/nLT3OLZOHRt14UWz2IwQXYIEOy5Mu4a1iPfiTqq08YS
         wBqm/q06mZED/N8WHHAVPDygcDIJWHaWdYOl7uIB5QiIrc7K/oF59GJMYjDI8y/P86f1
         yz3/TNM197rNsPKNFWMbb7XgwW/T6zldqMJCxcpQDQg417Ay7zoIM49/UHL74P7ALYtD
         G/dA==
X-Forwarded-Encrypted: i=1; AJvYcCWpqQgYc8DawhiRJHOQvt0lyHqpN5dVUO3ozB5RqwYkrNyYOCG+4gFfV8cU49q46IbNMIFrI26sW9WkzO6s@vger.kernel.org
X-Gm-Message-State: AOJu0YydVCTJlrv1kkfCSLC5uX9chh9RdHXpoNkYU1NrFMWs0iLqLY4v
	GHoHHUG0np25Ehge/y+9MWhmD8uc56CnhDWoobrUsehPALOB+sGf3S2jL4JErigoF+I4asDGrxx
	E7XAcwOhjvKb9qAHO8N2noUbXOZv51aY=
X-Gm-Gg: AZuq6aKb84BI/seL1G33xus+RuBqHZdM8C1O3hkOXEYh1af5nMFQsz00rZXf7kuoqIL
	9tGxpsUT7jApe5ptwt3FyicokH/rja0pIZVKeAjxEjUxEoiZ4zpFjb8cq7KsWjklrAHF5HothYZ
	CACERVStmGxEXV63RhkkAGG/8s+wy/pkszfZ2BhPIErHWiAHynpx+aigAUae8G5KQ+ulAyKcKAU
	2BC43/Aq65zjfZ/Wso9I18MBUyCWdUPYD1hX699JEuGzp+27+UnXTuOcG9Ty0bDe04Udi/N0UE4
	DxU2ik7d4W2juXU64WoMiLRYISKXySsvjmoFF9y7Iw==
X-Received: by 2002:a17:907:84b:b0:b90:bc06:2acc with SMTP id
 a640c23a62f3a-b90bc063e40mr41246666b.5.1771854151460; Mon, 23 Feb 2026
 05:42:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223011210.3853517-1-neilb@ownmail.net> <20260223011210.3853517-10-neilb@ownmail.net>
 <20260223132027.4165509-1-clm@meta.com>
In-Reply-To: <20260223132027.4165509-1-clm@meta.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 23 Feb 2026 15:42:19 +0200
X-Gm-Features: AaiRm52WUoDV9vuNNf_TRYKkff03CBHKSKX_6G_n5O_M7CVzPVA-lit5gSUxti8
Message-ID: <CAOQ4uxirM8dW9rOw4SvGtfH-s0Eg9LGuFk1aZooMvEDc=2tbyA@mail.gmail.com>
Subject: Re: [PATCH v2 09/15] ovl: Simplify ovl_lookup_real_one()
To: Chris Mason <clm@meta.com>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, John Johansen <john.johansen@canonical.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77957-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[brown.name,kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,canonical.com,paul-moore.com,namei.org,hallyn.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,brown.name:email,ownmail.net:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2A5CB1772A6
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 2:20=E2=80=AFPM Chris Mason <clm@meta.com> wrote:
>
> NeilBrown <neilb@ownmail.net> wrote:
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
>
> Hi everyone,
>
> Amir asked me to run these through, and this commit was flagged.  I recen=
tly
> changed the prompts to include some vfs knowledge:

Thanks Chris!

>
> https://github.com/masoncl/review-prompts/blob/main/kernel/subsystem/vfs.=
md
>
> And I also put in some words to make it prefer reporting problems that mi=
ght
> not be bugs, but that do violate some rule in the .md files.  This might
> be a false positive from that new shift toward blindly trusting the guide=
s,
> but I'll let everyone here decide:
>
> commit d1bfcef048896cdc9e4c57e3249b6ad344d64c02
> Author: NeilBrown <neil@brown.name>
>
> ovl: Simplify ovl_lookup_real_one()
>
> This patch removes locking from ovl_lookup_real_one() and reorganizes the
> control flow. The function now uses lookup_noperm_unlocked() instead of
> lookup_noperm() and performs consistency validation after the lookup rath=
er
> than holding a lock during the operation.
>
> > diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> > index 83f80fdb15674..b448fc9424b64 100644
> > --- a/fs/overlayfs/export.c
> > +++ b/fs/overlayfs/export.c
> > @@ -349,69 +349,64 @@ static struct dentry *ovl_dentry_real_at(struct d=
entry *dentry, int idx)
> >       return NULL;
> >  }
> >
> > -/*
> > - * Lookup a child overlay dentry to get a connected overlay dentry who=
se real
> > - * dentry is @real. If @real is on upper layer, we lookup a child over=
lay
> > - * dentry with the same name as the real dentry. Otherwise, we need to=
 consult
> > - * index for lookup.
> > +/**
> > + * ovl_lookup_real_one -  Lookup a child overlay dentry to get an over=
lay dentry whose real dentry is given
> > + * @connected: parent overlay dentry
> > + * @real: given child real dentry
> > + * @layer: layer in which @real exists
> > + *
> > + *
> > + * Lookup a child overlay dentry in @connected with the same name as t=
he @real
> > + * dentry.  Then check that the parent of the result is the real dentr=
y for
> > + * @connected, and @real is the real dentry for the result.
> > + *
> > + * Returns:
> > + *   %-ECHILD if the parent of @real is no longer the real dentry for =
@connected.
> > + *   %-ESTALE if @real is no the real dentry of the found dentry.
>                                        ^^
> There's a typo here: "is no the" should be "is not the".
>
> > + *   Otherwise the found dentry is returned.
> >   */
> >  static struct dentry *ovl_lookup_real_one(struct dentry *connected,
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
> > -      */
> > -     inode_lock_nested(dir, I_MUTEX_PARENT);
> > -     err =3D -ECHILD;
> > -     parent =3D dget_parent(real);
> > -     if (ovl_dentry_real_at(connected, layer->idx) !=3D parent)
> > -             goto fail;
> > -
> > -     /*
> > -      * We also need to take a snapshot of real dentry name to protect=
 us
> > +      * We need to take a snapshot of real dentry name to protect us
> >        * from racing with underlying layer rename. In this case, we don=
't
> >        * care about returning ESTALE, only from dereferencing a free na=
me
> >        * pointer because we hold no lock on the real dentry.
> >        */
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
>
> A subsystem pattern flags this as potentially concerning: the VFS subsyst=
em
> guide indicates that TOCTOU validation checking d_parent should also chec=
k
> d_unhashed() because a dentry can be unhashed (removed from dcache by
> concurrent operations) while its d_parent pointer remains unchanged.
>
> The old code held inode_lock_nested(dir, I_MUTEX_PARENT) during the entir=
e
> lookup and validation, which serialized with operations that could unhash=
 the
> dentry. The new lockless pattern creates a window where:
>
> 1. lookup_noperm_unlocked() completes and returns dentry `this`
> 2. A concurrent unlink/remove operation unhashes `this`
> 3. The d_parent validation passes (parent pointer unchanged)
> 4. The function returns an unhashed dentry
>
> Other overlayfs code uses the complete pattern. For example, in
> ovl_lock_rename_workdir() at fs/overlayfs/util.c:
>
>     if (work->d_parent !=3D workdir || d_unhashed(work)) {
>         ...
>     }
>
> Could this validation miss a race where the dentry is unhashed but d_pare=
nt
> still matches? The subsequent checks (!this->d_inode for -ENOENT,
> wrong real dentry for -ESTALE) might catch some cases, but is that
> sufficient for all the scenarios where an unhashed dentry could cause
> problems?
>

It's a very good comment and very important rule to check, since
we have at least 3 fix commits on breaking this rule, but as this
code is utterly confusing to most human I do not blame LLM for getting
confused here.

The lock not taken on 'dir' which is the overlayfs inode and the checked
'real' dentry is on the underlying fs.

Therefore, the check of real->d_parent was not protected in old code as
well as in new code - it is a mere best effort sanity check, so I think
there is no added risk here.

Neil, do you agree?

Thanks,
Amir.

