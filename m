Return-Path: <linux-fsdevel+bounces-7846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D01682BA06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 04:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20C07B227DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 03:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717C61B285;
	Fri, 12 Jan 2024 03:40:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD651A735
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 03:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35fe765d63eso31034045ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 19:40:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705030821; x=1705635621;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=rJ83snvIYjPlrsoiYfdnbTmeXdxMye1bzs8mkDZC6Npe6xENooG65DX45JTKyLuyKm
         cQ5qMoTLrTrBdOrY+KjWaCDkaoXheiIvHNz7ku4s7/2omsfYS6hPNcFB07gXCrslce+3
         em3e5+WBkhUC0DAXQh7KkBPk2FRRd+MExI7dAYUtyq/Tj3FlMTOb6HeBItBfdF7molTY
         sIhMvPAyYHRDeXxkETFCsGHUYoJzYm5InQo9CbRqX7kz3Sxs6/mZzlvD+QskB11gBxml
         /o8lPi12VQ5L66OruGrkgGoKH6W3aPOWG68k3YBtKX9VKu3Jj6oFjGDqeaMM6DIiBbf/
         MBYQ==
X-Gm-Message-State: AOJu0Yw086wIpUBmRMHjBnHX7fM8MTl9aHKBG9945S8ZoYOwkpJRYcaE
	2xCjwUV0je5ku8aFJeitFM8ionIerppn3K5kY9bjnbtRJ/s9
X-Google-Smtp-Source: AGHT+IFB9wtwpmlwh1hN38Y/mekRfMgDkX1YMtupYMYRVCkd0mAl9XPC2cSN1Nuc1Ci1vxRGdUPjVwpCgKAHanbVQVeQU5MJSIOV
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24b:0:b0:35f:e864:f6f with SMTP id
 k11-20020a92c24b000000b0035fe8640f6fmr27789ilo.0.1705030821093; Thu, 11 Jan
 2024 19:40:21 -0800 (PST)
Date: Thu, 11 Jan 2024 19:40:21 -0800
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006c2b4f060eb76cfa@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_write_inline_data
From: syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, eadavis@qq.com, linux-ext4@vger.kernel.org, 
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

