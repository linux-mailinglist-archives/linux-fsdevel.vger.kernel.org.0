Return-Path: <linux-fsdevel+bounces-2882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 566D37EBED5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 09:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B0FF1F25BFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 08:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A374C524E;
	Wed, 15 Nov 2023 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EAD2E838
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 08:50:16 +0000 (UTC)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFC210E
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 00:50:15 -0800 (PST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c19a2f606dso3378826a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 00:50:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700038214; x=1700643014;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=rEpnzusk/xzTIf8tgBguw/u97WYV6kX2HUVeUfD6hb/xF0b4vOj7o78k8AsatABClw
         LXJIup0jace7Jd1FKzpF42xc89/K8d4a7cf/S9rWryTKoLw0lUZNxJIiWK24zVlbL1EC
         nReqw2ScPImJo9b8F5qfjIbX5/Xmbaed6ucr98alZsahfAbzH1LcYzPIAmajbFlZ8OFD
         BvdDxbpXpPLbPoJnFDjCIPrj3F9WAII4k4TrdAA7ovFzmHAMF4glbdg/8okaq9Mzy5zr
         7PXMOJ5yqyfY7X0Xcf66jTOgLyjn+gnv4eYYQ1ZtNslhNs+oDP7fN0EcNhWVPtHcp/2v
         J1Ew==
X-Gm-Message-State: AOJu0YxnO4+u9o/cHFOuEzAi/yID8xkvthkOeeJbM/1uOCQqmi5l8g30
	xmuNrqXCG/QJVFFOfPKN6mQy1jQRCdvq7a+nPcjTPSCar10m
X-Google-Smtp-Source: AGHT+IFUJ+Vym4OCXmONbmxagAntdPkW/KmU7Wvov6LOO01+7a6hUu2vKKARqr9sXhI//jw8FapxCsgSNNL1ljrINCH0MWGV4VRs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a63:2022:0:b0:5bd:9cac:f993 with SMTP id
 g34-20020a632022000000b005bd9cacf993mr1135510pgg.5.1700038214642; Wed, 15 Nov
 2023 00:50:14 -0800 (PST)
Date: Wed, 15 Nov 2023 00:50:14 -0800
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e375e0060a2cfd2b@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_write_inline_data
From: syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nogikh@google.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Level: **

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

