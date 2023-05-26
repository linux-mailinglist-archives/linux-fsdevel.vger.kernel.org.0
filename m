Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9C7711CBC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 03:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241824AbjEZBgQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 21:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbjEZBgP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 21:36:15 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FE7189
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 18:36:13 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d1a0d640cso338834b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 18:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1685064973; x=1687656973;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bR3UToISzSLbX8ZQkHUE42zju/u1Pd13Qxkfw1ihU0s=;
        b=xBykKLfgpBaSvfRX3A2+FxT1KMrbnM15im+s6pEISEci1JWoy+6UGBvACHOKnzsNQr
         afk90Xh/M4D33/CZyC3EusZmqc1ApG7JjLCpW6aX3SWhZt9ZYbyqO7WMBxqRgMWFTHtq
         HSdOCN6vwq8iD2sZuRhSnYIqjspgSjnwj/JJkdgbMcgZZCUfDvhe0451GrKyYqY5eIvT
         gbFjo76t5wzNhvbQD1+eZ6JBj+DjthvcCoZA0AU3MkAccbMC5I/5OCQHLQBwb95rcN0F
         aZC1+itQVaJaNWNgoirfbLXH3K81rFtIImWJ/54lSzn69rMSJfSeM4eOwdpVzh8fi8GZ
         2dwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685064973; x=1687656973;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bR3UToISzSLbX8ZQkHUE42zju/u1Pd13Qxkfw1ihU0s=;
        b=Di7dP3YKaCNFhslsa5SSFzPXEDAELgAtFcyATh8gJoH8yBHMAoNdNh97ASwADj/FpL
         eRsd79Jv5jNoy8dnyJmC+6iI08fIDjLaf0h+ObDfA76CHsChe0VkEYgERZzRTPiLsrh3
         MGVayJ4N/t6qxAHc20s5C20Bf+eVt1qn9FqgzehBMqEw7ZvIizhMgTZRwhP8ZIEjt3DZ
         tJB4EVJUvMvpZ55Uv7hAhgczMjSh+1dW6blIRsCALLUXfaGPo107rSWhSNIfuEEGVOE+
         imboyCWf5vVfhgA6uolMCtcM5D8iYkKtWNyxKywk/Vtk3rwI9OKnb9U3YYBg7pYaexjo
         Hi/g==
X-Gm-Message-State: AC+VfDwI+BIUvAMrYrkRkZLw9k6Kb4s/puLwzMWzAQwdpt154L6dviM2
        WTwapCELExbmu/Ou8moTNTJcAvrriuRFJO56+vU=
X-Google-Smtp-Source: ACHHUZ6sPdmuQonaj/olpSGroUfK3OoVqwjZ0hrzZiUIv4Qa66jySy12bySeqpIr9yyQSaUMpmfRQA==
X-Received: by 2002:a05:6a00:124a:b0:643:96bc:b292 with SMTP id u10-20020a056a00124a00b0064396bcb292mr1061741pfi.5.1685064972718;
        Thu, 25 May 2023 18:36:12 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id g9-20020a62e309000000b0063efe2f3ecdsm1679539pfh.204.2023.05.25.18.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 18:36:11 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q2MNF-003wt9-15;
        Fri, 26 May 2023 11:36:09 +1000
Date:   Fri, 26 May 2023 11:36:09 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     Mike Snitzer <snitzer@kernel.org>, Joe Thornber <ejt@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, dm-devel@redhat.com,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v7 0/5] Introduce provisioning primitives
Message-ID: <ZHANCbnHuhnwCrGz@dread.disaster.area>
References: <ZGeKm+jcBxzkMXQs@redhat.com>
 <ZGgBQhsbU9b0RiT1@dread.disaster.area>
 <ZGu0LaQfREvOQO4h@redhat.com>
 <ZGzIJlCE2pcqQRFJ@bfoster>
 <ZGzbGg35SqMrWfpr@redhat.com>
 <ZG1dAtHmbQ53aOhA@dread.disaster.area>
 <ZG5taYoXDRymo/e9@redhat.com>
 <ZG9JD+4Zu36lnm4F@dread.disaster.area>
 <ZG+GKwFC7M3FfAO5@redhat.com>
 <CAG9=OMNhCNFhTcktxSMYbc5WXkSZ-vVVPtb4ak6B3Z2-kEVX0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG9=OMNhCNFhTcktxSMYbc5WXkSZ-vVVPtb4ak6B3Z2-kEVX0Q@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 25, 2023 at 03:47:21PM -0700, Sarthak Kukreti wrote:
> On Thu, May 25, 2023 at 9:00 AM Mike Snitzer <snitzer@kernel.org> wrote:
> > On Thu, May 25 2023 at  7:39P -0400,
> > Dave Chinner <david@fromorbit.com> wrote:
> > > On Wed, May 24, 2023 at 04:02:49PM -0400, Mike Snitzer wrote:
> > > > On Tue, May 23 2023 at  8:40P -0400,
> > > > Dave Chinner <david@fromorbit.com> wrote:
> > > > > It's worth noting that XFS already has a coarse-grained
> > > > > implementation of preferred regions for metadata storage. It will
> > > > > currently not use those metadata-preferred regions for user data
> > > > > unless all the remaining user data space is full.  Hence I'm pretty
> > > > > sure that a pre-provisioning enhancment like this can be done
> > > > > entirely in-memory without requiring any new on-disk state to be
> > > > > added.
> > > > >
> > > > > Sure, if we crash and remount, then we might chose a different LBA
> > > > > region for pre-provisioning. But that's not really a huge deal as we
> > > > > could also run an internal background post-mount fstrim operation to
> > > > > remove any unused pre-provisioning that was left over from when the
> > > > > system went down.
> > > >
> > > > This would be the FITRIM with extension you mention below? Which is a
> > > > filesystem interface detail?
> > >
> > > No. We might reuse some of the internal infrastructure we use to
> > > implement FITRIM, but that's about it. It's just something kinda
> > > like FITRIM but with different constraints determined by the
> > > filesystem rather than the user...
> > >
> > > As it is, I'm not sure we'd even need it - a preiodic userspace
> > > FITRIM would acheive the same result, so leaked provisioned spaces
> > > would get cleaned up eventually without the filesystem having to do
> > > anything specific...
> > >
> > > > So dm-thinp would _not_ need to have new
> > > > state that tracks "provisioned but unused" block?
> > >
> > > No idea - that's your domain. :)
> > >
> > > dm-snapshot, for certain, will need to track provisioned regions
> > > because it has to guarantee that overwrites to provisioned space in
> > > the origin device will always succeed. Hence it needs to know how
> > > much space breaking sharing in provisioned regions after a snapshot
> > > has been taken with be required...
> >
> > dm-thinp offers its own much more scalable snapshot support (doesn't
> > use old dm-snapshot N-way copyout target).
> >
> > dm-snapshot isn't going to be modified to support this level of
> > hardening (dm-snapshot is basically in "maintenance only" now).

Ah, of course. Sorry for the confusion, I was kinda using
dm-snapshot as shorthand for "dm-thinp + snapshots".

> > But I understand your meaning: what you said is 100% applicable to
> > dm-thinp's snapshot implementation and needs to be accounted for in
> > thinp's metadata (inherent 'provisioned' flag).

*nod*

> A bit orthogonal: would dm-thinp need to differentiate between
> user-triggered provision requests (eg. from fallocate()) vs
> fs-triggered requests?

Why?  How is the guarantee the block device has to provide to
provisioned areas different for user vs filesystem internal
provisioned space?

> I would lean towards user provisioned areas not
> getting dedup'd on snapshot creation,

<twitch>

Snapshotting is a clone operation, not a dedupe operation.

Yes, the end result of both is that you have a block shared between
multiple indexes that needs COW on the next overwrite, but the two
operations that get to that point are very different...

</pedantic mode disegaged>

> but that would entail tracking
> the state of the original request and possibly a provision request
> flag (REQ_PROVISION_DEDUP_ON_SNAPSHOT) or an inverse flag
> (REQ_PROVISION_NODEDUP). Possibly too convoluted...

Let's not try to add everyone's favourite pony to this interface
before we've even got it off the ground.

It's the simple precision of the API, the lack of cross-layer
communication requirements and the ability to implement and optimise
the independent layers independently that makes this a very
appealing solution.

We need to start with getting the simple stuff working and prove the
concept. Then once we can observe the behaviour of a working system
we can start working on optimising individual layers for efficiency
and performance....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
