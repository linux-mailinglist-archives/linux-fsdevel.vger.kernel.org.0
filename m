Return-Path: <linux-fsdevel+bounces-6977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7683F81F490
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 05:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A87C11C21AFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 04:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67AB2909;
	Thu, 28 Dec 2023 04:23:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B70C1396
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Dec 2023 04:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7ba7d8f3b1fso750586739f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Dec 2023 20:23:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703737385; x=1704342185;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dd9vr80+WFGKnhM1JNQ66LsYvSI4r3S79KXgQZCzYg8=;
        b=QdcBgFTBtKx3Ii5S9ZLuuvRt3RS8ywm+kdT3JHAsB/+FfEXrg+jsp8y7JjfTE2434e
         1uQiHI6DV8dpjeP5CHjzt4Fw2jM2juhi7ZrzxQqKcsWDxVbdrU6OWkDbBfWKg48QoWwe
         ZSUzG8TUNI08aao4mo/HODO+f//J2Yel8YjtdQorUdOlDfICQM9/BkanccT3u8z/rG7P
         Z+tKjVe1lWelfA1JL932RQtrD6rEGAiGGLM/O8IuDBuRrmvBqCRBQazFe29XdxqE0lha
         2mlsYObfP4eIUpG1r/U9Pf3+BYknQ2LLDdCb1Neh801LkMAPFM4gQkN2vXMXj1o0eDEH
         SCMw==
X-Gm-Message-State: AOJu0YwYiE832uVjfqaZrrZRWi52HlPs3eD248lDPhFAc+Ikd6QUn4k/
	k7tcA4BaH+4w7CImMhAmf79esFSIcsg2paYsj/Z7Pxsa8PLH
X-Google-Smtp-Source: AGHT+IGaH2neAkdIoyk3jyVZ49xeJ9vANxYmgJtaoyxGuIkm1BlzltdENKQP89j3UrTnEYAGl/eH773XOz1+ZzVlXzqXfTbc77Yh
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:18f:b0:7ba:cef9:803a with SMTP id
 m15-20020a056602018f00b007bacef9803amr69602ioo.4.1703737385611; Wed, 27 Dec
 2023 20:23:05 -0800 (PST)
Date: Wed, 27 Dec 2023 20:23:05 -0800
In-Reply-To: <5e2ad1d3-32cc-4f94-963f-a066d2a21536@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8f9a6060d8a4520@google.com>
Subject: Re: [syzbot] [erofs?] KMSAN: uninit-value in z_erofs_lz4_decompress (2)
From: syzbot <syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com>
To: chao@kernel.org, hsiangkao@linux.alibaba.com, huyue2@coolpad.com, 
	jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com

Tested on:

commit:         94da00a0 erofs: avoid debugging output for (de)compres..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=13715b95e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f711bc2a7eb1db25
dashboard link: https://syzkaller.appspot.com/bug?extid=6c746eea496f34b3161d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

