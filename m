Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84034400729
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 22:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349516AbhICU4c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 16:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236849AbhICU4a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 16:56:30 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D880FC061757
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Sep 2021 13:55:29 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so354598pjw.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Sep 2021 13:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DJWNbah1vQRHs6Y2VZVGVoYhyj2trOxIMnnDdxrfdZw=;
        b=wP2IGzJzEHtLk8pslL2GlBpdmdQTvmt68Jp6xUeK5Ofa+gxxYt3loubGwsLb7ZaDem
         +uG9QHafPyZQcrGM6HUrOuoPcK70f6u+0tFJdr5uhrJFw0NeRTWqgZHqehDtO6bSnTOs
         3067J+ZHXzj3CSe7E0+Xvt1LfzCc+yLfEZJZ0w6jJdp2SB63OsauNpVLaBIBfHIpuVYZ
         X4FO7M8vjUQenUsB92CqRCZksqWm5Vpc7u4OL69M53vgwK22UB3wP6ozaxxBqYt9yuHH
         TfFR/lHo7Wqa13q4D/i4Uu3AxkOCFVCP7fcpwCaFFBYor2vK4M1oDafdGtyGI7iA40ZH
         /NCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DJWNbah1vQRHs6Y2VZVGVoYhyj2trOxIMnnDdxrfdZw=;
        b=HNyqgrlR0hbKnYXmXSA71i7BrpnNdbE9kHMGnmCWXsgGy8RY7+9gzwtjRoKLKLBUxA
         J+RJxIwoZPi8o0Y0tmzvjGuHv4fuPuZaGEV0phV2ZCkF3nlendy+jpGyswrrYcieWWxA
         ErrFWeksaxBGybA9iUUpVIkGLIG2ZA0ITuH4e0QyJVgREFruL1Bb3uUq8CzBXFPWBD5R
         8zImz+y9xK0oyIfL4/CNjTQkcwk9lpfbEHgUgzzvRFC8CF5YrQ55zZBQ6D/szSbKvU92
         ML9Cq6xxZBzB6OrNT3vwKeY3B0VGHkvcca6gJlrmwMG5cdG1CngVz24nmAZe05gPaOD1
         VDqw==
X-Gm-Message-State: AOAM530ApJzs0RVw017epALw2/JE0+fxHeAmHWtG67ybWkgWcXaly+v2
        59IFWt+1LhvMpLECeEDt1EzFJw==
X-Google-Smtp-Source: ABdhPJxSKZZvEzoiBKtOJMsYAeeNgQzpmfzFds0q+qil8k3cdzIwypjxiJ67PupCJP3EAiFgdWnc4g==
X-Received: by 2002:a17:90a:d596:: with SMTP id v22mr822204pju.51.1630702529188;
        Fri, 03 Sep 2021 13:55:29 -0700 (PDT)
Received: from ?IPv6:2600:380:7567:4da9:ea68:953f:1224:2896? ([2600:380:7567:4da9:ea68:953f:1224:2896])
        by smtp.gmail.com with ESMTPSA id t9sm257946pfe.73.2021.09.03.13.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 13:55:28 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] iter revert problems
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Palash Oswal <oswalpalash@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel@vger.kernel.org,
        syzbot+9671693590ef5aad8953@syzkaller.appspotmail.com
References: <cover.1629713020.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <65d27d2d-30f1-ccca-1755-fcf2add63c44@kernel.dk>
Date:   Fri, 3 Sep 2021 14:55:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1629713020.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/23/21 4:18 AM, Pavel Begunkov wrote:
> iov_iter_revert() doesn't go well with iov_iter_truncate() in all
> cases, see 2/2 for the bug description. As mentioned there the current
> problems is because of generic_write_checks(), but there was also a
> similar case fixed in 5.12, which should have been triggerable by normal
> write(2)/read(2) and others.
> 
> It may be better to enforce reexpands as a long term solution, but for
> now this patchset is quickier and easier to backport.
> 
> v2: don't fail if it was justly fully reverted
> v3: use truncated size + reexapand based approach

Al, let's get this upstream. How do you want to handle it? I can take
it through the io_uring tree, or it can go through your tree. I really
don't care which route it takes, but we should get this upstream as
it solves a real problem.

-- 
Jens Axboe

