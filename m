Return-Path: <linux-fsdevel+bounces-75637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPokKKj+eGmOuQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 19:06:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB0A98C72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 19:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8A75307DEC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 18:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5404A325492;
	Tue, 27 Jan 2026 18:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8NJljtt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE8D32471E
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 18:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537083; cv=pass; b=Cd2CClcKVcYs0gS3d9lUY7e0oo4njjLvAYVNsozBGeLnFH0ppwZbOtGgM5l20481vHcueb6R9rq6feSQ2tIaPlBwjd49qm3VJGPYLC9QHv57OoX0+Lfqlyt9TRwxTkkgVsWNMYT5zQvYcyEhaGGuQC5UOZHkdTNEiKR2UZ67ndE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537083; c=relaxed/simple;
	bh=9Q++B6x9NWUhCC1MQvU3E6p3/VIk3il3MCiUUCXzizY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgkONdwRd9qw1RDAmBebmld3dt0Y1CXC2h52k9csAs4nKzYbqUhu7zCMIKvUuS3Aczn19knZvECZMLNJQ7yw97GSdnzBt6SSB2YVm0fiSicgR619BNRIu9HfmsXf2PRbl5ocEbT8i2KGl42/b1Dk8LZh7QLJaE2o4o1sA1tMdF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8NJljtt; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5028fb9d03bso52013981cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 10:04:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769537081; cv=none;
        d=google.com; s=arc-20240605;
        b=ESaCv4391OiAB7BiqwZiJeuOKXwr64RB0y/ulxE8ESibQr3O8jvZxmiT2pFLQyoJ7X
         kUGV0GBK+ZqtZNLaqCM7QO32KdMV48K0UfBg9kfrhAlY+59/+EkhlL2QmuZuI6hezr1x
         OpCAi+9Z4EbOtkIzDw/QI0hK5VBH2j2NnXGLaAIfSeIPHHmyUFebKOr2NmKIJmV5HSbf
         rAXpuOeGD1SdIUorbq92BfAy1bC6G5uWI0BVwCB330jYXGq+k+uHPCUbE6/Ql1VGiWmJ
         OYKXLdaaJH/TZH1LwOFA1GPs3eRvVxq7uxGH5ZlgGQD8tk1C0RS/uoUGBaOvAHBIuNNu
         C1dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yTGqCSrAO14/T74bD9VsvyVFqd1QleqaRQzBRwnRSe8=;
        fh=u/zfD3iqn3WkxW7x/8REUsVvr1bmGfL8dFXiY15YElA=;
        b=eOxnfJjE2UdsXOaBYUSrFduzq2Hi4EYw5stmj8ls/EWsDnv/Shz9/GTmA70fsrQrFu
         zmxrybGYVepHTYmq1K8UP2ZR+oAH60pWSw7LXFrDCjXCjUlfYtka5OlVhwiF7U8CR4Wn
         /1OjF5b5CIv8OmNQO0YwqNTb/2TdDbOrfs4gYw7liRl3NF9FOHw2VTTa3u0ctASWrkgz
         qf2BuCAPJJLu4loNDH1cVx4Rk/pzUOw6Pz/IegX2YKqbKkYzcFCMRzJ+TwcjuFwHPX+v
         3EQkVFLxf17s/VCb8Z8V2dmBOtrhwdkC20PCSdQVOU68/YVfhHEDFB4jsCiQ/7rJAzsg
         fOiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769537081; x=1770141881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTGqCSrAO14/T74bD9VsvyVFqd1QleqaRQzBRwnRSe8=;
        b=g8NJljttsEUvP2ypfSNjRy6zCXGp/ZjpWQh5tEddTNC7vWFY1/gMSNvD2M46ff9LmI
         zgutSJnhcD7yyxJ8JNLnkcIzsDfXN5q38CSNzNjebNeNCVyfUfIIA+FX10AHuBZTi2G2
         ewSUlR96zfrW5Q5MNhKxFU9cRjxKrvZa8jhLhxk7YsBlHtvZjwQCUClrOFa60PQ+DT6J
         /TM3DSiN10PnQNiLEsZWgXQRyL5gd24MPlV6Oy316KqAP/XI8wV3k7DELSaXI6WLMjCN
         wop5m0Lv8/moW2OFKzVez4dsF5h4RZi9qv+jSWkZdzrHKscJ/vochDK5I5vxQiCnIyGa
         +77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537081; x=1770141881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yTGqCSrAO14/T74bD9VsvyVFqd1QleqaRQzBRwnRSe8=;
        b=NWTU7sJaKOEEd0iufCMLxwumQiGm3p1lXClL3M1JGfhmVF0Djrh9HABnXGr2jmn9ca
         hpYPCWuNq94RG/Jci4ZhW4Kkv8Qc4ZKp51gLQqMYvceXvhBJTqXZLe0sCAm+zCMG/yO+
         Yk6Jv0wD39g2pdNCWDoKN4jhbCDN7guoeNNrjPW2L/61rd543kZbXqpc+CAZNYa4mWNp
         k5tmsysoUubeVA0sjw1AihrFQTYEYmOYjnjmgmmLAgMYGgI44MUtiScivJ+MNGo7MlgF
         Biw7/Z9FA8906KJPcPReHyQlYS/sgkO453xAdxhycKAT3qrtyHd4L2nCe24t27a5BQYK
         SSfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqEkM/qhN7aT/WiJtte3m7UpGcixvMHEabLJwJC92Eo2mKgKT+OtypnNR2jRfTxrblJMbnRBAiq62GaPSt@vger.kernel.org
X-Gm-Message-State: AOJu0Yya9W3eKDXOTEejwIhoWQ/S0Xg8xTBm1IOdTH+H4OoaYEUK91pB
	aVED6z5ISmKTFEe1LXOy4ZdoNour6OCJuwZC1bt83t61j0yOgiZl7Ps+eJW807Cfi2WypE+MK18
	caqXnPHhqj+UaEtHuIe98kM3kxUhp+iE=
X-Gm-Gg: AZuq6aIiObX5MNIqn4mi5GtZFXNo3J+LyJy9Pj2FQ5ZWrA6LlQY4qv02dWxXkbVY0Ah
	xHcO8J+o33hF1fQNl6CQFtmoExu7CMKWElkd0Pyl8ICCYZHDmpOnYE5/h+eSwsYfnYhmhUkPiaX
	FGWVZK8tOtUbzFPFXMwG6x6McagWtS7fQt2gWKCLXPjzC8CToAZI3wdVtlItObAeKatRfmowjt2
	/3iPLhP/u63Ggju1LO/cMYcHdA06YWPPdpJ4Qd0w+Bad9npfxUVTvLwVTI18hBph0lt2cguiHV/
	/fbZ
X-Received: by 2002:ac8:7e92:0:b0:4ff:c876:bda4 with SMTP id
 d75a77b69052e-5032f89648cmr33195261cf.24.1769537081077; Tue, 27 Jan 2026
 10:04:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <176169810721.1424854.6150447623894591900.stgit@frogsfrogsfrogs>
 <CAJnrk1ZDz5pQUtyiphuqtyAJtpx23x1BcdPUDBRJRfJaguzrhQ@mail.gmail.com>
 <20260126235531.GE5900@frogsfrogsfrogs> <CAJnrk1ZYF7MG0mBZ4GRdKfmSiEEx3vXxgiH3oYdMS-neWSA2mw@mail.gmail.com>
 <20260127020944.GF5900@frogsfrogsfrogs>
In-Reply-To: <20260127020944.GF5900@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 27 Jan 2026 10:04:28 -0800
X-Gm-Features: AZwV_Qh-XbFdxsxs1T-D_CKamUEYHfT0idkeYSNmBHBpE74F0i3Qo6k1bW9XFkE
Message-ID: <CAJnrk1Yw5Ypv8NdY_+1wW3VURgmrornp2XCQSYv5VS4rwaf6Ow@mail.gmail.com>
Subject: Re: [PATCH 17/31] fuse: use an unrestricted backing device with iomap
 pagecache io
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75637-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1FB0A98C72
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 6:09=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Mon, Jan 26, 2026 at 05:35:05PM -0800, Joanne Koong wrote:
> > On Mon, Jan 26, 2026 at 3:55=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > On Mon, Jan 26, 2026 at 02:03:35PM -0800, Joanne Koong wrote:
> > > > On Tue, Oct 28, 2025 at 5:49=E2=80=AFPM Darrick J. Wong <djwong@ker=
nel.org> wrote:
> > > > >
> > > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > >
> > > > > With iomap support turned on for the pagecache, the kernel issues
> > > > > writeback to directly to block devices and we no longer have to p=
ush all
> > > > > those pages through the fuse device to userspace.  Therefore, we =
don't
> > > > > need the tight dirty limits (~1M) that are used for regular fuse.=
  This
> > > > > dramatically increases the performance of fuse's pagecache IO.
> > > > >
> > > > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > > > ---
> > > > >  fs/fuse/file_iomap.c |   21 +++++++++++++++++++++
> > > > >  1 file changed, 21 insertions(+)
> > > > >
> > > > >
> > > > > diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
> > > > > index 0bae356045638b..a9bacaa0991afa 100644
> > > > > --- a/fs/fuse/file_iomap.c
> > > > > +++ b/fs/fuse/file_iomap.c
> > > > > @@ -713,6 +713,27 @@ const struct fuse_backing_ops fuse_iomap_bac=
king_ops =3D {
> > > > >  void fuse_iomap_mount(struct fuse_mount *fm)
> > > > >  {
> > > > >         struct fuse_conn *fc =3D fm->fc;
> > > > > +       struct super_block *sb =3D fm->sb;
> > > > > +       struct backing_dev_info *old_bdi =3D sb->s_bdi;
> > > > > +       char *suffix =3D sb->s_bdev ? "-fuseblk" : "-fuse";
> > > > > +       int res;
> > > > > +
> > > > > +       /*
> > > > > +        * sb->s_bdi points to the initial private bdi.  However,=
 we want to
> > > > > +        * redirect it to a new private bdi with default dirty an=
d readahead
> > > > > +        * settings because iomap writeback won't be pushing a to=
n of dirty
> > > > > +        * data through the fuse device.  If this fails we fall b=
ack to the
> > > > > +        * initial fuse bdi.
> > > > > +        */
> > > > > +       sb->s_bdi =3D &noop_backing_dev_info;
> > > > > +       res =3D super_setup_bdi_name(sb, "%u:%u%s.iomap", MAJOR(f=
c->dev),
> > > > > +                                  MINOR(fc->dev), suffix);
> > > > > +       if (res) {
> > > > > +               sb->s_bdi =3D old_bdi;
> > > > > +       } else {
> > > > > +               bdi_unregister(old_bdi);
> > > > > +               bdi_put(old_bdi);
> > > > > +       }
> > > >
> > > > Maybe I'm missing something here, but isn't sb->s_bdi already set t=
o
> > > > noop_backing_dev_info when fuse_iomap_mount() is called?
> > > > fuse_fill_super() -> fuse_fill_super_common() -> fuse_bdi_init() do=
es
> > > > this already before the fuse_iomap_mount() call, afaict.
> > >
> > > Right.
> > >
> > > > I think what we need to do is just unset BDI_CAP_STRICTLIMIT and
> > > > adjust the bdi max ratio?
> > >
> > > That's sufficient to undo the effects of fuse_bdi_init, yes.  However
> > > the BDI gets created with the name "$major:$minor{-fuseblk}" and ther=
e
> > > are "management" scripts that try to tweak fuse BDIs for better
> > > performance.
> > >
> > > I don't want some dumb script to mismanage a fuse-iomap filesystem
> > > because it can't tell the difference, so I create a new bdi with the
> > > name "$major:$minor.iomap" to make it obvious.  But super_setup_bdi_n=
ame
> > > gets cranky if s_bdi isn't set to noop and we don't want to fail a mo=
unt
> > > here due to ENOMEM so ... I implemented this weird switcheroo code.
> >
> > I see. It might be useful to copy/paste this into the commit message
> > just for added context. I don't see a better way of doing it than what
> > you have in this patch then since we rely on the init reply to know
> > whether iomap should be used or not...
>
> I'll do that.  I will also add that as soon as any BDI is created, it
> will be exposed to userspace in sysfs.  That means that running the code
> from fuse_bdi_init in reverse will not necessarily produce the same
> results as a freshly created BDI.
>
> > If the new bdi setup fails, I wonder if the mount should just fail
> > entirely then. That seems better to me than letting it succeed with
>
> Err, which new bdi setup?  If fuse-iomap can't create a new BDI, it will
> set s_bdi back to the old one and move on.  You'll get degraded
> performance, but that's not the end of the world.

I was thinking from the user POV, I'd rather the whole mount fail
(which it seems like would only be a transient failure, eg running out
of memory) and I retry, than it work but have writes potentially run
10x slower (10x comes from the benchmarks Jingbo saw in [1])
>
> > strictlimiting enforced, especially since large folios will be enabled
> > for fuse iomap. [1] has some numbers for the performance degradations
> > I saw for writes with strictlimiting on and large folios enabled.
>
> If fuse_bdi_init can't set up a bdi it will fail the mount.
>
> That said... from reading [1], if strictlimiting is enabled with large
> folios, then can we figure out what is the effective max folio size and
> lower it to that?

I'm not really sure how we figure that out, unless I guess we try to
do it experimentally? The throttling logic for this is in
balance_dirty_pages().

>
> > Speaking of strictlimiting though, from a policy standpoint if we
> > think strictlimiting is needed in general in fuse (there's a thread
> > from last year [1] about removing strict limiting), then I think that
>
> (did you mean [2] here?)

Ah yes sorry, I had meant [2].
>
> > would need to apply to iomap as well, at least for unprivileged
> > servers.
>
> iomap requires a privileged server, FWIW.

Oh right, I forgot iomap only runs with privileges enabled. In that
case, I think that makes the whole strictlimiting thing a lot simpler
then. imo for privileged servers, we should get rid of strictlimiting
entirely. Though I'm not sure how MIklos feels about that.

Thanks,
Joanne

>
> > [1] https://lore.kernel.org/linux-fsdevel/CAJnrk1bwat_r4+pmhaWH-ThAi+zo=
AJFwmJG65ANj1Zv0O0s4_A@mail.gmail.com/
> > [2] https://lore.kernel.org/linux-fsdevel/20251010150113.GC6174@frogsfr=
ogsfrogs/T/#ma34ff5ae338a83f8b2e946d7e5332ea835fa0ff6
> >
> > >
> > > > This is more of a nit, but I think it'd also be nice if we
> > > > swapped the ordering of this patch with the previous one enabling
> > > > large folios, so that large folios gets enabled only when all the b=
di
> > > > stuff for it is ready.
> > >
> > > Will do, thanks for reading these patches!
> > >
> > > Also note that I've changed this part of the patchset quite a lot sin=
ce
> > > this posting; iomap configuration is now a completely separate fuse
> > > command that gets triggered after the FUSE_INIT reply is received.
> >
> > Great, I'll look at your upstream tree then for this part.
>
> Ok.
>
> --D
>
> > Thanks,
> > Joanne
> >
> > >
> > > --D
> > >
> > > > Thanks,
> > > > Joanne
> > > >
> > > > >
> > > > >         /*
> > > > >          * Enable syncfs for iomap fuse servers so that we can se=
nd a final
> > > > >
> > > >
> >

