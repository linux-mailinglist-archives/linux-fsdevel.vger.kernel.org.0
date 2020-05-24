Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CE41E023F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 May 2020 21:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387992AbgEXTYp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 May 2020 15:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387807AbgEXTYo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 May 2020 15:24:44 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD60C08C5C0
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 May 2020 12:24:44 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 23so7934001pfy.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 May 2020 12:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dgc3lxr2w8bqe7nZRW8lKjFTzqIALZXVaHjKz6zro3w=;
        b=e+VnPB6Ko1789GSjUbC5PBmmKMbZDoprtwNwSYo6Modwe+qUJSLxKRvETyHOsx+iaF
         F2i5yehyv8rgJtaiUIFt0U92bf4Y5FVCL12fqCATHKChX6SYTalfaewnHHp3WxkHY83Q
         7rxj7BdB829+EV8HmJlzz3qXZuE1Kk1rwt9gsxkugR7A/ykv3wiBBXdnq49s4dF9AYiX
         zId1SRMwlerW6+8br+rRS0jlsnjPXnzaG3yvz3afr3UK1+yKvGRZ138GUItgFUZtfaB7
         d0oCLOSKrQttJKYA4jTReghoh6HdrAQrRrEzkzf+s4FT7Fz1DWHL6drtw54iBaSWbMfq
         ICTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dgc3lxr2w8bqe7nZRW8lKjFTzqIALZXVaHjKz6zro3w=;
        b=joTvCOQYp5T7GnBxKO/HWsX5UxCjHbrY/sHFBgmiJGTKVUq/bud8kfcgCTqC2hH3Df
         hmEgZ9UrCoNjnsiRrn1kLtlp90DcjZCUBWlvAXqYokJv6wKm0Iligl7X2eP4hvb4AgZD
         Jpo1c0uvpA8W6krxHe6mssnMQGBdUkN32F8gTdBksHqiP25kYmgPYJITvfA71H2unHKt
         I7LTAU1Oe1y1cZ+dJmSonVEf1+10P5Mub4tBqNhfh/GJ1A1oPVl79o/0fpT/pYThAMb4
         FWNKKUA0ub6rMG8hqlMzs5mZE2yYG62LPJKwK2sZAqEejTLTirzglFC1cpl3eO+YDEDE
         K2tw==
X-Gm-Message-State: AOAM532sHVVyvlEe3vIYrFAYKPwyrvOc/ITo8jj3+WdIli+v1kTxNRZn
        sQuyM2CtmlvYUh9Kk0HPMe/NeQ==
X-Google-Smtp-Source: ABdhPJzxor4BiLVaXHSh4qj7gDp1AJs+eMT8WKofeCCw54L99wJmJlkXn8O1bc5hT4IwWo1ovoT1sw==
X-Received: by 2002:a63:da50:: with SMTP id l16mr22609989pgj.198.1590348284045;
        Sun, 24 May 2020 12:24:44 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:343d:8ab7:4cee:d96f? ([2605:e000:100e:8c61:343d:8ab7:4cee:d96f])
        by smtp.gmail.com with ESMTPSA id g18sm10134116pgn.47.2020.05.24.12.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2020 12:24:43 -0700 (PDT)
Subject: Re: [PATCHSET v2 0/12] Add support for async buffered reads
To:     Chris Panayis <chris@movency.com>, io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20200523185755.8494-1-axboe@kernel.dk>
 <2b42c0c3-5d3c-e381-4193-83cb3f971399@kernel.dk>
 <43ee202c-ffd1-2276-3c8d-7d5201b60684@movency.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ba854ebb-b4d3-1982-9602-61888ba77a5f@kernel.dk>
Date:   Sun, 24 May 2020 13:24:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <43ee202c-ffd1-2276-3c8d-7d5201b60684@movency.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/24/20 3:46 AM, Chris Panayis wrote:
> Yes! Jens & Team! Yes!
> 
> My code has never looked so beautiful, been so efficient and run so well 
> since switching to io_uring/async awesome-ness.. Really, really is a 
> game-changer in terms of software design, control, performance, 
> expressiveness... so many levels. Really, really great work! Thank you!

Thanks! Glad you like it.

-- 
Jens Axboe

