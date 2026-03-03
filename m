Return-Path: <linux-fsdevel+bounces-79247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLEmNBb4pmmgawAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 16:02:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F901F1F6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 16:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2816730B2110
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 14:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BFC47DD7A;
	Tue,  3 Mar 2026 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfIHgG9h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1F247DD70
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549776; cv=pass; b=X/bFPno53ZMbDl3aKqpfBEdPUqheQfeDmS+moyzpicugMNTGgUqtSJa9OrPCZhQy9jdtVelJHleRnAXLKavXmicRoqOYTA7NDLU35vBSURx3aRtwsut5LBKzmj/CSgBfGlClwMDeVDTWhnQC1UPzy+5WekCeIrglKnX/G8HNEg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549776; c=relaxed/simple;
	bh=5QoujqJkWgms6jqzEiHsaG7e0wdOWQp96Pzu/VCA4rA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bLrYfdWSDJkDgnxcLdmO2GU+ZcUnAsNILwEsXhqlBtYJUZy4St31sqvDQCTUyFN6AFvPzXcYl4PaF/QD1wGK2EYVg9CkABCMQbYd2FF1wUfqrea7bVjBX5UT+icVtgGWa1LurWV9YEnL2/Jh6IuxD1kzgE+uOKkei/xJK+yWYHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfIHgG9h; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8f97c626aaso1001145066b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2026 06:56:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772549773; cv=none;
        d=google.com; s=arc-20240605;
        b=bn48yA8cp3dUipEVTQCONqixUe3dh7925CkcQNAGaTkPf8p97He4yaMiJvxYVzMHJw
         GLb6sz3Ao/yejux4j7HFLBItArJD94ES5eqSJgNS2sroeenyozpbnAbDatRFMoIPHLhL
         THLlG71gggaTreFI6J+e7wDnQlt2jun4agJ1s2omp5DoBROu2sZQUH/d0ubR7TYuTRSE
         YZS5pymDGCXpDEcs/gpBkaqpaDr8rCWQ3HdQ/2TQcdO012mlZzheXQvq82j7B+yzDM5+
         kWv/wqmxZikC9AMO+Y8c/3FGF4czX9U8iLi79kXSmc+0y1LYb7G34AJDhf4rfxFBJg+G
         hKsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=udta42pxnBlFqxC1s4Qd1kLUvohusAt+5rXvzlylPvw=;
        fh=uikabjUoENshDuhH4G6aJskJ/WjIJGD2prwgUs22wiY=;
        b=VZnb7Bmmx2fub79N3wstUr/BPpjXg9x//iFRLJYGfoTUD2/ISXKy7A7LVPWuWuvx/a
         PVS1J1YSuD1U1rp98Ma61TBm0e5XW4gPSlkimhTZwxmZFpeRSBoLG9lDnoVI/BXWPDEV
         miYrZ23imv41aVA9YJeoey9cpkjVmk1Jc/TyYJn8LyXSJ2VlScX54pd/jvrNeXNCSfIZ
         qBcCTDgBEUK0GuyuUcVMuuxjb3GLSqBJM/pnBMCEGNDCUwzH85p8i2HpjRTIjV9LDl1C
         56cUmLixM8JwoelMkSDd0rAzYLxGI/0CQ45Pf/ByhKuJ50FO3GTcV4G6Xe8JLXvnRvBO
         CyCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772549773; x=1773154573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udta42pxnBlFqxC1s4Qd1kLUvohusAt+5rXvzlylPvw=;
        b=PfIHgG9hoaNHWSQc9BC3S25gqfPqDUvt5S6PuctIb6fwWpXcbC7JFsQIBhee0CCvFL
         11Y01HQsEbDWxuT9+61Fw2SuVkFUQTk0TBU8OSIkw00HdDpYAZC25w+EB3hlKuveJtxj
         17S6P13N06cDDc+E+mLu5QFZtFhYxr1vf9ujvT1Jhpu3kQZOwHYsg7RieyLxBtuX8KL2
         hDySVqTDbUPZPgS/NEB/TLAFkfUK89KjOZ9MhoBFg6ZIu2LzuGjOdBP01Q6QyROE95He
         42d3vIfntBkJEAikpwSLJlhwE+IWgWgG0cPIJzc3qDMmTZOEDi7OYAAtdUwHZnW9voks
         W5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772549773; x=1773154573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=udta42pxnBlFqxC1s4Qd1kLUvohusAt+5rXvzlylPvw=;
        b=E2+gyl14OL6zvLikxD+snjjX8cQ9SWQOlWhvCWv+2JK4UIh6zkoFc7pE0wRYkwIo4r
         aOHoSNirksDUvI6V81cw1Ch3aCHN11KlZl0CZd/TpuoTHBQG1JxwU0o3s/xXThmHRSPF
         XfpElK62uJL6ragaOgmrlGVrxmmmP/9ox9UP4HyJPKMyfioM0aRhdtann5FGLeNfRqcP
         0NgsAjtUIjuCUl9J+DBwxC79csId8eg6lpawnsR9awWcxKeQavXP4g5G5vACcPUDwWh2
         SK7tqN88We6sRiVqwwJcnfIUMmK8nHeDyKhAlG13qiweho97960ow0CR25LJo+yp3OFL
         2ZSg==
X-Forwarded-Encrypted: i=1; AJvYcCWlYwEFmgWV2bcxrCM7zZNJ5H1WXplsddfiBd4pkaXldNaz1eRMurS4cKzl/7qIDr7g5CfpklGWy1jcpqbX@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ/5Yw+o9tg1Q9VJ/5pabY2JI81oC9qXDO1JAs8vhir8gLey+z
	VWxtzFHa6EPjp2BlgebYL5rgtCqxoRnoYu0gts6LPuWb/4/Z7+TtPdcC4xUiu0i6QqpOiMTH2fy
	Tc9icxn2L6m0hOzDyl2GFznVTEP7Ws38=
X-Gm-Gg: ATEYQzyc3woxLWBZ1bhDkvHjOiIf3I5z0x5m1UIf5JjkM8t8/Aqn8Ki7Y5qDsVdkjyB
	t9rqeiJhmwOF9PcCceAG5btYFv96WHfDbAz8TGw/otnQCEjKahCgZVQDWaDY0TsvabdW3NQ7tLQ
	8D0RIQRmU4cUhSnNomNxu+2bNluusGoyROAJTupI0YIC7NP0jHGZv8QBXjG9We7CwAPp22ipTr9
	no4rugvxJruhwGLTd/851dPiUlG3Gv61AJVD5EV1mFg9XuYSG7uvGuCoIMYT8xRULLkLkONgVQ/
	VC3nVowqFo41yvaftVAym8FlN/NFi9ilEoaYriLGSA==
X-Received: by 2002:a17:907:1c90:b0:b93:892a:e82b with SMTP id
 a640c23a62f3a-b93892ae9f8mr888062766b.51.1772549772848; Tue, 03 Mar 2026
 06:56:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177249785452.483405.17984642662799629787.stgit@frogsfrogsfrogs>
 <177249785472.483405.1160086113668716052.stgit@frogsfrogsfrogs>
 <CAOQ4uxgmYNWCs18+WU9-7QDkhp0f_xX6nvKiyDhS8gZzfUXXXA@mail.gmail.com> <aab1Z7J-m97VfFvS@infradead.org>
In-Reply-To: <aab1Z7J-m97VfFvS@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Mar 2026 15:56:01 +0100
X-Gm-Features: AaiRm50Dm2AD3hFSZjiomm2u0pnUT4PvlIZrYEt7j6TT094HiewpP9Ly0nyguXc
Message-ID: <CAOQ4uxiruBkn=454AoxQuatK3CUve95Jkn=wBzU9hDkWWbFGPA@mail.gmail.com>
Subject: Re: [PATCH 1/1] generic: test fsnotify filesystem error reporting
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, zlang@redhat.com, linux-fsdevel@vger.kernel.org, 
	hch@lst.de, gabriel@krisman.be, jack@suse.cz, fstests@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 53F901F1F6A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79247-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 3:51=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Tue, Mar 03, 2026 at 10:21:04AM +0100, Amir Goldstein wrote:
> > On Tue, Mar 3, 2026 at 1:40=E2=80=AFAM Darrick J. Wong <djwong@kernel.o=
rg> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > Test the fsnotify filesystem error reporting.
> >
> > For the record, I feel that I need to say to all the people whom we pus=
hed back
> > on fanotify tests in fstests until there was a good enough reason to do=
 so,
> > that this seems like a good reason to do so ;)
>
> Who pushed backed on that?  Because IMHO hiding stuff in ltp is a sure
> way it doesn't get exercisesd regularly?
>

Jan and myself pushed back on adding generic fanotify tests to fstest
because we already have most fanotify tests in LTP.

LTP is run by many testers on many boxes and many release
kernels and we are happy with this project to host tests for the
subsystem that we maintain.

Thanks,
Amir.

