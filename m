Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0018856266E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 01:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiF3XHX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 19:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiF3XHV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 19:07:21 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B95E58FF2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 16:07:19 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d17so781635pfq.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 16:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IzpHwFgvoVMHsmNDV3HQvMQ7xQrAh7FjeXWydwsIu7E=;
        b=jmjNcTL3G7zifdsOnW6lZRRYwOpziyO7wOpP6s6zHb7o2Q7wJOEbDJn7tROJmgP0l9
         KWp+ZMGhBXHsfNResw8WiOb7dr67d47pYTFtcf2Y+WZGIsYY9FV31tmZHWMnRgkc8G5z
         5buaV8JYTt9IhdMtpCxYTisaOxZEr1nRJB6PIvhJ8suVsAuoBN3zDhBKateK2zNs4Jua
         8/5/2OAa1pcsoZQ9ZBwQmx+rSA/6q3DnHC18SIBhVL2Trl27wPqAlGNO/FA157lSgxOY
         0snAw2XqcTCQiOTCPhgUTw1d6XWMe3Mfi9sXIBKz9PPY4zbEu15V7aI2eWqIlfL+76Ip
         ho/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IzpHwFgvoVMHsmNDV3HQvMQ7xQrAh7FjeXWydwsIu7E=;
        b=pyzldRTE4BdwrC9kzR0I5wLn2xw7gaagw4w9YM98kkA7yLfFHrRFYbs33VL2Aqx4mC
         1GLcGzZiqCdQHqh/tAtUvfoxZUIqz8YyVpuWBj1SosvHhpSWnYPgVeXUW9qipRqAUL4j
         xBCffEvC0AHNiHT46w76EbwB1SxsJPS+pY5wUW2G9mdwSYvSPQhWro4cpuKdl9LkY0hH
         mfmPJO+p8iC6//Oqs6enAFHFjfFhLoNlqYcEkEwmxPrzSm5EQTX9TtpRoAXCgLAXZOM3
         gelY37CvSmyQ4Kw2Dxg91MLT2hPYveFseq0hVsCTZHCtbUNi3S9D8EvwY59HBsL4AM+E
         5zhA==
X-Gm-Message-State: AJIora8ZA9mPymxIKuEcBED3iaUVE/OnWLMM8W2vl4h+lCUJ4+DaXTxo
        y0UffBRiWgDCt81bskvpXUB4Uw==
X-Google-Smtp-Source: AGRyM1sRf/TyO65O4RWwmFVPttFV3KeOdpL9UHdP+5g07KKtSEnouWeX1dC42+6Hx2+k3wUjHGLPFg==
X-Received: by 2002:a63:4654:0:b0:405:e571:90b with SMTP id v20-20020a634654000000b00405e571090bmr9538365pgk.120.1656630438896;
        Thu, 30 Jun 2022 16:07:18 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 132-20020a62198a000000b005256c9c3957sm14100638pfz.108.2022.06.30.16.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 16:07:18 -0700 (PDT)
Message-ID: <52c4db18-ef4a-9896-3dfa-9db2e0e3d07d@kernel.dk>
Date:   Thu, 30 Jun 2022 17:07:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [block.git conflicts] Re: [PATCH 37/44] block: convert to
 advancing variants of iov_iter_get_pages{,_alloc}()
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>,
        Keith Busch <kbusch@kernel.org>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
 <20220622041552.737754-37-viro@zeniv.linux.org.uk> <Yr4fj0uGfjX5ZvDI@ZenIV>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yr4fj0uGfjX5ZvDI@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/30/22 4:11 PM, Al Viro wrote:
> On Wed, Jun 22, 2022 at 05:15:45AM +0100, Al Viro wrote:
>> ... doing revert if we end up not using some pages
>>
>> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> ... and the first half of that thing conflicts with "block: relax direct
> io memory alignment" in -next...
> 
> Joy.  It's not hard to redo on top of the commit in there; the
> question is, how to deal with conflicts?
> 
> I can do a backmerge, provided that there's a sane tag or branch to
> backmerge from.  Another fun (if trivial) issue in the same series
> is around "iov: introduce iov_iter_aligned" (two commits prior).
> 
> Jens, Keith, do you have any suggestions?  AFAICS, variants include
> 	* tag or branch covering b1a000d3b8ec582da64bb644be633e5a0beffcbf
> (I'd rather not grab the entire for-5.20/block for obvious reasons)
> It sits in the beginning of for-5.20/block, so that should be fairly
> straightforward, provided that you are not going to do rebases there.
> If you are, could you put that stuff into an invariant branch, so
> I'd just pull it?
> 	* feeding the entire iov_iter pile through block.git;
> bad idea, IMO, seeing that it contains a lot of stuff far from
> anything block-related. 
> 	* doing a manual conflict resolution on top of my branch
> and pushing that out.  Would get rid of the problem from -next, but
> Linus hates that kind of stuff, AFAIK, and with good reasons.
> 
> 	I would prefer the first variant (and that's what I'm
> going to do locally for now - just
> git tag keith_stuff bf8d08532bc19a14cfb54ae61099dccadefca446
> and backmerge from it), but if you would prefer to deal with that
> differently - please tell.

I'm not going to rebase it, and I can create a tag for that commit for
you. Done, it's block-5.20-al. I did the former commit, or we can move
the tag so it includes bf8d08532bc19a14cfb54ae61099dccadefca446? That'd
be the whole series of that patchset, which is just that one extra
patch.

-- 
Jens Axboe

