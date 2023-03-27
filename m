Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00856CAE29
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 21:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjC0TG4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 15:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjC0TGx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:06:53 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7842D48
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 12:06:42 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id d14so4326935ion.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 12:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679944002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E36Pw5Q8t0I2zx5O9gKa8C9oju5ufl1kUpeLdodl1e8=;
        b=va+SraEvwHAl4XVq7PoFfpgWwn5ICQXVbkk+OcArUJ4eLfpKPBqo5w9dzXUBJzIOza
         V6uv5lLjCwao5e5jbww4IftLx67wx32h6l43a6nD85xj8ggdTlaxUgMtQM/QBjPzd0tE
         RyjjBKrKDEpqY4/baP6cWGbusIVIWYmfoDFuayKV6PbDTt7T+V4CYzZTlKrpPHj48VtD
         euOBJ7YUuTgnG0kw1hcelmUJsj3cTM8r8k1IBNOmvORkuh8TuWhzhrH2/mr7wDapM0lS
         IUq9DUix7uszA/DgsvyJ6h3y+/pJ3KKiXG4VNHBeYNCFWn6lJghMZrqyLLfxYP9k3FP+
         s+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679944002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E36Pw5Q8t0I2zx5O9gKa8C9oju5ufl1kUpeLdodl1e8=;
        b=c/SxjRIH2XDdLQjIbFFIVkwk6pswUJrxzzOgePyC7HmDGd45GZnVTfaMrXqrLuHvSh
         CmkMy6ougx/0TR8UIpUBoGLxHhdHr8uyhZYyB2v9m8uYfphJkgZrwFedjEuDg9sq1eFV
         HvNF1xRSVauXJfiYJf2bRdUs/SPq6/S28Qh8LkW/u8WlBfzEBBwJy5K8Vbo2bz7eZWqq
         Gk7tGdNSzpnl91fjX2xR78I1c7UKlmnXRTzuFee9FVgvlOgKJZ9vgr1NnhgoNM1liQGe
         TL+GrlYGTptNr4uTeoIO2BW23ZHlgjYkNub/MOGuHMzE2iy38iDATWYIRSyj/9VNf25t
         JFfw==
X-Gm-Message-State: AO0yUKVLzdAznL3tFeHaiemN8xQb1+mMMSK+dB1+7ecicvFhhZoit7Sb
        7XVGZ5wpiW6llQvl71ZVuQsnyg==
X-Google-Smtp-Source: AK7set8/UOlLsLl8QQ8psl6NTqBdNyoG0/Fn3YGAx4p2pzhhLK6CUj5TTDkoFBroSCH4RWgZhwSJqw==
X-Received: by 2002:a05:6602:3793:b0:758:5405:7275 with SMTP id be19-20020a056602379300b0075854057275mr8949759iob.2.1679944001951;
        Mon, 27 Mar 2023 12:06:41 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id g21-20020a05663810f500b00405f36ed05asm9064668jae.55.2023.03.27.12.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 12:06:41 -0700 (PDT)
Message-ID: <2d33d8dc-ed1f-ed74-5cc5-040e321ac34f@kernel.dk>
Date:   Mon, 27 Mar 2023 13:06:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/4] fs: make do_loop_readv_writev() deal with ITER_UBUF
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
References: <20230327180449.87382-1-axboe@kernel.dk>
 <20230327180449.87382-2-axboe@kernel.dk>
 <CAHk-=wh4SOZ=kfxOe+pFvWFM4HHTAhXMwwcm3D_R6qR_m148Yw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wh4SOZ=kfxOe+pFvWFM4HHTAhXMwwcm3D_R6qR_m148Yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/27/23 1:03?PM, Linus Torvalds wrote:
> On Mon, Mar 27, 2023 at 11:04?AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> --- a/fs/read_write.c
>> +++ b/fs/read_write.c
>> @@ -748,10 +748,21 @@ static ssize_t do_loop_readv_writev(struct file *filp, struct iov_iter *iter,
>>         if (flags & ~RWF_HIPRI)
>>                 return -EOPNOTSUPP;
>>
>> +       if (WARN_ON_ONCE(iter->iter_type != ITER_IOVEC &&
>> +                        iter->iter_type != ITER_UBUF))
>> +               return -EINVAL;
> 
> Hmm. I think it might actually be nicer for the "iter_is_ubuf(iter)"
> case to be outside the loop entirely, and be done before this
> WARN_ON_ONCE().
> 
> If it's a single ITER_UBUF, that code really shouldn't loop at all -
> it's literally just the old case of "call ->read/write with a single
> buffer".
> 
> So i think I'd prefer this patch to be something along the lines of
> this instead:

See Al's suggestion in the other thread, I like that a lot better as it
avoids any potential wack-a-mole with potentially similar cases. There
are not a lot of hits for iov_iter_iovec() in the three and I spotted
two, which lead to these two prep patches. But if we do:

https://git.kernel.dk/cgit/linux-block/commit/?h=iter-ubuf&id=8a825a6f52e8fab74e936f15eea6c34ac67272f6

then we don't really have to worry about those.

-- 
Jens Axboe

