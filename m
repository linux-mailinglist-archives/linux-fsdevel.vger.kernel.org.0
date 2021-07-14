Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067D53C833D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 12:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238368AbhGNKxG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 06:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbhGNKxF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 06:53:05 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E97C06175F;
        Wed, 14 Jul 2021 03:50:12 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id n14so2842613lfu.8;
        Wed, 14 Jul 2021 03:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ydJrW4zIZfpmcsGuzesK/aUPaVGvU/zLXj9XHjifBxY=;
        b=IG/XvgWJtHCXeK76Potz7Lfi2KPs0IPnN1Tp98jH01Ev40LnnaRLU7u9CU3Hd8wza+
         K7CdbROLwk/aUeM/l+ChAFTJLD1PBWLZxFDgs7o98kHOii0hz2eKy4+phujLC0cpOVvF
         khOWmNP2+2rUFcvt0hUchmt8mx7tpcYYKMTMkKnqN7ctrKvY5vHuQGYglGWXqYCzCE1v
         x/qjU7hF5knBrGr1FmmwMeyccKWuM9M1TksEL0vyEGdx8Hy0V1d3K+/AAN4mlN4CRJqf
         9C0TwvTMnS/o9FoH0OVW/EVOq2W5v+k2a6uyLj6sYM2MOeqVU2tkUST6K5FFhgzUCtSd
         0yGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ydJrW4zIZfpmcsGuzesK/aUPaVGvU/zLXj9XHjifBxY=;
        b=lEQljl9yzAQhMfkPGgzgxd7MK/hfUraNec5cCViLKyp+hHgB+KGFj6tuK+k71KQI4Z
         oFLdjzttLu/hp27t+2B7YXFeEiaRe1LFuJZ6vRY+8eGf16Ngqcp25u/6MCkFjbULDZ7R
         dcnkHVaUv3LsGoRtRtYSIGR5dTXHvYS1FS2mjNXcfYKUqrE79LpM3wDHOGMciDBkMDmj
         jjvhys4u1gsM8v6XpNtQ5Vw/Q6tMm/It3qORU5pQb4WmJ7FV+/QNSvDvKo7LlA8Auivb
         D3tB4d0Byo1nMnZRNbis2WOm6ktUCz8XsJ0qfKMoKtP9qFTRH8J2sPdtcI+9QqMHP9Q8
         u1EA==
X-Gm-Message-State: AOAM5316k/HzQvv/7WMYiQTPCzdVk4G0hnx/LGFWl7SMfDqW9O/o+zXo
        +ywjoO+3y/7tIABijCN1kUKMBXtWeCU=
X-Google-Smtp-Source: ABdhPJxMyDS1zlR0PPsl+Gz2STqLAbgoHT71r8MiHltMCYUL+2PeDKDqDmRtS64mViFQ10fqDRTMWA==
X-Received: by 2002:ac2:410a:: with SMTP id b10mr7149090lfi.376.1626259811267;
        Wed, 14 Jul 2021 03:50:11 -0700 (PDT)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id n27sm136523lfh.99.2021.07.14.03.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 03:50:10 -0700 (PDT)
Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <30c7ec73-4ad5-3c4e-4745-061eb22f2c8a@redhat.com>
 <CAHk-=wjW7Up3KD-2EqVg7+ca8Av0-rC5Kd7yK+=m6Dwk3D4Q+A@mail.gmail.com>
 <YO30DKw5FKLz4QuF@zeniv-ca.linux.org.uk>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <bea2bcf2-02f6-f247-9e06-7b9ec154377a@gmail.com>
Date:   Wed, 14 Jul 2021 12:50:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YO30DKw5FKLz4QuF@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Alexander,

On 13.07.2021 22:14, Al Viro wrote:
> To elaborate a bit - there's one case when I want it to go through
> vfs.git, and that's when there's an interference between something
> going on in vfs.git and the work done in filesystem.  Other than
> that, I'm perfectly fine with maintainer sending pull request directly
> to Linus (provided that I hadn't spotted something obviously wrong
> in the series, of course, but that's not "I want it to go through
> vfs.git" - that's "I don't want it in mainline until such and such
> bug is resolved").

let me take this opportunity to ask about another filesystem.

Would you advise to send pull req for the fs/ntfs3 directly to Linus?

That is a pending filesystem that happens to be highly expected by many
Linux focused communities.


Paragon Software GmbH proved it's commitment by sending as many as 26
versions on it's patchset. The last set was send early April:

[PATCH v26 00/10] NTFS read-write driver GPL implementation by Paragon Software
https://marc.info/?l=linux-fsdevel&m=161738417018673&q=mbox
https://patchwork.kernel.org/project/linux-fsdevel/list/?series=460291


I'd say there weren't any serious issues raised since then.

One Tested-by, one maintenance question, one remainder, one clang-12
issue [0] [1].

It seems this filesystem only needs:
1. [Requirement] Adjusting to the meanwhile changed iov API [2]
2. [Clean up] Using fs/iomap/ helpers [3]


[0] https://marc.info/?t=161738428400012&r=1&w=2
[1] https://marc.info/?t=162143182800001&r=1&w=2
[2] https://marc.info/?l=linux-fsdevel&m=162607857810008&w=2
[3] https://marc.info/?l=linux-fsdevel&m=162152950315047&w=2
