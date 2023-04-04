Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418A56D68D4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 18:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjDDQ3q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 12:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjDDQ3p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:29:45 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A00A3C3D
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Apr 2023 09:29:42 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id o12so14645164iow.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Apr 2023 09:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680625781; x=1683217781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cbK0zrp1wQKQmsAFQg8KCfCI0BV6eNXjxDNWPXzuNbA=;
        b=TqZ554oDFcBqKvCfescr6ya0vaC1ggZWfwmtq+PsSJzeqV9W49ucCFxPmaqcmqfXa+
         NNcjQsMUNhaN4TdnEEiyd2BySlOrXfYRaRb09taH6ax1BnvroirDmYXs0Y8mFg7ww6pW
         yGrjgvF4Ul/CsilvGVCMZOV1bd6GqJivZNSeoC6VCT7MOKpd5tTDpGuHQHJFqSolqhxn
         3dvwrHcANw9UnUtkzzUb+M+Nesr+N9SB9QRS8h3LGmc8fQ93EaE4l1aPg+jIbcPJT9aZ
         lU1hVwY/SXQy79jVD4/vH7vDC4BBWdPCqOIYXoRh1N1NjnVaCGTsAEoY7JtNz1au0Fz+
         SBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680625781; x=1683217781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cbK0zrp1wQKQmsAFQg8KCfCI0BV6eNXjxDNWPXzuNbA=;
        b=ttK9HB+R2ik4cCoCOyVnw8RdWNFIM9fsdKLAptxh8LBvzIf5u9siIaNKDBRdjJvm3M
         dHqbr7Mx9s0T0OYQ4HYadjrFh+ZLF/rMjgWsBsE75fyrAmJApuww3ZjgKzwO29p0m5oL
         wjYlw9RTcT45w/tR9eLRsQHLSxB31WeDrhdQmht2ZFIhCBwOl0bC3H1S46N/YH0gv6jX
         cWU/OuXFqdaivP6Ta+oYlWgiC7/zvtgIxDUi5AgqvJY7yyr+26+ZWTaRUHC78gcBUPMZ
         Wmc5PpELSxQpw1eI65QUODMMLALVOmdUJegcCwa+9WWxM8pHtUZSt5ioNPsYRtjojf6u
         e7HA==
X-Gm-Message-State: AAQBX9dx/E6lwcVs+qNe+RDfiUlsH1l+5fS8OvpvUv0LeWIOxuuqJNtr
        CxbHKrXyzz/Ax4fShzFg5rQHjyGJZanmur04DjpfgA==
X-Google-Smtp-Source: AKy350ZNCVlGHF+OI2/j8nGfFw0wDwc23kMYGSP/JbU0hqNkGsNSn1iYABu+a/8lyu113oWIqgc3Eg==
X-Received: by 2002:a05:6602:1495:b0:758:6517:c621 with SMTP id a21-20020a056602149500b007586517c621mr438880iow.2.1680625781585;
        Tue, 04 Apr 2023 09:29:41 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id o9-20020a02a1c9000000b003c4f35c21absm3249651jah.137.2023.04.04.09.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 09:29:41 -0700 (PDT)
Message-ID: <fa83cc9a-2303-d32c-1ded-82683df95c2f@kernel.dk>
Date:   Tue, 4 Apr 2023 10:29:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] splice: report related fsnotify events
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, shepjeng@gmail.com,
        kernel@cccheng.net, Chung-Chiang Cheng <cccheng@synology.com>,
        Christian Brauner <brauner@kernel.org>
References: <20230322062519.409752-1-cccheng@synology.com>
 <CAOQ4uxiAbMaXqa8r-ErVsM_N1eSNWq+Wnyua4d+Eq89JZWb7sA@mail.gmail.com>
 <CAOQ4uxg_=7ypNL1nZKQ-=Sp-Q11sQjA4Jbws3Zgxgvirdw242w@mail.gmail.com>
 <cd875f29-7dd8-58bd-1c81-af82a6f1cb88@kernel.dk>
 <CAOQ4uxjf2rHyUWYB+K-YqKBxq_0mLpOMfqnFm4njPJ+z+6nGcw@mail.gmail.com>
 <80ccc66e-b414-6b68-ae10-59cf38745b45@kernel.dk>
 <20230404092109.evsvdcv6p2e5bvtf@quack3>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230404092109.evsvdcv6p2e5bvtf@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/4/23 3:21?AM, Jan Kara wrote:
> On Mon 03-04-23 11:23:25, Jens Axboe wrote:
>> On 4/3/23 11:15?AM, Amir Goldstein wrote:
>>>> On 4/3/23 11:00?AM, Amir Goldstein wrote:
>>>> io_uring does do it for non-polled IO, I don't think there's much point
>>>> in adding it to IOPOLL however. Not really seeing any use cases where
>>>> that would make sense.
>>>>
>>>
>>> Users subscribe to fsnotify because they want to be notified of changes/
>>> access to a file.
>>> Why do you think that polled IO should be exempt?
>>
>> Because it's a drastically different use case. If you're doing high
>> performance polled IO, then you'd never rely on something as slow as
>> fsnotify to tell you of any changes that happened to a device or file.
>> That would be counter productive.
> 
> Well, I guess Amir wanted to say that the application using fsnotify
> is not necessarily the one doing high performance polled IO. You could
> have e.g. data mirroring application A tracking files that need
> mirroring to another host using fsnotify and if some application B
> uses high performance polled IO to modify a file, application A could
> miss the modified file.

Sure, but what I'm trying to say is that if you're using polled IO,
you're doing a custom setup anyway and the likelihood of needing
fsnotify is slim to none. It'd certainly be in your best interesting to
NOT rely on that, for performance reasons. And the latter is presumably
why you'd using polled IO to begin with.

> That being said if I look at exact details, currently I don't see a
> very realistic usecase that would have problems (people don't depend
> on FS_MODIFY or FS_ACCESS events too much, usually they just use
> FS_OPEN / FS_CLOSE), which is likely why nobody reported these issues
> yet :).

The only report I got on io_uring and fsnotify was someone writing a
buffered log with it, and noticing that tail doesn't work if you don't
have fsnotify access notifications. Open/close would not be enough
there.

I'd much rather make fsnotify opt-in for io_uring than have it on by
default, as it's quite the cycler consumer for IRQ based workloads right
now. And that's without even having any watches on the file...

-- 
Jens Axboe

