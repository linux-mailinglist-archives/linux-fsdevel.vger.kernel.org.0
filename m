Return-Path: <linux-fsdevel+bounces-1079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEF97D536B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 15:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 729FCB2103F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 13:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180162B75C;
	Tue, 24 Oct 2023 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="dBGQjqFy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BFE125DE
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 13:58:01 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977262720
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 06:57:58 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9c603e2354fso937218366b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 06:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1698155877; x=1698760677; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CFq2Fg3zVAnOrmEfLn53FQxN7jmqeIO+YSPDEZIOjqc=;
        b=dBGQjqFyfkxCERh0ht6T4zHtOMCIAEEElWD0aSCE56alg9Tf21JyvwveX0xPtdPfJM
         2lNl7cJUacZQZfQsx6uluR+8JzJ/pMrkSihbCje0m4cS3jM8oLrrlfpDYCiy6VeP+X72
         nsEYRXs8dvXwPwr3u5i/31goOMOKzmLc8zBag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155877; x=1698760677;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CFq2Fg3zVAnOrmEfLn53FQxN7jmqeIO+YSPDEZIOjqc=;
        b=SFZORk/zE2doPEngb5yz/Wr0IHf79qrzxleWu7lag8MbCVNArhJ/QYCw/RX5roo/Mx
         s+5kaXgyEyJglfBsmH+9X8Q6mg4K4n8rzW1vEeV2wdiooIxf0/ha5fPgHuniBeAfJ4CC
         LhKVlVgFMm0yOocdR0j6nSc/D3DkHwSkwx+/m7ScHjk2SAjz6RKHGkXLTI594EfGLd6p
         fLfvQ6KqdXteceuz6zr+udzx1cM5CjMs+D78Wtk/9UImoJQQQAnDOTmWlqIYlnKLszk0
         oB/W4o8oSref9xUsQOWth0ar5vZlZVODs4D/b3x20aZspGlBttlolf8AJE+f8F8w1wVE
         cxJw==
X-Gm-Message-State: AOJu0Yzy3uDS/mm2v+AaG8BpmjtMh0p/QGJbDx80ahQushNKiF1c4O4X
	rEyPzmQyisEpnzayN2rpHPPtAjLRgp0kTd21qtM4iA==
X-Google-Smtp-Source: AGHT+IEV11aVuDatR+GsbiTzkdam4eLmDzs7DndyyWqozB2d9zhCaHb3NdyEF13kC/pQx/zoObUqvAUWAIwVd1XT2cQ=
X-Received: by 2002:a17:907:94cd:b0:9ae:614e:4560 with SMTP id
 dn13-20020a17090794cd00b009ae614e4560mr9998911ejc.29.1698155877064; Tue, 24
 Oct 2023 06:57:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230928130147.564503-1-mszeredi@redhat.com> <20230928130147.564503-5-mszeredi@redhat.com>
 <CAHC9VhQD9r+Qf5Vz1XmxUdJJJO7HNTKdo8Ux=n+xkxr=JGFMrw@mail.gmail.com>
 <CAJfpegsPbDgaz46x4Rr9ZgCpF9rohVHsvuWtQ5LNAdiYU_D4Ww@mail.gmail.com>
 <a25f2736-1837-f4ca-b401-85db24f46452@themaw.net> <CAJfpegv78njkWdaShTskKXoGOpKAndvYYJwq7CLibiu+xmLCvg@mail.gmail.com>
 <7fe3c01f-c225-394c-fac5-cabfc70f3606@themaw.net> <c45fc3e5-05ca-14ab-0536-4f670973b927@themaw.net>
In-Reply-To: <c45fc3e5-05ca-14ab-0536-4f670973b927@themaw.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 24 Oct 2023 15:57:45 +0200
Message-ID: <CAJfpegvTFFzCN9nssL0B6g97qW5xbm6KsrFPRqtSp5B1jaYbLg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] add listmount(2) syscall
To: Ian Kent <raven@themaw.net>
Cc: Paul Moore <paul@paul-moore.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-man@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>, 
	David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>, 
	Amir Goldstein <amir73il@gmail.com>, Matthew House <mattlloydhouse@gmail.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Oct 2023 at 04:40, Ian Kent <raven@themaw.net> wrote:

> But because we needed to enumerate mounts in the same way as the proc file
>
> system mount tables a flag FSINFO_ATTR_MOUNT_ALL was added that essentially
>
> used the mount namespace mounts list in a similar way to the proc file
>
> system so that a list of mounts for a mount namespace could be retrieved.

Makes sense.

Added a LISTMOUNT_RECURSIVE flag.

Thanks,
Miklos

