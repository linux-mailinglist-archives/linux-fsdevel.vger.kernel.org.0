Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC89E77F8AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 16:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351329AbjHQOV5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 10:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351831AbjHQOVh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:21:37 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B3630E6
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:21:34 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-95.bstnma.fios.verizon.net [173.48.102.95])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37HEL3Gn028243
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 10:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692282065; bh=1nwFHxgw3tfo1n5h9l6XazSvo2VPtHFHrvBdlf/+dik=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=AcXY8Cbxpc45eSuMMXguUD/M9Q8pRHIdlunOILVzRi6Mu0lxVfwMvbOGNYLImlHWa
         mol8ZLM5ejT3qFiXE6Q4avFUYwvDAm8JxL4yVXYWK7UisulDQJOERhkB5MjbuMcrGn
         ke2Pqcz7RRsgeggvxB0YAPlKXWzveqyGFMYJ7WieIACPzlbmC7zq/cqFnMkFQ9Kc+B
         ZwO1VOFEClnOOiGoirlgTq8uskoV1t+BlFJhbG1/cpU+8GwoYH/f5aXYZ7eqloYU4z
         E+oEh1lN6QU/ede4Qam73R6Zltdydy4skp2EM7YGc1khET3oncbKOilybqwBDd7+DV
         lg60TDoY9p4/A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 300A515C0501; Thu, 17 Aug 2023 10:21:03 -0400 (EDT)
Date:   Thu, 17 Aug 2023 10:21:03 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+27eece6916b914a49ce7@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] [ext4?] kernel panic: EXT4-fs (device loop0): panic
 forced after error (3)
Message-ID: <20230817142103.GA2247938@mit.edu>
References: <000000000000530e0d060312199e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000530e0d060312199e@google.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 16, 2023 at 03:48:49PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ae545c3283dc Merge tag 'gpio-fixes-for-v6.5-rc6' of git://..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=13e5d553a80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=171b698bc2e613cf
> dashboard link: https://syzkaller.appspot.com/bug?extid=27eece6916b914a49ce7
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13433207a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109cd837a80000
> 
> EXT4-fs error (device loop0): ext4_validate_block_bitmap:430: comm syz-executor211: bg 0: block 46: invalid block bitmap
> Kernel panic - not syncing: EXT4-fs (device loop0): panic forced after error

#syz invalid

This is fundamentally a syzbot bug.  The file system is horrifically
corrupted, *and* the superblock has the "panic on error" (aka "panic
onfile system corruption") bit set.

This can be desireable because in a failover situation, if the file
system is found to be corrupted, you *want* the primary server to
fail, and let the secondary server to take over.  This is a technique
which is decades old.

So this is Working As Intended, and is a classic example of (a) if you
are root, you can force the file system to crash, and (b) a classic
example of syzbot noise.  (Five minutes of my life that I'm never
getting back.  :-)

						- Ted
