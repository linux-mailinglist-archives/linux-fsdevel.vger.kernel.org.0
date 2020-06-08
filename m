Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979551F20C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 22:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgFHUjj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 16:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgFHUji (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 16:39:38 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65BEC08C5C2;
        Mon,  8 Jun 2020 13:39:38 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id 9so18150320ilg.12;
        Mon, 08 Jun 2020 13:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mAd7JhAYZMVc6azRedxEagiqORK5Ua8BgpxjO80A5sw=;
        b=UHsda/nq/tocnJpXaz48+0UUq3ASGfUjn4tNAYeG/xaeocjlBn2o4A4MjKoE9qtiYb
         tp91lX2DXnF65+3i+AbqrhSSu4Cll/hvs6nOZxhSSNhj3QrgbciCv0FJIHScxDiXaloR
         4lpnX/j9lHGSRkCNzIEfxS4T3Jt+CuJaZ8jAVgV7O8izE5peHyAnjOr0v61SBerRzYon
         JppXIXwn6s3Ptm79N9RymAFqyQNqjVvA5mZKpP8KOpM5LLdXiBqYt7etEfuKsAuVSM8m
         dVh4ZAd7H95Xstg8agThOZdYV02xzOknaDKjn2bkHbeviTlDJw1xfyRauycQ0C2+CcJ4
         4rOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mAd7JhAYZMVc6azRedxEagiqORK5Ua8BgpxjO80A5sw=;
        b=de5EPTmxo906HUaNtdpFA/89SaSvsYPNaR5FBtCkmaTTuLiXqVMAJidUgLczWwiSvh
         etlLUTnkmLlaoJleG2LXRGvDG9Klgy64nNbrH4BhFzxv9gICA8fcIyYIzpRd6/tIJ7sZ
         2WUEJb6iEZErhyEvbTkUunkGi6dLoOUFUkXaFPNU2NRrZaWFFUSH2S57ZiocX6nGPSvH
         Q7BlySZ/XrgP7XeSL8V9IYNC8STxgJIuRrAEtDHGfzBseiPQ4TbtIEavDBLX1pdNrrT5
         zXJC2IhNeeZFDLMxxD6Oa+3Kdh229HWkYPxR9okyVX7OylBR0YFPCACKkDWsQzFfi8bV
         +aoQ==
X-Gm-Message-State: AOAM531E+dHpo9wbLHo0PVinCksZ5NEFlEqLFCFtEi8cZi8pBrAeZ91X
        0y6IVlrWGOCXtz2ef8K0nztAnGSuq5evb1EJpWA=
X-Google-Smtp-Source: ABdhPJxZWFfpRNGaoX+lQ2NYh8itWT3KdUcyN8Jm9dD/Brla+2iSKMKo3BgV321CFSeiNOUkHsAUF0X8dAzlFzflppE=
X-Received: by 2002:a92:1b86:: with SMTP id f6mr24270089ill.9.1591648778156;
 Mon, 08 Jun 2020 13:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200608140557.GG3127@techsingularity.net> <CAOQ4uxhb1p5_rO9VjNb6assCczwQRx3xdAOXZ9S=mOA1g-0JVg@mail.gmail.com>
 <20200608160614.GH3127@techsingularity.net> <CAOQ4uxh=Z92ppBQbRJyQqC61k944_7qG1mYqZgGC2tU7YAH7Kw@mail.gmail.com>
 <20200608180130.GJ3127@techsingularity.net> <CAOQ4uxgcUHuqiXFPO5mX=rvDwP-DOoTZrXvpVNphwEMFYHtyCw@mail.gmail.com>
In-Reply-To: <CAOQ4uxgcUHuqiXFPO5mX=rvDwP-DOoTZrXvpVNphwEMFYHtyCw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 8 Jun 2020 23:39:26 +0300
Message-ID: <CAOQ4uxhbE46S65-icLhaJqT+jKqz-ZdX=Ypm9hAt9Paeb+huhQ@mail.gmail.com>
Subject: Re: [PATCH] fsnotify: Rearrange fast path to minimise overhead when
 there is no watcher
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 8, 2020 at 9:12 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> > > > didn't look too closely at your series as I'm not familiar with fsnotify
> > > > in general. However, at a glance it looks like fsnotify_parent() executes
> > > > a substantial amount of code even if there are no watchers but I could
> > > > be wrong.
> > > >
> > >
> > > I don't about substantial, I would say it is on par with the amount of
> > > code that you tries to optimize out of fsnotify().
> > >
> > > Before bailing out with DCACHE_FSNOTIFY_PARENT_WATCHED
> > > test, it also references d_inode->i_sb,  real_mount(path->mnt)
> > > and fetches all their ->x_fsnotify_mask fields.
> > >
> > > I changed the call pattern from open/modify/... hooks from:
> > > fsnotify_parent(...);
> > > fsnotify(...);
> > >
> > > to:
> > > fsnotify_parent(...); /* which calls fsnotify() */
> > >
> > > So the NULL marks optimization could be done in beginning of
> > > fsnotify_parent() and it will be just as effective as it is in fsnotify().
> > >
> >
> > Something like that may be required because
> >
> >                               5.7.0                  5.7.0                  5.7.0                  5.7.0
> >                             vanilla      fastfsnotify-v1r1      fastfsnotify-v2r1          amir-20200608
> > Amean     1       0.4837 (   0.00%)      0.4630 *   4.27%*      0.4597 *   4.96%*      0.4967 *  -2.69%*
> > Amean     3       1.5447 (   0.00%)      1.4557 (   5.76%)      1.5310 (   0.88%)      1.6587 *  -7.38%*
> > Amean     5       2.6037 (   0.00%)      2.4363 (   6.43%)      2.4237 (   6.91%)      2.6400 (  -1.40%)
> > Amean     7       3.5987 (   0.00%)      3.4757 (   3.42%)      3.6543 (  -1.55%)      3.9040 *  -8.48%*
> > Amean     12      5.8267 (   0.00%)      5.6983 (   2.20%)      5.5903 (   4.06%)      6.2593 (  -7.43%)
> > Amean     18      8.4400 (   0.00%)      8.1327 (   3.64%)      7.7150 *   8.59%*      8.9940 (  -6.56%)
> > Amean     24     11.0187 (   0.00%)     10.0290 *   8.98%*      9.8977 *  10.17%*     11.7247 *  -6.41%*
> > Amean     30     13.1013 (   0.00%)     12.8510 (   1.91%)     12.2087 *   6.81%*     14.0290 *  -7.08%*
> > Amean     32     13.9190 (   0.00%)     13.2410 (   4.87%)     13.2900 (   4.52%)     14.7140 *  -5.71%*
> >
> > vanilla and fastnotify-v1r1 are the same. fastfsnotify-v2r1 is just the
> > fsnotify_parent() change which is mostly worse and may indicate that the
> > first patch was reasonable. amir-20200608 is your branch as of today and
> > it appears to introduce a substantial regression albeit in an extreme case
> > where fsnotify overhead is visible. The regressions are mostly larger
> > than noise with the caveat it may be machine specific given that the
> > machine is overloaded. I accept that adding extra functional to fsnotify
> > may be desirable but ideally it would not hurt the case where there are
> > no watchers at all.
> >
>
> Of course.
> And thanks for catching this regression even before I posted the patches :-)
>
> > So what's the right way forward? The patch as-is even though the fsnotify()
> > change itself may be marginal, a patch that just inlines the fast path
> > of fsnotify_parent or wait for the additional functionality and try and
> > address the overhead on top?
> >
> >
>
> Let me add your optimizations on top of my branch with the needed
> adaptations and send you a branch for testing.

https://github.com/amir73il/linux/commits/fsnotify_name-for-mel

Cheers,
Amir.
