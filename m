Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FCD6ED766
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 00:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjDXWFG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 18:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbjDXWFE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:05:04 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FA41BD8
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 15:05:02 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b78525ac5so1429511b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 15:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682373902; x=1684965902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V7n4IK1ZSqKlX1ZMiQx4ShboFoAiJ0hUCI2Vsw8IvpE=;
        b=smXNnIDtxJckxbzeu5ZKLu9B5dl4kPHzQvtakILsgFJTyjqYPLwK3gJ0jnoF2LZi9q
         sn2Gb2Zt1upgc5h8RjIPZYGGlxN8i+I94seEBKT5Xlzqv8POjpertQjtvSTd+vEKLG3Y
         iEEwv00hiwzq/ap+fXYnKd6SStiVeScEXFd8+YeonVKmsReMFjDjSS0FFt0L+M0+lLXH
         DqyWX6J4ayte4sGDGNmg7Hgv8kD9UB/UZpDPr/gRcB8rZ8TnrL7+Pq5ykkPj8xrXiK5P
         ozmIX/zvVgXjg+jyY4tIkgToLo4No8slEE+nE0I0HLOvFMJa8SsPK4EZNiu4BMWhkZU6
         1JcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682373902; x=1684965902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7n4IK1ZSqKlX1ZMiQx4ShboFoAiJ0hUCI2Vsw8IvpE=;
        b=OC5hBv2FdJFF2qCXWW4tLPhdstxnMjc1IeB1+rPJSuYbYXQENFtzv2x4ZSEwtPbR5g
         1uNrXjDEACNYvH0kPGvDygc40qy9v2s1grnUxS4e4xMXk+JxrMc2T1oZxSBkJoYoY1oe
         qq5Aj+r6aU8tIR7w0MtK+vaqHqMoQjy5eRv5ZZjsk8MzB6WZghzSRS39RrusHcr1iCKI
         Kg4WJMNIh52t3Z5ddeVPvvON+64ZmLscsRv9n1Us/bKBHrtTfLbgBOwkYSSnPP0NITHI
         ilBV1PYoepxA1S+5E0U+mmRAbMdIN6QTPU96t96ddoeyAscFNL62Yj3oyltphJJWcO53
         625Q==
X-Gm-Message-State: AC+VfDy43scTx96FbQjGUclWWRVKjFjdKhbSZqkefMJKCIsFThWYkPat
        z44M/qA5sQRdebQHNnXZ6KZrVA==
X-Google-Smtp-Source: ACHHUZ5p+qkajHkY6tByRiWmkXy/aZb+YKiDnjyRokpDX8h+3xm4sEw3FBOF/qn3AOdsbmAw9EZfKw==
X-Received: by 2002:a05:6a00:a88:b0:635:4f6:2f38 with SMTP id b8-20020a056a000a8800b0063504f62f38mr303224pfl.2.1682373901600;
        Mon, 24 Apr 2023 15:05:01 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y189-20020a62cec6000000b00640defda6d2sm1292677pfg.207.2023.04.24.15.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 15:05:01 -0700 (PDT)
Message-ID: <22265532-595f-0477-45a7-f920115b3771@kernel.dk>
Date:   Mon, 24 Apr 2023 16:05:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [GIT PULL] pipe: nonblocking rw for io_uring
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230421-seilbahn-vorpreschen-bd73ac3c88d7@brauner>
 <CAHk-=wgyL9OujQ72er7oXt_VsMeno4bMKCTydBT1WSaagZ_5CA@mail.gmail.com>
 <6882b74e-874a-c116-62ac-564104c5ad34@kernel.dk>
 <CAHk-=wiQ8g+B0bCPJ9fxZ+Oa0LPAUAyryw9i+-fBUe72LoA+QQ@mail.gmail.com>
 <ae8ee8f3-9960-1fd9-5471-433acacb6521@kernel.dk>
 <CAHk-=wiQ+S79vjAJf92TE8PqCie4xZPAhRgVchHnPesVHZPO0g@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wiQ+S79vjAJf92TE8PqCie4xZPAhRgVchHnPesVHZPO0g@mail.gmail.com>
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

On 4/24/23 4:00?PM, Linus Torvalds wrote:
> On Mon, Apr 24, 2023 at 2:55?PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> I took another look at this, and the main issue is in fact splice
>> confirming buffers. So I do think that we can make this work by simply
>> having the non-block nature of it being passed down the ->confirm()
>> callback as that's the one that'll be waiting for IO. If we have that,
>> then we can disregard the pipe locking as we won't be holding it over
>> IO.
> 
> Ok, that part looks fine to me.
> 
> The pipe_buf_confirm() part of the series I don't find problematic,
> it's really conditional locking that I absolutely detest and has
> always been a sign of problems elsewhere.

Agree, the conditional locking is the ugly bit for sure. I'll reply to
your other email as my followup to my message discovered that this isn't
enough due to mixed splice/non-splice usage.

-- 
Jens Axboe

