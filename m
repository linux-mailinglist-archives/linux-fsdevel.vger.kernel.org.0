Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377C16F983F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 May 2023 12:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjEGKpc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 May 2023 06:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjEGKpb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 May 2023 06:45:31 -0400
X-Greylist: delayed 2659 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 07 May 2023 03:45:29 PDT
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3006::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF93911B7B;
        Sun,  7 May 2023 03:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
        ; s=ds202212; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UuRslKEz3TrrM7BwSCTQR0LzlT9MO+Zs5diYRPGT8CE=; b=RTEmghShuuleHl42X6H6nnr+wN
        H3a0XNWYnIpQi6Ds1GQLORnAkjGvK47rt4Tc0TwgZnnIaZNdsJDRazAyRv5Ny/Hq5NfoJz0vTTxJx
        GjdoxxtEXhX+ytx1TmqOggP5kDZNWptqzZ7iylE9fplim5kqzl/cOBkwgBY2UehZEBrEHK6zOdyMt
        kDwtKck8o688mkbZJouCuKmSlL78itN/83XFsJ7PKHYxUzNQqly2rrsj7SydTqM/pqx//8XPyCydj
        qhbLa0jQxKWd3Or9gctfJTpSNvskQh5uLhaVmOEp6Ci+E6Va5xeGnO0hGc8K/9HmXTX5FJ3H3FfmM
        OTMssF2A==;
Received: from 236.51-175-223.customer.lyse.net ([51.175.223.236]:60534 helo=[192.168.1.161])
        by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <harald@skogtun.org>)
        id 1pvbCV-005Npf-QM;
        Sun, 07 May 2023 12:01:07 +0200
Message-ID: <49b64864-b47f-0da4-c9eb-5255bdd6d2a0@skogtun.org>
Date:   Sun, 7 May 2023 12:01:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [GIT PULL] Pipe FMODE_NOWAIT support
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <26aba1b5-8393-a20a-3ce9-f82425673f4d@kernel.dk>
 <CAHk-=wj=LwLDYrjHpMM+QnE2T+u4P9-UXhXGkAMXiyfGjGnNEA@mail.gmail.com>
 <6be969d0-e941-c8fa-aca7-c6c96f2c1ba2@kernel.dk>
 <CAHk-=wg=sQ6NvX5C=2xDhB45UsiGySzh0tqCuXWZ-ANOk1gRhQ@mail.gmail.com>
From:   Harald Arnesen <harald@skogtun.org>
In-Reply-To: <CAHk-=wg=sQ6NvX5C=2xDhB45UsiGySzh0tqCuXWZ-ANOk1gRhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds [07/05/2023 02.55]:

>>> Something is very rotten in the state of Denmark.
>> It's the Norwegians, always troublesome.
> Something all Nordic people can agree on. Even the Norwegians, because
> they are easily confused.

You are all just jealous of our oil and gas.

It's a result of being occupied first by the Danes from 1537 to 1814, 
then by the Swedes from 1814 to 1905. And the Finns moved through Sweden 
to Norway, where they burned down the forests in order to grow rye in 
the ashes ("svedjebruk" in the district of Finnskogen in eastern Norway).

Actually, my family on my mother's side descend from some of these 
"skogfinner" ("forest Finns" for those on the list without language 
skills), as we call them.
-- 
Hilsen Harald
