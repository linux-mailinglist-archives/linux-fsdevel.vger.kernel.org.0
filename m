Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E24781204
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 19:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379088AbjHRRdy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 13:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379080AbjHRRd3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:33:29 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7243A98
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 10:33:28 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bf3a2f44ffso7146425ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 10:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692380008; x=1692984808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9LqROe/xq3VxxB2qIfe85nYrLgNe52o6xYWxNbvcSzw=;
        b=SmQZg12z/hBsunEu7RHOuUKrqiDUOk0W+yPuT9G37hg+RkAfxXMwjDRJq8KSr6aXtL
         uBJQbBcikFT6uhkVNj6XWwIgHdkJ7/wUe8TxcW57HsezTr67A9qMyrnPSQbBr9Y1L3jo
         eMCa6nZ5xloAE7/UdJ/VVe9hwgROpMLKku6/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692380008; x=1692984808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LqROe/xq3VxxB2qIfe85nYrLgNe52o6xYWxNbvcSzw=;
        b=e4Pit/bPLMkWDGuvAQPEF2hyw/DYWyCetoBIpkYfZ7Nt664rhIzFqtvMC5Tqw7Xt2R
         tfjqLUbrowhAVpx8vo0mDYY0ySQl75VL6/cxHzPs3L3s6y0yeVlJRl9FYPkFC6Sclt8J
         z8Hc6ziHepopf94k4QwUshqgldOo19DtY1rYFpIlEfcmpO5jBtpqu4NnUq05p0oBjpzd
         7FM+LvE9QFC/ELnHn3lg38PghWZDm4yrQOhkgZyQXenFhvGOPcO0nFMf1bVWV07imUqt
         XZUnuwE643EbIcYImnkyCoPpVMEv416NGh/LsZN+qsYfxhwgoaaffr+lPZq5aWuOt/yf
         eBjw==
X-Gm-Message-State: AOJu0YzOTxA6xKvSoRGCeQ4iWMpGwNx3V9QWuPimkyiFuwm/J+qrauA8
        XfZx9i2ruQfOMqR9rGsPPoXW6M0OiY1pj5qMSlI=
X-Google-Smtp-Source: AGHT+IG7+VZxTbILfrSZv34tOHbnZPnsXjg6L4Mnlt+0JSwNWtlbPKrNujxb5jWd0t+KLFeCAP/iQw==
X-Received: by 2002:a17:902:b198:b0:1bc:48dc:d881 with SMTP id s24-20020a170902b19800b001bc48dcd881mr3193969plr.8.1692380007700;
        Fri, 18 Aug 2023 10:33:27 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 10-20020a170902c14a00b001b8953365aesm2029761plj.22.2023.08.18.10.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 10:33:27 -0700 (PDT)
Date:   Fri, 18 Aug 2023 10:33:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     syzbot <syzbot+6ec38f7a8db3b3fb1002@syzkaller.appspotmail.com>,
        anton@tuxera.com, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [ntfs?] WARNING in do_open_execat
Message-ID: <202308181030.0DA3FD14@keescook>
References: <000000000000c74d44060334d476@google.com>
 <87o7j471v8.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7j471v8.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 18, 2023 at 11:26:51AM -0500, Eric W. Biederman wrote:
> syzbot <syzbot+6ec38f7a8db3b3fb1002@syzkaller.appspotmail.com> writes:
> 
> > Hello,
> >
> > syzbot found the following issue on:
> 
> Not an issue.
> Nothing to do with ntfs.
> 
> The code is working as designed and intended.
> 
> syzbot generated a malformed exec and the kernel made it
> well formed and warned about it.
> 
> Human beings who run syzbot please mark this as not an issue in your
> system.  The directions don't have a way to say that the code is working
> as expected and designed.

WARN and BUG should not be reachable from userspace, so if this can be
tripped we should take a closer look and likely fix it...

> > HEAD commit:    16931859a650 Merge tag 'nfsd-6.5-4' of git://git.kernel.or..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=13e2673da80000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=aa796b6080b04102
> > dashboard link: https://syzkaller.appspot.com/bug?extid=6ec38f7a8db3b3fb1002
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17cdbc65a80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1262d8cfa80000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/eecc010800b4/disk-16931859.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/f45ae06377a7/vmlinux-16931859.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/68891896edba/bzImage-16931859.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/4b6ab78b223a/mount_0.gz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+6ec38f7a8db3b3fb1002@syzkaller.appspotmail.com
> >
> > ntfs: volume version 3.1.
> > process 'syz-executor300' launched './file1' with NULL argv: empty string added
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 5020 at fs/exec.c:933 do_open_execat+0x18f/0x3f0 fs/exec.c:933

This is a double-check I left in place, since it shouldn't have been reachable:

        /*
         * may_open() has already checked for this, so it should be
         * impossible to trip now. But we need to be extra cautious
         * and check again at the very end too.
         */
        err = -EACCES;
        if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
                         path_noexec(&file->f_path)))
                goto exit;

So yes, let's figure this out...

-- 
Kees Cook
