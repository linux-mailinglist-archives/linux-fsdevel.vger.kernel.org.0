Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3608F13F716
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 20:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437354AbgAPTJP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 14:09:15 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44007 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388043AbgAPTJM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 14:09:12 -0500
Received: by mail-oi1-f195.google.com with SMTP id p125so19845355oif.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2020 11:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6nsG4OiSI74VDUNjgH/EGPUC6QzQOOzMAIB017xQliU=;
        b=J79PjTiwui87Gtdaft875ciI4awf5xIZ2OlEVeWr6PK1j7HDrzdets/eOiB9gFbjxU
         N8a+VDYTOh/zAoGUZWE4w1cYgXKFMyIY5mxDDqaoQWFa6T9HxfH2fP9PLUP1uKEVP7xo
         SFvhifCBTkknEhBzZWrz1h+yDcMOzcy1CAiSWM1LLzIaCNgg2JOGV1Bsk6VwLRFyGzsl
         3oI19Df8dP3bwMD1fbOXbUBm44Ixpu94cRB2oRYOQ/+C0gKdgTy/EpALksKs5ue92Nlt
         bvnoL/8n6PK1nwQDhUpD7aFZSXwTnAcIEDKECZAVt2HboWTI3XccHsyHaJHIW0AO8xHe
         C2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6nsG4OiSI74VDUNjgH/EGPUC6QzQOOzMAIB017xQliU=;
        b=ryMrIxl8hgX+UAe11rYKyXurBmg/7292/kVNplMsukYVNnmFX2fzGwSnGFnh1I6gDK
         70GNY7+TuyS/tMqQzzptGthmDZDYi4JykPQaaGQP3mPLCDRb3sKX3h+aw+1MKPmJfCJO
         4RQ/QNNvZpuHMI6jw347YhwRppWw5P8mxWPXvi/gqXnBZju3DiL3Kk2MaTELL79Pub0f
         a/YvT/8krwPkjaRasRqexQDikrywPWzFLe94yglGZoKa3UmOsc+jO+30locQd53t2xUV
         1FgNZ7/Uvp8nFpRLU/VubUGYDTmBcuFpjFXFM2xTaD9iqOGa2hYFZFLdoCFkf/D8M+J3
         O7VA==
X-Gm-Message-State: APjAAAXO7gdEdgy/u1MZgaRqGax0mRcMu0KHrYjvb+YFMX8cpKYG/vMN
        0K8Q43pwVLNJ1VOqD5Bner7963Y8q4E0QBpX2QGt1g==
X-Google-Smtp-Source: APXvYqxWT+/8vZf0zWr1Yl/badv1TRvP/1k5BqWSq6/+HNdAxAD63JMtXrBctEvUY7L00GT1BthDGiNYcFZ4grHpWxY=
X-Received: by 2002:aca:3f54:: with SMTP id m81mr427008oia.73.1579201751684;
 Thu, 16 Jan 2020 11:09:11 -0800 (PST)
MIME-Version: 1.0
References: <20200109112447.GG27035@quack2.suse.cz> <CAPcyv4j5Mra8qeLO3=+BYZMeXNAxFXv7Ex7tL9gra1TbhOgiqg@mail.gmail.com>
 <20200114203138.GA3145@redhat.com> <CAPcyv4iXKFt207Pen+E1CnqCFtC1G85fxw5EXFVx+jtykGWMXA@mail.gmail.com>
 <20200114212805.GB3145@redhat.com> <CAPcyv4igrs40uWuCB163PPBLqyGVaVbaNfE=kCfHRPRuvZdxQA@mail.gmail.com>
 <20200115195617.GA4133@redhat.com> <CAPcyv4iEoN9SnBveG7-Mhvd+wQApi1XKVnuYpyYxDybrFv_YYw@mail.gmail.com>
 <x49wo9smnqc.fsf@segfault.boston.devel.redhat.com> <CAPcyv4hCR9NV+2MF0iAJ5rHS2uiOgTnu=+yQRfpieDJQpQz22w@mail.gmail.com>
 <20200116183900.GC25291@redhat.com>
In-Reply-To: <20200116183900.GC25291@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 16 Jan 2020 11:09:00 -0800
Message-ID: <CAPcyv4irezimk8m4hysrd0rst_f0Rr+iiNxeFesqbxQnWYA2Xw@mail.gmail.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Jeff Moyer <jmoyer@redhat.com>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 16, 2020 at 10:39 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Thu, Jan 16, 2020 at 10:09:46AM -0800, Dan Williams wrote:
> > On Wed, Jan 15, 2020 at 1:08 PM Jeff Moyer <jmoyer@redhat.com> wrote:
> > >
> > > Hi, Dan,
> > >
> > > Dan Williams <dan.j.williams@intel.com> writes:
> > >
> > > > I'm going to take a look at how hard it would be to develop a kpartx
> > > > fallback in udev. If that can live across the driver transition then
> > > > maybe this can be a non-event for end users that already have that
> > > > udev update deployed.
> > >
> > > I just wanted to remind you that label-less dimms still exist, and are
> > > still being shipped.  For those devices, the only way to subdivide the
> > > storage is via partitioning.
> >
> > True, but if kpartx + udev can make this transparent then I don't
> > think users lose any functionality. They just gain a device-mapper
> > dependency.
>
> So udev rules will trigger when a /dev/pmemX device shows up and run
> kpartx which in turn will create dm-linear devices and device nodes
> will show up in /dev/mapper/pmemXpY.
>
> IOW, /dev/pmemXpY device nodes will be gone. So if any of the scripts or
> systemd unit files are depenent on /dev/pmemXpY, these will still be
> broken out of the box and will have to be modified to use device nodes
> in /dev/mapper/ directory instead. Do I understand it right, Or I missed
> the idea completely.

No, I'd write the udev rule to create links from /dev/pmemXpY to the
/dev/mapper device, and that rule would be gated by a new pmem device
attribute to trigger when kpartx needs to run vs the kernel native
partitions.
