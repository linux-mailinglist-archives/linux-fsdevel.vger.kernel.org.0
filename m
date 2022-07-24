Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A06257F4BA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Jul 2022 13:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiGXKwb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Jul 2022 06:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGXKwa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Jul 2022 06:52:30 -0400
X-Greylist: delayed 239 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 24 Jul 2022 03:52:25 PDT
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F771277B;
        Sun, 24 Jul 2022 03:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jRTxHY+3oumoRJBcTtxrjwhVP8T6AjbX7SwAwTUS/fA=; b=RAeVT921F6Z7MgUnX8ri9bFlen
        nKKKEw+ELvqJNehseL1TPLtgYGnmhsUW9hiOs13UShey1bh4j+OpCBN4aWUn0GjIpwdDyw99DMOaI
        gft7KaCHxIVs1jCLIhGyt4e7yOR2IGukayenZ2tYatJc2OrbeZwih32dchcw5uKTmr0PaNxQgzPBM
        gYAMsFrz6PGR2Swhxdf9Y6YpBnVKfKitH8w+RW/xszLjlNf0ddPbozWqS0JkvukyGIMrzIATf6Xgc
        N3WEguyl/dkv0rVAt5CjRZI6QdS2RKP1kWFN+vmmjlhAqkLJ8pSn8+w3XKXjct4m1JeFAd7GcbuYT
        jCdYrnGQ==;
Received: from 236.51-175-223.customer.lyse.net ([51.175.223.236]:60626 helo=[192.168.1.162])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <harald@skogtun.org>)
        id 1oFZ9r-0001wF-Jr; Sun, 24 Jul 2022 12:48:23 +0200
Message-ID: <e24fa505-3472-61c2-68ff-c728c5f10717@skogtun.org>
Date:   Sun, 24 Jul 2022 12:48:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] hfsplus: Fix code typo
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>, Xin Gao <gaoxin@cdjrlc.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220722195133.18730-1-gaoxin@cdjrlc.com>
 <YtsXiPPmQ5cqVsqp@casper.infradead.org>
From:   Harald Arnesen <harald@skogtun.org>
In-Reply-To: <YtsXiPPmQ5cqVsqp@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Matthew Wilcox [22/07/2022 23.32]:

> On Sat, Jul 23, 2022 at 03:51:33AM +0800, Xin Gao wrote:
>> The double `free' is duplicated in line 498, remove one.
> 
> This is wrong.  The intended meaning here is "trying to free bnode
> which is already free".  Please don't send patches for code you don't
> understand.

Perhaps inserting an "a" in the message would make it clearer?
(pr_crit("trying to free a free bnode ")
-- 
Hilsen Harald
