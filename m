Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2FA6688EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 02:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240196AbjAMBMy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 20:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237286AbjAMBMx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 20:12:53 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736CF5D6BA;
        Thu, 12 Jan 2023 17:12:52 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id y4-20020a4ab404000000b004f21c72be42so1983153oon.8;
        Thu, 12 Jan 2023 17:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KV52lj2dmjkAsboEJSBjeC6RZgHMYA6025SgDDWUPjA=;
        b=jQvh9BtcxioCFwJqPAATwW7XH20JrEE6xXt0uzDoSMoX+gAkfBk5NYfs01zNyx9S5b
         Kqg6QYjRmels0qpVta6XvOZOYsoykIj4EIXFPJqVgP63tx6rtuiaB8AlNIT8Mpot0vgF
         4N1QBxbdVuSpLUI8CVeWhpK6VAzwduLg8RX5Ys6wprCOZOihjr8W6hn3Ub4FWu1ylkV6
         cH8XtbAdQiTcLcciL61RdQLCyYYaoEHgNQCbw/hNaz/7lG+1m6g2I6fsfeIQq8E6s9ji
         zQ/01gQyWcuzOEkTDBsoze++PVjAnJBV2q2YrfGYmCwLQUdjP/QiGa2y37BoMLXts2XQ
         76qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KV52lj2dmjkAsboEJSBjeC6RZgHMYA6025SgDDWUPjA=;
        b=GxFmKk3stbNWGn3CHT8F8XQ4vTZGYS6dWCyVqFGvKPWJ1XbklyAuPVBZ40H9p+WW5m
         J+15e9NuCRctvX17c5n9XXe8GzypTx0MJnMF9HN6Qp7mfp09VAYgj5DyF3gdeaof9dGX
         MDEa/62TMCcQyxwFihTtGaXFpt8daJOnzQzGZTgjUHZyyixc6B10xIHSsicBmoUm3LRp
         2A7Tb6hb5oABl2aaykQ42RqGa6wC1vnBX8nD7PC/M75/Iu7JZF5dGv0m5M2nEz5MWEEN
         ZQTpyCjaB2e6D7FWtPWLB8JISB1/dc6w5ugq+A6sVSQZJqswDV9DeiKjMosvoT0+QI6f
         JjqA==
X-Gm-Message-State: AFqh2koHERgLcID2XV+bY74WGI8nlQtzLDah+auYl8CJHZ5J9bhVKdZP
        4xNpskRdF+zPpVQHDqT9obWTlTkPRb8O5YDlgyM=
X-Google-Smtp-Source: AMrXdXuWIXZj7GTqE2vZ82Tol/3lPrC2YrNkJMh4/eYlDNwugZKGviKH9kvg1/JBDmDJLMmE/uNj0l3V8UWTfh5vAzE=
X-Received: by 2002:a05:6820:188d:b0:4a0:78a0:bb6a with SMTP id
 bm13-20020a056820188d00b004a078a0bb6amr3948746oob.4.1673572371746; Thu, 12
 Jan 2023 17:12:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:77d5:0:b0:491:8368:9bdd with HTTP; Thu, 12 Jan 2023
 17:12:50 -0800 (PST)
In-Reply-To: <CAHk-=wjthxgrLEvgZBUwd35e_mk=dCWKMUEURC6YsX5nWom8kQ@mail.gmail.com>
References: <CAGudoHHx0Nqg6DE70zAVA75eV-HXfWyhVMWZ-aSeOofkA_=WdA@mail.gmail.com>
 <CAHk-=wjthxgrLEvgZBUwd35e_mk=dCWKMUEURC6YsX5nWom8kQ@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Fri, 13 Jan 2023 02:12:50 +0100
Message-ID: <CAGudoHE0tzL8OAqvwpDR4Nn_g70a8qBdE_+-fmhXF-DEx_K6kg@mail.gmail.com>
Subject: Re: lockref scalability on x86-64 vs cpu_relax
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Jan Glauber <jan.glauber@gmail.com>, tony.luck@intel.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/13/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Side note on your access() changes - if it turns out that you can
> remove all the cred games, we should possibly then revert my old
> commit d7852fbd0f04 ("access: avoid the RCU grace period for the
> temporary subjective credentials") which avoided the biggest issue
> with the unnecessary cred switching.
>
> I *think* access() is the only user of that special 'non_rcu' thing,
> but it is possible that the whole 'non_rcu' thing ends up mattering
> for cases where the cred actually does change because euid != uid (ie
> suid programs), so this would need a bit more effort to do performance
> testing on.
>

I don't think the games are avoidable. For one I found non-root
processes with non-empty cap_effective even on my laptop, albeit I did
not check how often something like this is doing access().

Discussion for another time.

> On Thu, Jan 12, 2023 at 5:36 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
>> All that said, I think the thing to do here is to replace cpu_relax
>> with a dedicated arch-dependent macro, akin to the following:
>
> I would actually prefer just removing it entirely and see if somebody
> else hollers. You have the numbers to prove it hurts on real hardware,
> and I don't think we have any numbers to the contrary.
>
> So I think it's better to trust the numbers and remove it as a
> failure, than say "let's just remove it on x86-64 and leave everybody
> else with the potentially broken code"
>
[snip]
> Then other architectures can try to run their numbers, and only *if*
> it then turns out that they have a reason to do something else should
> we make this conditional and different on different architectures.
>
> Let's try to keep the code as common as possibly until we have hard
> evidence for special cases, in other words.
>

I did not want to make such a change without redoing the ThunderX2
benchmark, or at least something else arm64-y. I may be able to bench it
tomorrow on whatever arm-y stuff can be found on Amazon's EC2, assuming
no arm64 people show up with their results.

Even then IMHO the safest route is to patch it out on x86-64 and give
other people time to bench their archs as they get around to it, and
ultimately whack the thing if it turns out nobody benefits from it.
I would say beats backpedaling on the removal, but I'm not going to
fight for it.

That said, does waiting for arm64 numbers and/or producing them for the
removal commit message sound like a plan? If so, I'll post soon(tm).

-- 
Mateusz Guzik <mjguzik gmail.com>
