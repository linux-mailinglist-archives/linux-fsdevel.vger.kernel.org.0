Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54BF31C177
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 19:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhBOSZS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 13:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhBOSZL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 13:25:11 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12242C061786
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Feb 2021 10:24:31 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id z9so4376333pjl.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Feb 2021 10:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/Q2Oyenx8GmfnXaHluVKTSj/aWQ8dgSZ6Bh0/XSraks=;
        b=JhlmGKDfJ1zLK8yg/jzkE4LJCX5Ph32YbY1XWThe0L+Ltwtu/+ZyAlAkIS36VFv3WX
         dJQEOc/iqOASPdWYa+sFOWm3G9YrFRZ8VygbKwHeDYUFzq+9vTfcN60lkwicpKoW18Qk
         27uHM5HlSPzaaoSzfPz76QK9ia+/VXFeyBEqs0u6W+c+ALE1nTeGFP+FiV0Nrh46wr51
         Y2G3YJ4rg7nY6RuO0B5iEaZa8DZNBbjRxQxlxEfCOWFwzguXnkKFj8CB1tOzndbZ0gpe
         1ZzdTlljREznGTlo5Gr6EEH9zbDv10eCGi5ZNo3AyLnNInurK7KGgA546oHSuXzhtIUO
         EHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Q2Oyenx8GmfnXaHluVKTSj/aWQ8dgSZ6Bh0/XSraks=;
        b=mjkkk66xRRdglvVHKK9gtfN7Q/EG+iHCV9ntjWlyW7RAGK5UaskO9f7Ik+qM0GYtn+
         id8fg2NSy7ln/NusyJAMpMVc6gQdeht+fAQchhQVKNOL7yXHDqqYZPWmakYh0fo7ubLk
         NCDcppz+/4SRdYhBUUPICSCCAL9lmjOI4ZPZgP53iMuroRp+nY1WQi2r21PjUPi2wbv4
         gmHQHh6iZl+sb2oZcxHRsk7CtJ4Fi0GOi97DkEOltJVzFwZwonzzJK+1WJhFk5ObVuNl
         8vUP6OKKBOtQUNSXw37ehugF6iKOzupL8R0YA0iIH1qJatU26VH3tOvFg2HN0Inv1hFG
         SLYg==
X-Gm-Message-State: AOAM531U+D6YNybiQGBMEx17GD+K4i/v+rB4nfZRSPA4FnHCh9tKHBE4
        cFgPWyzJi/IfTAfyMY042+pSdg==
X-Google-Smtp-Source: ABdhPJylBBBmMK/6/q5h5nx7I5IUgPnv/SinuPw6ks8PbFjrOorC7j0phvSPGBg2vwq/Ks9vN9F7+g==
X-Received: by 2002:a17:902:988f:b029:e2:e8f7:ac11 with SMTP id s15-20020a170902988fb02900e2e8f7ac11mr16374977plp.81.1613413468525;
        Mon, 15 Feb 2021 10:24:28 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id ck10sm103323pjb.5.2021.02.15.10.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Feb 2021 10:24:28 -0800 (PST)
Subject: Re: [PATCHSET v3 0/4] fs: Support for LOOKUP_NONBLOCK /
 RESOLVE_NONBLOCK (Insufficiently faking current?)
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20201214191323.173773-1-axboe@kernel.dk>
 <m1lfbrwrgq.fsf@fess.ebiederm.org>
 <94731b5a-a83e-91b5-bc6c-6fd4aaacb704@kernel.dk>
 <CAHk-=wiZuX-tyhR6rRxDfQOvyRkCVZjv0DCg1pHBUmzRZ_f1bQ@mail.gmail.com>
 <m11rdhurvp.fsf@fess.ebiederm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e9ba3d6c-ee1f-6491-e7a9-56f4d7a167a3@kernel.dk>
Date:   Mon, 15 Feb 2021 11:24:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <m11rdhurvp.fsf@fess.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/15/21 11:07 AM, Eric W. Biederman wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
>> On Sun, Feb 14, 2021 at 8:38 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>>> Similarly it looks like opening of "/dev/tty" fails to
>>>> return the tty of the caller but instead fails because
>>>> io-wq threads don't have a tty.
>>>
>>> I've got a patch queued up for 5.12 that clears ->fs and ->files for the
>>> thread if not explicitly inherited, and I'm working on similarly
>>> proactively catching these cases that could potentially be problematic.
>>
>> Well, the /dev/tty case still needs fixing somehow.
>>
>> Opening /dev/tty actually depends on current->signal, and if it is
>> NULL it will fall back on the first VT console instead (I think).
>>
>> I wonder if it should do the same thing /proc/self does..
> 
> Would there be any downside of making the io-wq kernel threads be per
> process instead of per user?
> 
> I can see a lower probability of a thread already existing.  Are there
> other downsides I am missing?
> 
> The upside would be that all of the issues of have we copied enough
> should go away, as the io-wq thread would then behave like another user
> space thread.  To handle posix setresuid() and friends it looks like
> current_cred would need to be copied but I can't think of anything else.

I really like that idea. Do we currently have a way of creating a thread
internally, akin to what would happen if the same task did pthread_create?
That'd ensure that we have everything we need, without actively needing to
map the request types, or find future issues of "we also need this bit".
It'd work fine for the 'need new worker' case too, if one goes to sleep.
We'd just 'fork' off that child.

Would require some restructuring of io-wq, but at the end of it, it'd
be a simpler solution.

-- 
Jens Axboe

