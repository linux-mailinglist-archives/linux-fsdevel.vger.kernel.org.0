Return-Path: <linux-fsdevel+bounces-1711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 938037DDDE4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 09:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496332816B9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 08:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218F06FBA;
	Wed,  1 Nov 2023 08:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EA25C9A
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 08:49:17 +0000 (UTC)
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B93DBD
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 01:49:12 -0700 (PDT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1e9c315a081so832985fac.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Nov 2023 01:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698828552; x=1699433352;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=Cs839Np/F+ci1Y8H6I3RQqo0lcNLZs2AENF7JTp9LAg02+0ZxjX4kGL18W4frCXo9M
         5AnF+AlqenEd42/Yz06gfycGWIfUwxtWO9mARDgtzGZMBNwd3YL4JseZsoWB4M2poT05
         mxTUDoGcqbGdi4qT5YA6N9YiEdUxARz+WX9bXrSFvhWgbd5Pq6ek3DYqU6Ngo8pR3DYC
         mbe9C0RCzABFmbcs5DvP35lCsupSYZwgYFGdXBVr5p4q99FyYSMS5chfTt4VzYlCaBbI
         gDzDJlTkjhx/fSR6TUBTYJzuSmKtrLkFBc0d788mUXrKOFm3FPBT/vWI+kd0EiQeK6Og
         zlIA==
X-Gm-Message-State: AOJu0Yw9AsmoLnJ9gmA2p9QCAkIvvpgO4lNWfRCOsQGk5FdYe/ZjZDKj
	/YL4R/kSCFiNQSnZT8IVlFNB7Sl0kfSn/JQUtXM4tPJawb+4
X-Google-Smtp-Source: AGHT+IHcunDBTKsdG6HwYObTbjW7yGSIe6O+NrfxyuISaXIumOCLSA0dGIIBR7P65cCYIijfOW6pKSYaHy1p0BDbBWsjpQmK0Rfl
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:1f06:b0:1ef:afd3:813f with SMTP id
 pd6-20020a0568701f0600b001efafd3813fmr1126528oab.5.1698828551901; Wed, 01 Nov
 2023 01:49:11 -0700 (PDT)
Date: Wed, 01 Nov 2023 01:49:11 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ed5bf06091358dd@google.com>
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

