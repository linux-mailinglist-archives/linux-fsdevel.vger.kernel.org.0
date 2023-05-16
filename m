Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4DC70438B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 04:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjEPCpG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 22:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjEPCpE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 22:45:04 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7DE35BD;
        Mon, 15 May 2023 19:45:02 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1aaf70676b6so97115955ad.3;
        Mon, 15 May 2023 19:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684205102; x=1686797102;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNrwrxEXioPVU1CHB+NMHjC+VIIUqcxI7JMhaUrSWzw=;
        b=dJ4Hmy3CaKT4Ee1HiDj2nV6ZHGbgYqFpv1QMLVSDrBv9JqTkLbQz53HqcyS+5uUPeH
         V9WN9IhbsnBidl+LVUjFgIqmrNiXQY1iaY4erbQh+4eYQ6IPKBEd9aC7L0B73fUDaQns
         9T9LR9fkb2XR5U0H7lGo+8nAPBCwPBJrOClmJHCXA8ZF0af9Ow4Ty7Rd3D2T0DohIuk3
         uLQdexWGJond3609bpwpYbm7PBpjFZ+vmuGyLb9TyJm/1XNqiO6Dpbf4UQIoU322U6vU
         0WLZymNq0eGGZCMHyxYJsqazgZ8cZzKpLA1Fguh9H/lRO+gvA54Geq2jgcgzE3SjJWJL
         Qgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684205102; x=1686797102;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GNrwrxEXioPVU1CHB+NMHjC+VIIUqcxI7JMhaUrSWzw=;
        b=HbZ7sMqSLZtuK+8OGRYa9GAHpomZFgaYFVdo7AUiN4dNmuuF2uDKGs0yxt+ZvrUjZu
         fRaOCd68c8AsiIk2sgZlVzzPaWGlnW58MOh6iXMdlq2k59ohqcvygFNJe6x2U4H5o2Ry
         ioZiGALUBC4AksfhPRSRvJbYeuSGjbbwGylpeYiPmSqE3CXTdqVV56v6nDA+SFs9PJgs
         9VQTxlkBvgc0il7MpzXFIaua3zjUlzbr4lMQdadgJPagSzTwUV+Czfl4rnjRI1pLZPGg
         rlr0Jg4kKNnSZKe95AZ2Gp3JOEqnM4UB+fyEYx8g/aq7MgiFL4DjY8wjYLj7NCCKhi9I
         g2aA==
X-Gm-Message-State: AC+VfDwX62XyBtA8eGUSJmtBpH7j8FNCbBs9UeV2+dfYTUOw/vTb+E1Y
        zdcOxFFpZVm7suMUCEZMiUO16SBRvg8=
X-Google-Smtp-Source: ACHHUZ4aAjo16mYYVJw56/Ey7MpV0voqIMFvFyHGqu/Q9QHjMqsHSp1BSS1zWi4rVF3Rn9w3xV3BVA==
X-Received: by 2002:a17:903:234f:b0:1ae:bf5:7b5 with SMTP id c15-20020a170903234f00b001ae0bf507b5mr8733272plh.34.1684205101918;
        Mon, 15 May 2023 19:45:01 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-4.three.co.id. [116.206.28.4])
        by smtp.gmail.com with ESMTPSA id j10-20020a170902690a00b001ac7c6fd12asm14168055plk.104.2023.05.15.19.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 19:45:01 -0700 (PDT)
Message-ID: <24fb92c2-27e1-e98b-c163-74b530d613fa@gmail.com>
Date:   Tue, 16 May 2023 09:44:52 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Linux Memory Management List <linux-mm@kvack.org>,
        Linux Filesystems <linux-fsdevel@vger.kernel.org>,
        Linux x86 <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Cc:     Vladimir Lomov <lomov.vl@bkoty.ru>,
        Matthew Wilcox <willy@infradead.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: _filemap_get_folio and NULL pointer dereference
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I notice a regression report on bugzilla [1]. Quoting from it:

> Hello.
> 
> (I apologize if I chose the wrong "Product" and "Component".)
> 
> On two of my systems, I see strange "bug" when running 6+ kernels (below is a recent one):
> 
> ```
> May 14 14:48:07 smoon7.bkoty.ru kernel: RIP: 0010:__filemap_get_folio+0xbf/0x6a0
> May 14 14:48:07 smoon7.bkoty.ru kernel: Code: ef e8 c5 60 c3 00 48 89 c7 48 3d 02 04 00 00 74 e4 48 3d 06 04 00 00 74 dc 48 85 c0 0f 84 6a 04 00 00 a8 01 0f 85 6c 04 00 00 <8b> 40 34 85 c0 74 c4 8d 50 01 4c 8d 47 34 f0 0f b1 57 34 75 ee 48
> May 14 14:48:07 smoon7.bkoty.ru kernel: RSP: 0000:ffffa7800b1dfbf8 EFLAGS: 00010246
> May 14 14:48:07 smoon7.bkoty.ru kernel: RAX: 0000000000000002 RBX: 0000000000000000 RCX: 0000000000000004
> May 14 14:48:07 smoon7.bkoty.ru kernel: RDX: ffffa7800b1dfc50 RSI: ffff9a2413646910 RDI: 0000000000000002
> May 14 14:48:07 smoon7.bkoty.ru kernel: RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 00007f862b600000
> May 14 14:48:07 smoon7.bkoty.ru kernel: R10: 00007f8659246f48 R11: ffff9a21c1494a0c R12: 000000000002dc46
> May 14 14:48:07 smoon7.bkoty.ru kernel: R13: ffffa7800b1dfc50 R14: ffff9a21e2cb82b0 R15: 00007f8659246f48
> May 14 14:48:07 smoon7.bkoty.ru kernel: FS:  00007f87fcff96c0(0000) GS:ffff9a295e280000(0000) knlGS:0000000000000000
> May 14 14:48:07 smoon7.bkoty.ru kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> May 14 14:48:07 smoon7.bkoty.ru kernel: CR2: 0000000000000036 CR3: 0000000105b2c003 CR4: 00000000003706e0
> May 14 14:48:07 smoon7.bkoty.ru kernel: Call Trace:
> May 14 14:48:07 smoon7.bkoty.ru kernel:  <TASK>
> May 14 14:48:07 smoon7.bkoty.ru kernel:  ? psi_group_change+0x274/0x430
> May 14 14:48:07 smoon7.bkoty.ru kernel:  filemap_fault+0x6f/0xfd0
> May 14 14:48:07 smoon7.bkoty.ru kernel:  ? filemap_map_pages+0x15f/0x640
> May 14 14:48:07 smoon7.bkoty.ru kernel:  __do_fault+0x30/0x130
> May 14 14:48:07 smoon7.bkoty.ru kernel:  do_fault+0x1d7/0x400
> May 14 14:48:07 smoon7.bkoty.ru kernel:  handle_mm_fault+0xb48/0x1450
> May 14 14:48:07 smoon7.bkoty.ru kernel:  do_user_addr_fault+0x1c7/0x740
> May 14 14:48:07 smoon7.bkoty.ru kernel:  exc_page_fault+0x7c/0x180
> May 14 14:48:07 smoon7.bkoty.ru kernel:  asm_exc_page_fault+0x26/0x30
> May 14 14:48:07 smoon7.bkoty.ru kernel: RIP: 0033:0x7f881a56cb0d
> May 14 14:48:07 smoon7.bkoty.ru kernel: Code: 00 00 00 00 00 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 48 89 f8 48 83 fa 20 72 23 <c5> fe 6f 06 48 83 fa 40 0f 87 a5 00 00 00 c5 fe 6f 4c 16 e0 c5 fe
> May 14 14:48:07 smoon7.bkoty.ru kernel: RSP: 002b:00007f87fcff72c8 EFLAGS: 00010202
> May 14 14:48:07 smoon7.bkoty.ru kernel: RAX: 00007f87dc02a700 RBX: 00007f87fcff8308 RCX: 00007f87fcff7500
> May 14 14:48:07 smoon7.bkoty.ru kernel: RDX: 0000000000004000 RSI: 00007f8659246f48 RDI: 00007f87dc02a700
> May 14 14:48:07 smoon7.bkoty.ru kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> May 14 14:48:07 smoon7.bkoty.ru kernel: R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000000
> May 14 14:48:07 smoon7.bkoty.ru kernel: R13: 00007f87dc001370 R14: 0000000000000009 R15: 00005645d0719a70
> May 14 14:48:07 smoon7.bkoty.ru kernel:  </TASK>
> ```
> 
> I've seen these errors since the very first kernel of the 6 series, while I see no problem with 5.15 on the same hardware.
> 
> These two systems have the same CPU (Intel(R) Core(TM) i5-10500 CPU @ 3.10GHz) but slightly different motherboards, same amount of memory (same  manufacturer, I tested it when plugged in).
> 
> The hosts in question don't show this "bug" immediately, but after some time while having "heavy" disk load (torrents). The "bug" shows up whether I use `mitigations=off` or not (at first I thought the "bug" might be related to `mitigations=off`, but I got the above output when I removed that setting from the kernel command line).
> 
> What puzzles me is that I don't see these errors on the other hosts (but they don't have "heavy" disk loads), they work just fine. On the other hand, they have different CPUs (not i5-10500). Sometimes (less often than this error) I saw the following in the kernel log (dmesg):
> 
> ```
> May 14 08:09:09 smoon7.bkoty.ru kernel: mce: [Hardware Error]: Machine check events logged
> May 14 08:09:09 smoon7.bkoty.ru kernel: mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 0: 9000004000010005
> May 14 08:09:09 smoon7.bkoty.ru kernel: mce: [Hardware Error]: TSC 95596a63008b
> May 14 08:09:09 smoon7.bkoty.ru kernel: mce: [Hardware Error]: PROCESSOR 0:a0653 TIME 1684022949 SOCKET 0 APIC 0 microcode f6
> May 14 08:11:39 smoon7.bkoty.ru kernel: mce: [Hardware Error]: Machine check events logged
> May 14 08:11:39 smoon7.bkoty.ru kernel: mce: [Hardware Error]: CPU 5: Machine Check: 0 Bank 0: 9000004000010005
> May 14 08:11:39 smoon7.bkoty.ru kernel: mce: [Hardware Error]: TSC 95c56b82abf0
> May 14 08:11:39 smoon7.bkoty.ru kernel: mce: [Hardware Error]: PROCESSOR 0:a0653 TIME 1684023099 SOCKET 0 APIC a microcode f6
> ```
> 
> So now I'm thinking of buying a new CPU (same socket) and see if I will see the same error.

For the full thread, see bugzilla.

FYI, filemap_get_folio() is introduced in 3f0c6a07fee6a1 ("mm/filemap:
Add filemap_get_folio").

Anyway, I'm adding this to regzbot:

#regzbot introduced: v5.15..v6.0 https://bugzilla.kernel.org/show_bug.cgi?id=217441
#regzbot title: NULL pointer dereference on filemap_get_folio() on Intel Core i5-10500

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217441

-- 
An old man doll... just what I always wanted! - Clara
