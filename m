Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154C2217946
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 22:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgGGUYH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 16:24:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728292AbgGGUYG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 16:24:06 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79B99206BE;
        Tue,  7 Jul 2020 20:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594153445;
        bh=40urT3yultzL1QLUZ36YCR16H0oUPShoY0I57dvbUr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nT/o5KAXF2gFIf05jT6b2gEiT9nuQSKnyAqyTp57qFBRm/vDI9YT0MrRyzYNOdjTG
         W+tMQIpTmbs4CxmsWHyeZdBOMG3x2QuunzX8XSwDLhY9W8x3dRhdnAJKSxJjaQ90e8
         zsyYhLPzxBRvCKxIK3EnzApxnnv0i9R+pTEq2A9s=
Date:   Tue, 7 Jul 2020 13:24:04 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+7748c5375dc20dfdb92f@syzkaller.appspotmail.com>
Cc:     bp@alien8.de, hpa@zytor.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, x86@kernel.org
Subject: Re: BUG: sleeping function called from invalid context in
 do_user_addr_fault
Message-ID: <20200707202404.GA3426938@gmail.com>
References: <0000000000002c6fbf05a8954afe@google.com>
 <0000000000006dbe1005a9dfaa7c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000006dbe1005a9dfaa7c@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 07, 2020 at 01:16:25PM -0700, syzbot wrote:
> syzbot has found a reproducer for the following crash on:
> 
> HEAD commit:    7cc2a8ea Merge tag 'block-5.8-2020-07-01' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14ed01a3100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=183dd243398ba7ec
> dashboard link: https://syzkaller.appspot.com/bug?extid=7748c5375dc20dfdb92f
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1469d28f100000
> 

The reproducer uses ioctl$FBIOPUT_VSCREENINFO on /dev/fb0, which is generating
lots of other syzbot reports.  This is probably another duplicate.
See https://lkml.kernel.org/lkml/000000000000ff323f05a053100c@google.com/T/#u
for some previous discussion.
