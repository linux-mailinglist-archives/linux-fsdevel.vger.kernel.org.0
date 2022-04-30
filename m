Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9E7515D8B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Apr 2022 15:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382727AbiD3Nai (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Apr 2022 09:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382722AbiD3Nah (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Apr 2022 09:30:37 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F6E36313
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Apr 2022 06:27:15 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o69so7919115pjo.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Apr 2022 06:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oCzWgWhhG7IWlDHkgweCLD8r25SvqJ41BjsLlfD+agc=;
        b=WLndbh79Pv5SNg8DK8nNF3XTxXb4916n15htOIRK+dLom00X4DHQK8aEbj1TwjiyGy
         uJqnz7des0BNwWrGA5r3wSLRJTg4PDz/bSMDEeTVcMc3nAzg7cjPtxPT6n7ELnkM5ZLC
         jU1tFwFkLOSNg+Ddk8RyBZ74EE5MmLS72gnghffxVEilAsLc8i9RmbB0Ih01mHBSlJA1
         bF0SH75cbBJHrw27r1g9xWPDrEn/tvM3siGr+G4k0ErWtNrZ1cYp3Q5r1L3BYMlveYV4
         GVwMNcPkd2ySCT8YT8FRH5beDo1i1r9xY05VF4MSGGE2NKa5Ol8QRMhbfoiygPb5ukK6
         fUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oCzWgWhhG7IWlDHkgweCLD8r25SvqJ41BjsLlfD+agc=;
        b=YkA9dKOSQRI/JJom6MSqROOhc4R4qA4Ng+aUc8AzFC0PHgLr2U7gV7y350e6yGR6k/
         dDpaX0xap05E4NymBsC6QFW4tQbk3J3qx+t2cUNAmEYTs+a4KtBO7aUKKTd2zYLczyzG
         kf05RB8XrAOJx6aFjbjtX4fJa+Jid7kUgRx7ftPz5jEqw43wCEAy3JWJvR2nnrCH+Uwv
         JiRPJjr/c2BoVEe/HIM/3rb07JwqPndz/u4A17PKqgK8F3SPIn8iARHkUJjBtJO9kh1R
         pITf5J3Bp2bqc4B8eWbNkrZ2DI47S+SOpBtb+N9TWPdH8zr+pckx0vRYBTi8Nnw88qsJ
         JItA==
X-Gm-Message-State: AOAM530rOE1BQQqqbN2p64Z6a36G7PKbQ3P+86zOKIKcQ0U9yA9dWWBn
        G4gVVZ2a43QMsVFOJUygovH7uQ==
X-Google-Smtp-Source: ABdhPJyoZXoUeWNbVxt926XEaxMdZ9eiVvwyjxDOMovIluronLbzZA9Kp3RQvuXCK5E6r0FoMJ8UlA==
X-Received: by 2002:a17:902:9005:b0:156:8a9d:ba49 with SMTP id a5-20020a170902900500b001568a9dba49mr3922744plp.42.1651325234978;
        Sat, 30 Apr 2022 06:27:14 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v12-20020a17090331cc00b0015e8d4eb247sm1439220ple.145.2022.04.30.06.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Apr 2022 06:27:14 -0700 (PDT)
Message-ID: <015f58ed-09c1-cd27-064a-b6c0cc5580d2@kernel.dk>
Date:   Sat, 30 Apr 2022 07:27:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 7/9] io-wq: implement fixed worker logic
Content-Language: en-US
To:     Hao Xu <haoxu.linux@gmail.com>, io-uring@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220429101858.90282-1-haoxu.linux@gmail.com>
 <20220429101858.90282-8-haoxu.linux@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220429101858.90282-8-haoxu.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/29/22 4:18 AM, Hao Xu wrote:
> @@ -1030,6 +1101,7 @@ static bool io_wq_work_match_item(struct io_wq_work *work, void *data)
>  static void io_wqe_enqueue(struct io_wqe *wqe, struct io_wq_work *work)
>  {
>  	struct io_wqe_acct *acct = io_work_get_acct(wqe, work);
> +	struct io_wqe_acct *fixed_acct;
>  	struct io_cb_cancel_data match;
>  	unsigned work_flags = work->flags;
>  	bool do_create;
> @@ -1044,8 +1116,14 @@ static void io_wqe_enqueue(struct io_wqe *wqe, struct io_wq_work *work)
>  		return;
>  	}
>  
> +	fixed_acct = io_get_acct(wqe, !acct->index, true);
> +	if (fixed_acct->fixed_worker_registered && !io_wq_is_hashed(work)) {
> +		if (io_wqe_insert_private_work(wqe, work, fixed_acct))
> +			return;
> +	}
> +

As per previous email, I was going to comment back saying "why don't we
just always do hashed work on the non-fixed workers?" - but that's
already what you are doing. Isn't this fine, does anything else need to
get done here in terms of hashed work and fixed workers? If you need
per-iowq serialization, then you don't get a fixed worker.

-- 
Jens Axboe

