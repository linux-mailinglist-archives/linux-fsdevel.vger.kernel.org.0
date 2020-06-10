Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA541F55B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 15:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgFJNYO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 09:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgFJNYO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 09:24:14 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E16C03E96B;
        Wed, 10 Jun 2020 06:24:14 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id c8so2137361iob.6;
        Wed, 10 Jun 2020 06:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PwlNjYivUWdKHcVIoPXfrF198UvAE89w19myI5A5i7o=;
        b=l9Wpn+af7SXh6JyAKNVX5t5CbMef7o2fQLQXpQgYy1fUr2Cn9Jyp+0FQy1ekQ/SacO
         Izu+QX5g7GNVnSfXhGBA/k2dnqHAkFQfwf0VZfUspRHyrRynKnUMrVJdS66UEByB1qkO
         7kVHecI8y1dhpzRb4jYa517WsS2DmCKE5D/41Vo6e9i8uvnsgSoMcxhxCam2M1CNwBrF
         g62IHCat6LcDSVy6OyyZmI2fFUWMMSQWn7rNkuSFjx1e6CO/2ASAbjjlfRnBuOflviAW
         r9eTDldNKgyHrF4VlDpge5ujKmSvnqVwDZzXiCFsjFqnPo1l7aLoTLQg0oVxRDACgO1K
         dpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PwlNjYivUWdKHcVIoPXfrF198UvAE89w19myI5A5i7o=;
        b=L1BE7KWSWnZ9VWESlE+EoyWktOFyl+Nog4jGFlBh0EblXH+fWxLreQpdLvT9ChHzZB
         PQExrI8wph6Z5CyokF4shYwGTyC4Qf346UahpZRdT7IVdqmLcTcmrumcOfAbXIjIyY85
         HWwRufI3Mswhj3/VMgqjjQS1qiiqWrn6g2ChfvWiqSJalLUHYFdl4uZv9vQgCngwYcJl
         AncDGRXiOrp1ngwS3114tFO68HEz67xgSc7K3VArlKlz5AsDr5+PplJy7Wgen2Va4p8y
         xSknktBd8w/8C4FdY/t2Dprzv1JGHbYsBtMkjLENvlNHmiiKH+9geEih4GR5kZsrAz+t
         +H2w==
X-Gm-Message-State: AOAM5338nDAR2DoThE5RTJ4KhjN1yqBAGyC8J+y3xVNESmo/vdcC8//Q
        nfnHa55HIkCZu25L0UJZf3HEKhtAq+Nch95BGrowZpNY
X-Google-Smtp-Source: ABdhPJxt2GympD6OjFk5mMgUySZlRz2/c4zqUBYKC4U+pOCDQb3tqjXgVgwb1MoXNUHZYhvHxo2hqgIzqyw672pbwok=
X-Received: by 2002:a05:6602:5c8:: with SMTP id w8mr3308477iox.64.1591795453388;
 Wed, 10 Jun 2020 06:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200608140557.GG3127@techsingularity.net> <CAOQ4uxhb1p5_rO9VjNb6assCczwQRx3xdAOXZ9S=mOA1g-0JVg@mail.gmail.com>
 <20200608160614.GH3127@techsingularity.net> <CAOQ4uxh=Z92ppBQbRJyQqC61k944_7qG1mYqZgGC2tU7YAH7Kw@mail.gmail.com>
 <20200608180130.GJ3127@techsingularity.net> <CAOQ4uxgcUHuqiXFPO5mX=rvDwP-DOoTZrXvpVNphwEMFYHtyCw@mail.gmail.com>
 <CAOQ4uxhbE46S65-icLhaJqT+jKqz-ZdX=Ypm9hAt9Paeb+huhQ@mail.gmail.com> <20200610125920.GM3127@techsingularity.net>
In-Reply-To: <20200610125920.GM3127@techsingularity.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 10 Jun 2020 16:24:02 +0300
Message-ID: <CAOQ4uxhcFO4=e-s7uStbEkZU==8kraD1=owZGu4SWx_iR72gTA@mail.gmail.com>
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

On Wed, Jun 10, 2020 at 3:59 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Mon, Jun 08, 2020 at 11:39:26PM +0300, Amir Goldstein wrote:
> > > Let me add your optimizations on top of my branch with the needed
> > > adaptations and send you a branch for testing.
> >
> > https://github.com/amir73il/linux/commits/fsnotify_name-for-mel
> >
>
> Sorry for the delay getting back. The machine was busy with other tests
> and it took a while to reach this on the queue. Fairly good news
>
> hackbench-process-pipes
>                               5.7.0                  5.7.0                  5.7.0                  5.7.0
>                             vanilla      fastfsnotify-v1r1          amir-20200608           amir-for-mel
> Amean     1       0.4837 (   0.00%)      0.4630 *   4.27%*      0.4967 *  -2.69%*      0.4680 (   3.24%)
> Amean     3       1.5447 (   0.00%)      1.4557 (   5.76%)      1.6587 *  -7.38%*      1.4807 (   4.14%)
> Amean     5       2.6037 (   0.00%)      2.4363 (   6.43%)      2.6400 (  -1.40%)      2.4900 (   4.37%)
> Amean     7       3.5987 (   0.00%)      3.4757 (   3.42%)      3.9040 *  -8.48%*      3.5130 (   2.38%)
> Amean     12      5.8267 (   0.00%)      5.6983 (   2.20%)      6.2593 (  -7.43%)      5.6967 (   2.23%)
> Amean     18      8.4400 (   0.00%)      8.1327 (   3.64%)      8.9940 (  -6.56%)      7.7240 *   8.48%*
> Amean     24     11.0187 (   0.00%)     10.0290 *   8.98%*     11.7247 *  -6.41%*      9.5793 *  13.06%*
> Amean     30     13.1013 (   0.00%)     12.8510 (   1.91%)     14.0290 *  -7.08%*     12.1630 (   7.16%)
> Amean     32     13.9190 (   0.00%)     13.2410 (   4.87%)     14.7140 *  -5.71%*     13.2457 *   4.84%*
>
> First two sets of results are vanilla kernel and just my patch respectively
> to have two baselines. amir-20200608 is the first git branch you pointed
> me to and amir-for-mel is this latest branch. Comparing the optimisation
> and your series, we get
>
> hackbench-process-pipes
>                               5.7.0                  5.7.0
>                   fastfsnotify-v1r1           amir-for-mel
> Amean     1       0.4630 (   0.00%)      0.4680 (  -1.08%)
> Amean     3       1.4557 (   0.00%)      1.4807 (  -1.72%)
> Amean     5       2.4363 (   0.00%)      2.4900 (  -2.20%)
> Amean     7       3.4757 (   0.00%)      3.5130 (  -1.07%)
> Amean     12      5.6983 (   0.00%)      5.6967 (   0.03%)
> Amean     18      8.1327 (   0.00%)      7.7240 (   5.03%)
> Amean     24     10.0290 (   0.00%)      9.5793 (   4.48%)
> Amean     30     12.8510 (   0.00%)     12.1630 (   5.35%)
> Amean     32     13.2410 (   0.00%)     13.2457 (  -0.04%)
>
> As you can see, your patches with the optimisation layered on top is
> comparable to just the optimisation on its own. It's not universally
> better but it would not look like a regression when comparing releases.
> The differences are mostly within the noise as there is some variability
> involved for this workload so I would not worry too much about it (caveats
> are other machines may be different as well as other workloads).

Excellent!
Thanks for verifying.

TBH, this result is not surprising, because despite all the changes from
fastfsnotify-v1r1 to amir-for-mel, the code that is executed when there
are no watches should be quite similar. Without any unexpected compiler
optimizations that may differ between our versions, fsnotify hooks called
for directories should execute the exact same code.

fsnotify hooks called for non-directories (your workload) should execute
almost the same code. I spotted one additional test for access to
d_inode and one additional test of:
dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED
in the entry to __fsnotify_parent().

> A minor
> issue is that this is probably a bisection hazard. If a series is merged
> and LKP points the finger somewhere in the middle of your series then
> I suggest you ask them to test the optimisation commit ID to see if the
> regression goes away.
>

No worries. I wasn't planning on submitted the altered patch.
I just wanted to let you test the final result.
I will apply your change before my series and make sure to keep
optimizations while my changes are applied on top of that.

Thanks,
Amir.
