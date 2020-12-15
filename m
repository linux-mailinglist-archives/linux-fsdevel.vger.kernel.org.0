Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30172DB017
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 16:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbgLOPam (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 10:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729003AbgLOPad (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:30:33 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A875C0617A6
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 07:29:53 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id k8so19576569ilr.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 07:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ybeLKj7kYEapueQTxivi74dC26Mbrm9bMg3bpV9XJd4=;
        b=lVfamKAfE5u3fMSERx6FP10glwktkXvvw+XoUb6HGzZB5VPCaetfAiNne2V+6mI3tv
         TbgL+LlwnY8TktxfL7TNN/OwtZO9i9pEaKbJ+kLvE5ek6uzJ5COs52aByQDCQCceUlen
         n/6L5a9Ou3mODulwyhrOQd/8jCDmbvpSijwC1TMXKIoP9klvOVW0virsCHehkXrw1h4v
         975hPEWo5zoDH7MwC2Oyh7VTiTm9n47TulSbBe0deEgtwwcLbxuc0VDBnvTi09EDFydf
         5fFmwo/lZiz6d+4u5xijY1szC63wermnaAlHlxxus4f5KT/QtxpK5Qh8SLyg2UCFtvSP
         1cUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ybeLKj7kYEapueQTxivi74dC26Mbrm9bMg3bpV9XJd4=;
        b=LOlI+3o0oir3rZQ4FKTL3EP/NZZuzB2Eyk1lhla3ZwtZKgPBDy0XmuTM8ooXR+Nimj
         oIwZ/uPI112bfLDQmdDKvuXmC2+QI5TrS9ckfMY87GIHLnsbiCUMmxDYY37cp2WIpPao
         UbGalRAVoPnrGAnt3E5wQ+xt6FNnuGV46MGp8fuk3GbKdhUSVihxYMS6GQHgtaulroGK
         z2/si8yigYDp+ePqO8kqRmw/nNG5m4373QPFXFgA7np8uALFbAsUHMUOmEzZRrrCZPsU
         7Kv4WY1Cw4Y/4J1iIq0M43POEKg1jLtQ7IhhkwdZBTKmu8syzV9AThFISH+lZRjFZKBK
         vitg==
X-Gm-Message-State: AOAM532ym5r5OTUsvNf4HS+aLZj3cd1O1olnFrFnpHDoTwGSJixF7ozs
        42CYVQlPEW12KmK6mY8I6xn2DyWb8dCOuw==
X-Google-Smtp-Source: ABdhPJxC8A/vvApUd+/aqQikCi5XrDaQa8vVHZ3WlUy1XLl6ThkBQlRluvmlANVF6gpt+uLGe7sYZw==
X-Received: by 2002:a05:6e02:168a:: with SMTP id f10mr37219857ila.70.1608046192898;
        Tue, 15 Dec 2020 07:29:52 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 12sm13676987ily.42.2020.12.15.07.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 07:29:52 -0800 (PST)
Subject: Re: [PATCHSET v3 0/4] fs: Support for LOOKUP_NONBLOCK /
 RESOLVE_NONBLOCK
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
References: <20201214191323.173773-1-axboe@kernel.dk>
 <20201215061131.GG3579531@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bdd0ee88-24b8-858d-b54d-287b98a890dc@kernel.dk>
Date:   Tue, 15 Dec 2020 08:29:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201215061131.GG3579531@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/14/20 11:11 PM, Al Viro wrote:
> On Mon, Dec 14, 2020 at 12:13:20PM -0700, Jens Axboe wrote:
>> Hi,
>>
>> Wanted to throw out what the current state of this is, as we keep
>> getting closer to something palatable.
>>
>> This time I've included the io_uring change too. I've tested this through
>> both openat2, and through io_uring as well.
>>
>> I'm pretty happy with this at this point. The core change is very simple,
>> and the users end up being trivial too.
> 
> I'll review tomorrow morning (sorry, half-asleep right now)

Thanks Al, appreciate it.

-- 
Jens Axboe

