Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8975D39093C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 20:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhEYSvq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 14:51:46 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:35002 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbhEYSvq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 14:51:46 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1llc7z-007eCj-Ng; Tue, 25 May 2021 12:50:08 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1llc7x-005OOw-F9; Tue, 25 May 2021 12:50:07 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     menglong8.dong@gmail.com
Cc:     mcgrof@kernel.org, josh@joshtriplett.org, viro@zeniv.linux.org.uk,
        keescook@chromium.org, samitolvanen@google.com, ojeda@kernel.org,
        johan@kernel.org, bhelgaas@google.com, masahiroy@kernel.org,
        dong.menglong@zte.com.cn, joe@perches.com, axboe@kernel.dk,
        hare@suse.de, jack@suse.cz, tj@kernel.org,
        gregkh@linuxfoundation.org, song@kernel.org, neilb@suse.de,
        akpm@linux-foundation.org, f.fainelli@gmail.com, arnd@arndb.de,
        linux@rasmusvillemoes.dk, wangkefeng.wang@huawei.com,
        brho@google.com, mhiramat@kernel.org, rostedt@goodmis.org,
        vbabka@suse.cz, glider@google.com, pmladek@suse.com,
        chris@chrisdown.name, jojing64@gmail.com, terrelln@fb.com,
        geert@linux-m68k.org, mingo@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeyu@kernel.org
References: <20210525141524.3995-1-dong.menglong@zte.com.cn>
        <20210525141524.3995-3-dong.menglong@zte.com.cn>
Date:   Tue, 25 May 2021 13:49:48 -0500
In-Reply-To: <20210525141524.3995-3-dong.menglong@zte.com.cn> (menglong8's
        message of "Tue, 25 May 2021 22:15:23 +0800")
Message-ID: <m18s42odgz.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1llc7x-005OOw-F9;;;mid=<m18s42odgz.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18YmYcHb1zoQ+Dyv3wanOk9z9PS7q6iEaE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4897]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;menglong8.dong@gmail.com
X-Spam-Relay-Country: 
X-Spam-Timing: total 1213 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 8 (0.7%), b_tie_ro: 7 (0.6%), parse: 0.94 (0.1%),
        extract_message_metadata: 13 (1.1%), get_uri_detail_list: 2.4 (0.2%),
        tests_pri_-1000: 5.0 (0.4%), tests_pri_-950: 1.27 (0.1%),
        tests_pri_-900: 1.15 (0.1%), tests_pri_-90: 83 (6.9%), check_bayes: 82
        (6.7%), b_tokenize: 10 (0.8%), b_tok_get_all: 8 (0.7%), b_comp_prob:
        3.3 (0.3%), b_tok_touch_all: 56 (4.6%), b_finish: 0.90 (0.1%),
        tests_pri_0: 426 (35.1%), check_dkim_signature: 0.91 (0.1%),
        check_dkim_adsp: 2.1 (0.2%), poll_dns_idle: 659 (54.3%), tests_pri_10:
        2.1 (0.2%), tests_pri_500: 668 (55.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 2/3] init/do_cmounts.c: introduce 'user_root' for initramfs
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

menglong8.dong@gmail.com writes:

> From: Menglong Dong <dong.menglong@zte.com.cn>
>
> If using container platforms such as Docker, upon initialization it
> wants to use pivot_root() so that currently mounted devices do not
> propagate to containers. An example of value in this is that
> a USB device connected prior to the creation of a containers on the
> host gets disconnected after a container is created; if the
> USB device was mounted on containers, but already removed and
> umounted on the host, the mount point will not go away until all
> containers unmount the USB device.
>
> Another reason for container platforms such as Docker to use pivot_root
> is that upon initialization the net-namspace is mounted under
> /var/run/docker/netns/ on the host by dockerd. Without pivot_root
> Docker must either wait to create the network namespace prior to
> the creation of containers or simply deal with leaking this to each
> container.
>
> pivot_root is supported if the rootfs is a initrd or block device, but
> it's not supported if the rootfs uses an initramfs (tmpfs). This means
> container platforms today must resort to using block devices if
> they want to pivot_root from the rootfs. A workaround to use chroot()
> is not a clean viable option given every container will have a
> duplicate of every mount point on the host.
>
> In order to support using container platforms such as Docker on
> all the supported rootfs types we must extend Linux to support
> pivot_root on initramfs as well. This patch does the work to do
> just that.
>
> pivot_root will unmount the mount of the rootfs from its parent mount
> and mount the new root to it. However, when it comes to initramfs, it
> donesn't work, because the root filesystem has not parent mount, which
> makes initramfs not supported by pivot_root.
>
> In order to support pivot_root on initramfs we introduce a second
> "user_root" mount which is created before we do the cpio unpacking.
> The filesystem of the "user_root" mount is the same the rootfs.
>
> While mounting the 'user_root', 'rootflags' is passed to it, and it means
> that we can set options for the mount of rootfs in boot cmd now.
> For example, the size of tmpfs can be set with 'rootflags=size=1024M'.

What is the flow where docker uses an initramfs?

Just thinking about this I am not being able to connect the dots.

The way I imagine the world is that an initramfs will be used either
when a linux system boots for the first time, or an initramfs would
come from the distribution you are running inside a container.  In
neither case do I see docker being in a position to add functionality
to the initramfs as docker is not responsible for it.

Is docker doing something creating like running a container in a VM,
and running some directly out of the initramfs, and wanting that code
to exactly match the non-VM case?

If that is the case I think the easy solution would be to actually use
an actual ramdisk where pivot_root works.

I really don't see why it makes sense for docker to be a special
snowflake and require kernel features that no other distribution does.

It might make sense to create a completely empty filesystem underneath
an initramfs, and use that new rootfs as the unchanging root of the
mount tree, if it can be done with a trivial amount of code, and
generally make everything cleaner.

As this change sits it looks like a lot of code to handle a problem
in the implementation of docker.   Which quite frankly will be a pain
to have to maintain if this is not a clean general feature that
other people can also use.

Eric
