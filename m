Return-Path: <linux-fsdevel+bounces-76201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHtSOgYEgmmYNgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 15:19:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 733EADA7A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 15:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 966AA30CBBD0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 14:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78573A7F4B;
	Tue,  3 Feb 2026 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vz9wTatK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA703A7F53
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770128258; cv=none; b=cSHC3j2+34KBPBI4S4raEb3xnr6x8tq058t05v+4wPmsy/V+OhQ6hI2a9goM/+y6png4XlEPv7yPtzSdHNtN2AJfH3uoX51/W2C5FI8KkTabpOLAdTdsIGQHrz29hL+UdZPDwToHdG4qwRfmQhKO3Bx0Sbp/l5e2JZ0cfvJ+0EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770128258; c=relaxed/simple;
	bh=+GS4XNQ51ixbh5dkWAnRESBpCyK6L48WlPDwptdcWlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSWo+CVKMxzI9T4WmN+jz7fjbMtiBU+uFC7P7mEuvRV1jhodr9dTE9Rrg2m/Rp3jx0YWaOALB1QZejClorvmKSHd0gVoy3782XZJBYpUuR5/8YmMmC10LGdXPpJv23Yry6Ug6FmyPf2YGqXEJBWOBbNqtEYiaMhmT/JBoBJCFv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vz9wTatK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B642C2BCB2
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 14:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770128258;
	bh=+GS4XNQ51ixbh5dkWAnRESBpCyK6L48WlPDwptdcWlU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Vz9wTatKWAtwiYCnjtYSJEDzfUfmE+EqOQxmRjimDbIl4L6fpzxK1VKCpfkeh+/Yu
	 lekjmGsS6XZr+uQNV2W0pJh+C87dPI9JEStsvpP0IK7H7mF+epZdzfXpkbUKJVXvZf
	 07HwvChRHHIWbs9VOWKwRgE4SRfho0mAVAvQkVif9JoV1ttNEzE8RFbVnsLyRFKjDb
	 fAQV4MNp8iBoYwdPg9xwmi/puUUTuuYR8axYYzdnI6l1zSfhiwyshY1MmMTfPQMV9D
	 dpOtolFpVzCrnnU+W7vF6frrLsnpydwlXWNc/GX0wMmFStwUoYSRglNqlZcFmJVbKG
	 fIcF5y1nB7Zew==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8845cb580bso941421966b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 06:17:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUNvupOAHOupoP7WwEjal2Nkwgp/SSa7illZqt/gyg4mZXjRnJWAGa1VkkF593Hh8Cvh53NiEnYZ/Zoi5xU@vger.kernel.org
X-Gm-Message-State: AOJu0YzoTigVUCcWqUUvLT7TUIue+JZ/cUfjglz80rj2H2AJ4LOdbgW0
	oeOD/Qt9eRj4YGVd02odhi/STLoyz0TySuF6+exWBcTsajpQzAp4oxCxSEFZ6QrOcwIWlrfZp0L
	4E1bsF7KeXpbL6UdtFh1rEtjpAHN0T/4=
X-Received: by 2002:a17:906:ee82:b0:b87:7250:ad8f with SMTP id
 a640c23a62f3a-b8dff528bf8mr992086866b.10.1770128256763; Tue, 03 Feb 2026
 06:17:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202220202.10907-1-linkinjeon@kernel.org> <20260202220202.10907-13-linkinjeon@kernel.org>
 <20260203063758.GB18053@lst.de>
In-Reply-To: <20260203063758.GB18053@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 3 Feb 2026 23:17:24 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9v_BzopZptrdeEONO9rdegT+XFVb0CLJHe16fDP9jNWQ@mail.gmail.com>
X-Gm-Features: AZwV_QijYccZY627qi7yJrba77Q61Tc1Wg360vJHgHHohUBxzoTw-Wb3SjK6k14
Message-ID: <CAKYAXd9v_BzopZptrdeEONO9rdegT+XFVb0CLJHe16fDP9jNWQ@mail.gmail.com>
Subject: Re: [PATCH v6 12/16] ntfs: add reparse and ea operations
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu, 
	willy@infradead.org, jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com, 
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, 
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76201-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,mit.edu,infradead.org,suse.cz,toxicpanda.com,sandeen.net,suse.com,brown.name,gmail.com,vger.kernel.org,lge.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,lst.de:email]
X-Rspamd-Queue-Id: 733EADA7A0
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 3:38=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> Suggested commit message:
>
> Implement support for Extended Attributes and Reparse Points, enabling
> Posix ACL support and, and compatibility with Windows Subsystem for
> Linux (WSL) metadata.
Okay, I will use it.
>
> > +struct WSL_LINK_REPARSE_DATA {
> > +     __le32  type;
> > +     char    link[];
> > +};
> > +
> > +struct REPARSE_INDEX {                       /* index entry in $Extend=
/$Reparse */
>
> Why are these using all upper case names unlike the rest of the
> code?
Right, I will change it.
>
> > +     ok =3D ni && reparse_attr && (size >=3D sizeof(struct reparse_poi=
nt)) &&
> > +             (reparse_attr->reparse_tag !=3D IO_REPARSE_TAG_RESERVED_Z=
ERO) &&
> > +             (((size_t)le16_to_cpu(reparse_attr->reparse_data_length) =
+
> > +               sizeof(struct reparse_point) +
> > +               ((reparse_attr->reparse_tag & IO_REPARSE_TAG_IS_MICROSO=
FT) ?
> > +                0 : sizeof(struct guid))) =3D=3D size);
>
> A bunch of superflous braces.  But in general decomposing such complex
> operations into an inline helper using multiple if statements and
> adding comments improves the readability a lot.
Okay, I will update and add the comments.
>
> > +     if (ok) {
>
> ... and just return here for !ok and reduce the indentation for
> the rest of the function?
Right, I will change it like this.
>
> > +             switch (reparse_attr->reparse_tag) {
> > +             case IO_REPARSE_TAG_LX_SYMLINK:
> > +                     wsl_reparse_data =3D (const struct WSL_LINK_REPAR=
SE_DATA *)
> > +                                             reparse_attr->reparse_dat=
a;
> > +                     if ((le16_to_cpu(reparse_attr->reparse_data_lengt=
h) <=3D
> > +                          sizeof(wsl_reparse_data->type)) ||
> > +                         (wsl_reparse_data->type !=3D cpu_to_le32(2)))
> > +                             ok =3D false;
> > +                     break;
> > +             case IO_REPARSE_TAG_AF_UNIX:
> > +             case IO_REPARSE_TAG_LX_FIFO:
> > +             case IO_REPARSE_TAG_LX_CHR:
> > +             case IO_REPARSE_TAG_LX_BLK:
> > +                     if (reparse_attr->reparse_data_length ||
> > +                         !(ni->flags & FILE_ATTRIBUTE_RECALL_ON_OPEN))
> > +                             ok =3D false;
> > +                     break;
>
> ... and then directly return from inside the switch as well?
Right, I will change it.
Thanks for the review!
>
>

