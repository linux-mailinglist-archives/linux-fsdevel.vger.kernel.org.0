Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A4B5EFEE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 22:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiI2Uun (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 16:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiI2Uun (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 16:50:43 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FDA1449EC;
        Thu, 29 Sep 2022 13:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IbHeC0UoLetN8Eh2Saee1yLcn/79FwEYvj2s6jPeAiI=; b=TcghY1nF1nA7Y4RCBZB2R0o+Xt
        oHKqD6itrUaXTdQzX7cZxAJFBB5oszavCObpiMaaPl13xgOIUGy8uz77hiGP695a1OcmT1YaoPNXB
        TPDiS2gqvx9OFOYLfOQ1BU2w73yq9jJO5ZEjBuzoKF4xQteTXPVuWx3J5yFLpL25qQfkFaIabEcMt
        zAs9ZZucSgkgo8aP41CDaZUF+n0vgBlTIlLBmO7m6Q4XEr/NvqPrD5vfNHuyMb1ZoaFtm9NfVqRiE
        A8XxBohMNHWwfk4Hx/O18D1Aq0p1Ftb2vDO6K9yMfQUGyE3vOrbTCwzmDaljjyIwry6xo9EIidas5
        o0u8aFTQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oe0US-0055cL-0P;
        Thu, 29 Sep 2022 20:50:40 +0000
Date:   Thu, 29 Sep 2022 21:50:40 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+84b7b87a6430a152c1f4@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] kernel panic: stack is corrupted in
 writeback_single_inode
Message-ID: <YzYFIK/jFiN6WEzT@ZenIV>
References: <0000000000008ea2da05e979435f@google.com>
 <0000000000000f962805e9d6ae62@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000000f962805e9d6ae62@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 29, 2022 at 01:25:36PM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    c3e0e1e23c70 Merge tag 'irq_urgent_for_v6.0' of git://git...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17ab519c880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
> dashboard link: https://syzkaller.appspot.com/bug?extid=84b7b87a6430a152c1f4
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157c2000880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105224b8880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/e7f1f925f94e/disk-c3e0e1e2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/830dabeedf0d/vmlinux-c3e0e1e2.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+84b7b87a6430a152c1f4@syzkaller.appspotmail.com

... and you _still_ have not bothered to Cc ntfs maintainers.
Once more, with feeling:
	If you are fuzzing something (ntfs, in this case), the people most
interested in your report are the maintainers of the code in question.
You know that from the moment you put the test together.  No matter where
exactly the oops gets triggered, what it looks like, etc.
