Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2ED57A4F0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 18:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjIRQdk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 12:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjIRQdW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:33:22 -0400
Received: from icp-osb-irony-out5.external.iinet.net.au (icp-osb-irony-out5.external.iinet.net.au [203.59.1.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 783905FE1;
        Mon, 18 Sep 2023 09:19:10 -0700 (PDT)
X-SMTP-MATCH: 1
IronPort-Data: A9a23:VSxAMasW1E456BIkgqf6yRc4uOfnVEpfMUV32f8akzHdYApBsoF/q
 tZmKVkyQEty1hlBgm0KGI+zxf6LyZfVzubXKHJtqTc3CSgiRfPtXbyxNl33Mz6ZMvrNRUdm6
 9R2QtTbJajYdFeFzvuWGuan9SMUOZ2gHOKmU7aVY3ApHGeIdQ964f5ds79h6mJXqYXha++9k
 Yuai9HSPlajxwl1Pgo8g05UgEoy1BhakGpwUm0WPZinjneH/5UmJMt3yZWKEpfNatI88thW5
 gr05OrREmvxp3/BA/v5yeyjKhVirrT6ZWBigVIOM0SuqkQZ/HRqis7XOdJEAXq7hQllkPhIj
 9scnoytSz50O7z1g+c0UhVgKB1XaPguFL/veRBTsOSglhycNSKyk7M2ShtsCOX0+M4qUScQs
 6ZCdnZXNkDra+GemdpXTsFjnMksMc/kMZkSoFl/wCrFC/s6B5vERuPD+Le02R9s15kTRqiEN
 5txhTxHai/LOi9EH2guUb0hgs22vVumeCBdtwfAzUYwyy2JpOBr65DyMd7Ra/SLQ8tPl0qVr
 26A+H72ajkeNdqC2X+G/2iqi+vngyz2QsQRGae++/osh0ecrkQXCRsLRR61uvW0lEO6c8xQJ
 lZS+Sc0q6U2skuxQbHVWxy+vW7BtwQXW/JOHOAgrgKA0KzZ50CeHGdsZiJGcsIvsMMtbTgr0
 EKZ2t3uGDpjuaGUTnTb8a2bxRu0ISkaIm4ETSABRAoBpdLkpekOYgnnE4YmTuvv1IOwQ2mgh
 SySoyl4jLIWy8cWv0mmwW36b/uXjsChZmYICs//Bzv9s1oRiFKND2Bw1WXm0A==
IronPort-HdrOrdr: A9a23:0/uzuKjCrt8AqS1smUj0ClKljXBQXwV13DAbv31ZSRFFG/FwyP
 rCoB1L73XJYWgqM03I+OrwTZVoJEmskKKdjrNhdYtKNjOW8VdAU7sSk7cKrweQfREWtdQtpJ
 uICpIOe+EYVGIK//oSgzPIZ+rIouP3iJxA7N22pxsDLXAIGsVdAh9CazpzencGJjWubqBJc6
 Z0iPA33gZJBBwsH7SG760+LpL+Tunw5dnbiFM9dl0aAHXnt0LW1JfKVzyjmjsOWTJGxrkvtU
 DDjgzC/62m98q2zxfNvlWjoai/zLHapOdrNYipsIw4Oz/sggGnaMBKQLuZpg04p+mp9RIDjM
 TMiw1IBbUq11rhOkWO5Tf90Qjp1zgjr1X4z0WDvHflqcvlABonFst6g55DeBex0Tt4gDhF6t
 MR44uljesRMfqAplW42zHwbWAuqqNgmwtlrQYR50YvHrf2JoUh97D3x3klXKvoLBiKorzPL9
 MeQf00nMwmCm9yT0qp/1WHk+bcHkjbWC32AHTqTfblrwS+cUoJuHfw2vZv6EvoXahNNqV52w
 ==
X-Talos-CUID: =?us-ascii?q?9a23=3ADIVpgmrEUmiu9eRs8tg4wefmUflifCz23GrSGhK?=
 =?us-ascii?q?9GF9yS5SURWerxIoxxg=3D=3D?=
X-Talos-MUID: 9a23:UX6ocgp3iuKBxa4lo4gezzdZP55a6IGRMRkijosspfKmbCdtPijI2Q==
X-IronPort-AV: E=Sophos;i="6.02,156,1688400000"; 
   d="scan'208";a="491536289"
Received: from 58-6-226-208.tpgi.com.au (HELO [192.168.0.22]) ([58.6.226.208])
  by icp-osb-irony-out5.iinet.net.au with ESMTP; 18 Sep 2023 22:37:48 +0800
Message-ID: <cb763591-a697-ab74-171e-fcd7f4e70137@westnet.com.au>
Date:   Tue, 19 Sep 2023 00:37:47 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 09/17] m68k: Implement xor_unlock_is_negative_byte
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, torvalds@linux-foundation.org,
        Nicholas Piggin <npiggin@gmail.com>
References: <20230915183707.2707298-1-willy@infradead.org>
 <20230915183707.2707298-10-willy@infradead.org>
 <6e409d5f-a419-07b7-c82c-4e80fe19c6ba@westnet.com.au>
 <ZQW849TfSCK6u2f8@casper.infradead.org>
From:   Greg Ungerer <gregungerer@westnet.com.au>
In-Reply-To: <ZQW849TfSCK6u2f8@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 17/9/23 00:34, Matthew Wilcox wrote:
> On Sat, Sep 16, 2023 at 11:11:32PM +1000, Greg Ungerer wrote:
>> On 16/9/23 04:36, Matthew Wilcox (Oracle) wrote:
>>> Using EOR to clear the guaranteed-to-be-set lock bit will test the
>>> negative flag just like the x86 implementation.  This should be
>>> more efficient than the generic implementation in filemap.c.  It
>>> would be better if m68k had __GCC_ASM_FLAG_OUTPUTS__.
>>>
>>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>> ---
>>>    arch/m68k/include/asm/bitops.h | 14 ++++++++++++++
>>>    1 file changed, 14 insertions(+)
>>>
>>> diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
>>> index e984af71df6b..909ebe7cab5d 100644
>>> --- a/arch/m68k/include/asm/bitops.h
>>> +++ b/arch/m68k/include/asm/bitops.h
>>> @@ -319,6 +319,20 @@ arch___test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
>>>    	return test_and_change_bit(nr, addr);
>>>    }
>>> +static inline bool xor_unlock_is_negative_byte(unsigned long mask,
>>> +		volatile unsigned long *p)
>>> +{
>>> +	char result;
>>> +	char *cp = (char *)p + 3;	/* m68k is big-endian */
>>> +
>>> +	__asm__ __volatile__ ("eor.b %1, %2; smi %0"
>>
>> The ColdFire members of the 68k family do not support byte size eor:
>>
>>    CC      mm/filemap.o
>> {standard input}: Assembler messages:
>> {standard input}:824: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `eor.b #1,3(%a0)' ignored
> 
> Well, that sucks.  What do you suggest for Coldfire?

I am not seeing an easy way to not fall back to something like the MIPS
implementation for ColdFire. Could obviously assemblerize this to do better
than gcc, but if it has to be atomic I think we are stuck with the irq locking.

static inline bool cf_xor_is_negative_byte(unsigned long mask,
                 volatile unsigned long *addr)
{
         unsigned long flags;
         unsigned long data;

         local_irq_save(flags)
         data = *addr;
         *addr = data ^ mask;
         local_irq_restore(flags);

         return (data & BIT(7)) != 0;
}

Regards
Greg


> (Shame you didn't join in on the original discussion:
> https://lore.kernel.org/linux-m68k/ZLmKq2VLjYGBVhMI@casper.infradead.org/ )
