Return-Path: <linux-fsdevel+bounces-1327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0658B7D90F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 10:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886CD282494
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 08:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AF3154AC;
	Fri, 27 Oct 2023 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aHjwnsGI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD9515496
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 08:17:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C78111
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 01:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698394654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ouDL3Q+P4kOF4DRXdbPPiLhvDYpBpA3cyTxKCKn6rY=;
	b=aHjwnsGIjbrji7QsyhvZbtcZKm652ld5XKqZCFotS7i35wbyFw05sfSeMuGrHAKXwnLEPF
	ZSoAtxfXf1eSTRQC6e6RqK9SMvAQtV4ENE83a6xnIFcUspnz3O0VMTY3ptVxSZnAHP4bBk
	+JEUeom+1/uz0FdrFreB7O5PVFPldiI=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-2MWOJgg8NOSJcPM3xwDELg-1; Fri, 27 Oct 2023 04:17:32 -0400
X-MC-Unique: 2MWOJgg8NOSJcPM3xwDELg-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6b697b7f753so1708809b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 01:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698394652; x=1698999452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ouDL3Q+P4kOF4DRXdbPPiLhvDYpBpA3cyTxKCKn6rY=;
        b=Rs4O4ZwUxRa830CXMi3n+sqKBLbHy/LTD0ZbyOskwHTe3f4F5VCtJyJHOPOM423IX+
         Nv5iejMEqsQBbXSLUVQpHEjhhN35XJ5dWnJdRU09S68jei9VVUf4qhHeDkO0iOyiNZFm
         HPj4SetmX1qpl6Zu+s6977QAHdcEN2fBUWHnT48rGjk3Ru0/37BJUY4Lo9lS2uVpJ3bR
         Ie6t4MviR762iZ0AhtTizaNWAuHya2xSjaggCmiLFqjx3tXfvaVDDPP5kKfKSvFX0QB5
         i3PnY3Ms/xEjFmmsLh2YzjXE5e2rnQJ8Fwb0m5Ku5z5lKihkdRLwukZzB3KmdYqdd4MJ
         8Ong==
X-Gm-Message-State: AOJu0YwJDCps54jqiLnWxvExId1xoxVwCA5/RQR+59dAKmKmkYK/Y9cK
	LtHzNDsN1TrSYeDHhv4mVC1GT8QokQHjYKTX04xt2KNp5Jz8XnToqnK8sQ+ofzXIdJ4JloBVyJA
	B4eQELaAToloKwi7tGg1KgQDNq81zhfqDwvG4zs4B8A==
X-Received: by 2002:a05:6a21:33a4:b0:14c:c393:692 with SMTP id yy36-20020a056a2133a400b0014cc3930692mr2704229pzb.7.1698394651762;
        Fri, 27 Oct 2023 01:17:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTt9SvLiPEi281c5qYNL3fkkUk1SSE30SNu0c6PnpZmbzcGnqGfiaie561R0D3GgR9kSHXh0Ays6TCRh7/8Kw=
X-Received: by 2002:a05:6a21:33a4:b0:14c:c393:692 with SMTP id
 yy36-20020a056a2133a400b0014cc3930692mr2704213pzb.7.1698394651459; Fri, 27
 Oct 2023 01:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025140205.3586473-1-mszeredi@redhat.com> <20231025140205.3586473-3-mszeredi@redhat.com>
 <b69c1c17-35f9-351e-79a9-ef3ef5481974@themaw.net>
In-Reply-To: <b69c1c17-35f9-351e-79a9-ef3ef5481974@themaw.net>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Fri, 27 Oct 2023 10:17:20 +0200
Message-ID: <CAOssrKe76uZ5t714=Ta7GMLnZdS4QGm-fOfT9q5hNFe1fsDMVg@mail.gmail.com>
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

On Fri, Oct 27, 2023 at 5:12=E2=80=AFAM Ian Kent <raven@themaw.net> wrote:
>
> On 25/10/23 22:02, Miklos Szeredi wrote:

> > The mnt.mnt_list is still used to set up the mount tree and for
> > propagation, but not after the mount has been added to a namespace.  He=
nce
> > mnt_list can live in union with rb_node.  Use MNT_ONRB mount flag to
> > validate that the mount is on the correct list.
>
> Is that accurate, propagation occurs at mount and also at umount.

When propagating a mount, the new mount's mnt_list is used as a head
for the new propagated mounts.  These are then moved to the rb tree by
commit_tree().

When umounting there's a "to umount" list called tmp_list in
umount_tree(), this list is used to collect direct umounts and then
propagated umounts.  The direct umounts are added in umount_tree(),
the propagated ones umount_one().

Note: umount_tree() can be called on a not yet finished mount, in that
case the mounts are still on mnt_list, so umount_tree() needs to deal
with both.

> IDG how the change to umount_one() works, it looks like umount_list()
>
> uses mnt_list. It looks like propagate_umount() is also using mnt_list.
>
>
> Am I missing something obvious?

So when a mount is part of a namespace (either anonymous or not) it is
on the rb tree, when not then it can temporarily be on mnt_list.
MNT_ONRB flag is used to validate that the mount is on the list that
we expect it to be on, but also to detect the case of the mount setup
being aborted.

We could handle the second case differently, since we should be able
to tell when we are removing the mount from a namespace and when we
are aborting a mount, but this was the least invasive way to do this.

Thanks,
Miklos


