Return-Path: <linux-fsdevel+bounces-74682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMjqD2iub2k7GgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 17:33:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B502947A56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 17:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A5029CB236
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 15:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8AF47CC65;
	Tue, 20 Jan 2026 15:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wf9H/ICM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E69453489
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921979; cv=pass; b=IfIYJYnPgSlaSA469zUd4ATKnz4MQnAPQ1lD2x5bHYVkZCo4xB5zMZNb1ihWqrc52wveGxMgmyjikxV51Pkfn/myI9o2hgCO+HXRrOh5dDuz6Pbsj2Knq5Sb0YQ777pN3ULUeJS4PzLcV5loznOT7OZsBITuoWxpoSml5SLyz7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921979; c=relaxed/simple;
	bh=Xnjuhtir64eVTIEfdUmhiDcTr/ARUdXCTWH26MCgUOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kyNVaNtMwYDqfNDXdqe0PH5oXP3XI6aUTMiYkvg0Vpm8/CUUe83qWinvY6wK5wsQQgHHjJCf2xIUoV+zW2kzk2BzEDke2Scs4Qb/PhZzZ4WlYcBMxsDNVMS5eyiqvdLPPdosUk44HzbeA+osaaskdh5EsYAcgQhGzBTkS5ppkbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wf9H/ICM; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b87677a8abeso895393566b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 07:12:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768921975; cv=none;
        d=google.com; s=arc-20240605;
        b=cNNO8V4UlDiyij7J+LQD9z38S7ZdstT3X2c7ea7px523EAChrrXSwi29Y9TgOUN4rw
         BnzbHpwiTuLPvFDtBDjdLhBD0X4/LzG6HLIoLXob8oCU+ae8gbO7JPclLtKTBSCf+DMn
         cnQHXI6F8vWi7K+BO9+W6yrmEv0x8F4Flv92AiYgKzbTny1lnOlu1+sgTl3WDTHCDbs+
         zIIuQO1NKGhZjue7zVBr4Dsq4Vob2GCEHOOMrph6wFVBbkBr+hfT98D1kFGlj4TXSuol
         qmOkpQgF8WaGyTiMYQDFAVhtOZ3m9pRkXxl5KYm1o0NPDqcs+4hwFPhYPkkOfWmY6o1e
         EqBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rp3Cco0V7YWfsBRnrN7YWiXeWxd2p0Ss5nTS/91MVtk=;
        fh=m8a5hjTq3BZIa9TpZ8twRCJWmaUlSpkaQiq3pOW1Ybk=;
        b=km0Ca5Vbl0mRp4vLJoH5AbhjTOBgveFFG6WNwIZQZHpJ+xY10Zqe7bKE7PCeX0Nshx
         vBQH8PnNFJsT5ZtMQ20Avg/5IzWuvmVgOLFT35PFNlRgx8JKPVLKoNwuoHYH7nh3zTQs
         Qzfa/BLU7qzYxjniCeCjuGwDMzmbRMUEAbEGSPdwiD330Dcpq8jrAFBHZNnxd2vUpdfX
         8DLhxGUSkbGxaewxt8P84djacZWyuVkVHx5kxxMGW4r2eQkhzJCpCoYeDFLqopnuF+g3
         J9F+06i0Aam/GvYv1wJypyUEh1CzEGwicB1t6rg0YzhzPikJgqDvS6qYyK2Hd7d5ccwT
         Wbjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768921975; x=1769526775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rp3Cco0V7YWfsBRnrN7YWiXeWxd2p0Ss5nTS/91MVtk=;
        b=Wf9H/ICMG/H9XmWjFGBJVy+WoCGIsBR+YwbkyuZq8rtMe0BdUguFDH98FrE5iYUD9F
         +F3KgChkA5F5EmGdD3RSSI/qh/z5wsNFxTK6gDkb09/dVJS7yJ/JT0g9KeQSJ3r9ayRd
         2Dsk8Kmh2qrXd6ip//1wleiPePY2NPHxaW1LNS90/p/z2GqHJ5wQEj4GLpEQaomK+iSY
         gOLCPfXwccmH4V5JGp2xXtpnJtmzoqCEyPJROemcc+Gmi1m+pJ0n4B3C8jdwTQkhSXEo
         RyCChFmSgVzGIgzI6RFIiH88JzqB4VoD1/dRz32ysqBPyiPguE08hGHdNtfoHzDcDq2K
         p9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768921975; x=1769526775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rp3Cco0V7YWfsBRnrN7YWiXeWxd2p0Ss5nTS/91MVtk=;
        b=OwjZOo8sAhny+5DtXpzKL4Dtz2BknABbWZQ7lMl+G7PeoiwkMalIqlucfWjW0cBMwE
         xay324yrAwSBO94l8nI+zJYNE0gmIo/+6USZ1/q5Iya8TPG2noeccHj3Ydg26MIYDLOL
         QxELJVjpOJ/W3TgHOTvdthZaqpLyPZMkGDX13AuDj26Hl5GyqlnP92ZccbrdlQUYBEnI
         ZD/i1YtkaxdDOzctlk75hceTk8sK6pY9KtgTzxAOKtjxMiOe3gobFhFMpY2oPLkkRxfj
         RNt5wgx7PoEXMBsH+S7KsSVvEnZeD1IJ6wTmq1oIS6a7H5l1jkDKiuCyuW5Y35dUIN9i
         qgKg==
X-Forwarded-Encrypted: i=1; AJvYcCU8Df+78C5hKIGHssrqtWTjBO5kz7TW6bTHKi1hL3aAqRsWJSQrP6+tySh3abhOB6OS//khFP2YnGz0vpLo@vger.kernel.org
X-Gm-Message-State: AOJu0YzoCBWYzpQAfjaCDIYIhBDr6+HwLpg13I/3TlIym7tH4WvKm1gZ
	ecLvaOzwoeobD1/zVLATIZ3XdSXsDLAhjixR1P/cOtpnmq0XE+pQp5RWOcdfvSc2vYJ/Ll84eel
	r+WqOYbaSOO7insKsf0CBhzPjvN8cJdQ=
X-Gm-Gg: AZuq6aIe341NU5e/+wrKy19qPLFRwIL4NrnDqgJ/VDlaoweppv+cUz8CAUf21+zTyMd
	c075FuNfULjguVXcXjZfHOA+yVys85cHqYBIw7bqfCmc1tV0/5qfq9C/I+w8VK0KbwBB5c+ZW47
	9gBK//XothFhQl7wmcjB1G7vQnTEInvJqRzik0r1KafAKrkUDA4i1u6orYHYp7yQp/6ztqVJGCs
	jWoqtg6FOGXJZ5yXrHOgGbaj/EfcNLxuyhcG2ASWSsr8gnG2ChqmXxGy9i23C9iASqJ6vJmiMxL
	o8CwbCS/SO27uJ4Z31cieZg+pG0TPg==
X-Received: by 2002:a17:907:7b9a:b0:b87:115:a724 with SMTP id
 a640c23a62f3a-b879324398bmr1329515266b.34.1768921974511; Tue, 20 Jan 2026
 07:12:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com>
 <20260114-tonyk-get_disk_uuid-v1-3-e6a319e25d57@igalia.com>
 <20260114062608.GB10805@lst.de> <5334ebc6-ceee-4262-b477-6b161c5ca704@igalia.com>
 <20260115062944.GA9590@lst.de> <633bb5f3-4582-416c-b8b9-fd1f3b3452ab@suse.com>
 <20260115072311.GA10352@lst.de> <22b16e24-d10e-43f6-bc2b-eeaa94310e3a@igalia.com>
 <CAOQ4uxhbz7=XT=C3R8XqL0K_o7KwLKsoNwgk=qJGuw2375MTJw@mail.gmail.com>
 <0241e2c4-bf11-4372-9eda-cccaba4a6d7d@igalia.com> <CAOQ4uxi988PutUi=Owm5zf6NaCm90PUCJLu7dw8firH8305w-A@mail.gmail.com>
 <33c1ccbd-abbe-4278-8ab1-d7d645c8b6e8@igalia.com> <CAOQ4uxgCM=q29Vs+35y-2K9k7GP2A2NfPkuqCrUiMUHW+KhbWw@mail.gmail.com>
 <75a9247a-12f4-4066-9712-c70ab41c274f@igalia.com>
In-Reply-To: <75a9247a-12f4-4066-9712-c70ab41c274f@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 20 Jan 2026 16:12:41 +0100
X-Gm-Features: AZwV_QghbBNAoP8paOdiNoqpwmmKM3bWt4If2fMAFv5l9zx2CG_D1s9roNDQ-Gs
Message-ID: <CAOQ4uxig==FAd=2hO0B_CVBDSuBwdqL-zaXkpf-QXn5iEL364g@mail.gmail.com>
Subject: Re: [PATCH 3/3] ovl: Use real disk UUID for origin file handles
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Carlos Maiolino <cem@kernel.org>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	kernel-dev@igalia.com, vivek@collabora.com, 
	Ludovico de Nittis <ludovico.denittis@collabora.com>
Content-Type: multipart/mixed; boundary="000000000000edabef0648d33d95"
X-Spamd-Result: default: False [-0.86 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-74682-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,virtuozzo.com:email,igalia.com:email]
X-Rspamd-Queue-Id: B502947A56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000edabef0648d33d95
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 5:56=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Em 16/01/2026 14:06, Amir Goldstein escreveu:
> > On Fri, Jan 16, 2026 at 2:28=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid=
@igalia.com> wrote:
> >>
> >> [+CC SteamOS developers]
> >>
> >> Em 16/01/2026 06:55, Amir Goldstein escreveu:
> >>> On Thu, Jan 15, 2026 at 7:55=E2=80=AFPM Andr=C3=A9 Almeida <andrealme=
id@igalia.com> wrote:
> >>>>
> >>>> Em 15/01/2026 13:07, Amir Goldstein escreveu:
> >>>>> On Thu, Jan 15, 2026 at 4:42=E2=80=AFPM Andr=C3=A9 Almeida <andreal=
meid@igalia.com> wrote:
> >>>>>>
> >>>>>> Em 15/01/2026 04:23, Christoph Hellwig escreveu:
> >>>>>>
> >>>>>> [...]
> >>>>>>
> >>>>>>>
> >>>>>>> I still wonder what the use case is here.  Looking at Andr=C3=A9'=
s original
> >>>>>>> mail it states:
> >>>>>>>
> >>>>>>> "However, btrfs mounts may have volatiles UUIDs. When mounting th=
e exact same
> >>>>>>> disk image with btrfs, a random UUID is assigned for the followin=
g disks each
> >>>>>>> time they are mounted, stored at temp_fsid and used across the ke=
rnel as the
> >>>>>>> disk UUID. `btrfs filesystem show` presents that. Calling statfs(=
) however
> >>>>>>> shows the original (and duplicated) UUID for all disks."
> >>>>>>>
> >>>>>>> and this doesn't even talk about multiple mounts, but looking at
> >>>>>>> device_list_add it seems to only set the temp_fsid flag when set
> >>>>>>> same_fsid_diff_dev is set by find_fsid_by_device, which isn't doc=
umented
> >>>>>>> well, but does indeed seem to be done transparently when two file=
 systems
> >>>>>>> with the same fsid are mounted.
> >>>>>>>
> >>>>>>> So Andr=C3=A9, can you confirm this what you're worried about?  A=
nd btrfs
> >>>>>>> developers, I think the main problem is indeed that btrfs simply =
allows
> >>>>>>> mounting the same fsid twice.  Which is really fatal for anything=
 using
> >>>>>>> the fsid/uuid, such NFS exports, mount by fs uuid or any sb->s_uu=
id user.
> >>>>>>>
> >>>>>>
> >>>>>> Yes, I'm would like to be able to mount two cloned btrfs images an=
d to
> >>>>>> use overlayfs with them. This is useful for SteamOS A/B partition =
scheme.
> >>>>>>
> >>>>>>>> If so, I think it's time to revert the behavior before it's too =
late.
> >>>>>>>> Currently the main usage of such duplicated fsids is for Steam d=
eck to
> >>>>>>>> maintain A/B partitions, I think they can accept a new compat_ro=
 flag for
> >>>>>>>> that.
> >>>>>>>
> >>>>>>> What's an A/B partition?  And how are these safely used at the sa=
me time?
> >>>>>>>
> >>>>>>
> >>>>>> The Steam Deck have two main partitions to install SteamOS updates
> >>>>>> atomically. When you want to update the device, assuming that you =
are
> >>>>>> using partition A, the updater will write the new image in partiti=
on B,
> >>>>>> and vice versa. Then after the reboot, the system will mount the n=
ew
> >>>>>> image on B.
> >>>>>>
> >>>>>
> >>>>> And what do you expect to happen wrt overlayfs when switching from
> >>>>> image A to B?
> >>>>>
> >>>>> What are the origin file handles recorded in overlayfs index from i=
mage A
> >>>>> lower worth when the lower image is B?
> >>>>>
> >>>>> Is there any guarantee that file handles are relevant and point to =
the
> >>>>> same objects?
> >>>>>
> >>>>> The whole point of the overlayfs index feature is that overlayfs in=
odes
> >>>>> can have a unique id across copy-up.
> >>>>>
> >>>>> Please explain in more details exactly which overlayfs setup you ar=
e
> >>>>> trying to do with index feature.
> >>>>>
> >>>>
> >>>> The problem happens _before_ switching from A to B, it happens when
> >>>> trying to install the same image from A on B.
> >>>>
> >>>> During the image installation process, while running in A, the B ima=
ge
> >>>> will be mounted more than once for some setup steps, and overlayfs i=
s
> >>>> used for this. Because A have the same UUID, each time B is remouted
> >>>> will get a new UUID and then the installation scripts fails mounting=
 the
> >>>> image.
> >>>
> >>> Please describe the exact overlayfs setup and specifically,
> >>> is it multi lower or single lower layer setup?
> >>> What reason do you need the overlayfs index for?
> >>> Can you mount with index=3Doff which should relax the hard
> >>> requirement for match with the original lower layer uuid.
> >>>
> >>
> >> The setup has a single lower layer. This is how the mount command look=
s
> >> like:
> >>
> >> mount -t overlay -o
> >> "lowerdir=3D${DEV_DIR}/etc,upperdir=3D${DEV_DIR}/var/lib/overlays/etc/=
upper,workdir=3D${DEV_DIR}/var/lib/overlays/etc/work"
> >> none "${DEV_DIR}/etc"
> >>
> >> They would rather not disable index, to avoid mounting the wrong layer=
s
> >> and to avoid corner cases with hardlinks.
> >
> > IIUC you have all the layers on the same fs ($DEV_DIR)?
> >
> > See mount option uuid=3Doff, created for this exact use case:
> >
> > Documentation/filesystems/overlayfs.rst:
> > Note: the mount option uuid=3Doff can be used to replace UUID of the un=
derlying
> > filesystem in file handles with null, and effectively disable UUID chec=
ks. This
> > can be useful in case the underlying disk is copied and the UUID of thi=
s copy
> > is changed. This is only applicable if all lower/upper/work directories=
 are on
> > the same filesystem, otherwise it will fallback to normal behaviour.
> >
> > commit 5830fb6b54f7167cc7c9d43612eb01c24312c7ca
> > Author: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> > Date:   Tue Oct 13 17:59:54 2020 +0300
> >
> >      ovl: introduce new "uuid=3Doff" option for inodes index feature
> >
> >      This replaces uuid with null in overlayfs file handles and thus re=
laxes
> >      uuid checks for overlay index feature. It is only possible in case=
 there is
> >      only one filesystem for all the work/upper/lower directories and b=
are file
> >      handles from this backing filesystem are unique. In other case whe=
n we have
> >      multiple filesystems lets just fallback to "uuid=3Don" which is an=
d
> >      equivalent of how it worked before with all uuid checks.
> >
> >      This is needed when overlayfs is/was mounted in a container with i=
ndex
> >      enabled ...
> >
> >      If you just change the uuid of the backing filesystem, overlay is =
not
> >      mounting any more. In Virtuozzo we copy container disks (ploops) w=
hen
> >      create the copy of container and we require fs uuid to be unique f=
or a new
> >      container.
> >
> > TBH, I am trying to remember why we require upper/work to be on the
> > same fs as lower for uuid=3Doff,index=3Don and I can't remember.
> > If this is important I can look into it.
> >
>
> Actually they are not in the same fs, upper and lower are coming from
> different fs', so when trying to mount I get the fallback to
> `uuid=3Dnull`. A quick hack circumventing this check makes the mount work=
.
>
> If you think this is the best way to solve this issue (rather than
> following the VFS helper path for instance),

That's up to you if you want to solve the "all lower layers on same fs"
or want to also allow lower layers on different fs.
The former could be solved by relaxing the ovl rules.

> please let me know how can
> I safely lift this restriction, like maybe adding a new flag for this?

I think the attached patch should work for you and should not
break anything.

It's only sanity tested and will need to write tests to verify it.

Thanks,
Amir.

--000000000000edabef0648d33d95
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-ovl-relax-requirement-for-uuid-off-index-on.patch"
Content-Disposition: attachment; 
	filename="0001-ovl-relax-requirement-for-uuid-off-index-on.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mkmqeux30>
X-Attachment-Id: f_mkmqeux30

RnJvbSAxNDdlODhkODhiNWRmYmNkZDIzYWZmNzM2ZTRkMzgxYThhZjQ0NmY2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBUdWUsIDIwIEphbiAyMDI2IDE1OjU4OjMxICswMTAwClN1YmplY3Q6IFtQQVRDSF0gb3Zs
OiByZWxheCByZXF1aXJlbWVudCBmb3IgdXVpZD1vZmYsaW5kZXg9b24KCnV1aWQ9b2ZmLGluZGV4
PW9uIHJlcXVpcmVkIHRoYXQgYWxsIHVwcGVyL2xvd2VyIGRpcmVjdG9yaWVzIGFyZSBvbiB0aGUK
c2FtZSBmaWxlc3lzdGVtLgoKUmVsYXggdGhlIHJlcXVpcmVtZW50IHNvIHRoYXQgb25seSBhbGwg
dGhlIGxvd2VyIGRpcmVjdG9yaWVzIG5lZWQgdG8gYmUKb24gdGhlIHNhbWUgZmlsZXN5c3RlbS4K
ClNpZ25lZC1vZmYtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+Ci0tLQog
RG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9vdmVybGF5ZnMucnN0IHwgIDIgKy0KIGZzL292ZXJs
YXlmcy9uYW1laS5jICAgICAgICAgICAgICAgICAgICB8IDIxICsrKysrKysrKysrKystLS0tLS0t
LQogZnMvb3ZlcmxheWZzL292ZXJsYXlmcy5oICAgICAgICAgICAgICAgIHwgIDIgKysKIGZzL292
ZXJsYXlmcy9zdXBlci5jICAgICAgICAgICAgICAgICAgICB8IDEzICsrKysrLS0tLS0tLS0KIDQg
ZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9vdmVybGF5ZnMucnN0IGIvRG9jdW1lbnRh
dGlvbi9maWxlc3lzdGVtcy9vdmVybGF5ZnMucnN0CmluZGV4IGFiOTg5ODA3YTJjYjYuLmQ0MDIw
ZWFlMWRlYmEgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMvb3ZlcmxheWZz
LnJzdAorKysgYi9Eb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL292ZXJsYXlmcy5yc3QKQEAgLTc1
NSw3ICs3NTUsNyBAQCByZWFkLXdyaXRlIG1vdW50IGFuZCB3aWxsIHJlc3VsdCBpbiBhbiBlcnJv
ci4KIE5vdGU6IHRoZSBtb3VudCBvcHRpb24gdXVpZD1vZmYgY2FuIGJlIHVzZWQgdG8gcmVwbGFj
ZSBVVUlEIG9mIHRoZSB1bmRlcmx5aW5nCiBmaWxlc3lzdGVtIGluIGZpbGUgaGFuZGxlcyB3aXRo
IG51bGwsIGFuZCBlZmZlY3RpdmVseSBkaXNhYmxlIFVVSUQgY2hlY2tzLiBUaGlzCiBjYW4gYmUg
dXNlZnVsIGluIGNhc2UgdGhlIHVuZGVybHlpbmcgZGlzayBpcyBjb3BpZWQgYW5kIHRoZSBVVUlE
IG9mIHRoaXMgY29weQotaXMgY2hhbmdlZC4gVGhpcyBpcyBvbmx5IGFwcGxpY2FibGUgaWYgYWxs
IGxvd2VyL3VwcGVyL3dvcmsgZGlyZWN0b3JpZXMgYXJlIG9uCitpcyBjaGFuZ2VkLiBUaGlzIGlz
IG9ubHkgYXBwbGljYWJsZSBpZiBhbGwgbG93ZXIgZGlyZWN0b3JpZXMgYXJlIG9uCiB0aGUgc2Ft
ZSBmaWxlc3lzdGVtLCBvdGhlcndpc2UgaXQgd2lsbCBmYWxsYmFjayB0byBub3JtYWwgYmVoYXZp
b3VyLgogCiAKZGlmZiAtLWdpdCBhL2ZzL292ZXJsYXlmcy9uYW1laS5jIGIvZnMvb3ZlcmxheWZz
L25hbWVpLmMKaW5kZXggZTlhNjljOTViZTkxOC4uNzRjNTE0NjAzYWMyMyAxMDA2NDQKLS0tIGEv
ZnMvb3ZlcmxheWZzL25hbWVpLmMKKysrIGIvZnMvb3ZlcmxheWZzL25hbWVpLmMKQEAgLTE1OCw2
ICsxNTgsMTggQEAgc3RhdGljIHN0cnVjdCBvdmxfZmggKm92bF9nZXRfZmgoc3RydWN0IG92bF9m
cyAqb2ZzLCBzdHJ1Y3QgZGVudHJ5ICp1cHBlcmRlbnRyeSwKIAlnb3RvIG91dDsKIH0KIAorYm9v
bCBvdmxfdXVpZF9tYXRjaChzdHJ1Y3Qgb3ZsX2ZzICpvZnMsIGNvbnN0IHN0cnVjdCBzdXBlcl9i
bG9jayAqc2IsCisJCSAgICBjb25zdCB1dWlkX3QgKnV1aWQpCit7CisJLyoKKwkgKiBNYWtlIHN1
cmUgdGhhdCB0aGUgc3RvcmVkIHV1aWQgbWF0Y2hlcyB0aGUgdXVpZCBvZiB0aGUgbG93ZXIKKwkg
KiBsYXllciB3aGVyZSBmaWxlIGhhbmRsZSB3aWxsIGJlIGRlY29kZWQuCisJICogSW4gY2FzZSBv
ZiB1dWlkPW9mZiBvcHRpb24ganVzdCBtYWtlIHN1cmUgdGhhdCBzdG9yZWQgdXVpZCBpcyBudWxs
LgorCSAqLworCXJldHVybiBvdmxfb3JpZ2luX3V1aWQob2ZzKSA/IHV1aWRfZXF1YWwodXVpZCwg
JnNiLT5zX3V1aWQpIDoKKwkJCQkgICAgICB1dWlkX2lzX251bGwodXVpZCk7Cit9CisKIHN0cnVj
dCBkZW50cnkgKm92bF9kZWNvZGVfcmVhbF9maChzdHJ1Y3Qgb3ZsX2ZzICpvZnMsIHN0cnVjdCBv
dmxfZmggKmZoLAogCQkJCSAgc3RydWN0IHZmc21vdW50ICptbnQsIGJvb2wgY29ubmVjdGVkKQog
ewpAQCAtMTY3LDE0ICsxNzksNyBAQCBzdHJ1Y3QgZGVudHJ5ICpvdmxfZGVjb2RlX3JlYWxfZmgo
c3RydWN0IG92bF9mcyAqb2ZzLCBzdHJ1Y3Qgb3ZsX2ZoICpmaCwKIAlpZiAoIWNhcGFibGUoQ0FQ
X0RBQ19SRUFEX1NFQVJDSCkpCiAJCXJldHVybiBOVUxMOwogCi0JLyoKLQkgKiBNYWtlIHN1cmUg
dGhhdCB0aGUgc3RvcmVkIHV1aWQgbWF0Y2hlcyB0aGUgdXVpZCBvZiB0aGUgbG93ZXIKLQkgKiBs
YXllciB3aGVyZSBmaWxlIGhhbmRsZSB3aWxsIGJlIGRlY29kZWQuCi0JICogSW4gY2FzZSBvZiB1
dWlkPW9mZiBvcHRpb24ganVzdCBtYWtlIHN1cmUgdGhhdCBzdG9yZWQgdXVpZCBpcyBudWxsLgot
CSAqLwotCWlmIChvdmxfb3JpZ2luX3V1aWQob2ZzKSA/Ci0JICAgICF1dWlkX2VxdWFsKCZmaC0+
ZmIudXVpZCwgJm1udC0+bW50X3NiLT5zX3V1aWQpIDoKLQkgICAgIXV1aWRfaXNfbnVsbCgmZmgt
PmZiLnV1aWQpKQorCWlmICghb3ZsX3V1aWRfbWF0Y2gob2ZzLCBtbnQtPm1udF9zYiwgJmZoLT5m
Yi51dWlkKSkKIAkJcmV0dXJuIE5VTEw7CiAKIAlieXRlcyA9IChmaC0+ZmIubGVuIC0gb2Zmc2V0
b2Yoc3RydWN0IG92bF9mYiwgZmlkKSk7CmRpZmYgLS1naXQgYS9mcy9vdmVybGF5ZnMvb3Zlcmxh
eWZzLmggYi9mcy9vdmVybGF5ZnMvb3ZlcmxheWZzLmgKaW5kZXggZjlhYzliZGRlODMwNS4uY2Yx
MDY2MTUyMjEwNiAxMDA2NDQKLS0tIGEvZnMvb3ZlcmxheWZzL292ZXJsYXlmcy5oCisrKyBiL2Zz
L292ZXJsYXlmcy9vdmVybGF5ZnMuaApAQCAtNzEwLDYgKzcxMCw4IEBAIHN0YXRpYyBpbmxpbmUg
aW50IG92bF9jaGVja19maF9sZW4oc3RydWN0IG92bF9maCAqZmgsIGludCBmaF9sZW4pCiAJcmV0
dXJuIG92bF9jaGVja19mYl9sZW4oJmZoLT5mYiwgZmhfbGVuIC0gT1ZMX0ZIX1dJUkVfT0ZGU0VU
KTsKIH0KIAorYm9vbCBvdmxfdXVpZF9tYXRjaChzdHJ1Y3Qgb3ZsX2ZzICpvZnMsIGNvbnN0IHN0
cnVjdCBzdXBlcl9ibG9jayAqc2IsCisJCSAgICBjb25zdCB1dWlkX3QgKnV1aWQpOwogc3RydWN0
IGRlbnRyeSAqb3ZsX2RlY29kZV9yZWFsX2ZoKHN0cnVjdCBvdmxfZnMgKm9mcywgc3RydWN0IG92
bF9maCAqZmgsCiAJCQkJICBzdHJ1Y3QgdmZzbW91bnQgKm1udCwgYm9vbCBjb25uZWN0ZWQpOwog
aW50IG92bF9jaGVja19vcmlnaW5fZmgoc3RydWN0IG92bF9mcyAqb2ZzLCBzdHJ1Y3Qgb3ZsX2Zo
ICpmaCwgYm9vbCBjb25uZWN0ZWQsCmRpZmYgLS1naXQgYS9mcy9vdmVybGF5ZnMvc3VwZXIuYyBi
L2ZzL292ZXJsYXlmcy9zdXBlci5jCmluZGV4IGJhOTE0NmYyMmEyY2MuLjhmMGVjYjQ5MDVlOTMg
MTAwNjQ0Ci0tLSBhL2ZzL292ZXJsYXlmcy9zdXBlci5jCisrKyBiL2ZzL292ZXJsYXlmcy9zdXBl
ci5jCkBAIC05NDAsNyArOTQwLDcgQEAgc3RhdGljIGJvb2wgb3ZsX2xvd2VyX3V1aWRfb2soc3Ry
dWN0IG92bF9mcyAqb2ZzLCBjb25zdCB1dWlkX3QgKnV1aWQpCiAJCSAqIGRpc2FibGUgbG93ZXIg
ZmlsZSBoYW5kbGUgZGVjb2Rpbmcgb24gYWxsIG9mIHRoZW0uCiAJCSAqLwogCQlpZiAob2ZzLT5m
c1tpXS5pc19sb3dlciAmJgotCQkgICAgdXVpZF9lcXVhbCgmb2ZzLT5mc1tpXS5zYi0+c191dWlk
LCB1dWlkKSkgeworCQkgICAgb3ZsX3V1aWRfbWF0Y2gob2ZzLCBvZnMtPmZzW2ldLnNiLCB1dWlk
KSkgewogCQkJb2ZzLT5mc1tpXS5iYWRfdXVpZCA9IHRydWU7CiAJCQlyZXR1cm4gZmFsc2U7CiAJ
CX0KQEAgLTk1Miw2ICs5NTIsNyBAQCBzdGF0aWMgYm9vbCBvdmxfbG93ZXJfdXVpZF9vayhzdHJ1
Y3Qgb3ZsX2ZzICpvZnMsIGNvbnN0IHV1aWRfdCAqdXVpZCkKIHN0YXRpYyBpbnQgb3ZsX2dldF9m
c2lkKHN0cnVjdCBvdmxfZnMgKm9mcywgY29uc3Qgc3RydWN0IHBhdGggKnBhdGgpCiB7CiAJc3Ry
dWN0IHN1cGVyX2Jsb2NrICpzYiA9IHBhdGgtPm1udC0+bW50X3NiOworCWNvbnN0IHV1aWRfdCAq
dXVpZCA9IG92bF9vcmlnaW5fdXVpZChvZnMpID8gJnNiLT5zX3V1aWQgOiAmdXVpZF9udWxsOwog
CXVuc2lnbmVkIGludCBpOwogCWRldl90IGRldjsKIAlpbnQgZXJyOwpAQCAtOTYzLDcgKzk2NCw3
IEBAIHN0YXRpYyBpbnQgb3ZsX2dldF9mc2lkKHN0cnVjdCBvdmxfZnMgKm9mcywgY29uc3Qgc3Ry
dWN0IHBhdGggKnBhdGgpCiAJCQlyZXR1cm4gaTsKIAl9CiAKLQlpZiAoIW92bF9sb3dlcl91dWlk
X29rKG9mcywgJnNiLT5zX3V1aWQpKSB7CisJaWYgKCFvdmxfbG93ZXJfdXVpZF9vayhvZnMsIHV1
aWQpKSB7CiAJCWJhZF91dWlkID0gdHJ1ZTsKIAkJaWYgKG9mcy0+Y29uZmlnLnhpbm8gPT0gT1ZM
X1hJTk9fQVVUTykgewogCQkJb2ZzLT5jb25maWcueGlubyA9IE9WTF9YSU5PX09GRjsKQEAgLTk3
Niw4ICs5NzcsNyBAQCBzdGF0aWMgaW50IG92bF9nZXRfZnNpZChzdHJ1Y3Qgb3ZsX2ZzICpvZnMs
IGNvbnN0IHN0cnVjdCBwYXRoICpwYXRoKQogCQl9CiAJCWlmICh3YXJuKSB7CiAJCQlwcl93YXJu
KCIlcyB1dWlkIGRldGVjdGVkIGluIGxvd2VyIGZzICclcGQyJywgZmFsbGluZyBiYWNrIHRvIHhp
bm89JXMsaW5kZXg9b2ZmLG5mc19leHBvcnQ9b2ZmLlxuIiwKLQkJCQl1dWlkX2lzX251bGwoJnNi
LT5zX3V1aWQpID8gIm51bGwiIDoKLQkJCQkJCQkgICAgImNvbmZsaWN0aW5nIiwKKwkJCQl1dWlk
X2lzX251bGwodXVpZCkgPyAibnVsbCIgOiAiY29uZmxpY3RpbmciLAogCQkJCXBhdGgtPmRlbnRy
eSwgb3ZsX3hpbm9fbW9kZSgmb2ZzLT5jb25maWcpKTsKIAkJfQogCX0KQEAgLTE0NjksMTAgKzE0
NjksNyBAQCBzdGF0aWMgaW50IG92bF9maWxsX3N1cGVyX2NyZWRzKHN0cnVjdCBmc19jb250ZXh0
ICpmYywgc3RydWN0IHN1cGVyX2Jsb2NrICpzYikKIAlpZiAoIW92bF91cHBlcl9tbnQob2ZzKSkK
IAkJc2ItPnNfZmxhZ3MgfD0gU0JfUkRPTkxZOwogCi0JaWYgKCFvdmxfb3JpZ2luX3V1aWQob2Zz
KSAmJiBvZnMtPm51bWZzID4gMSkgewotCQlwcl93YXJuKCJUaGUgdXVpZD1vZmYgcmVxdWlyZXMg
YSBzaW5nbGUgZnMgZm9yIGxvd2VyIGFuZCB1cHBlciwgZmFsbGluZyBiYWNrIHRvIHV1aWQ9bnVs
bC5cbiIpOwotCQlvZnMtPmNvbmZpZy51dWlkID0gT1ZMX1VVSURfTlVMTDsKLQl9IGVsc2UgaWYg
KG92bF9oYXNfZnNpZChvZnMpICYmIG92bF91cHBlcl9tbnQob2ZzKSkgeworCWlmIChvdmxfaGFz
X2ZzaWQob2ZzKSAmJiBvdmxfdXBwZXJfbW50KG9mcykpIHsKIAkJLyogVXNlIHBlciBpbnN0YW5j
ZSBwZXJzaXN0ZW50IHV1aWQvZnNpZCAqLwogCQlvdmxfaW5pdF91dWlkX3hhdHRyKHNiLCBvZnMs
ICZjdHgtPnVwcGVyKTsKIAl9Ci0tIAoyLjUyLjAKCg==
--000000000000edabef0648d33d95--

