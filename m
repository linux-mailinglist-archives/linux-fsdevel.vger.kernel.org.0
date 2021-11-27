Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE45E45FF76
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Nov 2021 15:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbhK0Oz2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Nov 2021 09:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244635AbhK0Ox1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Nov 2021 09:53:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2478C06175E
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Nov 2021 06:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EDlX/d509WnwXtKnyV3OhYKU2Jux+wH1IMgfZGLS5Ec=; b=oZzGRn1D6c5g/WYdln3a1nCSVx
        jMdGpnYCytPli2SGymByaI6jvRLs/gpVb/KIx1P6bD7hWpr/WbiiFHoioAtszMTMxSubmhlPwaYdT
        7Uv/Req9i36OiKYnjvjEqwIMX/tXw09VroOyFeOiWXlvhJRqEDMPBokQkzyxDteVh2hWu/+b1eFgY
        4PmDSKJeTm8ba2ojgcYa/Vw2ThSTmvyDpFoJSt1TvsowLVRw/Y6iJECovBnrvemPmFi9scq0WGR9t
        IFg2ypJIfxM6MqlJmtxzA5uDdEzMXFqYaS0W1gfFw88pIhYT9wTAuj5eTtE4NTWLDfEXu8ZyvM/y+
        QPFTNsZg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqz1l-00FTbz-T5; Sat, 27 Nov 2021 14:50:09 +0000
Date:   Sat, 27 Nov 2021 14:50:09 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mohan R <mohan43u@gmail.com>
Cc:     uwe.sauter.de@gmail.com, almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, ntfs3@lists.linux.dev
Subject: Re: Bug using new ntfs3 file system driver (5.15.2 on Arch Linux)
Message-ID: <YaJFoadpGAwPfdLv@casper.infradead.org>
References: <CAFYqD2pe-sjPrHXGsNCHa2fcdECNm44UEZbEn4P5VgygFnrn7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFYqD2pe-sjPrHXGsNCHa2fcdECNm44UEZbEn4P5VgygFnrn7A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 27, 2021 at 07:43:06PM +0530, Mohan R wrote:
> Hi,
> 
> I confirm this issue. I tried to rsync between two ntfs3 mounts, but
> rsync got killed unexpectedly.

This is a completely different problem.

> Nov 27 19:21:53 mohanlaptop0 kernel: BUG: unable to handle page fault
> for address: ffffb9c24fb74000

The address has nothing in common with the address in the original
report.

> Nov 27 19:21:53 mohanlaptop0 kernel: #PF: supervisor read access in kernel mode
> Nov 27 19:21:53 mohanlaptop0 kernel: #PF: error_code(0x0000) - not-present page
> Nov 27 19:21:53 mohanlaptop0 kernel: PGD 100000067 P4D 100000067 PUD
> 1001bd067 PMD 10460a067 PTE 0
> Nov 27 19:21:53 mohanlaptop0 kernel: Oops: 0000 [#2] PREEMPT SMP NOPTI
> Nov 27 19:21:53 mohanlaptop0 kernel: CPU: 5 PID: 144039 Comm: rsync
> Not tainted 5.15.5-arch1-1 #1 f0168f793e3f707b46715a62fafabd6a40826924
> Nov 27 19:21:53 mohanlaptop0 kernel: Hardware name: Dell Inc. Inspiron
> 14 5410/0CKN95, BIOS 2.2.1 07/27/2021
> Nov 27 19:21:53 mohanlaptop0 kernel: RIP: 0010:show_trace_log_lvl+0x1a4/0x32d
> Nov 27 19:21:53 mohanlaptop0 kernel: Code: c7 14 60 a5 86 e8 0f be 00
> 00 4d 85 ed 74 41 0f b6 95 37 ff ff ff 4c 89 f1 4c 89 ee 48 8d bd 50
> ff ff ff e8 dc fd ff ff eb 26 <4c> 8b 3b 48 8d bd 70 ff ff ff e8 2e 4e
> 52 ff 4c 89 ff 48 89 85 28

That's annoying.  show_trace_log_lvl() isn't supposed to crash.

> Nov 27 19:21:53 mohanlaptop0 kernel: RSP: 0018:ffffb9c24fb738d8 EFLAGS: 00010012
> Nov 27 19:21:53 mohanlaptop0 kernel: RAX: 0000000000000000 RBX:
> ffffb9c24fb73fff RCX: 0000000000000000
> Nov 27 19:21:53 mohanlaptop0 kernel: RDX: 0000000000000000 RSI:
> 0000000000000000 RDI: 0000000000000000
> Nov 27 19:21:53 mohanlaptop0 kernel: RBP: ffffb9c24fb739b8 R08:
> 0000000000000000 R09: 0000000000000000
> Nov 27 19:21:53 mohanlaptop0 kernel: R10: 0000000000000000 R11:
> 0000000000000000 R12: ffff949c432b0000
> Nov 27 19:21:53 mohanlaptop0 kernel: R13: 0000000000000000 R14:
> ffffffff86a7d25f R15: 0000000000002b00
> Nov 27 19:21:53 mohanlaptop0 kernel: FS:  00007f40259b8580(0000)
> GS:ffff949dc7740000(0000) knlGS:0000000000000000
> Nov 27 19:21:53 mohanlaptop0 kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> Nov 27 19:21:53 mohanlaptop0 kernel: CR2: ffffb9c24fb74000 CR3:
> 00000001b114c005 CR4: 0000000000770ee0
> Nov 27 19:21:53 mohanlaptop0 kernel: PKRU: 55555554
> Nov 27 19:21:53 mohanlaptop0 kernel: Call Trace:
> Nov 27 19:21:53 mohanlaptop0 kernel:  <TASK>
> Nov 27 19:21:53 mohanlaptop0 kernel:  __die_body.cold+0x1a/0x1f
> Nov 27 19:21:53 mohanlaptop0 kernel:  page_fault_oops+0x19e/0x310
> Nov 27 19:21:53 mohanlaptop0 kernel:  exc_page_fault+0xda/0x180
> Nov 27 19:21:53 mohanlaptop0 kernel:  asm_exc_page_fault+0x1e/0x30
> Nov 27 19:21:53 mohanlaptop0 kernel: RIP: 0010:0xffffff8586d685ff
> Nov 27 19:21:53 mohanlaptop0 kernel: Code: Unable to access opcode
> bytes at RIP 0xffffff8586d685d5.
> Nov 27 19:21:53 mohanlaptop0 kernel: RSP: 0018:ffffb9c24fb73b4f EFLAGS: 00010246
> Nov 27 19:21:53 mohanlaptop0 kernel: RAX: 0000000000000000 RBX:
> 0000000000001700 RCX: 0000000000000000
> Nov 27 19:21:53 mohanlaptop0 kernel: RDX: 0000000000000000 RSI:
> 0000000000000000 RDI: 0000000000000000
> Nov 27 19:21:53 mohanlaptop0 kernel: RBP: ffb9c24fb73c3800 R08:
> 0000000000000000 R09: 0000000000000000
> Nov 27 19:21:53 mohanlaptop0 kernel: R10: 0000000000000000 R11:
> 0000000000000000 R12: ff949b43a8426800
> Nov 27 19:21:53 mohanlaptop0 kernel: R13: 00000001112ccaff R14:
> fff6a0c99d400000 R15: 00000000000056ff

This is where the real bug happened.  It would be helpful if you
could run
./scripts/faddr2line /path/to/vmlinux page_cache_ra_unbounded+0x1c5/0x250

It'll spit out something like:
page_cache_ra_unbounded at mm/readahead.c:241

but probably a different line number from that.

> Nov 27 19:21:53 mohanlaptop0 kernel:  ? page_cache_ra_unbounded+0x1c5/0x250
> Nov 27 19:21:53 mohanlaptop0 kernel:  ? filemap_get_pages+0x269/0x730
> Nov 27 19:21:53 mohanlaptop0 kernel:  ? filemap_read+0xb9/0x360
> Nov 27 19:21:53 mohanlaptop0 kernel:  ? new_sync_read+0x156/0x1f0
> Nov 27 19:21:53 mohanlaptop0 kernel:  ? vfs_read+0xff/0x1a0
> Nov 27 19:21:53 mohanlaptop0 kernel:  ? ksys_read+0x67/0xf0
