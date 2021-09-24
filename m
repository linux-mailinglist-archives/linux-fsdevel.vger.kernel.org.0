Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F7141694F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 03:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243734AbhIXBT7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 21:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbhIXBT5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 21:19:57 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9749C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Sep 2021 18:18:24 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r2so8204635pgl.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Sep 2021 18:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uqQDICrjwFm5U5Uqyn+9fRddYNuzSxkxhD6TsyPwFBQ=;
        b=uXNOky86fkvBPovVcGHqsg5IwilbsRlOyStj5vunQE+xO6ynctO2vW7os8mbaYjcsR
         Qp5hu2w3ytkFTB1E96kYCQXeKKJ3znG3ZkZXhKxPcJmAq/pJOGYT4eLzLdtWxcaFsgbW
         ENUjyG6uPw2J4ZqNP6esg68acUn+YxbaLxSmDL/jo4KGDnDlG/p72+6bTchIVtxSEoYS
         3G939lLxpjbhFqWLsYpTB+wxvApDJu6HC8Qb0V/89oJKgy7mYrmnFeQlYNh/jbZRBcmx
         4o2f6tfMRYx3/e5QXadun+TOiLIlQt/doA6HhpS9Z8vRIssVMD3+yCeMJAf12WYlmQPg
         qHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uqQDICrjwFm5U5Uqyn+9fRddYNuzSxkxhD6TsyPwFBQ=;
        b=a7m9qSbqOrFmGYkzM2OdyplktpCeTMGTPGAvpzp1Bdnr9ymJ8c0Xnj31DZmd6kSA0B
         SPDaZIMqxvvw69kWrYzosIGZSsh5fCWLkDhUMI5CDV407jE7Sf57ejm+EmaefTPXjS44
         5masJrZPT9RZHEgv64Zo43hLMtK5PhDEY1tShcI+lEHY41DktivyCl04kyREEpa+9BJz
         tw5VQ+6sOq9o0DYnRYgvUx+c3SMubeAbA+e7Rv9ZDaU4/P0g+mT5HZgPGq2ilOssqayw
         ZjdWfQo76fMZ6fMICXvOgAcXmjXB7mrNwZR7RdAEA2HPV6Ozl68N7KngR0nU4tOYLLoR
         ht/A==
X-Gm-Message-State: AOAM531la6ahHdvxdbHNvfNSD0WSINtUjrQw9ENRi7eXKFZzBCVxrRr3
        6MC9usilyaAI3+2LiXt1f+sC3C5+o3QDg3mEJpXTyw==
X-Google-Smtp-Source: ABdhPJzx05Y6tsQ2rjQB5YOjhPY8GQyoQfvzyT7OPxy8YpAQmaxyp5sYZSC4GQnhFHY5Xe7WeClQ8/6XBCJBO3iFJx4=
X-Received: by 2002:a62:1b92:0:b0:3eb:3f92:724 with SMTP id
 b140-20020a621b92000000b003eb3f920724mr7477416pfb.3.1632446304295; Thu, 23
 Sep 2021 18:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4jF1UNW5rdXX3q2hfDcvzGLSnk=1a0C0i7_UjdivuG+pQ@mail.gmail.com>
 <20210922023801.GD570615@magnolia> <20210922035907.GR1756565@dread.disaster.area>
 <20210922041354.GE570615@magnolia> <20210922054931.GT1756565@dread.disaster.area>
 <20210922212725.GN570615@magnolia> <20210923000255.GO570615@magnolia>
 <20210923014209.GW1756565@dread.disaster.area> <CAPcyv4j77cWASW1Qp=J8poVRi8+kDQbBsLZb0HY+dzeNa=ozNg@mail.gmail.com>
 <CAPcyv4in7WRw1_e5iiQOnoZ9QjQWhjj+J7HoDf3ObweUvADasg@mail.gmail.com> <20210923225433.GX1756565@dread.disaster.area>
In-Reply-To: <20210923225433.GX1756565@dread.disaster.area>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 23 Sep 2021 18:18:12 -0700
Message-ID: <CAPcyv4jsU1ZBY0MNKf9CCCFaR4qcwUCRmZHstPpF02pefKnDtg@mail.gmail.com>
Subject: Re: [PATCH 3/5] vfs: add a zero-initialization mode to fallocate
To:     Jane Chu <jane.chu@oracle.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 3:54 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Wed, Sep 22, 2021 at 10:42:11PM -0700, Dan Williams wrote:
> > On Wed, Sep 22, 2021 at 7:43 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > On Wed, Sep 22, 2021 at 6:42 PM Dave Chinner <david@fromorbit.com> wrote:
> > > [..]
> > > > Hence this discussion leads me to conclude that fallocate() simply
> > > > isn't the right interface to clear storage hardware poison state and
> > > > it's much simpler for everyone - kernel and userspace - to provide a
> > > > pwritev2(RWF_CLEAR_HWERROR) flag to directly instruct the IO path to
> > > > clear hardware error state before issuing this user write to the
> > > > hardware.
> > >
> > > That flag would slot in nicely in dax_iomap_iter() as the gate for
> > > whether dax_direct_access() should allow mapping over error ranges,
> > > and then as a flag to dax_copy_from_iter() to indicate that it should
> > > compare the incoming write to known poison and clear it before
> > > proceeding.
> > >
> > > I like the distinction, because there's a chance the application did
> > > not know that the page had experienced data loss and might want the
> > > error behavior. The other service the driver could offer with this
> > > flag is to do a precise check of the incoming write to make sure it
> > > overlaps known poison and then repair the entire page. Repairing whole
> > > pages makes for a cleaner implementation of the code that tries to
> > > keep poison out of the CPU speculation path, {set,clear}_mce_nospec().
> >
> > This flag could also be useful for preadv2() as there is currently no
> > way to read the good data in a PMEM page with poison via DAX. So the
> > flag would tell dax_direct_access() to again proceed in the face of
> > errors, but then the driver's dax_copy_to_iter() operation could
> > either read up to the precise byte offset of the error in the page, or
> > autoreplace error data with zero's to try to maximize data recovery.
>
> Yes, it could. I like the idea - say RWF_IGNORE_HWERROR - to read
> everything that can be read from the bad range because it's the
> other half of the problem RWF_RESET_HWERROR is trying to address.
> That is, the operation we want to perform on a range with an error
> state is -data recovery-, not "reinitialisation". Data recovery
> requires two steps:
>
> - "try to recover the data from the bad storage"; and
> - "reinitialise the data and clear the error state"
>
> These naturally map to read() and write() operations, not
> fallocate(). With RWF flags they become explicit data recovery
> operations, unlike fallocate() which needs to imply that "writing
> zeroes" == "reset hardware error state". While that reset method
> may be true for a specific pmem hardware implementation it is not a
> requirement for all storage hardware. It's most definitely not a
> requirement for future storage hardware, either.
>
> It also means that applications have no choice in what data they can
> use to reinitialise the damaged range with because fallocate() only
> supports writing zeroes. If we've recovered data via a read() as you
> suggest we could, then we can rebuild the data from other redundant
> information and immediately write that back to the storage, hence
> repairing the fault.
>
> That, in turn, allows the filesystem to turn the RWF_RESET_HWERROR
> write into an exclusive operation and hence allow the
> reinitialisation with the recovered/repaired state to run atomically
> w.r.t. all other filesystem operations.  i.e. the reset write
> completes the recovery operation instead of requiring separate
> "reset" and "write recovered data into zeroed range" steps that
> cannot be executed atomically by userspace...

/me nods

Jane, want to take a run at patches for this ^^^?
