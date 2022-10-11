Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62185FAAC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 04:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiJKCyh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 22:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJKCyf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:54:35 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C388681E
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Oct 2022 19:54:34 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 3so10768649pfw.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Oct 2022 19:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VTK7B6DCScPAPU4kCXDLhpTXXn0/7k1H7IMWkY/AN/Q=;
        b=1Z6t8CrNsCSmpx9yA7rcdYroTGqbpG2oFuWoSs1SsFraaXunubMPGAJe5XbNeQLiyx
         DoGnyy3JOdahLpGb0syE3dj4QWya4xtmyaf0SN7yOPWTwvvWrEdrDQt69PbL6PDnYEde
         i3sLcORg0BV0zOClmo0NK7+Hqr4Z2v402NY3szvkWhQEFDj75yt5KicdFki8ZQEUJx5k
         VekyAeVSoIjWf0pqSCtZtVAu+sWpN5SzHAepdYDU0CmtX+3noVwun7zTr3kFx6wATnL3
         v2IPG4fevCVnOBx8plIaNqHww5+dE1nwv8nlY/Y3EgrSomI+rtqHJqPiZYlz3d4S3LMi
         C3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VTK7B6DCScPAPU4kCXDLhpTXXn0/7k1H7IMWkY/AN/Q=;
        b=hWqw2PcZ+o2qDm3p4hfNW5nhnSPf6LE4u2Am1fnEMuZfkKHTxU+DuqXmbT9h4NNl6J
         N84EhR547V8xl3tgdAJ8aPYAp1EvQwXocp7Kl+Uy8jvvCBtU6oPIKmjNQOelQ31blYzK
         HnBACA14A0TQfm7HK0mhNncGmFSEyYqaKsepMc1WGhbOj11jOfm7TMmGmR9dCjdlsGuB
         3HUbqk3BRhXUaaA/wTxoNv9Ittln5QYPkzVmZgpPWS/pXu1hnn+eHVu+F24eQKRjpipo
         REfF40ygKIQd00uAdOYHG/8rpCQ4mnH/JRKyjlR3enJRSQl6jxmNTSataShZM7fBjybw
         M1rg==
X-Gm-Message-State: ACrzQf1+smUWGau+jSmGzmrJth0JeZaJpE0g4Wg9vvrS3pVyiIwUTtjv
        Kf/cKNjl6uj4uwi9zuSQla3W6A==
X-Google-Smtp-Source: AMsMyM42r+iyJKP47fvd4foFhr+NDCne0uTseZEAZJc/sMI89iNYEiKglULcJsZ74JVQQtGByfFJXQ==
X-Received: by 2002:a63:df10:0:b0:43b:e82f:e01c with SMTP id u16-20020a63df10000000b0043be82fe01cmr19486369pgg.19.1665456873246;
        Mon, 10 Oct 2022 19:54:33 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u11-20020a654c0b000000b0044ba7b39c2asm6790629pgq.60.2022.10.10.19.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 19:54:32 -0700 (PDT)
Message-ID: <fbec411b-afd9-8b3b-ee2d-99a36f50a01b@kernel.dk>
Date:   Mon, 10 Oct 2022 20:54:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [regression, v6.0-rc0, io-uring?] filesystem freeze hangs on
 sb_wait_write()
Content-Language: en-US
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Dave Chinner <david@fromorbit.com>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
References: <20221010050319.GC2703033@dread.disaster.area>
 <20221011004025.GE2703033@dread.disaster.area>
 <8e45c8ee-fe38-75a9-04f4-cfa2d54baf88@gmail.com>
 <697611c3-04b0-e8ea-d43d-d05b7c334814@kernel.dk>
 <db66c011-4b86-1167-f1e0-9308c7e6eb71@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <db66c011-4b86-1167-f1e0-9308c7e6eb71@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/10/22 8:10 PM, Pavel Begunkov wrote:
> On 10/11/22 03:01, Jens Axboe wrote:
>> On 10/10/22 7:10 PM, Pavel Begunkov wrote:
>>> On 10/11/22 01:40, Dave Chinner wrote:
>>> [...]
>>>> I note that there are changes to the the io_uring IO path and write
>>>> IO end accounting in the io_uring stack that was merged, and there
>>>> was no doubt about the success/failure of the reproducer at each
>>>> step. Hence I think the bisect is good, and the problem is someone
>>>> in the io-uring changes.
>>>>
>>>> Jens, over to you.
>>>>
>>>> The reproducer - generic/068 - is 100% reliable here, io_uring is
>>>> being exercised by fsstress in the background whilst the filesystem
>>>> is being frozen and thawed repeatedly. Some path in the io-uring
>>>> code has an unbalanced sb_start_write()/sb_end_write() pair by the
>>>> look of it....
>>>
>>> A quick guess, it's probably
>>>
>>> b000145e99078 ("io_uring/rw: defer fsnotify calls to task context")
>>>
>>>  From a quick look, it removes  kiocb_end_write() -> sb_end_write()
>>> from kiocb_done(), which is a kind of buffered rw completion path.
>>
>> Yeah, I'll take a look.
>> Didn't get the original email, only Pavel's reply?
> 
> Forwarded.

Looks like the email did get delivered, it just ended up in the
fsdevel inbox.

> Not tested, but should be sth like below. Apart of obvious cases
> like __io_complete_rw_common() we should also keep in mind
> when we don't complete the request but ask for reissue with
> REQ_F_REISSUE, that's for the first hunk

Can we move this into a helper?

-- 
Jens Axboe


