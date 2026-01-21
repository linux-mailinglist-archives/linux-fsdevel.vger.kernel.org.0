Return-Path: <linux-fsdevel+bounces-74838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBMeAF+vcGmKZAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 11:50:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDD855829
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 11:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CDC1892247F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 10:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7F447CC6D;
	Wed, 21 Jan 2026 10:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKu3Y3MC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC07346FBC
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768991109; cv=pass; b=nA61sNBpBYPHUEIW0oLnXdvUjpdibu4cx7h5xCjY1ffv7tzEwpe6c6MJYoArmVFdFwDKeC2N+y8bkuVFm1P6irzKO/XxnzoD2zU/EdNqKAdQlnM/pSNbX9vml+JG867pxbRJQ90MM5YPJ1KQQSSR3vbLWMeh9v0SewIefYez8Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768991109; c=relaxed/simple;
	bh=l+ypYojp2fTRROqWBoXqJp773shvjCTjbb7obXqjHQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nm2CeQbhdY4ikuuZpaQCCboohllKg19eUCOPnB8kfo0Wb81HqwaC1WueoKtF43Oc89s9tcnkDFTSGk9ucZLoI7VAtQAyFGptovM+Oe+MWZyoBAmH0Ot7cO7Ie1d/KfhoFljjLHLN/FFUI6vyIPqCuKbEQ4K5NB3UXz92HsmGxOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKu3Y3MC; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65813e3bdaaso1452676a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 02:25:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768991099; cv=none;
        d=google.com; s=arc-20240605;
        b=UDCnV0jfV3tEgTRqvCd3rtxItzoJ8NFisagB7+kOTMX4Vus01w2zbB4auRjLbfMT8k
         RKJNDomj2qG2FNIP40ZbvoagySHsfkK92M/lJ3KNWXF7imVNvs/YoIRx4JW+kRVHiiT0
         GSTIPpyGJ3mOReOQ7rITJ9mrm0ptuYA+Kln9xoxiumS1vIseoUahP5XQ+0adwvPXXUON
         JdKqB7OrgtK64QssBt6ZsWpW1Jc1PZCBe92iZPfcfvrysG9r2xS9pT5b/ZXNn7tjuRwm
         o+ZHz3typZtkQpxnXq9D2hjAysp464lraXrWwlSHK+AEGhdH/Ng+9/ABxWymAXoRMqxu
         evWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ovBUsOmaeb6ZJMo2t0jZrkzimLFtOGYI9UIc20VRznc=;
        fh=vmpevJvJqGXzvj3hD8RMG8JPT33musJufNLqdbCp73o=;
        b=g1mqLD28udR0vGHn/ZGpuZyejgbAWUWK3uGGlC2s6p7e+3T0wvTfKfMdudjSn3rtYv
         XkAfHqaXKxRIMxU2rBnIEwV8KjuKhu4jt0sNYE8WTq9EN7Hs6Y0E5KJHggXhoi+i9X1O
         4KDk8h29XN6JLPTkA+F2ojnn/F+Om4ZbTxjEG4tnHN1jfuP0aPxfLVuSUZIJJZ8LnPqn
         j821rZC8n+hnhV9U+utY9xjX9AUjZkJmn2Ii22Hp+1Mg4i08h6BeTeHlsfwIbggfl8sc
         j57RVXC+ycTen7hTmKjjwoZrAZbf7RzWEkBHT5mkmJFJLwdWYPBeIbm3BvCT8H43l1fx
         mjnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768991099; x=1769595899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovBUsOmaeb6ZJMo2t0jZrkzimLFtOGYI9UIc20VRznc=;
        b=LKu3Y3MC0yp+O7tdqi46cy3pzG2zdUgjNIBTcrOIESjxFlyrFTomD7B9Muo6FWmyBH
         UlKcViykEKv4Arcinh4F0vIX9ta4gvBTOCYOj6iMtPzNY+MIJ/zgqoIcsjzjF1xQRnVP
         h3mDzg69q9qROfrLCGvXItckl9pxjDVWyXK5g26tZbwnLjYdnGiJ/h7B3xfJlWnGs0/K
         JZJNisA7vfN7et2hXyofqjryUlWHvQLaXC43VuDyG3qefcNa/OuExgA0QpYH9RV6y0EO
         tQXepFB7+v22eJHWQ7rEgl93sIMTWtWhiCqnFuQNP7Edh/K9Q9n4EojsVmexJyldqOTv
         KVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768991099; x=1769595899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ovBUsOmaeb6ZJMo2t0jZrkzimLFtOGYI9UIc20VRznc=;
        b=ErwBj+yg1c2riCQ1aG+eg+Wa0npVxVlsCF2R+dZOigIcqBRRCiRMHR0x+dmY5yfBqW
         HSOxHrLPElCCbUniwLXHNFFg6C2KT6iGFqJDfHMCgkmvyb27rTNczYckDpyj5CSlRef0
         ezW2hx4UHW9txX7xX83h9y/b/XNQygH/Ms0f+Ts5SlMpYuItkkKfrZ3+VDVGNCbAcN8m
         P1krtRQrGrjZfb40L3+hsjukbgj2pyhz5bip/vUDOmiZyVOYGIWNE2xLqXAeTvP9m2Ej
         lEPi7qn0c0fED4BVZJSWsw6XuZQC4bdNdxgCwz8Tin+tgukQO7Djm9xnDE2d825uWDXJ
         VlQA==
X-Forwarded-Encrypted: i=1; AJvYcCVlQltDG+FJJkljTF3H4eAfvdNiwbbjdS8zC87pGA0EpPS4yL5rsN4XccCVIAf1p7XA7D7V5broW+ShEWh5@vger.kernel.org
X-Gm-Message-State: AOJu0YzwKibZ4gw9GoOXDQ3K4cKdkJdsng1ijbiGJPey9LmHKp+ofMRL
	yTKiQqaS6AzPtSdr4Hs5n+08iMDvvhHbauCz6REpZwGkB/cA9IxevF2XWn17T+/Qurr7+xM33sT
	sFrppAP2MOh+gOXdr1WkhFXHjtt/6RmE=
X-Gm-Gg: AZuq6aIUvkqq4mrZXZ+S4UByPQ6uMRAW+O9oUdAaLLeHq1hf67/IH68r2MuW5mkCzcS
	yB8v+DlayA3xkueTsaA5DhS0AC64bWZa075T/8Y0CNz5Xvsk10jLZ4fPY7w5acJl/Ju94m9euec
	/Gti8edIFn3tvFIFybr/OM6JgRgLrNkjjfB0Zt1kEYIVHaq37V5U/YJMXBUTGYaiQnMgX0omMMq
	OvOypEsbUhPSzYN76pny5FX9pD/NFIXNMsUfP/A2Rvbl7lF/9PiXAmkU1i5KEwa3At0rCDscEDN
	CzXuhO1HtjJMY7dR88xGXYuSFKsXuA==
X-Received: by 2002:aa7:cf89:0:b0:64b:5771:8fbd with SMTP id
 4fb4d7f45d1cf-65412e2fe5amr13008885a12.5.1768991098311; Wed, 21 Jan 2026
 02:24:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121085028.558164-1-amir73il@gmail.com> <176898904083.16766.14818617047357377637@noble.neil.brown.name>
In-Reply-To: <176898904083.16766.14818617047357377637@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 21 Jan 2026 11:24:47 +0100
X-Gm-Features: AZwV_QgpxvSanSzskH1hhL28IJ79rUs7e2PvwrQjRcwQqzvlw-RIVAAYY9Wc3yQ
Message-ID: <CAOQ4uxiB=RAZEgTRqRvbCQ4e0FTc9WaTX2Z+T=YAYySaPUVHjQ@mail.gmail.com>
Subject: Re: [PATCH] nfsd: do not allow exporting of special kernel filesystems
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TAGGED_FROM(0.00)[bounces-74838-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,ownmail.net:email]
X-Rspamd-Queue-Id: 9CDD855829
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 10:50=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrot=
e:
>
> On Wed, 21 Jan 2026, Amir Goldstein wrote:
> > pidfs and nsfs recently gained support for encode/decode of file handle=
s
> > via name_to_handle_at(2)/opan_by_handle_at(2).
> >
> > These special kernel filesystems have custom ->open() and ->permission(=
)
> > export methods, which nfsd does not respect and it was never meant to b=
e
> > used for exporting those filesystems by nfsd.
> >
> > Therefore, do not allow nfsd to export filesystems with custom ->open()
> > or ->permission() methods.
> >
> > Fixes: b3caba8f7a34a ("pidfs: implement file handle support")
> > Fixes: 5222470b2fbb3 ("nsfs: support file handles")
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/nfsd/export.c | 21 +++++++++++++--------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
> >
> > Christian,
> >
> > I had enough of the stable file handles discussion [1].
> >
> > This patch which I already suggested [2] on week ago, states a justifie=
d
> > technical reason why pidfs and nsfs should not be exported by nfsd,
> > so let's use this technical reasoning and stop the philosophic discussi=
ons
> > about what is a stable file handle is please.
> >
> > Regarding cgroupfs, we can either deal with it later or not - it is not
> > a clear but as pidfs and nsfs which absolutely should be fixed
> > retroactively in stable kernels.
> >
> > If you think that cgroupfs could benefit from "exhaustive" file handles=
 [3]
> > then we can implement open_by_handle_at(FD_CGROUPFS_ROOT, ... and that
> > would classify cgroupfs the same as pidfs and nsfs.
> >
> > Thanks,
> > Amir.
> >
> > [1] https://lore.kernel.org/linux-fsdevel/20250912-work-namespace-v2-0-=
1a247645cef5@kernel.org/
> > [2] https://lore.kernel.org/linux-fsdevel/CAOQ4uxhkaGFtQRzTj2xaf2GJucoA=
Y5CGiyUjB=3D8YA2zTbOtFvw@mail.gmail.com/
> > [3] https://lore.kernel.org/linux-fsdevel/20250912-work-namespace-v2-29=
-1a247645cef5@kernel.org/
> >
> > diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> > index 2a1499f2ad196..232dacac611e9 100644
> > --- a/fs/nfsd/export.c
> > +++ b/fs/nfsd/export.c
> > @@ -405,6 +405,7 @@ static struct svc_export *svc_export_lookup(struct =
svc_export *);
> >  static int check_export(const struct path *path, int *flags, unsigned =
char *uuid)
> >  {
> >       struct inode *inode =3D d_inode(path->dentry);
> > +     const struct export_operations *nop =3D inode->i_sb->s_export_op;
> >
> >       /*
> >        * We currently export only dirs, regular files, and (for v4
> > @@ -422,13 +423,12 @@ static int check_export(const struct path *path, =
int *flags, unsigned char *uuid
> >       if (*flags & NFSEXP_V4ROOT)
> >               *flags |=3D NFSEXP_READONLY;
> >
> > -     /* There are two requirements on a filesystem to be exportable.
> > -      * 1:  We must be able to identify the filesystem from a number.
> > -      *       either a device number (so FS_REQUIRES_DEV needed)
> > -      *       or an FSID number (so NFSEXP_FSID or ->uuid is needed).
> > -      * 2:  We must be able to find an inode from a filehandle.
> > -      *       This means that s_export_op must be set.
> > -      * 3: We must not currently be on an idmapped mount.
> > +     /*
> > +      * The requirements for a filesystem to be exportable:
> > +      * 1. The filehandle must identify a filesystem by number
> > +      * 2. The filehandle must uniquely identify an inode
> > +      * 3. The filesystem must not have custom filehandle open/perm me=
thods
> > +      * 4. The requested file must not reside on an idmapped mount
> >        */
> >       if (!(inode->i_sb->s_type->fs_flags & FS_REQUIRES_DEV) &&
> >           !(*flags & NFSEXP_FSID) &&
> > @@ -437,11 +437,16 @@ static int check_export(const struct path *path, =
int *flags, unsigned char *uuid
> >               return -EINVAL;
> >       }
> >
> > -     if (!exportfs_can_decode_fh(inode->i_sb->s_export_op)) {
> > +     if (!exportfs_can_decode_fh(nop)) {
> >               dprintk("exp_export: export of invalid fs type.\n");
> >               return -EINVAL;
> >       }
> >
> > +     if (nop->open || nop->permission) {
> > +             dprintk("exp_export: export of non-standard fs type.\n");
> > +             return -EINVAL;
> > +     }
> > +
>
> It is not immediately obvious that this is safe when nop is NULL, but it
> is because exportfs_can_decode_fh() checks for that case.  As that is a
> static inline a static analyser can easily confirm this.  So it is
> probably OK.

Heh, in the RFC patch [1], I had those conditions wrapped in a helper
just below exportfs_can_decode_fh(), so this was more clear, but now
I tried to avoid adding a helper named exportfs_may_nfs_export()... ;)

>
> "non-standard" is not totally clear.  "special" might be better, or it
> might not.  It is only a dprintk so it probably doesn't matter much.
>

In said RFC patch it was using the same dprinkt() ("invalid fs type")
I am not sure that the distinction to two different classes is important.
printing the fstype->name, either with dprintk() or trace point would
be much more valuable IMO.

But Jeff has a patch to convert dprink() to trace point, so I will gladly
leave those decisions for him.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxhkaGFtQRzTj2xaf2GJucoAY5CG=
iyUjB=3D8YA2zTbOtFvw@mail.gmail.com/

