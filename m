Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70056773C81
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 18:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjHHQH3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 12:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHHQFp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:05:45 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E62F6E87;
        Tue,  8 Aug 2023 08:45:35 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe2d152f62so9638809e87.0;
        Tue, 08 Aug 2023 08:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691509531; x=1692114331;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lysJhQXGNtEOWv4JXhBTYoi8wPVsm0uOHEDBLobVbIk=;
        b=BTgknCEOkEUWhy9xrbPwhLfXtcYjKD1rKmvV9dElplPIUsfr9AqpX3izcbboYJvEN2
         WC9qD6JdzdpVZarhA8oLL6L8zuQzHW2hLKznovGxiq4eqHFYQ73omzOd6yBwzilmOcZi
         VhxM4mJ11WxWJIlwc9VmJju2OEZp9Vj/Tr7eGdQJguk4aUmxCjngeSGWr99GSCa1t4qf
         9fQCWxCgjT74nujNOCrxZl2fIHRj4e+lcVV5fHBLRR+YbeP5DKjxJYvIRWMR+4ZqyJP8
         CnrWfZEzXiIOXpZ3ogO6ePf2xdVe4dH2Y6Dy1gc8YzL0477Xwia6LwMrsp2g0olk4CU7
         DFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509531; x=1692114331;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lysJhQXGNtEOWv4JXhBTYoi8wPVsm0uOHEDBLobVbIk=;
        b=J7taj72zFgwlUTNeSm0YcM4UsZ4v+/L/kBg+4p59tOG/aZjBOzOIg4zOUm8rGG2wWS
         OE7k+GWu15OKXqtuym3ejsbHBGXFgAT1aoZA6eAMs+PmonOc6eK1cW+FQj9LYc6vptKy
         ViJVBlThx2sMPOn7BjRJTCtf0OFcwRVdOPy/RiB1Ajn5JpV/0006t2zbASJQ57VyHINH
         uKU6vHUY/P9Ze6PZtYXXJHikmfOh8srhrZIeZDPDvOVq+Jd/dXi53rubpuNyorsJJQjE
         KRDRL+6BeDmUQ82NxaeUPiSxt7Y0VpRD8VK/G6jvRIYYNC3P8js4+4J/6vNFbhZXY3Et
         1Uhg==
X-Gm-Message-State: AOJu0YwiK0GXSTlw8Ibms282UxhPTwZHrJfH6/9ODhlMQ3M7mV+a1uOj
        lunzhuXyaEE3psVzDAiafvIMCbLQeUg=
X-Google-Smtp-Source: AGHT+IGsZin9+ncr2tFP2CG1ZCm/ak0OCQEihvB824ZGDcsTUJ620RJHEcI93aBiUVg2hMFSPiUe0w==
X-Received: by 2002:a5d:6344:0:b0:317:3b13:94c3 with SMTP id b4-20020a5d6344000000b003173b1394c3mr8509188wrw.41.1691479761813;
        Tue, 08 Aug 2023 00:29:21 -0700 (PDT)
Received: from [192.168.0.103] ([77.126.7.132])
        by smtp.gmail.com with ESMTPSA id a2-20020a5d4d42000000b00317ca89f6c5sm12640688wru.107.2023.08.08.00.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 00:29:21 -0700 (PDT)
Message-ID: <ca5ac2f8-d3b1-0d07-d361-6ce1d4f12392@gmail.com>
Date:   Tue, 8 Aug 2023 10:29:18 +0300
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
 <852cef0c-2c1a-fdcd-4ee9-4a0bca3f54c5@gmail.com>
 <20230803201212.1d5dd0f9@kernel.org>
From:   Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20230803201212.1d5dd0f9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 04/08/2023 6:12, Jakub Kicinski wrote:
> On Thu, 3 Aug 2023 14:47:35 +0300 Tariq Toukan wrote:
>> When applying this patch, repro disappears! :)
>> Apparently it is related to the warning.
>> Please go on and submit it.
> 
> I have no idea how. I found a different bug, staring at this code
> for another hour. But I still don't get how we can avoid UaF on
> a page by having the TCP take a ref on it rather than copy it.
> 
> If anything we should have 2 refs on any page in the sg, one because
> it's on the sg, and another held by the re-tx handling.
> 
> So I'm afraid we're papering over something here :( We need to keep
> digging.

Hi Jakub,
I'm glad to see that you already nailed the other bug and merged the fix.

I can update that we ran comprehensive TLS testing on a branch that 
contains your proposed fix (net: tls: set MSG_SPLICE_PAGES 
consistently), and doesn't contain the other fix (net: tls: avoid 
discarding data on record close).

Except for one "known" issue (we'll discuss it in a second), the runs 
look clean.
No more traces or encrypt/decrypt error counters. Your proposed fix 
seems to work and causes no degradation.
How do you suggest proceeding here?

One mysterious remaining issue, which I already reported some time ago 
but couldn't effectively debug due to other TLS bugs, is the increase of 
TlsDecryptError / TlsEncryptError counters when running kTLS offloaded 
traffic during bond creation on some other interface.
Weird...

We should start giving it the needed attention now that the other issues 
seem to be resolved.

Regards,
Tariq
