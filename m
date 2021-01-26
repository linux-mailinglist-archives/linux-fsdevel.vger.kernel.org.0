Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13213034BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 06:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732735AbhAZF0m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732035AbhAZBex (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:34:53 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7ACC0698D2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 17:31:27 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id n25so10216094pgb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 17:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+rOSxpCfLAi+4QJn/ZTJAaummeegtELcLiTveho04CI=;
        b=UWaIPOZf1DpySwiZueylaccUXpXV1AN3+j8atad1KjzH/D/RpVZ5l3hlQX/v5oUmQH
         d3rRICZorJEri3Z9iIv8Xy9j5+GmIpUwhq5XlDgIEQNezEsvAJ5QySUzt0YkAtJi7FJg
         2hPIkp5ch6/wxqNbXuDfRqo7R3JqhVBrINHt8DA1I77ZyirpwmrEaAjeD0wRhdpUwD1T
         TrWsXqb3WJttrUzvpgMj24wvmEwzfpnvTCjaS8iJWpHf4foo1y3yODbwm8wIP8PM5GoO
         JAyLjYIzmMIJq6RfbD8giu3rLNshfBq49R0FHmCJ2Y+H31acHyUXjvJkjxdMmMSE64cC
         Q3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+rOSxpCfLAi+4QJn/ZTJAaummeegtELcLiTveho04CI=;
        b=ou3NI00Evc3P5EjHq5rxwtV0XEwoe+jk6EXBGllAVmqq37GsQ2uF6hpkJREmc1Vhd6
         v5pF0UWRMxOfCyeMYI2K79k2PlDmtTpRz9VZlW7mqNAOtxTUkpPSNAv/nFlSQbn1mNby
         yUzD94rhBzCMpxsSU1ZoML/u36gcsr4bpXub8Ylxehgr8t5887Su+Vm70PH2Gsmfq6EY
         PZDet0lBajykLQkF/pw7J2LXckHegAz/bqFPJnc0hs40PLvW2daW382VHnfSRoziyCuM
         c4uDZur7klz+VKWUWXbDYHdnpxv+BogfyLnUk2Shr4/IpFQTT4NzQ2gQoLVeK71BNNj1
         98Vw==
X-Gm-Message-State: AOAM530cEW1ssc1ek8jEpnjBfphHcy9NEH67kj4xkTSMCfEA5fCxj1Hr
        dLWxTlNOi/4g5Pn98cZxLruEKQ==
X-Google-Smtp-Source: ABdhPJw/yNerFPWKVzIuL4CAI1D9Rd3HaYaJUu8ucVQX0KM9Vcty8CEowP26G39ZecukCySc5mtwJg==
X-Received: by 2002:a62:445:0:b029:19c:162b:bbef with SMTP id 66-20020a6204450000b029019c162bbbefmr2932755pfe.40.1611624686612;
        Mon, 25 Jan 2021 17:31:26 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id i1sm18858666pfb.54.2021.01.25.17.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 17:31:25 -0800 (PST)
Subject: Re: [PATCHSET RFC] support RESOLVE_CACHED for statx
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20210125213614.24001-1-axboe@kernel.dk>
 <CAHk-=whh=+nkoZFqb1zztY9kUo-Ua75+zY16HeU_3j1RV4JR0Q@mail.gmail.com>
 <4bd713e8-58e7-e961-243e-dbbdc2a1f60c@kernel.dk>
 <CAHk-=wgdL-5=7dxpertTre5+3a5Y+D7e+BJ2aVb=-cceKKcJ5w@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <add91ec9-da8f-1eed-5c54-c94281b5ca99@kernel.dk>
Date:   Mon, 25 Jan 2021 18:31:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgdL-5=7dxpertTre5+3a5Y+D7e+BJ2aVb=-cceKKcJ5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/25/21 6:28 PM, Linus Torvalds wrote:
> On Mon, Jan 25, 2021 at 5:06 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Which ones in particular? Outside of the afs one you looked a below,
>> the rest should all be of the "need to do IO of some sort" and hence
>> -EAGAIN is reasonable.
> 
> Several of them only do the IO conditionally, which was what I reacted
> to in at least cifs.
> 
> But I think it's ok to start out doing it unconditionally, and make it
> fancier if/when/as people notice or care.

Agree, that was the point I was trying to make in the reply. I'd rather
start simpler and talk to folks about improving it, looping in the
relevant developers for that. I'll leave it as-is for now, modulo the
afs one which was definitely just a mistake.

-- 
Jens Axboe

