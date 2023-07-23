Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35E375E01B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jul 2023 08:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjGWGgE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Jul 2023 02:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGWGgD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Jul 2023 02:36:03 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3591BC7;
        Sat, 22 Jul 2023 23:36:02 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3172144c084so2835685f8f.1;
        Sat, 22 Jul 2023 23:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690094161; x=1690698961;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fWULp1Z09v1+2fHlAakWzwZrv/VdXoRTMrsIIP2c9oM=;
        b=GTulg8USXbVDXXRM6ly4eKBRjjUBfUEIVWlNI8PKgXWaF81SmwvQ3xUOMUPN79twjE
         PyhA+aDv6joI6cbOn3fpU5e60He7zvn/DPAXkjxUF04dckmsJbWn/msqwJi9mEhDdmdi
         +OyHavZLtbf9/EGalrXeGtkQOBBjudFBaU2KOcDHEEoF8rNsRCx07bv1+5H6/xcf3A8Q
         SRopIWfL22SC3foYcxFeeEuh9sqaD6tVDxE6UMZkfKXeIO1by5ejKRmV7kwtWWCztSFk
         4gKny5d0AOLGZoCU9YGlBhOjujE/MExGCudC0mh4ldTuBVUxyD9zy8h7gxMtKGAt+rvP
         Oc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690094161; x=1690698961;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWULp1Z09v1+2fHlAakWzwZrv/VdXoRTMrsIIP2c9oM=;
        b=QMsZYtpwwYamxTLJVdZezes5IPc5SfNoQ84smJjKnh8WDpyXa5V5kr+gmnIkXKwECG
         npYpvb7gevWrlu6XzJa56dIs3TbwtWVqzHzXe4aWghkJpBAcFGboo2X1HBvSrnzdMrMF
         0/bLmwpwM3GuTRL9C3q5FxrbRw+Zj1Weq+6SRbppAXydbAV8qTgmqnpYx1Spdn/SQxTj
         gbsQb9pGCwY2/m7KjSB6UbfKnJavG089ho1VQQtVSi1/r8eeGClW5+En8Frwod+Ke8vo
         sqGHEVhHwktxeX2tFIXobFLZpTwZskvAvJ7Iys6yi237STZQCuQvlx2kv5DdNk3OD2MV
         0MgA==
X-Gm-Message-State: ABy/qLbJd0g0aiFV8RSaEF1MUtEeetpbwZVnHlMwGqFOQU6Wo85RpjkE
        sLN0M9m71U/C/Vzyw9Ds+B8=
X-Google-Smtp-Source: APBJJlG9YNmkLBeWnc+pvI9ph5YB4yCi6YR54SPLj6YxVXPOdHaAUQOZNPWzSS10tg0VPFD/q0GcGw==
X-Received: by 2002:adf:e106:0:b0:315:8a80:329e with SMTP id t6-20020adfe106000000b003158a80329emr4470506wrz.40.1690094160991;
        Sat, 22 Jul 2023 23:36:00 -0700 (PDT)
Received: from [192.168.0.110] ([77.126.88.184])
        by smtp.gmail.com with ESMTPSA id l8-20020a7bc448000000b003fb40ec9475sm6963768wmi.11.2023.07.22.23.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jul 2023 23:36:00 -0700 (PDT)
Message-ID: <bbdce803-0f23-7d3f-f75a-2bc3cfb794af@gmail.com>
Date:   Sun, 23 Jul 2023 09:35:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v10 08/16] tls: Inline do_tcp_sendpages()
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
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
From:   Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20230705091914.5bee12f8@kernel.org>
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



On 05/07/2023 19:19, Jakub Kicinski wrote:
> On Tue, 4 Jul 2023 23:06:02 +0300 Tariq Toukan wrote:
>> Unfortunately, it still repros for us.
>>
>> We are collecting more info on how the repro is affected by the
>> different parameters.
> 
> Consider configuring kdump for your test env. Debugging is super easy
> if one has the vmcore available.

Hi Jakub, David,

We repro the issue on the server side using this client command:
$ wrk -b2.2.2.2 -t4 -c1000 -d5 --timeout 5s 
https://2.2.2.3:20443/256000b.img

Port 20443 is configured with:
     ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256;
     sendfile    off;


Important:
1. Couldn't repro with files smaller than 40KB.
2. Couldn't repro with "sendfile    on;"

In addition, we collected the vmcore (forced by panic_on_warn), it can 
be downloaded from here:
https://drive.google.com/file/d/1Fi2dzgq6k2hb2L_kwyntRjfLF6_RmbxB/view?usp=sharing

Regards,
Tariq
