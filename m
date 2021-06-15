Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C233A7840
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 09:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhFOHtk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 03:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhFOHtj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 03:49:39 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FACC0617AF
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 00:47:34 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id dj8so49783235edb.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 00:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KBRdVIOa/asDmbEumkxjOA8DSurhtMGcGIoG3TYPT2Y=;
        b=Crcal5RtkkBcDXdj5iAxnD1gvaFJfEwDwRgm8xZ3EAOu4RtYaSVDFtFHKFShRPlhAl
         npephrwP1CJpcdeyMS//t5/d1phcMaiAJQmWJAdCIIH0UP6ZQqOIwmnPf8VuFtbWJR9B
         5jD6Ol1iZrpaHrkafsh7V369VJXsflwxQ6TBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KBRdVIOa/asDmbEumkxjOA8DSurhtMGcGIoG3TYPT2Y=;
        b=TDsP6jgmqwNh+ShRgHsmbff36hh0/NMPhlMmrxIz0wJxPIYUwhhBIlZos78LLZO5r9
         Axcf5sNb49XtL9b4lREGIbyLrK9xzSoyjItorug7D6Ut67NgirfU4FdtVmiQndXY6iVi
         PecYXpujDLmd2fQb6bxFyVASexF/+BBOfPGePQ0zP3sGDNYNZ+pb1YdGCiKUVxYUmOoV
         LxDIwXR7a4g4Jy95Ih0zX2t4D9CGgXp9KPaikDh2OBzHHqYmsK+7EmTfHeIUTzRlev1A
         hhaMMzkgAe4Le+E+1MNz+84KH64FQA4Co7x7dctGZbtj1Jcu59+F7nEDrenp7Mqj0qeQ
         Upqg==
X-Gm-Message-State: AOAM5317EiNZMR2kCNGvsSu9YKULfegwaFIHzEEmy0VlXlLjZbtiP3Xv
        mEW/LwQg5Ku7cOggXZHzJkO6hetL7p9QnWl5
X-Google-Smtp-Source: ABdhPJwNMbkXylErvIagkPbri2w/XvfHjlohoakbcrmNIZJjV8B28X6xTCIhWQnNhW0EWElzSW60cw==
X-Received: by 2002:aa7:c1da:: with SMTP id d26mr21437105edp.92.1623743253307;
        Tue, 15 Jun 2021 00:47:33 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.64.110])
        by smtp.gmail.com with ESMTPSA id cf26sm9394124ejb.38.2021.06.15.00.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 00:47:32 -0700 (PDT)
Subject: Re: [PATCH RFCv3 3/3] lib/test_printf: add test cases for '%pD'
To:     Justin He <Justin.He@arm.com>, Petr Mladek <pmladek@suse.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20210611155953.3010-1-justin.he@arm.com>
 <20210611155953.3010-4-justin.he@arm.com> <YMd5StgkBINLlb8E@alley>
 <AM6PR08MB4376096643BA02A1AE2BA8F4F7309@AM6PR08MB4376.eurprd08.prod.outlook.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <55513987-4ec5-be80-a458-28f275cb4f72@rasmusvillemoes.dk>
Date:   Tue, 15 Jun 2021 09:47:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <AM6PR08MB4376096643BA02A1AE2BA8F4F7309@AM6PR08MB4376.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 15/06/2021 09.07, Justin He wrote:
> Hi Petr
> 

>>> +static void __init
>>> +f_d_path(void)
>>> +{
>>> +   test("(null)", "%pD", NULL);
>>> +   test("(efault)", "%pD", PTR_INVALID);
>>> +
>>> +   is_prepend_buf = true;
>>> +   test("/bravo/alfa   |/bravo/alfa   ", "%-14pD|%*pD", &test_file, -14,
>> &test_file);
>>> +   test("   /bravo/alfa|   /bravo/alfa", "%14pD|%*pD", &test_file, 14,
>> &test_file);
>>> +   test("   /bravo/alfa|/bravo/alfa   ", "%14pD|%-14pD", &test_file,
>> &test_file);
>>
>> Please, add more test for scenarios when the path does not fit into
>> the buffer or when there are no limitations, ...
> 
> Indeed, thanks

Doesn't the existing test() helper do this for you automatically?

        /*
         * Every fmt+args is subjected to four tests: Three where we
         * tell vsnprintf varying buffer sizes (plenty, not quite
         * enough and 0), and then we also test that kvasprintf would
         * be able to print it as expected.
         */

I don't see why one would need to do anything special for %pD.

Rasmus
