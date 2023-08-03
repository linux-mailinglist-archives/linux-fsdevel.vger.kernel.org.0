Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F94076E747
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 13:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbjHCLrn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 07:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbjHCLrm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:47:42 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAEAE53;
        Thu,  3 Aug 2023 04:47:41 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9923833737eso121973566b.3;
        Thu, 03 Aug 2023 04:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691063259; x=1691668059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uCIhJJ2hQzGyb6KTmj3+r2054kWgm3yg50ej7a2QDQc=;
        b=csXKjk2uhcfAg18dyTPk/RSzhNTWvubZIkepX1Mj3atVktKxOrnvv2YG36KoACoDNC
         cny9ht4allynSHcLQQ6ciTN8i8LPccQRSd11vfi8IHmkUB6to8/GFYqbVUp4B8Ak6kk6
         twCtl4BfxAgLsPpRxML7vLOq0u7wGQzuMesOoc7Kx+VlkPtdnNMdWEewM9LKFaejDUVB
         4qZbE64kk18Jcyh8H5Knp5wcFoOR8GkbVyVk2qu3wHkCP+ZE3A+CjAlP6einWWRpoDF+
         k86qVzOyoRWv48h49pVjr+5EKlk4xNSxVuEAaYeNtq2jaV70WfIi8IZn2tQ9qZJH+M+H
         cQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691063259; x=1691668059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uCIhJJ2hQzGyb6KTmj3+r2054kWgm3yg50ej7a2QDQc=;
        b=Sd4Dx+TeTG4/BmrWHjkCLk7FlsDUWcD5Y2suFzXQRnkLPEstp0TW7c6PTNOEmMqWIM
         4VHMbjXsLclDy9ZIeocDL5PpcQIrNKq/YZ9ooBpUKqzGaij4pLibYKSBDrs2NAbGlEBj
         +Gv53Pm46w1i3w6ZX6mnz9pyVt/Gog+4MUkBLRzUG0UlEWaif2TMnEYoOU3z2u3W2PRh
         smyrt56OB6eSgBvsTvKPURAfeOX5q8zyHKMgmOEeCYPnua0JCMsC7SOScBQcHsqYlvT1
         UZ9bGaiNBfOvaWTWDvgatllVc5CB2TxEyowGY9cIzIhY8Mpk0ohVBbsLKvxmSrMnoF3P
         b5Sg==
X-Gm-Message-State: ABy/qLZMtC/RyulAl0OtPWr4helf1d6cANlQIUeEYMrOIPvm81AAbkMa
        PgoPblcy+LUIWBKMwvp1Ph1K6FS5G/Y=
X-Google-Smtp-Source: APBJJlEuLtlzLF7ZRSWqZTPsnYH5PMw8werL0IhJsaRD6sunTyQymk/YX8Sx+fiBHSP3tF/19IR7Yw==
X-Received: by 2002:a17:906:8a58:b0:991:d5ad:f1b1 with SMTP id gx24-20020a1709068a5800b00991d5adf1b1mr7306166ejc.47.1691063259192;
        Thu, 03 Aug 2023 04:47:39 -0700 (PDT)
Received: from [192.168.0.103] ([77.126.7.132])
        by smtp.gmail.com with ESMTPSA id sb9-20020a170906edc900b00992ae4cf3c1sm10325742ejb.186.2023.08.03.04.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 04:47:38 -0700 (PDT)
Message-ID: <852cef0c-2c1a-fdcd-4ee9-4a0bca3f54c5@gmail.com>
Date:   Thu, 3 Aug 2023 14:47:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v10 08/16] tls: Inline do_tcp_sendpages()
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Gal Pressman <gal@nvidia.com>, ranro@nvidia.com,
        samiram@nvidia.com, drort@nvidia.com,
        Tariq Toukan <tariqt@nvidia.com>
References: <ecbb5d7e-7238-28e2-1a17-686325e2bb50@gmail.com>
 <4c49176f-147a-4283-f1b1-32aac7b4b996@gmail.com>
 <20230522121125.2595254-1-dhowells@redhat.com>
 <20230522121125.2595254-9-dhowells@redhat.com>
 <2267272.1686150217@warthog.procyon.org.uk>
 <5a9d4ffb-a569-3f60-6ac8-070ab5e5f5ad@gmail.com>
 <776549.1687167344@warthog.procyon.org.uk>
 <7337a904-231d-201d-397a-7bbe7cae929f@gmail.com>
 <20230630102143.7deffc30@kernel.org>
 <f0538006-6641-eaf6-b7b5-b3ef57afc652@gmail.com>
 <20230705091914.5bee12f8@kernel.org>
 <bbdce803-0f23-7d3f-f75a-2bc3cfb794af@gmail.com>
 <20230725173036.442ba8ba@kernel.org>
Content-Language: en-US
From:   Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20230725173036.442ba8ba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,WEIRD_PORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 26/07/2023 3:30, Jakub Kicinski wrote:
> On Sun, 23 Jul 2023 09:35:56 +0300 Tariq Toukan wrote:
>> Hi Jakub, David,
>>
>> We repro the issue on the server side using this client command:
>> $ wrk -b2.2.2.2 -t4 -c1000 -d5 --timeout 5s
>> https://2.2.2.3:20443/256000b.img
>>
>> Port 20443 is configured with:
>>       ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256;
>>       sendfile    off;
>>
>>
>> Important:
>> 1. Couldn't repro with files smaller than 40KB.
>> 2. Couldn't repro with "sendfile    on;"
>>
>> In addition, we collected the vmcore (forced by panic_on_warn), it can
>> be downloaded from here:
>> https://drive.google.com/file/d/1Fi2dzgq6k2hb2L_kwyntRjfLF6_RmbxB/view?usp=sharing
> 
> This has no symbols :(
> 
> There is a small bug in this commit, we should always set SPLICE.
> But I don't see how that'd cause the warning you're seeing.
> Does your build have CONFIG_DEBUG_VM enabled?
> 
> -->8-------------------------
> 
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Tue, 25 Jul 2023 17:03:25 -0700
> Subject: net: tls: set MSG_SPLICE_PAGES consistently
> 
> We used to change the flags for the last segment, because
> non-last segments had the MSG_SENDPAGE_NOTLAST flag set.
> That flag is no longer a thing so remove the setting.
> 
> Since flags most likely don't have MSG_SPLICE_PAGES set
> this avoids passing parts of the sg as splice and parts
> as non-splice.
> 
> ... tags ...
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   net/tls/tls_main.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index b6896126bb92..4a8ee2f6badb 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -139,9 +139,6 @@ int tls_push_sg(struct sock *sk,
>   
>   	ctx->splicing_pages = true;
>   	while (1) {
> -		if (sg_is_last(sg))
> -			msg.msg_flags = flags;
> -
>   		/* is sending application-limited? */
>   		tcp_rate_check_app_limited(sk);
>   		p = sg_page(sg);

Hi Jakub,

When applying this patch, repro disappears! :)
Apparently it is related to the warning.
Please go on and submit it.

Tested-by: Tariq Toukan <tariqt@nvidia.com>

We are going to run more comprehensive tests, I'll let you know if we 
find anything unusual.

Regards,
Tariq
