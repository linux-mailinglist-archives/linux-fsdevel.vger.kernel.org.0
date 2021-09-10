Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907B8406620
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 05:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhIJDaE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 23:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhIJDaD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 23:30:03 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5477BC061575
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Sep 2021 20:28:53 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id q3so628023iot.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Sep 2021 20:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HkeHhnqkzSEVCG8RBViWFhN/hyIZCVQVxMZ4nK2bjs8=;
        b=PkWP9UGyF379pXe/D9Yf+Ivd9Eruhf+xmAuxu9RC2rNGoNLpkUGMDnp6G5oIuI8hQ2
         xbTqhTOfVOBA41nsgUthZ2RcHT6sOyQp7Bv2iMAwiUJSVxdnha8b+nYnwT8JDwW1gj6L
         KCu3onchyYKvwKNOYmsyf1ltANK5T7B/NQ6+NkZDlrWwymOlFSBQQyA50LlDKaN3DArh
         sNq1hDQokhDbuswGnyJa5j400ekgZ9yVbHbrxz4E0N5gfO++NsYq7aKUjp8tR7R+jFY+
         1a94D/qkCQzhh+VEzOafB4SFOCwpRlc/BfbaLfqSs41fraajURLFkSIheRelXV1SGOfs
         9Y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HkeHhnqkzSEVCG8RBViWFhN/hyIZCVQVxMZ4nK2bjs8=;
        b=oAb+OjVFT6We55ypaqU+suELlLE2HkTeVjKgOZLjUn+gXUiMWFJfsURzbiGd8j3jeV
         CsWypQLNpo1KWVXdotZUzSMlOjU2hNxAMd1tIG7Uub1h0fD9RDX4/Kt99UialHJ0o1qk
         wHKQB2RWLpNSgYirc8LPXPjXijz5mI2IzlaVK9Q7FRIH1xkp6eMMBe+CvDPRRf507Ztl
         oHGSCla99Icnes2uLVHZPQlfjDNS187FIYFV/D4YpZLfOtzxgCa7XfqDKlR+1XYON7kC
         1BPC+my886TS1lPY1EhK0nWTkha9X+tPQiBas55wwoP27oKYZJbiOsUteULWU9L86uOT
         CY+Q==
X-Gm-Message-State: AOAM531K1tZBzW5Tm3WPUcaLhlxh3WI1OvJ66bepMhW10NnfEfyinEYS
        rhPpjicEQQMrCjf+CW4c6CLi6yOlwgVdnw==
X-Google-Smtp-Source: ABdhPJyZRFwpOYrNkHfl47VbHws9Q0r+wvfhG26yCw8IAw26Y2E0tf7E/tZS25v8UB3hFtxJT183ew==
X-Received: by 2002:a5e:c00a:: with SMTP id u10mr5291469iol.60.1631244532538;
        Thu, 09 Sep 2021 20:28:52 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id h9sm1870320ioz.30.2021.09.09.20.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 20:28:52 -0700 (PDT)
Subject: Re: [git pull] iov_iter fixes
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com>
 <5971af96-78b7-8304-3e25-00dc2da3c538@kernel.dk>
 <ebc6cc5e-dd43-6370-b462-228e142beacb@kernel.dk>
 <CAHk-=whoMLW-WP=8DikhfE4xAu_Tw9jDNkdab4RGEWWMagzW8Q@mail.gmail.com>
 <ebb7b323-2ae9-9981-cdfd-f0f460be43b3@kernel.dk>
 <CAHk-=wi2fJ1XrgkfSYgn9atCzmJZ8J3HO5wnPO0Fvh5rQx9mmA@mail.gmail.com>
 <88f83037-0842-faba-b68f-1d4574fb45cb@kernel.dk>
 <YTrHYYEQslQzvnWW@zeniv-ca.linux.org.uk>
 <8d9e4f7c-bcf4-2751-9978-6283cabeda52@kernel.dk>
 <YTrN16wu/KE0X/QZ@zeniv-ca.linux.org.uk>
 <YTrP0EbPaZ4c67Ij@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4f9960f0-26bd-5972-3dcf-f2e2d63ea283@kernel.dk>
Date:   Thu, 9 Sep 2021 21:28:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YTrP0EbPaZ4c67Ij@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/9/21 9:24 PM, Al Viro wrote:
> On Fri, Sep 10, 2021 at 03:15:35AM +0000, Al Viro wrote:
>> On Thu, Sep 09, 2021 at 09:06:58PM -0600, Jens Axboe wrote:
>>> On 9/9/21 8:48 PM, Al Viro wrote:
>>>> On Thu, Sep 09, 2021 at 07:35:13PM -0600, Jens Axboe wrote:
>>>>
>>>>> Yep ok I follow you now. And yes, if we get a partial one but one that
>>>>> has more consumed than what was returned, that would not work well. I'm
>>>>> guessing that a) we've never seen that, or b) we always end up with
>>>>> either correctly advanced OR fully advanced, and the fully advanced case
>>>>> would then just return 0 next time and we'd just get a short IO back to
>>>>> userspace.
>>>>>
>>>>> The safer way here would likely be to import the iovec again. We're
>>>>> still in the context of the original submission, and the sqe hasn't been
>>>>> consumed in the ring yet, so that can be done safely.
>>>>
>>>> ... until you end up with something assuming that you've got the same
>>>> iovec from userland the second time around.
>>>>
>>>> IOW, generally it's a bad idea to do that kind of re-imports.
>>>
>>> That's really no different than having one thread do the issue, and
>>> another modify the iovec while it happens. It's only an issue if you
>>> don't validate it, just like you did the first time you imported. No
>>> assumptions need to be made here.
>>
>> 	It's not "need to be made", it's "will be mistakenly made by
>> somebody several years down the road"...
> 
> E.g. somebody blindly assuming that the amount of data read the last
> time around will not exceed the size of reimported iov_iter.  What I'm
> saying is that there's a plenty of ways to fuck up in that direction,
> and they will *not* be caught by normal fuzzers.

If the plan pans out, it's literally doing the _exact_ same thing that
we did originally. No assumptions are made about the contents of the
iovecs originally passed in, none of that state is reused. It's an
identical import to what was originally done.

I'm not saying it's trivial, but as long as the context is correct, then
it really should be pretty straight forward...

> I'm not arguing in favour of an uncoditional copy, BTW - I would like
> to see something resembling profiling data, but it's obviously not a
> pretty solution.

I can tell you right now that it's unworkable, it'll be a very
noticeable slowdown. And it's very much a case of doing the slow path
for the extreme corner case of ever hitting this case. For most
workloads, you'll _never_ hit it. But we obviously have to be able to do
it, for the slower cases (like SCSI with low QD, it'd trigger pretty
easily).

-- 
Jens Axboe

