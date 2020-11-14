Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF002B2AEA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 04:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgKNDB3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 22:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKNDB3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 22:01:29 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12441C0613D1;
        Fri, 13 Nov 2020 19:01:28 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id t21so2292721pgl.3;
        Fri, 13 Nov 2020 19:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eEuasWYUzUxiVFkGQ/82C4A4a65oCbTJi/uGSdGDgEM=;
        b=s1lYgyC0atYBEDCnuXAZ/LuZ8RkXV9gKVcpSnCPM+wrOEdJ/sLDWaOOHN5DlBFebaG
         YbFYF7DSUxlkLcIzJW/T+j4VGbiQ0ipyruhRZMWf1lF97PTUZEtPMICelj9OtgJpMpXj
         4/OR2Q5Lh+bZP3BPmjAaeo4xZmVafzOl566H3o+II/7J+zQ7F8gB+5EMfTdgqaRJHU/W
         WGHyKCWWQBDKM7v3pnPa0DpSz8pzw497GUhfI4B6nWOafR8fgts+Zs8JmDPsWn586EUN
         t6Spyw5kfuqmgUBJ68hW9Ia1NHwJTrAddyDl7cxv/hbFSAHh0FOvndml5WndB7ONpKHk
         Gkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eEuasWYUzUxiVFkGQ/82C4A4a65oCbTJi/uGSdGDgEM=;
        b=c5b8F29efXyOTGl8Ntl1r9cHQhIPl3OXY/EMABwzt+YeN6PP/RkdcXRUljgTyVThps
         Cyc87mo6A3P8/cNHdGcF6IOPWj/yF+abgJnY3X2nD4Da1cD3Z/KGj1D1LP0zhp7qwAzX
         /GW6t20Cdd1ddZuj1pFGu1eNbyuMPtAh8mO7j3fh8rVn16/D/dL+IfCCBXbQPhw1fkWK
         KGWCDP9cTEnC6a0gPb6TA9x/No7Y9CViuPhj+dZf5ooiuEmNMc8ZT5hBV9eDGmQJZq22
         7r1tY+PwTGmSoeW0VTflyDPVMVInNgqwyHY+Tgo62Ite9VBpbTmQ5pekzzk6Pv+rCWie
         dThQ==
X-Gm-Message-State: AOAM531+8Mzgpf4LTGK6H4O5IaS3IDRYaPIu8PEq1lUF38J2mU8noTfd
        xjDa0Zx/w5o0UW4mYECz7Cs=
X-Google-Smtp-Source: ABdhPJx6nEXNmslm4ofseIcOEsiF4fjo3LPiSXpG4sD74iTKA64Lovw7QIfp+41fnJ9Q3/wdsHIF8w==
X-Received: by 2002:a05:6a00:9d:b029:18c:8dac:4a96 with SMTP id c29-20020a056a00009db029018c8dac4a96mr4711546pfj.22.1605322887271;
        Fri, 13 Nov 2020 19:01:27 -0800 (PST)
Received: from Ryzen-9-3900X.localdomain (ip68-98-75-144.ph.ph.cox.net. [68.98.75.144])
        by smtp.gmail.com with ESMTPSA id 30sm10578510pgl.45.2020.11.13.19.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 19:01:26 -0800 (PST)
Date:   Fri, 13 Nov 2020 20:01:24 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
Message-ID: <20201114030124.GA236@Ryzen-9-3900X.localdomain>
References: <20201104082738.1054792-1-hch@lst.de>
 <20201104082738.1054792-2-hch@lst.de>
 <20201110213253.GV3576660@ZenIV.linux.org.uk>
 <20201110213511.GW3576660@ZenIV.linux.org.uk>
 <20201110232028.GX3576660@ZenIV.linux.org.uk>
 <CAHk-=whTqr4Lp0NYR6k3yc2EbiF0RR17=TJPa4JBQATMR__XqA@mail.gmail.com>
 <20201111215220.GA3576660@ZenIV.linux.org.uk>
 <20201111222116.GA919131@ZenIV.linux.org.uk>
 <20201113235453.GA227700@ubuntu-m3-large-x86>
 <20201114011754.GL3576660@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114011754.GL3576660@ZenIV.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 14, 2020 at 01:17:54AM +0000, Al Viro wrote:
> On Fri, Nov 13, 2020 at 04:54:53PM -0700, Nathan Chancellor wrote:
> 
> > This patch in -next (6a9f696d1627bacc91d1cebcfb177f474484e8ba) breaks
> > WSL2's interoperability feature, where Windows paths automatically get
> > added to PATH on start up so that Windows binaries can be accessed from
> > within Linux (such as clip.exe to pipe output to the clipboard). Before,
> > I would see a bunch of Linux + Windows folders in $PATH but after, I
> > only see the Linux folders (I can give you the actual PATH value if you
> > care but it is really long).
> > 
> > I am not at all familiar with the semantics of this patch or how
> > Microsoft would be using it to inject folders into PATH (they have some
> > documentation on it here:
> > https://docs.microsoft.com/en-us/windows/wsl/interop) and I am not sure
> > how to go about figuring that out to see why this patch breaks something
> > (unless you have an idea). I have added the Hyper-V maintainers and list
> > to CC in case they know someone who could help.
> 
> Out of curiosity: could you slap WARN_ON(!iov_iter_count(iter)); right in
> the beginning of seq_read_iter() and see if that triggers?

Sure thing, it does trigger.

[    0.235058] ------------[ cut here ]------------
[    0.235062] WARNING: CPU: 15 PID: 237 at fs/seq_file.c:176 seq_read_iter+0x3b3/0x3f0
[    0.235064] CPU: 15 PID: 237 Comm: localhost Not tainted 5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #15
[    0.235065] RIP: 0010:seq_read_iter+0x3b3/0x3f0
[    0.235066] Code: ba 01 00 00 00 e8 6d d2 fc ff 4c 89 e7 48 89 ee 48 8b 54 24 10 e8 ad 8b 45 00 49 01 c5 48 29 43 18 48 89 43 10 e9 61 fe ff ff <0f> 0b e9 6f fc ff ff 0f 0b 45 31 ed e9 0d fd ff ff 48 c7 43 18 00
[    0.235067] RSP: 0018:ffff9c774063bd08 EFLAGS: 00010246
[    0.235068] RAX: ffff91a77ac01f00 RBX: ffff91a50133c348 RCX: 0000000000000001
[    0.235069] RDX: ffff9c774063bdb8 RSI: ffff9c774063bd60 RDI: ffff9c774063bd88
[    0.235069] RBP: 0000000000000000 R08: 0000000000000000 R09: ffff91a50058b768
[    0.235070] R10: ffff91a7f79f0000 R11: ffffffffbc2c2030 R12: ffff9c774063bd88
[    0.235070] R13: ffff9c774063bd60 R14: ffff9c774063be48 R15: ffff91a77af58900
[    0.235072] FS:  000000000029c800(0000) GS:ffff91a7f7bc0000(0000) knlGS:0000000000000000
[    0.235073] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.235073] CR2: 00007ab6c1fabad0 CR3: 000000037a004000 CR4: 0000000000350ea0
[    0.235074] Call Trace:
[    0.235077]  seq_read+0x127/0x150
[    0.235078]  proc_reg_read+0x42/0xa0
[    0.235080]  do_iter_read+0x14c/0x1e0
[    0.235081]  do_readv+0x18d/0x240
[    0.235083]  do_syscall_64+0x33/0x70
[    0.235085]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    0.235086] RIP: 0033:0x22c483
[    0.235086] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    0.235087] RSP: 002b:00007ffca2245ca0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    0.235088] RAX: ffffffffffffffda RBX: 0000000000a58120 RCX: 000000000022c483
[    0.235088] RDX: 0000000000000002 RSI: 00007ffca2245ca0 RDI: 0000000000000005
[    0.235089] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    0.235089] R10: 00007ab6c1fabb20 R11: 0000000000000257 R12: 0000000000a58120
[    0.235089] R13: 00007ffca2245d90 R14: 0000000000000001 R15: 00007ffca2245ce7
[    0.235091] CPU: 15 PID: 237 Comm: localhost Not tainted 5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #15
[    0.235091] Call Trace:
[    0.235092]  dump_stack+0xa1/0xfb
[    0.235094]  __warn+0x7f/0x120
[    0.235095]  ? seq_read_iter+0x3b3/0x3f0
[    0.235096]  report_bug+0xb1/0x110
[    0.235097]  handle_bug+0x3d/0x70
[    0.235098]  exc_invalid_op+0x18/0xb0
[    0.235098]  asm_exc_invalid_op+0x12/0x20
[    0.235100] RIP: 0010:seq_read_iter+0x3b3/0x3f0
[    0.235100] Code: ba 01 00 00 00 e8 6d d2 fc ff 4c 89 e7 48 89 ee 48 8b 54 24 10 e8 ad 8b 45 00 49 01 c5 48 29 43 18 48 89 43 10 e9 61 fe ff ff <0f> 0b e9 6f fc ff ff 0f 0b 45 31 ed e9 0d fd ff ff 48 c7 43 18 00
[    0.235101] RSP: 0018:ffff9c774063bd08 EFLAGS: 00010246
[    0.235101] RAX: ffff91a77ac01f00 RBX: ffff91a50133c348 RCX: 0000000000000001
[    0.235102] RDX: ffff9c774063bdb8 RSI: ffff9c774063bd60 RDI: ffff9c774063bd88
[    0.235102] RBP: 0000000000000000 R08: 0000000000000000 R09: ffff91a50058b768
[    0.235103] R10: ffff91a7f79f0000 R11: ffffffffbc2c2030 R12: ffff9c774063bd88
[    0.235103] R13: ffff9c774063bd60 R14: ffff9c774063be48 R15: ffff91a77af58900
[    0.235104]  ? seq_open+0x70/0x70
[    0.235105]  ? path_openat+0xbc0/0xc40
[    0.235106]  seq_read+0x127/0x150
[    0.235107]  proc_reg_read+0x42/0xa0
[    0.235108]  do_iter_read+0x14c/0x1e0
[    0.235109]  do_readv+0x18d/0x240
[    0.235109]  do_syscall_64+0x33/0x70
[    0.235110]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    0.235111] RIP: 0033:0x22c483
[    0.235111] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    0.235112] RSP: 002b:00007ffca2245ca0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    0.235113] RAX: ffffffffffffffda RBX: 0000000000a58120 RCX: 000000000022c483
[    0.235113] RDX: 0000000000000002 RSI: 00007ffca2245ca0 RDI: 0000000000000005
[    0.235113] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    0.235114] R10: 00007ab6c1fabb20 R11: 0000000000000257 R12: 0000000000a58120
[    0.235114] R13: 00007ffca2245d90 R14: 0000000000000001 R15: 00007ffca2245ce7
[    0.235115] ---[ end trace 92966dbcf1e9cae5 ]---

Cheers,
Nathan
