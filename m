Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D06530529
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 20:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238791AbiEVS3V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 14:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiEVS3T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 14:29:19 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C103E2B19F
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 11:29:18 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id v11so11860342pff.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 11:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7ySKjn29iAOCRph0da3VPaMJx7axnY+y7puUCDnhmjA=;
        b=zT+qs3dMPSkFMMagPj1p86bXA+vQv1J1D1kcKrXryVlQPs3w2BE4L6hfiY1IPPcT9U
         W3m0Cae1RgIj75WGgAurr4t05dmCn+lSnYShz8EX5K50S8mcfZV+Ma5FP5EwsBMsGW1d
         G2GWXtW5D3rO/JNIyoROdjMya/EO5sNn91ufv7GOoULzddcFFQ7PA5RpjOu/L6yiu+iq
         TCrm33MY2o4/9cqP8va3XkdB5ZSs4q2L0y+ei6USv013dBwkVs8e9l4sNF/3bx2Ps1zm
         15qK1hW3wXVAMFFuamNqSU96Y/uw4h8HfZYeLDs/RM/v6gBf4ERScpFxuNQ33goxnbXV
         Ieow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7ySKjn29iAOCRph0da3VPaMJx7axnY+y7puUCDnhmjA=;
        b=rlRxPfPWHW2oMIR5cw8cRnN9tRvwAQYhLsfyLjdZmv8CVAylXEKZE60jT8ZO+IgGnS
         YbSf3g8NHO2H6eDfgKZLdUhbSbnxOZOZzEo8DasKIKAvVGbZokXzyCNvdoonrvQXVTj/
         SKOnNZ/4wyzPoMSweOpqwV8mZiY5zxgXOM/uobPgvx0Kox5PZbswW91vxgoun0WCtjdp
         kUyf6WiVBj6BBGFgll981AyZPj3XUAS6I1ZB/pW4x72F+Eed49py/2lxEAhbkhQqSLvV
         Zt6Ei8Vv6HUizSNhUW2ZUcYod+iT2V025V9zhS/kFH2lJUVh7Bb4uXZJXD49JLwSfKcd
         S7gQ==
X-Gm-Message-State: AOAM532CsW9ZYavjMhyo0nUi2ecpdU0POyFT3ImtoAzx70Jd+AQb1q3e
        OR7qMX4kYWohuerj3xXxYObJi4oCe4m/7A==
X-Google-Smtp-Source: ABdhPJxwzC6eDaHBxUC5WJnIyIs4HBSayHmqUpLmJ2HpBjkkxhi//MGarQDFuTUseXRXNoyIzBgf/g==
X-Received: by 2002:a63:43c2:0:b0:3c1:829a:5602 with SMTP id q185-20020a6343c2000000b003c1829a5602mr17617454pga.252.1653244158198;
        Sun, 22 May 2022 11:29:18 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s32-20020a056a0017a000b0050dc762814asm5649569pfg.36.2022.05.22.11.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 11:29:17 -0700 (PDT)
Message-ID: <41f4fba6-3ab2-32a6-28d9-8c3313e92fa5@kernel.dk>
Date:   Sun, 22 May 2022 12:29:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <YooPLyv578I029ij@casper.infradead.org>
 <YooSEKClbDemxZVy@zeniv-ca.linux.org.uk>
 <Yoobb6GZPbNe7s0/@casper.infradead.org> <20220522114540.GA20469@lst.de>
 <e563d92f-7236-fbde-14ee-1010740a0983@kernel.dk>
 <YooxLS8Lrt6ErwIM@zeniv-ca.linux.org.uk>
 <96aa35fc-3ff7-a3a1-05b5-9fae5c9c1067@kernel.dk>
 <Yoo1q1+ZRrjBP2y3@zeniv-ca.linux.org.uk>
 <e2bb980b-42e8-27dc-cb6b-51dfb90d7e0a@kernel.dk>
 <7abc2e36-f2f3-e89c-f549-9edd6633b4a1@kernel.dk>
 <YoqAM1RnN/er6GDP@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YoqAM1RnN/er6GDP@zeniv-ca.linux.org.uk>
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

It was sent out as a discussion point, it's not a submission and it's by
no means complete (as mentioned!). If you're working on this, I'd be
happy to drop it, it's not like I really enjoy the iov_iter code... And
it sounds like you are?

-- 
Jens Axboe

