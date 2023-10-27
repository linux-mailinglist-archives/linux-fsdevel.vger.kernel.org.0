Return-Path: <linux-fsdevel+bounces-1361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CCF7D960B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 13:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D2EA1C20F49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 11:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDDF182C0;
	Fri, 27 Oct 2023 11:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D65E15AFF
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 11:11:08 +0000 (UTC)
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D6D9C
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 04:11:07 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1bf00f8cf77so2294156fac.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 04:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698405066; x=1699009866;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHYFRDDqX2abVHCDP7I6KtrsG2bKXGwCJSHzhmv7Wxo=;
        b=PZBJmWKJPrGt2JjPH8vt/0NUS4X8T4lojhSdTNo9UviPBdgEQ7RQq9gXSoJN6Lv+rm
         g/5BU+y9ZZNTw0Z12kN8mCIV4aTjWnCNpwoCpZqsrK8zmJeyX/maK+Khld2k0lpnGBJf
         vMsp/ef1sloZoEkNfLUy+wLHWBuXrB8bqt/VMXY/s0Ve08HMeajR7kUIzd/RxLzM1slX
         Ucj8PCfVR24AtnCmm4g7qlDvRVVhFhcjnxSHyPlcC4+Ncn7i3T16H1qGRJeZ8FlIKe1Z
         y4PDKnRUsBi+XsIZ43nuK6mFuPcwqLbW/EmBN4qzwwrMTIkKS1lXjv9lvyI8ZtPVnhZy
         hJ2g==
X-Gm-Message-State: AOJu0YyYl3PMC9EX1qL/NSVaHh5OQphXAkHVCde4Gk69+9XLSBYhLl6J
	9e21t0QvOmElF5asMTt4IdKROLRoyGWIqA3AL3zEDh/kbYJz
X-Google-Smtp-Source: AGHT+IErGGl8I9pZs0z5jYPnq5+PZghKlSw97pW/dZhAu9GU7YV8AuOLdJZErMMTBB9u98SHBxYwC4JDQv90suiNnnWoqaDZ+BeF
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:3645:b0:1e9:dbd8:b0bd with SMTP id
 v5-20020a056870364500b001e9dbd8b0bdmr1101923oak.10.1698405066271; Fri, 27 Oct
 2023 04:11:06 -0700 (PDT)
Date: Fri, 27 Oct 2023 04:11:06 -0700
In-Reply-To: <0000000000006cb13705ee3184f9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8f4b30608b0be9c@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in create_pending_snapshot
From: syzbot <syzbot+d56e0d33caf7d1a02821@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, fdmanana@suse.com, 
	johannes.thumshirn@wdc.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit df9f278239046719c91aeb59ec0afb1a99ee8b2b
Author: Filipe Manana <fdmanana@suse.com>
Date:   Tue Jun 13 15:42:16 2023 +0000

    btrfs: do not BUG_ON on failure to get dir index for new snapshot

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1584c385680000
start commit:   0136d86b7852 Merge tag 'block-6.2-2023-02-03' of git://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=5ea620bd01d9130d
dashboard link: https://syzkaller.appspot.com/bug?extid=d56e0d33caf7d1a02821
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14657573480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16dd145d480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: do not BUG_ON on failure to get dir index for new snapshot

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

