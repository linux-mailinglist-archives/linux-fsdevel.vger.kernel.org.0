Return-Path: <linux-fsdevel+bounces-6341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCDB815E57
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Dec 2023 10:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF181F220F0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Dec 2023 09:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961223C23;
	Sun, 17 Dec 2023 09:36:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CE21FAD
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Dec 2023 09:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35f8344e3c8so36513265ab.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Dec 2023 01:36:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702805766; x=1703410566;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QYt+ikegC5rVi/qGr8IiLcMnutjmAb6NTg3JW6/hHH0=;
        b=pg/XFepehb+5B4yvzQVfl77b3jy4dk0siTg83/k2/Xefm6yZLlE1sxF0XC10AVpM7L
         RfCwyhuS/Bdc8VGwx6YNv+IpP85UME4iUjnFVjNHSMkxErphFfiavuDZFK1LIQnxCL7M
         HvTN4q6ReFPVqCannKgjCaRlv5K6rnvZwlxxqFCrHPyHVntB7MS0mBgtI2nXWEnY9lUy
         mlsJDXjOcglrRGvzcPRwTCay7L0zAQfE+PEwSnPtWfRpfRK/c4f4+qjEIfsI4FsigROg
         3GH9GFYRXRBhwmJF5GUxi8KuZKi8HpDCVrnMec0k5We9OEs9Ph3PZwwZ/hWZJyLh1o6S
         xtiA==
X-Gm-Message-State: AOJu0YxGNP89UYSRtuRKegyqYu2FDYHSQo/oE/8MzvEr1tDUnB5aD6aq
	KjEZ8zZ1e5IuEPC2kbMct50Y5EQhnu3YLDDetxdIUER7BE0Z
X-Google-Smtp-Source: AGHT+IEJAguZt+Gv2Y76sjvdueN6ZFAUUjgQ3bitOLfHS8oC6v8p3BLP5V9wsQgaUv5l1IktXBdwbNZHY16qZ2kMSl2kME9KRaTW
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:1e06:0:b0:35f:4dfd:c224 with SMTP id
 e6-20020a921e06000000b0035f4dfdc224mr473921ile.0.1702805765999; Sun, 17 Dec
 2023 01:36:05 -0800 (PST)
Date: Sun, 17 Dec 2023 01:36:05 -0800
In-Reply-To: <CAOQ4uxjjo=qwwWcRXhv_D+KFfnPa_CEOrPbbZtzLroiOO7eYDg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cdd406060cb15c9c@google.com>
Subject: Re: [syzbot] [reiserfs?] [squashfs?] BUG: Dentry still in use in unmount
From: syzbot <syzbot+8608bb4553edb8c78f41@syzkaller.appspotmail.com>
To: amir73il@gmail.com, chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, phillip@squashfs.org.uk, 
	reiserfs-devel@vger.kernel.org, squashfs-devel@lists.sourceforge.net, 
	syzkaller-bugs@googlegroups.com, terrelln@fb.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8608bb4553edb8c78f41@syzkaller.appspotmail.com

Tested on:

commit:         79f938ea ovl: fix dentry reference leak after changes ..
git tree:       https://github.com/amir73il/linux ovl-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=171ae01ae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=52c9552def2a0fdd
dashboard link: https://syzkaller.appspot.com/bug?extid=8608bb4553edb8c78f41
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

