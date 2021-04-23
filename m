Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9487F368E5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 10:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241591AbhDWIDx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 04:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241648AbhDWIDd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 04:03:33 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3878BC06138B
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Apr 2021 01:02:57 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so784729pjh.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Apr 2021 01:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zkwqr4ii+y2yCGvUW33yVCSAvzQ6+dlaSRw7HFJQvbc=;
        b=C7XvTy5eOHk1xRblYxz2nk9GJKaPr9grYTNBEnjJ78gjE0Jher/h6PYLIG97mzJ2Mh
         aDaMaZCAqGtN26ZOlsX/dtvMJO8v5zDrT008M8Wol1gzyyhNvraaFRZWHhB0UehW37Bv
         8jDkTEdjWZ54Hnru7DXbmzrDV65bTfTxFbyido3TDPYH9jJISzl71epy0HjRtiUaT6pK
         nC/B/AWBS7q2WfF1WZn4dHgvW9phnkq9EyuvEP1Z780TiTBPQJ1rjv7HwdQzxgCr80dL
         c4kAW2pbpJk9KaUTBtcPdFIwiXzoQiLK1xS45tGno+T7FKLg7BkeQLL9ppLLZ3cp6OnB
         0YFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zkwqr4ii+y2yCGvUW33yVCSAvzQ6+dlaSRw7HFJQvbc=;
        b=kGFpJzpOwNE/qck+VK8cM1TG01lmXeeR/N2+3M+S+OsUL9vH/X1xDhn+h6HVTE1+qa
         0ZMukeI/nyD4EDUO3oEXsKej8ymxKZmgnoxfWqeLfVQs6ocvRP9YlMXpposVU8r5nNwi
         oTzcerY4rzktPDF5ccMUhtLlUMGSA7Shr4EmKjJYl9eAkWYNdM5VM690cRc0r9ZvMHY/
         Feuw5f9EVThOzbUPygFa/sdyN4oNOA5uA+JzCV2uCtRIEPSsj0/KU3h2bikdBwK6BKWT
         qwnxldPntO6iAKRLD9rQkpXM1lB7u18UgyXBryAzsKGGQpg0neRuxV7+oEwfyCj2oGVS
         GDBg==
X-Gm-Message-State: AOAM533qNN1zcbbFy4l3WRcuK4er29EpM9VyMdgF+Xc8MmymxELdcYEF
        P/CvpGA3ERkc+ePeNf31BX9S2w==
X-Google-Smtp-Source: ABdhPJxWew8WyY5y3xI1CHVk9SRXGkAs3qTR9Yn8Dsk066v8X/hJuKqYnLIQVkQRB22GAow8wbwNkA==
X-Received: by 2002:a17:902:8308:b029:e9:d69:a2f with SMTP id bd8-20020a1709028308b02900e90d690a2fmr2855049plb.20.1619164976557;
        Fri, 23 Apr 2021 01:02:56 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:686a:2391:ed27:7821])
        by smtp.gmail.com with ESMTPSA id h11sm3968099pjs.52.2021.04.23.01.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 01:02:55 -0700 (PDT)
Date:   Fri, 23 Apr 2021 18:02:44 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/2] fanotify: Add pidfd support to the fanotify API
Message-ID: <YIJ/JHdaPv2oD+Jd@google.com>
References: <cover.1618527437.git.repnop@google.com>
 <e6cd967f45381d20d67c9d5a3e49e3cb9808f65b.1618527437.git.repnop@google.com>
 <20210419132020.ydyb2ly6e3clhe2j@wittgenstein>
 <20210419135550.GH8706@quack2.suse.cz>
 <20210419150233.rgozm4cdbasskatk@wittgenstein>
 <YH4+Swki++PHIwpY@google.com>
 <20210421080449.GK8706@quack2.suse.cz>
 <YIIBheuHHCJeY6wJ@google.com>
 <CAOQ4uxhUcefbu+5pLKfx7b-kOPP2OB+_RRPMPDX1vLk36xkZnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhUcefbu+5pLKfx7b-kOPP2OB+_RRPMPDX1vLk36xkZnQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 23, 2021 at 10:39:46AM +0300, Amir Goldstein wrote:
> On Fri, Apr 23, 2021 at 2:06 AM Matthew Bobrowski <repnop@google.com> wrote:
> >
> > On Wed, Apr 21, 2021 at 10:04:49AM +0200, Jan Kara wrote:
> > > On Tue 20-04-21 12:36:59, Matthew Bobrowski wrote:
> > > > On Mon, Apr 19, 2021 at 05:02:33PM +0200, Christian Brauner wrote:
> > > > > A general question about struct fanotify_event_metadata and its
> > > > > extensibility model:
> > > > > looking through the code it seems that this struct is read via
> > > > > fanotify_rad(). So the user is expected to supply a buffer with at least
> > > > >
> > > > > #define FAN_EVENT_METADATA_LEN (sizeof(struct fanotify_event_metadata))
> > > > >
> > > > > bytes. In addition you can return the info to the user about how many
> > > > > bytes the kernel has written from fanotify_read().
> > > > >
> > > > > So afaict extending fanotify_event_metadata should be _fairly_
> > > > > straightforward, right? It would essentially the complement to
> > > > > copy_struct_from_user() which Aleksa and I added (1 or 2 years ago)
> > > > > which deals with user->kernel and you're dealing with kernel->user:
> > > > > - If the user supplied a buffer smaller than the minimum known struct
> > > > >   size -> reject.
> > > > > - If the user supplied a buffer < smaller than what the current kernel
> > > > >   supports -> copy only what userspace knows about, and return the size
> > > > >   userspace knows about.
> > > > > - If the user supplied a buffer that is larger than what the current
> > > > >   kernel knows about -> copy only what the kernel knows about, zero the
> > > > >   rest, and return the kernel size.
> > > > >
> > > > > Extension should then be fairly straightforward (64bit aligned
> > > > > increments)?
> > > >
> > > > You'd think that it's fairly straightforward, but I have a feeling
> > > > that the whole fanotify_event_metadata extensibility discussion and
> > > > the current limitation to do so revolves around whether it can be
> > > > achieved in a way which can guarantee that no userspace applications
> > > > would break. I think the answer to this is that there's no guarantee
> > > > because of <<reasons>>, so the decision to extend fanotify's feature
> > > > set was done via other means i.e. introduction of additional
> > > > structures.
> > >
> > > There's no real problem extending fanotify_event_metadata. We already have
> > > multiple extended version of that structure in use (see e.g. FAN_REPORT_FID
> > > flag and its effect, extended versions of the structure in
> > > include/uapi/linux/fanotify.h). The key for backward compatibility is to
> > > create extended struct only when explicitely requested by a flag when
> > > creating notification group - and that would be the case here -
> > > FAN_REPORT_PIDFD or how you called it. It is just that extending the
> > > structure means adding 8 bytes to each event and parsing extended structure
> > > is more cumbersome than just fetching s32 from a well known location.
> > >
> > > On the other hand extended structure is self-describing (i.e., you can tell
> > > the meaning of all the fields just from the event you receive) while
> > > reusing 'pid' field means that you have to know how the notification group
> > > was created (whether FAN_REPORT_PIDFD was used or not) to be able to
> > > interpret the contents of the event. Actually I think the self-describing
> > > feature of fanotify event stream is useful (e.g. when application manages
> > > multiple fanotify groups or when fanotify group descriptors are passed
> > > among processes) so now I'm more leaning towards using the extended
> > > structure instead of reusing 'pid' as Christian suggests. I'm sorry for the
> > > confusion.
> >
> > This approach makes sense to me.
> >
> > Jan/Amir, just to be clear, we've agreed to go ahead with the extended
> > struct approach whereby specifying the FAN_REPORT_PIDFD flag will
> > result in an event which includes an additional struct
> > (i.e. fanotify_event_info_pid) alongside the generic existing
> 
> struct fanotify_event_info_pidfd?

Well, yeah? I mean, my line of thought was that we'd also need to
include struct fanotify_event_info_header alongside the event to
provide more meta-information about the additional event you'd expect
to receive when FAN_REPORT_PIDFD is provided, so we'd end up with
something like:

struct fanotify_event_info_pidfd {
       struct fanotify_event_info_header hdr;
       __s32 pidfd;
}

Unless this of course is overbaking it and there's no need to do this?

/M
