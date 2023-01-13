Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197C066987A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 14:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241015AbjAMN16 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 08:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241441AbjAMN1W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:27:22 -0500
X-Greylist: delayed 612 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 Jan 2023 05:19:07 PST
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D91F0D
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 05:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
        ; s=ds202212; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5KsLnX8REZqJ06dCgBsMbb70EKP4NApu5OUKtsyxy/0=; b=JFd+FBnIimkD4WNXJyH6GBDyZk
        C6f8K6MtRPaOtaYGH94LwJXnxsi5bW/TTCCfQeqfAo1zbO5tt71N9YpQJ/QBbL5lLGgzKatQ5uiBx
        AidCFzg0Q4C742ceXv7GQbXA2LjOpRX68RcVJcXJwY42+F/sUDi/FrbBatUzJBZvOkO7F3jIMaOrh
        lkHhfYuw/+JUPzqnwI3Q7eGsQWB8KyirMwlXGlgKgvbQPhk4YA9JoyUoi1r07dBfpYHPFNOXWCIRQ
        UnLncpVQxgKGGxQ9J1/ObZfzMtYafKZ5xkcUu1MGsP7xrCZA96T3j/R/m+qH003ZPSGUl8fHWl1b6
        7t8P3EKA==;
Received: from 236.51-175-223.customer.lyse.net ([51.175.223.236]:54530 helo=[192.168.1.161])
        by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <harald@skogtun.org>)
        id 1pGJnd-00E1rG-Bc;
        Fri, 13 Jan 2023 14:08:49 +0100
Message-ID: <0661e73f-9420-9a0a-ef46-15b54a3b5357@skogtun.org>
Date:   Fri, 13 Jan 2023 14:08:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Should we orphan JFS?
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>
Cc:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Y8DvK281ii6yPRcW@infradead.org>
From:   Harald Arnesen <harald@skogtun.org>
In-Reply-To: <Y8DvK281ii6yPRcW@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig [13/01/2023 06.42]:

> Hi all,
> 
> A while ago we've deprecated reiserfs and scheduled it for removal.
> Looking into the hairy metapage code in JFS I wonder if we should do
> the same.  While JFS isn't anywhere as complicated as reiserfs, it's
> also way less used and never made it to be the default file system
> in any major distribution.  It's also looking pretty horrible in
> xfstests, and with all the ongoing folio work and hopeful eventual
> phaseout of buffer head based I/O path it's going to be a bit of a drag.
> (Which also can be said for many other file system, most of them being
> a bit simpler, though).

The Norwegian ISP/TV provider used to have IPTV-boxes which had JFS on 
the hard disk that was used to record TV programmes.

However, I don't think these boxes are used anymore.
-- 
Hilsen Harald
