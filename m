Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47465F2070
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Oct 2022 00:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiJAWuu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Oct 2022 18:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiJAWur (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Oct 2022 18:50:47 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6E13FEDF;
        Sat,  1 Oct 2022 15:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H4LaXW0+7ZvmWnd7PNPP0COXcadj5Lnd9XTe3XsLQRo=; b=A5kKn8uMAOSZ/Hg4aSpMUwoy7+
        kvtPPToJKHrTQ013P5wQ+tEgCtlzPqsxXFoL4J/U5/oD8kCLfFpTLtwS76WG5K6PHBM+shAG5mUgi
        0Sxt6LcHmWuuzGqdfhfqcqUw1K+HmEhNfEsWKn0ahDGNQYTozUb34Io+M2oJhK4v4fnDZ1l2Aogcn
        OtS5srY31qQnh8+P2Ck/0U4c4i5Kwj/zOTMMK3DmdFD0ToL4DI4bHExst+Xq9jfACvXhjfksstkm6
        QCIa14lttj5rizH8kGGtakO2cIJJPzIgu7lT2LEBLPit3gzYoCtzk9VnSPvkB63xPaOf6P3uuZXGn
        H38kDbKQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oelJf-005nTB-1I;
        Sat, 01 Oct 2022 22:50:39 +0000
Date:   Sat, 1 Oct 2022 23:50:39 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+7902cd7684bc35306224@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in __brelse
Message-ID: <YzjEP8639prhhCKe@ZenIV>
References: <000000000000d2adfa05e9c2d0b9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d2adfa05e9c2d0b9@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 28, 2022 at 01:43:39PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    46452d3786a8 Merge tag 'sound-6.0-rc8' of git://git.kernel..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=154595ef080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=755695d26ad09807
> dashboard link: https://syzkaller.appspot.com/bug?extid=7902cd7684bc35306224
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127543c4880000

For crying out loud...  Seeing that it has

syz_mount_image$udf(

in it and seeing that MAINTAINERS has

UDF FILESYSTEM
M:      Jan Kara <jack@suse.com>
S:      Maintained
F:      Documentation/filesystems/udf.rst
F:      fs/udf/

which word is missing in Subject and which mail is missing in Cc?

"[syzbot] WARNING in __brelse" says nothing beyond "it's probably about
something that does buffer_head IO".  Recepients of that mail have no way
to find which fs is involved without wget of your reproducer and looking
into it (well, that or start a browser, cut'n'paste the URL there, etc.).
You, OTOH, have that information from the very beginning...
