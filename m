Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670B96ED763
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 00:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbjDXWD0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 18:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjDXWDZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:03:25 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E03C7684
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 15:03:23 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63d32d21f95so1167688b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 15:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682373802; x=1684965802;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BOc9YH+oGqwIpPSq5V/5aVKlMiMHqBjxPBRqWKmHOfA=;
        b=rmT/wQJtGXdI2xWEpUP5et6/IDtgx8ko4m/4kTM/DaHFG4IJ0felb43tvKYMorRR0H
         T83uSU+fp/ninhWqyK6ZEWuZg/VsCfFmsHwSHpEfQnyVWbtbS2db/YFxsl8390fdDrOZ
         SUor7GQu0n2bY0i8rCrJtLGVqQYKNsrzeePKZMP4Ohf+w/v5R0aijnP9K5wHAHPDL7gT
         3J7CRh/5YhfZSZdRxoB1pDBl1UaaMTmtThd3GXx+OxHlMZSbKrjOh8WLS8EHrXIkwHq4
         LNvi5qpJH8r4aHaSSUuY+emoY8d5WyXZdgKg9pH0XvPvSNq3bNdDOjPorAil+6ghTf8L
         aaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682373802; x=1684965802;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BOc9YH+oGqwIpPSq5V/5aVKlMiMHqBjxPBRqWKmHOfA=;
        b=b71ThGuT3zQWdGulvcreYKDnyhts5akshYcDBYr6qaFZCxS9eFVev6GSAw7tjCtKg0
         rexTsridXaPJoqHlugVzAUMSkCv8vMViyVELm46zXwMQSCM4vYF938tnP0gvDwY9P3Gd
         Jm9dgX51GElzIri/y7T6KYxHluGfZk+sGR0O9owywUPEqaH6M+Fmf1pHpoB6MaGCgN8g
         jCK4TR+jyObFm6P/cV9+++XyG1leaUB8vZtUQarMRBP21H0UNEZFMIQDQs56bBEX7g72
         Qxfy6avI3Y8LEdbnEe7yrbmQc7YitMCY2lXN2RSsGT/u9fNNqNxPm3SEiQ/Ce1GxelMP
         CZeQ==
X-Gm-Message-State: AAQBX9cR7EWsRbTOYGd0jqRTG/RNeRuJJ9zIKNfnnn1ZaKUoTpmEDYpM
        E3c4JwJVZ7b8bif5fqB0qOhH5Zf1Txs14bBdoCQ=
X-Google-Smtp-Source: AKy350ZlEdxLB0ycl7j8TzRt1zNUbUabFy4ZhtSwJjyDusHh4TNPAvFoiBMZx6rDkm+z9gCe2uv9gA==
X-Received: by 2002:a05:6a00:f0e:b0:63f:21e:cad8 with SMTP id cr14-20020a056a000f0e00b0063f021ecad8mr17447730pfb.3.1682373802596;
        Mon, 24 Apr 2023 15:03:22 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j18-20020a056a00235200b0063d46ec5777sm7888385pfj.158.2023.04.24.15.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 15:03:22 -0700 (PDT)
Message-ID: <83712767-82b2-42f6-c86f-9e3d4edd44d5@kernel.dk>
Date:   Mon, 24 Apr 2023 16:03:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [GIT PULL] pipe: nonblocking rw for io_uring
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230421-seilbahn-vorpreschen-bd73ac3c88d7@brauner>
 <CAHk-=wgyL9OujQ72er7oXt_VsMeno4bMKCTydBT1WSaagZ_5CA@mail.gmail.com>
 <6882b74e-874a-c116-62ac-564104c5ad34@kernel.dk>
 <CAHk-=wiQ8g+B0bCPJ9fxZ+Oa0LPAUAyryw9i+-fBUe72LoA+QQ@mail.gmail.com>
 <ae8ee8f3-9960-1fd9-5471-433acacb6521@kernel.dk>
In-Reply-To: <ae8ee8f3-9960-1fd9-5471-433acacb6521@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/24/23 3:55?PM, Jens Axboe wrote:
> On 4/24/23 3:37?PM, Linus Torvalds wrote:
>> On Mon, Apr 24, 2023 at 2:22?PM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> If we don't ever wait for IO with the pipe lock held, then we can skip
>>> the conditional locking. But with splice, that's not at all the case! We
>>> most certainly wait for IO there with the pipe lock held.
>>
>> I think that then needs to just be fixed.
> 
> I took another look at this, and the main issue is in fact splice
> confirming buffers. So I do think that we can make this work by simply
> having the non-block nature of it being passed down the ->confirm()
> callback as that's the one that'll be waiting for IO. If we have that,
> then we can disregard the pipe locking as we won't be holding it over
> IO.
> 
> Which is what part of this series does, notably patch 1.
> 
> Only other oddity is pipe_to_sendpage(), which we can probably sanely
> ignore.
> 
> IOW, would you be fine with a v2 of this pull request where patch 2
> drops the conditional locking and just passes it to ->confirm()? That's
> certainly sane, and just makes the ultimate page locking conditional to
> avoid waiting on IO. I'd really hate to still be missing out on pipe
> performance with io_uring.

I guess that would still have blocking if you have someone doing splice
in a blocking fashion, and someone else trying to do RWF_NOWAIT reads or
writes to the pipe... The very thing the conditional pipe locking would
sort out.

Only fool proof alternative would seem to be having splice use a
specific pipe lock rather then pipe->mutex. And honestly pipes and
splice are so tied together than I'm not sure that doing separate
locking would be feasible.

-- 
Jens Axboe

