Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6466CCD16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 00:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjC1WUd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 18:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjC1WUa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 18:20:30 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD1A30EF
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 15:19:59 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w4so13076028plg.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 15:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680041958;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sm4y8A0Z1L5l7EANveKzNmWGMOQddGbNiQBoQgLf15Y=;
        b=x+jK/+wesJwzBex35Ohr0vk6QpgpBiQg2nYpbgbBg0iZ1n2Ed4pMmUwkVr66/FhR1J
         0AmYzVNJBq4QJhhzgB+/9DuRrZaVegBnaYth3BYsM2wGoPHkz0l9fvSTSlSVHn7jaIb/
         lJMmRnxEdFip2bW7bNlJ/VoyfgPM19rpCz74VPiUXMA3tup2Z0owlICH7cBNGW4y1Rio
         uw095DXhRglPYQNLWwlSCXaPPrzQqhjKmBu2WUZbHEqFRGKBS5xlTtBWgAP4yAr3Wnem
         HvG/1Yii179IhPu6VrvO0m3z92TpYctQFsuP0caJs0PJa/cz9Er0fjWw9iNyKrkRD8qx
         VzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680041958;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sm4y8A0Z1L5l7EANveKzNmWGMOQddGbNiQBoQgLf15Y=;
        b=fAaJZN3hIVCaZ9QX6Ia6Z2iHPLwYxr0ZtWEQBGB2FLO51dziK6zBtOEwa0/zl7lDXA
         VjmwSV+LxcoaVnWEW6TYaCQy/AHYiDEeRuWWgz0DkvQZh+lmiCAqwamHq3wkqzBsL4Z/
         Ge/F7Z61RD9Qbz8lrgNRqaQ6efmHjOj1TbuoMStCRNPfIAazwfeyX8W6lgoT1ne08cDh
         u9r0vVfMK4JEz0FFVv9R6tseZUN4tsFTdbnbtf0g4a/Ta10bdYP7AWxkGcxai7ZBityH
         dDC9Jp+0GU+wdZeKc9l2bXMCJGGPCpYModFX1AEcCuHLYv9M5q+6i/mEF5hXR8OdYLvP
         X43Q==
X-Gm-Message-State: AAQBX9eFq4+G6WRZ9pn//XBY1Au7R6+uPw4hkWsth40jfhx1Y9NOsGcT
        K3cqqmHHRLIcnuWl+uZhygYlcA==
X-Google-Smtp-Source: AKy350ZnrQi59PsnOOthALP2GvS+vdLlQQ3BlOwpojl3A4f6D2UM4hTtZ9c1IDmBu91xEKbfBekJ6w==
X-Received: by 2002:a17:902:f9cb:b0:19a:723a:8405 with SMTP id kz11-20020a170902f9cb00b0019a723a8405mr14969702plb.6.1680041957868;
        Tue, 28 Mar 2023 15:19:17 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z30-20020a17090a6d2100b0023b4d4ca3a9sm21925pjj.50.2023.03.28.15.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 15:19:17 -0700 (PDT)
Message-ID: <416ec013-72db-7ef0-2205-e8fa0165b712@kernel.dk>
Date:   Tue, 28 Mar 2023 16:19:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/9] iov_iter: overlay struct iovec and ubuf/len
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
References: <20230328215811.903557-1-axboe@kernel.dk>
 <20230328215811.903557-4-axboe@kernel.dk>
 <CAHk-=winXSHgikHZSyDrmoN=WNZWKoR1JrKGW6Vv4mqn6F4EmA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=winXSHgikHZSyDrmoN=WNZWKoR1JrKGW6Vv4mqn6F4EmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/28/23 4:16 PM, Linus Torvalds wrote:
> On Tue, Mar 28, 2023 at 2:58 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> +               struct iovec __ubuf_iovec;
> 
> This really should be "const struct iovec".
> 
> The only valid use for this is as an alternative to "iter->iov", and
> that one is a 'const' pointer too:

True, it should. But as per the cover letter, this only really
serves as a space filler, none of the code actually uses it. But
let's make it const, because that is the right thing to do.

>> +                               const struct iovec *iov;
> 
> and any code that tries to use it as a non-const iovec entry really is
> very very wrong.

Nobody should use it, though. The one case where I thought we'd use
it was iov_iter_iovec(), but that doesn't work...

> And yes, the current infiniband/hw/hfi1/* code does indeed do all of
> this wrong and cast the pointer to a non-const one, but that's
> actually just because somebody didn't do the const conversion right.
> 
> That cast should just go away, and hfi1_user_sdma_process_request()
> should just take a 'const struct iovec *iovec' argument.  It doesn't
> actually want to write to it anyway, so it's literally just a "change
> the prototype of the function" change.

Let's leave that for the IB people!

-- 
Jens Axboe


