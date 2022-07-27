Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F71581FAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 07:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiG0F7t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jul 2022 01:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiG0F7r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jul 2022 01:59:47 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF85B3F311
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jul 2022 22:59:46 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id d124so11238380ybb.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jul 2022 22:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fwuqyQ3OHu/JxqXb5v/uPB63dGDCYAIBWB3mJRoR3DM=;
        b=kQD6DIPEehRwwi4BJVZLH7pM4B4ztost7Elbe7SKVMHvqzAmhFhI0sMHj/88d33GKf
         aTLkY29gtzAK03KA0ykONcqzVRBn/WwJoBcX3n7s/1+1Wlu8Ut7pjPL3ESTvM9Gn6BVm
         JtiEDcP8eoWmK6COO6XAUFXcIpaDD2pjNEnPn7lKI5keFVvEJBwoR32JTO0ugDLDhQFt
         VtOZRihlgxQreXviQEbtHXZsRGDA7ZjoloDBIsMqkysrD60xcfVm3Asf9J/pK3EuZVCC
         BCGQOuHGBmp8PaeXuq/g8j+fIjglCTEtaFXNPjvXIfkRvNHxVeTSWeYdCns8w30I7v61
         9qwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fwuqyQ3OHu/JxqXb5v/uPB63dGDCYAIBWB3mJRoR3DM=;
        b=byQ35aALgG9dipBibHIN8xcND1k9KReD79YxqVluwiMP6K/Ryj7qVH6sDfnzZyuWn4
         RVxp3cjxP2pNfdUrltEklkRWNRlFUdcLTQ3e7xlmj++V4aUXiPx+2x8Q8In42U36fyPV
         NEgEdatlTODmGKMiyagS3nlxUAfjiJg7R12qVg4uDcUV3TddBuQkPAU48AunItA9mv9x
         /BX8nD0cwo1UBJUMsrpHFrrcYMfFUi6shYymdumJJXYROjmCdM+lsG1uDEdEohQPakqz
         pZpn1E1JJvRz2Goay+wD2emFPHfpZuFbKe53LHaSRzssaIHOM4jwuiuKAp5XdoqLMwn9
         b5IA==
X-Gm-Message-State: AJIora+5uBqVK4FKreDiUGQbchX9PPw9t+YyceXMHBIXEjXpE/PEAmRH
        O2quTjizSkLyYyomgInaRgnQKUB69Ktluob2P2UGuQ2Dw2c=
X-Google-Smtp-Source: AGRyM1uT2kbtWmMkigenl0f5Z2+tjmu/O2BMPPSMIvHMnOo3UNWm+JpZBy1BI6OGCvR1hYWUWZmCA9gdPvgQ8ctoG6g=
X-Received: by 2002:a05:6902:512:b0:671:5739:9b7 with SMTP id
 x18-20020a056902051200b00671573909b7mr8501294ybs.338.1658901585983; Tue, 26
 Jul 2022 22:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAC6jXv3PE3rxk3NJv83jjmXLF9rVg2wLTBjB8+ZkDZWB0oLUHg@mail.gmail.com>
 <CACT4Y+aPy+Fc5Wz_d_WNh9J0KNBjMAe0eJ5OFKCg9_RP4tXk-Q@mail.gmail.com>
In-Reply-To: <CACT4Y+aPy+Fc5Wz_d_WNh9J0KNBjMAe0eJ5OFKCg9_RP4tXk-Q@mail.gmail.com>
From:   Nikhil Kshirsagar <nkshirsagar@gmail.com>
Date:   Wed, 27 Jul 2022 11:29:34 +0530
Message-ID: <CAC6jXv07mxAAZb9k3AvZS+KGV7O9wZLrQyrXgV92S8Uhi2Huug@mail.gmail.com>
Subject: Re: help with a fuse-overlayfs hang please
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     miklos@szeredi.hu, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for your mail Dmitry,

https://syzkaller.appspot.com/bug?id=7c27d8aa6c0f824004399b6b14776c9c7d8dc34d
looks similar though the "mutex_lock_nested" call isn't in the call
trace I report. Do you think it makes sense to report this one as a
new issue and open a bug?

Regards,
Nikhil.

On Wed, 27 Jul 2022 at 11:05, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, 27 Jul 2022 at 07:20, Nikhil Kshirsagar <nkshirsagar@gmail.com> wrote:
> >
> > Hello Mikolos and Dmitri!
> >
> > I'm trying to debug a fuse-overlayfs hang in the Ubuntu kernel, with versions,
> >
> > fuse_overlayfs: 1.7.1-1 (universe)
> > kernel: 5.15.0-40-generic (server)
> >
> > This happens when fuse-overlayfs
> > (https://github.com/containers/fuse-overlayfs) is stacked on top of
> > squashfuse (https://github.com/vasi/squashfuse) to allow users to
> > quickly start a container from a squashfs file without any privileges.
> >
> > The hang looks like this
> >
> > Jul 26 17:46:31  kernel: INFO: task fuse-overlayfs:326111 blocked for
> > more than 120 seconds.
> > Jul 26 17:46:31  kernel: Tainted: P OE 5.15.0-40-generic #43-Ubuntu
> > Jul 26 17:46:31  kernel: "echo 0 >
> > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > Jul 26 17:46:31  kernel: task:fuse-overlayfs state:D stack: 0
> > pid:326111 ppid:326103 flags:0x00000002
> > Jul 26 17:46:31  kernel: Call Trace:
> > Jul 26 17:46:31  kernel: <TASK>
> > Jul 26 17:46:31  kernel: __schedule+0x23d/0x590
> > Jul 26 17:46:31  kernel: ? update_load_avg+0x82/0x620
> > Jul 26 17:46:31  kernel: schedule+0x4e/0xb0
> > Jul 26 17:46:31  kernel: schedule_preempt_disabled+0xe/0x10
> > Jul 26 17:46:31  kernel: __mutex_lock.constprop.0+0x263/0x490
> > Jul 26 17:46:31  kernel: ? kmem_cache_alloc+0x1ab/0x2e0
> > Jul 26 17:46:31  kernel: __mutex_lock_slowpath+0x13/0x20
> > Jul 26 17:46:31  kernel: mutex_lock+0x34/0x40
> > Jul 26 17:46:31  kernel: fuse_lock_inode+0x2f/0x40
> > Jul 26 17:46:31  kernel: fuse_lookup+0x48/0x1b0
> > Jul 26 17:46:31  kernel: ? d_alloc_parallel+0x235/0x4b0
> > Jul 26 17:46:31  kernel: ? __legitimize_path+0x2d/0x60
> > Jul 26 17:46:31  kernel: __lookup_slow+0x81/0x150
> > Jul 26 17:46:31  kernel: walk_component+0x141/0x1b0
> > Jul 26 17:46:31  kernel: link_path_walk.part.0.constprop.0+0x23b/0x360
> > Jul 26 17:46:31  kernel: ? path_init+0x2bc/0x3e0
> > Jul 26 17:46:31  kernel: path_lookupat+0x3e/0x1b0
> > Jul 26 17:46:31  kernel: filename_lookup+0xcf/0x1d0
> > Jul 26 17:46:31  kernel: ? __check_object_size+0x19/0x20
> > Jul 26 17:46:31  kernel: ? strncpy_from_user+0x44/0x140
> > Jul 26 17:46:31  kernel: ? getname_flags.part.0+0x4c/0x1b0
> > Jul 26 17:46:31  kernel: user_path_at_empty+0x3f/0x60
> > Jul 26 17:46:31  kernel: path_getxattr+0x4a/0xb0
> > Jul 26 17:46:31  kernel: ? __secure_computing+0xa5/0x110
> > Jul 26 17:46:31  kernel: __x64_sys_lgetxattr+0x21/0x30
> > Jul 26 17:46:31  kernel: do_syscall_64+0x59/0xc0
> > Jul 26 17:46:31  kernel: ? do_syscall_64+0x69/0xc0
> > Jul 26 17:46:31  kernel: ? do_syscall_64+0x69/0xc0
> > Jul 26 17:46:31  kernel: ? irqentry_exit+0x19/0x30
> > Jul 26 17:46:31  kernel: ? exc_page_fault+0x89/0x160
> > Jul 26 17:46:31  kernel: ? asm_exc_page_fault+0x8/0x30
> > Jul 26 17:46:31  kernel: entry_SYSCALL_64_after_hwframe+0x44/0xae
> > Jul 26 17:46:31  kernel: RIP: 0033:0x7ffff7e6d2ae
> > Jul 26 17:46:31  kernel: RSP: 002b:00007fffffff7528 EFLAGS: 00000202
> > ORIG_RAX: 00000000000000c0
> > Jul 26 17:46:31  kernel: RAX: ffffffffffffffda RBX: 000055555556d6f0
> > RCX: 00007ffff7e6d2ae
> > Jul 26 17:46:31  kernel: RDX: 00007fffffff8570 RSI: 0000555555566190
> > RDI: 00007fffffff7530
> > Jul 26 17:46:31  kernel: RBP: 0000555555566190 R08: 0000000000000010
> > R09: 0000555555579cf0
> > Jul 26 17:46:31  kernel: R10: 0000000000000010 R11: 0000000000000202
> > R12: 00007fffffff8570
> > Jul 26 17:46:31  kernel: R13: 0000000000000010 R14: 00007fffffff7530
> > R15: 0000000000000000
> > Jul 26 17:46:31  kernel: </TASK>
> >
> > Seems to me the &get_fuse_inode(inode)->mutex cannot be locked,
> >
> > bool fuse_lock_inode(struct inode *inode)
> > {
> >         bool locked = false;
> >
> >         if (!get_fuse_conn(inode)->parallel_dirops) {
> >                 mutex_lock(&get_fuse_inode(inode)->mutex);
> >                 locked = true;
> >         }
> >
> >         return locked;
> > }
> >
> > Please would you be able to help me understand if this is a
> > known/reported issue, and has any fix/patch?
> >
> > Regards,
> > Nikhil.
>
> +linux-fsdevel, syzkaller
>
> Hi Nikhil,
>
> Re known bugs: we have 5 open bugs that mention "fuse" in the title,
> including some task hangs with reproducers:
> https://syzkaller.appspot.com/upstream
> These may be the easiest to check first.
>
> There were also some fixed task hangs in fuse:
> https://syzkaller.appspot.com/upstream/fixed
> But they look old enough, so fixes are probably already in your kernel.
