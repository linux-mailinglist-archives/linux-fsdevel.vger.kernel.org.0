Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A42228C269
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Oct 2020 22:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbgJLUa5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Oct 2020 16:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730401AbgJLUa4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:30:56 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1DAC0613D0;
        Mon, 12 Oct 2020 13:30:56 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e23so11352682wme.2;
        Mon, 12 Oct 2020 13:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v+S/WeTaJhr5udoYnCYs6HSyWnfSG0aTQiRF77j2gcE=;
        b=cyPZsRdjoOAy5zaNXrqfdpCnPm4A4y7tC1NnG5LwNj5pdullZE+lbMOYksKln0IMqg
         9iwv2m4oVvBiwJCYn6POZumwvpvCSYlNsUrmcCtnyRstSSGQ9iPINKjGleZBVJr7v0HZ
         fYv82PIG2VDYfo3hDNi0uxYV7T+wHtOiloYABD3bfVOQ4qMnVTczQ94X8tfwA6vSIwHv
         /Oz+FNiPw3UnF4A6Miz5Uu+UA2UgGtIYTtUj39TNfjC//ZwNS4ebo4ULyss32mBuQbyJ
         atC4JyfKpsolxQGqOQ9KGxUEU3sPuRxSc9lQCqqrUmbhZGcrikH1TW4bALnKCxw8OpXS
         da/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v+S/WeTaJhr5udoYnCYs6HSyWnfSG0aTQiRF77j2gcE=;
        b=MQZhTh2Ml44zdfHcIkd2zHHO2jKHCiPpfGRCHsocWcoN9+hB+3d1DaFewMlHktbbY1
         8L9qZmP4MyqiGhGEphLbpDgzSrJBF5ZPYD6YssOc3JW52l3YL2FOGUUsN7ldlNKSyXIn
         lhOvHGZrvJWGPgXl0Xx4bH5cflsFA5vDGySmGWDebX4es+QwemSUqteJOl5wG1BbRcaf
         wG+oEXzTSIj0Fqdr/p0cH8wn+EKfp11j7OkBJZeOdoy4ZYqfRSCplAzVgz1baaHQbssc
         kG8KHTOSIcQpwJpQWs4fZG/hWud6WMeTm0nJeuofMowAT1FNbsUJwHwVDxmUYHufp0vP
         hzLQ==
X-Gm-Message-State: AOAM53184RMYtQDm6zpWNCAF4zZrKswm3JlgZ21KWkjQGXDP0/7BU2Ud
        zUZL+ard9jZ+no4jLS21GOU8ekNAnS8=
X-Google-Smtp-Source: ABdhPJxOhn5AdG4k0m0VXqOag2CnjWAslhBsDh1zFUxuQW8QXWnzeti+o0gBCaTzGJKfs3z1jyFLJg==
X-Received: by 2002:a05:600c:2cd0:: with SMTP id l16mr12395320wmc.18.1602534654648;
        Mon, 12 Oct 2020 13:30:54 -0700 (PDT)
Received: from [192.168.1.10] (static-176-175-73-29.ftth.abo.bbox.fr. [176.175.73.29])
        by smtp.gmail.com with ESMTPSA id 205sm10289105wme.38.2020.10.12.13.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 13:30:53 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, David Howells <dhowells@redhat.com>,
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
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <aviro@redhat.com>
References: <CAKgNAkjMBGeAwF=2MKK758BhxvW58wYTgYKB2V-gY1PwXxrH+Q@mail.gmail.com>
 <CAHk-=wig1HDZzkDEOxsxUjr7jMU_R5Z1s+v_JnFBv4HtBfP7QQ@mail.gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <81229415-fb97-51f7-332c-d5e468bcbf2a@gmail.com>
Date:   Mon, 12 Oct 2020 22:30:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wig1HDZzkDEOxsxUjr7jMU_R5Z1s+v_JnFBv4HtBfP7QQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[CC += Davide]

Hello Linus,

Thanks for your quick reply.

On 10/12/20 9:25 PM, Linus Torvalds wrote:
> On Mon, Oct 12, 2020 at 11:40 AM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
>>
>> Between Linux 5.4 and 5.5 a regression was introduced in the operation
>> of the epoll EPOLLET flag. From some manual bisecting, the regression
>> appears to have been introduced in
>>
>>          commit 1b6b26ae7053e4914181eedf70f2d92c12abda8a
>>          Author: Linus Torvalds <torvalds@linux-foundation.org>
>>          Date:   Sat Dec 7 12:14:28 2019 -0800
>>
>>              pipe: fix and clarify pipe write wakeup logic
>>
>> (I also built a kernel from the  immediate preceding commit, and did
>> not observe the regression.)
> 
> So the difference from that commit is that now we only wake up a
> reader of a pipe when we add data to it AND IT WAS EMPTY BEFORE.
> 
>> The aim of ET (edge-triggered) notification is that epoll_wait() will
>> tell us a file descriptor is ready only if there has been new activity
>> on the FD since we were last informed about the FD. So, in the
>> following scenario where the read end of a pipe is being monitored
>> with EPOLLET, we see:
>>
>> [Write a byte to write end of pipe]
>> 1. Call epoll_wait() ==> tells us pipe read end is ready
>> 2. Call epoll_wait() [again] ==> does not tell us that the read end of
>> pipe is ready
> 
> Right.
> 
>> If we go further:
>>
>> [Write another byte to write end of pipe]
>> 3. Call epoll_wait() ==> tells us pipe read end is ready
> 
> No.
> 
> The "read end" readiness has not changed. It was ready before, it's
> ready now, there's no change in readiness.
> 
> Now, the old pipe behavior was that it would wake up writers whether
> they needed it or not, so epoll got woken up even if the readiness
> didn't actually change.
> 
> So we do have a change in behavior.
> 
> However, clearly your test is wrong, and there is no edge difference.
> 
> Now, if this is more than just a buggy test - and it actually breaks
> some actual application and real behavior - we'll need to fix it. A
> regression is a regression, and we'll need to be bug-for-bug
> compatible for people who depended on bugs.

I don't think this is correct. The epoll(7) manual page
sill carries the text written long ago by Davide Libenzi,
the creator of epoll:

    Since  even with edge-triggered epoll, multiple events can be gen‐
    erated upon receipt of multiple chunks of data, the caller has the
    option  to specify the EPOLLONESHOT flag, to tell epoll to disable
    the associated file descriptor after the receipt of an event  with
    epoll_wait(2).

My reading of that text is that in the scenario that I describe a
readiness notification should be generated at step 3 (and indeed
should be generated whenever additional data bleeds into the channel).
Indeed, the very rationale for the existence of the EPOLLONESHOT flag
is to *prevent* notifications in such circumstances. And, as I noted,
sockets and terminals do (still) behave in the way that I expect in
this scenario.

So, I don't think this is a buggy test. It (still) appears to me
that this is a breakage of intended and documented behavior.
(Whether it breaks some actual application, I do not know. But
I have also seen that sometimes reports of such breakages take
a very time to come in.)

Thanks,

Michael



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
