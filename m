Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD22691D1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Feb 2023 11:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjBJKqM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Feb 2023 05:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjBJKqK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:46:10 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9CE34C1F
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 02:46:08 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id p26so14641887ejx.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 02:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6uMcbVMgytFg/rZZMh+BerzgXH+nMa25qUluc8XB1rU=;
        b=C7xSJEu9+rDzoh1MfU9LXHuvZgcD2HgbgNL80pXMhpAFJI6bMNR8/RscCbX64XjRbw
         tCpz2KCnVjiMtmh8pvMvIHJoNJjOViWR8H3L2jxGPT3b8Kx09QMTtNlNTjzjbRCoIrsM
         t6bR+Cd4K0t0yUXf8hqRv1ZpYBy2pEv8AMe5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6uMcbVMgytFg/rZZMh+BerzgXH+nMa25qUluc8XB1rU=;
        b=O2q6RzJR9emIweKZw+ikTq01xX5xRmVxQxhAE/Z84/+6K8hwIsnmF3lj7zgEPjOZTJ
         ihA173BgiLeRGtjaYahCCb8aJCDzCM6vZmnZf9FEe9rE8X2MC6Wz0v3zw3Wbn6Rc+EPE
         v+uh//v5U/s+4/Lw3dwfL8jmXgGIHh4SIqnjxmhCpXdDBLS+HGZL1vPpDFp+M+am1hE6
         GUex8k8Y+zRLYUBuPlW8dKOjhUwxaRRS9pMV0L3j3nP2zQpzZ3a3xedFWOm/Caniqtwy
         bBl/InsmMadehkO+pJT24o2T3oL0fVTiVa/gSKXj5q3It3n/UwOgIRvF5ETC9sDwpbsD
         PD5Q==
X-Gm-Message-State: AO0yUKWChKx77b52eQf3Zhue+Ph0Kr4SJlLoFErHfggOb6seINZYsmN8
        2D8xro8ntZaNM7f6ozrGkqWoC8cbXKo8igh50tlU5kqFjb6YjeHR
X-Google-Smtp-Source: AK7set8F1pcPNpNn1QYJuq7e3gMLr8CMjJVXf1tOdSHHap6fkvfxo2/b6X/hF31/dxVuygrLi27mhhJ6/mxLfTt1llc=
X-Received: by 2002:a17:906:7242:b0:889:a006:7db5 with SMTP id
 n2-20020a170906724200b00889a0067db5mr3266276ejk.138.1676025967166; Fri, 10
 Feb 2023 02:46:07 -0800 (PST)
MIME-Version: 1.0
References: <7038cabf-e9bb-394a-e084-11bc23813fc7@ddn.com>
In-Reply-To: <7038cabf-e9bb-394a-e084-11bc23813fc7@ddn.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 10 Feb 2023 11:45:56 +0100
Message-ID: <CAJfpegsOPsXqP0=fANO01pyaP99j2+BOF8UrixhXimrCsrabOQ@mail.gmail.com>
Subject: Re: [LSF/MM/BFP ATTEND][LSF/MM/BFP TOPIC] fuse uring communication
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        Ming Lei <ming.lei@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 5 Feb 2023 at 02:00, Bernd Schubert <bschubert@ddn.com> wrote:
>
> Hello,
>
> I'm working for some time on fuse uring based communication that is numa
> aware and core-affine.

I might have mentioned this earlier, but one of the bigger issues with
NUMA that I found was that having a single process with multiple
threads serving queues of different NUMA nodes incurs a performance
hit each time a server thread gets to run. This is due to having to
update mm->cpu_bitmap, which indicates on which  CPUs the current
process is running on.  This bitmap is shared by the address space,
hence constantly updating it from different nodes means having to move
it from one node to the other.

My workaround was to use separate processes (address space is not
shared) but use shared memory for common structures.  This complicates
things quite a bit, so it would be nice to find some other way of
fixing this issue.  For example it occurs to me that making this
bitmap use different cachelines for CPUs that are on different nodes
might actually help fix the issue.

> In the current /dev/fuse based IO model requests are queued on lists
> that are not core-affine or numa aware. For every request a round trip
> between userspace and kernel is needed.
> When we benchmarked our atomic-open patches (also still WIP) initially
> confusing findings came up [1] and could be tracked down to multiple
> threads reading from /dev/fuse. After switching to a single thread that
> reads from /dev/fuse we got consistent and expected results.
> Later we also figured out that adding a polling spin fuse_dev_do_read()
> before going into a waitq sleep when no request is available greatly
> improved meta data benchmark performance [2].
>
> That made us to think about the current communication and to look into a
> ring based queuing model. Around that time IORING_OP_URING_CMD was added
> to uring and the new userspace block device driver (ublk) is using that
> command, to send requests from kernel to userspace.
> I started to look how ublk works and started to adapt a similar model to
> fuse. State as today is that it is basically working, but I'm still
> fixing issues found by xfstests. Benchmarks and patch cleanup for
> submission follow next.
>
> https://github.com/bsbernd/linux/tree/fuse-uring
> https://github.com/bsbernd/libfuse/tree/uring
> (these branches will _not_ be used for upstream submission, these are
> purely for base development)
>
>
> A fuse design documentation update will also be added in the 1st RFC
> request, basic details follow as
>
> - Initial mount setup goes over /dev/fuse
> - fuse.ko queues FUSE_INIT in the existing /dev/fuse (background) queue
> - User space sets up the ring and all queues with a new ioctl
> - fuse.ko sets up the ring and allocates request queues/request memory
> per queue/request
> - Userspace mmaps these buffers and assigns them per queue/request
> - Data are send through these mmaped buffers, there is no kmap involved
> (difference to ublk)

How is the queue buffer filled?  Are requests packed or is the queue
divided into equal parts for each request?

How replies are sent?  Do they use the same buffer?

> - Similar to ublk user space first submits SQEs with as
> FUSE_URING_REQ_FETCH, then later as FUSE_URING_REQ_COMMIT_AND_FETCH -
> commit results of the current request and fetch the next one.
> - FUSE_URING_REQ_FETCH also takes the FUSE_INIT request, later these
> lists are not checked anymore, as there is nothing supposed to be on them

Which list?  If the FUSE_INIT is handled on /dev/fuse why handle it on
the uring?

> - The ring currently only only handles fuse pending and background
> requests (with credits assigned)
> - Forget requires libfuse still read /dev/fuse (handling will be added
> to the ring later)
> - In the WIP state request interrupts are not supported (yet)
> - Userspace needs to send fuse notifications to /dev/fuse, needs to be
> handled by the ring as well (or maybe a separate ring)
> - My goal was to keep compatibility with existing fuse file systems,
> except of the so far missing interrupt handling that should work so far.

Interrupts and notifications are used by very few fs.  So if it's
easier, then we could leave one thread to handle legacy /dev/fuse
requests for anything that's not performance sensitive.

Thanks,
Miklos
