Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE8A75FEC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 20:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjGXSFW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 14:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjGXSFV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:05:21 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4353810E7
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 11:05:15 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-77dcff76e35so58038839f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 11:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1690221914; x=1690826714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hsQLWiCx5Jj3SkbXeD4hp14VN/U+7+kmixZ0jf5P3sM=;
        b=xMrm9jSJ4x9FAKpp7ej5qB+8nUyzzUwmdQATjODYVT0GKYPEwUwIGqv8iw+oecBLdu
         zL3KxGy8gZL7hb6L4c8/fiwaRdN+FDuAd9wcWdXhe4nL64tcA+1stPDbnKSL39A1JAbz
         E3Co6XOyzIklkxavfRgCnyRc5Csavdft/R01dIjRiUrDcGquJv5amFManYiCWOzTQLIB
         0fL/2vl6gdfNkPIFrpq+C/UH4JKemn7gWbpReVn9JJ5n1YNYz9o8ieZn3azyspDTIyjg
         qixy+09uI7uC0qvfF0UzAYMW5fLsstCI2rZDiWi6k9ZgZ+9awnX0jcG5WIWB229FUAvV
         fC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690221914; x=1690826714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hsQLWiCx5Jj3SkbXeD4hp14VN/U+7+kmixZ0jf5P3sM=;
        b=T1JWNPb0WDM/rnqOtgniYhavbKkGX0rPsK/xCHpqcbEdzVeAhj9c89woo3QL8+cgtq
         g+M6IirrDUOJZ0p0t8DI85AFYJCZdUlUYSOOBWIw1Gz+W8KQPyF/L36QCBo40qYY/3B7
         Z2HTrO+KrdZtqj/BmiZwv9S+GN0UpprPYWm7ZrdDr/9NmMfIPkGhfo3B9z0Fbk9VD5m3
         uqfQPutLR8TuYgMjcT6aYw7khXjoHbMpZgd15G3/NbwHdIgiiC7RhTqjXQKg60I4OMVp
         bvOmzu5cA297mcW6XF5MOkpDl6JjBF3P7opoAJ22N1GeHylfcIUKlBftXEka+oJsIByM
         ZAlA==
X-Gm-Message-State: ABy/qLbyIt6ilrAyjT/dCrfXhOOmQPchS1kaO0a4thW6DENnmL6y1iXJ
        UuolBYFjM9Q1toxLK6GbWdZvTGwibkzbb/u0NkM=
X-Google-Smtp-Source: APBJJlHU/IEgJnOjhKfDwNqIMcgChLFB2B3H7kd6sx8OXuMH1PIEth+hwzINuoq76AZYvb5cyXSgSw==
X-Received: by 2002:a6b:b789:0:b0:787:1926:54ed with SMTP id h131-20020a6bb789000000b00787192654edmr8086955iof.1.1690221914639;
        Mon, 24 Jul 2023 11:05:14 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id do17-20020a0566384c9100b0042b10d42c90sm2959694jab.113.2023.07.24.11.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 11:05:14 -0700 (PDT)
Message-ID: <790fbcff-9831-e5cf-2aaf-1983d9c2cffe@kernel.dk>
Date:   Mon, 24 Jul 2023 12:05:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] file: always lock position
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
 <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
 <20230724-scheren-absegnen-8c807c760ba1@brauner>
 <CAHk-=whwUTsixPwyBiuA25F2mAzARTU_-BijfmJ3MzkKLOYDmA@mail.gmail.com>
 <20230724-gebessert-wortwahl-195daecce8f0@brauner>
 <CAHk-=wiZRxy3983r_nvWG4JP=w+Wi623WA9W6i2GXoTi+=6zWg@mail.gmail.com>
 <20230724-eckpunkte-melden-fc35b97d1c11@brauner>
 <CAHk-=wijcZGxrw8+aukW-m2YRGn5AUWfZsPSscez7w7_EqfuGQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wijcZGxrw8+aukW-m2YRGn5AUWfZsPSscez7w7_EqfuGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/24/23 12:01?PM, Linus Torvalds wrote:
> On Mon, 24 Jul 2023 at 10:46, Christian Brauner <brauner@kernel.org> wrote:
>>
>> I don't think we do but it's something to keep in mind with async io
>> interfaces where the caller is free to create other threads after having
>> registered a request. Depending on how file references are done things
>> can get tricky easily.
> 
> Honestly, by now, the io_uring code had *better* understand that it
> needs to act exactly like a user thread.
> 
> Anything else is simply not acceptable. io_uring has been a huge pain,
> and the only thing that salvaged the horror was that the io_uring
> async code should now *always* be done as a real thread.
> 
> If io_uring does something from truly async context (ie interrupts,
> not io_uring threads), then io_uring had better be very *very*
> careful.
> 
> And any kind of "from kthread context" is not acceptable. We've been
> there, done that, and have the battle scars. Never again.
> 
> So the absolutely *only* acceptable context is "I'm a real
> io_uringthread that looks exactly like a user thread in every which
> way, except I never return to user space".
> 
> And if io_uring does absolutely _anything_ to file descriptors from
> any other context, it needs to be fixed *NOW*.

io_uring never does that isn't the original user space creator task, or
from the io-wq workers that it may create. Those are _always_ normal
threads. There's no workqueue/kthread usage for IO or file
getting/putting/installing/removing etc.

-- 
Jens Axboe

