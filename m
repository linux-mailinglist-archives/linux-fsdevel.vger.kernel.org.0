Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44C8144717
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 18:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbfFMQ5F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 12:57:05 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33519 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729948AbfFMBO6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 21:14:58 -0400
Received: by mail-oi1-f195.google.com with SMTP id q186so13187538oia.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2019 18:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RcKUTNC1/Yaa+Z7YVTaDTsC+idf0Auxj860bjLfby9Y=;
        b=pyVy5aBfnvmLd4LmS99NC7v2hHH+z4UZs9t88ZWrifMnyNQ1ntVXoql6oB68VhzVo1
         F8hclQ0Wyg9MsOlwr7j9F9a5FwakzRc0cX63T9oeseLCkWGBIj3OBaI1LL2HQs2XiGNX
         ETH5Cv/Dp91sVJ4t+YsWm75tFBfI5P44fYs8oiCUlHe8OHYW0zmCh+Jz3mI3juP3eG0d
         bwg8PkQXV/rh9Ruhio4gTK3UfuitZunT8jlU1uJv5ynSJJDHBTJWHqmmDp1yyxN5HdDN
         3nC3in/UilzgUI6FwH3DI0lKZs/DXkSb6pM0DXEBpGmyHzzfZCjAONw9LI5SpclpGpd3
         Jyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RcKUTNC1/Yaa+Z7YVTaDTsC+idf0Auxj860bjLfby9Y=;
        b=hPnRabYJgx0ke2LI+50/MwVUGC8zCIuIdCPJUUt+JPzQsPBOveuNsqg8w8POmzMv7Z
         CNQNpqZU9q7xpbBstmewbBkQR6f6UL2USp72FaSuxm8glMI1i6YueESpv1/P81uN6H7C
         HriSbJenavziahRlEi8/y7ikBQBdTqQ9CUo/ESkK3577c5ke5UGE8D8SMXCx8FkT86IF
         2lQ6/KKvEbMx6Gig89PvNgnv1ZLybDHfHj6v8hMuyeNxSmNPd/umk48H6xFGR33Z1rWP
         iGau4JLafjdL3Xo8JHgkYZYmUVr5xaFnj9yOBNOoFNZ2acBR9BkHMY1w+qpyJozAc5GR
         fkxQ==
X-Gm-Message-State: APjAAAXAHA05ow4qeAzS4seZfftQjjHf6q2so+PFF/p2YYbsFt4uCIpe
        pM3RHZYz6cngh7fEWefWx/+9XYvP1n2fDdz6jEvkWQ==
X-Google-Smtp-Source: APXvYqykCVdxD0fjMiZ7EZWZAtb82hdqz1hJdJILcfFTKlDzRoucvcWvFMaxGMog6wRYrJg2D1GBjocrrJhQVeNNqcs=
X-Received: by 2002:aca:fc50:: with SMTP id a77mr1431023oii.0.1560388497122;
 Wed, 12 Jun 2019 18:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190606222228.GB11698@iweiny-DESK2.sc.intel.com>
 <20190607103636.GA12765@quack2.suse.cz> <20190607121729.GA14802@ziepe.ca>
 <20190607145213.GB14559@iweiny-DESK2.sc.intel.com> <20190612102917.GB14578@quack2.suse.cz>
 <20190612114721.GB3876@ziepe.ca> <20190612120907.GC14578@quack2.suse.cz>
 <20190612191421.GM3876@ziepe.ca> <20190612221336.GA27080@iweiny-DESK2.sc.intel.com>
 <CAPcyv4gkksnceCV-p70hkxAyEPJWFvpMezJA1rEj6TEhKAJ7qQ@mail.gmail.com> <20190612233324.GE14336@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20190612233324.GE14336@iweiny-DESK2.sc.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 12 Jun 2019 18:14:46 -0700
Message-ID: <CAPcyv4jf19CJbtXTp=ag7Ns=ZQtqeQd3C0XhV9FcFCwd9JCNtQ@mail.gmail.com>
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>, Jeff Layton <jlayton@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 12, 2019 at 4:32 PM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Wed, Jun 12, 2019 at 03:54:19PM -0700, Dan Williams wrote:
> > On Wed, Jun 12, 2019 at 3:12 PM Ira Weiny <ira.weiny@intel.com> wrote:
> > >
> > > On Wed, Jun 12, 2019 at 04:14:21PM -0300, Jason Gunthorpe wrote:
> > > > On Wed, Jun 12, 2019 at 02:09:07PM +0200, Jan Kara wrote:
> > > > > On Wed 12-06-19 08:47:21, Jason Gunthorpe wrote:
> > > > > > On Wed, Jun 12, 2019 at 12:29:17PM +0200, Jan Kara wrote:
> > > > > >
> > > > > > > > > The main objection to the current ODP & DAX solution is that very
> > > > > > > > > little HW can actually implement it, having the alternative still
> > > > > > > > > require HW support doesn't seem like progress.
> > > > > > > > >
> > > > > > > > > I think we will eventually start seein some HW be able to do this
> > > > > > > > > invalidation, but it won't be universal, and I'd rather leave it
> > > > > > > > > optional, for recovery from truely catastrophic errors (ie my DAX is
> > > > > > > > > on fire, I need to unplug it).
> > > > > > > >
> > > > > > > > Agreed.  I think software wise there is not much some of the devices can do
> > > > > > > > with such an "invalidate".
> > > > > > >
> > > > > > > So out of curiosity: What does RDMA driver do when userspace just closes
> > > > > > > the file pointing to RDMA object? It has to handle that somehow by aborting
> > > > > > > everything that's going on... And I wanted similar behavior here.
> > > > > >
> > > > > > It aborts *everything* connected to that file descriptor. Destroying
> > > > > > everything avoids creating inconsistencies that destroying a subset
> > > > > > would create.
> > > > > >
> > > > > > What has been talked about for lease break is not destroying anything
> > > > > > but very selectively saying that one memory region linked to the GUP
> > > > > > is no longer functional.
> > > > >
> > > > > OK, so what I had in mind was that if RDMA app doesn't play by the rules
> > > > > and closes the file with existing pins (and thus layout lease) we would
> > > > > force it to abort everything. Yes, it is disruptive but then the app didn't
> > > > > obey the rule that it has to maintain file lease while holding pins. Thus
> > > > > such situation should never happen unless the app is malicious / buggy.
> > > >
> > > > We do have the infrastructure to completely revoke the entire
> > > > *content* of a FD (this is called device disassociate). It is
> > > > basically close without the app doing close. But again it only works
> > > > with some drivers. However, this is more likely something a driver
> > > > could support without a HW change though.
> > > >
> > > > It is quite destructive as it forcibly kills everything RDMA related
> > > > the process(es) are doing, but it is less violent than SIGKILL, and
> > > > there is perhaps a way for the app to recover from this, if it is
> > > > coded for it.
> > >
> > > I don't think many are...  I think most would effectively be "killed" if this
> > > happened to them.
> > >
> > > >
> > > > My preference would be to avoid this scenario, but if it is really
> > > > necessary, we could probably build it with some work.
> > > >
> > > > The only case we use it today is forced HW hot unplug, so it is rarely
> > > > used and only for an 'emergency' like use case.
> > >
> > > I'd really like to avoid this as well.  I think it will be very confusing for
> > > RDMA apps to have their context suddenly be invalid.  I think if we have a way
> > > for admins to ID who is pinning a file the admin can take more appropriate
> > > action on those processes.   Up to and including killing the process.
> >
> > Can RDMA context invalidation, "device disassociate", be inflicted on
> > a process from the outside? Identifying the pid of a pin holder only
> > leaves SIGKILL of the entire process as the remediation for revoking a
> > pin, and I assume admins would use the finer grained invalidation
> > where it was available.
>
> No not in the way you are describing it.  As Jason said you can hotplug the
> device which is "from the outside" but this would affect all users of that
> device.
>
> Effectively, we would need a way for an admin to close a specific file
> descriptor (or set of fds) which point to that file.  AFAIK there is no way to
> do that at all, is there?

Even if there were that gets back to my other question, does RDMA
teardown happen at close(fd), or at final fput() of the 'struct file'?
I.e. does it also need munmap() to get the vma to drop its reference?
Perhaps a pointer to the relevant code would help me wrap my head
around this mechanism.
