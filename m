Return-Path: <linux-fsdevel+bounces-2092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C4B7E259E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 14:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99A0E1C20BB1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 13:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42011249F6;
	Mon,  6 Nov 2023 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJ1o35PI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B90241F4
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 13:33:41 +0000 (UTC)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55BD107;
	Mon,  6 Nov 2023 05:33:36 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-41cc75c55f0so44849271cf.1;
        Mon, 06 Nov 2023 05:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699277616; x=1699882416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kfYO/jqXsEVbiPCa+98Wg6yWGKOyc07wJKMC7BNdsQ=;
        b=YJ1o35PIC4Ts2CiYbaO5InTOJCdp2W7SskqYLl9q2vqf+5AEaGZF7dAojOCI9X5t90
         DiCanFZPGEx9nlNg5Gc4JwwIPYgp5yandgOoVe2/qUFP7R3sTyum/blrVhTJdo1UfOXS
         +4XeJ6OMnDdAs9j8r+Y1gKB8JzkBrPKJ4ovcpsuHuKGgNwid+6xecdyvawhLWlQpFNJ/
         niK3A7Q7HvFUwLYEjYdHxNwreJ5ljubf2TKqlROFTlK8bNQUEYXrj5SyUsSLHuydDkPu
         KDYKWXzk3L206GKeUdw3aHN5ePdbYbsyail+37Mc6Yydmy1btxsNi7wBdM6a8JmbJ7hn
         fowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699277616; x=1699882416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kfYO/jqXsEVbiPCa+98Wg6yWGKOyc07wJKMC7BNdsQ=;
        b=qIPrdjANE2+oW+qdHswEheUZ1Y7/QoLBC7jgkbnqontKWD8Ie8PoovkonHq/EPHFeZ
         wXp2aJT+FlHEntIuNcFnCx/S8qZy5TllZiUPHoukWSnRLn5l8m+kuGRbQd6l+ARjYrCf
         LBfWV/UxwdhA2A80XgqPhFVTZjA8VRT0it2bmMNblC9gp5QyaxEP+Tb7TgqQ2z3uL5y8
         qJw3x5Y/NkNz+1Q9Rb8zeOJqyRxmUobQmxCHPCFvKH9TVYSE86mD2hSOCIBHOKwolY0r
         StDC7ZdLTnfBnf/RpYdBBqb5z3/KUlwrqm8v/Se+LFTlwLmflYm2qcEFUYTU9Yp2m9st
         xmNw==
X-Gm-Message-State: AOJu0YxcmPPlWz6uY2vhec2/PoLO+ey0Q4shJ9VVkKi0lJxKADfi0xHa
	RJR5LqXVt778X/3t9Nivr6ky1G+p7TyPfz/5EQz65peEK/w=
X-Google-Smtp-Source: AGHT+IGfna+ns1OJYt9vnIpo34kwqS4zK3N8Q0DIkJXGI7keTrtYAHV1O3+FoRhLDkMnqRpc5FeiUhOWpjUGAD2eMr0=
X-Received: by 2002:a05:6214:482:b0:66f:b7ff:1e12 with SMTP id
 pt2-20020a056214048200b0066fb7ff1e12mr16096792qvb.20.1699277615718; Mon, 06
 Nov 2023 05:33:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025140205.3586473-1-mszeredi@redhat.com> <374433e3-ab72-64a3-0fa0-ab455268e5e0@themaw.net>
 <20231106121053.egamth3hr7zcfzji@ws.net.home>
In-Reply-To: <20231106121053.egamth3hr7zcfzji@ws.net.home>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 6 Nov 2023 15:33:23 +0200
Message-ID: <CAOQ4uxgn--PshKxMDmM4YoDQ8x3+a0NwCv+Bppjq-3w9V+Sxpg@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] querying mount attributes
To: Karel Zak <kzak@redhat.com>
Cc: Ian Kent <raven@themaw.net>, Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-man@vger.kernel.org, linux-security-module@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>, 
	Matthew House <mattlloydhouse@gmail.com>, Florian Weimer <fweimer@redhat.com>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 2:11=E2=80=AFPM Karel Zak <kzak@redhat.com> wrote:
>
> On Wed, Nov 01, 2023 at 07:52:45PM +0800, Ian Kent wrote:
> > On 25/10/23 22:01, Miklos Szeredi wrote:
> > Looks ok to me,covers the primary cases I needed when I worked
> > on using fsinfo() in systemd.
>
> Our work on systemd was about two areas: get mount info (stat/listmount()
> now) from the kernel, and get the mount ID from notification.
>
> There was watch_queue.h with WATCH_TYPE_MOUNT_NOTIFY and struct
> mount_notification->auxiliary_mount (aka mount ID) and event subtype
> to get the change status (new mount, umount, etc.)
>
> For example David's:
>  https://patchwork.kernel.org/project/linux-security-module/patch/1559917=
11016.15579.4449417925184028666.stgit@warthog.procyon.org.uk/
>
> Do we have any replacement for this?
>

The plan is to extend fanotify for mount namespace change notifications.

Here is a simple POC for FAN_UNMOUNT notification:

https://lore.kernel.org/linux-fsdevel/20230414182903.1852019-1-amir73il@gma=
il.com/

I was waiting for Miklos' patches to land, so that we can report
mnt_id_unique (of mount and its parent mount) in the events.

The plan is to start with setting a mark on a vfsmount to get
FAN_MOUNT/FAN_UNMOUNT notifications for changes to direct
children of that mount.

This part, I was planning to do myself. I cannot say for sure when
I will be able to get to it, but it should be a rather simple patch.

If anybody else would like to volunteer for the task, I will be
happy to assist.

Not sure if we are going to need special notifications for mount
move and mount beneath?

Not sure if we are going to need notifications on mount attribute
changes?

We may later also implement a mark on a mount namespace
to get events on all mount namespace changes.

If you have any feedback about this rough plan, or more items
to the wish list, please feel free to share them.

Thanks,
Amir.

