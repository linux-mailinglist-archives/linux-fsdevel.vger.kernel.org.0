Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D26B368938
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 01:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237126AbhDVXHf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 19:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbhDVXHe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 19:07:34 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFDBC06174A
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Apr 2021 16:06:58 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p16so20357865plf.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Apr 2021 16:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EJZl9yLZWw5znDYbZ4TN51rUNcfF2rQMU5tbRXrgfFU=;
        b=idGHBus1QSHsC88Uz4R8ecx5e7uM4gjZF6dZy9jt64HM26eTY39z7NjJCYXhbepUOX
         xrPf6Sv+LI0Vrlpar+NI8vZCfc4OLRPfrh+j+A6TcB5XMqlGtOGeG2wT7kE9YjjZnyDY
         Gi0vPkvmGh4q2m/kOnIkXP2C/SMu0DyYNYNnWNt1VRQuj/FDtfPyBS2Ihq3Efw0i6n6t
         MQ+XMA/LHRa1Mfo56sykipfNHnZU67N0j8TY7JYKH7YOv7O8O8HQrce1plu3dxq26CON
         7eiNss9ID3+9mqLBtqfz3iqZ/P7tHk2KiOzRhvbfSajO0/J2h4g/IEeL9e3zsB8IomBA
         ud7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EJZl9yLZWw5znDYbZ4TN51rUNcfF2rQMU5tbRXrgfFU=;
        b=Pjdf37vQYzla/m5tsPOdrEFe7toKn2sqI9dxm9NyHdLm9FgRf4DUY0pKnIpdQ22xR1
         wo3+gWs3VY+PTWEwuF3gZBloTj8tootMy2k6BveHe4PtYzlMRRFgC5RIVFeN1sWqt5BT
         hOf5I6CWdLnsP8wt0zF1QnOhgnh3/6BFlo9coiwOQTmWoCh3MFruS1YCgdHlBxrvao6s
         Cp/od0igHudScXElG5k5H4kOMYfLlUUq5AH2Fg2oEb1lAT1yyvaxOzq4uWRKF+ECsgcx
         WCiUSTXo1FzPl8CEGlcduC0uGzePutTZukJO9/2LFrHWOVggLZjaoIoKQrS06l+J0zjH
         v2ow==
X-Gm-Message-State: AOAM533jkCDc8pQ8xu13bttPrzS9VViIUEEZ2GLv0/jDXRlU5hvpKAKv
        aGzLhi1OVnud07JhocwNB9DWWg==
X-Google-Smtp-Source: ABdhPJxKJCXXCNYuBo3+KfWHCM3l8Sy6kPuKUdgpSObjI+Zz3upxo1MKTo9dVENfHHQ8+jYmdh3ldw==
X-Received: by 2002:a17:90a:eb04:: with SMTP id j4mr1136535pjz.156.1619132817365;
        Thu, 22 Apr 2021 16:06:57 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:686a:2391:ed27:7821])
        by smtp.gmail.com with ESMTPSA id w25sm3016201pfg.206.2021.04.22.16.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 16:06:56 -0700 (PDT)
Date:   Fri, 23 Apr 2021 09:06:45 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        amir73il@gmail.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fanotify: Add pidfd support to the fanotify API
Message-ID: <YIIBheuHHCJeY6wJ@google.com>
References: <cover.1618527437.git.repnop@google.com>
 <e6cd967f45381d20d67c9d5a3e49e3cb9808f65b.1618527437.git.repnop@google.com>
 <20210419132020.ydyb2ly6e3clhe2j@wittgenstein>
 <20210419135550.GH8706@quack2.suse.cz>
 <20210419150233.rgozm4cdbasskatk@wittgenstein>
 <YH4+Swki++PHIwpY@google.com>
 <20210421080449.GK8706@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421080449.GK8706@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 21, 2021 at 10:04:49AM +0200, Jan Kara wrote:
> On Tue 20-04-21 12:36:59, Matthew Bobrowski wrote:
> > On Mon, Apr 19, 2021 at 05:02:33PM +0200, Christian Brauner wrote:
> > > A general question about struct fanotify_event_metadata and its
> > > extensibility model:
> > > looking through the code it seems that this struct is read via
> > > fanotify_rad(). So the user is expected to supply a buffer with at least
> > > 
> > > #define FAN_EVENT_METADATA_LEN (sizeof(struct fanotify_event_metadata))
> > > 
> > > bytes. In addition you can return the info to the user about how many
> > > bytes the kernel has written from fanotify_read().
> > > 
> > > So afaict extending fanotify_event_metadata should be _fairly_
> > > straightforward, right? It would essentially the complement to
> > > copy_struct_from_user() which Aleksa and I added (1 or 2 years ago)
> > > which deals with user->kernel and you're dealing with kernel->user:
> > > - If the user supplied a buffer smaller than the minimum known struct
> > >   size -> reject.
> > > - If the user supplied a buffer < smaller than what the current kernel
> > >   supports -> copy only what userspace knows about, and return the size
> > >   userspace knows about.
> > > - If the user supplied a buffer that is larger than what the current
> > >   kernel knows about -> copy only what the kernel knows about, zero the
> > >   rest, and return the kernel size.
> > > 
> > > Extension should then be fairly straightforward (64bit aligned
> > > increments)?
> > 
> > You'd think that it's fairly straightforward, but I have a feeling
> > that the whole fanotify_event_metadata extensibility discussion and
> > the current limitation to do so revolves around whether it can be
> > achieved in a way which can guarantee that no userspace applications
> > would break. I think the answer to this is that there's no guarantee
> > because of <<reasons>>, so the decision to extend fanotify's feature
> > set was done via other means i.e. introduction of additional
> > structures.
> 
> There's no real problem extending fanotify_event_metadata. We already have
> multiple extended version of that structure in use (see e.g. FAN_REPORT_FID
> flag and its effect, extended versions of the structure in
> include/uapi/linux/fanotify.h). The key for backward compatibility is to
> create extended struct only when explicitely requested by a flag when
> creating notification group - and that would be the case here -
> FAN_REPORT_PIDFD or how you called it. It is just that extending the
> structure means adding 8 bytes to each event and parsing extended structure
> is more cumbersome than just fetching s32 from a well known location.
> 
> On the other hand extended structure is self-describing (i.e., you can tell
> the meaning of all the fields just from the event you receive) while
> reusing 'pid' field means that you have to know how the notification group
> was created (whether FAN_REPORT_PIDFD was used or not) to be able to
> interpret the contents of the event. Actually I think the self-describing
> feature of fanotify event stream is useful (e.g. when application manages
> multiple fanotify groups or when fanotify group descriptors are passed
> among processes) so now I'm more leaning towards using the extended
> structure instead of reusing 'pid' as Christian suggests. I'm sorry for the
> confusion.

This approach makes sense to me.

Jan/Amir, just to be clear, we've agreed to go ahead with the extended
struct approach whereby specifying the FAN_REPORT_PIDFD flag will
result in an event which includes an additional struct
(i.e. fanotify_event_info_pid) alongside the generic existing
fanotify_event_metadata (also ensuring that pid has been
provided). Events will be provided to userspace applications just like
when specifying FAN_REPORT_FID, correct?

/M
