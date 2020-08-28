Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5F6255E06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Aug 2020 17:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgH1Pip (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Aug 2020 11:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbgH1Pij (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:38:39 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7359BC061264;
        Fri, 28 Aug 2020 08:38:39 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBgSP-006DLM-8Z; Fri, 28 Aug 2020 15:38:25 +0000
Date:   Fri, 28 Aug 2020 16:38:25 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+c92c93d1f1aaaacdb9db@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, oleg@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com
Subject: Re: kernel BUG at fs/inode.c:LINE! (2)
Message-ID: <20200828153825.GI1236603@ZenIV.linux.org.uk>
References: <000000000000c8fcd905adefe24b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000c8fcd905adefe24b@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 28, 2020 at 06:18:17AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d012a719 Linux 5.9-rc2
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15aa650e900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=891ca5711a9f1650
> dashboard link: https://syzkaller.appspot.com/bug?extid=c92c93d1f1aaaacdb9db
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12ecb939900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140a19a9900000

Trying to reproduce...
