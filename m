Return-Path: <linux-fsdevel+bounces-593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A487CD6E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 10:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 939A3281B51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 08:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C5B156DC;
	Wed, 18 Oct 2023 08:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50FF11723
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 08:48:44 +0000 (UTC)
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578A710D
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 01:48:43 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1dcdb642868so8914654fac.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 01:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697618922; x=1698223722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=miPm2qwuOrYuQG0wH8srYJdrrUo4qP9EfiejuHFZ8oOgNV2mYbPmzgFRqLy1RIXa4F
         2QgWBdJIBKlk933KzTEAR+lYm3gCwUvXw8mDMS0XFrHCfy5ra/mrPX5D5CHpyON1Wdeo
         FkoC8KncJA3MitsQT2QNaCpZ6tGGjc3iHgTCu27gTNnyhH44seNXXQZSThSueggR+pli
         cTCo8q4HqJ5vozDJstMhR/fCCIOzUzSSTMJ+M5VXlNcdayHHcpGmkbfMZ7YqR24cTi8c
         SdWtwKIktHcNpCmUZw4L69TJqOXh6keFf3TkEOx82kBMtoB0qqjkzDApKxxae0D2cqCE
         tGWw==
X-Gm-Message-State: AOJu0YxenrdpF2OA/vCCRKK8B9AIF2FMgJnZac74za22W6En5urBwgmI
	5oz4JCyG2CdUxyeoEUP+zurPI3qfBOahHPgWhdrsqBwQ+mwo
X-Google-Smtp-Source: AGHT+IH5KX39Zu5WRNgK3VKyydT+0tvTjeetKkwDFus95ScBRPsXK3zjjJxvbV/6vxL20IQCDEZ9FHkNsLjuYTS+6mTaNsskXrjM
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:3046:b0:1e9:dabc:9d6 with SMTP id
 u6-20020a056870304600b001e9dabc09d6mr2212109oau.1.1697618922448; Wed, 18 Oct
 2023 01:48:42 -0700 (PDT)
Date: Wed, 18 Oct 2023 01:48:42 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d62e9e0607f9b415@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_write_inline_data
From: syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nogikh@google.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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

