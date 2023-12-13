Return-Path: <linux-fsdevel+bounces-5818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2920810CCB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 09:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A511C20A2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 08:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBAA1EB52;
	Wed, 13 Dec 2023 08:52:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDCEAC
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 00:52:17 -0800 (PST)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-2031c40ef24so653052fac.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 00:52:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702457537; x=1703062337;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=bEDnnPsFaEJJZu1MwMN1ATrw489bGGsPWAbOM2eg1kVDIIOdD99mxcQ6JC8gmueIKV
         W+A3ioDsnKIzWvtH/lZ9gfXd0J/fL8dY0XyM0zfWjF1rjxWZJrVtdhzlp2L5J6dgMSs6
         g19ftI0MPKfI/zNDcSVjmHJjN098DrcVftZrNwadetgmosypQjY9eaqM7D7/toYEgARS
         s+al+on2bmCRJxtX8ouoKknV/F8xpofGlPXztSTKiF1xzLc9QvElfnYmVrbmgyz1P2yd
         h9gS6kYE7sSlyKB0zh+0i8ZnXHz1P9uvEyAMGY8gwYn6gi3tcGaO1o65O1mo69DVWrTC
         UbqA==
X-Gm-Message-State: AOJu0YxRaJUntCBGdCxr4K6CaLJ2X1YKTTZgS7R8lfnDMVZ8xzH5W8LX
	RHkcN2rec8ilqbikdG5kvtnHBo8yhCfzXqbgDtG+A3FMtB3b
X-Google-Smtp-Source: AGHT+IGzn1vWQRWy4hNK47/fXNETo9pMF7OxRmF3w0I7jOqcRkx6dD72V7r0g1rmfo1M2lvpFsx36btyv4fDVet8vGSK7FV4vEgC
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6871:5b05:b0:1fa:e120:4c64 with SMTP id
 op5-20020a0568715b0500b001fae1204c64mr8088036oac.10.1702457536123; Wed, 13
 Dec 2023 00:52:16 -0800 (PST)
Date: Wed, 13 Dec 2023 00:52:16 -0800
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af990e060c604832@google.com>
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

