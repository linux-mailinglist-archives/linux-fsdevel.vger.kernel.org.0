Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDEEA18574
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 08:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfEIGd5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 02:33:57 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46802 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfEIGd4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 02:33:56 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hOcct-0003kG-5d; Thu, 09 May 2019 06:33:55 +0000
Date:   Thu, 9 May 2019 07:33:55 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+494c7ddf66acac0ad747@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: general protection fault in do_move_mount
Message-ID: <20190509063355.GR23075@ZenIV.linux.org.uk>
References: <000000000000eb704c05886de151@google.com>
 <20190509063034.GQ23075@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509063034.GQ23075@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 09, 2019 at 07:30:34AM +0100, Al Viro wrote:
> On Wed, May 08, 2019 at 10:40:06PM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    80f23212 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11ab8dd0a00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=40a58b399941db7e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=494c7ddf66acac0ad747
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > 
> > Unfortunately, I don't have any reproducer for this crash yet.
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+494c7ddf66acac0ad747@syzkaller.appspotmail.com
> 
> *Ugh*
> 
> That's a bloody dumb leftover from very old variant of that thing;
> the following should fix it.

In vfs.git#fixes, will send a pull request tomorrow...
