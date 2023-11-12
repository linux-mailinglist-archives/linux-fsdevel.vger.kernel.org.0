Return-Path: <linux-fsdevel+bounces-2776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D327E9109
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 14:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3637D1F20F9E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 13:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA72134B6;
	Sun, 12 Nov 2023 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD7811730
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Nov 2023 13:45:10 +0000 (UTC)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C89D3860
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Nov 2023 05:45:06 -0800 (PST)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6b31cb3cc7eso3674007b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Nov 2023 05:45:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699796705; x=1700401505;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWjilwy3ei2JMmBplrMuEmMSvPjKFecRGFZndim+p1Q=;
        b=EXl91t0lTVkuL1YERDmmAoWsw0j+khDN/loMXwcYf9lQCU0K2VdMhH9SU7/i2whgnW
         sAhDBci7gK3YdQg/O0CmCM95IDrUFL8bDWFTC7vgv94444F/O8B0FySBWaY/5m2UwDfm
         DqrS1y7XIHfDXn7fpdn87hf/jlXXWAW8vEDY7gC80EPMSLVoG20m5qcBezdWADhsbVi+
         GN87Ft903lAGxVZQlYRXyGyPpAkxdLyQQ0MHERisWnYfRz324+cAMsJ1Hjq3bI4BoVMq
         yt1w3RnQobR8Zc8qa7ZSJw7c4vSRvp3hqUIhVqhMeQ9H9HRoU9+2hbgAkT1z8twol1JG
         iHdQ==
X-Gm-Message-State: AOJu0YxwsEPYP1/Udmva5NL5ZjSCNhAL/q2iPH1aoLrBHx4dOtSG+PK4
	eIbT03vnChURf08zSSwXqjlENUXNYZ18tn0ZwRoJHL+S4dwn
X-Google-Smtp-Source: AGHT+IHyQOou3WgvCQDwLJUWJwBTuQvumcew/x8XMghpHidvj+B/MwoXaAicooxZYrggZzAr6JfKKV7E7dpNzqa6Mwvt1ivdn1ST
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:6c8d:b0:692:c216:8830 with SMTP id
 jc13-20020a056a006c8d00b00692c2168830mr1712398pfb.0.1699796705645; Sun, 12
 Nov 2023 05:45:05 -0800 (PST)
Date: Sun, 12 Nov 2023 05:45:05 -0800
In-Reply-To: <10dd4562-81bf-48c7-b2a2-42ea51ba8843@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d49a590609f4c28d@google.com>
Subject: Re: [syzbot] [btrfs?] memory leak in btrfs_ref_tree_mod
From: syzbot <syzbot+d66de4cbf532749df35f@syzkaller.appspotmail.com>
To: bragathemanick0908@gmail.com, clm@fb.com, dsterba@suse.com, 
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d66de4cbf532749df35f@syzkaller.appspotmail.com

Tested on:

commit:         25aa0beb Merge tag 'net-6.5-rc6' of git://git.kernel.o..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17c578a8e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2bf8962e4f7984f4
dashboard link: https://syzkaller.appspot.com/bug?extid=d66de4cbf532749df35f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16ce93e0e80000

Note: testing is done by a robot and is best-effort only.

