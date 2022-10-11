Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CCB5FB4E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 16:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiJKOrZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 10:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiJKOrY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 10:47:24 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4886358B5F
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Oct 2022 07:47:22 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id w2so13781686pfb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Oct 2022 07:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iohUTW6Vhnk6wO1nlG13FT7j9MtQn1aKVQlxnQ0foKI=;
        b=5/p8W8eXWlfvugtxyn9yrgFpd3HW3NVRg77MYgORbXCzvopvn4WpbKWuD3BvnXUtqe
         MgNhc03MLkYHlRmxyGsp73tVRPQKfedHR1cVOTWT9nn3+6uO5zChKD9Mbr9rWjnoxEtR
         c41xTh8+TOAvihouPbNk4qh1cajO5OK/KBEPwuCjoPoO42VAW6ahYwBi962V+pQzkkG+
         R8SZcNWYUgW5ZTpsPrIvbzVxRhZiZtIdXkuSNdqls3hE37nwz4Amt3BQkNp2ly9P3IVn
         R8mX58SRIlOF3gsEcWi/AR4D5KSfTujHUB4HdnDVi6LCVk8yG/5ZMQ+wJoRqKMj7/jOA
         e5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iohUTW6Vhnk6wO1nlG13FT7j9MtQn1aKVQlxnQ0foKI=;
        b=FP9r62TSLxBMo1igDuGU97dLdRE2yI4bllOd8p5PnGxoE1v/CeVPk/moWuP1Cp4YJn
         vJAwCQHI1MEEFYULp2ZFNs/B5ZiHBC5sAXo8eTgR4r5IAn5aM4xk1HT2/0+1f6tkome+
         itbcLMUCj12Xf9aay3ra8K684FlOYYWrjW3Ng4xyva4vscIbCXlwSikn8BjDjQiumfQ0
         sdTUMZw1uit2R5QXnBaAZy1MlYUL0TIosGHzFsEqcTmpQ+03NC8fx7xuyznoUe0lxioG
         DTfdkqxJvc/1eIPfkh2NPk8xGTynMgDUaI63YzDhHcFtRUHR1MeakBe8sfQvv9jFQm2w
         2oXA==
X-Gm-Message-State: ACrzQf32G8NLmUDj3uKJdh2UuA40H+u0QcJLOa8e/y5A7V2LEMU2gsxY
        FUJk3SEBHJ4yDTt0OVuhqxvPAStxn2JiMNbo
X-Google-Smtp-Source: AMsMyM7ey+P+S2vJ9wHedtkWSlnFfH2DR+qnVxQl7z3GYlu8xK+vfu0J/e0CE9SbnyvcrXm2QT84bw==
X-Received: by 2002:a63:6cca:0:b0:43c:7998:8a78 with SMTP id h193-20020a636cca000000b0043c79988a78mr21067887pgc.600.1665499641698;
        Tue, 11 Oct 2022 07:47:21 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id o3-20020a17090a4e8300b001fdbb2e38acsm11645368pjh.5.2022.10.11.07.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 07:47:21 -0700 (PDT)
Message-ID: <225b2df5-3160-a85c-dba5-e10678d5ab9a@kernel.dk>
Date:   Tue, 11 Oct 2022 08:47:20 -0600
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
 <fbec411b-afd9-8b3b-ee2d-99a36f50a01b@kernel.dk>
 <1941f3d3-5b7a-7b87-cc53-382cac1647d6@kernel.dk>
 <3aa0d616-58cc-5a3f-3662-149c089cd6b9@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <3aa0d616-58cc-5a3f-3662-149c089cd6b9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/11/22 8:39 AM, Pavel Begunkov wrote:
> On 10/11/22 15:18, Jens Axboe wrote:
>> On 10/10/22 8:54 PM, Jens Axboe wrote:
>>> On 10/10/22 8:10 PM, Pavel Begunkov wrote:
>>>> On 10/11/22 03:01, Jens Axboe wrote:
>>>>> On 10/10/22 7:10 PM, Pavel Begunkov wrote:
>>>>>> On 10/11/22 01:40, Dave Chinner wrote:
>>>>>> [...]
>>>>>>> I note that there are changes to the the io_uring IO path and write
>>>>>>> IO end accounting in the io_uring stack that was merged, and there
>>>>>>> was no doubt about the success/failure of the reproducer at each
>>>>>>> step. Hence I think the bisect is good, and the problem is someone
>>>>>>> in the io-uring changes.
>>>>>>>
>>>>>>> Jens, over to you.
>>>>>>>
>>>>>>> The reproducer - generic/068 - is 100% reliable here, io_uring is
>>>>>>> being exercised by fsstress in the background whilst the filesystem
>>>>>>> is being frozen and thawed repeatedly. Some path in the io-uring
>>>>>>> code has an unbalanced sb_start_write()/sb_end_write() pair by the
>>>>>>> look of it....
>>>>>>
>>>>>> A quick guess, it's probably
>>>>>>
>>>>>> b000145e99078 ("io_uring/rw: defer fsnotify calls to task context")
>>>>>>
>>>>>> ?From a quick look, it removes? kiocb_end_write() -> sb_end_write()
>>>>>> from kiocb_done(), which is a kind of buffered rw completion path.
>>>>>
>>>>> Yeah, I'll take a look.
>>>>> Didn't get the original email, only Pavel's reply?
>>>>
>>>> Forwarded.
>>>
>>> Looks like the email did get delivered, it just ended up in the
>>> fsdevel inbox.
>>
>> Nope, it was marked as spam by gmail...
>>
>>>> Not tested, but should be sth like below. Apart of obvious cases
>>>> like __io_complete_rw_common() we should also keep in mind
>>>> when we don't complete the request but ask for reissue with
>>>> REQ_F_REISSUE, that's for the first hunk
>>>
>>> Can we move this into a helper?
>>
>> Something like this? Not super happy with it, but...
> 
> Sounds good. Would be great to drop a comment why it's ok to move
> back io_req_io_end() into __io_complete_rw_common() under the
> io_rw_should_reissue() "if".

Agree, I'll add a comment and post this.

-- 
Jens Axboe


