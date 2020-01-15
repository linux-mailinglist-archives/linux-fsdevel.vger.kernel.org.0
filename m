Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21AF113CDF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 21:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgAOURw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 15:17:52 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33698 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgAOURv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 15:17:51 -0500
Received: by mail-ot1-f66.google.com with SMTP id b18so17294818otp.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2020 12:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dPd0oj72IQTr7Ho1Km4ZWXqORK+AR/nQgrcplLwpJyE=;
        b=fpojuKnu+Wi5p9+eOGcUnK1tXz/ym+tDyQJR7fiN07JPdlNydPbQ1RuKfL9nYOO/vp
         ktdoj1LGNeeH0tLetzt6le5Wb0WjNM3TI4p2CjOGGX+EuSOWw0DzUACfhhv8vVjFUZDe
         W6M8jugyiYMYQ6KmvTTdLB9sA/e2SPnlatCfzz0H0tbTOuYqDFrMchmtCY6PyFUez9hR
         OJoFqGd7eJNY1E5+nY46wPN/+WfX65rZrOFaITHNzfaWg74cclGgIH9l50y+jzJWSEL7
         OLoPXxM4Hj1zKIsYyFEQOBs4ip5mmicI0GLmGXVjvoFJoRTGMOaPmOsh7mhiRTDNLsCU
         UcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dPd0oj72IQTr7Ho1Km4ZWXqORK+AR/nQgrcplLwpJyE=;
        b=q66mqsbIMa/sT3U3vhgfGyiDxeUWUXqaTeH0VZzoc9tM0NGii0F4erExof7tcpjU6M
         l8iT/OIP9ezK0Cwi9WxSbpFzoQTs7aTzr/4Rsl0pUfjwBwoTpAdTs07wohhcYIZ3jwRA
         VK/RmxIP2D4YVLzz7r0oTP+YaoekOrb9+/MglbsssHe9CVcfte/Mj0e6B5NItQg8RjMA
         2IcgRe5StTvaTHXOgSZdIv+Ymk1iePFGJLQptlvhquU6IeNhUimSkFNg2BWfJthjnSvG
         etDigg3HzyVr9fzrT9+tw1TAiX6kCXBnjdRHjhiNH5weyEeWBD2RUa9nrCkdzLORrh19
         fDlg==
X-Gm-Message-State: APjAAAVD+T3JTTJMc2eoTFXZc5qqmZABtjdF4qSoHbP9GLcVGrottzRy
        N1Xgpm3C95bwUHS/fSaw+9muNITzoFs1VrJ1P3Sj7w==
X-Google-Smtp-Source: APXvYqxa2PtNKtiTJcIUathhM+5vp8w9k5zscIWT4wSuOwLkVVcCWydFq1TB1qX0u3WdgAKuekec5Tb3+clHuOZsZ0c=
X-Received: by 2002:a9d:68d3:: with SMTP id i19mr3785693oto.71.1579119471207;
 Wed, 15 Jan 2020 12:17:51 -0800 (PST)
MIME-Version: 1.0
References: <20200107180101.GC15920@redhat.com> <CAPcyv4gmdoqpwwwy4dS3D2eZFjmJ_Zi39k=1a4wn-_ksm-UV4A@mail.gmail.com>
 <20200107183307.GD15920@redhat.com> <CAPcyv4ggoS4dWjq-1KbcuaDtroHKEi5Vu19ggJ-qgycs6w1eCA@mail.gmail.com>
 <20200109112447.GG27035@quack2.suse.cz> <CAPcyv4j5Mra8qeLO3=+BYZMeXNAxFXv7Ex7tL9gra1TbhOgiqg@mail.gmail.com>
 <20200114203138.GA3145@redhat.com> <CAPcyv4iXKFt207Pen+E1CnqCFtC1G85fxw5EXFVx+jtykGWMXA@mail.gmail.com>
 <20200114212805.GB3145@redhat.com> <CAPcyv4igrs40uWuCB163PPBLqyGVaVbaNfE=kCfHRPRuvZdxQA@mail.gmail.com>
 <20200115195617.GA4133@redhat.com>
In-Reply-To: <20200115195617.GA4133@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 15 Jan 2020 12:17:40 -0800
Message-ID: <CAPcyv4iEoN9SnBveG7-Mhvd+wQApi1XKVnuYpyYxDybrFv_YYw@mail.gmail.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jeff Moyer <jmoyer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 11:56 AM Vivek Goyal <vgoyal@redhat.com> wrote:
[..]
> > Even the Red Hat
> > installation guide example shows mounting on pmem0 directly. [1]
>
> Below that example it also says.
>
> "When creating partitions on a pmem device to be used for direct access,
> partitions must be aligned on page boundaries. On the Intel 64 and AMD64
> architecture, at least 4KiB alignment for the start and end of the
> partition, but 2MiB is the preferred alignment. By default, the parted
> tool aligns partitions on 1MiB boundaries. For the first partition,
> specify 2MiB as the start of the partition. If the size of the partition
> is a multiple of 2MiB, all other partitions are also aligned."
>
> So documentation is clearly saying dax will work with partitions as well.
> And some user might decide to just do that.

Yes, of course but my point is that it was ambiguous.

I'm going to take a look at how hard it would be to develop a kpartx
fallback in udev. If that can live across the driver transition then
maybe this can be a non-event for end users that already have that
udev update deployed.
