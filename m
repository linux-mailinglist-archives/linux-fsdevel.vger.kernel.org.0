Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE15A53033A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 15:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345222AbiEVNJL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 09:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiEVNJK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 09:09:10 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8612C39834
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 06:09:09 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id i24so11476230pfa.7
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 06:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5todWIDwFAE/RBjozBs7syGQn5b8/9ou4A/9hDcuY1s=;
        b=T5wpsC4ly8lWZBi3ZnKk7COV3bieo1LvEei5m5i3oDiqyOs3qIkZ0CY1Veas3S0/pG
         ThlD3u9hxf2djkQaL4hYLiVTjRSZmpp/NfGIFKubT9P3rpDyMkeUlbc0TfhlotwIizUR
         fMzStHLAS1foZmBOMcOZ7VrfGIRe0I+bxxu6Dk+BCrRWPNulxvOcKbitBHztJA5u4I7T
         hKhKY5p2hIPwPTkENrsYTyCJ9amttBGfIuryDFgVA548lAKzLbC3nAwmZFH67SM1uA0x
         Vdk2cQQD2ZHx/5efQgdMXhLcM6KX/CzX/ea3zUyvxDXzfo2ttUJLGseHx8e8flycgFEm
         nPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5todWIDwFAE/RBjozBs7syGQn5b8/9ou4A/9hDcuY1s=;
        b=sxiS7EPLdPeIsYXjP3leSBFCsCayLFjXvMJ0Bopqo3qSHkLrfH8SByBjllHh6U5MCk
         w+XOqbXa5EtmF8hHo+0YQ1Ii/8z/dloWAxYU5a2dSXVZec+1KAt8KJ+ux/WqAU5Hmj2e
         69s2kp5uRHGwMi+1uxCeEKGA52EuilUUXTXOB9Bs6K+Uc3X/0uKr4a94zSxOFsovsf31
         DbCHVCq4LEhBye5DIaJJcihXXdPFzEvy7fRqUq6CWIQuBC0SWOd3/PYkW70iNjnYwpX2
         yB7n8wNCdrCmbRodfHUPRXLb6DTLlLRFgfX3dMuHQVXIVbcefmiNTt2uM8Qnsvc+c4XD
         Ad8g==
X-Gm-Message-State: AOAM533eMAQHnmq0kDW3rk/2yDO73TPniGicIhfK6TujsGk4WNfY/5hp
        plndCT1MIjxYqcmpE57Qa26qWQ==
X-Google-Smtp-Source: ABdhPJzgWu/OKiGHnTHyI9001yiwj2TobopyO/gGxitkW+Aw+ahuhyf5U6VcP09jI344q82RhbgcQA==
X-Received: by 2002:a05:6a00:15c5:b0:518:98a7:dc0e with SMTP id o5-20020a056a0015c500b0051898a7dc0emr2169128pfu.30.1653224948860;
        Sun, 22 May 2022 06:09:08 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id mr3-20020a17090b238300b001d97fc5a544sm5235923pjb.2.2022.05.22.06.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 06:09:08 -0700 (PDT)
Message-ID: <e2bb980b-42e8-27dc-cb6b-51dfb90d7e0a@kernel.dk>
Date:   Sun, 22 May 2022 07:09:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <70b5e4a8-1daa-dc75-af58-9d82a732a6be@kernel.dk>
 <f2547f65-1a37-793d-07ba-f54d018e16d4@kernel.dk>
 <20220522074508.GB15562@lst.de> <YooPLyv578I029ij@casper.infradead.org>
 <YooSEKClbDemxZVy@zeniv-ca.linux.org.uk>
 <Yoobb6GZPbNe7s0/@casper.infradead.org> <20220522114540.GA20469@lst.de>
 <e563d92f-7236-fbde-14ee-1010740a0983@kernel.dk>
 <YooxLS8Lrt6ErwIM@zeniv-ca.linux.org.uk>
 <96aa35fc-3ff7-a3a1-05b5-9fae5c9c1067@kernel.dk>
 <Yoo1q1+ZRrjBP2y3@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yoo1q1+ZRrjBP2y3@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/22/22 7:07 AM, Al Viro wrote:
> On Sun, May 22, 2022 at 07:02:01AM -0600, Jens Axboe wrote:
>> +static void iter_uaddr_advance(struct iov_iter *i, size_t size)
>> +{
>> +}
> 
> How could that possibly work?  At the very least you want to do
> what xarray does - you *must* decrement ->count and shift ->iov_offset.
> Matter of fact, I'd simply go with a bit of reorder and had it go
> for if (iter_is_uaddr(i) || iter_is_xarray(i)) in there...

It's just a stub, you said you'd want to do it, so I just dropped what I
had in the email. As I said, it's not even compiled yet, let alone
complete or tested.

-- 
Jens Axboe

