Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2A6781244
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 19:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379170AbjHRRnl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 13:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379229AbjHRRnZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:43:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B472102;
        Fri, 18 Aug 2023 10:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=emG3qXIaO7YAlWV3oGlGfhgkQo9laxPdQNiw90Gx9Wc=; b=fRiKkJZrSVPeWrWwrRPnd/vSim
        4Vn0YBHUdC6Sd+z6WPjGYyiwUV8CXUKNkei8B6+n3dOkBEer3jYkMBCEbIBtNywosja1Fw0nQNeXT
        MvwgJmgcgkK4OJDITE5DE8pkZU4H4ayjcNdF6MWsYCI1lwLtyxW04c4TlzevCyfknnHoATTFu5xuk
        li6tPDD/kgEPC4isq0P+gJi1TL0Q9BI4l5iz3lVo8Un9b0EOUchCXL0U1WUv5Gf7LteKDYLlVATBu
        8dqASGdTDwwe+xjiC7WZ3OaJzpcaBmQDu7AWMILuDqculAeLxge/xjEmR2tqttKyIdCdgb8D5vaVl
        slLjPsUQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qX3V9-00An9w-Sj; Fri, 18 Aug 2023 17:43:11 +0000
Date:   Fri, 18 Aug 2023 18:43:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        syzbot <syzbot+6ec38f7a8db3b3fb1002@syzkaller.appspotmail.com>,
        anton@tuxera.com, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [ntfs?] WARNING in do_open_execat
Message-ID: <ZN+tr1uluHSZqcIg@casper.infradead.org>
References: <000000000000c74d44060334d476@google.com>
 <87o7j471v8.fsf@email.froward.int.ebiederm.org>
 <202308181030.0DA3FD14@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308181030.0DA3FD14@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 18, 2023 at 10:33:26AM -0700, Kees Cook wrote:
> On Fri, Aug 18, 2023 at 11:26:51AM -0500, Eric W. Biederman wrote:
> > syzbot <syzbot+6ec38f7a8db3b3fb1002@syzkaller.appspotmail.com> writes:
> > 
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > 
> > Not an issue.
> > Nothing to do with ntfs.
> > 
> > The code is working as designed and intended.
> > 
> > syzbot generated a malformed exec and the kernel made it
> > well formed and warned about it.
> > 
> > Human beings who run syzbot please mark this as not an issue in your
> > system.  The directions don't have a way to say that the code is working
> > as expected and designed.
> 
> WARN and BUG should not be reachable from userspace, so if this can be
> tripped we should take a closer look and likely fix it...
> 
> > > HEAD commit:    16931859a650 Merge tag 'nfsd-6.5-4' of git://git.kernel.or..
> > > git tree:       upstream
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=13e2673da80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=aa796b6080b04102
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=6ec38f7a8db3b3fb1002
> > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17cdbc65a80000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1262d8cfa80000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/eecc010800b4/disk-16931859.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/f45ae06377a7/vmlinux-16931859.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/68891896edba/bzImage-16931859.xz
> > > mounted in repro: https://storage.googleapis.com/syzbot-assets/4b6ab78b223a/mount_0.gz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+6ec38f7a8db3b3fb1002@syzkaller.appspotmail.com
> > >
> > > ntfs: volume version 3.1.
> > > process 'syz-executor300' launched './file1' with NULL argv: empty string added
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 0 PID: 5020 at fs/exec.c:933 do_open_execat+0x18f/0x3f0 fs/exec.c:933
> 
> This is a double-check I left in place, since it shouldn't have been reachable:
> 
>         /*
>          * may_open() has already checked for this, so it should be
>          * impossible to trip now. But we need to be extra cautious
>          * and check again at the very end too.
>          */
>         err = -EACCES;
>         if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
>                          path_noexec(&file->f_path)))
>                 goto exit;
> 
> So yes, let's figure this out...

When trying to figure it out, remember that ntfs corrupts random memory,
so all reports from syzbot that have "ntfs" in them should be discarded.
I tried to tell them that all this work they're doing testing ntfs3 is
pointless, but they won't listen.
