Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A8F6CAF55
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 22:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjC0UD0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 16:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjC0UDZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:03:25 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAF91718
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 13:03:24 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id m22so4414302ioy.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 13:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679947404;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o1nWu6G6ersSqlothMvrsB30NgxeHx8YgmKJY3Wn5fY=;
        b=BE0LZy/tn82F8XVa8Qq58x++1qFAzSyimMtQ6mdfVOPnx+NWmBLejt3vDkBzr5oY9C
         xVsExSLaQUwtT2K+CDx/dYYEONpbtHuQixYtRGmTopoQd47mQRPduHAPmY3BSwhtsALD
         x44xevX+6Q0sdIi2nKj/ZJne+p4kkoPw6XjzKHfoa3z0+BnceQ8HD3pszYm9+DlCV+94
         remVXi5H3q4yyg8BXCtvoHrY9LCZ+yr4AyA5/hYIthpeLHkC4hD1kwUIXHi5pP+9NGzi
         UaxR1qDuUvaO1aDtPerNpMtxsLV1rlFfwE0KomDu9pyBEAQWWeNJtM3Q/MKRIVFCe3Pl
         zixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679947404;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o1nWu6G6ersSqlothMvrsB30NgxeHx8YgmKJY3Wn5fY=;
        b=ezOeRyONHJ3hx8wW0WMVlnl7kVhhR+xO7clEhN5YkWJbYrupAjbTU6pUYNLKh35sYr
         YS8c+MUydr8euMWejIkQjZpjtvfGwZgR8Mk+S2oNCaB/2C5GO3sNM9ztVkUBAWbk1Qdt
         mXTNdY4YtPa0tw2okb4+5mDYWOMQuXIVbf+V2VtVlyUs+tLe4dYjLzB3uCMTq6WUeeGT
         k3O4M+Z1KgiX3PJDg7Qheo0mQN4ozVzzA14tQ7oQ1NVPxBjlMIHks4Wqfzdui7/3Ic1B
         s1Atz3+cRYaLSZcA02lzhdy5RgIbYtjNyyyrdZh0a7TJZF3vjxJsauLmnQJkBFd5zCtD
         viOA==
X-Gm-Message-State: AO0yUKXpqmp8VfcGh+we/ePZkffDcoaOhVE8MJCPO3qq+mu7aqjO9nyI
        OtUWJBMmHOc2UBAuC256MoQ2SA==
X-Google-Smtp-Source: AK7set8zZPVAYbehj0moVoHJK9f9rQ0J/46sgkEARGfNy1a/85zznI8NpxbolDlpArGa5bL5XXqW5Q==
X-Received: by 2002:a05:6602:395:b0:758:5653:353a with SMTP id f21-20020a056602039500b007585653353amr7742176iov.0.1679947403817;
        Mon, 27 Mar 2023 13:03:23 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e34-20020a026d62000000b003c50d458389sm9247940jaf.69.2023.03.27.13.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 13:03:23 -0700 (PDT)
Message-ID: <f568a652-d10c-b2b3-e2c7-ba43e774f2bf@kernel.dk>
Date:   Mon, 27 Mar 2023 14:03:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCHSET 0/2] Turn single segment imports into ITER_UBUF
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        brauner@kernel.org
References: <20230324204443.45950-1-axboe@kernel.dk>
 <20230325044654.GC3390869@ZenIV>
 <1ef65695-4e66-ebb8-3be8-454a1ca8f648@kernel.dk>
 <20230327184254.GH3390869@ZenIV>
 <65c20342-b6ed-59c8-3aef-1d6f6d8bfdf2@kernel.dk>
 <c975dbcf-1332-5bb5-3375-04280407a897@kernel.dk>
 <20230327200226.GI3390869@ZenIV>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230327200226.GI3390869@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/27/23 2:02 PM, Al Viro wrote:
> On Mon, Mar 27, 2023 at 12:59:09PM -0600, Jens Axboe wrote:
> 
>>> That's a great idea. Two questions - do we want to make that
>>> WARN_ON_ONCE()? And then do we want to include a WARN_ON_ONCE for a
>>> non-supported type? Doesn't seem like high risk as they've all been used
>>> with ITER_IOVEC until now, though.
>>
>> Scratch that last one, user_backed should double as that as well. At
>> least currently, where ITER_UBUF and ITER_IOVEC are the only two
>> iterators that hold user backed memory.
> 
> Quite.  As for the WARN_ON_ONCE vs. WARN_ON...  No preferences, really.

OK, I'll stick with WARN_ON_ONCE then. At least that avoids a ton of
dmesg dumping for something buggy, yet still preserving the first
trace.

-- 
Jens Axboe


