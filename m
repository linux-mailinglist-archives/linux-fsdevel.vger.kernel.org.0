Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC5734DC6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 01:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhC2XZ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Mar 2021 19:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhC2XZ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Mar 2021 19:25:28 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EE3C061762
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Mar 2021 16:25:28 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so13876301otb.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Mar 2021 16:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kfopmyrbr/GcMHD9psmtDMqZjT1PfgeegTPCEU08EiE=;
        b=J7Fblzrr8H0/D0Vgsenq6S9RHUn3tBJEFubecR2cTg2QQjk95Lrnx74t0afFYBOhJZ
         HRKP1mIY75YS6ayguV98qH764d0jinlSSBNl2tinFVLcnqAsjTkoAyQTO/4v7ucnL/uH
         tE+ftAWh6Ygdsc2wSiR6Q3d/k09NBjViAfjavj0q+YOuc0QOV7LLV2mtbCiiOKntEHeS
         PvVdNMXJy/AU4/rSSBF//RdnNmnxXW7PIuhbGtFkZ0lriylLxVRIQu3HV1oU3E2uae8a
         zJYntg25CiGrjH7JCnY1nvwLaF58hQySL4Q6CzNtLAwaniSqmFH6r3ojC50jpBBMYYpD
         5Lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kfopmyrbr/GcMHD9psmtDMqZjT1PfgeegTPCEU08EiE=;
        b=MT03pL05pYVOHOqo35xcFhBZjCvrSoEKRX4qVLlLZ9GRJtR3CPEk4s8cainFDVOxyo
         V1XxiSIb62uEVS/Hif2Gfpw3SlMaiwNUrHWq7RdnGNoNTtzkgJ2IvlazueMSAPP+ptQX
         ulIZ99Ok5DEYr3iYRHsPqjFiSpx0NOexjgdImnMiUz6hbUK8r3hoKLHqccXW5ZYrfTUn
         qP3T+M9puHIaxqwiZw6HJKRLyvWagp8grXIpF8mbuNmSKQKt98Lhmc/ezPjn/V7h8qUB
         jOHJRUjQKHohjz4vW0SLmTDlEmKWjy2lPWtQ7j8QKGv1nnjiMa7rVN1QCKN0+8SpAhyD
         udkQ==
X-Gm-Message-State: AOAM530zQ90ge0Hvt9+92mT4U3OC1jVQthuCOO/bQdF0KhccQpRg+GMQ
        5DghRnRazvsBp1ZdtvbhRxE1v3B6uQVIAT90HVazYK8010Hr1BFK
X-Google-Smtp-Source: ABdhPJwUrIUAlEIYdNAUESbil7h2HVIKRjM6HWFIgZe1ZW5L6ERaodz/BIujBTfrM9IKHrSELrCestMSKZhV0HUnDJE=
X-Received: by 2002:a9d:bc9:: with SMTP id 67mr25187355oth.352.1617060327832;
 Mon, 29 Mar 2021 16:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210327035019.GG1719932@casper.infradead.org>
 <CAOg9mSTQ-zNKXQGBK9QEnwJCvwqh=zFLbLJZy-ibGZwLve4o0w@mail.gmail.com>
 <20210201130800.GP308988@casper.infradead.org> <CAOg9mSSd5ccoi1keeiRfkV+esekcQLxer9_1iZ-r9bQDjZLfBg@mail.gmail.com>
 <CAOg9mSSEVE3PGs2E9ya5_B6dQkoH6n2wGAEW_wWSEvw0LurWuQ@mail.gmail.com>
 <2884397.1616584210@warthog.procyon.org.uk> <CAOg9mSQMDzMfg3C0TUvTWU61zQdjnthXSy01mgY=CpgaDjj=Pw@mail.gmail.com>
 <1507388.1616833898@warthog.procyon.org.uk> <20210327135659.GH1719932@casper.infradead.org>
 <CAOg9mSRCdaBfLABFYvikHPe1YH6TkTx2tGU186RDso0S=z-S4A@mail.gmail.com>
 <20210327155630.GJ1719932@casper.infradead.org> <CAOg9mSSxrPEd4XsWseMOnpMGzDAE5Pm0YHcZE7gBdefpsReRzg@mail.gmail.com>
 <CAOg9mSSaDsEEQD7cwbsCi9WA=nSAD78wSJV_5Gu=Kc778z57zA@mail.gmail.com> <1720948.1617010659@warthog.procyon.org.uk>
In-Reply-To: <1720948.1617010659@warthog.procyon.org.uk>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Mon, 29 Mar 2021 19:25:17 -0400
Message-ID: <CAOg9mSTEepP-BjV85dOmk6hbhQXYtz2k1y5G1RbN9boN7Mw3wA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] implement orangefs_readahead
To:     David Howells <dhowells@redhat.com>,
        Mike Marshall <hubcap@omnibond.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David>> Um - which patches?

fscache-iter from
https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git

When the top commit was
cachefiles: Don't shorten if over 1G: ff60d1fc9c7cb93d53d1d081f65490ff4ab2f122

followed by a bunch of commits up to
iov_iter: Add ITER_XARRAY: 153907f0e36425bdefd50182ca9733d8bc8e716a

And after that it was Linus' 5.12-rc2 tree...
Linux 5.12-rc2: a38fd8748464831584a19438cbb3082b5a2dab15

You were posting patches from there on fs-devel, and I was
reading your messages and knew what I needed was included there.
When you asked me to try iov_iter_xarray I looked for it
in your git tree instead of peeling it out of my
gmail. Perhaps I got more stuff than you intended...

I did    git format-patch a38fd874..ff60d1fc
and added that to my Linux 5.12-rc4 tree to make my orangefs_readahead
patch that uses readahead_expand.

-Mike

On Mon, Mar 29, 2021 at 5:37 AM David Howells <dhowells@redhat.com> wrote:
>
> Mike Marshall <hubcap@omnibond.com> wrote:
>
> > Then I got rid of David's patches, I'm at
> > generic Linux 5.12-rc4, and am no longer
> > failing those tests.
>
> Um - which patches?
>
> David
>
