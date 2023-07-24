Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A0E7602D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 00:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjGXW5F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 18:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGXW5E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 18:57:04 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C14E49
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 15:57:00 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5576ad1b7e7so515621a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 15:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1690239420; x=1690844220;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UrBb13udC0Sw0lvgxVDSnhNAbZY+mi9v9znyZvL6wfM=;
        b=lESGWgwKbHrD7eD+yo7IbzjvnFOa2AQYQC3b7uZhKvqkRZkfnvHzBeHSU0cqXVaXdD
         AoGoLbgdHZgTvNgHg+Yh5M1cgNPkHBGMX320oz56TCM8ccJX7l1vSHlG9ApRg/Uy5dTS
         En5mbnU/9wdkBUGFHYU5uHY6qk24AjK0o7+pxHxChhn1wu90qgXY0EH6/ubOvsyjf0F0
         bCTSdN0Bg8kZLcHZUJRBPGPpQGMYiBuf/wjZ8pZzwPcp6AWo7zjA+gxRxEyrtwEFDnkN
         pTsrwSB0T88vZpj4Q+w2in78yTsJiFqu/7iGDOBi6IHRa1AaPSTQN5gUZiN3Tz9fjKRk
         HKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690239420; x=1690844220;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UrBb13udC0Sw0lvgxVDSnhNAbZY+mi9v9znyZvL6wfM=;
        b=U3UG8WPhq5upHOUFN5CcPak2LX1SAv2fU4jC19UWcumgSErXAAQ/C9NfPvR+S+mhAJ
         ntQgkVwwBZVLIr0XpuEW5MaMQj8tS6hvX6m7i2pPpdGQgPMboseYQ1lADQXI5O4Kdfft
         tw8aolI8zVdMskK7rkqLS5a9VzDUR/Ao8Cd18qkyxFeHOGpU51MHi6ssdtkfP9Qsdk7D
         Ad6OsKUwV8lFkAKaQ9N7V5/g+8PF0nFFtm1eAm5sl1Bo6oJu0qHs+QO8FragXCFNfyqb
         k8i6aq7EJJ7K+t5HMurtWQaSuqB5X2rJXrDqu0gYqz8Hz4KXsMLt3Q8Q512OdXFINckZ
         yFWA==
X-Gm-Message-State: ABy/qLbqnU28rERrMkF+7p0U1coLpVSByvy8kN9Nqiw23dQoOQ3rqep/
        MEEPsm3HLgLvNdKQVMOfeLDQ2g==
X-Google-Smtp-Source: APBJJlHzOj52nENWFGfKQ1Ibk02D3ClkkpbgfLa6YtnLuKXCpqfiTDI1LkP79vTn6z0iGFufaZh5Aw==
X-Received: by 2002:a05:6a20:160d:b0:111:a0e5:d2b7 with SMTP id l13-20020a056a20160d00b00111a0e5d2b7mr14464498pzj.4.1690239420187;
        Mon, 24 Jul 2023 15:57:00 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g14-20020a62e30e000000b006579b062d5dsm8232945pfh.21.2023.07.24.15.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 15:56:59 -0700 (PDT)
Message-ID: <4b382446-82b6-f31a-2f22-3e812273d45f@kernel.dk>
Date:   Mon, 24 Jul 2023 16:56:58 -0600
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
 <790fbcff-9831-e5cf-2aaf-1983d9c2cffe@kernel.dk>
 <CAHk-=wgqLGdTs5hBDskY4HjizPVYJ0cA6=-dwRR3TpJY7GZG3A@mail.gmail.com>
 <20230724-geadelt-nachrangig-07e431a2f3a4@brauner>
 <CAHk-=wjKXJhW3ZYtd1n9mhK8-8Ni=LSWoytkx2F5c5q=DiX1cA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wjKXJhW3ZYtd1n9mhK8-8Ni=LSWoytkx2F5c5q=DiX1cA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/24/23 4:25?PM, Linus Torvalds wrote:
> On Mon, 24 Jul 2023 at 11:48, Christian Brauner <brauner@kernel.org> wrote:
>>
>> It's really just keeping in mind that refcount rules change depending on
>> whether fds or fixed files are used.
> 
> This sentence still worries me.
> 
> Those fixed files had better have their own refcounts from being
> fixed. So the rules really shouldn't change in any way what-so-ever.
> So what exactly are you alluding to?

They do, but they only have a single reference, which is what fixes them
into the io_uring file table for fixed files. With the patch from the
top of this thread, that should then be fine as we don't need to
artificially elevator the ref count more than that.

-- 
Jens Axboe

