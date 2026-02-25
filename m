Return-Path: <linux-fsdevel+bounces-78400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFf5OEdun2mZbwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 22:48:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D5819E041
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 22:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27C083020035
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 21:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDDC319608;
	Wed, 25 Feb 2026 21:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DcXnIIPe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AFB317701
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 21:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772055828; cv=pass; b=l5o5z4lEzv0550OQmqnPgHTEUtKUmWl1kCeVq03qguDmfpJJs1pewTl/fYvWpunY2C9PyQ2j30WUCbWydJeJ33XW57Wy8tIQECl1S2P+ewKyX72yc/7aupheZ8sJGuE1KNUImzgZuAwEn68EaWdKsRAp7nhvuLc9m0hXMOqoZOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772055828; c=relaxed/simple;
	bh=hoZBQczrzcuyVPOXD+tTAmFlTYabJ94zI9Irylb/EVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iaLkvgsPA9RETSKHeJ6NB6qJMIcEtj30efUnhLKg9sFGBOMfea5CR5+vuFqh1jBPSAqBTlo6RmXtDTNn1UFZ7mWixw8qohMEeld7+9huGjs3SwEAaTWVLaGihUPx4qihOU8OYq3aFrqvIeqO/dNzIQhKhLgBfuwDF1FddmaCdkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DcXnIIPe; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65f3a35ff13so3617a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 13:43:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772055824; cv=none;
        d=google.com; s=arc-20240605;
        b=K995wpZHkOqhvRjTVRKIH94oKep1wcrwa2uON8YZ+fwYRoRePPK0rd5ahwkRQU3Xbu
         Tgd1y8WCAMeL6zGiADlay19mpL9/eY5ORLVgsJooc/hzLkIsn3AuIVR7hC+J6NKNHeZ4
         7H7U7NwJxvFydnYR6h6Xk1i3M95HwRnkkE8VUSfqIx//hhV4iI24a0JC2r8rikEjgsBZ
         xZYBv0j3Ulfmmfnb03IqJJw8Jd/PB9Vb0Wm8N8InoEVzqTf4oVbiIG3VssCKniFFWTJ3
         Umci19iyVhtq7G0/mVTMUjhyWhb/HQfzmocb6jixx4emv55u/aCNLkrs1YwgQ+zNbN4i
         7nTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vB9FeLIHdzkOeJQl8sZ1jnIIU5NTPuPRUQDCv7qOk1c=;
        fh=LnSHZj8cK8pcv9mFvJ8r0wF3wg7lZ5L7D0Gb2l8N8y0=;
        b=Wfu4ZrrgQTbvs/1KElmH7oG7HYICPcZbjClaRCS7rxkxHLOUvDnxd4HmdhMVszzHxN
         HfEZvWH4Pwr47OihWCMaV+hZqCyPj84NhdijYuovca1B4POKb/xT2Nc8h11/RgqVrbCY
         sJBGLP/gSS5vYxfFYBR+Dlc23oexerF4uYG1zRwx3dCvxzYk5hDxn4lQG666KJG08xU9
         GV9DgQpDisHt7XasxUqrsfYBQNmt1H//RM7vPRIRhQsERqzVx3NNXWK+NwRTO2pW8B4f
         egVJBGGibEqeAvfvamFyPeH0/ODyFqJMLr6NkBmRewdyxEuNL84hzpRZrKv6lO8vpUUV
         Uwug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772055824; x=1772660624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vB9FeLIHdzkOeJQl8sZ1jnIIU5NTPuPRUQDCv7qOk1c=;
        b=DcXnIIPehOR7Zcc84tU5ax/4/X+fJQQXdh6G/qeIGgAwD6QNLuPBvyozFNu04p1olg
         g2ioHyEBoajIsPgNamu8pOCASAUioThGOznYmtfFxA2PNCUI/goNDca2bs4YaC57UiMX
         hrNrJLYnxtIrwCeUCMpB65/mfvXVpuwHhNmB8r2rpeEZVUk9JmP1VTBaWsG8jXrjKXwl
         UiqonoSGe9mduDMaJoz8Kgszdb+iCjKBceJQZRl2elaXYdryJsUcOdQPBv+X7m1a9tcz
         uA3wykguwgIff37UR05C2cadCAQdbVnrzA/akWYG16NJ0Q72rMQDl7LjJp/0lKeJMubA
         Zb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772055824; x=1772660624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vB9FeLIHdzkOeJQl8sZ1jnIIU5NTPuPRUQDCv7qOk1c=;
        b=rfBm5h3O8Aa0LCn9V+fsDQo5XhgZew2YqDHYydLWfpa4edp/AzjgbTEQloNj1AL4MT
         0n554SreuLSEnzEF7oTDT8Oq19klRQrW7nB89htBVADqKcfrcGGImfU+xG4NUQMJ1Olb
         vcC3kh2YZLJSossTMwQN9U1HXNRdpf/YiPnzISxAszVPQuYfATtIIKuR6uW+2LvqRt2m
         No8zJG1mNLMgrTqyaxCd8UMWN09xu9UqndEo02LO5J7kiJ2DW4XqovC3um83KHGzQHCs
         u8uwYm/uituAnd2GpyWr9TnThuRBxmpCUi426gX9DkT4NAJjgzAPvb9K+jVxhL3ewdwj
         L/EA==
X-Forwarded-Encrypted: i=1; AJvYcCXXkd3uM1j5Dpd19k5C6aw1Ues6gqoNX2s9VrUNZTvAcfzS/Nk8QShgpxMCHCtnz+DvYORnQfwac5OnJ2XT@vger.kernel.org
X-Gm-Message-State: AOJu0YyvOH5DfVp9WaqMqoNFsI8eOgIlw/KNZF5r1jBFD1ezgpAwIGzT
	nvG3bGYYSvQUmY2/5W0NR6dgP3S1nQepsqjupz14Zw+4fpMLCgLlY7De8IUe7cVwRpsdc9L95ZD
	KqQVAH5wYMft52mdmNTpQh7maFJ9mLx1eTfCDJsn2
X-Gm-Gg: ATEYQzx2mOvn+BMStNc6F9RrOcDShJdQsCLL5R9flyODMACSldA5P+NJtrgwM7sqrUB
	McHunMWNchtXegYJE1jUzKi9JSFVRk85NKXJBvheidFkPo1aaMM15c1gyKy8YZyBYWVeqjVV44J
	uxR5csjTAB/HWvT7Hq2lv5b+XNZHsDOw8dIlmkfxIzv+PxnUW+PiEF+0l29zkr6f/8KDysbbnAk
	nAQMwlBC7wgC7D+CY57PYcG2ezIQmITvQDkbACOHgr37c7KgnBW/F8UHjFf7eblRPqAXWecaIwa
	jumouS1qKsUbzjTonV5gPFi2INXFdxbkvKIiRw==
X-Received: by 2002:aa7:c7cf:0:b0:658:e7a:6fa7 with SMTP id
 4fb4d7f45d1cf-65fab61a7b0mr11377a12.4.1772055823405; Wed, 25 Feb 2026
 13:43:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619111806.3546162-3-yi.zhang@huaweicloud.com>
 <20260225000531.3658802-1-robertpang@google.com> <7d2a3f65-4272-46c1-991a-356f0d2323cb@huaweicloud.com>
In-Reply-To: <7d2a3f65-4272-46c1-991a-356f0d2323cb@huaweicloud.com>
From: Robert Pang <robertpang@google.com>
Date: Wed, 25 Feb 2026 13:43:31 -0800
X-Gm-Features: AaiRm53fO14_kYBnlB-QimzynwfGzteAR7wRZiT1Sf0awQgFveGcUyR_Z7IWsCY
Message-ID: <CAJhEC05L7QEc9iY7gFZVK3SPYvFhtFyURss6xQgZ-qWwZZkFjA@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] nvme: set max_hw_wzeroes_unmap_sectors if device
 supports DEAC bit
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Zhang Yi <yi.zhang@huawei.com>, bmarzins@redhat.com, brauner@kernel.org, 
	chaitanyak@nvidia.com, chengzhihao1@huawei.com, djwong@kernel.org, 
	dm-devel@lists.linux.dev, hch@lst.de, john.g.garry@oracle.com, 
	linux-block@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	linux-xfs@vger.kernel.org, martin.petersen@oracle.com, 
	shinichiro.kawasaki@wdc.com, tytso@mit.edu, yangerkun@huawei.com, 
	yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78400-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robertpang@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,huaweicloud.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 93D5819E041
X-Rspamd-Action: no action

Dear Zhang Yi

Thank you for your quick response. Please see my comments below:

On Tue, Feb 24, 2026 at 6:32=E2=80=AFPM Zhang Yi <yi.zhang@huaweicloud.com>=
 wrote:
>
> Hi Robert!
>
> On 2/25/2026 8:05 AM, Robert Pang wrote:
> > Dear Zhang Yi,
> >
> > In reviewing your patch series implementing support for the
> > FALLOC_FL_WRITE_ZEROES flag, I noted the logic propagating
> > max_write_zeroes_sectors to max_hw_wzeroes_unmap_sectors in commit 545f=
b46e5bc6
> > "nvme: set max_hw_wzeroes_unmap_sectors if device supports DEAC bit" [1=
]. This
> > appears to be intended for devices that support the Write Zeroes comman=
d
> > alongside the DEAC bit to indicate unmap capability.
> >
> > Furthermore, within core.c, the NVME_QUIRK_DEALLOCATE_ZEROES quirk alre=
ady
> > identifies devices that deterministically return zeroes after a dealloc=
ate
> > command [2]. This quirk currently enables Write Zeroes support via disc=
ard in
> > existing implementations [3, 4].
> >
> > Given this, would it be appropriate to respect NVME_QUIRK_DEALLOCATE_ZE=
ROES also
> > to enable unmap Write Zeroes for these devices, following the prior com=
mit
> > 6e02318eaea5 "nvme: add support for the Write Zeroes command" [5]? I ha=
ve
> > included a proposed change to nvme_update_ns_info_block() below for you=
r
> > consideration.
> >
>
> Thank you for your point. Overall, this makes sense to me, but I have one
> question below.
>
> > Best regards
> > Robert Pang
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index f5ebcaa2f859..9c7e2cabfab3 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -2422,7 +2422,9 @@ static int nvme_update_ns_info_block(struct nvme_=
ns *ns,
> >          * require that, it must be a no-op if reads from deallocated d=
ata
> >          * do not return zeroes.
> >          */
> > -       if ((id->dlfeat & 0x7) =3D=3D 0x1 && (id->dlfeat & (1 << 3))) {
> > +       if ((id->dlfeat & 0x7) =3D=3D 0x1 && (id->dlfeat & (1 << 3)) ||
> > +           (ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES) &&
> > +           (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM)) {
>                                 ^^^^^^^^^^^^^^^^^^
> Why do you want to add a check for NVME_CTRL_ONCS_DSM? In nvme_config_dis=
card(),
> it appears that we prioritize ctrl->dmrsl, allowing discard to still be
> supported even on some non-standard devices where NVME_CTRL_ONCS_DSM is n=
ot set.
> In nvme_update_disk_info(), if the device only has NVME_QUIRK_DEALLOCATE_=
ZEROES,
> we still populate lim->max_write_zeroes_sectors (which might be non-zero =
on
> devices that support NVME_CTRL_ONCS_WRITE_ZEROES). Right? So I'm not sure=
 if we
> only need to check for NVME_QUIRK_DEALLOCATE_ZEROES here.
>
The check for NVME_CTRL_ONCS_DSM is to follow the same check in [3]. There,=
 the
check was added by 58a0c875ce02 "nvme: don't apply NVME_QUIRK_DEALLOCATE_ZE=
ROES
when DSM is not supported" [6]. The idea is to limit
NVME_QUIRK_DEALLOCATE_ZEROES
to those devices that support DSM.

> >                 ns->head->features |=3D NVME_NS_DEAC;
>
> I think we should not set NVME_NS_DEAC for the quirks case.
>
Make sense. In that case, will it be more appropriate to set
max_hw_wzeroes_unmap_sectors in nvme_update_disk_info() where
NVME_QUIRK_DEALLOCATE_ZEROES is checked? I.e.

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f5ebcaa2f859..3f5dd3f867e9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2120,9 +2120,10 @@ static bool nvme_update_disk_info(struct
nvme_ns *ns, struct nvme_id_ns *id,
        lim->io_min =3D phys_bs;
        lim->io_opt =3D io_opt;
        if ((ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES) &&
-           (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM))
+           (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM)) {
                lim->max_write_zeroes_sectors =3D UINT_MAX;
-       else
+               lim->max_hw_wzeroes_unmap_sectors =3D UINT_MAX;
+       } else
                lim->max_write_zeroes_sectors =3D ns->ctrl->max_zeroes_sect=
ors;
        return valid;
 }

Best regards
Robert

> Cheers,
> Yi.
>
> >                 lim.max_hw_wzeroes_unmap_sectors =3D lim.max_write_zero=
es_sectors;
> >         }
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D545fb46e5bc6
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/drivers/nvme/host/nvme.h#n72
> > [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/drivers/nvme/host/core.c#n938
> > [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/drivers/nvme/host/core.c#n2122
> > [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D6e02318eaea5
[6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D58a0c875ce02

