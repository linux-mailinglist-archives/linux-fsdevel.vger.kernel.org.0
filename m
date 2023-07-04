Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2260F7478E3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 22:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjGDUGK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 16:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjGDUGJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 16:06:09 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2AD10D9;
        Tue,  4 Jul 2023 13:06:08 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so724287266b.2;
        Tue, 04 Jul 2023 13:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688501167; x=1691093167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OKWAUZq2LMZPHtm5CDvILwRT0rAIVFmH6pWCRnU0qnw=;
        b=SkdJTcPyWaVeyIUbTXl7qT9rX83oc+1C51++R1LIl6+mVF3I8f2eBDl8DwBP+uuLHv
         s8iaivafWsuHhcZKtMPF0vUSwNPutoX6aBvxujJOkk5p8B6cQ9QgCWf61uz5vKSyEVCh
         ns13e3tPSTzRbFat37pHToKkuzVfJMH9tS/Ce0qmWbSwPXibgBt/bhZlVeyiOtQlhm2G
         vIqFv3BZcJBt8K6Vl6qh1JMUUNJ9rz3YUzH1u/A0zbDmMukdX+0Z33clbZz0Q0j7nHQ+
         jgttUQCmx1W+ppdjJ+mbBQnGb6bSYuMe4n1ZZkVpl+pNCvUQoupmAe/w+cdveI3DMy3X
         hxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688501167; x=1691093167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OKWAUZq2LMZPHtm5CDvILwRT0rAIVFmH6pWCRnU0qnw=;
        b=Fa8E13KaLBUnSQl+mvXXD60WRh7XNzkLkBY27ZKQ2aw+PZlA/BOM8Nfl6nndP6+716
         ADpQ3ATUn/DhthatgeyP/jwbsAMu3Uf/zI0xjP6DjuBggLCHLMfnmHqHy75f2Y9VEPoR
         Qws6mxI3oG7mIwJuYohHuR4OVTSfDfaWsnzOoLwdUipqf03SvsrmixIYWaPno141Cc6a
         dRKGMrhyE0Zlap9Cc1Q5ZPKldfKlxj0HKjNJdOUTi2fmA1fhPhX3e5lzW3/p/1F97xjp
         QER46Vi5GuLD01jQN+IPOmFC3TMlUwuTz+JaMjE+5Bk06504SowCfR8LO6Ig7Ob2EFVv
         Uqqg==
X-Gm-Message-State: ABy/qLZJSJsK7JBnW0w7x16t3RXy0JsSCfUMuD59/RUZ7DeSf3SGk1th
        HOp76ZJTsXx3i5kdAhZC8Gw=
X-Google-Smtp-Source: APBJJlGWBEpjs9whdpAfmUG1S8ouqxb57kqZzCyNHPuNr8kM2V4BRS8J4IN48uFsTBxbx/EbQsE+/w==
X-Received: by 2002:a17:907:76e7:b0:97b:956f:e6b5 with SMTP id kg7-20020a17090776e700b0097b956fe6b5mr10673097ejc.23.1688501166855;
        Tue, 04 Jul 2023 13:06:06 -0700 (PDT)
Received: from [192.168.0.107] ([77.126.161.239])
        by smtp.gmail.com with ESMTPSA id gw26-20020a170906f15a00b009929d998abcsm8022416ejb.209.2023.07.04.13.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 13:06:06 -0700 (PDT)
Message-ID: <f0538006-6641-eaf6-b7b5-b3ef57afc652@gmail.com>
Date:   Tue, 4 Jul 2023 23:06:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v10 08/16] tls: Inline do_tcp_sendpages()
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
Content-Language: en-US
From:   Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20230630102143.7deffc30@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 30/06/2023 20:21, Jakub Kicinski wrote:
> On Tue, 27 Jun 2023 19:49:22 +0300 Tariq Toukan wrote:
>> Unfortunately, it still happens:
>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 2 PID: 93427 at net/core/skbuff.c:7013
> 
> I can't repro it on net-next with basic TLS 1.2 sendmsg/stream
> test + device offload, let us know if you still see it.

Hi,

Unfortunately, it still repros for us.

We are collecting more info on how the repro is affected by the 
different parameters.

Regards,
Tariq
