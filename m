Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195B03E83BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 21:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhHJTax (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 15:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhHJTaw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 15:30:52 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7816FC0613C1;
        Tue, 10 Aug 2021 12:30:30 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u16so22686938ple.2;
        Tue, 10 Aug 2021 12:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w33uFdck5RcJX68cJm7DF6DgXYSeGQPNlroZpWjMPdg=;
        b=Mt7jOMvJ8KhKvna7YJU5UpYTCdSg8COeycRVtaVDqVBRLXJFS0Nry6bmaPEb5EMR7D
         Mj9oYz/5DTovkjn+FTFYwaZWedj4dU69eDgDx0gVsoS4yl1w6KC0S0ueU4ORCy250wh9
         g1sYEEuhpTVyI4SZeSwLL0gpcZTPlqb9d4SoCUhBrsvcGgqBmd7DWbL4ZNP69nQsYNdQ
         KcQb6Zm956ycZpqC0PKa3SsDdV07ikhPtwYsoxnXNKd+1RlBXoV9wnpG6wYsAQ2H63sL
         m6WyYZQgWjEIgWE9bKQFGF8NJTvWz/oq5CN/IuI4+hLBvWgZYD71CREam1DIdMdiKhr1
         d55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w33uFdck5RcJX68cJm7DF6DgXYSeGQPNlroZpWjMPdg=;
        b=QNyqwmfTitXK0nJT5QrxbbZMKr1yhOXswPR59XbqoCDHfvNqll3F8Swfo9kmOwdt1I
         NDzuR5PpE13CkuEHWKqg1rjdyQ2C5RaN8m3ExbofY9vT3PshvvcluCg3n3VmtaFRX+i6
         dI/t5BnRWHO4wlCHS8l8/O9ErG4Nw1PcWtzrJty6liH28aV0t57hEO7RkOi3gj+YfBt+
         el+9QzvkwGUo9YbR0ei9aOnHlosPViN7CZEfkNbBTBLKyFWF/ibfLbbvAUWIv9SXy756
         cYzekg4hkUKYDRuKyh5Go6IBY3cg6lFpLkZjTByKywlPRv/wSdhGYexdEiqS7LWhZpIe
         EWmQ==
X-Gm-Message-State: AOAM532iAWNTxtaTJUaVuHhwkM+WeedZb7TQbtx5o6h4WBmNkx8j76K+
        etYEeaEEdHQzvtK2Al+TykU=
X-Google-Smtp-Source: ABdhPJxaLZ78gZAfuwIt1mmpNrhDC0M/DNLevy+vYOlJQIbOr6nqCMWVidL93ULMql2iRLqs0K+zaw==
X-Received: by 2002:a63:8ac2:: with SMTP id y185mr45975pgd.179.1628623830094;
        Tue, 10 Aug 2021 12:30:30 -0700 (PDT)
Received: from [192.168.1.71] (122-61-176-117-fibre.sparkbb.co.nz. [122.61.176.117])
        by smtp.gmail.com with ESMTPSA id q13sm3881455pjq.10.2021.08.10.12.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 12:30:29 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Alejandro Colomar <alx.manpages@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: Questions re the new mount_setattr(2) manual page
To:     Christian Brauner <christian.brauner@ubuntu.com>
References: <b58e2537-03f4-6f6c-4e1b-8ddd989624cc@gmail.com>
 <b23122c0-893a-c1b4-0b2d-3a332af4151f@gmail.com>
 <20210810141125.nxmvnwpyjxajvxl4@wittgenstein>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <40d5616a-7404-850e-bc73-09d0b513b94b@gmail.com>
Date:   Tue, 10 Aug 2021 21:30:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210810141125.nxmvnwpyjxajvxl4@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/10/21 4:11 PM, Christian Brauner wrote:
> On Tue, Aug 10, 2021 at 09:12:14AM +0200, Michael Kerrisk (man-pages) wrote:
>> Hi Christian,
>>
>> One more question...
>>
>>>>       The propagation field is used to specify the propagation typ
>>>>       of the mount or mount tree.  Mount propagation options are
>>>>       mutually exclusive; that is, the propagation values behave
>>>>       like an enum.  The supported mount propagation types are:
>>
>> The manual page text doesn't actually say it, but if the 'propagation'
>> field is 0, then this means leave the propagation type unchanged, 
>> right? This of course should be mentioned in the manual page.
> 
> Yes, if none of the documented values is set the propagation is unchanged.

Thanks for the confirmation.

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
