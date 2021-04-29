Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BB736E4F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 08:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhD2Gkq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 02:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhD2Gkp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 02:40:45 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A62BC06138B
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 23:39:59 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h8so37067131edb.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 23:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YaeH9sGa8MlXtO0yNppCZXJjRDMmZTvxbYDV3i2sS4U=;
        b=G+kCPzZt0bV04nTRDKIP0XzNCMEmRE1Y8/XwnOoegIUDSA1dPxSndP9AqGep941dpb
         HKHNcN4jKqdPGveE8Ei76tpBf07fQORwSFN+9CvdIQe5DyUjrRygoHxksf0vR0mo6fEl
         zEpP3L1DZONWOAbT7oeTRPh2nE3QYI5eh1a5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YaeH9sGa8MlXtO0yNppCZXJjRDMmZTvxbYDV3i2sS4U=;
        b=qMeVeP7BUPmOOc6/y/bNL1PXiQUuze0ggtlH9oiA/ojvyVXklmTfpTYtS+Xi2JT2Zf
         O3eWFU9jkz+subQuM2kMc0ltKJsIEHHW9tGQtgzri4Tw9parJbJoTzLtpL/EaM4hGsvW
         HZSJ7IO8hLbg41bbyjp7MKSsEFWPrACLmgqmLNmQhtzbyNyNBUluWgz0otpjhQB4ZoNd
         RRtwX0Fpi5EJGM4zvxCNZouGjpG5I9+bTJND5IHhgzAQmkFo6PvgUORvogFiuXlGxo/7
         n3debISI/Uo+3L66bbxyUft0x7cOC5UeIdAqM7Qpt2TORIRMuh4aw963jtoPIM4X8p5D
         BRKw==
X-Gm-Message-State: AOAM530ahiG29Qi0jw1I7NgVLBE0hlRDs3SzErSFUrnoBamXJVYiX5GY
        /pVMJwOfN8JX75vRK3BGgxrT+A==
X-Google-Smtp-Source: ABdhPJxdoTVAg+i2SjtkE7pNOx42NrI+oCCwYAgSODUgAGpgMhmW9GP/m9mtQBIvq5VILeJ+HQilhw==
X-Received: by 2002:a05:6402:17d7:: with SMTP id s23mr14972330edy.66.1619678398309;
        Wed, 28 Apr 2021 23:39:58 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id v19sm1586089edr.21.2021.04.28.23.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 23:39:57 -0700 (PDT)
Subject: Re: [GIT PULL] iomap: new code for 5.13-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>, Jia He <justin.he@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20210427025805.GD3122264@magnolia>
 <CAHk-=wj6XUGJCgsr+hx3rz=4KvBP-kspn3dqG5v-cKMzzMktUw@mail.gmail.com>
 <20210427195727.GA9661@lst.de>
 <CAHk-=wjrpinf=8gAjxyPoXT0jbK6-U3Urawiykh-zpxeo47Vhg@mail.gmail.com>
 <20210428061706.GC5084@lst.de>
 <CAHk-=whWnFu4wztnOtySjFVYXmBR4Mb2wxrp6OayZqnpKeQw0g@mail.gmail.com>
 <20210428064110.GA5883@lst.de>
 <CAHk-=wjeUhrznxM95ni4z+ynMqhgKGsJUDU8g0vrDLc+fDtYWg@mail.gmail.com>
 <1de23de2-12a9-2b13-3b86-9fe4102fdc0c@rasmusvillemoes.dk>
 <CAHk-=wimsMqGdzik187YWLb-ru+iktb4MYbMQG1rnZ81dXYFVg@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <26d06c27-4778-bf75-e39a-3b02cd22d0e3@rasmusvillemoes.dk>
Date:   Thu, 29 Apr 2021 08:39:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wimsMqGdzik187YWLb-ru+iktb4MYbMQG1rnZ81dXYFVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28/04/2021 18.50, Linus Torvalds wrote:
> [ Added Andy, who replied to the separate thread where Jia already
> posted the patch ]
> 
> On Wed, Apr 28, 2021 at 12:38 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> So the patch makes sense to me. If somebody says '%pD5', it would get
>> capped at 4 instead of being forced down to 1. But note that while that
>> grep only produces ~36 hits, it also affects %pd, of which there are
>> ~200 without a 2-4 following (including some vsprintf test cases that
>> would break). So I think one would first have to explicitly support '1',
>> switch over some users by adding that 1 in their format string
>> (test_vsprintf in particular), then flip the default for 'no digit
>> following %p[dD]'.
> 
> Yeah, and the "show one name" actually makes sense for "%pd", because
> that's about the *dentry*.
> 
> A dentry has a parent, yes, but at the same time, a dentry really does
> inherently have "one name" (and given just the dentry pointers, you
> can't show mount-related parenthood, so in many ways the "show just
> one name" makes sense for "%pd" in ways it doesn't necessarily for
> "%pD"). But while a dentry arguably has that "one primary component",
> a _file_ is certainly not exclusively about that last component.
> 
> So you're right - my "how about something like this" patch is too
> simplistic. The default number of components to show should be about
> whether it's %pd or %pD.

Well, keeping the default at 1 for %pd would certainly simplify things
as there are much fewer %pD instances.

> That also does explain the arguably odd %pD defaults: %pd came first,
> and then %pD came afterwards.

Eh? 4b6ccca701ef5977d0ffbc2c932430dea88b38b6 added them both at the same
time.

Rasmus
