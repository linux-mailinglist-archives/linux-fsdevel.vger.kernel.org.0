Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9BF7A3096
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Sep 2023 15:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238089AbjIPNPI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Sep 2023 09:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239195AbjIPNOz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Sep 2023 09:14:55 -0400
X-Greylist: delayed 184 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 16 Sep 2023 06:14:46 PDT
Received: from icp-osb-irony-out2.external.iinet.net.au (icp-osb-irony-out2.external.iinet.net.au [203.59.1.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FC6BDD;
        Sat, 16 Sep 2023 06:14:45 -0700 (PDT)
X-SMTP-MATCH: 1
IronPort-Data: A9a23:BSxs+K1vAQ0dQ7pFnvbD5cNwkn2cJEfYwER7XKvMYLTBsI5bpwWzt
 Nbn7RIyw0v2EmDwS237GIy29Xqy2ebUyshhVgBcGUhFFxpisdDCCcmSMnD+NiaTKtyrZE985
 q3yUPGZRCwPZiGa/k3F3oTJ9yEmjvnZH+SkUoYoBwgqLeNaYHZ54f5cs7Nh6mJYqYDRKx+Av
 9r0v/reNDeNs9KjGjtJg04rgEoHUMXa4Fv0jHRnDRx4lAa2e00uMX4qDfrZw00U42VjNrXSq
 +7rlNlV90uFpE11UovNfrzTKiXmSZaKVeSCoiYNAfD62nCuqwRqupvXOsbwZm9ziT/UoolT1
 elGtIW1EzY4EfXdm9wkBkww/yFWZcWq+Zf0eCnl95XNnwueNSG29p2CDmlrbctGvLwtXycUr
 axwxDMlN3hvg8q52r+0V+9ji94uNuH0MZgDvHx8izreCLAvXPgvRo2Wu4QIh21u3Zsm8fD2X
 dQVViFJVVf6OQRyFWpHOKAzjfz3iSyqG9FfgBfPzUYt2EDMzQh1wZDsNtTPc9CHTMkTmVyXz
 krC/mLkElQZOcaZxD6t7H2hnKnMkDn9VYZUE6e3ntZugVuO1ikdExEbS1a/iee2h1T4WN9FL
 UEQvC00osAa8E2tU8m4VgezoFaasRMGHdldCes37EeK0KW8yxqeHHYNSjJaQNgnstImADIty
 1mFls/oAjopt6eaIVqb7rabojK0EScQJG4GIyQDSGM4D8LL/dF20FeVFIgmSvblyMHtFjC2y
 DeP6iEj71kOsfM2O2yA1Qivq1qRSlLhFGbZOi2/srqZ0z5E
IronPort-HdrOrdr: A9a23:wC60R6Horfpb1OhrpLqE98eALOsnbusQ8zAXPiFKJyC9F/bzqy
 nAppsmPHPP+VQssRIb+OxoWpPtfZq0z/cc3WB2B9eftWLdyQiVxe9ZgLcKkweKJxHD
X-Talos-CUID: 9a23:K6nxDG+9szhpjgR9OpWVv2oWEJ0YK1/A8HzROkriOHdGEKyWcWbFrQ==
X-Talos-MUID: 9a23:JZcesAS6+AJ9wfe5RXTWmj1dL+FRoJ70EX0irMU2icSVLnN/bmI=
X-IronPort-AV: E=Sophos;i="6.02,152,1688400000"; 
   d="scan'208";a="463832633"
Received: from 58-6-226-208.tpgi.com.au (HELO [192.168.0.22]) ([58.6.226.208])
  by icp-osb-irony-out2.iinet.net.au with ESMTP; 16 Sep 2023 21:11:32 +0800
Message-ID: <6e409d5f-a419-07b7-c82c-4e80fe19c6ba@westnet.com.au>
Date:   Sat, 16 Sep 2023 23:11:32 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 09/17] m68k: Implement xor_unlock_is_negative_byte
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        torvalds@linux-foundation.org, Nicholas Piggin <npiggin@gmail.com>
References: <20230915183707.2707298-1-willy@infradead.org>
 <20230915183707.2707298-10-willy@infradead.org>
From:   Greg Ungerer <gregungerer@westnet.com.au>
In-Reply-To: <20230915183707.2707298-10-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 16/9/23 04:36, Matthew Wilcox (Oracle) wrote:
> Using EOR to clear the guaranteed-to-be-set lock bit will test the
> negative flag just like the x86 implementation.  This should be
> more efficient than the generic implementation in filemap.c.  It
> would be better if m68k had __GCC_ASM_FLAG_OUTPUTS__.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   arch/m68k/include/asm/bitops.h | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
> index e984af71df6b..909ebe7cab5d 100644
> --- a/arch/m68k/include/asm/bitops.h
> +++ b/arch/m68k/include/asm/bitops.h
> @@ -319,6 +319,20 @@ arch___test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
>   	return test_and_change_bit(nr, addr);
>   }
>   
> +static inline bool xor_unlock_is_negative_byte(unsigned long mask,
> +		volatile unsigned long *p)
> +{
> +	char result;
> +	char *cp = (char *)p + 3;	/* m68k is big-endian */
> +
> +	__asm__ __volatile__ ("eor.b %1, %2; smi %0"

The ColdFire members of the 68k family do not support byte size eor:

   CC      mm/filemap.o
{standard input}: Assembler messages:
{standard input}:824: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `eor.b #1,3(%a0)' ignored

Regards
Greg




> +		: "=d" (result)
> +		: "di" (mask), "o" (*cp)
> +		: "memory");
> +	return result;
> +}
> +#define xor_unlock_is_negative_byte xor_unlock_is_negative_byte
> +
>   /*
>    *	The true 68020 and more advanced processors support the "bfffo"
>    *	instruction for finding bits. ColdFire and simple 68000 parts
