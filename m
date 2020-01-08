Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA68134FB3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 23:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgAHW5g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 17:57:36 -0500
Received: from mail-pl1-f173.google.com ([209.85.214.173]:35165 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgAHW5g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 17:57:36 -0500
Received: by mail-pl1-f173.google.com with SMTP id g6so1723148plt.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jan 2020 14:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bpPCbAJa1IcpQ/BKglIrE/G9FMUvgzgoLTtjr58Kpes=;
        b=T4chxXWBBYBoNXdkc4bOzCRfQjpMYC+LUU4KWZpbQCUXglGNLND7/4bxicsi2Fl2Hh
         jd/dxEg5sdXdlivTogVngtASpIp8KOACMvqOTFBwwrT6KSrhULuc67xq06Bexfn6vJcc
         hsH79etcrhOsB73Iped7R4KUFkJS2Sjy1rZld1vBeEpwmPAw1Q4bXRxaq542nG83Ut4P
         3gYxPbMdfGpAs4i7mWuTUVhke5J+L06FNrN9UJBm7KdWeTD0sklP5cw33ajMQUON+P+c
         gJqyPbUYTz91Su/Kq0UvkDGc17qA6vTEtT64FLnp/RjSpySWtlMf/pJR0f/i8H+kGo+Q
         FXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bpPCbAJa1IcpQ/BKglIrE/G9FMUvgzgoLTtjr58Kpes=;
        b=MeGOT9y1Odk2872Ug7m/663NfZFWTrYAkAaxREOUKJMwoAdY2XhIzaAg8/k/JnTo2h
         rHANm4qVU1mK1QRlF60pGtk9/3sMZCC5oVX5GcKSVmzR0epQsBIt8XDmmcdObTXqC8Be
         XZI3nySFCvnDN/Ba5oysEbmF/F1T0PZ4mujWJJOJQMX3r+qxf+jLZ4LQAs/B7hraalBj
         J4/ivy9cyncrWrY1inbK28xFiZto0HLPsVf7+++0/y9YqeeG0yJx+laDLV7EQHnYn/VT
         hVPQK0f/XGpaNaxK6ADB95SghGWEblwpfwfz/9T+g00Nx7F7AOfxDJnYLQpu9mkoC25/
         RImQ==
X-Gm-Message-State: APjAAAU3uaY3Cf4zjLW1USkEZ/F4zCUTw3QtNfCUuonqmgonsgnGy65E
        1Zhb9C46e2Os8Ys6Obi01hy3o33SIKw=
X-Google-Smtp-Source: APXvYqyh699orD7W2qSj1cbAReNTvf3JT/+qUZTnCA6QQpTwmAwvNf7e69hREJv/07demO/MRK/Ksg==
X-Received: by 2002:a17:90a:6346:: with SMTP id v6mr1229865pjs.51.1578524255383;
        Wed, 08 Jan 2020 14:57:35 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id n24sm3741664pff.12.2020.01.08.14.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 14:57:34 -0800 (PST)
Subject: Re: [PATCHSET v2 0/6] io_uring: add support for open/close
To:     Stefan Metzmacher <metze@samba.org>, io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <20200107170034.16165-1-axboe@kernel.dk>
 <e4fb6287-8216-529e-9666-5ec855db02fb@samba.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4adb30f4-2ab3-6029-bc94-c72736b9004a@kernel.dk>
Date:   Wed, 8 Jan 2020 15:57:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <e4fb6287-8216-529e-9666-5ec855db02fb@samba.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/8/20 2:17 PM, Stefan Metzmacher wrote:
> Am 07.01.20 um 18:00 schrieb Jens Axboe:
>> Sending this out separately, as I rebased it on top of the work.openat2
>> branch from Al to resolve some of the conflicts with the differences in
>> how open flags are built.
> 
> Now that you rebased on top of openat2, wouldn't it be better to add
> openat2 that to io_uring instead of the old openat call?

The IORING_OP_OPENAT already exists, so it would probably make more sense
to add IORING_OP_OPENAT2 alongside that. Or I could just change it. Don't
really feel that strongly about it, I'll probably just add openat2 and
leave openat alone, openat will just be a wrapper around openat2 anyway.

-- 
Jens Axboe

