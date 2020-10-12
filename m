Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CE328C457
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Oct 2020 23:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgJLVvp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Oct 2020 17:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgJLVvo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Oct 2020 17:51:44 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01FBC0613D0;
        Mon, 12 Oct 2020 14:51:44 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i1so15003108wro.1;
        Mon, 12 Oct 2020 14:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q8OL3cmHRuG6ih7Mbuxc+VlMJ2+20Mh99TNgQTxbdJA=;
        b=Ze8YkPjp02pImWUzOdwjNRlFoVkd8kalL7GWVriWF2GI3s4cFIhwI54JQJpj1Iwumg
         aqBMqnjkAHLNh5CdMlITNYXFB7JyMxvzLs4d5LibaG87oA5TiTHcyRm4aqcOrquG0cjg
         MmzCfoxtxllUWPs0CQ8ixOIDs8nVghvu/x2TAaD99RZ7T6JFwM4URFBH6tNk7urP++J0
         3CxqriuWKBA060ocoOEL/6nfutY/KuIg29tb7fIAJHFVlOiHOOfQV4DaERuTTZdm0YwV
         DyXi3I30rFfTzlJKaYWGEw7c9BwohqLdqsO2Rnz4QYwprAM/cshxfHkQMm9zTmM9+BL6
         lhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q8OL3cmHRuG6ih7Mbuxc+VlMJ2+20Mh99TNgQTxbdJA=;
        b=MdZOsuz0oJp1h1/wLXr9tNd0sPt2VBIV/ge9j+cbaIauFKvs9wtAVz9wnfw+nNOKfi
         62p9QiOHb/VL53rUQznIjhr+IAmDWL4DgKJ8eqqtro8hB0lAb6GDVXDQC/jzCgbpMaGX
         Mxn3F1XoR/7gdUeFt+9rs7f7O9sZ8OTXAWqH53BRXfottSkw+ZXZqtqJbxT6kOy9cg9G
         N3XcuSlOHbAtUkObIjECaPvkrTAh5LeHqCbaW8/YVNfRK5sqwW9QzQT4NRdiOKeM5l5w
         Jdt8LUFXyeJNrRPilVGNl803g3UzUzki1WAcWsSlMhUMkFP1dF/NMCyyIuh4g1uQqc1W
         IEuA==
X-Gm-Message-State: AOAM530aJsokfwFmFuJuQujosqWiFxHGv8ItZV/FkQ3td5Nfkk1AWJX8
        jFz4RInCwb/rEXbmxehDOac=
X-Google-Smtp-Source: ABdhPJwhObTvt/NEPd5Cf5sy7BV9AVtfiWOjgvgS8Sp8JlYleGUH4VcwOHmxIrFY2E3AfjKDxKhxxA==
X-Received: by 2002:a5d:49cc:: with SMTP id t12mr10036264wrs.342.1602539502071;
        Mon, 12 Oct 2020 14:51:42 -0700 (PDT)
Received: from [192.168.1.10] (static-176-175-73-29.ftth.abo.bbox.fr. [176.175.73.29])
        by smtp.gmail.com with ESMTPSA id c16sm27216750wrx.31.2020.10.12.14.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 14:51:41 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Alexander Viro <aviro@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Davide Libenzi <davidel@xmailserver.org>
Subject: Re: Regression: epoll edge-triggered (EPOLLET) for pipes/FIFOs
To:     Linus Torvalds <torvalds@linux-foundation.org>
References: <CAKgNAkjMBGeAwF=2MKK758BhxvW58wYTgYKB2V-gY1PwXxrH+Q@mail.gmail.com>
 <CAHk-=wig1HDZzkDEOxsxUjr7jMU_R5Z1s+v_JnFBv4HtBfP7QQ@mail.gmail.com>
 <81229415-fb97-51f7-332c-d5e468bcbf2a@gmail.com>
 <CAHk-=wgjR7Nd4CyDoi3SH9kPJp_Td9S-hhFJZMqvp6GS1Ww8eg@mail.gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <85a6b7e0-d218-60e3-5147-b2548040de1f@gmail.com>
Date:   Mon, 12 Oct 2020 23:51:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgjR7Nd4CyDoi3SH9kPJp_Td9S-hhFJZMqvp6GS1Ww8eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/12/20 10:52 PM, Linus Torvalds wrote:
> On Mon, Oct 12, 2020 at 1:30 PM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
>>
>> [CC += Davide]
> 
> I'm not sure how active Davide is any more..

Yep, I know. But just in case.

>> I don't think this is correct. The epoll(7) manual page
>> sill carries the text written long ago by Davide Libenzi,
>> the creator of epoll:
>>
>>     Since  even with edge-triggered epoll, multiple events can be gen‐
>>     erated upon receipt of multiple chunks of data, the caller has the
>>     option  to specify the EPOLLONESHOT flag, to tell epoll to disable
>>     the associated file descriptor after the receipt of an event  with
>>     epoll_wait(2).
>>
>> My reading of that text is that in the scenario that I describe a
>> readiness notification should be generated at step 3 (and indeed
>> should be generated whenever additional data bleeds into the channel).
> 
> Hmm.
> 
> That is unfortunate, because it basically exposes an internal wait
> queue implementation decision, not actual real semantics.

I don't disagree that the longstanding semantics are a little odd;
your comment explains perhaps why.

> I suspect it's easy enough to "fix" the regression with the attached
> patch. It's pretty nonsensical, but I guess there's not a lot of
> downside - if the pipe wasn't empty, there normally shouldn't be any
> non-epoll readers anyway.
> 
> I'm busy merging, mind testing this odd patch out? It is _entirely_
> untested, but from the symptoms I think it's the obvious fix.

Applied against current master (13cb73490f475). My test now
runs as I expected.

> I did the same thing for the "reader starting out from a full pipe" case too.

I haven't tested this, but thanks for thinking of it.

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
