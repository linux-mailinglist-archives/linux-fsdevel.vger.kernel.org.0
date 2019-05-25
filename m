Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 211622A4FA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2019 16:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfEYOut (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 May 2019 10:50:49 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:42879 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfEYOur (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 May 2019 10:50:47 -0400
Received: by mail-pl1-f170.google.com with SMTP id go2so5318652plb.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 May 2019 07:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wn40ioz6D/ofBr/InxEufmSgTF6y/J0sW6EoYlrNtGw=;
        b=XbgCS0+JMTiEwzFME0zeRleXUj2lpEzQQztGWF2YDZ/OneDtnauuaGY5gDfOpl/nF1
         y+nAjh5nI23g5AU2fZ/+mFXqmgJIi0geQBdxnjtRq/ENNAHmOcVjTs5xy8U92SBONl3v
         FQqisWmhxUaOr9RBlYr5fECGH4Yh9OkzOJajVKlIvH8GE+hIhOoLQ/J8vMMZ5FMfnYfc
         BoPihBfQ19CTrCFwnPaaCGv2Nwn+4a0pbkoA+yNB0z24y6A5WOc034j+bPVeNdI03Je0
         xBzbuRJRxA6LkKobgbGF2E0osK3TjFM9b/ie0g70ROmvHOzPuQRnW2LQMDmwPUv++jyJ
         0WQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wn40ioz6D/ofBr/InxEufmSgTF6y/J0sW6EoYlrNtGw=;
        b=EHwAxY0EwI2eYJ8XHaLfgbORFbI9dLFIoYlm9Yv9tqxetoDmKHsXg8rnu1202Z3NN/
         BN8jhqOQSawuhc4VHaz/G3FxbvTByHZjPS5hMhLtdDqt2n1l/JGO7iftjmBKh+MLAeiK
         Ipn7awUX2WcvguhGlIEMOmJnRWC6UDNaalm5OSFXx7oUc7wXUlD5I/FCWdFdMPXc9/d5
         qgDuifCxnoGHXRjgrshNQ1BtAoY0w2w8xHG7+8vVcoSXQ4IjeB6daFupDvLM6rLneYaD
         O6F4+vRlWRTf5MsWpIV9yG3JEMyJa4xB3mZFmP49lelg9FdlFY5cAXHp4Bu5vJNjruUw
         4r4A==
X-Gm-Message-State: APjAAAWKhrPAIX31CIGyT5Yt0aqz/gjGRQS4uf1W+F7ssLe3g2av/qht
        NFSdHfPSjUagy7hmGYdRg9r6gKTU2DdbaA==
X-Google-Smtp-Source: APXvYqzW9av1b5fZ3vpemkhmxSW5eR0sw+F9b09SKHg5ckNM2xWc/jV4ngewhEyMuOshTnmRSNcUKA==
X-Received: by 2002:a17:902:2884:: with SMTP id f4mr83935251plb.230.1558795845870;
        Sat, 25 May 2019 07:50:45 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id h14sm5145589pgj.8.2019.05.25.07.50.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 07:50:44 -0700 (PDT)
Subject: Re: [PATCH -next] io_uring: remove set but not used variable 'ret'
To:     YueHaibing <yuehaibing@huawei.com>, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20190525122904.12792-1-yuehaibing@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <09f261fa-f981-3d2e-9d5c-5f576c3de192@kernel.dk>
Date:   Sat, 25 May 2019 08:50:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190525122904.12792-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/25/19 6:29 AM, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> fs/io_uring.c: In function io_ring_submit:
> fs/io_uring.c:2279:7: warning: variable ret set but not used [-Wunused-but-set-variable]
> 
> It's not used since commit f3fafe4103bd ("io_uring: add support for sqe links")

Some of the submission logic in that commit needs to be reworked, so I'm
not going to fold this patch in.

-- 
Jens Axboe

