Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509026CF33C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 21:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjC2Tia (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 15:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjC2Ti3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:38:29 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80557469C
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 12:38:28 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id h187so5592715iof.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 12:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680118708;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ksf/WVwu5t8w3aL3HGe01BLwvzd3hr2Dyd9hJrZ2RGs=;
        b=uJRe9asLlyQeHYoEIjoSB2QY54uikuMfofOF2xcCE5yGuqE3qzWbvZVpv7F1UyL9bx
         WE1teKkLv+PpS0zENCKpyYkrz6NRoLOIqsAu+HHhcNvRoCgQd5yKO8mvvhr9WxC4V0ku
         Es0YrO5CrK10V6y8L+PWLaVJuTi8o8jMxdwQzrJZIF+22tqZ5Qf2C4gQCav85FN3z3JY
         G9qa7rTdJ8BH1vtYfFiHoZkUpYx9wJ0/nX5e3hryEUrKeLcWl9rH5fLkHmuaG1+2NqDS
         ieDZxK9iCoQ2sBExggM7Dz3XJo6pliB8UBCa5Lv1xvOBT7Rh1WpfQsx0iuNSaUXcrXoc
         K5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680118708;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ksf/WVwu5t8w3aL3HGe01BLwvzd3hr2Dyd9hJrZ2RGs=;
        b=58Sosrvyr6KhjIFs3I33q1gy9hAf/c9VKyxNMXgpL9az1SW7WLDhkD7x8vrAoUmE2Y
         wXMg5nLvUO7yQ7Icv69TEwvykQ5JJwcgt32QrUXFlFA9s+J3Eju+WFkxBYrLHIDOfDip
         wl3n/Kdw712fBh4WId10kdfvnDyCnlGlRq2vHo/LsqWGfAFpj//8hLyhjJ+zD5aqCN5d
         8MKfTlddcdEK6OZF7b39pS4Hj3DwzTjaR5+RisaRJc3w3WN+z0TvI3jjCx/CRMR2bv7T
         p62nHQDzdyMWI8T9LqCKJJz2PuxFVvAvTOAsoP8rJjMvqSafAp/A+iOHrA9HigyYnxmx
         pdjw==
X-Gm-Message-State: AO0yUKX0j9lWPbcbp4hz0/bDWKGS8NfgvgbHM4kk3HgtWZDt87tp3Zf2
        Ehke9JwnliWLUvKAog8hPtFdgQ==
X-Google-Smtp-Source: AK7set+YVojMljpjtYBR2iwaP4R5s0dAa9xHH6gVR5GG75HZx4w6OASTOkqwyYuER00OFXx8tJy6uw==
X-Received: by 2002:a05:6602:395:b0:758:5653:353a with SMTP id f21-20020a056602039500b007585653353amr12076151iov.0.1680118707727;
        Wed, 29 Mar 2023 12:38:27 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v13-20020a056638358d00b004050767f779sm8073307jal.164.2023.03.29.12.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 12:38:27 -0700 (PDT)
Message-ID: <554cd099-aa7f-361a-2397-515f7a9f7191@kernel.dk>
Date:   Wed, 29 Mar 2023 13:38:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 06/11] iov_iter: overlay struct iovec and ubuf/len
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
References: <20230329184055.1307648-1-axboe@kernel.dk>
 <20230329184055.1307648-7-axboe@kernel.dk>
 <CAHk-=wg2q64+WLKE+0+UNeZav=LjXJZx2gHJ5NR3_5LxvQC8Mg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wg2q64+WLKE+0+UNeZav=LjXJZx2gHJ5NR3_5LxvQC8Mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/29/23 1:30 PM, Linus Torvalds wrote:
> On Wed, Mar 29, 2023 at 11:41 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> +               struct iovec __ubuf_iovec;
> 
> I think this is the third time I say this: this should be "const struct iovec".

Doh sorry, not sure why I keep missing that... But yes, it should, I'll make
the edit and actually amend it.

> No other use is ever valid, and this cast:
> 
>> +static inline const struct iovec *iter_iov(const struct iov_iter *iter)
>> +{
>> +       if (iter->iter_type == ITER_UBUF)
>> +               return (const struct iovec *) &iter->__ubuf_iovec;
> 
> should simply not exist.

Yep. Fixed both up.

-- 
Jens Axboe


