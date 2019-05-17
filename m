Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23EF021954
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 15:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfEQNsx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 09:48:53 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46198 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbfEQNsx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 09:48:53 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hRdEA-0001Yb-Ey; Fri, 17 May 2019 13:48:50 +0000
Date:   Fri, 17 May 2019 14:48:50 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+73c7fe4f77776505299b@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sabin.rapan@gmail.com, syzkaller-bugs@googlegroups.com
Subject: Re: BUG: unable to handle kernel paging request in do_mount
Message-ID: <20190517134850.GG17978@ZenIV.linux.org.uk>
References: <00000000000014285d05765bf72a@google.com>
 <0000000000000eaf23058912af14@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000000eaf23058912af14@google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 17, 2019 at 03:17:02AM -0700, syzbot wrote:
> This bug is marked as fixed by commit:
> vfs: namespace: error pointer dereference in do_remount()
> But I can't find it in any tested tree for more than 90 days.
> Is it a correct commit? Please update it by replying:
> #syz fix: exact-commit-title
> Until then the bug is still considered open and
> new crashes with the same signature are ignored.

Could somebody explain how the following situation is supposed to
be handled:

1) branch B1 with commits  C1, C2, C3, C4 is pushed out
2) C2 turns out to have a bug, which gets caught and fixed
3) fix is folded in and branch B2 with C1, C2', C3', C4' is
pushed out.  The bug is not in it anymore.
4) B1 is left mouldering (or is entirely removed); B2 is
eventually merged into other trees.

This is normal and it appears to be problematic for syzbot.
How to deal with that?  One thing I will *NOT* do in such
situations is giving up on folding the fixes in.  Bisection
hazards alone make that a bad idea.
