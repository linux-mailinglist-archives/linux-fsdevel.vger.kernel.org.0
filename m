Return-Path: <linux-fsdevel+bounces-1230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B07E7D7F76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 11:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C51FA281F1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 09:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF2027721;
	Thu, 26 Oct 2023 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CX8ghylP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AA8262B1
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 09:21:36 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B38184
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 02:21:34 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c9d4f08d7cso140025ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 02:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698312094; x=1698916894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZMZ4PPqKuvaUyytZN8F6rFzjVZIuTDbX7E6WtfgOoc=;
        b=CX8ghylPN9zgN+pJroo/nXs8Oi/8BQzUEf4avEdnQJ3DUU35zrhtqVJ2hki8gv+0Qx
         TX7d6vR2736n7ItALon2KEgLi7wbgAAWli/RNoWJk6ze5diqpeQt6SenCPs5fzE9PG4j
         8XTzYsWJ5qD29xkch5ufck6bPA0xOyTFw2aZlCXkX/CedchuMHo4stoHaNGXUZRn0W/e
         Gz3BjB4xVDIwFCO+XFGK7cis/pXUwZxwt/y/OaQhA4GtqYwJ6xkvThNw04kjdKTJaJ9o
         ZTD+EFQ1HZ57U92DSnwbX17B3fufwB+9PkisRcdS1lWs9v7i44LySzUy2Mn1hdOoPRmx
         g3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698312094; x=1698916894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZMZ4PPqKuvaUyytZN8F6rFzjVZIuTDbX7E6WtfgOoc=;
        b=eovSoS2agqEJbpOrYl2IInB193277CNuWDrHSQhawCXmq0g9pHUj6mAmz7Q2xhV/+N
         GIl3/tTvmGQwYNPMtxOKs0Dw+rklp7zoQIujnP3Wxwit8LXmhtSr2/RiR20uj06Lr7ES
         TEXW8M7gdTN/VHyq2WfFl4eOfLFBA3/YY3/2BKwK9LiFWDnWqopCIwYw5R0ZMU5TYPDA
         3FL5DRB1XxVpZoaYewkxyWy8Pu2zSUE6ngfa6qwjVS27SbuYyl7vVo7+7Y4EHPRxI737
         4f2l1+87Eh+i6KkqLdLe2aTD0Awj81i5kKPYG2onT/VjnDYADDzRvdGQIKAPV80sKYHj
         oyHQ==
X-Gm-Message-State: AOJu0Yy9uazN4mwwG/bD3TzkojwxF8vYwKxN/lmGCfQ6CCqo90X27Va+
	ycoFG3D0dLzTGxocqAF6sGYVO0DHeNTww3d/XqpN1g==
X-Google-Smtp-Source: AGHT+IErCd6aP8iwtmE/F3hCl2wzy53K0Ir6Imof+twmkHwphD9ClXmtrVHybhDQN1tU8IUIk51ZAULDc4AINetRPX8=
X-Received: by 2002:a17:903:28c:b0:1c9:e229:f5ec with SMTP id
 j12-20020a170903028c00b001c9e229f5ecmr427638plr.22.1698312093726; Thu, 26 Oct
 2023 02:21:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000000f188605ffdd9cf8@google.com> <00000000000017dd680608991d75@google.com>
In-Reply-To: <00000000000017dd680608991d75@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Thu, 26 Oct 2023 11:21:21 +0200
Message-ID: <CANp29Y4kNfuBK6LxU5nAHwA8wGqGYK9EJ-uBFef70s=AEbNP0g@mail.gmail.com>
Subject: Re: [syzbot] [f2fs?] possible deadlock in f2fs_add_inline_entry
To: syzbot <syzbot+a4976ce949df66b1ddf1@syzkaller.appspotmail.com>
Cc: arthurgrillo@riseup.net, chao@kernel.org, hdanton@sina.com, 
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lizhi.xu@windriver.com, mairacanal@riseup.net, mcanal@igalia.com, 
	penguin-kernel@i-love.sakura.ne.jp, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For some still unknown reason, syzbot's bisections of fs bugs
sometimes end up in drm. There've been quite a few such cases
already..

Please ignore this bot's message.


On Thu, Oct 26, 2023 at 8:59=E2=80=AFAM syzbot
<syzbot+a4976ce949df66b1ddf1@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit a0e6a017ab56936c0405fe914a793b241ed25ee0
> Author: Ma=C3=ADra Canal <mcanal@igalia.com>
> Date:   Tue May 23 12:32:08 2023 +0000
>
>     drm/vkms: Fix race-condition between the hrtimer and the atomic commi=
t
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D166c090d68=
0000
> start commit:   28f20a19294d Merge tag 'x86-urgent-2023-08-26' of git://g=
i..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D21a578092dd61=
d05
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Da4976ce949df66b=
1ddf1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15a09340680=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D118909eba8000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: drm/vkms: Fix race-condition between the hrtimer and the atomic=
 commit
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/00000000000017dd680608991d75%40google.com.

