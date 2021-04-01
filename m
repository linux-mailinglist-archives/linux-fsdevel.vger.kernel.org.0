Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C94B351E9D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 20:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbhDASoE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 14:44:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238674AbhDASfB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:35:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C895860FDA;
        Thu,  1 Apr 2021 18:32:57 +0000 (UTC)
Date:   Thu, 1 Apr 2021 20:32:54 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     syzbot <syzbot+c88a7030da47945a3cc3@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, chaitanya.kulkarni@wdc.com, damien.lemoal@wdc.com,
        hch@lst.de, johannes.thumshirn@edc.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] WARNING in mntput_no_expire (2)
Message-ID: <20210401183254.yup76gxvxk7foc3c@wittgenstein>
References: <0000000000003a565e05bee596f2@google.com>
 <000000000000f9391c05bee831ad@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000f9391c05bee831ad@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 01, 2021 at 05:16:03AM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 73d90386b559d6f4c3c5db5e6bb1b68aae8fd3e7
> Author: Damien Le Moal <damien.lemoal@wdc.com>
> Date:   Thu Jan 28 04:47:27 2021 +0000
> 
>     nvme: cleanup zone information initialization
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1440e986d00000
> start commit:   d19cc4bf Merge tag 'trace-v5.12-rc5' of git://git.kernel.o..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1640e986d00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1240e986d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d1a3d65a48dbd1bc
> dashboard link: https://syzkaller.appspot.com/bug?extid=c88a7030da47945a3cc3
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f50d11d00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137694a1d00000
> 
> Reported-by: syzbot+c88a7030da47945a3cc3@syzkaller.appspotmail.com
> Fixes: 73d90386b559 ("nvme: cleanup zone information initialization")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

That seems like a bogus bisect. Please see the bisect I provided in the
thread which seems more likely (Fyi, b4 mbox on the original thread
should help to get at those messages.).

Christian
