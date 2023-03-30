Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E9A6D1208
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 00:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjC3WTX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 18:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjC3WTB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:19:01 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF683B74B
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 15:19:00 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id l184so3182715pgd.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 15:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680214740; x=1682806740;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IjjefT2+aXSKyOUtfLh+a7ePsKI6CeWadLruiteIuqw=;
        b=zcrZRIjWFV7Z6mlDwjvX5XW+HFVUzCbtqmgYA4D0a9yXXN0fNgs9RvqoGcsTMcLG7/
         blTRmXi1rdyBbsqN/99PhN1HkxcpaQbxxO4dD+XRVm2nvuwDKT4cX7nbD7fIhrwaEjf5
         5H9S14mIL78MHYNKIVgOF8ifvRpTPx8VVVnE4o/emmNZlOB0oXM4ldRC3rhksNWkKA+n
         lJP9/QPBq7lkBCRWPQCvyYDYH5O2Qr3wcyy4kxsrGdyuePGxy05iH04CefAq3KigbkuO
         RWNzQy3dmLs+3TOnAiQnTS/cgi4KPTYNODBpKgGmTC9hvaHRmCDjSqyw2Vo1tKoyTgrO
         3YkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680214740; x=1682806740;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IjjefT2+aXSKyOUtfLh+a7ePsKI6CeWadLruiteIuqw=;
        b=XaF7L2duMfowbMpk+ftUgghXFPD7Lbz5CnR0d3YC0wC8vvK2vAPAvqtkqNsdy2Sf1R
         hysFFz7GhGEdPHmpmXu+XBR/xT6GPh6CUAXsSBCfRcNiYSrxAd1K9Kg/obn/NxP4GPxl
         sHiReuuMSE3hySKWzS+J/oFEW7mvgGvpT+p3p2oV22PGMNhsPQdTy0qZwVkqafXDgVdR
         KvyUbRRd9fg64yxFjW76c78fi0QxrHzj8wdhAsNxuLLCMCNbxYxFosImfIxTVaPi0B2E
         GQ2OoikQa2aYbaQKl73OCauT9gu4Sqd2cTWpwMzgsk+Ug8y2Po2VN2eXSAe+vL8fOZpt
         cywA==
X-Gm-Message-State: AAQBX9eJRbJVrP0voc04Z8p0BIAQVwXQucWlc6a1qsKe65ikOVp+tdYq
        4u0R031NUJPp5cfWLe/iU8Zwl6K3dqWnLBCOJ4A8HQ==
X-Google-Smtp-Source: AKy350a7N61bvPiNG/c2wtamiGhFhmeJipxSd5pvtDx7K6OESzf0T6Xh+Mka8TIhqCsOdAsqHamnJA==
X-Received: by 2002:aa7:86d1:0:b0:62d:e32a:8b5a with SMTP id h17-20020aa786d1000000b0062de32a8b5amr42074pfo.2.1680214740171;
        Thu, 30 Mar 2023 15:19:00 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id r18-20020a62e412000000b005a8ba70315bsm379325pfh.6.2023.03.30.15.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 15:18:59 -0700 (PDT)
Message-ID: <df0f88e5-c0af-5d50-bdd5-b273218861bf@kernel.dk>
Date:   Thu, 30 Mar 2023 16:18:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCHSET v6b 0/11] Turn single segment imports into ITER_UBUF
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
References: <20230330164702.1647898-1-axboe@kernel.dk>
 <CAHk-=wgmGBCO9QnBhheQDOHu+6k+OGHGCjHyHm4J=snowkSupQ@mail.gmail.com>
 <de35d11d-bce7-e976-7372-1f2caf417103@kernel.dk>
 <CAHk-=wiC5OBj36LFKYRONF_B19iyuEjK2WQFJpyZ+-w39mEN-w@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wiC5OBj36LFKYRONF_B19iyuEjK2WQFJpyZ+-w39mEN-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/30/23 3:53 PM, Linus Torvalds wrote:
> On Thu, Mar 30, 2023 at 10:33 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> That said, there might be things to improve here. But that's a task
>> for another time.
> 
> So I ended up looking at this, and funnily enough, the *compat*
> version of the "copy iovec from user" is actually written to be a lot
> more efficient than the "native" version.
> 
> The reason is that the compat version has to load the data one field
> at a time anyway to do the conversion, so it open-codes the loop. And
> it does it all using the efficient "user_access_begin()" etc, so it
> generates good code.
> 
> In contrast, the native version just does a "copy_from_user()" and
> then loops over the result to verify it. And that's actually pretty
> horrid. Doing the open-coded loop that fetches and verifies the iov
> entries one at a time should be much better.
> 
> I dunno. That's my gut feel, at least. And it may explain why your
> "readv()" benchmark has "_copy_from_user()" much higher up than the
> "read()" case.
> 
> Something like the attached *may* help.
> 
> Untested - I only checked the generated assembly to see that it seems
> to be sane, but I might have done something stupid. I basically copied
> the compat code, fixed it up for non-compat types, and then massaged
> it a bit more.

That's a nice improvement - about 6% better for the single vec case,
And that's the full "benchmark". Here are the numbers in usec for
the read-zero. Lower is better, obviously.

-git
1793883
1809305
1782602
1777280
1803978
1798792
1791190
1802017
1804558
1813370
1807696
1785887
1785506
1789876
1780018
1793932
1803655
1798186

-git+patch
1685393
1685891
1688886
1679967
1687551
1693233
1684883
1688779
1682103
1684944
1686928
1687984
1686729
1687009
1684660
1687295
1684893
1685309

-- 
Jens Axboe


