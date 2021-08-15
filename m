Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28123ECB0B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Aug 2021 22:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhHOU5o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Aug 2021 16:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhHOU5o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Aug 2021 16:57:44 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D2CC061764;
        Sun, 15 Aug 2021 13:57:13 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f12-20020a05600c4e8c00b002e6bdd6ffe2so7740065wmq.5;
        Sun, 15 Aug 2021 13:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N+RSkbR/hHzUCHT5t8wyCh3F2FjA9tgELrVsLHPO2kA=;
        b=JcRLzyU0sK/7VSGnmBHM+luEPDDpxSnZP1R0m6pEuzguIKmcBYkRsYvW6/xO+v4ubB
         rJRJXrTu2czOAMy0T+tyisoHMi36sak9vi8d650qX9hWPeCqejicflOxOLOsNUq4CL/G
         aRNODXioJKU2JDMRm/00b0GhqzMnTMTHAOn5ee/Bj9rvBmVpMT45xn5WDiVHJVw17ONP
         Elm1/DVh6pAAVUFbznUcE+bLWQDGxCdIPPhBgDdTyNgtOpDkauhDogDKpnpNmIUG9xoS
         GkVRoQ3ySFDJ3k5Jp+hBeswmdGSy1txnwjb8rFeWI1Bvb1GHJF9g5X92sr4O345zSaNb
         D0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N+RSkbR/hHzUCHT5t8wyCh3F2FjA9tgELrVsLHPO2kA=;
        b=E3B+mlXEBM3ZkXaxh1mVIRNS7s+iy7MnkJK9q/bMzerP8oFnEWwSwZsf42b0ACMDeM
         EZ9zM70LTzDHgfrnFaF/RDr/GTy7r+aWCt6zoE8vIWu/AVXDCcHLMJG9+ySnoZjP7QEW
         jJNdBZ3e5/SGhWQX0D9+yKftVkuOkLK+5zaRrwOyRD9200ADMbA0eWaPwhIw3VngmawN
         GYlAaF9bWTYQyFYIEtst6KXsXIguoX3jR0c2AcfIOjMSu2Ljkk6zuzYHNMgry723OgYs
         wjbtdj42MtulSqv4DsWT5LC5oOMj7dG/MbhgjjFZG0E4aW+3ZxfB9i2tZx9bex4QMhwQ
         4nLA==
X-Gm-Message-State: AOAM532IKyPKvcmoIPneGK+jDfrn+l5r7ZdTagYWSOP4FtsxdfieC9cR
        AM4l9QGvnZZA4PtTGsnzhVeUIgLHVXo=
X-Google-Smtp-Source: ABdhPJxP6LAZcWEHXDmig63n+ei2BtYED31hvym8d6tRgcAYriq2JV+wh8W189Uq2olsaWHOAJdKCw==
X-Received: by 2002:a1c:2b04:: with SMTP id r4mr12357507wmr.168.1629061032262;
        Sun, 15 Aug 2021 13:57:12 -0700 (PDT)
Received: from [192.168.178.40] (ipbcc187b7.dynamic.kabel-deutschland.de. [188.193.135.183])
        by smtp.gmail.com with ESMTPSA id r4sm7312702wmq.34.2021.08.15.13.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Aug 2021 13:57:11 -0700 (PDT)
Subject: Re: [GIT PULL] configfs fix for Linux 5.14
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Becker <jlbec@evilplan.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <YRdp2yz+4Oo2/zHy@infradead.org>
 <CAHk-=whh8F-9Q=h=V=bKczqfRPbUN_A3h21aVfkk2HNhCWF+Pw@mail.gmail.com>
From:   Bodo Stroesser <bostroesser@gmail.com>
Message-ID: <846641e9-682a-68f6-6967-6e3edc6f8ceb@gmail.com>
Date:   Sun, 15 Aug 2021 22:57:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whh8F-9Q=h=V=bKczqfRPbUN_A3h21aVfkk2HNhCWF+Pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14.08.21 18:27, Linus Torvalds wrote:
> On Fri, Aug 13, 2021 at 9:00 PM Christoph Hellwig <hch@infradead.org> wrote:
>>
>> configfs fix for Linux 5.14
>>
>>   - fix to revert to the historic write behavior (Bart Van Assche)
> 
> It would have been lovely to see what the problem was, but the commit
> doesn't actually explain that.
> 
> I suspect it's this
> 
>      https://lkml.org/lkml/2021/7/26/581

Yes. I hope I was able to describe the changed behavior sufficiently in
that mail.

Thank you,
Bodo

> 
> but there might have been more.
> 
>              Linus
> 
