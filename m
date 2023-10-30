Return-Path: <linux-fsdevel+bounces-1532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FF37DB5C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 10:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75627281584
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 09:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B978FD52C;
	Mon, 30 Oct 2023 09:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AggfYkFE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0FBD51B
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 09:06:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C59FBD
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 02:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698656792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y0atX0+sSSXblFLFWLmbV5ArNow5LoKvzRBMtZdLmQk=;
	b=AggfYkFE20GlBuawllO5ZB4I+LKFFFKPUq/NF+GXc8I5i5f9pi830IdWMZAtciqApXaA5m
	ea9OBsgIlQdJBUf0lRMJV6FOXrHfsSXQZbdPdUvowt4SptHRtcfKrvZuDoGQ8y2RERIHxI
	g3heZGPXu2M34kFdfexJwPBeSFAhmR0=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-PL0Vi1NwPTK_C4ce4EVK2w-1; Mon, 30 Oct 2023 05:06:30 -0400
X-MC-Unique: PL0Vi1NwPTK_C4ce4EVK2w-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6b9af7d41c6so2922744b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 02:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698656789; x=1699261589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0atX0+sSSXblFLFWLmbV5ArNow5LoKvzRBMtZdLmQk=;
        b=Rvx+RGEQy9h6VHOQEF+dbpU3MLd0XdcPRgmQXSkVa/MG7cH0u/+gNZ2OpY1k7j0t2p
         6lBRiepbYFeUuVzInFxWQTQ6mogbwF56urSpdiVozDEBH3ijdyVWsxgeDgc4tnA0VXxc
         HLKeShNq2HVhdvviMquY68Ytq3VtM9RPEmeOi4V9b7mS8Gg2Z8QxS4+1VjSgZ7I8JOse
         10ZtEdvp0QgOZMcPag3RPEZeqPedvfXpU94Zu027rTNgx3igh27bS9US1HQTMFPGi0UB
         VZ6bAjqcQ7v03ScMqAGe7yOM09QDkRAbq+cyQqml4JGCkz9b+mQVu0YGr1LxfVsh49Yh
         uPNQ==
X-Gm-Message-State: AOJu0YwMCNEjsOhnjDZ3wQB/fU2Lm5F7Melv5ocRyZgsCdEfxfaZhac/
	+BBqYIPGBpyKnCEMX7vvs/4hLdHt/ujYOkAZ6aKmCpCxapA1ayahofFfSPZR96KyjqhJ/ZBN8wR
	MTTuCn2fLhuRpKmK6VMFJF+ptlaRbua/WuUasK0fHxMO9l7kidQ==
X-Received: by 2002:a05:6a20:7d8a:b0:171:a8bc:74b2 with SMTP id v10-20020a056a207d8a00b00171a8bc74b2mr8574557pzj.7.1698656789545;
        Mon, 30 Oct 2023 02:06:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgI6VSfuoAE2RQro4OApKzTh51pBH7xn4E0oXjcNFufoZcmb5hUYyAZ9Iwz2uBJUgmSjdLrxau1bmihHZXQhg=
X-Received: by 2002:a05:6a20:7d8a:b0:171:a8bc:74b2 with SMTP id
 v10-20020a056a207d8a00b00171a8bc74b2mr8574537pzj.7.1698656789216; Mon, 30 Oct
 2023 02:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025140205.3586473-1-mszeredi@redhat.com> <20231025140205.3586473-3-mszeredi@redhat.com>
 <b69c1c17-35f9-351e-79a9-ef3ef5481974@themaw.net> <CAOssrKe76uZ5t714=Ta7GMLnZdS4QGm-fOfT9q5hNFe1fsDMVg@mail.gmail.com>
 <c938a7d9-aa9e-a3ad-a001-fb9022d21475@themaw.net> <dfb5f3d5-8db8-34af-d605-14112e8cc485@themaw.net>
 <cbc065c0-1dc3-974f-6e48-483baaf750a3@themaw.net>
In-Reply-To: <cbc065c0-1dc3-974f-6e48-483baaf750a3@themaw.net>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Mon, 30 Oct 2023 10:06:18 +0100
Message-ID: <CAOssrKdvTrPbnicFTiCiMNhKfdfwFEv4r_y1JeEe+H5V6LpkKg@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] mounts: keep list of mounts in an rbtree
To: Ian Kent <raven@themaw.net>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-man@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>, 
	David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>, 
	Amir Goldstein <amir73il@gmail.com>, Matthew House <mattlloydhouse@gmail.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 6:45=E2=80=AFAM Ian Kent <raven@themaw.net> wrote:

> Is fs/namespace.c:iterate_mounts() a problem?
>
> It's called from:
>
> 1) ./kernel/audit_tree.c:709: if (iterate_mounts(compare_root,
> 2) ./kernel/audit_tree.c:839:    err =3D iterate_mounts(tag_mount, tree, =
mnt);
> 3) ./kernel/audit_tree.c:917:        failed =3D iterate_mounts(tag_mount,
> tree, tagged);
>
>
>  From functions 1) audit_trim_trees(), 2) audit_add_tree_rule() and
>
> 3) audit_tag_tree().

So that interface works like this:

 - collect_mounts() creates a temporary copy of a mount tree, mounts
are chained on mnt_list.

 - iterate_mounts() is used to do some work on the temporary tree

 - drop_collected_mounts() frees the temporary tree

These mounts are never installed in a namespace.  My guess is that a
private copy is used instead of the original mount tree to prevent
races.

Thanks,
Miklos


