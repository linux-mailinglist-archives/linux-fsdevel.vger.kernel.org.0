Return-Path: <linux-fsdevel+bounces-20600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0F98D591D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 05:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63B181F2513C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 03:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C121E78C73;
	Fri, 31 May 2024 03:46:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBC8187562
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 03:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717127182; cv=none; b=lfQayyU33fi/crhZX6AY2P3sy4t+v2ns7KpxdUd7bvRweMcI1uJIBY+6yYrckfm7c2dbmN3Yo/e8aTD5lc7j7e1w+3kC4nsDuVmo/enKrhFXXNKOFd561RxHshyBaflqHaHj2r+8SEs9ieqxI6nohXoFi4kVtnK6FHuM7CkVAzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717127182; c=relaxed/simple;
	bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q5Z9TkrUfTFqafZ+X542JBau9WM+uaObtOAyZBEpCslKaBddBl3Rc1/NgCiqVLjF2na7jpXDa3Kwg+LJgPeXjf9MS3qrM5ZfGwgGTCMoulcxi3lFmUrm6u8gcfFG1DQmWV1Ng9pywqqtMV9/aIoONjyFHZtkktNeiupKEzznjR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3747f77bafcso11740505ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 20:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717127180; x=1717731980;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=VAOuCCbwza7gzUAP0nA1d4rQoS2nu14YVkF2WC/zw/qI/s6HNIYvDdZJYbai4HZnPm
         WvmfDPMaM1GWVbFzxz6yEHuBGBmum/wUuthXyyT2dKvJxYJ8qxwh7Hxajcd5Em0lB6j2
         XfPUuEUF04noFcie2e8cQ07TxZ4/vqHpPf98Dfmz4gQ19eZSlnPHm2lkJdQOZrc+aIp7
         W/rd78n6yo1WrLp1go3YAWkdDdTIbeVqKZVjgk8J4jqO4EQZj99OObmzpE8Nkz7repX5
         Clt08GUjCJA4GnKGX0csIsg97CZLK5F+OPRSm1vjoZxlljkPWcoZK91fjIC2zLf/wWiz
         bs4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUABShHhLL5J8hTNGTxccnietBisui/2a2Cmj2cLnRwuU99Saq5x8JrhS8yy3Mjf4C0m38TUG6E1xV/VLNSzNAnlO2MjxW0BhTOS6NBqw==
X-Gm-Message-State: AOJu0YzsCpxBJAOtZTXF1Zb9JxxxabgqAqjMECn3dE75cl42acFFlcCX
	UZT+KrJqMUWHgfHTHyWWmYC2VAIbDRe+7X4dePTKuhwYZa4XfCKEwGl6Cmsg6e+3VNgFZ1DRdSZ
	1Jo5FbJRGiG0uQF2EFnKMt+e/rm3F7JSRuPUOlFeWe8eAGAHRByBUq14=
X-Google-Smtp-Source: AGHT+IFAlsDFvycw9GtdEcUnKblFYVUmsufEcUGHjOdczoQb273MFgKPjf2HsqU/ULaiNL0DiWQF9DvncnFTP9/cEgX9Dm6AepsC
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c4:b0:373:fed2:d934 with SMTP id
 e9e14a558f8ab-3748b96aa5amr863735ab.1.1717127180409; Thu, 30 May 2024
 20:46:20 -0700 (PDT)
Date: Thu, 30 May 2024 20:46:20 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009f6f220619b7d3a8@google.com>
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

