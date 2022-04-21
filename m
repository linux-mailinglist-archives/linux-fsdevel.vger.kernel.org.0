Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996E05096DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 07:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384461AbiDUFhA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 01:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345361AbiDUFg6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 01:36:58 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9676611A08
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Apr 2022 22:34:09 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id dw17so2955891qvb.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Apr 2022 22:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lopfncGJubtM3QjrhekXM3BKrXrw09UHELrv89Q90Gs=;
        b=For0oSKlhehXY05+cfsw22EhOg3IFjKx6/71PVJ3qCi1AmTHGHnSeHKsuLSuBSBCw7
         p1BS+oBBQvzw4FdDavLviVGtan6YcYnHkxnozbLvL5+57wgoI6XIsAsO5Gy/m5bHozXx
         qsndm9ZNzPHkXC1uREudD+yWci8M5HbFQJbPmgQNXawBmcd5Gy9srUemKadRikjH1Tah
         giVsweVuc4uvcyD82fA6XIB8DsfkpmzUfuHdirl+wZT/BVVU0bAwNp+pdoL/9GRHsjIW
         6ebH3C81lpx32VU6YMFLtdnUUnO9PyzL/UEdPamK5gQPsE2SLhh5LRZgNc2iZESTPOY4
         jxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lopfncGJubtM3QjrhekXM3BKrXrw09UHELrv89Q90Gs=;
        b=DmrP+o4bwFF8bFgwZOLWJo4HDMTU2EJ/zrvPEJ9Ia0W+qBECc/LB0Cco1eVZDXY5mJ
         GTHjtSXaGMaa2rJ5pbso5upEY4o3adHVPwlsxbxt1rT0hKft5OY5N0XRw3eoqQDqOYoF
         2uDO6i8265x0/PDibPPa3pZfFXPUdDzmeZId7byI/49oLxq7Kzq+eEzfu61JMUrKDOtb
         Q6fZcB137WlJ982gnsAzTTjYk3gYneYyFf5YKjddXWaquPwP02JjBK78oMlSG7Z8E0Qu
         37aiuuZx8d6dqzPQPzdBM+iQPuNxpbvemaHNx2qxBPLYDMf+mTtNwGwGNxMQdyl54chN
         ClRQ==
X-Gm-Message-State: AOAM531a+tUglYw3fCSVNdilajPB6ByT7T9I3ClqyFTamwj/s9K6gt+Y
        Snonb1sNS4mTz/28UGeqp6D+Go34Zx2Gev6CsOQ=
X-Google-Smtp-Source: ABdhPJyJ0JvgWGOEICPX3nsDvzl8v8+rukG1D96j/m8Eqb9XEi749vPq7IR4GENhO+Pe+rBcuI/Z7XiAPBgEBvphIR4=
X-Received: by 2002:ad4:5d6e:0:b0:446:4aae:630c with SMTP id
 fn14-20020ad45d6e000000b004464aae630cmr16522298qvb.77.1650519248696; Wed, 20
 Apr 2022 22:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220418213713.273050-1-krisman@collabora.com>
 <20220418204204.0405eda0c506fd29e857e1e4@linux-foundation.org> <87h76pay87.fsf@collabora.com>
In-Reply-To: <87h76pay87.fsf@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 21 Apr 2022 08:33:56 +0300
Message-ID: <CAOQ4uxhjvwwEQo+u=TD-CJ0xwZ7A1NjkA5GRFOzqG7m1dN1E2Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] shmem: Allow userspace monitoring of tmpfs for
 lack of space.
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>, kernel@collabora.com,
        Khazhismel Kumykov <khazhy@google.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 19, 2022 at 6:29 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Andrew Morton <akpm@linux-foundation.org> writes:
>
> Hi Andrew,
>
> > On Mon, 18 Apr 2022 17:37:10 -0400 Gabriel Krisman Bertazi <krisman@collabora.com> wrote:
> >
> >> When provisioning containerized applications, multiple very small tmpfs
> >
> > "files"?
>
> Actually, filesystems.  In cloud environments, we have several small
> tmpfs associated with containerized tasks.
>
> >> are used, for which one cannot always predict the proper file system
> >> size ahead of time.  We want to be able to reliably monitor filesystems
> >> for ENOSPC errors, without depending on the application being executed
> >> reporting the ENOSPC after a failure.
> >
> > Well that sucks.  We need a kernel-side workaround for applications
> > that fail to check and report storage errors?
> >
> > We could do this for every syscall in the kernel.  What's special about
> > tmpfs in this regard?
> >
> > Please provide additional justification and usage examples for such an
> > extraordinary thing.
>
> For a cloud provider deploying containerized applications, they might
> not control the application, so patching userspace wouldn't be a
> solution.  More importantly - and why this is shmem specific -
> they want to differentiate between a user getting ENOSPC due to
> insufficiently provisioned fs size, vs. due to running out of memory in
> a container, both of which return ENOSPC to the process.
>

Isn't there already a per memcg OOM handler that could be used by
orchestrator to detect the latter?

> A system administrator can then use this feature to monitor a fleet of
> containerized applications in a uniform way, detect provisioning issues
> caused by different reasons and address the deployment.
>
> I originally submitted this as a new fanotify event, but given the
> specificity of shmem, Amir suggested the interface I'm implementing
> here.  We've raised this discussion originally here:
>
> https://lore.kernel.org/linux-mm/CACGdZYLLCqzS4VLUHvzYG=rX3SEJaG7Vbs8_Wb_iUVSvXsqkxA@mail.gmail.com/
>

To put things in context, the points I was trying to make in this
discussion are:

1. Why isn't monitoring with statfs() a sufficient solution? and more
    specifically, the shared disk space provisioning problem does not sound
    very tmpfs specific to me.
    It is a well known issue for thin provisioned storage in environments
    with shared resources as the ones that you describe
2. OTOH, exporting internal fs stats via /sys/fs for debugging, health
monitoring
    or whatever seems legit to me and is widely practiced by other fs, so
    exposing those tmpfs stats as this patch set is doing seems fine to me.

Another point worth considering in favor of /sys/fs/tmpfs -
since tmpfs is FS_USERNS_MOUNT, the ability of sysadmin to monitor all
tmpfs mounts in the system and their usage is limited.

Therefore, having a central way to enumerate all tmpfs instances in the system
like blockdev fs instances and like fuse fs instances, does not sound
like a terrible
idea in general.

> > Whatever that action is, I see no user-facing documentation which
> > guides the user info how to take advantage of this?
>
> I can follow up with a new version with documentation, if we agree this
> feature makes sense.
>

Given the time of year and participants involved, shall we continue
this discussion
in LSFMM?

I am not sure if this even requires a shared FS/MM session, but I
don't mind trying
to allocate a shared FS/MM slot if Andrew and MM guys are interested
to take part
in the discussion.

As long as memcg is able to report OOM to the orchestrator, the problem does not
sound very tmpfs specific to me.

As Ted explained, cloud providers (for some reason) charge by disk size and not
by disk usage, so also for non-tmpfs, online growing the fs on demand could
prove to be a rewarding practice for cloud applications.

Thanks,
Amir.
