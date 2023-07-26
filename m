Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F23D763F6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 21:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjGZTUx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 15:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjGZTUv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:20:51 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2292737;
        Wed, 26 Jul 2023 12:20:48 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbea147034so1016195e9.0;
        Wed, 26 Jul 2023 12:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690399247; x=1691004047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SU5w/Qd+Q2s6pTNTUx/bglHlSYRuAA+mciT7JmjRh4Q=;
        b=eoqi2tQD/6t5XYrmp8b4wsx9lND/kXSpo3WDzgeBYvmGmX8P0Qbv9v7pDii13+pyfd
         ER0K4tqBLphE04ZvAen5YdS1W0X1OBqgYPjwYZNF9l4seZ+oVg3f3Wvoofn7LEg6K6En
         /CdCtVnq50U+RI2LK6KD1tvDN5gfFJCL9qy+DBqSF9Ug8+PG0K0ekDURaqkHa3eAJoSq
         aSFL4/zvZxnGjG0iXbDYoPJ8Pw2hA+1skJ+X+eOS0HgX5l6DwLaWRT8BDboDgh/LOhh3
         ufkWtTbCRp5fKH7T3EtwgN0c9JqUb+re9tVFoOESHeVAXxYlwkIGDrBn9wel/6xHfbOt
         AU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690399247; x=1691004047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SU5w/Qd+Q2s6pTNTUx/bglHlSYRuAA+mciT7JmjRh4Q=;
        b=lUDnI30A7RAjmZXqicWXD9S4xbjUW4zJyvhCxx1Q7BVd7z8roCepoxMPpHlAm4ztLc
         fPG9a4PCOjOy8W80rU0tSFIrdC0aL3n3bNWMlcffo43DetrnNcGTU4Mx9nTIAcW2Ckgz
         ISulF1H51WxM0fb0h5KSG3zVW9/N0mJRbz6j+T0JAj9ukMwx16HB3NtiOV2rkQDAijW+
         ZhibVgrjlXAlhYlTxhH+V173dqW+QQk0f1ceEWZcPdTLeLEBm2D2MZKeotmwIwMXYdIl
         Aivcve23R5MIPaA8I7+zWcrlUh6sV+ttxLcw5wuShFWC33lVee23q5tmaoXI8KNo3O9M
         225g==
X-Gm-Message-State: ABy/qLZtBzZhTDa0a2VMfnGXgzdrlFaQOFy6+4Q5DRbn9p3E5XjzACNc
        4g8wvDZ206AT0tvcmOKxi8w=
X-Google-Smtp-Source: APBJJlHBRtroaMd2u/pxowsVAjxlt8UGtzJgYXLG5mldxeUG4NiXgFfvruege631QAMLsz2xk70BvA==
X-Received: by 2002:a05:600c:2181:b0:3fa:98c3:7dbd with SMTP id e1-20020a05600c218100b003fa98c37dbdmr10406wme.41.1690399246785;
        Wed, 26 Jul 2023 12:20:46 -0700 (PDT)
Received: from [192.168.0.103] ([77.126.7.132])
        by smtp.gmail.com with ESMTPSA id c22-20020a7bc856000000b003fbd0c50ba2sm2782413wml.32.2023.07.26.12.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 12:20:46 -0700 (PDT)
Message-ID: <e9c41176-829a-af5a-65d2-78a2f414cd04@gmail.com>
Date:   Wed, 26 Jul 2023 22:20:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v10 08/16] tls: Inline do_tcp_sendpages()
Content-Language: en-US
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
From:   Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20230725173036.442ba8ba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,WEIRD_PORT autolearn=ham
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

Uh.. :/
I'll try to fix this and re-generate.

> There is a small bug in this commit, we should always set SPLICE.
> But I don't see how that'd cause the warning you're seeing.
> Does your build have CONFIG_DEBUG_VM enabled?

No.

# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set

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

I'll test this anyway tomorrow and update.

Regards,
Tariq
