Return-Path: <linux-fsdevel+bounces-74943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DASGylqcWmaGgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 01:07:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2996F5FCDC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 01:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 248A83650FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 00:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DB22AF00;
	Thu, 22 Jan 2026 00:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLGf1X/E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F73B1662E7
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 00:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769040415; cv=pass; b=aJYZtBrDeSNcOtccOhUqNGbrXBvjPexaesdm6pi5OnEkdpxVbNt53JF6u/FZWGCI6QVIn2kMKpCe38L2vB/oaecfbnZSNUeRi/LjtzZdfYkFUaT+8fAPzaXH5PokK0hcPcR9x7L40cuVJelOi/3SBFw2x9LrHNJpHiVvs1NAifg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769040415; c=relaxed/simple;
	bh=Us4YSQljqrpT+pc7iDnp4BqK7WtRk/ptlOUramH/ci8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ARg795auGbmu3Pxf8KopVkGZCoJPHm6+M0NU4RQ7IG/rifZ6z6GiN4Q9Ltplla94VHh2VedTOVs6akCH9mujqcvuXBl5t85FDtNiSje0PmgOvPkK/6U3t32HIj9kMkZ7IK1JTRZovcbefKJo1CQcSxXDSjit0TXypmBD4jlXsvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLGf1X/E; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8947404b367so4821456d6.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 16:06:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769040411; cv=none;
        d=google.com; s=arc-20240605;
        b=WpmFXGfRdDjSPNyjw2q0skBRuYc9nUKJHwSZ5xYCunluxjE3kEmY/eYXfMhzcZ6ymF
         yVpMMl1bXRKJa1iy8vTvokNOtsP6uccRc1lUt8e8XMNAQm+68bAI8/1dc79ZcmjHCb/X
         7lP1LY4SPX1v7Alq6nAy6Btwv5BIPxyMiRxd5gYdvyGvw9CM+YJIlt51dc156Ym0gAKo
         oE04uKMNVaqUjnHovsuw3umpTSsg/zbMDnvBLRyA+1QqaioUgnd7JK6ZdC4Azq2eOMrw
         GO/WXXuOp549Ovwj2GDrfd7WFbOYQ6zccM2vMSNSCtwd6PxgI9JVGxqXUJqCbUvu2+Au
         7K3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UR22kfSdMvEE6HcIWepsk4bWrltrmmGqFzdtf/60qTA=;
        fh=0H8mf7ZcMDYr5CtTa4wl9LVkIsNdD+/swOSJUp7FBHA=;
        b=UVLHhEGU2JxL1v1hgfbUH+cZkP+TrDT+T0Wjxs+lf5Xed84pEtxo1kf9Dh4yVdh9e1
         Ok2xJWVE4/Cc9BaFrAYzFFrfHMLI2LfEq+gOjE7Rp5mpjxmjRLx5XxCu4DV7l0siM5GP
         Qeir6LH2DhRY2BbGJZwb7rKSD2WxquB/4Y27R5QeDnEN7vo94Xdpfn3BkhonbDiMTAqg
         U5pDpOMsM6AUdHpkSwcO9ixHDW1cKA+cuB/+hfA7XpFOS3WImtxwCrHpEhI+gYS90q+3
         A8u53EjuiBAIeFp36riDpQfjzo08LG44ROWFWIONPUDn7fRJhL2dc0eZw/kBEE+z/Rjs
         Ia3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769040411; x=1769645211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UR22kfSdMvEE6HcIWepsk4bWrltrmmGqFzdtf/60qTA=;
        b=YLGf1X/En208puz6AWZlDpB6OVjWRYHsgi+nDchavP7kBAqSoPwRYe/M624Oq/BlfA
         +L7GXQPTh5myK/RV1ZZtlCOcS+5tjwyTZWBSyqKOeEZhwvovCPvm7ocTB3Jmq/oBfgnO
         UKyZt8cW+2pszh2ahyzWz5vKOezad/4BFixAgmWFzkqfjzLmlx5MBVkYaaC1bv2R+2C+
         er7IcE4SNGXqKN6dKp911nM080vBc7JFqo5YqiiNRUSmkRR5PvgdDa4x8eUTiBnhKsnp
         frnF/CWwGA38ay1vPf2VYEYPn6oSlqquufsCVp9sP8jiqoVEK/oi8mGkRzbsUPFlIRH3
         +eqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769040411; x=1769645211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UR22kfSdMvEE6HcIWepsk4bWrltrmmGqFzdtf/60qTA=;
        b=oTIDGver1SPXhr0aALZhTMR1GPRtRcahgwdwpvx0HSNDJyNayjm8zahU/k4dp7pc/m
         W8mXizfb2/FlNbqRIO3nUWOI2Fdz+9x5FMJTplhunIZTpswLP/xi3LA6N9v5QrmAWU4f
         uT27fZ2L2gWr5ktoMCeLOTlDr4w7pTzB4UcxO75Mz+kyjYAJDH84jMNuyYt8zayPuFax
         qoMY/oY2Sv5tBkCeNdO8qVSptx7h8iosvuW8+LygDDaaZtDFGKKnYnB5PBBsFvRZ5jTt
         5t9TeHTywJblkH337w4NHKnxXO8wEUgHhnifAiK2vR0Kw6aKZx3TM7JR3fx8CgBwLGgX
         wLkw==
X-Forwarded-Encrypted: i=1; AJvYcCUTws7NvXshgNOq44FhKOsxLwF7or6TE/xf8tigK5XnU9EzZq4I2LOMyXzq4pByb4nOSXl0XfFU1aJ5fjrU@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7R1/puZlWnkXLDgTGCnGq0sqPwhMTw/ek27/hN0Ol1HJ6ClIW
	CVgwF0LoDDxyoLL5+PWoD0oN5bkNZwtkeSyXUfTPwuNuYjtV6zIqDIN8m+QswoGG61vgee7XOrx
	8RDfBEsNl1ti0Wye0jFHqOUfJi0JJuCw=
X-Gm-Gg: AZuq6aIuH8eiIvweOPQ9lHWGGDt567ayogjxZcm0r7ONvneSawzrnSed8ztImy3/0ms
	3vksONPFcB1VRG2aKakQq3o4WSccFHjVoDORoLLfqKfjFDtGqrvrJ9aF/+7c6yl768PE5Tzm+fc
	GuE2tgbhGIHJdC0a0xEdI34lngYc+wdOX0JuqgBinbmLa1tWtX/Tk4BRIIj+Jtro1a+xK3eNq+x
	BQhYIMedGZ8PF0OLX07jMOkNPTjF4yX+uqnv3u5hxlW+YT7Bj73Eq0SzpoNdp+XRJM+Ug==
X-Received: by 2002:a05:6214:2b0d:b0:893:42f1:ebb with SMTP id
 6a1803df08f44-8942dcf73fdmr295170096d6.24.1769040411036; Wed, 21 Jan 2026
 16:06:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <176169810371.1424854.3010195280915622081.stgit@frogsfrogsfrogs>
 <CAJnrk1ZOLNytBdVqvWiHbwA0rE0KCVt09SmHFZ3pp_tffg+iaQ@mail.gmail.com> <20260121224513.GJ5966@frogsfrogsfrogs>
In-Reply-To: <20260121224513.GJ5966@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 21 Jan 2026 16:06:39 -0800
X-Gm-Features: AZwV_Qivyz6odppIAn3T9hGnmQn9Y9S_tTuNOGZQQZUsI5lvFweUMcBO83gvSGg
Message-ID: <CAJnrk1aa7eyFLm30wiR9fVuwW6RKKniuFmFUSHhs7NVXKJVKtQ@mail.gmail.com>
Subject: Re: [PATCH 01/31] fuse: implement the basic iomap mechanisms
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74943-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 2996F5FCDC
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 2:45=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Wed, Jan 21, 2026 at 11:34:24AM -0800, Joanne Koong wrote:
> > On Tue, Oct 28, 2025 at 5:45=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > Implement functions to enable upcalling of iomap_begin and iomap_end =
to
> > > userspace fuse servers.
> > >
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > ---
> > >  fs/fuse/fuse_i.h          |   22 ++
> > >  fs/fuse/iomap_i.h         |   36 ++++
> > >  include/uapi/linux/fuse.h |   90 +++++++++
> > >  fs/fuse/Kconfig           |   32 +++
> > >  fs/fuse/Makefile          |    1
> > >  fs/fuse/file_iomap.c      |  434 +++++++++++++++++++++++++++++++++++=
++++++++++
> > >  fs/fuse/inode.c           |    8 +
> > >  7 files changed, 621 insertions(+), 2 deletions(-)
> > >  create mode 100644 fs/fuse/iomap_i.h
> > >  create mode 100644 fs/fuse/file_iomap.c
> > >
> > >
> > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > index 7c7d255d817f1e..45be59df7ae592 100644
> > > --- a/fs/fuse/fuse_i.h
> > > +++ b/fs/fuse/fuse_i.h
> > > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > > index 18713cfaf09171..7d709cf12b41a7 100644
> > > --- a/include/uapi/linux/fuse.h
> > > +++ b/include/uapi/linux/fuse.h
> > > @@ -240,6 +240,9 @@
> > >   *  - add FUSE_COPY_FILE_RANGE_64
> > >   *  - add struct fuse_copy_file_range_out
> > >   *  - add FUSE_NOTIFY_PRUNE
> > > + *
> > > + *  7.99
> >
> > Should this be changed to something like 7.46 now that this patch is
> > submitted for merging into the tree?
>
> When review of this patchset nears completion I'll change the 99s to
> 46 or whatever the fuse/libfuse minor version happens to be at that
> point.

Sounds good.

>
> Nobody's touched this series since 29 October (during 6.19 development)
> and I've been busy with xfs_healer so I'm not submitting this for 7.0
> either.
>
> > > + *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file op=
erations
> > >   */
> > >
> > > +/* fuse-specific mapping type indicating that writes use the read ma=
pping */
> > > +#define FUSE_IOMAP_TYPE_PURE_OVERWRITE (255)
> > > +
> > > +#define FUSE_IOMAP_DEV_NULL            (0U)    /* null device cookie=
 */
> > > +
> > > +/* mapping flags passed back from iomap_begin; see corresponding IOM=
AP_F_ */
> > > +#define FUSE_IOMAP_F_NEW               (1U << 0)
> > > +#define FUSE_IOMAP_F_DIRTY             (1U << 1)
> > > +#define FUSE_IOMAP_F_SHARED            (1U << 2)
> > > +#define FUSE_IOMAP_F_MERGED            (1U << 3)
> > > +#define FUSE_IOMAP_F_BOUNDARY          (1U << 4)
> > > +#define FUSE_IOMAP_F_ANON_WRITE                (1U << 5)
> > > +#define FUSE_IOMAP_F_ATOMIC_BIO                (1U << 6)
> >
> > Do you think it makes sense to have the fuse iomap constants mirror
> > the in-kernel iomap ones? Maybe I'm mistaken but it seems like the
> > fuse iomap capabilities won't diverge too much from fs/iomap ones? I
> > like that if they're mirrored, then it makes it simpler instead of
> > needing to convert back and forth.
>
> "Mirrored"?  As in, having the define use a symbol:
>
> #define FUSE_IOMAP_F_NEW                IOMAP_F_NEW
>
> instead of defining it to be a specific numerical constant like it is
> here?

I was thinking keeping it like it is with defining it to a specific
numerical constant, but having the number correspond to the number
iomap.h uses and having static asserts to ensure they match, and then
being able to just pass struct fuse_iomap_io's flags directly to
iomap->flags and vice versa. But I guess the iomap constants could
change at any time since it's not a uapi.

>
> <confused>
>
> This might not be answering your question, but as an old iomap
> maintainer I want the kernel iomap api and the fuse iomap uabi to
> be as decoupled as they can be; and trust the compiler to notice that
> the flag and enum constants are the same and not do anything too stupid
> with the translation.

Gotcha, that makes sense.
>
> > > +/* fuse-specific mapping flag asking for ->iomap_end call */
> > > +#define FUSE_IOMAP_F_WANT_IOMAP_END    (1U << 7)
> > > +
> > > +/* mapping flags passed to iomap_end */
> > > +#define FUSE_IOMAP_F_SIZE_CHANGED      (1U << 8)
> > > +#define FUSE_IOMAP_F_STALE             (1U << 9)
> > > +
> > > +/* operation flags from iomap; see corresponding IOMAP_* */
> > > +#define FUSE_IOMAP_OP_WRITE            (1U << 0)
> > > +#define FUSE_IOMAP_OP_ZERO             (1U << 1)
> > > +#define FUSE_IOMAP_OP_REPORT           (1U << 2)
> > > +#define FUSE_IOMAP_OP_FAULT            (1U << 3)
> > > +#define FUSE_IOMAP_OP_DIRECT           (1U << 4)
> > > +#define FUSE_IOMAP_OP_NOWAIT           (1U << 5)
> > > +#define FUSE_IOMAP_OP_OVERWRITE_ONLY   (1U << 6)
> > > +#define FUSE_IOMAP_OP_UNSHARE          (1U << 7)
> > > +#define FUSE_IOMAP_OP_DAX              (1U << 8)
> > > +#define FUSE_IOMAP_OP_ATOMIC           (1U << 9)
> > > +#define FUSE_IOMAP_OP_DONTCACHE                (1U << 10)
> > > +
> > > +#define FUSE_IOMAP_NULL_ADDR           (-1ULL) /* addr is not valid =
*/
> > > +
> > > +struct fuse_iomap_io {
> > > +       uint64_t offset;        /* file offset of mapping, bytes */
> > > +       uint64_t length;        /* length of mapping, bytes */
> > > +       uint64_t addr;          /* disk offset of mapping, bytes */
> > > +       uint16_t type;          /* FUSE_IOMAP_TYPE_* */
> > > +       uint16_t flags;         /* FUSE_IOMAP_F_* */
> > > +       uint32_t dev;           /* device cookie */
> >
> > Do you think it's a good idea to add a reserved field here in case we
> > end up needing it in the future?
>
> I'm open to the idea of pre-padding the structs, though that's extra
> copy overhead until they get used for something.

Bernd would know better than me on this, but iirc, fuse generally
tries to prepad structs to avoid having to deal with backwards
compatibility issues if future fields get added.

>
> Does that fuse-iouring-zerocopy patchset that you're working on enable
> the kernel to avoid copying fuse command data around?  I haven't read it
> in sufficient (or any) detail to know the answer to that question.

No, only the payload bypasses the copy. All the header stuff would
have to get copied out to the ring.

>
> Second: how easy is it to send a variable sized fuse command to
> userspace?  It looks like some commands like FUSE_WRITE do things like:
>
>         if (ff->fm->fc->minor < 9)
>                 args->in_args[0].size =3D FUSE_COMPAT_WRITE_IN_SIZE;
>         else
>                 args->in_args[0].size =3D sizeof(ia->write.in);
>         args->in_args[0].value =3D &ia->write.in;
>         args->in_args[1].size =3D count;
>
> Which means that future expansion can (in theory) bump the minor version
> and send larer commands.
>
> It also looks like the kernel can support receiving variable-sized
> responses, like FUSE_READ does:
>
>         args->out_argvar =3D true;
>         args->out_numargs =3D 1;
>         args->out_args[0].size =3D count;
>
> I think this means that if we ever needed to expand the _out struct to
> allow the fuse server to send back a more lengthy response, we could
> potentially do that without needing a minor protocol version bump.

I'm not sure, Bernd or Miklos would know more, but my general
impression has been that we try to avoid doing the FUSE_COMPAT_ stuff
if we can.
>
> > > +};
> > > +
> > > +struct fuse_iomap_begin_in {
> > > +       uint32_t opflags;       /* FUSE_IOMAP_OP_* */
> > > +       uint32_t reserved;      /* zero */
> > > +       uint64_t attr_ino;      /* matches fuse_attr:ino */
> > > +       uint64_t pos;           /* file position, in bytes */
> > > +       uint64_t count;         /* operation length, in bytes */
> > > +};
> > > +
> > > +struct fuse_iomap_begin_out {
> > > +       /* read file data from here */
> > > +       struct fuse_iomap_io    read;
> > > +
> > > +       /* write file data to here, if applicable */
> > > +       struct fuse_iomap_io    write;
> >
> > Same question here
>
> How much padding do you want?  fuse_iomap_io is conveniently half a
> cacheline right now...
>
> > > +};
> > > +
> > > +struct fuse_iomap_end_in {
> > > +       uint32_t opflags;       /* FUSE_IOMAP_OP_* */
> > > +       uint32_t reserved;      /* zero */
> > > +       uint64_t attr_ino;      /* matches fuse_attr:ino */
> > > +       uint64_t pos;           /* file position, in bytes */
> > > +       uint64_t count;         /* operation length, in bytes */
> > > +       int64_t written;        /* bytes processed */
> >
> > On the fs/iomap side, I see that written is passed through by
> > iomap_iter() to ->iomap_end through 'ssize_t advanced' but it's not
> > clear to me why advanced needs to be signed. I think it used to also
> > represent the error status, but it looks like now that's represented
> > through iter->status and 'advanced' strictly reflects the number of
> > bytes written. As such, do you think it makes sense to change
> > 'advanced' to loff_t and have written be uint64_t instead?
>
> Not quite -- back in the bad old days, iomap_iter::processed was a s64
> value that the iteration loop had to set to one of:
>
>  * a positive number for positive progress
>  * zero to stop the iteration
>  * a negative errno to fail out
>
> Nowadays we just move iomap_iter::pos forward via iomap_iter_advance or
> set status to a negative number to end the iteration.
>
> So yes, I think @advanced should be widened to 64-bits since iomap
> operations can jump more than 2GB per iter step.  Practically speaking I
> think this hasn't yet been a problem because the only operations that
> can do that (fiemap, seek, swap) also don't have any client filesystems
> that implement iomap_end; or they do but never send mappings large
> enough to cause problems.
>
> iomap iters can't go backwards so @advanced could be u64 as well.
>
> Also the name of the ->iomap_end parameter could be changed to
> "advanced" because iomap_end could in theory be called for any
> operation, not just writes.  That's a throwback to the days when the
> iomap code was just part of xfs.  It also is an unsigned quantity.

That makes sense, thanks for the context.

>
> > > +
> > > +       /* mapping that the kernel acted upon */
> > > +       struct fuse_iomap_io    map;
> > > +};
> > > +
> > >  #endif /* _LINUX_FUSE_H */
> > > diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> > > index 290d1c09e0b924..934d48076a010c 100644
> > > --- a/fs/fuse/Kconfig
> > > +++ b/fs/fuse/Kconfig
> > > @@ -69,6 +69,38 @@ config FUSE_PASSTHROUGH
> > >  config FUSE_BACKING
> > >         bool
> > >
> > > +config FUSE_IOMAP
> > > +       bool "FUSE file IO over iomap"
> > > +       default y
> > > +       depends on FUSE_FS
> > > +       depends on BLOCK
> > > +       select FS_IOMAP
> > > +       help
> > > +         Enable fuse servers to operate the regular file I/O path th=
rough
> > > +         the fs-iomap library in the kernel.  This enables higher pe=
rformance
> > > +         userspace filesystems by keeping the performance critical p=
arts in
> > > +         the kernel while delegating the difficult metadata parsing =
parts to
> > > +         an easily-contained userspace program.
> > > +
> > > +         This feature is considered EXPERIMENTAL.  Use with caution!
> > > +
> > > +         If unsure, say N.
> > > +
> > > +config FUSE_IOMAP_BY_DEFAULT
> > > +       bool "FUSE file I/O over iomap by default"
> > > +       default n
> > > +       depends on FUSE_IOMAP
> > > +       help
> > > +         Enable sending FUSE file I/O over iomap by default.
> >
> > I'm not really sure what the general linux preference is for adding
> > new configs, but assuming it errs towards less configs than more, imo
> > it seems easy enough to just set the enable_iomap module param to true
> > manually instead of needing this config for it, especially since the
> > param only needs to be set once.
>
> /me doesn't know what the norm is in fuse-land -- for xfs I've preferred
> to have a kconfig option for experimental code so that distros can turn
> off experimental stuff they don't want to support.
>
> OTOH they can also patch it out or affix the module param to 0.
>
> Also I'm not sure if the kernel tinyfication project is still active,
> for a while they were advocating strongly for more kconfig options so
> that people building embedded kernels could turn off big chunks of
> functionality they'd never need.
>
> > > +
> > > +config FUSE_IOMAP_DEBUG
> > > +       bool "Debug FUSE file IO over iomap"
> > > +       default y
> > > +       depends on FUSE_IOMAP
> > > +       help
> > > +         Enable debugging assertions for the fuse iomap code paths a=
nd logging
> > > +         of bad iomap file mapping data being sent to the kernel.
> >
> > I'm wondering if it makes sense to make this a general FUSE_DEBUG
> > config so we can reuse this more generally
>
> In general yes but I highly recommend that everyone look at the static
> labels and auto-ftracing stuff enabled by the next few debug patches
> before anyone commits to spreading that enhanced observability / brain
> disease to the rest of fuse. ;)
>
> > > +
> > >  config FUSE_IO_URING
> > >         bool "FUSE communication over io-uring"
> > >         default y
> > > diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> > > index 46041228e5be2c..27be39317701d6 100644
> > > --- a/fs/fuse/Makefile
> > > +++ b/fs/fuse/Makefile
> > > @@ -18,5 +18,6 @@ fuse-$(CONFIG_FUSE_PASSTHROUGH) +=3D passthrough.o
> > >  fuse-$(CONFIG_FUSE_BACKING) +=3D backing.o
> > >  fuse-$(CONFIG_SYSCTL) +=3D sysctl.o
> > >  fuse-$(CONFIG_FUSE_IO_URING) +=3D dev_uring.o
> > > +fuse-$(CONFIG_FUSE_IOMAP) +=3D file_iomap.o
> > >
> > >  virtiofs-y :=3D virtio_fs.o
> > > diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
> > > new file mode 100644
> > > index 00000000000000..d564d60d0f1779
> > > --- /dev/null
> > > +++ b/fs/fuse/file_iomap.c
> > > @@ -0,0 +1,434 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2025 Oracle.  All Rights Reserved.
> > > + * Author: Darrick J. Wong <djwong@kernel.org>
> > > + */
> > > +#include <linux/iomap.h>
> > > +#include "fuse_i.h"
> > > +#include "fuse_trace.h"
> > > +#include "iomap_i.h"
> > > +
> > > +static bool __read_mostly enable_iomap =3D
> > > +#if IS_ENABLED(CONFIG_FUSE_IOMAP_BY_DEFAULT)
> > > +       true;
> > > +#else
> > > +       false;
> > > +#endif
> > > +module_param(enable_iomap, bool, 0644);
> > > +MODULE_PARM_DESC(enable_iomap, "Enable file I/O through iomap");
> > > +
> > > +bool fuse_iomap_enabled(void)
> > > +{
> > > +       /* Don't let anyone touch iomap until the end of the patchset=
. */
> > > +       return false;
> > > +
> > > +       /*
> > > +        * There are fears that a fuse+iomap server could somehow DoS=
 the
> > > +        * system by doing things like going out to lunch during a wr=
iteback
> > > +        * related iomap request.  Only allow iomap access if the fus=
e server
> > > +        * has rawio capabilities since those processes can mess thin=
gs up
> > > +        * quite well even without our help.
> > > +        */
> > > +       return enable_iomap && has_capability_noaudit(current, CAP_SY=
S_RAWIO);
> > > +}
> > > +
> > > +/* Convert IOMAP_* mapping types to FUSE_IOMAP_TYPE_* */
> > > +#define XMAP(word) \
> > > +       case IOMAP_##word: \
> > > +               return FUSE_IOMAP_TYPE_##word
> > > +static inline uint16_t fuse_iomap_type_to_server(uint16_t iomap_type=
)
> > > +{
> > > +       switch (iomap_type) {
> > > +       XMAP(HOLE);
> > > +       XMAP(DELALLOC);
> > > +       XMAP(MAPPED);
> > > +       XMAP(UNWRITTEN);
> > > +       XMAP(INLINE);
> > > +       default:
> > > +               ASSERT(0);
> > > +       }
> > > +       return 0;
> > > +}
> > > +#undef XMAP
> > > +
> > > +/* Convert FUSE_IOMAP_TYPE_* to IOMAP_* mapping types */
> > > +#define XMAP(word) \
> > > +       case FUSE_IOMAP_TYPE_##word: \
> > > +               return IOMAP_##word
> > > +static inline uint16_t fuse_iomap_type_from_server(uint16_t fuse_typ=
e)
> > > +{
> > > +       switch (fuse_type) {
> > > +       XMAP(HOLE);
> > > +       XMAP(DELALLOC);
> > > +       XMAP(MAPPED);
> > > +       XMAP(UNWRITTEN);
> > > +       XMAP(INLINE);
> > > +       default:
> > > +               ASSERT(0);
> > > +       }
> > > +       return 0;
> > > +}
> > > +#undef XMAP
> > > +
> > > +/* Validate FUSE_IOMAP_TYPE_* */
> > > +static inline bool fuse_iomap_check_type(uint16_t fuse_type)
> > > +{
> > > +       switch (fuse_type) {
> > > +       case FUSE_IOMAP_TYPE_HOLE:
> > > +       case FUSE_IOMAP_TYPE_DELALLOC:
> > > +       case FUSE_IOMAP_TYPE_MAPPED:
> > > +       case FUSE_IOMAP_TYPE_UNWRITTEN:
> > > +       case FUSE_IOMAP_TYPE_INLINE:
> > > +       case FUSE_IOMAP_TYPE_PURE_OVERWRITE:
> > > +               return true;
> > > +       }
> > > +
> > > +       return false;
> > > +}
> > > +
> > > +#define FUSE_IOMAP_F_ALL (FUSE_IOMAP_F_NEW | \
> > > +                         FUSE_IOMAP_F_DIRTY | \
> > > +                         FUSE_IOMAP_F_SHARED | \
> > > +                         FUSE_IOMAP_F_MERGED | \
> > > +                         FUSE_IOMAP_F_BOUNDARY | \
> > > +                         FUSE_IOMAP_F_ANON_WRITE | \
> > > +                         FUSE_IOMAP_F_ATOMIC_BIO | \
> > > +                         FUSE_IOMAP_F_WANT_IOMAP_END)
> > > +
> > > +static inline bool fuse_iomap_check_flags(uint16_t flags)
> > > +{
> > > +       return (flags & ~FUSE_IOMAP_F_ALL) =3D=3D 0;
> > > +}
> > > +
> > > +/* Convert IOMAP_F_* mapping state flags to FUSE_IOMAP_F_* */
> > > +#define XMAP(word) \
> > > +       if (iomap_f_flags & IOMAP_F_##word) \
> > > +               ret |=3D FUSE_IOMAP_F_##word
> > > +#define YMAP(iword, oword) \
> > > +       if (iomap_f_flags & IOMAP_F_##iword) \
> > > +               ret |=3D FUSE_IOMAP_F_##oword
> > > +static inline uint16_t fuse_iomap_flags_to_server(uint16_t iomap_f_f=
lags)
> > > +{
> > > +       uint16_t ret =3D 0;
> > > +
> > > +       XMAP(NEW);
> > > +       XMAP(DIRTY);
> > > +       XMAP(SHARED);
> > > +       XMAP(MERGED);
> > > +       XMAP(BOUNDARY);
> > > +       XMAP(ANON_WRITE);
> > > +       XMAP(ATOMIC_BIO);
> > > +       YMAP(PRIVATE, WANT_IOMAP_END);
> > > +
> > > +       XMAP(SIZE_CHANGED);
> > > +       XMAP(STALE);
> > > +
> > > +       return ret;
> > > +}
> > > +#undef YMAP
> > > +#undef XMAP
> > > +
> > > +/* Convert FUSE_IOMAP_F_* to IOMAP_F_* mapping state flags */
> > > +#define XMAP(word) \
> > > +       if (fuse_f_flags & FUSE_IOMAP_F_##word) \
> > > +               ret |=3D IOMAP_F_##word
> > > +#define YMAP(iword, oword) \
> > > +       if (fuse_f_flags & FUSE_IOMAP_F_##iword) \
> > > +               ret |=3D IOMAP_F_##oword
> > > +static inline uint16_t fuse_iomap_flags_from_server(uint16_t fuse_f_=
flags)
> > > +{
> > > +       uint16_t ret =3D 0;
> > > +
> > > +       XMAP(NEW);
> > > +       XMAP(DIRTY);
> > > +       XMAP(SHARED);
> > > +       XMAP(MERGED);
> > > +       XMAP(BOUNDARY);
> > > +       XMAP(ANON_WRITE);
> > > +       XMAP(ATOMIC_BIO);
> > > +       YMAP(WANT_IOMAP_END, PRIVATE);
> > > +
> > > +       return ret;
> > > +}
> > > +#undef YMAP
> > > +#undef XMAP
> > > +
> > > +/* Convert IOMAP_* operation flags to FUSE_IOMAP_OP_* */
> > > +#define XMAP(word) \
> > > +       if (iomap_op_flags & IOMAP_##word) \
> > > +               ret |=3D FUSE_IOMAP_OP_##word
> > > +static inline uint32_t fuse_iomap_op_to_server(unsigned iomap_op_fla=
gs)
> > > +{
> > > +       uint32_t ret =3D 0;
> > > +
> > > +       XMAP(WRITE);
> > > +       XMAP(ZERO);
> > > +       XMAP(REPORT);
> > > +       XMAP(FAULT);
> > > +       XMAP(DIRECT);
> > > +       XMAP(NOWAIT);
> > > +       XMAP(OVERWRITE_ONLY);
> > > +       XMAP(UNSHARE);
> > > +       XMAP(DAX);
> > > +       XMAP(ATOMIC);
> > > +       XMAP(DONTCACHE);
> > > +
> > > +       return ret;
> > > +}
> > > +#undef XMAP
> > > +
> > > +/* Validate an iomap mapping. */
> > > +static inline bool fuse_iomap_check_mapping(const struct inode *inod=
e,
> > > +                                           const struct fuse_iomap_i=
o *map,
> > > +                                           enum fuse_iomap_iodir iod=
ir)
> > > +{
> > > +       const unsigned int blocksize =3D i_blocksize(inode);
> > > +       uint64_t end;
> > > +
> > > +       /* Type and flags must be known */
> > > +       if (BAD_DATA(!fuse_iomap_check_type(map->type)))
> > > +               return false;
> > > +       if (BAD_DATA(!fuse_iomap_check_flags(map->flags)))
> > > +               return false;
> > > +
> > > +       /* No zero-length mappings */
> > > +       if (BAD_DATA(map->length =3D=3D 0))
> > > +               return false;
> > > +
> > > +       /* File range must be aligned to blocksize */
> > > +       if (BAD_DATA(!IS_ALIGNED(map->offset, blocksize)))
> > > +               return false;
> > > +       if (BAD_DATA(!IS_ALIGNED(map->length, blocksize)))
> > > +               return false;
> > > +
> > > +       /* No overflows in the file range */
> > > +       if (BAD_DATA(check_add_overflow(map->offset, map->length, &en=
d)))
> > > +               return false;
> > > +
> > > +       /* File range cannot start past maxbytes */
> > > +       if (BAD_DATA(map->offset >=3D inode->i_sb->s_maxbytes))
> > > +               return false;
> > > +
> > > +       switch (map->type) {
> > > +       case FUSE_IOMAP_TYPE_MAPPED:
> > > +       case FUSE_IOMAP_TYPE_UNWRITTEN:
> > > +               /* Mappings backed by space must have a device/addr *=
/
> > > +               if (BAD_DATA(map->dev =3D=3D FUSE_IOMAP_DEV_NULL))
> > > +                       return false;
> > > +               if (BAD_DATA(map->addr =3D=3D FUSE_IOMAP_NULL_ADDR))
> > > +                       return false;
> > > +               break;
> > > +       case FUSE_IOMAP_TYPE_DELALLOC:
> > > +       case FUSE_IOMAP_TYPE_HOLE:
> > > +       case FUSE_IOMAP_TYPE_INLINE:
> > > +               /* Mappings not backed by space cannot have a device =
addr. */
> > > +               if (BAD_DATA(map->dev !=3D FUSE_IOMAP_DEV_NULL))
> > > +                       return false;
> > > +               if (BAD_DATA(map->addr !=3D FUSE_IOMAP_NULL_ADDR))
> > > +                       return false;
> > > +               break;
> > > +       case FUSE_IOMAP_TYPE_PURE_OVERWRITE:
> > > +               /* "Pure overwrite" only allowed for write mapping */
> > > +               if (BAD_DATA(iodir !=3D WRITE_MAPPING))
> > > +                       return false;
> > > +               break;
> > > +       default:
> > > +               /* should have been caught already */
> > > +               ASSERT(0);
> > > +               return false;
> > > +       }
> > > +
> > > +       /* XXX: we don't support devices yet */
> >
> > > +       if (BAD_DATA(map->dev !=3D FUSE_IOMAP_DEV_NULL))
> > > +               return false;
> > > +
> > > +       /* No overflows in the device range, if supplied */
> > > +       if (map->addr !=3D FUSE_IOMAP_NULL_ADDR &&
> > > +           BAD_DATA(check_add_overflow(map->addr, map->length, &end)=
))
> > > +               return false;
> > > +
> > > +       return true;
> > > +}
> > > +
> > > +/* Convert a mapping from the server into something the kernel can u=
se */
> > > +static inline void fuse_iomap_from_server(struct inode *inode,
> >
> > Maybe worth adding a const in front of struct inode?
>
> It can go away in a patch or two when we wire up bdev support.
>
> Though considering that fuse_iomap_enabled returns false all the way to
> the end of the patchset I guess I could just set bdev to null and skip
> passing in the inode at all.
>
> > > +                                         struct iomap *iomap,
> > > +                                         const struct fuse_iomap_io =
*fmap)
> > > +{
> > > +       iomap->addr =3D fmap->addr;
> > > +       iomap->offset =3D fmap->offset;
> > > +       iomap->length =3D fmap->length;
> > > +       iomap->type =3D fuse_iomap_type_from_server(fmap->type);
> > > +       iomap->flags =3D fuse_iomap_flags_from_server(fmap->flags);
> > > +       iomap->bdev =3D inode->i_sb->s_bdev; /* XXX */
> > > +}
> > > +
> > > +/* Convert a mapping from the kernel into something the server can u=
se */
> > > +static inline void fuse_iomap_to_server(struct fuse_iomap_io *fmap,
> > > +                                       const struct iomap *iomap)
> > > +{
> > > +       fmap->addr =3D FUSE_IOMAP_NULL_ADDR; /* XXX */
> > > +       fmap->offset =3D iomap->offset;
> > > +       fmap->length =3D iomap->length;
> > > +       fmap->type =3D fuse_iomap_type_to_server(iomap->type);
> > > +       fmap->flags =3D fuse_iomap_flags_to_server(iomap->flags);
> > > +       fmap->dev =3D FUSE_IOMAP_DEV_NULL; /* XXX */
> >
> > AFAICT, this only gets used for sending the FUSE_IOMAP_END request. Is
> > passing the iomap->addr to fmap->addr and inode->i_sb->s_bdev to
> > fmap->dev not useful to the server here?
>
> So far the only fields I've needed in fuse4fs are the
> offset/count/written fields as provided by iomap_iter, and the flags
> field from the mapping.  The addr field isn't necessary for fuse4fs
> because the fuse server would know if the mapping had changed.  OTOH
> it's probably harmless to send it along.
>
> Hrm.  I probably need a way to look up the backing_id from the iomap
> bdev.
>
> Looking further ahead at the ioend patch, I just realized that iomap
> ioends can tell you the new address of a write-append operation but they
> don't tell you which device.  I guess you can read that from the
> ioend->io_bio.bi_bdev.
>
> > Also, did you mean to leave in the /* XXX */ comments?
>
> Yes, because they're a reminder to come back and check if I /ever/
> needed them.

Makes sense, seems like you're planning to remove them when the patch
is ready to merge, if I understand correctly.
>
> > > +}
> > > +
> > > +/* Check the incoming _begin mappings to make sure they're not nonse=
nse. */
> > > +static inline int
> > > +fuse_iomap_begin_validate(const struct inode *inode,
> > > +                         unsigned opflags, loff_t pos,
> > > +                         const struct fuse_iomap_begin_out *outarg)
> > > +{
> > > +       /* Make sure the mappings aren't garbage */
> > > +       if (!fuse_iomap_check_mapping(inode, &outarg->read, READ_MAPP=
ING))
> > > +               return -EFSCORRUPTED;
> > > +
> > > +       if (!fuse_iomap_check_mapping(inode, &outarg->write, WRITE_MA=
PPING))
> > > +               return -EFSCORRUPTED;
> > > +
> > > +       /*
> > > +        * Must have returned a mapping for at least the first byte i=
n the
> > > +        * range.  The main mapping check already validated that the =
length
> > > +        * is nonzero and there is no overflow in computing end.
> > > +        */
> > > +       if (BAD_DATA(outarg->read.offset > pos))
> > > +               return -EFSCORRUPTED;
> > > +       if (BAD_DATA(outarg->write.offset > pos))
> > > +               return -EFSCORRUPTED;
> > > +
> > > +       if (BAD_DATA(outarg->read.offset + outarg->read.length <=3D p=
os))
> > > +               return -EFSCORRUPTED;
> > > +       if (BAD_DATA(outarg->write.offset + outarg->write.length <=3D=
 pos))
> > > +               return -EFSCORRUPTED;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static inline bool fuse_is_iomap_file_write(unsigned int opflags)
> > > +{
> > > +       return opflags & (IOMAP_WRITE | IOMAP_ZERO | IOMAP_UNSHARE);
> > > +}
> > > +
> > > +static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t =
count,
> > > +                           unsigned opflags, struct iomap *iomap,
> > > +                           struct iomap *srcmap)
> > > +{
> > > +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> > > +       struct fuse_iomap_begin_in inarg =3D {
> > > +               .attr_ino =3D fi->orig_ino,
> > > +               .opflags =3D fuse_iomap_op_to_server(opflags),
> > > +               .pos =3D pos,
> > > +               .count =3D count,
> > > +       };
> > > +       struct fuse_iomap_begin_out outarg =3D { };
> > > +       struct fuse_mount *fm =3D get_fuse_mount(inode);
> > > +       FUSE_ARGS(args);
> > > +       int err;
> > > +
> > > +       args.opcode =3D FUSE_IOMAP_BEGIN;
> > > +       args.nodeid =3D get_node_id(inode);
> > > +       args.in_numargs =3D 1;
> > > +       args.in_args[0].size =3D sizeof(inarg);
> > > +       args.in_args[0].value =3D &inarg;
> > > +       args.out_numargs =3D 1;
> > > +       args.out_args[0].size =3D sizeof(outarg);
> > > +       args.out_args[0].value =3D &outarg;
> > > +       err =3D fuse_simple_request(fm, &args);
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       err =3D fuse_iomap_begin_validate(inode, opflags, pos, &outar=
g);
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       if (fuse_is_iomap_file_write(opflags) &&
> > > +           outarg.write.type !=3D FUSE_IOMAP_TYPE_PURE_OVERWRITE) {
> > > +               /*
> > > +                * For an out of place write, we must supply the writ=
e mapping
> > > +                * via @iomap, and the read mapping via @srcmap.
> > > +                */
> > > +               fuse_iomap_from_server(inode, iomap, &outarg.write);
> > > +               fuse_iomap_from_server(inode, srcmap, &outarg.read);
> > > +       } else {
> > > +               /*
> > > +                * For everything else (reads, reporting, and pure ov=
erwrites),
> > > +                * we can return the sole mapping through @iomap and =
leave
> > > +                * @srcmap unchanged from its default (HOLE).
> > > +                */
> > > +               fuse_iomap_from_server(inode, iomap, &outarg.read);
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +/* Decide if we send FUSE_IOMAP_END to the fuse server */
> > > +static bool fuse_should_send_iomap_end(const struct iomap *iomap,
> > > +                                      unsigned int opflags, loff_t c=
ount,
> > > +                                      ssize_t written)
> > > +{
> > > +       /* fuse server demanded an iomap_end call. */
> > > +       if (iomap->flags & FUSE_IOMAP_F_WANT_IOMAP_END)
> > > +               return true;
> > > +
> > > +       /* Reads and reporting should never affect the filesystem met=
adata */
> > > +       if (!fuse_is_iomap_file_write(opflags))
> > > +               return false;
> > > +
> > > +       /* Appending writes get an iomap_end call */
> > > +       if (iomap->flags & IOMAP_F_SIZE_CHANGED)
> > > +               return true;
> > > +
> > > +       /* Short writes get an iomap_end call to clean up delalloc */
> > > +       return written < count;
> > > +}
> > > +
> > > +static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t co=
unt,
> > > +                         ssize_t written, unsigned opflags,
> > > +                         struct iomap *iomap)
> > > +{
> > > +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> > > +       struct fuse_mount *fm =3D get_fuse_mount(inode);
> > > +       int err =3D 0;
> > > +
> > > +       if (fuse_should_send_iomap_end(iomap, opflags, count, written=
)) {
> > > +               struct fuse_iomap_end_in inarg =3D {
> > > +                       .opflags =3D fuse_iomap_op_to_server(opflags)=
,
> > > +                       .attr_ino =3D fi->orig_ino,
> > > +                       .pos =3D pos,
> > > +                       .count =3D count,
> > > +                       .written =3D written,
> > > +               };
> > > +               FUSE_ARGS(args);
> > > +
> > > +               fuse_iomap_to_server(&inarg.map, iomap);
> > > +
> > > +               args.opcode =3D FUSE_IOMAP_END;
> > > +               args.nodeid =3D get_node_id(inode);
> >
> > Just curious about this - does it make sense to set args.force here
> > for this opcode? It seems like it serves the same sort of purpose a
> > flush request (which sets args.force) does?
>
> What does args.force do?  There's no documentation of what behaviors
> these fields are supposed to trigger.

The args.force forces the request to be sent even if it gets
interrupted by a signal. It'll also bypass the fuse_block_alloc()
check when sending the request, but I don't think that's too relevant
to this case.

Thanks,
Joanne
>
> > > +               args.in_numargs =3D 1;
> > > +               args.in_args[0].size =3D sizeof(inarg);
> > > +               args.in_args[0].value =3D &inarg;
> > > +               err =3D fuse_simple_request(fm, &args);
> > > +               switch (err) {
> > > +               case -ENOSYS:
> > > +                       /*
> > > +                        * libfuse returns ENOSYS for servers that do=
n't
> > > +                        * implement iomap_end
> > > +                        */
> > > +                       err =3D 0;
> > > +                       break;
> > > +               case 0:
> > > +                       break;
> >
> > Is this case 0 needed separately from the default case?
>
> Nah, that's just me absorbing functional brogrammerisms. ;)
>
> --D
>
> > Thanks,
> > Joanne
> >
> > > +               default:
> > > +                       break;
> > > +               }
> > > +       }
> > > +
> > > +       return err;
> > > +}
> > > +
> > > +const struct iomap_ops fuse_iomap_ops =3D {
> > > +       .iomap_begin            =3D fuse_iomap_begin,
> > > +       .iomap_end              =3D fuse_iomap_end,
> > > +};
> > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > index 0cac7164afa298..1eea8dc6e723c6 100644
> > > --- a/fs/fuse/inode.c
> > > +++ b/fs/fuse/inode.c
> > > @@ -1457,6 +1457,12 @@ static void process_init_reply(struct fuse_mou=
nt *fm, struct fuse_args *args,
> > >
> > >                         if (flags & FUSE_REQUEST_TIMEOUT)
> > >                                 timeout =3D arg->request_timeout;
> > > +
> > > +                       if ((flags & FUSE_IOMAP) && fuse_iomap_enable=
d()) {
> > > +                               fc->iomap =3D 1;
> > > +                               pr_warn(
> > > + "EXPERIMENTAL iomap feature enabled.  Use at your own risk!");
> > > +                       }
> > >                 } else {
> > >                         ra_pages =3D fc->max_read / PAGE_SIZE;
> > >                         fc->no_lock =3D 1;
> > > @@ -1525,6 +1531,8 @@ static struct fuse_init_args *fuse_new_init(str=
uct fuse_mount *fm)
> > >          */
> > >         if (fuse_uring_enabled())
> > >                 flags |=3D FUSE_OVER_IO_URING;
> > > +       if (fuse_iomap_enabled())
> > > +               flags |=3D FUSE_IOMAP;
> > >
> > >         ia->in.flags =3D flags;
> > >         ia->in.flags2 =3D flags >> 32;
> > >

