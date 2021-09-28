Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7573641A40C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 02:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238239AbhI1AJu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 20:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhI1AJu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 20:09:50 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAC1C061604
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Sep 2021 17:08:11 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id kn18so707455pjb.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Sep 2021 17:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SFyVj9jMzZDynp8Zc5/t3tU9a3H9qvbPvV/wKg5WCVY=;
        b=jxw2QqijIXj2//Xrh9C53cPwdU7qHg50jF+9D3ItOjN1r0pHHUV6OLBO0FzDbkMh8B
         26kQhZYS/V/783GB5Pmh6bOMjwuaAL0KGHp2KmDbXyjCm+InKYJbosHduHcSLwaC/HEL
         KyNGpXqRTzEodLiOd8kMHxyF04ER9vwq0x7YFF5iTSAbzENtYF5wyJ1g83dDI6SEPrqI
         85bZoSM0Jyg8DBGKsdIVj5/T7AZPYzvHovrLDVUAyu4cuIyZkBdpHWCm+vVjZZPIVXbx
         XC8VaIjNVGmL0iNoAwdWuxqYzXCisLzivXTD+yoCb5tBWdSEk8Mz8p1lSSlBHqEZXMCO
         87kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SFyVj9jMzZDynp8Zc5/t3tU9a3H9qvbPvV/wKg5WCVY=;
        b=FDEqVKSR5Oj/QN9sAf61bB1Wya1MGvSdxcma6mMV+OPhyGrXxSLrRoKs8IHSxn2VAx
         IOeg25OZXhTrXCyUCS41T0k+1CBGrDSJt0vURR6apZNFvXllORMVAlGMrDRYYMtt9Qiu
         JXe2bKCbG7/SyoGO4Na9RvxaCEVxXwVUY2uCjFio1R1KAFL0v0NF/dQqevr+Vb4xqCDQ
         4bLCuDw6Qjrmf6gkAQm4S1uPABdni1hHzJGt3tP5IrKIoiGC48WDSSQ79jm74aS3O3io
         eDbc+4EG+hdjnR1Ixpfy6wya6YXTzOqOeGFQ/D1CjRQOjPAQaXSGRIdXuKNPq2YP4E7D
         OsAA==
X-Gm-Message-State: AOAM530AgdeHoldWdDqqAZQ+Q5vsFP2eMA6s3t+odvOyhy4N5nu5HThN
        YytHisy49jEiqA38ah8o48JyVhgKa+QLEOX88KSnvg==
X-Google-Smtp-Source: ABdhPJwTJ6A2k1UeeqGfydjJ5IF+bOjyXKqkae/MK8Zyhai2HFNW0OwsicxXR42kX7SWIOLmyvlSNTfNStJ7G95eh9s=
X-Received: by 2002:a17:902:e80f:b0:13b:721d:f750 with SMTP id
 u15-20020a170902e80f00b0013b721df750mr2333618plg.18.1632787691398; Mon, 27
 Sep 2021 17:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210922054931.GT1756565@dread.disaster.area> <20210922212725.GN570615@magnolia>
 <20210923000255.GO570615@magnolia> <20210923014209.GW1756565@dread.disaster.area>
 <CAPcyv4j77cWASW1Qp=J8poVRi8+kDQbBsLZb0HY+dzeNa=ozNg@mail.gmail.com>
 <CAPcyv4in7WRw1_e5iiQOnoZ9QjQWhjj+J7HoDf3ObweUvADasg@mail.gmail.com>
 <20210923225433.GX1756565@dread.disaster.area> <CAPcyv4jsU1ZBY0MNKf9CCCFaR4qcwUCRmZHstPpF02pefKnDtg@mail.gmail.com>
 <09ed3c3c-391b-bf91-2456-d7f7ca5ab2fb@oracle.com> <20210924013516.GB570577@magnolia>
 <20210927210750.GH1756565@dread.disaster.area> <b0861cd0-f5c3-6a56-29f9-cd4421c221c4@oracle.com>
In-Reply-To: <b0861cd0-f5c3-6a56-29f9-cd4421c221c4@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 27 Sep 2021 17:08:03 -0700
Message-ID: <CAPcyv4gys1F6G1cgXk2UOcr27GNBAfc+ZBoh7MAwFVu5cqfXDg@mail.gmail.com>
Subject: Re: [PATCH 3/5] vfs: add a zero-initialization mode to fallocate
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 2:58 PM Jane Chu <jane.chu@oracle.com> wrote:
>
> On 9/27/2021 2:07 PM, Dave Chinner wrote:
> > On Thu, Sep 23, 2021 at 06:35:16PM -0700, Darrick J. Wong wrote:
> >> On Thu, Sep 23, 2021 at 06:21:19PM -0700, Jane Chu wrote:
> >>>
> >>> On 9/23/2021 6:18 PM, Dan Williams wrote:
> >>>> On Thu, Sep 23, 2021 at 3:54 PM Dave Chinner <david@fromorbit.com> wrote:
> >>>>>
> >>>>> On Wed, Sep 22, 2021 at 10:42:11PM -0700, Dan Williams wrote:
> >>>>>> On Wed, Sep 22, 2021 at 7:43 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >>>>>>>
> >>>>>>> On Wed, Sep 22, 2021 at 6:42 PM Dave Chinner <david@fromorbit.com> wrote:
> >>>>>>> [..]
> >>>>>>>> Hence this discussion leads me to conclude that fallocate() simply
> >>>>>>>> isn't the right interface to clear storage hardware poison state and
> >>>>>>>> it's much simpler for everyone - kernel and userspace - to provide a
> >>>>>>>> pwritev2(RWF_CLEAR_HWERROR) flag to directly instruct the IO path to
> >>>>>>>> clear hardware error state before issuing this user write to the
> >>>>>>>> hardware.
> >>>>>>>
> >>>>>>> That flag would slot in nicely in dax_iomap_iter() as the gate for
> >>>>>>> whether dax_direct_access() should allow mapping over error ranges,
> >>>>>>> and then as a flag to dax_copy_from_iter() to indicate that it should
> >>>>>>> compare the incoming write to known poison and clear it before
> >>>>>>> proceeding.
> >>>>>>>
> >>>>>>> I like the distinction, because there's a chance the application did
> >>>>>>> not know that the page had experienced data loss and might want the
> >>>>>>> error behavior. The other service the driver could offer with this
> >>>>>>> flag is to do a precise check of the incoming write to make sure it
> >>>>>>> overlaps known poison and then repair the entire page. Repairing whole
> >>>>>>> pages makes for a cleaner implementation of the code that tries to
> >>>>>>> keep poison out of the CPU speculation path, {set,clear}_mce_nospec().
> >>>>>>
> >>>>>> This flag could also be useful for preadv2() as there is currently no
> >>>>>> way to read the good data in a PMEM page with poison via DAX. So the
> >>>>>> flag would tell dax_direct_access() to again proceed in the face of
> >>>>>> errors, but then the driver's dax_copy_to_iter() operation could
> >>>>>> either read up to the precise byte offset of the error in the page, or
> >>>>>> autoreplace error data with zero's to try to maximize data recovery.
> >>>>>
> >>>>> Yes, it could. I like the idea - say RWF_IGNORE_HWERROR - to read
> >>>>> everything that can be read from the bad range because it's the
> >>>>> other half of the problem RWF_RESET_HWERROR is trying to address.
> >>>>> That is, the operation we want to perform on a range with an error
> >>>>> state is -data recovery-, not "reinitialisation". Data recovery
> >>>>> requires two steps:
> >>>>>
> >>>>> - "try to recover the data from the bad storage"; and
> >>>>> - "reinitialise the data and clear the error state"
> >>>>>
> >>>>> These naturally map to read() and write() operations, not
> >>>>> fallocate(). With RWF flags they become explicit data recovery
> >>>>> operations, unlike fallocate() which needs to imply that "writing
> >>>>> zeroes" == "reset hardware error state". While that reset method
> >>>>> may be true for a specific pmem hardware implementation it is not a
> >>>>> requirement for all storage hardware. It's most definitely not a
> >>>>> requirement for future storage hardware, either.
> >>>>>
> >>>>> It also means that applications have no choice in what data they can
> >>>>> use to reinitialise the damaged range with because fallocate() only
> >>>>> supports writing zeroes. If we've recovered data via a read() as you
> >>>>> suggest we could, then we can rebuild the data from other redundant
> >>>>> information and immediately write that back to the storage, hence
> >>>>> repairing the fault.
> >>>>>
> >>>>> That, in turn, allows the filesystem to turn the RWF_RESET_HWERROR
> >>>>> write into an exclusive operation and hence allow the
> >>>>> reinitialisation with the recovered/repaired state to run atomically
> >>>>> w.r.t. all other filesystem operations.  i.e. the reset write
> >>>>> completes the recovery operation instead of requiring separate
> >>>>> "reset" and "write recovered data into zeroed range" steps that
> >>>>> cannot be executed atomically by userspace...
> >>>>
> >>>> /me nods
> >>>>
> >>>> Jane, want to take a run at patches for this ^^^?
> >>>>
> >>>
> >>> Sure, I'll give it a try.
> >>>
> >>> Thank you all for the discussions!
> >>
> >> Cool, thank you!
> >
> > I'd like to propose a slight modification to the API: a single RWF
> > flag called RWF_RECOVER_DATA. On read, this means the storage tries
> > to read all the data it can from the range, and for the parts it
> > can't read data from (cachelines, sectors, whatever) it returns as
> > zeroes.
> >
> > On write, this means the errors over the range get cleared and the
> > user data provided gets written over the top of whatever was there.
> > Filesystems should perform this as an exclusive operation to that
> > range of the file.
> >
> > That way we only need one IOCB_RECOVERY flag, and for communicating
> > with lower storage layers (e.g. dm/md raid and/or hardware) only one
> > REQ_RECOVERY flag is needed in the bio.
> >
> > Thoughts?
>
> Sounds cleaner.  Dan, your thoughts?

I like it. I was struggling with a way to unify the flag names, and
"recovery" is a good term for not surprising the caller with zeros.
I.e. don't use this flow to avoid errors, use this flow to maximize
data recovery.
