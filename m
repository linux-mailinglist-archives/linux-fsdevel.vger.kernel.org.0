Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB26633EF09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 12:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhCQLCK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 07:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhCQLBr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 07:01:47 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702E3C06175F;
        Wed, 17 Mar 2021 04:01:47 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id l5so1044060ilv.9;
        Wed, 17 Mar 2021 04:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BYHMrjb4lyNPksOkVK6A39D0G0tsTSTkEMKh/7NW0Ws=;
        b=JxFvcYZ+B8J7QCd4kzuV+NO0CnvorOH8KWvWMrBc80nPxj07Mf2ksJMN3kHpOvj2o7
         PCOfX8qHeNfqNot7HL3+b9eCoiwGXgl2lg5GHww+6hbHDqvs7YBrvXEvu0cotQmVE9zz
         D7ifjZBR2xsPWiB24Sjz03eug7rzRDN78RfD56xbGIt80nJaqU2ilMh3+u8Rwaf8WZVZ
         M/mjt1Agx0xKc76rARiHJ+pExZAvbTZNMnnz355h/1qeZdb4eM4LNtEAHI64rWVp3153
         rbFyQJ3HF7spJ+Woyo+MNloagpt/mA3wNrjtcGP8mbnvQX/7lgZIiczKfusc/Dj6cJHG
         W18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BYHMrjb4lyNPksOkVK6A39D0G0tsTSTkEMKh/7NW0Ws=;
        b=nGhTdHpvo587ahKHCAB0XXrhpOSVSerfci/Y8VgN8bgc7+rkRbulylsYfn0HIbJGXy
         Q2w0CmqsYIj1H/Bwdp+Fxv63VFPqNDYQRK9nk+RGSCs2xWiZNY8K1nuCHKPMQ5BlG8N8
         8iKylJ15suo2ZMSQl2s2+wL40oq6GJPP6bDncrLRFO6w7XZXPDSLcSArFkcKTvVN5nf6
         aSq2xudGAcmm79JNgpO3o4j4r4mKXx32jvKCRciZqUNowJaWvLCZst3pzehkZg/wA8pm
         W9AJY5DWWBB+n0M05p4HoCC/KcLfkjwzubUF3XMxj7xeRqgllgKATs80l/hyDJ0p4yPV
         9DbQ==
X-Gm-Message-State: AOAM531qbcFz65eoNZgS4MRD2V4bjiaFHS6aWH0K09GXENNJFknicoG3
        rWOHGMvi5oPH+FlEESS1CcLvL0I5qgAXVyE6j73cnDNnj2M=
X-Google-Smtp-Source: ABdhPJwyBXpTmosErJ4afrXVoSkKn99fuKDH81ZQVYjSTjVuDG8QTOtu54nCcFrhzMqmIIXbw4l9YP3pGj/psrKhnXQ=
X-Received: by 2002:a92:740c:: with SMTP id p12mr7305240ilc.9.1615978906872;
 Wed, 17 Mar 2021 04:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210304112921.3996419-1-amir73il@gmail.com> <20210316155524.GD23532@quack2.suse.cz>
In-Reply-To: <20210316155524.GD23532@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 17 Mar 2021 13:01:35 +0200
Message-ID: <CAOQ4uxgCv42_xkKpRH-ApMOeFCWfQGGc11CKxUkHJq-Xf=HnYg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] unprivileged fanotify listener
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 16, 2021 at 5:55 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 04-03-21 13:29:19, Amir Goldstein wrote:
> > Jan,
> >
> > These patches try to implement a minimal set and least controversial
> > functionality that we can allow for unprivileged users as a starting
> > point.
> >
> > The patches were tested on top of v5.12-rc1 and the fanotify_merge
> > patches using the unprivileged listener LTP tests written by Matthew
> > and another LTP tests I wrote to test the sysfs tunable limits [1].
>
> Thanks. I've added both patches to my tree.

Great!
I'll go post the LTP tests and work on the man page updates.

BTW, I noticed that you pushed the aggregating for_next branch,
but not the fsnotify topic branch.

Is this intentional?

I am asking because I am usually basing my development branches
off of your fsnotify branch, but I can base them on the unpushed branch.

Heads up. I am playing with extra privileges we may be able to
allow an ns_capable user.
For example, watching a FS_USERNS_MOUNT filesystem that the user
itself has mounted inside userns.

Another feature I am investigating is how to utilize the new idmapped
mounts to get a subtree watch functionality. This requires attaching a
userns to the group on fanotify_init().

<hand waving>
If the group's userns are the same or below the idmapped mount userns,
then all the objects accessed via that idmapped mount are accessible
to the group's userns admin. We can use that fact to filter events very
early based on their mnt_userns and the group's userns, which should be
cheaper than any subtree permission checks.
<\hand waving>

Thanks,
Amir.
