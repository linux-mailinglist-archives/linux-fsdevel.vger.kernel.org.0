Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D476CF366
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 21:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjC2Tm5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 15:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjC2Tmm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:42:42 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1675D6A60
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 12:42:16 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id m22so7321665ioy.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 12:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680118935;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PBQAVi0nfd2l/A02FIyJWxp1fHTNBAlt9j+Djs7XH98=;
        b=j0G0eJ0dNPU7P6S67CUr9+mXguem/Wvzz+QmuzN3tCsHgnoLlIDsOMMZjGkxiuAMX0
         ko/kLQ3OXVyaW7aUj1Zf4gj8Ous1tJS3tuGE4EI6AC3yTSRARyz6EiU7FNve3hmOr1eT
         gPO0bwV//qp0SBGBELzGU4GhmNRcK4PILfvDl21Xqp8nx0fjgJSUKGzcONT+yER2JrOM
         luaBOhCMuByNKKtdt4yJcWdFq9Wgbcpm/9En8EQn4rY5n3GZH8eBG8GvTQc+1vFicLXM
         G/+3CGOMl09JCZWczCRVkc+6jvpZReVKOHiO6qtCAD/AK3HazJCTXySgos0cWvVqjy30
         HGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680118935;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PBQAVi0nfd2l/A02FIyJWxp1fHTNBAlt9j+Djs7XH98=;
        b=FfKPl7zT69v0o/whp+IJfx/yYGxUXa26JRcwA8uB7RiAKp5x/FTIM04ozgcKhbybw5
         FWQigTnSh9D5c6vkugcCSI390D3AEMB5nxbhRnfzeXzBr18wqiVpx/BeY+WbgJ0eWtSZ
         ayfo2GWavcYgIOQVhE8SE0pF/xfLZe+xoTx3AvX7sLwZ4EY2WGu4RG9cz9a+TbpsQbjX
         TuXSrb1VXKMaaclHfckYTRCIKlLAEbbzWTpx6SDHZsKzCdqQA9BH0vUuMmAHXhGmier5
         s/Eh3j3KeCj8NRk/7nDKcbCxuxcvUFihzqNIFqFdjHX8pdCLx7MAucbQuIRYM9HUaWHz
         HYgQ==
X-Gm-Message-State: AAQBX9fCEf1AvnM0t7JPvtpVji0Bel8JBkCynIHWqjAlAH+ChkT88nnv
        41tzIDfezqhD+Zs6yVhMZAMRhBwebpSUkukdTmdsUg==
X-Google-Smtp-Source: AKy350btwNO3j2TRqrLVlbgOxOph8U0W2fnGAnY6ny6qMCAz1NZ0YCq16ZmZqRRcKE+0uZRS+Q57Tw==
X-Received: by 2002:a6b:1408:0:b0:75c:f48c:2075 with SMTP id 8-20020a6b1408000000b0075cf48c2075mr199539iou.2.1680118935393;
        Wed, 29 Mar 2023 12:42:15 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t8-20020a05663836c800b003eb3be5601csm10604524jau.174.2023.03.29.12.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 12:42:14 -0700 (PDT)
Message-ID: <a0911019-9eb9-bf2a-783d-fe5b5d8a9ec0@kernel.dk>
Date:   Wed, 29 Mar 2023 13:42:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 06/11] iov_iter: overlay struct iovec and ubuf/len
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
References: <20230329184055.1307648-1-axboe@kernel.dk>
 <20230329184055.1307648-7-axboe@kernel.dk>
 <CAHk-=wg2q64+WLKE+0+UNeZav=LjXJZx2gHJ5NR3_5LxvQC8Mg@mail.gmail.com>
 <554cd099-aa7f-361a-2397-515f7a9f7191@kernel.dk>
In-Reply-To: <554cd099-aa7f-361a-2397-515f7a9f7191@kernel.dk>
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

On 3/29/23 1:38 PM, Jens Axboe wrote:
> On 3/29/23 1:30 PM, Linus Torvalds wrote:
>> On Wed, Mar 29, 2023 at 11:41 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> +               struct iovec __ubuf_iovec;
>>
>> I think this is the third time I say this: this should be "const struct iovec".
> 
> Doh sorry, not sure why I keep missing that... But yes, it should, I'll make
> the edit and actually amend it.

Now I recall why that ended up like that again, during the initial fiddling
with this. If we leave it const, we get:

  CC      arch/arm64/kernel/asm-offsets.s
In file included from ./include/linux/socket.h:8,
                 from ./include/linux/compat.h:15,
                 from ./arch/arm64/include/asm/ftrace.h:52,
                 from ./include/linux/ftrace.h:23,
                 from arch/arm64/kernel/asm-offsets.c:12:
./include/linux/uio.h: In function ‘iov_iter_ubuf’:
./include/linux/uio.h:374:12: error: assignment of read-only location ‘*i’
  374 |         *i = (struct iov_iter) {
      |            ^
make[1]: *** [scripts/Makefile.build:114: arch/arm64/kernel/asm-offsets.s] Error 1
make: *** [Makefile:1286: prepare0] Error 2

Let me take a closer look at that...

-- 
Jens Axboe


