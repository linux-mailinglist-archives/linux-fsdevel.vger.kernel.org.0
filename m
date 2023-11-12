Return-Path: <linux-fsdevel+bounces-2774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AD07E8FDD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 14:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1E2E1C208D2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 13:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478FD8BE5;
	Sun, 12 Nov 2023 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fk/3AcVs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D5C8482
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Nov 2023 13:08:05 +0000 (UTC)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26231272C;
	Sun, 12 Nov 2023 05:08:03 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5bd306f86a8so2295617a12.0;
        Sun, 12 Nov 2023 05:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699794482; x=1700399282; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RWVxpLK427H4whnOsLZxvmuxHp90iMSfaDnF1x/Reg=;
        b=fk/3AcVsvrzDkz1cIzirxFTQ7ihg91UmpCC4zbn7R4JzpNefhYCoWIoa31BRfp4TLt
         NP4qNTT0wXuaszTECcZs8WIvQfgbdNb8RQFK+l+BMHGHq8R1mL3h+RYkDUh/kV/8S+4e
         BTRrrMP5Zwha7P+NzrY/YDHFTZxWy/+Jx92wpJg0al3OGdInoAl3pCl+N7RdfiUP+opV
         8cc3HNfTapSdeKZ3HiTOkAIdklzrhO2RRPp17Fhs584E5WR3Z8KAZUSe8c0TXEYLsVlf
         oSO7Bf/0/bDSE6QOVklIkTQtUtZWo1quqZbfUAha6ubhUuDDEj1hQRzrdtEahdDQqjlr
         VbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699794482; x=1700399282;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0RWVxpLK427H4whnOsLZxvmuxHp90iMSfaDnF1x/Reg=;
        b=RnCtCuXMJLWdM1Wm0rPy1fBNrE9ruRJ194183yxj+XdyI7DGKclOBy5/B9NUZC11Wb
         JVs3pYVVh2F9s9KWvzUlvI0m7P5bDUpXEuROpFfR7S+JyTdO6rnFeWjDUBZJ1eZFoZxl
         ndbj3OhvMs6XItRtpL2OC3yZREwYA+n2h7kxn4QqICH95ywZKNOH78ij8/YeqGJM7CHG
         auR7hy4iyxZEgskFfq37NJ3xci5i+utvt6AtLAIr64kOuflmfXKJ91cCy04xQ2h6Mh+I
         e77shEt86KTs3v8lwehLxqJSap4U9Dgc83GcoqUCgKBmb3oS+xkXh5O2dvEs8RqlVc73
         aBJw==
X-Gm-Message-State: AOJu0Yw+0rVk9Tcwk3W4SlefNam/0LrtKxJ4h8XBAzziQvJFwL3IMQ0p
	UwVgSY7DKhtBjsFSgrSQ/xNyNTwiic/DnA==
X-Google-Smtp-Source: AGHT+IHPJAfhni0/ObKioqYvoX6TGhRp50dQHj13OyNKx/2qLZH9UgXzwDvJ1gJxfAYbA7djvY9i0w==
X-Received: by 2002:a17:903:1210:b0:1cc:87f8:96bc with SMTP id l16-20020a170903121000b001cc87f896bcmr3209455plh.15.1699794482147;
        Sun, 12 Nov 2023 05:08:02 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090322c300b001c3721897fcsm2558309plg.277.2023.11.12.05.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 05:08:01 -0800 (PST)
Message-ID: <7fa629b5-74bb-43a2-a1bc-38c4a221b30c@gmail.com>
Date: Sun, 12 Nov 2023 20:07:53 +0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>
Cc: Anders Larsen <al@alarsen.net>, Al Viro <viro@zeniv.linux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Niek Nooijens <nieknooijens@gmail.com>,
 Monthero Ronald <rhmcruiser@gmail.com>
From: Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Kernel panic on listing QNX4 fs directory
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

I notice a bug report on Bugzilla [1]. Quoting from it:

> When mounting a QNX4 filesystem in linux 6.6.0 (latest mainline) listing a directory may fail and cause a kernel panic.
> 
> 
> First discovered on ubuntu's own kernel, however I was curious if this was ubuntu-specific. turned out it wasn't. I compiled 6.6.0 from scratch with the attached config.
> 
> 
> steps to reproduce:
> 1. grab 6.6.0 from kernel.org main page.
> 2. apply attached config
> 3. make modules_install
> 4. sudo make install
> 5. reboot into new kernel
> 6. open disk image with disk image mounter (attaches it to /dev/loop30)
> 7. mount /dev/loop30p3 /mnt #(qnx partition) 
> 8. cd /dmnt
> 9. execute ls a few times in different directories.
> 
> 
> the first ls will give a [detected buffer overflow in strlen] kernel message.
> after a few times it completely hangs. 
> 
> 
> /var/log/kern.log reveals a full on panic:
> 
> Nov  7 10:34:09 noonie-T580-Linux kernel: [  234.756173] kernel BUG at lib/string.c:1165!
> Nov  7 10:34:09 noonie-T580-Linux kernel: [  234.756184] invalid opcode: 0000 [#1] SMP PTI
> ....
> 
> Full log is in the attachment.

Another reporter pinned down the cause:

> Checking the provided kernel log and config the below is what seems to be cause of the panic during the lookup operation of the qnx4 directory 
> 
> Panic dump stack indicates string length buffer overflow 
> and it is at below context during  qnx4_lookup() => qnx4_find_entry() => qnx4_match()
> 
>     [ 4849.636861] detected buffer overflow in strlen
>     [ 4849.636897] ------------[ cut here ]------------
>     [ 4849.636902] kernel BUG at lib/string.c:1165!
>     [ 4849.636917] invalid opcode: 0000 [#2] SMP PTI
>     ..
>     [ 4849.637047] Call Trace:
>     [ 4849.637053]  <TASK>
>     [ 4849.637059]  ? show_trace_log_lvl+0x1d6/0x2ea
>     [ 4849.637075]  ? show_trace_log_lvl+0x1d6/0x2ea
>     [ 4849.637095]  ? qnx4_find_entry.cold+0xc/0x18 [qnx4]
>     [ 4849.637111]  ? show_regs.part.0+0x23/0x29
>     [ 4849.637123]  ? __die_body.cold+0x8/0xd
>     [ 4849.637135]  ? __die+0x2b/0x37
>     [ 4849.637147]  ? die+0x30/0x60
>     [ 4849.637161]  ? do_trap+0xbe/0x100
>     [ 4849.637171]  ? do_error_trap+0x6f/0xb0
>     [ 4849.637180]  ? fortify_panic+0x13/0x15
>     [ 4849.637192]  ? exc_invalid_op+0x53/0x70
>     [ 4849.637203]  ? fortify_panic+0x13/0x15
>     [ 4849.637215]  ? asm_exc_invalid_op+0x1b/0x20
>     [ 4849.637228]  ? fortify_panic+0x13/0x15
>     [ 4849.637240]  ? fortify_panic+0x13/0x15
>     [ 4849.637251]  qnx4_find_entry.cold+0xc/0x18 [qnx4]
>     [ 4849.637264]  qnx4_lookup+0x3c/0xa0 [qnx4]
>     [ 4849.637275]  __lookup_slow+0x85/0x150
>     [ 4849.637291]  walk_component+0x145/0x1c0
>     [ 4849.637304]  ? path_init+0x2c0/0x3f0
>     [ 4849.637316]  path_lookupat+0x6e/0x1c0
>     [ 4849.637330]  filename_lookup+0xcf/0x1d0
>     [ 4849.637341]  ? __check_object_size+0x1d/0x30
>     [ 4849.637354]  ? strncpy_from_user+0x44/0x150
>     [ 4849.637365]  ? getname_flags.part.0+0x4c/0x1b0
>     [ 4849.637375]  user_path_at_empty+0x3f/0x60
>     [ 4849.637383]  vfs_statx+0x7a/0x130
>     [ 4849.637393]  do_statx+0x45/0x80
>     ..
> 
> ( in kernel config  CONFIG_FORTIFY_SOURCE=y ) 
> 
> linux-git$ git describe 
> v6.6-16177-gea69f5e8240
> 
> static int qnx4_match(int len, const char *name,
>                       struct buffer_head *bh, unsigned long *offset)
> {
>         struct qnx4_inode_entry *de;
>         int namelen, thislen;
> 
>         if (bh == NULL) {
>                 printk(KERN_WARNING "qnx4: matching unassigned buffer !\n");
>                 return 0;
>         }
>         de = (struct qnx4_inode_entry *) (bh->b_data + *offset);
>         *offset += QNX4_DIR_ENTRY_SIZE;
>         if ((de->di_status & QNX4_FILE_LINK) != 0) {
>                 namelen = QNX4_NAME_MAX;
>         } else {
>                 namelen = QNX4_SHORT_NAME_MAX;
>         }
> 
>         thislen = strlen( de->di_fname );     << [1]  buffer overflow 
>         if ( thislen > namelen )
>                 thislen = namelen;
>         if (len != thislen) {
>                 return 0;
>         }
> 
> [reply] [−] Comment 2 

See Bugzilla for the full thread, attached kernel log, and proposed fix.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218111

-- 
An old man doll... just what I always wanted! - Clara

