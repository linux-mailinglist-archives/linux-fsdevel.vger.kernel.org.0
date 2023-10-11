Return-Path: <linux-fsdevel+bounces-105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C907F7C5AF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 20:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017F31C20F33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 18:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5251B292;
	Wed, 11 Oct 2023 18:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSffV+hh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892E43994A
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 18:08:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5A794
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 11:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697047736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w7blpLv0J//F7BcZFgIxGOOwVi3L4ZBiVEU1vZ31tc0=;
	b=eSffV+hhzVMP+nJd+3DYQaasjOjC/DXccvSCSffWzse/2IulaFA5tkR2RN1yxAs+PX5Gb9
	YkPnreUpAhE+9dYiz3EfVpwcefgfjfsyKcbYYXb9TrspP/6EFThC+YEDoU1lfEu5DottS2
	G/xGT5Qy+cJfYrZ0rqO0gQfUQFjgP/U=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-WvDUXeWVN5q5hLcjwF-O3g-1; Wed, 11 Oct 2023 14:08:50 -0400
X-MC-Unique: WvDUXeWVN5q5hLcjwF-O3g-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-5a7b5754de7so441477b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 11:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697047729; x=1697652529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w7blpLv0J//F7BcZFgIxGOOwVi3L4ZBiVEU1vZ31tc0=;
        b=eWtHf1b7VPix1c8+4fTzLiazFySMkoPd1JJuFxT/MFQx969xasSlzBVe3mw4usBHoG
         q97dsTgaom6DMhjOvYD7ZbvXQw+DTeKyJkp0fyx3c3y+Rtunwn3PABtAwC3Yt7gBH3lk
         7CFSsETMMIDrWIKnaCWQOaVMkvmHr54logbLND7fIafY+sSecmO6HZNsvYWeKf+XnyyZ
         N8TYzLJ+pM+djk+cNcu55SXMQ/06NOwIIiOu/0Ux3EryJ/WDMYLVRe0YUFIXs+zMxzui
         3MdNdIIRGcNgSeO0iKLMv/bwFW4YRsVyBBke+ChbxgETk7mr+tvcRR3CBtfbCBWsQ0xN
         VwSw==
X-Gm-Message-State: AOJu0YxF5xiJK7yJR2VMQqHiH2ZCoxta+RaOnDxxoLHul5m3bvY4kB5N
	JxuFpqGuBfrYHZLBae5cFukOcpPst2/znzN5FCFtbpJycqodDSF0HNb8LMz8jZLsultUv0Bu9af
	F/71e3M2VyTmowFlN5UQN8PIm72OiVYKLMVJ6hO33wQ==
X-Received: by 2002:a05:690c:4881:b0:5a5:60a:ab9c with SMTP id hd1-20020a05690c488100b005a5060aab9cmr19054622ywb.0.1697047728953;
        Wed, 11 Oct 2023 11:08:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMZN9xL50Mr2DfbYvPqLXCD77hidKpXHsBQvybh+8jeR6aqdXwZZurPzngQLC/0dsv2Ry33Ct7Wa6/FeAOqpI=
X-Received: by 2002:a05:690c:4881:b0:5a5:60a:ab9c with SMTP id
 hd1-20020a05690c488100b005a5060aab9cmr19054606ywb.0.1697047728684; Wed, 11
 Oct 2023 11:08:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005203030.223489-1-vgoyal@redhat.com> <20231010172107.GC1754551@fedora>
In-Reply-To: <20231010172107.GC1754551@fedora>
From: German Maglione <gmaglione@redhat.com>
Date: Wed, 11 Oct 2023 20:08:11 +0200
Message-ID: <CAJh=p+6_MrouagxuaM6myEc=PCW88xqNG-vesW2GsT9f+mr+-g@mail.gmail.com>
Subject: Re: [PATCH] virtiofs: Export filesystem tags through sysfs
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com, 
	miklos@szeredi.hu, mzxreary@0pointer.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 8:38=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Thu, Oct 05, 2023 at 04:30:30PM -0400, Vivek Goyal wrote:
> > virtiofs filesystem is mounted using a "tag" which is exported by the
> > virtiofs device. virtiofs driver knows about all the available tags but
> > these are not exported to user space.
> >
> > People have asked these tags to be exported to user space. Most recentl=
y
> > Lennart Poettering has asked for it as he wants to scan the tags and mo=
unt
> > virtiofs automatically in certain cases.
> >
> > https://gitlab.com/virtio-fs/virtiofsd/-/issues/128
> >
> > This patch exports tags through sysfs. One tag is associated with each
> > virtiofs device. A new "tag" file appears under virtiofs device dir.
> > Actual filesystem tag can be obtained by reading this "tag" file.
> >
> > For example, if a virtiofs device exports tag "myfs", a new file "tag"
> > will show up here.
> >
> > /sys/bus/virtio/devices/virtio<N>/tag
> >
> > # cat /sys/bus/virtio/devices/virtio<N>/tag
> > myfs
>
> If you respin this series, please mention that the tag is available at
> KOBJ_BIND time, but not KOBJ_ADD. Just a sentence or two is enough to
> help someone trying to figure out how to use this new sysfs attr with
> udev.

Maybe it's also worth mention, that the tag file is created after a success=
ful
probe, so the tag should be a valid one: non-empty and unique

>
> >
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  fs/fuse/virtio_fs.c | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>



--=20
German


