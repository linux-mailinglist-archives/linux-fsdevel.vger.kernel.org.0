Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE3E31D521
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 06:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhBQFmE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 00:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhBQFmC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 00:42:02 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909AEC061574;
        Tue, 16 Feb 2021 21:41:22 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lCFaR-00Evyk-GQ; Wed, 17 Feb 2021 05:41:19 +0000
Date:   Wed, 17 Feb 2021 05:41:19 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+921ef0ccfeed3a496721@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: memory leak in path_openat (2)
Message-ID: <YCysfxN1qQoalEJH@zeniv-ca.linux.org.uk>
References: <00000000000049fbd305bb816399@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000049fbd305bb816399@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 16, 2021 at 09:21:14PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    dcc0b490 Merge tag 'powerpc-5.11-8' of git://git.kernel.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1316c614d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a2fbb1a71525e1d5
> dashboard link: https://syzkaller.appspot.com/bug?extid=921ef0ccfeed3a496721
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1378ba4cd00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e73fc2d00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+921ef0ccfeed3a496721@syzkaller.appspotmail.com

Some observations:
	* .config is x86 one
	* merge in question is ppc-only
	* at least some "leaks" reported are dentries in devtmpfs,
	  which should stay around until the shutdown
Care to bisect to something more useful?
