Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0577E4E36E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 03:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbiCVCvk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 22:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbiCVCvj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 22:51:39 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879604F473
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Mar 2022 19:50:12 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w8so14305166pll.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Mar 2022 19:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=B5PNzgEcp6v2BJNLNi+4zg0srfxRDwNVS+rv1yOEHhM=;
        b=vj3/jlOn1LkH2HdLUqdcTTxwa6jaGU2l8TDVIsP3ihBANaw05026klx9iMCtyYSnAR
         pXqdnfaewG5sMETf6wwYujb/6IZQAme5CwOSX+dVqEWmrGnMiY0GVZQ7YKeMS7BSoEI5
         GVU4SpDC0dHxyunR556FFjyY9y1i26DC+qMReDfFfWsXNlzkgmTUSW6vOhqiEb2dJynP
         a0WuKlUCBtiEe3lfbw3DsYEGcIWRepZkrNmA8sVzty4AUWrIXDP7urA9XnWx1ZZA2wxJ
         IKv2E39Kvex9JT0z3kxxnoIMHwzalgfAxiE1ejEPlH7TNHqr7oLkMf2XKlXyR/Prt4b2
         oLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B5PNzgEcp6v2BJNLNi+4zg0srfxRDwNVS+rv1yOEHhM=;
        b=UBWOuWSDhlwlhbegXETbQ1pYiBEPVngES9V3VhxZmJe8inculWKtTdlRLMQRTbltxe
         P8CH6nI+NtprBEaQVJ2iR9hwFIpTgS/3UWxarSjIXySVvY5YpfInaRe4kQhvbbol+iEI
         JU5hR+sh9X6oyVagYh01SJOlL4IXV8oNj9YdG/EDjtL5duWSLXbyDVMN+TZLbvM4OAHU
         xtxMulzeOfk9uBvIo6dbMkw3KRPBgTSOLeaBHp9ejQgf3tD+6ocbY2+Zeo7WOMfCV+CH
         nFTKfzOMEqQaXHSEQt6QZKe/Uxtk2a8JQWT1URSliGisPTLeVWzj1s/YAY2zg60S/ZrQ
         kgig==
X-Gm-Message-State: AOAM531mTMfH51lzg4rdDWD2qIoAhCGJqhALSb335ONCk8czgJzgyssp
        woPTm3Cy5Ldto0Xjy9crTJ7uwg==
X-Google-Smtp-Source: ABdhPJxnuAF867GdXqEmx0nbN2+jkI3LMCHKy+NOZAM2KjlwF9N/SMN/gmIFMS5eSeojO0P29YG02A==
X-Received: by 2002:a17:90a:a591:b0:1bc:8015:4c9e with SMTP id b17-20020a17090aa59100b001bc80154c9emr2393380pjq.154.1647917411931;
        Mon, 21 Mar 2022 19:50:11 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c18-20020a056a000ad200b004f0f9696578sm23169678pfl.141.2022.03.21.19.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 19:50:11 -0700 (PDT)
Message-ID: <d4fe91bf-5285-862d-4c2c-219161daec26@kernel.dk>
Date:   Mon, 21 Mar 2022 20:50:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] fs: remove kiocb.ki_hint
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220308060529.736277-1-hch@lst.de>
 <20220308060529.736277-2-hch@lst.de>
 <164678732353.405180.15951772868993926898.b4-ty@kernel.dk>
 <d28979ca-2433-01b0-a764-1288e5909421@kernel.dk>
 <Yjk4LNtLLYOCswC3@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yjk4LNtLLYOCswC3@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/21/22 8:45 PM, Matthew Wilcox wrote:
> On Mon, Mar 21, 2022 at 08:13:10PM -0600, Jens Axboe wrote:
>> On 3/8/22 5:55 PM, Jens Axboe wrote:
>>> On Tue, 8 Mar 2022 07:05:28 +0100, Christoph Hellwig wrote:
>>>> This field is entirely unused now except for a tracepoint in f2fs, so
>>>> remove it.
>>>>
>>>>
>>>
>>> Applied, thanks!
>>>
>>> [1/2] fs: remove kiocb.ki_hint
>>>       commit: 41d36a9f3e5336f5b48c3adba0777b8e217020d7
>>> [2/2] fs: remove fs.f_write_hint
>>>       commit: 7b12e49669c99f63bc12351c57e581f1f14d4adf
>>
>> Upon thinking about the EINVAL solution a bit more, I do have a one
>> worry - if you're currently using write_hints in your application,
>> nobody should expect upgrading the kernel to break it. It's a fine
>> solution for anything else, but that particular point does annoy me.
> 
> But if your application is run on an earlier kernel, it'll get
> -EINVAL. So it must already be prepared to deal with that?

Since support wasn't there, it's not unreasonable to expect that an
application was written on a newer kernel. Might just be an in-house or
application thing, who knows? But the point is that upgrading from 5.x
to 5.x+1, nobody should expect their application to break. And it will
with this change. If you downgrade a kernel and a feature didn't exist
back then, it's reasonable to expect that things may break.

Maybe this is being overly cautious, but... As a matter of principle,
it's unquestionably wrong.

We can just let Linus make the decision here, arming him with the info
he needs to make it in terms of hardware support. I'll write that up in
the pull request.

-- 
Jens Axboe

