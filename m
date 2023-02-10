Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84E6692A90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Feb 2023 23:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjBJWvz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Feb 2023 17:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBJWvx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Feb 2023 17:51:53 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF7E12597
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 14:51:51 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o13so6854154pjg.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 14:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R4N26B9VGGTnqC3xqOaxRLSDi0f2Dt0eKjIQvb/X62o=;
        b=u5HRO63gAcA4nfusNIOQSq65f86ZTJ3MqNvxRzAX5W+R22e0AtrfGMumqSuVrq1lF9
         NsFXM7VxYdTkvyXmirDO3xIUpW+ewcW65e2UkdwGOQJ9YYAwpFCJYyHSbkZWApVHEZGE
         trnv6AWqvv6dHFaEgCi4hVQIt+kM56QLFx8gqLW0NWJFYOuOwB8G583A//zD1Sai/c7C
         Yv8iBj0gA1lfIgrL3ID5Im4XMbfR6eu3isQI3hqYm8g51dYY/9UgnTVjXvGyKAjaFsRq
         qoIJ6191tOa8qIoM1uzUoaYGc2WROgSeZ+8ShxrfdZMyZQIyFSeReusVE5uiSq1tUukg
         zUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R4N26B9VGGTnqC3xqOaxRLSDi0f2Dt0eKjIQvb/X62o=;
        b=T7SHbzWRja1NOq8YuOC9LCwUxNWJeCrDK05EDIwdiX8RFtwP54z7VGDB5o8UoQn+eg
         uCHBt8uxhWcZS9Rq7Nha6fg+En9xAf/sylntFHjuDYGdDpQ+b3/al1ASvxWrstSYbhmG
         3pIjmAt8TY03/mxKtVWtwpqTmaz0mhIQp7qbjHFPaEIWcAtH1NkF8J7mKT6wyFfPLRHr
         8KPj8xpiJF4MW1keBDtk8f6PouiU6wdH9sQ7XpinVwNhGKUyI4ifwdIamB1ZKN4Dmlo+
         YcfIvAKGiZ1o8wLpl/ez2aqygiF9RBxFYHmQjuBhxRkgNzV6K+xbaAj6fvkZKP9uByTB
         D9gQ==
X-Gm-Message-State: AO0yUKWg1K+wjgRyjcchCWxe7QuwiZyLI9Laiw9V3x7doWzcVbb/yrlV
        mV/h+pe3uhnYW3InsjZ/AsB3tQ==
X-Google-Smtp-Source: AK7set/0HEQG/FQ9H218VpRyJjXTjhHzpcw6zsWsYqjqsJHruBzZv/lO8Nfnn1XVxrZ0jfTCujLcLQ==
X-Received: by 2002:a05:6a20:7f8e:b0:be:cd93:66cd with SMTP id d14-20020a056a207f8e00b000becd9366cdmr18769759pzj.2.1676069510837;
        Fri, 10 Feb 2023 14:51:50 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z29-20020a63b91d000000b0047899d0d62csm3439655pge.52.2023.02.10.14.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 14:51:50 -0800 (PST)
Message-ID: <c395bf68-108e-1674-1a1c-4cb26178d87c@kernel.dk>
Date:   Fri, 10 Feb 2023 15:51:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: copy on write for splice() from file to pipe?
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        'Linus Torvalds' <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     Stefan Metzmacher <metze@samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API Mailing List <linux-api@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Samba Technical <samba-technical@lists.samba.org>
References: <0cfd9f02-dea7-90e2-e932-c8129b6013c7@samba.org>
 <CAHk-=wj8rthcQ9gQbvkMzeFt0iymq+CuOzmidx3Pm29Lg+W0gg@mail.gmail.com>
 <20230210021603.GA2825702@dread.disaster.area>
 <20230210040626.GB2825702@dread.disaster.area>
 <CAHk-=wip9xx367bfCV8xaF9Oaw4DZ6edF9Ojv10XoxJ-iUBwhA@mail.gmail.com>
 <20230210061953.GC2825702@dread.disaster.area>
 <CAHk-=wj6jd0JWtxO0JvjYUgKfnGEj4BzPVOfY+4_=-0iiGh0tw@mail.gmail.com>
 <304d5286b6364da48a2bb1125155b7e5@AcuMS.aculab.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <304d5286b6364da48a2bb1125155b7e5@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/10/23 3:41?PM, David Laight wrote:
> From: Linus Torvalds
>> Sent: 10 February 2023 17:24
> ...
>> And when it comes to networking, in general things like TCP checksums
>> etc should be ok even with data that isn't stable.  When doing things
>> by hand, networking should always use the "copy-and-checksum"
>> functions that do the checksum while copying (so even if the source
>> data changes, the checksum is going to be the checksum for the data
>> that was copied).
>>
>> And in many (most?) smarter network cards, the card itself does the
>> checksum, again on the data as it is transferred from memory.
>>
>> So it's not like "networking needs a stable source" is some really
>> _fundamental_ requirement for things like that to work.
> 
> It is also worth remembering that TCP needs to be able
> to retransmit the data and a much later time.
> So the application must not change the data until it has
> been acked by the remote system.

This has been covered, and:

> I don't think io_uring has any way to indicate anything
> other than 'the data has been accepted by the socket'.

This is wrong and has also been covered.

-- 
Jens Axboe

