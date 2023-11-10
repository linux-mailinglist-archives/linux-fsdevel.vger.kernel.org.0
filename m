Return-Path: <linux-fsdevel+bounces-2730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206FC7E7DF2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 18:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4756A1C209FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 17:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD381DFE5;
	Fri, 10 Nov 2023 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Kw4Hrtks"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160C72F4A
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 17:00:34 +0000 (UTC)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA09642C07
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 09:00:33 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-da41e70e334so2312301276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 09:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699635633; x=1700240433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kjh5T8h9wjxj8rwI5k7AoyiBDuBw6RmJFRrtLAbwBaI=;
        b=Kw4Hrtks//V9GCBFNsZN64xQVmTkfjmZ2nrWWg5E0PLCIPDp8/N4lquzKdEtcwEuAc
         kpi1NA9RktLVAvG6JCjFaOfiq9amoXyXvHwnszhmYD1Vni0IuWmtBQVeOyleJRm7Eh7L
         RxFQPh7regjuw7pZBtrgeU37b1FeIfRjSMulzUq5tfsGqoYL+lzbwHmck8OoyAx6A1Wz
         lLvLDUlqbWoKcKWG3oI9MDTDXhMYsjRJWKINHMrELPSRk60MD+PC5TkkzURFdVnnuDCn
         x5suwLfwKN1hpizNDNvlfwFpYsSc5uI5QYN+1IXoCPmvmE51mlNaszQLnpMrsqVhgL/g
         fcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699635633; x=1700240433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kjh5T8h9wjxj8rwI5k7AoyiBDuBw6RmJFRrtLAbwBaI=;
        b=ZZjN5URtmzbMNHnJQxNCrmmXLEqjVSsAA+InDFqzsOmatMil6EB18mjqdQ7BSbukp8
         +hnrJ4omhBTxqte2aE5CV1Dfe8m3Izdgp09c7yKPfeVruyN9QJxKbuGHpLKKFtAGyWRp
         cS7HuU+PsRC/NxTjMUMgZ2igQwSQ+rvZd1V6sqCYm/AOqBFkRCoPgH9jJ3WNp9jOaJWb
         bxVB3mbRmGcI/gC4bv07ViDg1OQGnE7EX+XpZgdAyjSdLkJRNh3xgs3VeAIXV6QOWQls
         L84Q6vtXh3k+Ni/T9i9LurihXelC1GBHAtlBPcGNq91YYgsAXrrjeuCWp9yvWe0tWoHc
         trTA==
X-Gm-Message-State: AOJu0Yw3V06FIpR1cWgJyG6f0fHgfY5biH264u8CECSJAK99lLLkcoMU
	9oQ//GKvVXhRkmb4fUzsqHS12TEjJ4oBdc6BAoDC
X-Google-Smtp-Source: AGHT+IF6xmEmxjE5GSzP9TQylnTchoY8j5jR2rrNMdTsWqEfb4oLHP+Gj+Gl+tpZ0BvJlavju/oaKfSsOp4JqZZ+zWk=
X-Received: by 2002:a25:ca17:0:b0:d9a:4870:7943 with SMTP id
 a23-20020a25ca17000000b00d9a48707943mr8823635ybg.28.1699635632941; Fri, 10
 Nov 2023 09:00:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025140205.3586473-5-mszeredi@redhat.com> <4ab327f80c4f98dffa5736a1acba3e0d.paul@paul-moore.com>
 <20231108-zwerge-unheil-b3f48a84038d@brauner> <CAHC9VhSLGyFRSbeZXE7z61Y2aDJi_1Dedjw0ioFOckRCs0CRaA@mail.gmail.com>
In-Reply-To: <CAHC9VhSLGyFRSbeZXE7z61Y2aDJi_1Dedjw0ioFOckRCs0CRaA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 10 Nov 2023 12:00:22 -0500
Message-ID: <CAHC9VhRvYua4noiHbMqcAqz=Rkz=pxSgp5fVxXX+uhz61jYFag@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] add statmount(2) syscall
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-man@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <christian@brauner.io>, Amir Goldstein <amir73il@gmail.com>, 
	Matthew House <mattlloydhouse@gmail.com>, Florian Weimer <fweimer@redhat.com>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 3:10=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Wed, Nov 8, 2023 at 2:58=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> > > > +static int do_statmount(struct stmt_state *s)
> > > > +{
> > > > +   struct statmnt *sm =3D &s->sm;
> > > > +   struct mount *m =3D real_mount(s->mnt);
> > > > +   size_t copysize =3D min_t(size_t, s->bufsize, sizeof(*sm));
> > > > +   int err;
> > > > +
> > > > +   err =3D security_sb_statfs(s->mnt->mnt_root);
> > > > +   if (err)
> > > > +           return err;
> > > > +
> > > > +   if (!capable(CAP_SYS_ADMIN) &&
> > > > +       !is_path_reachable(m, m->mnt.mnt_root, &s->root))
> > > > +           return -EPERM;
> > >
> > > In order to be consistent with our typical access control ordering,
> > > please move the security_sb_statfs() call down to here, after the
> > > capability checks.
> >
> > I've moved the security_sb_statfs() calls accordingly.
>
> Okay, good.  Did I miss a comment or a patch where that happened?  I
> looked over the patchset and comments yesterday and didn't recall
> seeing anything about shuffling the access control checks.

Gentle ping on this.  I'm asking because I know there have been issues
lately with the lists and some mail providers and I want to make sure
I'm not missing anything, I double checked lore again and didn't see
anything there either, but I might be missing it.

--=20
paul-moore.com

