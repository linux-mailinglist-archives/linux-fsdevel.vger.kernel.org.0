Return-Path: <linux-fsdevel+bounces-4163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2E97FD472
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 11:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B3B9B20E57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 10:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BE01B279
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 10:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8E819BF
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 00:51:18 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cfccc9d6bcso45196245ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 00:51:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701247878; x=1701852678;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=g/pT3z5qBBzkWgX1saSVS4riCIMcme+NfAozq50lplLEMztNxhtaHp/MBqB3CgzD+G
         ExNxJX+dfGgghHvrkIjR0ukr3aUHcj1xRBorEJdxwf6QDfI/0taKTs04JAF6ExzSZoDX
         Z57aD+PA1ITSMSKsWZzaio9dw+Wm74Gz0EOz14lQa29WJDnKfejX8N92D6yLBFjxit4c
         b20GF5dI9WHxbfu0UqUGV6/7RtK4wKuizWA73Uo5DB7ChfuivI/+LOh0gFsIJJ0E0V2K
         ZUbSLcgJDNYM+UiWG2B0RwAW/zZQjfkXFVuex+mVd8IcJ9aExD3g6cwZ80ZqukNVlyyI
         KAlg==
X-Gm-Message-State: AOJu0YyYSDSLyiX1AQn24ytm7EwpugvP7ecucsMrCyaZ2GNG7Zzt1V8l
	LOaDwaEBJuhAAzpOcVpryh9pbWgG0x4iv4DgydpnWqvRG1uT
X-Google-Smtp-Source: AGHT+IF1MYdBNjdusmKFxsuZ/Nr/VSjghO6WRZ54GK864hsFL2YuTIprEZmQCeIMEbRyAlQzutP5Q08V4iUeTRqpO76M2EbgqcvB
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:902:f68e:b0:1ce:5c2d:47e with SMTP id
 l14-20020a170902f68e00b001ce5c2d047emr4297801plg.5.1701247878586; Wed, 29 Nov
 2023 00:51:18 -0800 (PST)
Date: Wed, 29 Nov 2023 00:51:18 -0800
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a6a45060b46a377@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_write_inline_data
From: syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nogikh@google.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=f4582777a19ec422b517

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos

