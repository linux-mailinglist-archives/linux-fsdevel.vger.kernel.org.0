Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A7F5634FD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 16:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiGAOTL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 10:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiGAOTK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:19:10 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BA830F41
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 07:19:09 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id l6so2493180plg.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Jul 2022 07:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rzOZ/i9oSJaRcIRoI1iWhltC/vefgetj7tSZBTo878o=;
        b=5HQrr8bsUEE61UmPmshuXLouerN7bDpQGL6uPBj0Z6oD+Z+BzfeXdXxfm+HPdIICP6
         /xCJl1spZE4rJ97OF6puWsMJeHT9fvWxiRJbInko4k9KIJa9H4KxjwB5wo6cnUvHyRFj
         3sa5jGx+4i/PgAp+XuwaejZ9X4yU18bWxPPbSJ0UKI9Z/6uHpbhVEcuSij4DdWW05JlZ
         rCM4EpDrWg0Cx81bPnObzhqxBdnMW586nX+S86OWrQyBaK4GXuBJJfPgVpsJaUqMJBNT
         j26E0dFwkFVt/aYyW3ZaB1RbYsySGLK4uO5JiaNKqgQcAS22gmYw9jOHmKP7CkOyB0aw
         FYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rzOZ/i9oSJaRcIRoI1iWhltC/vefgetj7tSZBTo878o=;
        b=AQBKRdOlRjInQhiEXUJOvwfdMFDTd7QSF4wTAHpYaGDcz5afByh58JXbM5FkG1Kdws
         IhlgruiYy1wR1fLE0CbwkYH3b25kL/Oqqe9FIhgJiYlN6ctkVO8o1DA3X2EmKdwMtW+K
         4Bsy7KuJj0jnzFbWPGcOo/aoWABf+NmdY9AT9/daaEuW75Dx1uljdZ92mfiBG173R6ig
         Ri0xRyO1x4X+lILFdAeC4anG6a3KnLPBUrIdPjOGOQvd0/ACGBlipS3GCAoRSjjXFlLp
         dGBHtqvvGfiquKFMm68eOeNRKI6JOcvEfIaKftG2YKFfHGCtYgCsWWSlPa3M/GthqgnJ
         jvRA==
X-Gm-Message-State: AJIora8iBMKgSFs8KHwymCORgRPapxKIBRQvjNtvoBpebh7517tw2gUe
        XBpGstjyzzH7PivmqMi7j0IbNQ==
X-Google-Smtp-Source: AGRyM1v0RzZrxH3XgsAPTjbzNfvNy9O3MwTKLMrckgh2iet5mvp0kq7mJYZDwHlDICGwRoI1VcItsw==
X-Received: by 2002:a17:90b:17c3:b0:1ed:157:b9f1 with SMTP id me3-20020a17090b17c300b001ed0157b9f1mr17066106pjb.205.1656685148583;
        Fri, 01 Jul 2022 07:19:08 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g8-20020a62e308000000b005251ff30dccsm15615879pfh.160.2022.07.01.07.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 07:19:07 -0700 (PDT)
Message-ID: <0a75a0c4-e2e5-b403-27bc-e43872fecdc1@kernel.dk>
Date:   Fri, 1 Jul 2022 08:19:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 15/15] xfs: Add async buffered write support
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>, Stefan Roesch <shr@fb.com>
Cc:     io-uring@vger.kernel.org, kernel-team@fb.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, jack@suse.cz, hch@infradead.org,
        Christoph Hellwig <hch@lst.de>
References: <20220601210141.3773402-1-shr@fb.com>
 <20220601210141.3773402-16-shr@fb.com> <Yr56ci/IZmN0S9J6@ZenIV>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yr56ci/IZmN0S9J6@ZenIV>
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

On 6/30/22 10:39 PM, Al Viro wrote:
> On Wed, Jun 01, 2022 at 02:01:41PM -0700, Stefan Roesch wrote:
>> This adds the async buffered write support to XFS. For async buffered
>> write requests, the request will return -EAGAIN if the ilock cannot be
>> obtained immediately.
> 
> breaks generic/471...

That test case is odd, because it makes some weird assumptions about
what RWF_NOWAIT means. Most notably that it makes it mean if we should
instantiate blocks or not. Where did those assumed semantics come from?
On the read side, we have clearly documented that it should "not wait
for data which is not immediately available".

Now it is possible that we're returning a spurious -EAGAIN here when we
should not be. And that would be a bug imho. I'll dig in and see what's
going on.

-- 
Jens Axboe

