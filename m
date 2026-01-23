Return-Path: <linux-fsdevel+bounces-75307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGOpJYG4c2n/yAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 19:05:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 576F179582
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 19:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03C66302C309
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 18:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0B5226CFE;
	Fri, 23 Jan 2026 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Db/eFW/N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503D91B81D3
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769191545; cv=pass; b=A70vg1DiaOXWOQU5IhU+YufNcVLm6BMmfzyHte7BBBJxL8GVgqSmnaZqfCE6pYNiX+M/4r9qBZN/sR0JB+XRcvEDi9RS3AjpQUVoV0cR/HB6mGWpN15Zixs3Pmsxw63Jd+tIKFs22vQxP32mfc80OfuB8iQNyt5uImOqHvf8Jnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769191545; c=relaxed/simple;
	bh=xehY8ysmdmNlqfZyinESPYs7hLaFRDZou9gAV+EhgYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKFS95ElQ6abd+xaJ4Q6tBC9aOISiRvHPylc6MKBmDF+Uxq/X+gdEfvDXbZFAJCzyKwUsCWJki/TzgwXxQ3CUq7OkTxCBPwXL3RP5WylQ0QPwhe16f27R0LoTSVar5FYgcHY8ADEFxnfhd2LCw0dboQHIKqiOEwa10oRNIVV6Ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Db/eFW/N; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5014e8a42aeso37631961cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 10:05:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769191543; cv=none;
        d=google.com; s=arc-20240605;
        b=QdLknCyxx03FjSVASWTI4E/1tbMLIfjrj4BxNva/G0bpft0Rx99ZlXrwHpaUsFHPjq
         j6X5vDY6lJXWZ/ln2eNM9M7QJkhQkat0vYBmibX2YJ8CkdPSYasJWanDRDIndLWpCxhD
         LgZ1jpkt4kNeFPl6qLuU57TYPz3VAUB39YwZsn53BfxfaqDRGwSaIpkcPIrC4O5dbWVG
         yPUFJuipo9E4cCJWPW8mfpKZ3YJVR9VCRYzvmpcG/HCySHPFBrA1glf6DcutnQGs0X9h
         b/anume+8Wv451ZyiQlodgytVR2VrgGmXP+6bsFS3WMMVY8RWKZpr6wnC1WhM47ReJhn
         MB1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wZkuP3g0YSuaBFKhPNa+n2pB+JE5lQaD+m2hRJ4sY3Y=;
        fh=YWxmlg5jRugnmeVvTfYQ/n8P5n/j6ky46glkQRM3JFQ=;
        b=Mec6gtQY+DplBeBSN6k46jamaLHaAwS+uvQHgf3aCEXzFNfIt1uhJABws7HCeIvG4G
         GDm7Pfri08SUfGG526PgwK/u7aqFx4XODscBEDvNqeWTjmKpg8XUvcSUVUo8G1BpyDS+
         zivP3MgT5q5NpN2teHaGd65l/7M1q9MdktI9+tLIBoZ5GzNDBIw1cbEzpD6M/b2C3UcR
         PQ0Vus8b3db2o+7iGAMXcMx6nIbtZJWVt7/cMq9IvhwgPwcVpMjyCEPKN8tuBbctLK1q
         cAbuyLHm2nvnxXIpNjoxmuMeFvvPaV89hJgfZPKvI+OnY6aFLI5ET3fnr2AJYiIh+PgK
         /yag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769191543; x=1769796343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZkuP3g0YSuaBFKhPNa+n2pB+JE5lQaD+m2hRJ4sY3Y=;
        b=Db/eFW/NFh8WHZQNAjyX4e4SMoiAk/ASps+ryZIIyqgkwL/mGA5r7JBgKNuVrWS7aS
         VBt4Xi53cOnGQgm6FUThoJMhBJYO9uj7VBuJ4g70iH5DHygw4xH0XeewCrMHI+78qx3E
         AJXRp44bxiCt5jybyHtb7nFYftKKMH10ne6fHPxVU/KZVe+H/YVK8cx1jnT+LTpbQY4P
         gpE+pm9awd8TxV5GdsB55pBpNJpr//5GiRUyt8M0kfZG/K6KchMUQaYI1cEs/8KO4udw
         9Q9Ba2rkM6jliCoUqOKMnLwC9UYDywmdx02CKk850Q5SMrCX1SlPPbUU2wxcIb+eI/ye
         ZSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769191543; x=1769796343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wZkuP3g0YSuaBFKhPNa+n2pB+JE5lQaD+m2hRJ4sY3Y=;
        b=G7d02CRZqwrcyRRlbjcreRGqCswmcnyJNkAXMvILDPovfHbcdjW9A/Z1ZImKIwm8NW
         NxZ0OSp/qJZIgGteCfia8dZHNg9twIoLwESEDu9DFskY5vkzjmRsQPny+TO7x5tFsRyv
         SWs+TBZxT14cNNO/tXzgwr23fRps5ETLrNEIfPnkWoDzDkhI4Xe7X+z9N0EV+qDbO30A
         4rLzUDOsOp1wziZqcQGTrAvfHQZVrZqcv9KCeuJ2LeskLyQ01OogenHZwzsJA4Ng7dhC
         juzRu2/7yL0r/wvH7FK8UssJQbQgHM30mNRG4pCiT3TmoDYaSegsxczlG5+hcy8UIH7U
         geDA==
X-Forwarded-Encrypted: i=1; AJvYcCUhQWPAAozv1Gk3unbC6Io/5mbIFsViBYLrOt9mhinpJ/sSe0GsEe+H/87vefr88WZtprLuMQqetjgSrIDQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyTR2XX3wGaB5LviTywM4WmbFdEQbl/6Mfk/mCa2ZzK5HwdTUzY
	ukzPgnQZL+gQCD6qLzxtL7Eq5DYRR0zDKCCOCD6WnawU00NeB14OdLRDeYiysJYnj5bAYIcapGA
	L/vVFVabubWPTKGzxE6KHfyDKSzTSs7M=
X-Gm-Gg: AZuq6aJQ4DJMxO4C+k6gZfctktKH1ZALQ6Ak3LNziSSk7QLNO/U8x0uTpuB6ayEhRIC
	IQp/7TiDovWq8xxZFoIFIesxYIqi42489s6sTZbnOJTMCYpr+dZXQG41e1v5gm/D9HJLM7MwU2t
	ylxhnYZQXPuVyGI1WvjwmfZcCZ+0dvlg+bSF+U1HCRvt2/L2uEdKvEwI+wcW10SoHkmfGVX7LDs
	52GVSChSll51/R7AFgrCngom0b8LILDhxRr3EbdxrXC381kDy2Lb/xDj9yB2WZDVbnjyA==
X-Received: by 2002:a05:622a:4c7:b0:4eb:a8ba:947b with SMTP id
 d75a77b69052e-502f7726656mr51243091cf.24.1769191543162; Fri, 23 Jan 2026
 10:05:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <176169810502.1424854.13869957103489591272.stgit@frogsfrogsfrogs>
 <CAJnrk1ZDeYytdjuCdg6-O-PGjcmwS33LOnfFT_YY9SPE=x=Qxw@mail.gmail.com> <20260122222233.GA5900@frogsfrogsfrogs>
In-Reply-To: <20260122222233.GA5900@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 23 Jan 2026 10:05:32 -0800
X-Gm-Features: AZwV_QgkdjFVlKZVVUA07jJ49LL9vru5MvlA1dgKsjEqqZGs9Tu7vycFzdr9a0c
Message-ID: <CAJnrk1ZYp=+ho02gMAPGLsGBo3a84ScuE92xP68=1SR-ixAs+g@mail.gmail.com>
Subject: Re: [PATCH 07/31] fuse: create a per-inode flag for toggling iomap
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75307-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 576F179582
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 2:22=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Wed, Jan 21, 2026 at 05:13:39PM -0800, Joanne Koong wrote:
> > On Tue, Oct 28, 2025 at 5:46=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > Create a per-inode flag to control whether or not this inode actually
> > > uses iomap.  This is required for non-regular files because iomap
> > > doesn't apply there; and enables fuse filesystems to provide some
> > > non-iomap files if desired.
> > >
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> >
> > The logic in this makes sense to me, left just a few comments below.
> >
> > Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
>
> Thanks!
>
> > > ---
> > >  fs/fuse/fuse_i.h          |   17 ++++++++++++++++
> > >  include/uapi/linux/fuse.h |    3 +++
> > >  fs/fuse/file.c            |    1 +
> > >  fs/fuse/file_iomap.c      |   49 +++++++++++++++++++++++++++++++++++=
++++++++++
> > >  fs/fuse/inode.c           |   26 ++++++++++++++++++------
> > >  5 files changed, 90 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > > index f1ef77a0be05bb..42c85c19f3b13b 100644
> > > --- a/fs/fuse/file.c
> > > +++ b/fs/fuse/file.c
> > > +void fuse_iomap_init_reg_inode(struct inode *inode, unsigned attr_fl=
ags)
> > > +{
> > > +       struct fuse_conn *conn =3D get_fuse_conn(inode);
> > > +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> > > +
> > > +       ASSERT(S_ISREG(inode->i_mode));
> > > +
> > > +       if (conn->iomap && (attr_flags & FUSE_ATTR_IOMAP)) {
> > > +               set_bit(FUSE_I_EXCLUSIVE, &fi->state);
> > > +               fuse_inode_set_iomap(inode);
> > > +       }
> > > +}
> > > +
> > > +void fuse_iomap_evict_inode(struct inode *inode)
> > > +{
> > > +       struct fuse_conn *conn =3D get_fuse_conn(inode);
> > > +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> > > +
> > > +       if (fuse_inode_has_iomap(inode))
> >
> > If I'm understanding this correctly, a fuse inode can't have
> > FUSE_I_IOMAP set on it if conn>iomap is not enabled, correct?
>
> Correct.
>
> > Maybe it makes sense to just return if (!conn->iomap) at the very
> > beginning, to make that more clear?
>
> <shrug> fuse_inode_has_iomap only checks FUSE_I_IOMAP...
>
> > > +               fuse_inode_clear_iomap(inode);
> > > +       if (conn->iomap && fuse_inode_is_exclusive(inode))
> > > +               clear_bit(FUSE_I_EXCLUSIVE, &fi->state);
>
> ...but I wasn't going to assume that iomap is the only way that
> FUSE_I_EXCLUSIVE could get set.
>
> On the other hand, for non-regular files we set FUSE_I_EXCLUSIVE only if
> conn->iomap is nonzero *and* attr->flags contains FUSE_ATTR_IOMAP.  So
> this clearing code isn't quite the same as the setting code.
>
> I wonder if that means we should set FUSE_I_IOMAP for non-regular files?
> They don't use iomap itself, but I suppose it would be neat if "iomap
> directories" also meant that timestamps and whatnot worked in the same
> as they do for regular files.
>

That seems like a good idea to me. I think that also makes the mental
model (at least for me) simpler.

Thanks,
Joanne

