Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11C36CCF0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 02:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjC2Aia (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 20:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjC2Ai3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 20:38:29 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A45268E
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 17:38:27 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id cu12so9194481pfb.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 17:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680050307; x=1682642307;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y0gxTvnTuxTFV4wRNjFidB+KW0g5MZSv3juEuZ0cE6s=;
        b=Am13j1BCMpHupyIRy2ImnAfRgX6GFW1YkSRVFvZTMNOhSAOlQ+dOcWi5IkOOFZM7U8
         aqJ9FnO82RdgoUWLFpDSkdzdJ68/R4dodUv0JwxedQSVIZrVUPRYE1X3CWgyllkqPJvd
         sexIC4kfynKzM0cwExlcPx5ZSa1S85ur0fEMPLDgx0EVuwcS3hou0w5rqUM8nstMMwLb
         XWdWwFPRlE+8UfHAWWKCS+d2xL8ayuEh774FfEGG+CSc6wJDTDLkkz9nSTZVu3vJBvVJ
         561K64fYu1TYI7Zd661JLGFLXxqQ1mL46+CjYfiruQaeD+cIdAuvCVZ/mumX1UH9DQ39
         V7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680050307; x=1682642307;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y0gxTvnTuxTFV4wRNjFidB+KW0g5MZSv3juEuZ0cE6s=;
        b=WRAp3S4R1413xlXk0FBwLWFZND0HCR/P98By7DCORXlwjoP94ibgrCSZoQHaApjG5/
         Ouj4CvwcNZNkAarwOb+QId5JIDxZprDX4/TqgMG4ldxSB+Z0Em9jbJmQGGujYR6Y412E
         r0nWLfZTU9yn681M4a7bSMXL0jX5SpenZ1AkIoMeEqtD1SPQco/UFcQuiPMfTmJL7Wb5
         VIYGjHkVhy+IXul8SWIe5YVfCOEM3cush6L0ttk/RUADEN6FuhRr7xrbnfBXb40aJN08
         H4nJrofpxjAAsX4dhaQ+m0aqEhDwqDx+pXmoadzicEKnKxOxC7en3MPkra+vB+XMjDL5
         /Abw==
X-Gm-Message-State: AAQBX9cfsGqMFgozWuC7yIdXVt3NSKT/6kkr5egh3MjvGg0UU1hhRzwu
        Oryhi1zyt6Mv48D5pTXV6nhJvnCviHvJYK0yfZFJsQ==
X-Google-Smtp-Source: AKy350Zmw6NwnltCZ6OmGDcOTtK1DFSl2Dvmex1/zSAumsBLAk7U1mktKhjVlktUbUZpO8Xy2OyoHw==
X-Received: by 2002:a05:6a00:bc6:b0:623:5c0f:b24a with SMTP id x6-20020a056a000bc600b006235c0fb24amr15142140pfu.2.1680050307318;
        Tue, 28 Mar 2023 17:38:27 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s10-20020a65584a000000b0051324e710d0sm8292057pgr.59.2023.03.28.17.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 17:38:26 -0700 (PDT)
Message-ID: <43b27cfd-0d14-2182-9a6a-83f07ad832ae@kernel.dk>
Date:   Tue, 28 Mar 2023 18:38:25 -0600
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
 <416ec013-72db-7ef0-2205-e8fa0165b712@kernel.dk>
 <CAHk-=wi-mSanfxOGr4i4_TsYvxQVpzCWCsqdZr3LACHWfdVnhw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wi-mSanfxOGr4i4_TsYvxQVpzCWCsqdZr3LACHWfdVnhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=3.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/28/23 4:30?PM, Linus Torvalds wrote:
>  thing
> 
> On Tue, Mar 28, 2023 at 3:19?PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Nobody should use it, though. The one case where I thought we'd use
>> it was iov_iter_iovec(), but that doesn't work...
> 
> You only think that because all your conversions are bogus and wrong.
> 
> Your latest "[PATCH 7/9] ALSA: pcm.. " patch is just wrong.
> 
> Doing this:
> 
> -       if (!iter_is_iovec(from))
> +       if (!from->user_backed)
> 
> does not work AT ALL. You also need to switch all the uses of
> "from->iov" to use the "iter_iov()" helper (that you didn't use).
> 
> Because "from->iov" is _only_ valid as a iov pointer for an ITER_IOV.
> 
> For an ITER_UBUF, that will be the user pointer in the union, and to
> get the iov, you need to do that
> 
>     iov = &from->ubuf_iov
> 
> thing.
> 
> The "overlay ubuf as an iov" does *not* make "from->iov" work at all.
> Really. You still need to *generate* that pointer from the overlaid
> data.
> 
> So your latest patches may build, but they most definitely won't work.
> 
> I would in fact suggest renaming the "iov" member entirely, to make
> sure that nobody uses the "direct access" model ever.

Yeah ok, I see what you mean now. I'll rework it and post something
tomorrow when it looks sane.

-- 
Jens Axboe

