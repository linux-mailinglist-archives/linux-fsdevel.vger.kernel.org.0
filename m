Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CD070ABA4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 May 2023 01:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjETXQM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 19:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjETXQM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 19:16:12 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93042115;
        Sat, 20 May 2023 16:16:09 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6aaef8ca776so1737206a34.2;
        Sat, 20 May 2023 16:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684624569; x=1687216569;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qtN503DAMVLG+ZzNXh8XqsPCLRzxoeSh0JfLzHKejJY=;
        b=CyIMrN2MhpEosseCZAw9ARngSHbN3e1fKGeGdChJABNEVzGX5zLDpwSkLg6Gtyf9mV
         269PUmpAyCGZDzk6Zie8vBgnafQ7CuTukl2G+p/toBY4P0YGTxiXltwfvNHGeB/PuzIS
         X11Ug+1jQs9jUbMG1f3EEW7mz/6Z2/SE9JzGM+0lXc04t8LrOJsVTgoj4DnRuH4Iy0jQ
         3FPo52z1AZt3Ez38be23zFbQyVqlX6zbUduKq4PjDYUp7qFsq9cbNndV7qEBDuO07tfx
         ayy6FyIOIstNFOWpJLlD6s/yx88js5mmUKdY8W+XcRanLodcAGJzDfcQDSMD/NERscwi
         Wp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684624569; x=1687216569;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qtN503DAMVLG+ZzNXh8XqsPCLRzxoeSh0JfLzHKejJY=;
        b=el9b4Uuqw4WGWoInjoLeUSN3uVFPIymnxyYdQ17BAOV+LPIGPnTRSQlZMgvXgMPNf7
         2YZFWVM+RYLa2VOZQFfaSjcKcron4a0GuBHEtgaopDD7sD02a3e2ukiSCw7l9uiyXgwT
         UPx1zgSyA2R9rt+hZBYhPotIBf774DyR/KLlnyZzZBFcO1I3Z2sw6KFVGF6zIFEG2A0g
         /PaxQAAUtqTV5KlNS2lKzPGUzY6mnDSLf/9zjP81auQN9ordHI9JTSCCv4I19ukAmNBm
         /neL/sk439fy9XRFj5ij3neTLFMtWxXIyPF65Y8WuzO5lMAfD1OsbxbpTpSphkMFJDRJ
         L0/w==
X-Gm-Message-State: AC+VfDzTQTd604YgjXNIojEmOuHvjGAtq8dMSIIOqlpm95NSmGhrpCdF
        h5Lq6i9tdZIQwMb8RpEmcxvfr+ED3j8=
X-Google-Smtp-Source: ACHHUZ5ijRccqrMNCyT9C9rF+440+EpLu9j68TL2kbqDne8/GuC7Bfc/VBYBipCqvRLoCJtcB0CjyA==
X-Received: by 2002:a05:6830:1181:b0:6ab:43b:a93c with SMTP id u1-20020a056830118100b006ab043ba93cmr3351049otq.13.1684624568854;
        Sat, 20 May 2023 16:16:08 -0700 (PDT)
Received: from [192.168.0.92] (cpe-70-94-157-206.satx.res.rr.com. [70.94.157.206])
        by smtp.gmail.com with ESMTPSA id i17-20020a9d6251000000b006ad3ed04973sm971205otk.8.2023.05.20.16.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 May 2023 16:16:08 -0700 (PDT)
Message-ID: <ced4d4e1-8358-d718-58ee-9effe39cff6e@gmail.com>
Date:   Sat, 20 May 2023 18:16:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [ANNOUNCE] util-linux v2.39
Content-Language: en-US
From:   Bruce Dubbs <bruce.dubbs@gmail.com>
To:     Masatake YAMATO <yamato@redhat.com>
Cc:     kzak@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org,
        renodr2002@gmail.com
References: <20230517112242.3rubpxvxhzsc4kt2@ws.net.home>
 <652d32c5-4b33-ce3a-3de7-9ebc064bbdcb@gmail.com>
 <20230520.074311.642413213582621319.yamato@redhat.com>
 <2fc8421e-634a-aa7d-b023-c8d5e5fa1741@gmail.com>
In-Reply-To: <2fc8421e-634a-aa7d-b023-c8d5e5fa1741@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/19/23 17:56, Bruce Dubbs wrote:
> On 5/19/23 17:43, Masatake YAMATO wrote:
>> Bruce,
>>
>>> On 5/17/23 06:22, Karel Zak wrote:
>>>> The util-linux release v2.39 is available at
>>>>                                        
>>>> http://www.kernel.org/pub/linux/utils/util-linux/v2.39
>>>>                                     Feedback and bug reports, as always, are 
>>>> welcomed.
>>>
>>> Karel, I have installed util-linux v2.39 in LFS and have run into a
>>> problem with one test, test_mkfds.  Actually the test passes, but does
>>> not clean up after itself. What is left over is:
>>>
>>> tester 32245 1 0 15:43 ?  00:00:00 /sources/util-linux-2.39/test_mkfds
>>> -q udp 3 4 server-port=34567 client-port=23456 server-do-bind=1
>>> client-do-bind=1 client-do-connect=1
>>> tester 32247 1 0 15:43 ?  00:00:00 /sources/util-linux-2.39/test_mkfds
>>> -q udp6 3 4 lite=1 server-port=34567 client-port=23456
>>> server-do-bind=1 client-do-bind=1 client-do-connect=1
>>>
>>> It's possible it may be due to something we are doing inside our
>>> chroot environment, but we've not had this type of problem with
>>> earlier versions of util-linux.
>>>
>>> In all I do have:
>>>
>>>    All 261 tests PASSED
>>>
>>> but the left over processes interfere later when we try to remove the
>>> non-root user, tester, that runs the tests.  I can work around the
>>> problem by disabling test_mkfds, but thought you would like to know.
>>
>> Thank you for reporting.
>> Reproduced on my PC. I found two processes were not killed properly.
>>
>> Could you try the following change?
>>
>> diff --git a/tests/ts/lsfd/option-inet b/tests/ts/lsfd/option-inet
>> index 21e66f700..70cc3798d 100755
>> --- a/tests/ts/lsfd/option-inet
>> +++ b/tests/ts/lsfd/option-inet
>> @@ -84,14 +84,10 @@ ts_cd "$TS_OUTDIR"
>>                     -o ASSOC,TYPE,NAME \
>>                     -Q "(PID == $PID0) or (PID == $PID1) or (PID == $PID2) or (PID 
>> == $PID3) or (PID == $PID4)"
>> -    kill -CONT "${PID0}"
>> -    wait "${PID0}"
>> -
>> -    kill -CONT "${PID1}"
>> -    wait "${PID1}"
>> -
>> -    kill -CONT "${PID2}"
>> -    wait "${PID2}"
>> +    for pid in "${PID0}" "${PID1}" "${PID2}" "${PID3}" "${PID4}"; do
>> +       kill -CONT "${pid}"
>> +       wait "${pid}"
>> +    done
>>   } > "$TS_OUTPUT" 2>&1
>>   ts_finalize
> 
> I will do that, but will not be able to get to it until late tomorrow, but will 
> report back asap.

I used the above patch and it fixed the problem.  Thank you.

   -- Bruce


