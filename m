Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9156CCC0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 23:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjC1VVZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 17:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjC1VVY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:21:24 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413232111
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 14:21:23 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a25eabf3f1so839645ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 14:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680038483;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=37w/mLz1/IeQYM1YNH9T1OFwsYSh/RWHj4RxdebIIUI=;
        b=q7ieAfxaMY2RuLOBs87DAWPjueycwFn6qnWlqTo/0PDEPmHAJDIpVM09ilJU6ZFU94
         yJG7WrKB0EEHXmAeZqRPqWSzk+0AqO9mn2UMDn/XCvXIt3hDlXwl50YaAyEh+iZ+oPI+
         Q4zbglxX5JvDwhRjOH6i3NGSkwtPNhThgEdzoauMyXZ1bkPHbaHJNQtkPtK8wJMiAdiL
         ya0BgFpvIBBM/FJAcDBcYoPqRfgwTuENjHQi4WID89611jFT4gY5nZqVC9gvxE5ovyEM
         eE8qatpJwgNWx71/+AmxT6RuG6BOQ7mUE0KF/axdqYm4D3VYyYArWPfjS+RlCV8UQhNa
         L5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680038483;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=37w/mLz1/IeQYM1YNH9T1OFwsYSh/RWHj4RxdebIIUI=;
        b=3EdGa4i5CS8cnRu2rP1flllgNTR6HlgzBMJHGITKVkxJSx38RwW8unva/OOG1s8A3A
         w/wM5jv3++3sNPD2pGZOgbj0m+QA8uzD5wHk9Gu5ofxCxbTEVh5ToDvZsW9CGygIyjiB
         6efJgp3VWOaGaccvrLto1ctJGQraofrXjQ8Zfn1OQb6nlR/jcmmU8FYVHN9lPHnw47h7
         NRc6Fnyh/1rM40yeGVT1tZn31lcTssRDhpAgCj1YzGFPQoFurO7VPHU1pS1RCvvW1Hll
         JFHS7ITXPfRxcR/z7xDxt0ldmftOdhQAcn/wAVtcVTgpnzzpwPG5I0lAZzqr3s9MTlu7
         rszQ==
X-Gm-Message-State: AAQBX9eoecrqTC/Ro3ItnfyKr96HTEwDFHl/XgP1nYjt9AWmLVPNUSz2
        Abrr3/Inw3gH6+qrZ5GT8DrO8w==
X-Google-Smtp-Source: AKy350aQQY9coHnT+dtPzsbvSIUtav3IUlX1I7tlsQhU+xktYU9SDeQlAC2Iu8x7TzfR3q9AcesSmg==
X-Received: by 2002:a17:90b:4007:b0:23f:6872:e37c with SMTP id ie7-20020a17090b400700b0023f6872e37cmr12349853pjb.0.1680038482677;
        Tue, 28 Mar 2023 14:21:22 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d7-20020a17090a498700b002340d317f3esm9561280pjh.52.2023.03.28.14.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 14:21:22 -0700 (PDT)
Message-ID: <fc3e4956-9956-01ee-7c11-e9eef59b5e38@kernel.dk>
Date:   Tue, 28 Mar 2023 15:21:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 5/8] IB/hfi1: make hfi1_write_iter() deal with ITER_UBUF
 iov_iter
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
References: <20230328173613.555192-1-axboe@kernel.dk>
 <20230328173613.555192-6-axboe@kernel.dk>
 <CAHk-=wj=21dt1ASqkvaNXenzQCEZHydYE39+YOj8AAfzeL5HOQ@mail.gmail.com>
 <ZCM4KsKa3xQR2IOv@casper.infradead.org>
 <CAHk-=wgxYOFJ-95gPk9uo1B6mTd0hx1oyybCuQKnfWD1yP=kjw@mail.gmail.com>
 <CAHk-=wggKW9VQSUzGGpC9Rq3HYiEEsFM3cn2cvAJsUBbU=zEzA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wggKW9VQSUzGGpC9Rq3HYiEEsFM3cn2cvAJsUBbU=zEzA@mail.gmail.com>
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

On 3/28/23 1:16?PM, Linus Torvalds wrote:
> On Tue, Mar 28, 2023 at 12:05?PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> But it's not like adding a 'struct iovec' explicitly to the members
>> just as extra "code documentation" would be wrong.
>>
>> I don't think it really helps, though, since you have to have that
>> other explicit structure there anyway to get the member names right.
> 
> Actually, thinking a bit more about it, adding a
> 
>     const struct iovec xyzzy;
> 
> member might be a good idea just to avoid a cast. Then that
> iter_ubuf_to_iov() macro becomes just
> 
>    #define iter_ubuf_to_iov(iter) (&(iter)->xyzzy)
> 
> and that looks much nicer (plus still acts kind of as a "code comment"
> to clarify things).

I went down this path, and it _mostly_ worked out. You can view the
series here, I'll send it out when I've actually tested it:

https://git.kernel.dk/cgit/linux-block/log/?h=iter-ubuf

A few mental notes I made along the way:

- The IB/sound changes are now just replacing an inappropriate
  iter_is_iovec() with iter->user_backed. That's nice and simple.

- The iov_iter_iovec() case becomes a bit simpler. Or so I thought,
  because we still need to add in the offset so we can't just use
  out embedded iovec for that. The above branch is just using the
  iovec, but I don't think this is right.

- Looks like it exposed a block bug, where the copy in
  bio_alloc_map_data() was obvious garbage but happened to work
  before.

I'm still inclined to favor this approach over the previous, even if the
IB driver is a pile of garbage and lighting it a bit more on fire would
not really hurt.

Opinions? Or do you want me to just send it out for easier reading


-- 
Jens Axboe

