Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF6D2BBEC2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 12:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbgKULl4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 06:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbgKULl4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 06:41:56 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCD5C0613CF;
        Sat, 21 Nov 2020 03:41:55 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 64so167793wra.11;
        Sat, 21 Nov 2020 03:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EoG8wgw5E9f2EWBQYb0JPBgNPT7CxypRnMcvN3LalNs=;
        b=mfYSoFCI4MEdVB3wn4V8mTutwvV0/+j7YHfXF5CfYOoTEmyXJGcZdS/5t2ykNiGKdY
         fl3qqlbN6/SkIJjgvI2t+OFUwpLqBqTD1LusfybXVGf/Y105CKrz5FvtF19bukvVrL3W
         sFxZvOgHPxBqfriQxlrX2toEU3cASu9fRxlwmN65VV9qIqNxJwInXmgqTE1gZMTxYOzf
         YV+r//8Sx84bN40rt9sMKeQv3DGKZe4pR6Zyk7YdfKVI4pJnw9phUb8+nXYPwVF5C6Mr
         72p2Lkm+InKX8h/vNVYOted/Txya7KBbzgSxGs0uJ8QXl+E95L5LCqyA+/TYRED4/KPP
         oH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EoG8wgw5E9f2EWBQYb0JPBgNPT7CxypRnMcvN3LalNs=;
        b=H1x56ORNf4KeOhp14qT9XzsYJovpU5kC1znnWE1r9R3SImOSnzZ+dJjTyoOloanB4K
         ii9qX03SdM2yIs30KkM40X/hz1aoQAdLbLjpjI2SLWEH/R+4uLNAnbicJVFEw3ZH/vT6
         Pe0rS+aDBSGsXUvDVZHosdxK/hudjb0EPE6rVag0B4h3XEoRj62igIh6YJXamBL6gQGW
         /n+HbxBgICWaAoFisUNe7MlW736G5sx3aroneUB4sdltKoSLIdTlJPJp8gnN42YqheQI
         l7113HSYgiNElBEigd26/iys03PKc0tVzXfXjYZaaFhAD6aO7Oe7pvfCDuKAchwtpUhk
         tjUw==
X-Gm-Message-State: AOAM533Xmyi9mv8ubzYUsRkx4qGYaTX5QaoFZB1qEgcHLplLZfGm+WG9
        sLRsr9mCG9x/uGP1d8IeO22QVFrWxAQ=
X-Google-Smtp-Source: ABdhPJyFMoiRUljjn8N3rRrbafrf/Wp2gdA9vGvdF+Kb/W5Fl6oaM8ntlft6xnMBprh2Bh4IHpIOdw==
X-Received: by 2002:a05:6000:143:: with SMTP id r3mr1077733wrx.331.1605958914206;
        Sat, 21 Nov 2020 03:41:54 -0800 (PST)
Received: from [192.168.0.160] ([170.253.49.0])
        by smtp.gmail.com with ESMTPSA id 90sm8634817wrl.60.2020.11.21.03.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Nov 2020 03:41:53 -0800 (PST)
Subject: Re: [PATCH v4] fs/aio.c: Cosmetic
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Joe Perches <joe@perches.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201103095015.3911-1-colomar.6.4.3@gmail.com>
 <20201120220647.8026-1-colomar.6.4.3@gmail.com>
 <cdcef7ab-3f06-1d61-35d5-dc9dd2561b8c@infradead.org>
From:   Alejandro Colomar <colomar.6.4.3@gmail.com>
Message-ID: <5764192e-60c4-dd98-8b3f-992f53c02a2f@gmail.com>
Date:   Sat, 21 Nov 2020 12:41:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <cdcef7ab-3f06-1d61-35d5-dc9dd2561b8c@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Randy,

Thanks for the review.
Next time I'll do it in two parts, as you wished.

Thanks,

Alex

On 11/21/20 2:22 AM, Randy Dunlap wrote:
> On 11/20/20 2:06 PM, Alejandro Colomar wrote:
>> Changes:
>> - Consistently use 'unsigned int', instead of 'unsigned'.
>> - Add a blank line after variable declarations.
>> - Move variable declarations to the top of functions.
>> - Invert logic of 'if's to reduce indentation and simplify function logic.
>> 	- Add goto tags when needed.
>> 	- Early return when appropriate.
>> - Add braces to 'else' if the corresponding 'if' used braces.
>> - Replace spaces by tabs
>> - Add spaces when appropriate (after comma, around operators, ...).
>> - Split multiple assignments.
>> - Align function arguments.
>> - Fix typos in comments.
>> - s/%Lx/%llx/  Standard C uses 'll'.
>> - Remove trailing whitespace in comments.
>>
>> This patch does not introduce any actual changes in behavior.
>>
>> Signed-off-by: Alejandro Colomar <colomar.6.4.3@gmail.com>
>> ---
>>
>> Hi,
>>
>> I rebased the patch on top of the current master,
>> to update it after recent changes to aio.c.
>>
>> Thanks,
>>
>> Alex
>>
>>  fs/aio.c | 466 +++++++++++++++++++++++++++++--------------------------
>>  1 file changed, 243 insertions(+), 223 deletions(-)
> 
> Hi,
> I reviewed this patch.
> I think it looks OK, but I wish that there was a better way to review it.
> 
> I'm not asking you to redo the patch, but I think that it would have been easier
> to review 2 patches: one that contains trivial changes[1] and one that requires
> thinking to review it -- where the trivial changes are not getting in the way
> of looking at the non-trivial changes.
> 
> [1] the trivial set of changes, taken from your patch description:
> 
>> - Consistently use 'unsigned int', instead of 'unsigned'.
>> - Add a blank line after variable declarations.
>> - Move variable declarations to the top of functions.
>> - Add braces to 'else' if the corresponding 'if' used braces.
>> - Replace spaces by tabs
>> - Add spaces when appropriate (after comma, around operators, ...).
>> - Split multiple assignments.
>> - Align function arguments.
>> - Fix typos in comments.
>> - s/%Lx/%llx/  Standard C uses 'll'.
>> - Remove trailing whitespace in comments.
> 
> OK, that's everything except for this:
>> - Invert logic of 'if's to reduce indentation and simplify function logic.
>> 	- Add goto tags when needed.
>> 	- Early return when appropriate.
> 
> 
> thanks.
> 
