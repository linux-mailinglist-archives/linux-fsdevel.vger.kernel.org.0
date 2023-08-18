Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EF778126D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 19:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379197AbjHRR5N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 13:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379255AbjHRR4r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:56:47 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29D54228
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 10:56:45 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bf078d5f33so9685965ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 10:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692381405; x=1692986205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NnfOvircwmzonwWqUmHydK9lcy2/QxRfXy/Xv+icsas=;
        b=DgCN3Jd/PxcsNcRlYxx4BzLrSBJrYtbbHYGvLalhOU8EtwK50AtTN3Aofh7pD8iLSi
         HcHpnOuaBYQATuaOtl4xiJe9P5KGJhumh2RYH45lnMGkkZDSuAqo8c7BUFBcgtrq+p2X
         l+QYCE4swvI2Jf2sgq6MqMup5zRm6AFkVusjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692381405; x=1692986205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnfOvircwmzonwWqUmHydK9lcy2/QxRfXy/Xv+icsas=;
        b=VEMlGrtlipKi466ACzk+FtKVlaX4Fr7ys+m5XEjJANvgVOLGoOZU+sva6IAn817+c0
         hwIMyv49p6TFRCc6+FottC0BVmaoL7Pf9vMT2Xpg4dFLV6rXUt2Rz+Cp8D/eywT+rfv/
         ABWoS6VesEaK1QkFxtSfJFBuCaM1kBAqtpOcWuBlf3bLDnHCMVD5yODyPATSLSMVc71A
         qF0Vi9e+10zIQCjD20nmutJg7BOG+DkV6Mgqz8dl7n+QCypgdcfA1XkWDVFgLCunHpuf
         KBeETamZK7M+nT4wqqDUie5Y3aJbiBFLuA3Gr1+xToe6wmGJn0LsFi5zgL008PFC/qLB
         QQgQ==
X-Gm-Message-State: AOJu0YxOPqal5EoRFONL9PcpE7Pa2LKYRTgzHCzkfg+A6D/5+erSl6uP
        ksStxkWP0jXyMh+7Qn7sHxb9/u/M1vSDdolQ/Nk=
X-Google-Smtp-Source: AGHT+IGg4gZs48PTflMiuJSOSkNRPIt40O7HOlI6qEPHZkp6HPo5TXRZIf4MGveF+BSpktQ3KpawCQ==
X-Received: by 2002:a17:902:d4d1:b0:1b8:b285:ec96 with SMTP id o17-20020a170902d4d100b001b8b285ec96mr3835658plg.23.1692381405137;
        Fri, 18 Aug 2023 10:56:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 10-20020a170902c14a00b001b8953365aesm2049883plj.22.2023.08.18.10.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 10:56:44 -0700 (PDT)
Date:   Fri, 18 Aug 2023 10:56:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        syzbot <syzbot+6ec38f7a8db3b3fb1002@syzkaller.appspotmail.com>,
        anton@tuxera.com, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [ntfs?] WARNING in do_open_execat
Message-ID: <202308181056.381D7C347@keescook>
References: <000000000000c74d44060334d476@google.com>
 <87o7j471v8.fsf@email.froward.int.ebiederm.org>
 <202308181030.0DA3FD14@keescook>
 <ZN+tr1uluHSZqcIg@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN+tr1uluHSZqcIg@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 18, 2023 at 06:43:11PM +0100, Matthew Wilcox wrote:
> On Fri, Aug 18, 2023 at 10:33:26AM -0700, Kees Cook wrote:
> > On Fri, Aug 18, 2023 at 11:26:51AM -0500, Eric W. Biederman wrote:
> > > syzbot <syzbot+6ec38f7a8db3b3fb1002@syzkaller.appspotmail.com> writes:
> > > 
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > 
> > > Not an issue.
> > > Nothing to do with ntfs.
> > > 
> > > The code is working as designed and intended.
> > > 
> > > syzbot generated a malformed exec and the kernel made it
> > > well formed and warned about it.
> > > 
> > > Human beings who run syzbot please mark this as not an issue in your
> > > system.  The directions don't have a way to say that the code is working
> > > as expected and designed.
> > 
> > WARN and BUG should not be reachable from userspace, so if this can be
> > tripped we should take a closer look and likely fix it...
> > 
> > > > HEAD commit:    16931859a650 Merge tag 'nfsd-6.5-4' of git://git.kernel.or..
> > > > git tree:       upstream
> > > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=13e2673da80000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=aa796b6080b04102
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=6ec38f7a8db3b3fb1002
> > > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17cdbc65a80000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1262d8cfa80000
> > > >
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/eecc010800b4/disk-16931859.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/f45ae06377a7/vmlinux-16931859.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/68891896edba/bzImage-16931859.xz
> > > > mounted in repro: https://storage.googleapis.com/syzbot-assets/4b6ab78b223a/mount_0.gz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+6ec38f7a8db3b3fb1002@syzkaller.appspotmail.com
> > > >
> > > > ntfs: volume version 3.1.
> > > > process 'syz-executor300' launched './file1' with NULL argv: empty string added
> > > > ------------[ cut here ]------------
> > > > WARNING: CPU: 0 PID: 5020 at fs/exec.c:933 do_open_execat+0x18f/0x3f0 fs/exec.c:933
> > 
> > This is a double-check I left in place, since it shouldn't have been reachable:
> > 
> >         /*
> >          * may_open() has already checked for this, so it should be
> >          * impossible to trip now. But we need to be extra cautious
> >          * and check again at the very end too.
> >          */
> >         err = -EACCES;
> >         if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
> >                          path_noexec(&file->f_path)))
> >                 goto exit;
> > 
> > So yes, let's figure this out...
> 
> When trying to figure it out, remember that ntfs corrupts random memory,

!! Oh. Well, then yeah, that's not great. :(

-Kees

> so all reports from syzbot that have "ntfs" in them should be discarded.
> I tried to tell them that all this work they're doing testing ntfs3 is
> pointless, but they won't listen.

-- 
Kees Cook
