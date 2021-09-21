Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C77741337A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 14:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbhIUMnO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 08:43:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232704AbhIUMnM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 08:43:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4112F61100;
        Tue, 21 Sep 2021 12:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632228104;
        bh=4Rvx3u9HCP441RTjiHrvCRRwauhtSwEWIhzMrD3GJIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JlKXwDIBNap74zCnEhXMgxiublDocy3uzTUFXF4wLpkIwOPwYBPfMaNnn9Y1ZZQ3q
         J0+wP0eLaD0JCaF/D11G8ZLrORPgtDWoh3fURT1q3UQJfA6udsu9wBHOid32rFbSxZ
         HcWM44BghlLd+aIM6vvTA/pu4P+I5TYegDDvmI3dOmrsS1RxCc0u9YGoJ1Y1zmST5t
         iOnA65shHi6DbkZI2p91BRWr/Qs+l0Ry+uXLpzKfmer8aSjVegtXyJFNW7WF+xu5F8
         4qhJJo2gFWn8v5M7BrtT+IqOVLQuO+5Btr8vmBvAWiZnYTD7lokhhHo726gYslrqqT
         1MDNBpxoR6aFw==
Date:   Tue, 21 Sep 2021 13:41:39 +0100
From:   Will Deacon <will@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+e6bda7e03e329ed0b1db@syzkaller.appspotmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] upstream test error: WARNING in __do_kernel_fault
Message-ID: <20210921124138.GA13537@willie-the-truck>
References: <000000000000f8d56e05cb50a541@google.com>
 <CACT4Y+YLEUuuNQ+2TOEevwNRvPHp-wT4W+dXAdKds_kf+upQbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YLEUuuNQ+2TOEevwNRvPHp-wT4W+dXAdKds_kf+upQbQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 10:20:40AM +0200, Dmitry Vyukov wrote:
> On Mon, 6 Sept 2021 at 11:55, syzbot
> <syzbot+e6bda7e03e329ed0b1db@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    f1583cb1be35 Merge tag 'linux-kselftest-next-5.15-rc1' of ..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17756315300000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5fe535c85e8d7384
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e6bda7e03e329ed0b1db
> > compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> > userspace arch: arm64
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+e6bda7e03e329ed0b1db@syzkaller.appspotmail.com
> 
> +Will, you added this WARNING in 42f91093b04333.
> This now crashes periodically on syzbot.

I'm still inclined to chalk this one down to a QEMU bug. We're not seeing it
anywhere else, and last time you looked at it I seem to remember that it
depended upon QEMU configuration [1].

Will

[1] https://lore.kernel.org/all/CAAeHK+wDz8aSLyjq1b=q3+HG9aJXxwYR6+gN_fTttMN5osM5gg@mail.gmail.com/
