Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C67417B945
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 10:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgCFJcB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 04:32:01 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46533 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgCFJcB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:32:01 -0500
Received: by mail-ed1-f65.google.com with SMTP id y3so1657852edj.13;
        Fri, 06 Mar 2020 01:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=3jEfyLUY00RD8pq5oLNxoDcRcehSkaINBT1VxKYt2l8=;
        b=lPKEoWOCV3sp8isNJOQnAUWE62dCvb2F67z8xMzkFMFqyyVCyAvWal0uqipTr7dUSS
         nzjP3aAhQKO13oDhKxSkW1e1xyh3BV0csDGW4u7mVymm72RzStaGFnJzZ7oTH4GODLsL
         kfm8R954y/LlE6qYhFnNU0OKPhYxTugdn0H3NAKPua4W4aXEuKtjFvLbooivv1Kjx+ZO
         v3dbJ0TRFZkiQV1/FCSkFUSmngHiIyVgnmFkwiWSBxcHpQHE8F0JzxBxtFwmPN7V1Ef6
         OEKQwOrVLkQC6yx+KT6z6S30RLQqfwq3bFky0q+RbNvWRE8/WLdK7a6KgFHb79NqCiz/
         yMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=3jEfyLUY00RD8pq5oLNxoDcRcehSkaINBT1VxKYt2l8=;
        b=AaxWdNN88FGDP3E+f4PesCLwmPLrd9ZokwrHWSYxvXX/NNo0nFIKx28YFA39wYZQkV
         boYJoOcWbqeqwbf85wb2zTaW5mxpNIhu8bW0PZZM1plSUMopDpBQ6iCD9j4Bm4Z/NwB6
         T2R5WVQ6+QIEkXgkeVeh/lhkzbW2zsS04cKc24APorqxcdyLzbXsw050vfRjn5rmwU4H
         3xI1j5PqiMRFQU6h0RnmnaLpqoelBPRRqffjSyoNQHstUTossv6iRvGdlUqC2jcgdM8g
         PyE095hSGooKVWjLH8dZrJermabiB30QNPZuTuMHM7C0NTKhWxzdchu0ZGY3p7B6lcKs
         xBew==
X-Gm-Message-State: ANhLgQ3d73up1BRGDxdSMf0BDWO4sgjGsjo9wQ/sJwJA4zH2jVioNqUD
        cXl0DlGbvEmqS792ltGPBXUG5gQGUBj/BSQQ6lBhdJJaglw=
X-Google-Smtp-Source: ADFU+vvpjLtXdzv2sheuMlgwOpsojwKjeENh3HdxiaWpR5EB97+0WGuOnUqve9BkSe6KmQS2BuHgdwlj2zKZPzBs2Oo=
X-Received: by 2002:a50:9b07:: with SMTP id o7mr1518139edi.139.1583487118865;
 Fri, 06 Mar 2020 01:31:58 -0800 (PST)
MIME-Version: 1.0
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
Date:   Fri, 6 Mar 2020 10:31:42 +0100
Message-ID: <CAH+2xPBuLsVjwStj4hQHDEbogKW+mXd2p66DG9X2F8nW+doyHw@mail.gmail.com>
Subject: Re: Still a pretty bad time on 5.4.6 with fuse_request_end.
To:     miklos@szeredi.hu, michael+lkml@stapelberg.ch
Cc:     fuse-devel@lists.sourceforge.net,
        Greg KH <gregkh@linuxfoundation.org>, kyle.leet@gmail.com,
        linux-fsdevel@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Bruno Thomsen <bth@kamstrup.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

First of all, sorry for the incorrect reply as I was not subscribed to
the mailing list.

A colleague and I have tested Miklos patch[1] on top of Fedora 31
5.5.7 kernel and it fixes a kernel oops[2] when using rootless
containers in Podman. Fix has been running for a few days now,
and the issue was normally reproducible within a few minutes.

Tested-by: Bruno Thomsen <bruno.thomsen@gmail.com>

/Bruno

[1] https://lore.kernel.org/linux-fsdevel/CAJfpegvBguKcNZk-p7sAtSuNH_7HfdCyYvo8Wh7X6P=hT=kPrA@mail.gmail.com/

[2] Oops when running podman workload.
kernel: BUG: kernel NULL pointer dereference, address: 0000000000000001
kernel: #PF: supervisor instruction fetch in kernel mode
kernel: #PF: error_code(0x0010) - not-present page
kernel: PGD 8000000e4cd85067 P4D 8000000e4cd85067 PUD e4cd80067 PMD 0
kernel: Oops: 0010 [#1] SMP PTI
kernel: CPU: 27 PID: 3422 Comm: fuse-overlayfs Not tainted
5.5.5-200.fc31.x86_64 #1
kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31
04/01/2014
kernel: RIP: 0010:0x1
kernel: Code: Bad RIP value.
kernel: RSP: 0018:ffffaa0d4196fc30 EFLAGS: 00010202
kernel: RAX: 0000000000000001 RBX: ffff8b5f344c2250 RCX: 0000000000000000
kernel: RDX: 0000000000000000 RSI: ffffaa0d4932fbb8 RDI: ffff8b65ac586800
kernel: RBP: ffff8b5f344c2240 R08: ffff8b5f344c22a0 R09: ffffaa0d4196fbd0
kernel: R10: ffff8b65a5c71888 R11: 0000000000000001 R12: ffff8b65ac586800
kernel: R13: 0000000000000001 R14: ffff8b65ab535dc0 R15: ffff8b5f344c2240
kernel: FS:  00007fb4239a7b80(0000) GS:ffff8b65b98c0000(0000)
knlGS:0000000000000000
kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: CR2: ffffffffffffffd7 CR3: 0000000e4cd38004 CR4: 0000000000360ee0
kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
kernel: Call Trace:
kernel:  ? fuse_request_end+0xbc/0x1f0 [fuse]
kernel:  ? fuse_dev_do_write+0x25e/0xe70 [fuse]
kernel:  ? lookup_fast+0xca/0x280
kernel:  ? fuse_dev_write+0x53/0x90 [fuse]
kernel:  ? do_iter_readv_writev+0x158/0x1d0
kernel:  ? do_iter_write+0x7d/0x190
kernel:  ? vfs_writev+0xa6/0xf0
kernel:  ? _copy_to_user+0x28/0x30
kernel:  ? readlink_copy+0x5a/0x80
kernel:  ? do_writev+0x6b/0x110
kernel:  ? do_syscall_64+0x5b/0x1c0
kernel:  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
kernel: Modules linked in: tun ip6t_REJECT nf_reject_ipv6
ip6t_rpfilter ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat
ebtable_broute ip6table_nat ip6table_mangle ip6table_raw ip6table_>
kernel: CR2: 0000000000000001
