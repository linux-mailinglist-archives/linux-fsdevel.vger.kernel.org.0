Return-Path: <linux-fsdevel+bounces-1225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A67227D7D22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 08:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45CDEB21340
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 06:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818AAC8C8;
	Thu, 26 Oct 2023 06:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD588C15
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 06:59:33 +0000 (UTC)
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350DD192
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 23:59:32 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1bf00f8cf77so649426fac.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 23:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698303571; x=1698908371;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mg4dqADrWVVQFvwUDMmazDT6n+A6BU7HqszKhe39EAk=;
        b=AFdtBgfkiyfELH7COQ55APOXAQljSDwZwLkXzN//EXkCfbP4rI9OEmRsjV/Xq5cG3M
         h+gSjW6XCF0y3rQ2LcJmiRAf6ZrO2GUShKawibrsX9uG+yoIOz/i8ZqaaXWxr3YzKYjt
         dxUeRCRn9n9j9YKJvGqieBm46O8E1RwozmU0BkI1yM0s+Ao5I44Nr+uTMrDbjtILOiGH
         pkQr72+Iy7nixDEioUkRz7ARAgNZj0RC1MQHkEiA7pfHs9uXtUrRvq1GC+G38qkrUH2B
         h7RXx7PTqeMGq6C+8mApoLTESJ+Q3EhFXTWgDO0yq7Z76IIiShhlUqbioiwP2jVKqYCh
         FKOA==
X-Gm-Message-State: AOJu0Yx85DMDCX+EOBNsXeBMhvWaC9dGz1c5GBAsGKgC3vmcp11OHKl+
	3hugr0Qpmk0puElJ/DXv3uONjlCJOU1CftTkDGab6q+DRqIz
X-Google-Smtp-Source: AGHT+IHp42mn/AOQMp/Gy+pIgTER3CgUE07jlE0pfwGuoDZyiIaKHT4W8OY7jzoJ5tQHqlAfyspW2vZKdlZR85jhZJ/GMbMFDJg/
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:179c:b0:1e9:a917:d59b with SMTP id
 r28-20020a056870179c00b001e9a917d59bmr8164456oae.3.1698303571383; Wed, 25 Oct
 2023 23:59:31 -0700 (PDT)
Date: Wed, 25 Oct 2023 23:59:31 -0700
In-Reply-To: <0000000000000f188605ffdd9cf8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000017dd680608991d75@google.com>
Subject: Re: [syzbot] [f2fs?] possible deadlock in f2fs_add_inline_entry
From: syzbot <syzbot+a4976ce949df66b1ddf1@syzkaller.appspotmail.com>
To: arthurgrillo@riseup.net, chao@kernel.org, hdanton@sina.com, 
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lizhi.xu@windriver.com, mairacanal@riseup.net, mcanal@igalia.com, 
	penguin-kernel@i-love.sakura.ne.jp, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

syzbot suspects this issue was fixed by commit:

commit a0e6a017ab56936c0405fe914a793b241ed25ee0
Author: Ma=C3=ADra Canal <mcanal@igalia.com>
Date:   Tue May 23 12:32:08 2023 +0000

    drm/vkms: Fix race-condition between the hrtimer and the atomic commit

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D166c090d6800=
00
start commit:   28f20a19294d Merge tag 'x86-urgent-2023-08-26' of git://gi.=
.
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D21a578092dd61d0=
5
dashboard link: https://syzkaller.appspot.com/bug?extid=3Da4976ce949df66b1d=
df1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15a0934068000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D118909eba80000

If the result looks correct, please mark the issue as fixed by replying wit=
h:

#syz fix: drm/vkms: Fix race-condition between the hrtimer and the atomic c=
ommit

For information about bisection process see: https://goo.gl/tpsmEJ#bisectio=
n

