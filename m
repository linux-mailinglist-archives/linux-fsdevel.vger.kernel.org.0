Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1752C3F715C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Aug 2021 11:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239464AbhHYJCA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Aug 2021 05:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237532AbhHYJBx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:01:53 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F2BC0613C1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Aug 2021 02:01:07 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id k5so51404902lfu.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Aug 2021 02:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=os8aJlJMxgrA15emDY2bCaToS5/IQDjiEq+tnVstXAw=;
        b=jEIbpHYxVhHrfdNd/nVe3NRg1kTS35Dx6pl5OkFnhiQ4clvqdytIyGhfKExQZeiVDh
         /5COoSvH3nPClSJBeYp5ANkEqC/p0tgJz0APPKJcUXrPKTKu0FlSKN3RhoSoWjOtsxLd
         6FVTtvLx519X9nbEQNvpjuRYd1gH+2k8gDOf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=os8aJlJMxgrA15emDY2bCaToS5/IQDjiEq+tnVstXAw=;
        b=p7C3JB4w0iEezox85Fgao+kfmsnaqr0ZnGnlqp8p+QVbrAAFUFB5nzkKzrV3Ejr50c
         o3THpRb7UpdwMLbmBC1tpJ8a/ziyewYcsRzcpShUVvnkz4lfTDDMBe50uHQra574OAVv
         UmdnFr4F+RLjWTJ3eETly0jM+3UWBynln7OlZHjWGgCAiVp7mZrZQMai9iTiUtxv4PTr
         u27294k/oeEiFQeV484wunp3v2v5TEGX1bbtxNLlmGzaJ3I4YwPnFh2zXhqtZlAMBclA
         PSUDtxPCTqbATvPxRaJ6eROXXKp/RZI46qKtVQgV1XGg2gbgw4+iL0mcL1e7heWd+VKu
         RIfg==
X-Gm-Message-State: AOAM530GbJj2h9J9uM4w+p6xVofjQjH9+WOQlHh2StFkb4s6lSOlpqjc
        ZuOl2sPxma5GhgHNzt1hA7dQyg==
X-Google-Smtp-Source: ABdhPJw+pYgFjlPmRojIMl29cAfzcGLeR7M55MokkKR8hZmfuCeq7O5tj3jMMsGnGnsJrQpbka43Pg==
X-Received: by 2002:a05:6512:3b9e:: with SMTP id g30mr703973lfv.651.1629882065538;
        Wed, 25 Aug 2021 02:01:05 -0700 (PDT)
Received: from [172.16.11.1] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id k15sm1593540lfv.141.2021.08.25.02.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 02:01:05 -0700 (PDT)
Subject: Re: [GIT PULL] Memory folios for v5.15
To:     Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
 <YSPwmNNuuQhXNToQ@casper.infradead.org> <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <1957060.1629820467@warthog.procyon.org.uk>
 <YSUy2WwO9cuokkW0@casper.infradead.org>
 <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com>
 <YSVCAJDYShQke6Sy@casper.infradead.org>
 <CAHk-=wisF580D_g+wFt0B_uijSX+mCgz6tRRT5KADnO7Y97t-g@mail.gmail.com>
 <YSVHI9iaamxTGmI7@casper.infradead.org> <YSVMMMrzqxyFjHlw@mit.edu>
 <YSXkDFNkgAhQGB0E@infradead.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <92cbfb8f-7418-15d5-c469-d7861e860589@rasmusvillemoes.dk>
Date:   Wed, 25 Aug 2021 11:01:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSXkDFNkgAhQGB0E@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 25/08/2021 08.32, Christoph Hellwig wrote:
> On Tue, Aug 24, 2021 at 03:44:48PM -0400, Theodore Ts'o wrote:
>> The problem is whether we use struct head_page, or folio, or mempages,
>> we're going to be subsystem users' faces.  And people who are using it
>> every day will eventually get used to anything, whether it's "folio"
>> or "xmoqax", we sould give a thought to newcomers to Linux file system
>> code.  If they see things like "read_folio()", they are going to be
>> far more confused than "read_pages()" or "read_mempages()".
> 
> Are they?  It's not like page isn't some randomly made up term
> as well, just one that had a lot more time to spread.
> 
>> So if someone sees "kmem_cache_alloc()", they can probably make a
>> guess what it means, and it's memorable once they learn it.
>> Similarly, something like "head_page", or "mempages" is going to a bit
>> more obvious to a kernel newbie.  So if we can make a tiny gesture
>> towards comprehensibility, it would be good to do so while it's still
>> easier to change the name.
> 
> All this sounds really weird to me.  I doubt there is any name that
> nicely explains "structure used to manage arbitrary power of two
> units of memory in the kernel" very well.  So I agree with willy here,
> let's pick something short and not clumsy.  I initially found the folio
> name a little strange, but working with it I got used to it quickly.
> And all the other uggestions I've seen s far are significantly worse,
> especially all the odd compounds with page in it.
> 

A comment from the peanut gallery: I find the name folio completely
appropriate and easy to understand. Our vocabulary is already strongly
inspired by words used in the world of printed text: the smallest unit
of information is a char(acter) [ok, we usually call them bytes], a few
characters make up a word, there's a number of words to each (cache)
line, and a number of those is what makes up a page. So obviously a
folio is something consisting of a few pages.

Are the analogies perfect? Of course not. But they are actually quite
apt; words, lines and pages don't universally have one size, but they do
form a natural hierarchy describing how we organize information.

Splitting a word across lines can slow down the reader so should be
avoided... [sorry, couldn't resist].

Rasmus
