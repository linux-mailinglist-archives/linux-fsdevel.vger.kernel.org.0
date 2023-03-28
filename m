Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749536CCA97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 21:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjC1T1h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 15:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjC1T1g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 15:27:36 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9828D359A
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 12:27:34 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id f22so8598265plr.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 12:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680031654; x=1682623654;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yoe83wTu4JiEC2nD57kWaKyFdNwq3IRhPc/h90ghRUM=;
        b=Y2ZF26k6H7LsSWQIOTWNZ/cnifeC3yYN0AxD7Lim/rzV4kSQc/Od1V0WqF5HecDpK1
         6t60QcbkXSn7KYEriXxdZnee3CSO3rtYhwqHWzgGpRDA8inp0XgtjgvK1nJreY0rTCqf
         aLcL4i+741OUax/+C3dUJgN58J0EZHNXwxnFN7/yeZbEP0/2uITehUzw4QteVybFLS8j
         QqsqOqix7swy21P6UwCsCNv/vwRyyDj6UHIahiJxSAzZNaVhWrKhGvlN2bYNLVTubs1X
         bQjnkzkLmsosyJBFTGmpkxgFSTJ6bzYCGxAkhmCUjX5kleYoBBykcN8VWyL5nwk7pGft
         BHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680031654; x=1682623654;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yoe83wTu4JiEC2nD57kWaKyFdNwq3IRhPc/h90ghRUM=;
        b=GsupYq8utNnWSNppUQTzHpf0A6KsYEUMntRbT89JByP6ZFRGpL9VD3HH1sSTVpZRkg
         P+xOZQaz8xcY5EXc11SaHiNWpQUxeVCY04PhPFjcfSZHkZW5kgtu2p4iojsnhHc63rL5
         7N3R1Z+7mPPv11m1Bf4LLY5YPJhX45yTL7a7ZJEGjdH+NNwlRDzC8HQeZjuYv2Rcay3O
         Fk8QOeC3wq15EEQUcD7QDd0Q/fYIYzPVy2uFNsA/e1K+uwxhaNcAk+40wIWT+rVhehSN
         h16FSp7VALj2LhWdpzEL7R8uRyysYtcRY2+MPbn/TwXR88+hHijhU3mlpHQfbPvaZtlC
         XOZQ==
X-Gm-Message-State: AAQBX9dEVBZRJmL2cmsj7WwMJgMeFOgS0fuFhtgX7IaqffWdqX4J138p
        ezVZhhHQwd+F8xKpw1jnzy7p9Q==
X-Google-Smtp-Source: AKy350ZngWPeQURhxkfQ4ZeTDsrKiHyRIPgDVfvzNcAIyfDL5KyNEtKqpdTppyGYYdYaq1/9KNodpA==
X-Received: by 2002:a17:90a:c296:b0:23b:4bce:97de with SMTP id f22-20020a17090ac29600b0023b4bce97demr14286197pjt.4.1680031653898;
        Tue, 28 Mar 2023 12:27:33 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s19-20020a170902989300b00186cf82717fsm21508365plp.165.2023.03.28.12.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 12:27:33 -0700 (PDT)
Message-ID: <8f36e443-e072-3c85-4ff9-b76476d7b98f@kernel.dk>
Date:   Tue, 28 Mar 2023 13:27:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/8] iov_iter: add iovec_nr_user_vecs() helper
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        brauner@kernel.org
References: <20230328173613.555192-1-axboe@kernel.dk>
 <20230328173613.555192-3-axboe@kernel.dk> <20230328184220.GL3390869@ZenIV>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230328184220.GL3390869@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/28/23 12:42 PM, Al Viro wrote:
> On Tue, Mar 28, 2023 at 11:36:07AM -0600, Jens Axboe wrote:
>> This returns the number of user segments in an iov_iter. The input can
>> either be an ITER_IOVEC, where it'll return the number of iovecs. Or it
>> can be an ITER_UBUF, in which case the number of segments is always 1.
>>
>> Outside of those two, no user backed iterators exist. Just return 0 for
>> those.
> 
> Umm...  Why not set ->nr_segs to 1 in iov_iter_ubuf() instead?  Note that
> it won't be more costly; that part of struct iov_iter (8 bytes at offset 40
> on amd64) is *not* left uninitialized - zero gets stored there.  That way
> you'll get constant 1 stored there, which is just as cheap...

Good point, let's have a prep patch that does that too.

-- 
Jens Axboe


