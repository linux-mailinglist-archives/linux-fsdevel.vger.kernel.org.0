Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2EA43FF6AD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 23:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347580AbhIBV45 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 17:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347567AbhIBV4n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 17:56:43 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E136C0613D9
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Sep 2021 14:55:39 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y34so7457664lfa.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Sep 2021 14:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1OGY0A1bmZf1fxvWkbRm6Nt7GcmJzJ4PCA9tMxUQzJU=;
        b=L34pszxLvaK1/ThKDYqV097bwVi8n2QR0jDIHeafcSSoPQ9z8W+i4niPigybjSIJqH
         dFiDtYwNyV56xL39aIJBQy+mTx3awcN1DVNd15K9XDNl52+jJzM/lNcR26w39F121YK1
         e7Vu0mceRcUbTfqKirHJsqCLxbSujeusdES90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1OGY0A1bmZf1fxvWkbRm6Nt7GcmJzJ4PCA9tMxUQzJU=;
        b=fHdlJ6mev3MPjmmrQa0Q6ft5+nc0SZ8cs56KYnQzZPrPmfq4jS/LvfFUp9zit1rqNB
         XTP8jXAornkigTOld9H+GIXJ/OAGKmP+KqesTUTP1Fq7IfsEJUAv5df4enMhsDjVgVK8
         Fgxk81dXfIXu8g28DuMiKHWRQAIYGEBTkUJyvJFp4p60hv53QHRATpb/Dd8OKcngbnBG
         FM/m+o2hO5oJZ/y02wztPL4dDtimT4HW4lXBZFWBpM4tQS1FbgkJBgPYOe9WvQuDmtMW
         pW0fe0Bwy0uh8YoU5mytt5YX342hH510rGODIUVXp27y97THnFLXZwEkWnBiuNad7xmE
         mrHg==
X-Gm-Message-State: AOAM530MFRp+exGma53/qVLqCkW3Pvz7ftKMKTLViwnRrkAuLpGskuve
        q8xpfoMLEIstlxFqR+/kF5lFwh0lT0B9INqUpMU=
X-Google-Smtp-Source: ABdhPJykA4FcwuFcHw9zoISKMkElMX3hvcKswOcRJ+K5012lh7AAjInChqNQ1b+i4G47dwuv4YctlA==
X-Received: by 2002:a19:f616:: with SMTP id x22mr210980lfe.239.1630619737306;
        Thu, 02 Sep 2021 14:55:37 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id r23sm362277ljd.86.2021.09.02.14.55.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 14:55:36 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id z2so7494863lft.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Sep 2021 14:55:36 -0700 (PDT)
X-Received: by 2002:a05:6512:128a:: with SMTP id u10mr229751lfs.40.1630619736152;
 Thu, 02 Sep 2021 14:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <4e8c0640-d781-877c-e6c5-ed5cc09443f6@gmail.com>
 <20210716114635.14797-1-papadakospan@gmail.com> <CAHk-=whfeq9gyPWK3yao6cCj7LKeU3vQEDGJ3rKDdcaPNVMQzQ@mail.gmail.com>
 <afd62ae457034c3fbc4f2d38408d359d@paragon-software.com> <CAHk-=wjn4W-7ZbHrw08cWy=12DgheFUKLO5YLgG6in5TA5HxqQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjn4W-7ZbHrw08cWy=12DgheFUKLO5YLgG6in5TA5HxqQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Sep 2021 14:55:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg7GMGD1YNM7WgPAU3nwHhMAvQ8yvdwvJtuwe9J1pBgvg@mail.gmail.com>
Message-ID: <CAHk-=wg7GMGD1YNM7WgPAU3nwHhMAvQ8yvdwvJtuwe9J1pBgvg@mail.gmail.com>
Subject: Re: Paragon NTFSv3 (was Re: [GIT PULL] vboxsf fixes for 5.14-1)
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        "zajec5@gmail.com" <zajec5@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 30, 2021 at 10:23 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Well, I won't pull until the next merge window opens anyway (about a
> month away). But it would be good to have your tree in linux-next for
> at least a couple of weeks before that happens.
>
> Added Stephen to the participants list as a heads-up for him - letting
> him know where to fetch the git tree from will allow that to happen if
> you haven't done so already.

Ok, so I've merged the biggest pieces of this merge window, and I
haven't actually seen a NTFSv3 pull request yet.

I wonder if you expected that being in linux-next just "automatically"
causes the pull to happen, because that's not the case. We often have
things "brewing" in linux-next for a while, and it's there for testing
but not necessarily ready for prime time.

So linux-next is a preparatory thing, not a "this will get merged"

So to actually merge things, I will expect to get an explicit pull
request with the usual diffstat and shortlog, to show that yes, you
really think it's all good, and it's ready to merge.

Don't worry about - and don't try to fix - merge conflicts with
possible other work that has been going on. Stephen fixes it for
linux-next and makes people aware of it, and I want to _know_ about
them, but I will then handle and re-do the merge conflicts myself
based on what I have actually merged up to that point.

And of course, the other side of that is that if linux-next uncovered
other issues, or if there are things holding things up, please _don't_
feel obligated to send me a pull request. There is always the next
merge window.

            Linus
