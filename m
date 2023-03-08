Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A01A6AFD70
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 04:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCHDdk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 22:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjCHDdf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 22:33:35 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0122331B
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 19:33:26 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id kb15so15389442pjb.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Mar 2023 19:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678246406;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GkqujeajDOVGkFJlXH2eTg70d+LtwBvsMGIszeviqrU=;
        b=BiFQ1GA47AR13egNO3EGqB4pIIUWqAJikzXxopNWNKUwrfVgMPSRJmVERVdc7RfgBB
         osmLqnCk9uDgRMu/z8UQizOAUewkWRMPZguSUqKFmmgh0U7OE1+bmKlowlsch0J4tUAl
         W1zVmxfftoaUrVzi8/pnl1BNimXsONp/v+xnhLadicXarF2jWhj8NSkQ63Aqb2vdsxvs
         AR383znsDFsA5XQxBg/l/D+VGJkg4vJrdxb0Bgl7AkRqIRyz0+QChnLqQxe8VtPJZvBi
         D1mQ24ERm9K/yvsHF5W2y1jmChK266LFlVXiToiLIpfWHIzLg7HEMtEqYPHAont75Ual
         fu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678246406;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GkqujeajDOVGkFJlXH2eTg70d+LtwBvsMGIszeviqrU=;
        b=aOZDIJVxQ7Q+nCm5y1rWzSuG/29lfhO2aaYRSZSIoaP5BhgPsnb69+gg1E3nCDxC4o
         Z55EPuBr8CFdyhzHQBGRn+ZCAnxNPEMS3t/JUr9mTZnwEdwOQvG82ljX6UpzUckYV16f
         5wO456DOVzVbxE1WSC0l6cVSX3bqB2jkSj26fR75MODlAB5ajno1osoXIfxS4CL732s/
         LAU6Y/L2PP5ze0zrLcvOvxGphLTNhKUsYWWo7G18u2B19epbF+dciQwMMr4cFL9VMs7i
         WmnOFK627qMgoYa21EL+HKtF7wy4A8sW6b2scHyTSSYhieAopYDNi2ut+vXpjql0Cc0U
         Gu2w==
X-Gm-Message-State: AO0yUKVYmBSrIkah8NofZNxT2OAU8Tja1NeDVU/4stKWJ/NoEDMv5B90
        Uu/NcJZmeAP9j/re9wlMLrpifw==
X-Google-Smtp-Source: AK7set/1m8Y+pGS6qiTpWiZsMNtX9prLeulRjQfjEo+YTJKM6Gh6UIWk1nE0wIc9B1yapFFTBtH47Q==
X-Received: by 2002:a17:902:e5cb:b0:19c:13d2:44c5 with SMTP id u11-20020a170902e5cb00b0019c13d244c5mr18346411plf.3.1678246405928;
        Tue, 07 Mar 2023 19:33:25 -0800 (PST)
Received: from [172.20.4.229] ([50.233.106.125])
        by smtp.gmail.com with ESMTPSA id f6-20020a170902ab8600b0019a7d58e595sm9026879plr.143.2023.03.07.19.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 19:33:25 -0800 (PST)
Message-ID: <30edf51c-792e-05b9-9045-2feab70ec427@kernel.dk>
Date:   Tue, 7 Mar 2023 20:33:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCHSET for-next 0/3] Add FMODE_NOWAIT support to pipes
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230308031033.155717-1-axboe@kernel.dk>
In-Reply-To: <20230308031033.155717-1-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/7/23 8:10?PM, Jens Axboe wrote:
> Curious on how big of a difference this makes, I wrote a small benchmark
> that simply opens 128 pipes and then does 256 rounds of reading and
> writing to them. This was run 10 times, discarding the first run as it's
> always a bit slower. Before the patch:
> 
> Avg:	262.52 msec
> Stdev:	  2.12 msec
> Min:	261.07 msec
> Max	267.91 msec
> 
> and after the patch:
> 
> Avg:	24.14 msec
> Stdev:	 9.61 msec
> Min:	17.84 msec
> Max:	43.75 msec
> 
> or about a 10x improvement in performance (and efficiency).

The above test was for a pipe being empty when the read is issued, if
the test is changed to have data when, then it looks even better:

Before:

Avg:	249.24 msec
Stdev:	  0.20 msec
Min:	248.96 msec
Max:	249.53 msec

After:

Avg:	 10.86 msec
Stdev:	  0.91 msec
Min:	 10.02 msec
Max:	 12.67 msec

or about a 23x improvement.

-- 
Jens Axboe

