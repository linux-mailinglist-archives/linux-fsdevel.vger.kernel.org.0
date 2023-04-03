Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8BD6D4EDA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 19:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjDCRX3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 13:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjDCRX2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:23:28 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D07E8
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 10:23:27 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-752fe6c6d5fso15688539f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Apr 2023 10:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680542607;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A/nI5JWy9mUPr82eH0AjqX9FtVEyGufsuFLMvj5t4Ss=;
        b=4Zc/L8B2yxQLaI0T6zL5zcZWurE2XU68unwnsycaVpjCXUBwZ0xLkIgDjV8zh5CzFw
         DUkT/q9Jo82KNxxuqurjRwPn0N/LfXgtCl9dXZtsvnITZlnQMali+jrH3Az2oqLSVBxh
         O4PsmEELnTLa6VAp0+s2+sr+0t93txpqqQONHhGTRjwPHw+BUU+j1NHS1MnJGUZjAfVj
         dH98tMcafsQx1eZn2nY8MlZUH0+5/yMx6rEHBUMixvqhmy9VPs1mnCcWGsrgqjv/FC1S
         l2tPf180LoaskiMjZ2IgcUKOzzE9j5DjsYADJbuze4GoVOKP/hlHSXYhmyNBT9WBfQDN
         tteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680542607;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A/nI5JWy9mUPr82eH0AjqX9FtVEyGufsuFLMvj5t4Ss=;
        b=DK05l6pMTmDG6Kooor+yH3LTGPHD3GOTXZqMh/YAXONMYrK/4F8KNl8Qs32WhO8qfW
         DzIIOPVrsqPs0Uh22YQCuwKzahIjZ/yVSwYYiEjiGwttvb/gxg/ZgxczictmNDolFzlz
         hLfesLmnpV2Yz2E+y5yA0hNHHrjvAFSUWpA8RRndPEJGaNSsXppUgLlnx8FM3oikD6x8
         0KfLRAjmY7vRBhLHAlK5Cv+Yus/N+8niAEV03Y9ysbcMsN3ZAds8epK1XHSL+LuxY09B
         8QQLvhz8mr80RLt0YKHatsrOu2pFJg+W39oZ67mTBc3iyTai8tOzZoixona5R05NDgQA
         t32A==
X-Gm-Message-State: AAQBX9f9tgCzrtQAajRRSy8etWv8Rl0OMjHOqoXSUtcQ3H5aWi9qUaec
        ZTpMq1gKBKFK2WrU+mJnxVcSxygw5oUZfmSkoxPbSQ==
X-Google-Smtp-Source: AKy350asN2kOiDwxBpBJAd8JpOC3K4b8YOK8KQg/ZE9v6aufKg464XkTLRn8R/BSNpI1pDhtM3Z9kA==
X-Received: by 2002:a05:6602:3402:b0:740:7d21:d96f with SMTP id n2-20020a056602340200b007407d21d96fmr147658ioz.1.1680542606959;
        Mon, 03 Apr 2023 10:23:26 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id z18-20020a027a52000000b00375783003fcsm2709986jad.136.2023.04.03.10.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 10:23:26 -0700 (PDT)
Message-ID: <80ccc66e-b414-6b68-ae10-59cf38745b45@kernel.dk>
Date:   Mon, 3 Apr 2023 11:23:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] splice: report related fsnotify events
Content-Language: en-US
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, shepjeng@gmail.com,
        kernel@cccheng.net, Chung-Chiang Cheng <cccheng@synology.com>,
        Christian Brauner <brauner@kernel.org>
References: <20230322062519.409752-1-cccheng@synology.com>
 <CAOQ4uxiAbMaXqa8r-ErVsM_N1eSNWq+Wnyua4d+Eq89JZWb7sA@mail.gmail.com>
 <CAOQ4uxg_=7ypNL1nZKQ-=Sp-Q11sQjA4Jbws3Zgxgvirdw242w@mail.gmail.com>
 <cd875f29-7dd8-58bd-1c81-af82a6f1cb88@kernel.dk>
 <CAOQ4uxjf2rHyUWYB+K-YqKBxq_0mLpOMfqnFm4njPJ+z+6nGcw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAOQ4uxjf2rHyUWYB+K-YqKBxq_0mLpOMfqnFm4njPJ+z+6nGcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/3/23 11:15?AM, Amir Goldstein wrote:
>> On 4/3/23 11:00?AM, Amir Goldstein wrote:
>>> On Wed, Mar 22, 2023 at 9:08?AM Amir Goldstein <amir73il@gmail.com> wrote:
>>>>
>>>> On Wed, Mar 22, 2023 at 8:51?AM Chung-Chiang Cheng <cccheng@synology.com> wrote:
>>>>>
>>>>> The fsnotify ACCESS and MODIFY event are missing when manipulating a file
>>>>> with splice(2).
>>>>>
>>>
>>> Jens, Jan,
>>>
>>> FYI, I've audited aio routines and found that
>>> fsnotify_access()/modify() are also missing in aio_complete_rw()
>>> and in io_complete_rw_iopoll() (io_req_io_end() should be called?).
>>>
>>> I am not using/testing aio/io_uring usually, so I wasn't planning on sending
>>> a patch any time soon. I'll get to it someday.
>>> Just wanted to bring this to public attention in case someone is
>>> interested in testing/fixing.
>>
>> aio has never done fsnotify, but I think that's probably an oversight.
> 
> I know. and I am not keen either on fixing something that nobody
> complained about.

Nobody does buffered IO with aio (as it doesn't work), which is probably
why nobody complained.

>> io_uring does do it for non-polled IO, I don't think there's much point
>> in adding it to IOPOLL however. Not really seeing any use cases where
>> that would make sense.
>>
> 
> Users subscribe to fsnotify because they want to be notified of changes/
> access to a file.
> Why do you think that polled IO should be exempt?

Because it's a drastically different use case. If you're doing high
performance polled IO, then you'd never rely on something as slow as
fsnotify to tell you of any changes that happened to a device or file.
That would be counter productive.

-- 
Jens Axboe

