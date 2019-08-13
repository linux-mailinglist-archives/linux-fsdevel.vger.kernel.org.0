Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC7648B96B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 15:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbfHMNDY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 09:03:24 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40858 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbfHMNDT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:03:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id a93so49208634pla.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2019 06:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0YYrt8fX8NBe3Ix0ZR8N7yG5IdU706M3lTlC7xsDXZg=;
        b=nkYZnagQ/N+uvwC9Ff9zhOFqbOrUlnQYXOHbaXVlcf1nr0dsS69AaKbg1Sdb4bHqsS
         Rw0nONPYNHH+ZI1uW9Pl/qa6ZrBVPgrdhUJDjDb31Umw9OmTNIk12NcZOYodMhVYSAlG
         23CPdOXA+MqHPsRg0w23i+m4zmC12TNmy+XXKAbb9MQiARYNFSUlJSQZnQpMnxwVsbOO
         HRmYifIH193V8+HqAAajmwf/NH2chEnFGsi6FGS+rrAVoqfKdD+toWpZ1HaLEBO6YkeS
         cSIGOPhQUTmJT/u3a3EgJI8cGav7YQtcz2AbqF1+PcBStArN4hpDMUQRk1Y1j+UKWLw/
         mfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0YYrt8fX8NBe3Ix0ZR8N7yG5IdU706M3lTlC7xsDXZg=;
        b=tS30f93V1bLXXHjpp0mnoTuhGRuhvmcnx1tj8kTL3jkRNMTRKBsgbhYY/7rI3klLS/
         XutKpeHKymmIpbRTwVXm7+e3oVkqtui5DZ60oHhl9oyTek/aaUzXST0vSJUX38j4te0a
         w4usYKvN8j/1sFLH+hwfHD3E0Wc+nkQc2VTveDrJoITwhndNzbwbYQutSQkwx9/xnNXk
         ns/TlJGydHvPK3aKmtfrzK1wT1K5IQmWMLh/ZZSsZ/4DiLUQ0lSCR60Kh132wBS4sWLs
         6DfeJQm9hvRQDOAJ08mq81ue/pivTnqCEnsvUn5da5mYbH0dVR4/D9XfM0RGnYTDd/nL
         DaQA==
X-Gm-Message-State: APjAAAXlIq+V2Qugly1hcoEKLQToRL95NHI8h5OHqEQZUY/uc/z0on+A
        kM6P3i1Q5cnls+9Vbr/m8uUKzL/dOtv7rvetNQYiSQ==
X-Google-Smtp-Source: APXvYqx5QN3Xu0FjLh/BJUrsZv+FEng8X5z4EG0iHTMxlFgLEZUcutUE5Zys4DzTpckKpqeQwJEkajNChyety2rhw38=
X-Received: by 2002:a17:902:bb94:: with SMTP id m20mr5225493pls.336.1565701398386;
 Tue, 13 Aug 2019 06:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000532b860589f0669a@google.com>
In-Reply-To: <000000000000532b860589f0669a@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 13 Aug 2019 15:03:07 +0200
Message-ID: <CAAeHK+waUUNpGp1b2WqXQHkbBcQT_MonG62-bK-aEj2dvYr-gA@mail.gmail.com>
Subject: Re: general protection fault in cdev_del
To:     syzbot <syzbot+67b2bd0e34f952d0321e@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Oliver Neukum <oneukum@suse.com>
Content-Type: multipart/mixed; boundary="000000000000ad7835058fff43df"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000ad7835058fff43df
Content-Type: text/plain; charset="UTF-8"

On Tue, May 28, 2019 at 12:48 PM syzbot
<syzbot+67b2bd0e34f952d0321e@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    69bbe8c7 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=178e4526a00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c309d28e15db39c5
> dashboard link: https://syzkaller.appspot.com/bug?extid=67b2bd0e34f952d0321e
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10dc5d54a00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17cae526a00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+67b2bd0e34f952d0321e@syzkaller.appspotmail.com
>
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN PTI
> CPU: 1 PID: 2486 Comm: kworker/1:2 Not tainted 5.2.0-rc1+ #9
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: usb_hub_wq hub_event
> RIP: 0010:cdev_del+0x22/0x90 fs/char_dev.c:592
> Code: cf 0f 1f 80 00 00 00 00 55 48 89 fd 48 83 ec 08 e8 93 a5 d5 ff 48 8d
> 7d 64 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48
> 89 f8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 4f 48
> RSP: 0018:ffff8881d18e7218 EFLAGS: 00010207
> RAX: dffffc0000000000 RBX: ffff8881d249a100 RCX: ffffffff820d879e
> RDX: 000000000000000c RSI: ffffffff8167705d RDI: 0000000000000064
> RBP: 0000000000000000 R08: ffff8881d18d1800 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: ffff8881d25c9100 R14: 0000000000000000 R15: ffff8881cc2a8070
> FS:  0000000000000000(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f35af318000 CR3: 00000001cc182000 CR4: 00000000001406e0
> Call Trace:
>   tty_unregister_device drivers/tty/tty_io.c:3192 [inline]
>   tty_unregister_device+0x10d/0x1a0 drivers/tty/tty_io.c:3187
>   hso_serial_tty_unregister drivers/net/usb/hso.c:2245 [inline]
>   hso_create_bulk_serial_device drivers/net/usb/hso.c:2682 [inline]
>   hso_probe.cold+0xc8/0x120 drivers/net/usb/hso.c:2948
>   usb_probe_interface+0x30b/0x7a0 drivers/usb/core/driver.c:361
>   really_probe+0x287/0x660 drivers/base/dd.c:509
>   driver_probe_device+0x104/0x210 drivers/base/dd.c:670
>   __device_attach_driver+0x1c4/0x230 drivers/base/dd.c:777
>   bus_for_each_drv+0x15e/0x1e0 drivers/base/bus.c:454
>   __device_attach+0x217/0x360 drivers/base/dd.c:843
>   bus_probe_device+0x1e6/0x290 drivers/base/bus.c:514
>   device_add+0xae6/0x1700 drivers/base/core.c:2111
>   usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
>   generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
>   usb_probe_device+0xa2/0x100 drivers/usb/core/driver.c:266
>   really_probe+0x287/0x660 drivers/base/dd.c:509
>   driver_probe_device+0x104/0x210 drivers/base/dd.c:670
>   __device_attach_driver+0x1c4/0x230 drivers/base/dd.c:777
>   bus_for_each_drv+0x15e/0x1e0 drivers/base/bus.c:454
>   __device_attach+0x217/0x360 drivers/base/dd.c:843
>   bus_probe_device+0x1e6/0x290 drivers/base/bus.c:514
>   device_add+0xae6/0x1700 drivers/base/core.c:2111
>   usb_new_device.cold+0x8c1/0x1016 drivers/usb/core/hub.c:2534
>   hub_port_connect drivers/usb/core/hub.c:5089 [inline]
>   hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
>   port_event drivers/usb/core/hub.c:5350 [inline]
>   hub_event+0x1adc/0x35a0 drivers/usb/core/hub.c:5432
>   process_one_work+0x90a/0x1580 kernel/workqueue.c:2268
>   worker_thread+0x96/0xe20 kernel/workqueue.c:2414
>   kthread+0x30e/0x420 kernel/kthread.c:254
>   ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
> Modules linked in:
> ---[ end trace 3b56fa5a205cba42 ]---
> RIP: 0010:cdev_del+0x22/0x90 fs/char_dev.c:592
> Code: cf 0f 1f 80 00 00 00 00 55 48 89 fd 48 83 ec 08 e8 93 a5 d5 ff 48 8d
> 7d 64 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48
> 89 f8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 4f 48
> RSP: 0018:ffff8881d18e7218 EFLAGS: 00010207
> RAX: dffffc0000000000 RBX: ffff8881d249a100 RCX: ffffffff820d879e
> RDX: 000000000000000c RSI: ffffffff8167705d RDI: 0000000000000064
> RBP: 0000000000000000 R08: ffff8881d18d1800 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: ffff8881d25c9100 R14: 0000000000000000 R15: ffff8881cc2a8070
> FS:  0000000000000000(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f35af318000 CR3: 00000001cc182000 CR4: 00000000001406e0

Trying Oliver's fix from [1]:

#syz test: https://github.com/google/kasan.git 69bbe8c7

[1] https://groups.google.com/forum/#!msg/syzkaller-bugs/5qVDUDTxXYQ/OlN_ZX6LBwAJ

>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches

--000000000000ad7835058fff43df
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-usb-hso-initialize-so-that-we-can-tear-down-in-the-e.patch"
Content-Disposition: attachment; 
	filename="0001-usb-hso-initialize-so-that-we-can-tear-down-in-the-e.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jz9u5b6z0>
X-Attachment-Id: f_jz9u5b6z0

RnJvbSA2ODY3YWJjMTcwMWYxODg5MmQzMmU4YWVhZjY0NDkwMWU5YmNiZjgyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBPbGl2ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29tPgpEYXRl
OiBXZWQsIDUgSnVuIDIwMTkgMTM6NDk6MjEgKzAyMDAKU3ViamVjdDogW1BBVENIXSB1c2I6IGhz
bzogaW5pdGlhbGl6ZSBzbyB0aGF0IHdlIGNhbiB0ZWFyIGRvd24gaW4gdGhlIGVycm9yCiBjYXNl
CgpJbml0dWFsaXphdGlvbiBtdXN0IGZvbGxvdyB0aGUgc2VxdWVuY2Ugc3R1ZmYgaXMgdW5kb25l
IGluIGNhc2UKd2UgYmFpbCBvdXQuIFRodXMgdGhlIHBhcmVudCBwb2ludGVyIG11c3QgYmUgc2V0
IGVhcmxpZXIuCgpTaWduZWQtb2ZmLWJ5OiBPbGl2ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29t
PgotLS0KIGRyaXZlcnMvbmV0L3VzYi9oc28uYyB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L3VzYi9oc28uYyBiL2RyaXZlcnMvbmV0L3VzYi9oc28uYwppbmRleCA2YTBlY2RkZmYzMTAuLjRk
OTEwMGZiOWY2ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvdXNiL2hzby5jCisrKyBiL2RyaXZl
cnMvbmV0L3VzYi9oc28uYwpAQCAtMjY1Myw2ICsyNjUzLDkgQEAgc3RhdGljIHN0cnVjdCBoc29f
ZGV2aWNlICpoc29fY3JlYXRlX2J1bGtfc2VyaWFsX2RldmljZSgKIAkJCQkgICAgIEJVTEtfVVJC
X1RYX1NJWkUpKQogCQlnb3RvIGV4aXQ7CiAKKwkvKiBhbmQgcmVjb3JkIHRoaXMgc2VyaWFsICov
CisJc2V0X3NlcmlhbF9ieV9pbmRleChzZXJpYWwtPm1pbm9yLCBzZXJpYWwpOworCiAJc2VyaWFs
LT5pbl9lbmRwID0gaHNvX2dldF9lcChpbnRlcmZhY2UsIFVTQl9FTkRQT0lOVF9YRkVSX0JVTEss
CiAJCQkJICAgICBVU0JfRElSX0lOKTsKIAlpZiAoIXNlcmlhbC0+aW5fZW5kcCkgewpAQCAtMjY2
OSw5ICsyNjcyLDYgQEAgc3RhdGljIHN0cnVjdCBoc29fZGV2aWNlICpoc29fY3JlYXRlX2J1bGtf
c2VyaWFsX2RldmljZSgKIAogCXNlcmlhbC0+d3JpdGVfZGF0YSA9IGhzb19zdGRfc2VyaWFsX3dy
aXRlX2RhdGE7CiAKLQkvKiBhbmQgcmVjb3JkIHRoaXMgc2VyaWFsICovCi0Jc2V0X3NlcmlhbF9i
eV9pbmRleChzZXJpYWwtPm1pbm9yLCBzZXJpYWwpOwotCiAJLyogc2V0dXAgdGhlIHByb2MgZGly
cyBhbmQgZmlsZXMgaWYgbmVlZGVkICovCiAJaHNvX2xvZ19wb3J0KGhzb19kZXYpOwogCi0tIAoy
LjE2LjQKCg==
--000000000000ad7835058fff43df--
