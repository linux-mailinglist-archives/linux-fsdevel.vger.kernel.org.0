Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3FF7A74AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 09:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbjITHrD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 03:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjITHqd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:46:33 -0400
Received: from icp-osb-irony-out5.external.iinet.net.au (icp-osb-irony-out5.external.iinet.net.au [203.59.1.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C72DCE4;
        Wed, 20 Sep 2023 00:45:52 -0700 (PDT)
X-SMTP-MATCH: 1
IronPort-Data: A9a23:azQpg6xIW9ObnWEOXuN6t+cnxyrEfRIJ4+MujC+fZmUNrF6WrkU3e
 hirod39jgY+HhL3funC5f239Uo2Dfalz9J9ShxunZ1UZyoigdLfAtiEJVvHMSqXL8nSJGpq9
 Mx2huPodajYdVeC4E/3WlTdhSMkj/rQF+CkULes1h1ZHmeIdg9w0XqPpMZk2uaEsfDhayuRt
 NX7pdHoOVPN81aY5UpNtspvADs21BjDkGtwUm4WPJinj3eH/5UhN6/zEInqR5fOrii4KcbhL
 wrL5OnREmrxo0x3Uov9+lrxWhVirrX6ZWBihlIKAPL62kAqSiEais4G2PQghUh/u2WkkdZ62
 tp3kZ2TcVYlA4/nwvkmakwNe81+FfUuFL7vEiHu64rKkR2AKz22mcAG4EMeYN1epKAtWz8Ir
 6RIQNwORknra+aez6i2RfRqick5IdPDI44Epndt0XfSCvNgSI2rr6DiuY4BjWlh2JgTdRrYT
 9AHVTd9NhXdWkFwNBRNMKM9w8KamVCqJlW0r3rQ/8Lb+VP70w111KnFMdzbYNWGSMxZ2EGCq
 Qru+2X/HwFfN9GFzzeB2myji/WJni7hXo8WUrqi+ZZChFyV23xWBgYaWEW2pdGnhUOkHdFSM
 UoZ/mwpt6da3EiqSMTtGhSiq36soBERQZxTHvc85QXLzbDbiy6FAXIaRzpNc/QitckrVXkk0
 UKPk9r1BDtp9rqPRhq18K+VojyzPwAaKGYDYWkPSg5t3jX4iNxjy0yKFIw9VfTt3pvpAT7xh
 TuNqW43mt3/kPI26klyxnif6xrEm3QDZlddCtn/No590j5EWQ==
IronPort-HdrOrdr: A9a23:8cNknKgC5uWXPwRJcEjE0pucnXBQXmsji2hC6mlwRA09TyX4ra
 6TdZEguCMc5wxxZJhNo7C90dC7MBThHPxOkOss1MaZLWrbUQKTRekIh+eM/9SHIVybygc379
 YET0ERMqyJMXFKyez/pCG+G9Mx2tmcmZrY+dv2/jNGSUVHbL5t6gFhBm+gYzJLbTgDKZ0lFI
 eNouprzgDQAkj/t/7LYEXtidKz3uHjpdbvfBoPBxss7Q+TgHey7qLmH3Gjr2kjegIKyaon+W
 jBmQn++qjmqeiyzlvV3XLS6ZM+oqqa9vJzQMSQjsAULz/ojBqkIJ55U7nHpzwtpvqzgWxa7e
 Xxnw==
X-Talos-CUID: =?us-ascii?q?9a23=3AuWQeS2pTeuaoxyCd2FPf7pvmUfB1X3Pbx2XfGWu?=
 =?us-ascii?q?5Kl44RIC3YgWNw5oxxg=3D=3D?=
X-Talos-MUID: 9a23:z4HOwgWseijTGJ7q/CXyuDxwbsZ12viRBgNXqaQF5Oy2KgUlbg==
X-IronPort-AV: E=Sophos;i="6.02,161,1688400000"; 
   d="scan'208";a="491969605"
Received: from 58-6-226-208.tpgi.com.au (HELO [192.168.0.22]) ([58.6.226.208])
  by icp-osb-irony-out5.iinet.net.au with ESMTP; 20 Sep 2023 15:45:47 +0800
Message-ID: <5add8ae8-d746-b254-7559-b96aa72d3523@westnet.com.au>
Date:   Wed, 20 Sep 2023 17:45:47 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 09/17] m68k: Implement xor_unlock_is_negative_byte
Content-Language: en-US
From:   Greg Ungerer <gregungerer@westnet.com.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, torvalds@linux-foundation.org,
        Nicholas Piggin <npiggin@gmail.com>
References: <20230915183707.2707298-1-willy@infradead.org>
 <20230915183707.2707298-10-willy@infradead.org>
 <6e409d5f-a419-07b7-c82c-4e80fe19c6ba@westnet.com.au>
 <ZQW849TfSCK6u2f8@casper.infradead.org>
 <cb763591-a697-ab74-171e-fcd7f4e70137@westnet.com.au>
In-Reply-To: <cb763591-a697-ab74-171e-fcd7f4e70137@westnet.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 19/9/23 00:37, Greg Ungerer wrote:
> On 17/9/23 00:34, Matthew Wilcox wrote:
>> On Sat, Sep 16, 2023 at 11:11:32PM +1000, Greg Ungerer wrote:
>>> On 16/9/23 04:36, Matthew Wilcox (Oracle) wrote:
>>>> Using EOR to clear the guaranteed-to-be-set lock bit will test the
>>>> negative flag just like the x86 implementation.  This should be
>>>> more efficient than the generic implementation in filemap.c.  It
>>>> would be better if m68k had __GCC_ASM_FLAG_OUTPUTS__.
>>>>
>>>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>>> ---
>>>>    arch/m68k/include/asm/bitops.h | 14 ++++++++++++++
>>>>    1 file changed, 14 insertions(+)
>>>>
>>>> diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
>>>> index e984af71df6b..909ebe7cab5d 100644
>>>> --- a/arch/m68k/include/asm/bitops.h
>>>> +++ b/arch/m68k/include/asm/bitops.h
>>>> @@ -319,6 +319,20 @@ arch___test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
>>>>        return test_and_change_bit(nr, addr);
>>>>    }
>>>> +static inline bool xor_unlock_is_negative_byte(unsigned long mask,
>>>> +        volatile unsigned long *p)
>>>> +{
>>>> +    char result;
>>>> +    char *cp = (char *)p + 3;    /* m68k is big-endian */
>>>> +
>>>> +    __asm__ __volatile__ ("eor.b %1, %2; smi %0"
>>>
>>> The ColdFire members of the 68k family do not support byte size eor:
>>>
>>>    CC      mm/filemap.o
>>> {standard input}: Assembler messages:
>>> {standard input}:824: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `eor.b #1,3(%a0)' ignored
>>
>> Well, that sucks.  What do you suggest for Coldfire?
> 
> I am not seeing an easy way to not fall back to something like the MIPS
> implementation for ColdFire. Could obviously assemblerize this to do better
> than gcc, but if it has to be atomic I think we are stuck with the irq locking.
> 
> static inline bool cf_xor_is_negative_byte(unsigned long mask,
>                  volatile unsigned long *addr)
> {
>          unsigned long flags;
>          unsigned long data;
> 
>          local_irq_save(flags)
>          data = *addr;
>          *addr = data ^ mask;
>          local_irq_restore(flags);
> 
>          return (data & BIT(7)) != 0;
> }

The problem with this C implementation is that need to use loal_irq_save()
which results in some ugly header dependencies trying top include irqflags.h.

This version at least compiles and run, though we can probably do better still.


diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
index e984af71df6b..99392c26e784 100644
--- a/arch/m68k/include/asm/bitops.h
+++ b/arch/m68k/include/asm/bitops.h
@@ -319,6 +319,48 @@ arch___test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
         return test_and_change_bit(nr, addr);
  }
  
+static inline bool cf_xor_unlock_is_negative_byte(unsigned long mask,
+               volatile unsigned long *addr)
+{
+       unsigned long data;
+
+        asm volatile (
+               "move.w %%sr,%%d1       \n\t"
+               "move.w %%d1,%%d0       \n\t"
+               "ori.l  #0x0700,%%d0    \n\t"
+               "move.w %%d0,%%sr       \n\t"
+
+               "move.l %2@,%0          \n\t"
+               "eor.l  %1,%0           \n\t"
+               "move.l %0,%2@          \n\t"
+
+               "movew  %%d1,%%sr       \n"
+               : "=d" (data)
+               : "di" (mask), "a" (addr)
+               : "cc", "%d0", "%d1", "memory");
+
+       return (data & BIT(7)) != 0;
+}
+
+static inline bool m68k_xor_unlock_is_negative_byte(unsigned long mask,
+               volatile unsigned long *p)
+{
+       char result;
+       char *cp = (char *)p + 3;       /* m68k is big-endian */
+
+       __asm__ __volatile__ ("eor.b %1, %2; smi %0"
+               : "=d" (result)
+               : "di" (mask), "o" (*cp)
+               : "memory");
+       return result;
+}
+
+#if defined(CONFIG_COLDFIRE)
+#define xor_unlock_is_negative_byte(mask, p) cf_xor_unlock_is_negative_byte(mask, p)
+#else
+#define xor_unlock_is_negative_byte(mask, p) m68k_xor_unlock_is_negative_byte(mask, p)
+#endif
+
  /*
   *     The true 68020 and more advanced processors support the "bfffo"
   *     instruction for finding bits. ColdFire and simple 68000 parts


Regards
Greg
