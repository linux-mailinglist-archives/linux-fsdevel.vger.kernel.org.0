Return-Path: <linux-fsdevel+bounces-76181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FbgEVfMgWl1JwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 11:22:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9826CD784B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 11:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC04B303AB56
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 10:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA3A3115A1;
	Tue,  3 Feb 2026 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHQWJLGc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F94E304BB4
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114026; cv=pass; b=bif+v5fmE5ILBY4H3X70ZZgtDujYelPnPmAj/T8KVYeofCj14ACR5vNAFUUKHjpqxbTUYSvicbhU92NVbZySvenQ9QjmoNNDlRyrdwjmk1mXg4CaqrAQcTTMGkBosA+RDlGpt/eF32MoQFEpotwRrY2pvKsEXWoAJjkEbVpJ+VM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114026; c=relaxed/simple;
	bh=sVM0+hEP4PdpJC59WffH3ZxbPipWAX0zZaMuRpIJiF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5/OHClSGuZAYvIMQiuGIUuuZKUzfsQGEs61Pbo/i1oo/5ZNaab/HVQG5ZcAR+x43VUT1I3HrtXPHqd/Uqln/nxMMTpRbwNpIdf2Z8YUffxBMxl5kkNrx1Ek7akUbIHCUd3Jfb0TdCGcARyhC+yHZc59fD/IztLd+ZfiM6+j8Kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHQWJLGc; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65941c07fb4so229147a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 02:20:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770114023; cv=none;
        d=google.com; s=arc-20240605;
        b=EhUN6iGEgnXy1spcHsUVE+gY468VOFytGyntaXoDT4LDUcZ6TfGoDYbZv4u+lVieQ7
         vyNP0aCv+tkDQg36KlZFvg3e/UTWC3692Wgu3xXmKPs26sI+Yx92l5WBSbKUFIZ3GgkO
         Hl0zqR0jbW/jD7r4ZziigBh5Ioiq3IrVUnYErnCghHSms4GiWmnmZOlA2ULeo7/qnxq3
         B9v2FY5ua9Ln842GdzKlvSTljr0M1AQhYEybTBgT1L/QNmYzZHR+Csl2M1gq7u0Mdhnv
         y00vMoGNz8lE62efEzfDx0Ylk7s0rtsFyMjAdbiirESpW318hrW2aLAGR6nodn+ANR6F
         +AzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gjTcDMssS6pyQf8XKQ4J7kd/rjxdjsXPIt+uqkYRZO8=;
        fh=Gmi6GZsnAKYGi8ZNBqMcwIrlyDkF0NLRnka3IiQe3v4=;
        b=Yz1YJk/Fc33V//ILCVPEkl4MBzjxLDX6bPKL16ywkPVOhfLgpsgMog7WMfAHNvldzf
         u2vmqg9Fd4bFZJUq9C3lmfsNE7JuG1Dlbd7Og14F261kYPIklrDi00Eh040eGAfUMdef
         LD/qFaoOgORyco9K2tKfQTNrIkCzBpQObvxifw0GrYXouM4C57SqKYdOswHnq9UmKWga
         D9zS7HczY4+RZV9pOG2blmFwmTS3UNa1GAWHGLYUm0xEFxs+pDZ+8+23nuvedwL7mzqI
         qKUkv2LCCQ7nHMDINi9Ii3dJ0JDDqDkuXtFZKPeL3F45M45T0x9FoxQzXHYg1JwHHg7W
         /IVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770114023; x=1770718823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjTcDMssS6pyQf8XKQ4J7kd/rjxdjsXPIt+uqkYRZO8=;
        b=IHQWJLGcJqbE5TbUthlxgJQoqd467zxTdbexLgxZZOlA2O/a798YBJPLiRnKMnxb5W
         3dQx3SYPXMJOAPfxHnREmmvMmd9KDDgZmOSCh/TbfMEaL2Cpv9Qx7Jfu17JPnxg3KvX7
         dfRjJASQYt++pdol/0FiycE1crkiKblRlS1NPFI2UJmjX4P6AsbGq/oE3BIWPU8B7SNh
         uA1ArhZLmVrsHwUZpbQvTxyAWDfSUMdRIFPBaGvKo5m/UC0Ipu6LiXOnyHEz3vLrauHX
         GSDPFvB0ZJHzbIkXSw1T1DofOCiV5p4tb8FpDy4LJ1fHlAdzSNhQiquPRoNIus9LPXKg
         yUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770114023; x=1770718823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gjTcDMssS6pyQf8XKQ4J7kd/rjxdjsXPIt+uqkYRZO8=;
        b=YlfYHGRlfqImchsomtFrm/c1gWWwt6oGfloQtlS9yIElH+r5dWghesJqacQCof1oCJ
         7/tpAtFXsr2hsubl7ZIdyzJ6WMfkyF85xiqMFmxcVg5Lu80TgP2B/5tZjVv3R1hGl67m
         CNOka/XcmGC6X9VEbAW84Zk2coXth/ApQ7dr6gA7zX90wEky8+rcx9YYxOXa6mFmnHrb
         eMDShOGImfL8u+LA3ivSqaHZfdydj4ivkKGLwlwjFbe/B4kXNooXNCKhplKfVIABnDhF
         Izp7WzEjs/+dpvgvfGqRN5i6NNSG1zZUIG/SaYmK4Qvk9bQosM7hWg1muQrdrl100I5D
         XeNw==
X-Forwarded-Encrypted: i=1; AJvYcCWl71zBuHPfU2Xh3jApmIEV7ziZclz5gXU2+px+/e933q/vx9p1Ax1/i8jzjS6CDk4glyhRROd/SQ3haBlx@vger.kernel.org
X-Gm-Message-State: AOJu0YxAPhczcQQ9UybJ6L+1/YD6JXE5OIdNp2wWMx+UjR0LGM+w8+tD
	T5m3p13FNs/I2GFVe3ye9GtTmXtVGdoQ/jF+UX0GC7B2eEjaInN0xBNJ4YR1iuHNcfNrqAkBUEe
	aqIxufkp1MK7qBma/8j23w1EVhI4PkMU=
X-Gm-Gg: AZuq6aIHIKhtJ9feQV7IRVirdimDRDMehedtb/I6vZvtBiZjhJVsJHoFG8w/iSX31T9
	mxqd88bkQDKIFv9LhHXd08W6TNIRvNV9cE4/pg2RZTQgSkzojir3w8SAcJEfWJAAJFb6AQOkqqb
	btJH+cv4b9WVfBxfpWrJwrrXy4xTpA4J3p8HlqWsPo1r3ErcubnLJgvhoFjRn0jHw5Ir5b7IUMF
	lIq2cwIYfRVvVm5LKGvWA8XGQU/zPDdxvfT1JT4D2fcvOAwvtAmaE4soylm5EBUsmNiLZkWnD1P
	zfRXfSL7BmaOl4OYw/cC44d7XuRUag==
X-Received: by 2002:a05:6402:42c5:b0:64d:498b:aefd with SMTP id
 4fb4d7f45d1cf-658de54f012mr8656942a12.5.1770114023260; Tue, 03 Feb 2026
 02:20:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <CAOQ4uxjEdJHjbfCFM364V=tBrEyczYvzo-b-Xo0UPOCA2cnPGQ@mail.gmail.com> <87cy2myvyu.fsf@wotan.olymp>
In-Reply-To: <87cy2myvyu.fsf@wotan.olymp>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Feb 2026 11:20:12 +0100
X-Gm-Features: AZwV_Qg75JZKui3VPxcY59EJLbTYypK2pwBrPu4und1ir7d3h5i87YqZo7ZwE-M
Message-ID: <CAOQ4uxjKHptXXCJzpwU6jvGKiqTuRBOSesmpzGGUTgcJqW_gbQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Joanne Koong <joannelkoong@gmail.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>, 
	Horst Birthelmer <horst@birthelmer.de>, lsf-pc <lsf-pc@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,szeredi.hu:email];
	FREEMAIL_CC(0.00)[szeredi.hu,vger.kernel.org,gmail.com,kernel.org,groves.net,bsbernd.com,birthelmer.de,lists.linux-foundation.org];
	TAGGED_FROM(0.00)[bounces-76181-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 9826CD784B
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 11:15=E2=80=AFAM Luis Henriques <luis@igalia.com> wr=
ote:
>
> On Mon, Feb 02 2026, Amir Goldstein wrote:
>
> > [Fixed lsf-pc address typo]
> >
> > On Mon, Feb 2, 2026 at 2:51=E2=80=AFPM Miklos Szeredi <miklos@szeredi.h=
u> wrote:
> >>
> >> I propose a session where various topics of interest could be
> >> discussed including but not limited to the below list
> >>
> >> New features being proposed at various stages of readiness:
> >>
> >>  - fuse4fs: exporting the iomap interface to userspace
> >>
> >>  - famfs: export distributed memory
> >>
> >>  - zero copy for fuse-io-uring
> >>
> >>  - large folios
> >>
> >>  - file handles on the userspace API
> >>
> >>  - compound requests
> >>
> >>  - BPF scripts
> >>
> >> How do these fit into the existing codebase?
> >>
> >> Cleaner separation of layers:
> >>
> >>  - transport layer: /dev/fuse, io-uring, viriofs
> >>
> >>  - filesystem layer: local fs, distributed fs
> >>
> >> Introduce new version of cleaned up API?
> >>
> >>  - remove async INIT
> >>
> >>  - no fixed ROOT_ID
> >>
> >>  - consolidate caching rules
> >>
> >>  - who's responsible for updating which metadata?
> >>
> >>  - remove legacy and problematic flags
> >>
> >>  - get rid of splice on /dev/fuse for new API version?
> >>
> >> Unresolved issues:
> >>
> >>  - locked / writeback folios vs. reclaim / page migration
> >>
> >>  - strictlimiting vs. large folios
> >
> > All important topics which I am sure will be discussed on a FUSE BoF.
>
> I wonder if the topic I proposed separately (on restarting FUSE servers)
> should also be merged into this list.  It's already a very comprehensive
> list, so I'm not sure it's worth having a separate topic if most of it
> will (likely) be touched here already.
>
> What do you think?

We are likely going to do a FUSE BoF, likely Wed afternoon,
so we can have an internal schedule for that.

Restartability and stable FUSE handles is one of the requirements
to replace an existing fs if that fs is NFS exportrable.

Thanks,
Amir.

