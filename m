Return-Path: <linux-fsdevel+bounces-7039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D7282082E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Dec 2023 19:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E398E1C21E2A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Dec 2023 18:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF09BE4C;
	Sat, 30 Dec 2023 18:24:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBCEBA37
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 Dec 2023 18:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35fd42a187bso54023695ab.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Dec 2023 10:24:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703960648; x=1704565448;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xLSqQXflCKXSuE0x3+EU2nuQ/UIrEEdd7MZHamp9QFc=;
        b=ISkB8tAHA5UJancCzSYW9snuupyykgoKpZ2qGSbkN8Dko/ixW0q497SFxqr3JYeSo+
         gmG9pK9V2OuTT7A/G4OBWOyDi/S/OgHsIuqBIbGl4e/lK2RZkDrV6+hx6/tIcwt1/UDc
         p2KFgCjZeNSHacF7HkX5vWQk1i5WGvNXfKqVevEJN3iGVHr8IUOoJmy2EvbEYVMBRqGR
         LcTdugZG1ZL4UZMJZQspgxXqu7r53dqEKXB+RDZamgAuRXl8Hbhibm6bohlSMtO0kRa/
         T3VXFPcmAdDiYAPC5lE+zll52q/hg5O1RZ/uNQE3bRolejEaMdAf0oYqhCNy4oU8Y4Vx
         spog==
X-Gm-Message-State: AOJu0YxWhWSZub/PaAKB5rQLSyxVkdkQ3tDSgabVlFEWT+jqMY8o6DjC
	qchgSJPfnZj0563UI3OREGSFBBsXvmgPRTWNBCWli+lcbVqY
X-Google-Smtp-Source: AGHT+IFWqTXNE8q8KmjU9VLfd4+RDLQxAjj4HgpJLHUx2jLQOVYptHdZLmafnKg5V4WQxG2bXL1tHOtyf5V7a0Wphhc/pZROnxKe
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6c:b0:360:134:535e with SMTP id
 w12-20020a056e021a6c00b003600134535emr1613798ilv.1.1703960648201; Sat, 30 Dec
 2023 10:24:08 -0800 (PST)
Date: Sat, 30 Dec 2023 10:24:08 -0800
In-Reply-To: <000000000000fdfe4b060b91993f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025c17f060dbe41ef@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in pagemap_scan_hugetlb_entry
From: syzbot <syzbot+6e2ccedb96d1174e6a5f@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, brauner@kernel.org, dan.carpenter@linaro.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, llvm@lists.linux.dev, mike.kravetz@oracle.com, 
	muchun.song@linux.dev, nathan@kernel.org, ndesaulniers@google.com, 
	sidhartha.kumar@oracle.com, syzkaller-bugs@googlegroups.com, trix@redhat.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 4a3ef6be03e6700037fc20e63aa5ffd972e435ca
Author: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Date:   Mon Dec 4 18:32:34 2023 +0000

    mm/hugetlb: have CONFIG_HUGETLB_PAGE select CONFIG_XARRAY_MULTI

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=126d4145e80000
start commit:   df60cee26a2e Merge tag '6.7-rc3-smb3-server-fixes' of git:..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb39fe85d254f638
dashboard link: https://syzkaller.appspot.com/bug?extid=6e2ccedb96d1174e6a5f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17befd62e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d5a90ce80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mm/hugetlb: have CONFIG_HUGETLB_PAGE select CONFIG_XARRAY_MULTI

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

