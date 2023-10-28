Return-Path: <linux-fsdevel+bounces-1486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8744E7DA82D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 19:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E000EB211E7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 17:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1944B1772F;
	Sat, 28 Oct 2023 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21440171BC
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 17:05:08 +0000 (UTC)
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B49129
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 10:05:06 -0700 (PDT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1e1a878ef40so3987361fac.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 10:05:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698512705; x=1699117505;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VTo/MYGjU98OZVhpt1voIWuh+FHLPG7oyJBS1qD9LfQ=;
        b=P93WfROob5x2DEBi7pshSx4GD8nR9gQw6DPZdc4neMeuEDnH7qq+Q+suw7M6Rusr1i
         Uz9jBulKuOh1wJhYaWnhwpcCe/wQt4Oen9GH2NEDUw7fF+It4F1dBqmskIOcIX7KEg9C
         AgeLZy3IshXndjx/yHOZShii1B5xVMnlEovIZRbKk4QrX4cCsgwknZNZMcTTwbDOUEZo
         uSAtB/mEYoFfTpDHRJoeaRvHxhB/FoLZis4DQB3j97DaKqEREHDRGZqQU8JDEhp2T8vn
         WtiEUiyBNkwVlCudp1skw2WkZs06MYLjE7SBoe0BVvdLs7yhGcnA5hSLiXpSKbYq8QFS
         6ulA==
X-Gm-Message-State: AOJu0YwZB5B9v1EHiWzuCLoqGYY5NGk+eN5raU0ycf/VMfN8/9m4bs0g
	j8vyS1hnBXHH/J6648kjyLDMKSKnT06o4jb0Wx9e6UMVzUq8
X-Google-Smtp-Source: AGHT+IHDWbVpcRZW17s+E9mZT2p3NLImbd1EcjPq+4ECelqP51WUu/Fg5z00UTleUxVPQ3pE/XOUb6xGMgZ4y7h8sYPMfUlG8x9+
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:30d:b0:1e1:3367:1429 with SMTP id
 m13-20020a056870030d00b001e133671429mr2675836oaf.10.1698512705435; Sat, 28
 Oct 2023 10:05:05 -0700 (PDT)
Date: Sat, 28 Oct 2023 10:05:05 -0700
In-Reply-To: <0000000000003ba9f506013b0aed@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000743d980608c9ce33@google.com>
Subject: Re: [syzbot] [ntfs3?] INFO: task hung in ntfs_read_folio (2)
From: syzbot <syzbot+913093197c71922e8375@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, 
	clang-built-linux@googlegroups.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, nathan@kernel.org, 
	ndesaulniers@google.com, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit bfbe5b31caa74ab97f1784fe9ade5f45e0d3de91
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Jun 30 12:22:53 2023 +0000

    fs/ntfs3: fix deadlock in mark_as_free_ex

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14006f67680000
start commit:   bfa3037d8280 Merge tag 'fuse-update-6.5' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4507c291b5ab5d4
dashboard link: https://syzkaller.appspot.com/bug?extid=913093197c71922e8375
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b8869ea80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149e6072a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: fix deadlock in mark_as_free_ex

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

