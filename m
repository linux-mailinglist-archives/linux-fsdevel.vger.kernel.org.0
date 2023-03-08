Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DAE6AFB26
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 01:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjCHAcD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 19:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCHAcC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 19:32:02 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CCBB0491
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 16:32:01 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so420890pja.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Mar 2023 16:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678235520;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AEsMgalcatpSKQO/pDZVaHweQJaXK1mWCaEr5mhyepU=;
        b=rsB/B7Cfuk4rjsdAczPw02m2FmRN7MTInKl6zemXOO/ZVFzkZxDPS5d5xhOyIDQ/Hd
         ZK2q2GnZTtIV6Nk7c0t/DDi8KxzCRxez1BYexvIg83Ej3aP3uajkmYgLOGUpIbr7EkCM
         GNKbLv2KS5YHDn+6upoHFKB8kkpH5KlEjZRoRHpgjZuvo6mR6kA6BtVadtffi7J2tIWo
         Drx7NBxkEpA4O5i7Pg2en9NpzoYA7EiDQ91bUB42eFTZeP5aW5UQQNZ68EoL2Ob/aCGy
         Y6WSyavGa1xw7S13urK+pb47RIMgZze8a/w56PdQ+itvU1g4xhO/SxHCmDLdCtGq0jbl
         1kXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678235520;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEsMgalcatpSKQO/pDZVaHweQJaXK1mWCaEr5mhyepU=;
        b=f0qgXNdz7UvP/kmUfoNZOd/jaWtZ1iyB6i9Kdvl+e6v+q8GGT9X2ApyXooY6yQZ6rV
         UxedWPOGGaKOYbALcv2MH4X73p5nu+mly0QjpklITcWttfrJ8WBXpCJ/HdoSBOAgJPhq
         AqgBgH2zDbHgC7rH533jQw0rIwNMG8rE4rydXxJmQNxmkCzNUqm7wLAbEEvYPX1FpVyi
         bzjjJgxXXeH3hqK6eGXjuUpoAdkVIw2+kFg4EHSL47d6olU3J/vUw2qxnlMzgz5XdVE4
         NlLMe8adfg7gEqrLuSu9ghaH5OuccceiKyGYxkvNEjpPngP66GAxeZ0ExZ13BdKs9atg
         EuQg==
X-Gm-Message-State: AO0yUKV0buyy0G8aoYn1CvKklUnPVo/RIIU6+FmCWJEBRYe28pScbeX0
        hqBRcOGsluM+gzJiKUcaHo9rJw==
X-Google-Smtp-Source: AK7set8N6zVADkbhO5WhiG2LAuOBDL7zqJZxE8JWVESIY4R+IXttseHYc/os4nAEUMpP6zFtvSz2Aw==
X-Received: by 2002:a17:902:e5d0:b0:196:3f5a:b4f9 with SMTP id u16-20020a170902e5d000b001963f5ab4f9mr18941514plf.1.1678235520461;
        Tue, 07 Mar 2023 16:32:00 -0800 (PST)
Received: from [172.20.4.229] ([50.233.106.125])
        by smtp.gmail.com with ESMTPSA id a16-20020a170902b59000b00195f242d0a0sm8872788pls.194.2023.03.07.16.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 16:32:00 -0800 (PST)
Message-ID: <2cd7c118-5a6a-0a21-5e08-58ece4fe56c2@kernel.dk>
Date:   Tue, 7 Mar 2023 17:31:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCHSET for-next 0/2] Make pipe honor IOCB_NOWAIT
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        brauner@kernel.org
References: <20230307154533.11164-1-axboe@kernel.dk>
 <20230308001929.GS2825702@dread.disaster.area>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230308001929.GS2825702@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/7/23 5:19 PM, Dave Chinner wrote:
> On Tue, Mar 07, 2023 at 08:45:31AM -0700, Jens Axboe wrote:
>> Hi,
>>
>> File types that implement read_iter/write_iter should check for
>> IOCB_NOWAIT
> 
> Since when? If so, what's the point of setting FMODE_NOWAIT when the
> struct file is opened to indicate the file has comprehensive
> IOCB_NOWAIT support in the underlying IO path?

Guess I missed that FMODE_NOWAIT is supposed to be added for that,
my naive assumption was that the iter based one should check. Which
is a bad sad, but at least there's a flag for it.

But the good news is that I can drop the io_uring patch, just need
to revise the pipe patch. I'll send a v2.

-- 
Jens Axboe


