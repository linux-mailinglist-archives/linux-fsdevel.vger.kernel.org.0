Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEAB6CF3F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 22:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjC2UBG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 16:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjC2UBE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 16:01:04 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72345FF1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 13:01:03 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-752fe6c6d5fso10212139f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 13:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680120063;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L5wJhLghJ0C2qxjXZBKrjnAORtU6nmnrem9ugdmaALE=;
        b=lD4h0mp1oGIbizBBDyB+47t7/euDB+pBJiPai3sWEufsguftqFdXfRgUU2Cw21HQqG
         pmVbrC23hEhnc2VYY1KUqAV6a/qqnhUbZ0xM6fRw3bLeH/reBylget6uEa0p7Rs25lNN
         NpYmkQryckrInVfWI1YFFaZnSdldyCWM9FCz3xIlUsf4gpQcYsbMKUr9JYZZXYoNoQEh
         WdQRYtH7w1W0oUi9NvkJX/iHaX0UBCqO+Q17ZkryGwtjyfVw51+KZz1wRCB0qRqFnCiJ
         v8AsX7Bhqvwr5NZZtpiseIsnT0Ig8eaoR0P0+Fo345jzfPdqyGPG8BNxRFvxjj73/6qM
         b0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680120063;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L5wJhLghJ0C2qxjXZBKrjnAORtU6nmnrem9ugdmaALE=;
        b=7X7a6Gz4LO9EK7JM0ZmKSxqzAGWzfIbGnI3epo2e6/cJGBQS2OV6+z9CoPGck9/8r2
         nt1YxC5vW96mrMJiCX/NaPfvGl+TZdlSYmOLGZ3V36Rq2xpenkYfEnab6SABRNKRnHzL
         gtjUoqRBQOeZMhaBVmbpeKyrDjKs42WzV8AcIPQRbK+y2N4Bz0l++uXV4cJ5m7gv3w69
         nLgITOdvlWsaTTrKr8hVd1xmVOJMitQqYE8vmk7eFQm9YTRLXqUQSECrkZ0z3pndW60E
         BKhxsyg70HpMOJgZikX/fhO2KV0A4iCctvI96p9j7glB7bI9XNn/u874KGWjw8Ob4Hl/
         xiZQ==
X-Gm-Message-State: AAQBX9ccgUfSpJEdoxUECx4Urg5W/XBKxlaah9kVb7zbzRuesFZI4RfG
        VoRC6k/xllwXKyY8q9L9JA4dmw==
X-Google-Smtp-Source: AKy350aizYZGsb4cONjZPdEbo5UMbeXBQ1W8mXbXO6E1ot4M0V/SWaRzBcHt5hbXFrhGIKBzPk9jwQ==
X-Received: by 2002:a05:6e02:1c04:b0:325:e065:8bf8 with SMTP id l4-20020a056e021c0400b00325e0658bf8mr11492653ilh.0.1680120063025;
        Wed, 29 Mar 2023 13:01:03 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id a17-20020a056e0208b100b00315785bfabfsm9478659ilt.47.2023.03.29.13.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 13:01:02 -0700 (PDT)
Message-ID: <1b9abd54-f046-af65-fd0c-1573e50c61d6@kernel.dk>
Date:   Wed, 29 Mar 2023 14:01:01 -0600
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
 <554cd099-aa7f-361a-2397-515f7a9f7191@kernel.dk>
 <a0911019-9eb9-bf2a-783d-fe5b5d8a9ec0@kernel.dk>
 <f12452c7-0bab-3b5d-024c-6ab76672068f@kernel.dk>
 <CAHk-=wg4J1+Ses2rY0xBhWxyfTDNW+H_ujpcwngKG5tp0y_Fxw@mail.gmail.com>
 <3274c95f-b102-139d-0688-be688d799c20@kernel.dk>
 <CAHk-=wjMWpR6y34Rk92O31NFEOaZPuMb9DxwKThvFF-CE+vA8Q@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wjMWpR6y34Rk92O31NFEOaZPuMb9DxwKThvFF-CE+vA8Q@mail.gmail.com>
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

On 3/29/23 1:59 PM, Linus Torvalds wrote:
> On Wed, Mar 29, 2023 at 12:56 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Nope, still fails with it moved below.
> 
> Ouch. I guess the 'const' cast may be the only way then.  It sounds
> like gcc may warn whenever it sees an assignment to any structure that
> has a const member, rather than when it sees an assignment to that
> particular member.
> 
> Sad.

Yeah, I tried a bunch of variants to trick it, including having
it in a union with another non-const iovec first. But it cannot be
tricked, so I think we're stuck with that. I'll add a comment.

-- 
Jens Axboe


