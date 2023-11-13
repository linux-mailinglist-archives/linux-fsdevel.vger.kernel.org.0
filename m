Return-Path: <linux-fsdevel+bounces-2786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568A57E9604
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 05:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85BA51C2098E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 04:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E30C8C3;
	Mon, 13 Nov 2023 04:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhOCt3GO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A778C11
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 04:15:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46011729
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Nov 2023 20:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699848915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ov+x7HzdGwyU+jHlaZfU1L5IZSQbEUUK1LixBfo2D/Y=;
	b=LhOCt3GOBjBfWhGnG/57+XocwCjQoczFu4DTsnWaJxc7GIPQhHL0U1Pi6DcWZH2QqnIDX8
	Kj2GG1x14hKlVLri2Bo7VUwX+y3hzff1PPNAK/RVhlAYVnw+DcH9BBgXIBiNGC5pWKmbL9
	1Nhgjro7Spw6YmTMfstegL2Si6TQvzI=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-slG0v_cVPF2vPCejHYZ2bg-1; Sun, 12 Nov 2023 23:15:12 -0500
X-MC-Unique: slG0v_cVPF2vPCejHYZ2bg-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-45d96e01bd7so1268725137.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Nov 2023 20:15:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699848912; x=1700453712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ov+x7HzdGwyU+jHlaZfU1L5IZSQbEUUK1LixBfo2D/Y=;
        b=X0VmWc34MK3rsYXh751BQn1T+7UuJXRlQvsh+UQkgW+viglpzrG4Z98kfTODPpvE0G
         whMhBUl8VOFMA6H+VUv/bZco2GEn9nh2xT7IXi9+JUyyE4VgdGVOVfcgdHN3mKeTGH/Y
         pDJop0aVcHBoBqs/63zZBb44BW6L0dSqSGRJTZjNS2T4wArxYPBLXpXqWaCECOPcuvh7
         SIVkNxjh2HVb4mtnoMES+JNaCYVMEXiuc6ov/D+RkO+IeqYAiQSJaRsptcB8Yhc3b9/w
         reJXXEFrFlrWkE2DsDwXieGl+QEfBEqwQGlRZGZDXl5W6qkMzkNCYojHP4iR8Q2kSdm2
         /4iA==
X-Gm-Message-State: AOJu0Yyy1BdtSlMYhki5965M7/e0mftnCvbypVww1wnhSAKq1OmGcz4S
	J8hT+JFQg1MnwyQN8moE0d4R+93yDhPX66qNV2smNTk5nVcSpTh8DfPZFFjIAG3LhI+zzT3ypHQ
	gifiZmgfs1NYjZzHW5jfQaXWpTnYPhC8aUegRi8KHwg==
X-Received: by 2002:a05:6102:2908:b0:460:621c:d14b with SMTP id cz8-20020a056102290800b00460621cd14bmr5940092vsb.20.1699848912129;
        Sun, 12 Nov 2023 20:15:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiNq1wy78YEV+FfLhVnSBPQqjbfUbc9rfWK0Z0GO4RCbMCmdaJaVtU9ExbYgGT6AwSDtX9ZsDt+FIJg1qTW9M=
X-Received: by 2002:a05:6102:2908:b0:460:621c:d14b with SMTP id
 cz8-20020a056102290800b00460621cd14bmr5940079vsb.20.1699848911851; Sun, 12
 Nov 2023 20:15:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110170615.2168372-1-cmirabil@redhat.com> <20231112-bekriegen-branche-fbc86a9aaa5e@brauner>
In-Reply-To: <20231112-bekriegen-branche-fbc86a9aaa5e@brauner>
From: Charles Mirabile <cmirabil@redhat.com>
Date: Sun, 12 Nov 2023 23:15:00 -0500
Message-ID: <CABe3_aHqQPjePNPsCu2GEt_uX4dZ0WVrFBQH5p+LCFE9JQxq7w@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] fs: Consider capabilities relative to namespace
 for linkat permission check
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, Seth Forshee <sforshee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 3:14=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Fri, Nov 10, 2023 at 12:06:14PM -0500, Charles Mirabile wrote:
> > This is a one line change that makes `linkat` aware of namespaces when
> > checking for capabilities.
> >
> > As far as I can tell, the call to `capable` in this code dates back to
> > before the `ns_capable` function existed, so I don't think the author
> > specifically intended to prefer regular `capable` over `ns_capable`,
> > and no one has noticed or cared to change it yet... until now!
> >
> > It is already hard enough to use `linkat` to link temporarily files
> > into the filesystem without the `/proc` workaround, and when moving
> > a program that was working fine on bare metal into a container,
> > I got hung up on this additional snag due to the lack of namespace
> > awareness in `linkat`.
>
> I agree that it would be nice to relax this a bit to make this play
> nicer with containers.
>
> The current checks want to restrict scenarios where an application is
> able to create a hardlink for an arbitrary file descriptor it has
> received via e.g., SCM_RIGHTS or that it has inherited.
Makes sense.
>
> So we want to somehow get a good enough approximation to the question
> whether the caller would have been able to open the source file.
>
> When we check for CAP_DAC_READ_SEARCH in the caller's namespace we
> presuppose that the file is accessible in the current namespace and that
> CAP_DAC_READ_SEARCH would have been enough to open it. Both aren't
> necessarily true. Neither need the file be accessible, e.g., due to a
> chroot or pivot_root nor need CAP_DAC_READ_SEARCH be enough. For
> example, the file could be accessible in the caller's namespace but due
> to uid/gid mapping the {g,u}id of the file doesn't have a mapping in the
> caller's namespace. So that doesn't really cut it imho.
Good point.
>
> However, if we check for CAP_DAC_READ_SEARCH in the namespace the file
> was opened in that could work. We know that the file must've been
> accessible in the namespace the file was opened in and we
> know that the {g,u}id of the file must have been mapped in the namespace
> the file was opened in. So if we check that the caller does have
> CAP_DAC_READ_SEARCH in the opener's namespace we can approximate that
> the caller could've opened the file.
Would that be the namespace pointed to by `->f_cred->user_ns`  on the
struct file corresponding to the fd?

If so is there a better way to surface that struct file for checking than t=
his?
error=3D-ENOENT;
if(flags & AT_EMPTY_PATH && !old->name[0]) {
    struct file *file =3D fget(oldfd);
    bool capable =3D ns_capable(file->f_cred->user_ns, CAP_DAC_READ_SEARCH)=
;
    fput(file);
    if(!capable)
        goto out_putnames;
}
>
> So that should allow us to enabled this for containers.
>
Best - Charlie


