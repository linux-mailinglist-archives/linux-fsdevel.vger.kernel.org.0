Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFCCA219693
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 05:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgGIDZH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 23:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgGIDZG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 23:25:06 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C3FC08C5DC
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 20:25:06 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mn17so464220pjb.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 20:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=deFlbzkfMfRMfRuQ/QU9968LuaI6fXYErNVqNwLy8as=;
        b=XfXxLQhprQL4NnAPivi9oxxga+lkbU6keLLx0IU9ns311y+Px8w7PHpAvp64BESVN1
         kApTUyFPpte5GFuHFeS/tqgxuf+JfeKB/NfsCfL4/Q7xLCmt77fIxD8L1nsveweR5Z3U
         stZYA/J8PALWqAOyibX4wC/1mOzF7QgXrVOfRcKrsGPN+zRi5kVsmiu/7GSmraV76z1u
         9ZTiQ1RhmoRrRMw6K/K2zqK3S1fpXNCaMYko6BfG9diP84SEITRpvXXOBEAMHkSzA6Bn
         Z8NbKFFJdzezBHtv/nlht3avdMXFd1UzEOBG0W8I0Mpfku36kQjtIxFh7Q/lo58UxnOj
         k9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=deFlbzkfMfRMfRuQ/QU9968LuaI6fXYErNVqNwLy8as=;
        b=RnVGhOznxNFMv7j9yXrL2Nc7UIDT5lOn4aCm9xRYDzGiG0yxWHkOMGBvNvS85sSShG
         D5pm8HidEa4KYTpxgQoKeGyeqBbTNbpTlAB5XAAMML3iSVe9W5nWUBH9XByIlpyLR0PG
         TB8u9g9tANwx8Iy0v8xrA3jMan1flsACW52js8PJe1dNMRC0BNL9JodCEg/5D/9kLMaf
         teDTLu+0FwQpm60HqDhpcAf8/4S6fyedc04jsh84wNR0SaRujk8N40zljHoC5AbrvtIt
         fMfD5BBThLAGknWuEWhtxnL7hWcNzdK+lRFdaNA1VR5bXyfck4I3hDK1ZqjTvS4LNYb1
         gVtw==
X-Gm-Message-State: AOAM532/TW9btp0SfeE2VFLIOPe6U/vztiNo0k2keC1SRw2BauCRpx7d
        4eLNN3A5LqxO0jroJvW16hKG6Q==
X-Google-Smtp-Source: ABdhPJz560zuzQ7gzwQLW5ElxrPuuMfP9mKyVDEbkWsInO/9g2BC0r+xIW94+9fByxAUgBsOGZ5Jmw==
X-Received: by 2002:a17:90b:4005:: with SMTP id ie5mr12867035pjb.147.1594265105583;
        Wed, 08 Jul 2020 20:25:05 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id y198sm1043506pfg.116.2020.07.08.20.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 20:25:04 -0700 (PDT)
Subject: Re: [PATCH 2/2] fs: Remove kiocb->ki_complete
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
References: <20200708222637.23046-1-willy@infradead.org>
 <20200708222637.23046-3-willy@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a0d5c015-1985-280e-2253-8e2663b234e9@kernel.dk>
Date:   Wed, 8 Jul 2020 21:25:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708222637.23046-3-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/8/20 4:26 PM, Matthew Wilcox (Oracle) wrote:
> +void unregister_kiocb_completion(int id)
> +{
> +	ki_cmpls[id - 1] = NULL;
> +}
> +EXPORT_SYMBOL(unregister_kiocb_completion);

This should have a limit check (<= 0 || > max).

>  void complete_kiocb(struct kiocb *iocb, long ret, long ret2)
>  {
> -	iocb->ki_complete(iocb, ret, ret2);
> +	unsigned int id = kiocb_completion_id(iocb);
> +
> +	if (id > 0)
> +		ki_cmpls[id - 1](iocb, ret, ret2);
>  }

I'd make id == 0 be a dummy funciton to avoid this branch.

-- 
Jens Axboe

