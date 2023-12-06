Return-Path: <linux-fsdevel+bounces-5051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5484B807B61
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 23:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AD481F217C8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 22:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863DD7099F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 22:36:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E82D53
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 12:36:08 -0800 (PST)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b88c1f5ecaso316620b6e.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Dec 2023 12:36:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701894967; x=1702499767;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HpNbwOXTQE/pK8Y5FKL4XcwMcPxfIP/Q/V7UQfxy6YM=;
        b=nfzLIhmAuGJe3i880I7bmQhDm24HlUZzuL/7l2Z0Sj4z0WHEp8Ggr2lPalwamvPcHp
         pNlsTV4TAH6LJWkGviKPOLPcoRHM8RynreJs11wMIWNkRzk/6MjeLldNmJbEDu+a84Gb
         hAdjNuLPcyg9yQE9hYYm1Ho77Rnf4fGeJjoreHOdzcXBDiqNMwJ6q3wznCu0mWlLApEq
         fnbGrWJcMdBw8CbTm+8867gzuSeXdBf9CXdGIQY7pKDAQ2jLzClsUwl9T6ex5OmeBA11
         a//SZOGXAiw6uLhhUur1ORd+zN5LOOIzMS8GuA54o9RuZibzfFUqziJhxJPItqRpxbl4
         zunA==
X-Gm-Message-State: AOJu0Yy/E5udsMWvli7IX5syKA7Hyc4NLL1Q4kQtNONMFXGP1tOT6K9k
	W+oxETAq2m+WSW6Ro9W+DgOBy0NFfCCQyQ6drT2uUIHBbHTX
X-Google-Smtp-Source: AGHT+IEyWCgNr7gxZR5OshHlDIhRJ2iTV2R4/qkUBMTbCdJf0LCUN9ecFLDTPTstODpJIP/y/ivG8obuX/Z8yzu/tAH5w4/8wWla
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a03:b0:3ad:29a4:f54f with SMTP id
 bk3-20020a0568081a0300b003ad29a4f54fmr1315439oib.4.1701894967425; Wed, 06 Dec
 2023 12:36:07 -0800 (PST)
Date: Wed, 06 Dec 2023 12:36:07 -0800
In-Reply-To: <CH0PR10MB5113DA035381743379D344F99584A@CH0PR10MB5113.namprd10.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa801f060bdd4cef@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in pagemap_scan_hugetlb_entry
From: syzbot <syzbot+6e2ccedb96d1174e6a5f@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, dan.carpenter@linaro.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, llvm@lists.linux.dev, mike.kravetz@oracle.com, 
	muchun.song@linux.dev, nathan@kernel.org, ndesaulniers@google.com, 
	sidhartha.kumar@oracle.com, syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+6e2ccedb96d1174e6a5f@syzkaller.appspotmail.com

Tested on:

commit:         41f87dea kexec: select CRYPTO from KEXEC_FILE instead ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-hotfixes-unstable
console output: https://syzkaller.appspot.com/x/log.txt?x=144310d4e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3513b9514190e290
dashboard link: https://syzkaller.appspot.com/bug?extid=6e2ccedb96d1174e6a5f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

