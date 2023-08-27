Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396F6789B1B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Aug 2023 05:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjH0DV0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Aug 2023 23:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjH0DVF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Aug 2023 23:21:05 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CBB120;
        Sat, 26 Aug 2023 20:20:59 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a88e1a5286so1651811b6e.3;
        Sat, 26 Aug 2023 20:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693106458; x=1693711258;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FEyWeqX8Is1IEk36VE0KtAj4uBLFs02fZuBwFGkFHk=;
        b=d9DMQwkK1yACkkeb4HY83v9R7FyFYVaqO8J1AReDI3dbQ41zO1M1OKlETYX1yQe/Ot
         XsAU5XdUg00X8VbDReIlqbAcRX0gVUrwxVa7FAh0wR8Y+IC+ylpaW7UOUSmEoFwpDnRp
         mUIPTNfNV2OgOyFsnUXHEqzaVuFjbpLp15E8s5CiKH7+678c4UogUN9695tN2kVWyi2H
         KmainU/A+SgDRAh9gOomX91iiTW5HbbqQa0+TaC4vnqJmyfWEG4MGg/iSe4F3pX2nSEW
         G6PRYMyV98NDPf5tNMKPRdRihOhi8oIUMlWi9MtaJOR6iJtfjBVQ5UU1Emq7gQ5UbuuO
         7P2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693106458; x=1693711258;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6FEyWeqX8Is1IEk36VE0KtAj4uBLFs02fZuBwFGkFHk=;
        b=O2BYFxnKNtapbACbx6hxKg0q7aURF7C3DzCNwMqTguM8nRcf6ZFPotfzK+dv9eH6R6
         zZhpeptxwxlKuhDcyjy9P8nr1QDYnnSbJUSOQesaGcFzlym4nqx0DbVFa8+XTtOl0Bcz
         sm6dXQYqimWaF+iNvltNhFwlo01HKaYb/2HY+gmOBSalT++OLfKKLC2hSWYRe889/qTJ
         BUD5CdqXkB05ruAGmAZ0NETPJBQ+IZGRyL0ikte1wO/hoK+OQapDTQR2Ww7JGOI1p949
         ii2123wuBFLng+cgb0HcM4c96BA4CVClsD3Vb/uP5Rb2yPG1ayDdArF+vuv4NH/UsaE/
         uxig==
X-Gm-Message-State: AOJu0YxYUze0QweVtSsmlYTEm8skRiMnXampRUpCFjOauGOzHhQkIq1T
        mk1KK1q5JUWimu9+FoV8CPBMx0SpjA0=
X-Google-Smtp-Source: AGHT+IGZeMydH0CnYFnaoeGYczx3IPWLSTIX41Sx09NBOxgh2z+QEwkfMrNJzkgYUUYmbxhQ9Apw1g==
X-Received: by 2002:aca:1719:0:b0:3a4:4b42:612b with SMTP id j25-20020aca1719000000b003a44b42612bmr7178019oii.42.1693106458533;
        Sat, 26 Aug 2023 20:20:58 -0700 (PDT)
Received: from [192.168.0.105] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id y17-20020aa78051000000b0064d74808738sm3986307pfm.214.2023.08.26.20.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 20:20:58 -0700 (PDT)
Message-ID: <f847bc14-8f53-0547-9082-bb3d1df9ae96@gmail.com>
Date:   Sun, 27 Aug 2023 10:20:51 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        dianlujitao@gmail.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux btrfs <linux-btrfs@vger.kernel.org>,
        Linux Filesystem Development <linux-fsdevel@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: kernel bug when performing heavy IO operations
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I notice a bug report on Bugzilla [1]. Quoting from it:

> When the IO load is heavy (compiling AOSP in my case), there's a chance to crash the kernel, the only way to recover is to perform a hard reset. Logs look like follows:
> 
> 8月 25 13:52:23 arch-pc kernel: BUG: Bad page map in process tmux: client  pte:8000000462500025 pmd:b99c98067
> 8月 25 13:52:23 arch-pc kernel: page:00000000460fa108 refcount:4 mapcount:-256 mapping:00000000612a1864 index:0x16 pfn:0x462500
> 8月 25 13:52:23 arch-pc kernel: memcg:ffff8a1056ed0000
> 8月 25 13:52:23 arch-pc kernel: aops:btrfs_aops [btrfs] ino:9c4635 dentry name:"locale-archive"
> 8月 25 13:52:23 arch-pc kernel: flags: 0x2ffff5800002056(referenced|uptodate|lru|workingset|private|node=0|zone=2|lastcpupid=0xffff)
> 8月 25 13:52:23 arch-pc kernel: page_type: 0xfffffeff(offline)
> 8月 25 13:52:23 arch-pc kernel: raw: 02ffff5800002056 ffffe6e210c05248 ffffe6e20e714dc8 ffff8a10472a8c70
> 8月 25 13:52:23 arch-pc kernel: raw: 0000000000000016 0000000000000001 00000003fffffeff ffff8a1056ed0000
> 8月 25 13:52:23 arch-pc kernel: page dumped because: bad pte
> 8月 25 13:52:23 arch-pc kernel: addr:00007f5fc9816000 vm_flags:08000071 anon_vma:0000000000000000 mapping:ffff8a10472a8c70 index:16
> 8月 25 13:52:23 arch-pc kernel: file:locale-archive fault:filemap_fault mmap:btrfs_file_mmap [btrfs] read_folio:btrfs_read_folio [btrfs]
> 8月 25 13:52:23 arch-pc kernel: CPU: 40 PID: 2033787 Comm: tmux: client Tainted: G           OE      6.4.11-zen2-1-zen #1 a571467d6effd6120b1e64d2f88f90c58106da17
> 8月 25 13:52:23 arch-pc kernel: Hardware name: JGINYUE X99-8D3/2.5G Server/X99-8D3/2.5G Server, BIOS 5.11 06/30/2022
> 8月 25 13:52:23 arch-pc kernel: Call Trace:
> 8月 25 13:52:23 arch-pc kernel:  <TASK>
> 8月 25 13:52:23 arch-pc kernel:  dump_stack_lvl+0x47/0x60
> 8月 25 13:52:23 arch-pc kernel:  print_bad_pte+0x194/0x250
> 8月 25 13:52:23 arch-pc kernel:  ? page_remove_rmap+0x8d/0x260
> 8月 25 13:52:23 arch-pc kernel:  unmap_page_range+0xbb1/0x20f0
> 8月 25 13:52:23 arch-pc kernel:  unmap_vmas+0x142/0x220
> 8月 25 13:52:23 arch-pc kernel:  exit_mmap+0xe4/0x350
> 8月 25 13:52:23 arch-pc kernel:  mmput+0x5f/0x140
> 8月 25 13:52:23 arch-pc kernel:  do_exit+0x31f/0xbc0
> 8月 25 13:52:23 arch-pc kernel:  do_group_exit+0x31/0x80
> 8月 25 13:52:23 arch-pc kernel:  __x64_sys_exit_group+0x18/0x20
> 8月 25 13:52:23 arch-pc kernel:  do_syscall_64+0x60/0x90
> 8月 25 13:52:23 arch-pc kernel:  entry_SYSCALL_64_after_hwframe+0x77/0xe1
> 8月 25 13:52:23 arch-pc kernel: RIP: 0033:0x7f5fca0da14d
> 8月 25 13:52:23 arch-pc kernel: Code: Unable to access opcode bytes at 0x7f5fca0da123.
> 8月 25 13:52:23 arch-pc kernel: RSP: 002b:00007fff54a44358 EFLAGS: 00000206 ORIG_RAX: 00000000000000e7
> 8月 25 13:52:23 arch-pc kernel: RAX: ffffffffffffffda RBX: 00007f5fca23ffa8 RCX: 00007f5fca0da14d
> 8月 25 13:52:23 arch-pc kernel: RDX: 00000000000000e7 RSI: fffffffffffffeb8 RDI: 0000000000000000
> 8月 25 13:52:23 arch-pc kernel: RBP: 0000000000000002 R08: 00007fff54a442f8 R09: 00007fff54a4421f
> 8月 25 13:52:23 arch-pc kernel: R10: 00007fff54a44130 R11: 0000000000000206 R12: 0000000000000000
> 8月 25 13:52:23 arch-pc kernel: R13: 0000000000000000 R14: 00007f5fca23e680 R15: 00007f5fca23ffc0
> 8月 25 13:52:23 arch-pc kernel:  </TASK>
> 8月 25 13:52:23 arch-pc kernel: Disabling lock debugging due to kernel taint
> 
> Full log is available at https://fars.ee/HJw3
> Notice that the issue is introduced by linux kernel released in recent months.

See Bugzilla for the full thread.

IMO, this looks like it is introduced by page cache (folio) feature.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217823

-- 
An old man doll... just what I always wanted! - Clara
