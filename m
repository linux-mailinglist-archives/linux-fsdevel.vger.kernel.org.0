Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1B07B5674
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 17:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238047AbjJBPSr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 11:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbjJBPSr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:18:47 -0400
X-Greylist: delayed 363 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 Oct 2023 08:18:43 PDT
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C560E9;
        Mon,  2 Oct 2023 08:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1696259919;
        bh=5P8PgMCydyEfKGMY3Q2kV+H74KvDoo+0m+vuI47K+j8=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To;
        b=EldUxfrFUUN5VS7TBe/5U8B4O3q5F6CL6YyC5iZuqDL8V2FVGJ7z3dEQWLJzrsHkr
         YEnuKbx4MSiIxFE86181eKvRxl/eveNn1vKt8qCkLk7wP1GNaY4h3MQyhrUmtfF5n4
         mN7hesmDDduXrA1D8P6e7WOyei6CSwDhU7DZlLp0=
Received: from [IPV6:240e:430:cc3:362a:ac65:29f0:b0a3:8952] ([240e:430:cc3:362a:ac65:29f0:b0a3:8952])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id 30E80C8B; Mon, 02 Oct 2023 23:12:14 +0800
X-QQ-mid: xmsmtpt1696259534t3plu1m45
Message-ID: <tencent_BC7A3D486E923DFD8C99DFCFEA79B82A8205@qq.com>
X-QQ-XMAILINFO: OQhZ3T0tjf0ayTPDmx2MouI4u9hhZsqYnpcVlTJqmYQHeFqoHp4qY37pcf5nCC
         GdkNLrZiB+jnZUBJr/GwN5OigeRvs0MDBaEzsa05cH80xqG2PubHSqXYHjYP1Gc5mvhhvA29vgs2
         PA7Hk5gFuAJyX/yh7DuSc2xoTfw1q8dXH6DUcaUATGKNJaAzwtjjdA48z1/5tENwhg4cNnS+1SQB
         23v4XVk76H9tTKrhhAtvewq0wKno+VZf3ww1t84JjNHO93j0ZzmKTYaeeWNUtfEVsVD0KIL4YyH4
         YRMR8cyC+CjR3dneQtzv+YXdY701MnhpAMEYSREzwoUL/qgW8MGM7CpnUbOPB5wpSnsBOeQs1wwT
         VaaFDK7BhOMc+e3NB7lQmL0jR608SLKtBqZ89AuioTYYSxG5j2McmuEkC5gwFWKGrfRZnumm2wtR
         Xq2J0sR2Lly/T4X7BlzI8Jw7R6kHHLciASUEz/uI44D8mamQyBkQ53gNvksgLRpxwoIppzypeZ8s
         xFLVqqGVBKK5hmyFNVpNYKlsayyvX/KBLGOEsBpaY1eEf/KXmNJFX2UqXd5o1b8lpI3h+5y52SCD
         y1kKhHXhxpMAJsGFt9YXsxLdqCawMnDUTNdpqknjloIR/f0WcITjCCq9U4/8k7qIpsSiuwzgOUQB
         Q7AwcXiY/X1RZWo/0zIaR3KQY/7hQptp8e7SNtWxm5EpCdkvH3gtiXxS5FAg4LJnlaosdRWiZkIj
         Lb9hhqY+ok7Dm2MTW/fMBGeWCQVZT05kuCpAO17QPxMLM9Ct30T1JiD7267uASgS159hduCk7cPj
         MqIygNm3cr7raNbUEgmMlGxE8FUok2bSMudmiiGq5rlbS5kcSyPNrSR9E+V4FW/+HV+Q/N0u5UNk
         L8DUQWIkrmkeCLCEVfhMvUv3s3ZUvfXefn3D6hFs336IyhLkvSjLvVBUBMpLI3OYZPychWtmimEq
         ji1oqk9YiYdU7K08snw9WPKIfbPFseKMf8avZhg+z6SaWHEN+yztBGHShpMsRu
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-OQ-MSGID: <2537b70b-4c54-1cea-0b24-d0d7c07b5eef@foxmail.com>
Date:   Mon, 2 Oct 2023 23:12:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Wen Yang <wenyang.linux@foxmail.com>
Subject: Re: [PATCH] eventfd: move 'eventfd-count' printing out of spinlock
To:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_6E80209FC9C7F45EE61E3FB3E7952A226A07@qq.com>
 <ff95e764-9e61-4204-8024-42f15c34f084@kernel.dk>
Content-Language: en-US
In-Reply-To: <ff95e764-9e61-4204-8024-42f15c34f084@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2023/9/27 15:32, Jens Axboe wrote:
> On 9/26/23 8:05 AM,wenyang.linux@foxmail.com  wrote:
>> From: Wen Yang<wenyang.linux@foxmail.com>
>>
>> It is better to print debug messages outside of the wqh.lock
>> spinlock where possible.
> Does it really matter for fdinfo? Your commit message is a bit
> light, so I'm having to guess whether this is fixing a real issue
> for you, or if it's just a drive-by observation.
>
Thanks for your comments.
There is a business running on our machine that frequently calls 
eventfd_write().
We will resend the V2 and provide a detailed explanation.

--

Best wishes,
Wen


