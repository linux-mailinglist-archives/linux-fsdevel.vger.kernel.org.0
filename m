Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931AE3D69E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 01:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbhGZWY1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 18:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbhGZWY1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 18:24:27 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A14C061760
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jul 2021 16:04:55 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id k1so13417782plt.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jul 2021 16:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3zvXXrm1EhbPo/karfODgyzPbnnWPGS2r+uLic52hag=;
        b=fQqHn6H1zjjuCf+tc7UHRpbniU8mOLPDIyKvV9Dp8Au6zgcLVA2luunJGKsi4iOKYq
         PU+f6c81qLy3GY4FTsy6Y0jO6J1hzO6qN3p75ulLdhfAUp15o2p+k9Q6j1nJxLdjBZcr
         cE8N+lhtbCV4tijsMCCaFPtIAq+rokxvhmIwhV7nultbEDHmDDD+cxyDnDumUO0exViY
         UT/gyZ8Rt6zy7mAcVJiJtPU1CzRC7yIGTVGPyR9Oi2lFQaGpVtxgZGi1B8gHxv8U6VNu
         7RrEbCNOjJgZ17nnIM0NJx+nXXrlUrCUrWIQ7ZDCQOcgvYfbOZnySNs2ibTGsGOvaCbp
         NKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3zvXXrm1EhbPo/karfODgyzPbnnWPGS2r+uLic52hag=;
        b=K4pZ4Dy2kKQdd0TWWD+hVSmApPip6aZJrScNj3UHAwbDqtC0AWAIFY2xN1foiAALpp
         I8VQU6v/5UqG1yO5qfQPdvCVO+f5TmQf1RjcrVkjfTjTXMztKL7byImHyh7FhNhnHEsq
         +xj9iYCs7wUz/Jg9zFdxAvok3tI/B5CPc/m50AnVHOqtzLFpugu2iRj/jhjWUS1Dw2YZ
         gcSOyb9j2E2X8Z5SZcf3AXIsXg09b5mIXcoDkZFX149GCmpChV3iYzWDv/GqoPX+QiiA
         fM+QCrEu4TxU7/A6lU2e/anaEc7DjlXT6k0/iI1t26QhzurDGv+AvnT1r/IWPMZQhPjb
         8cAQ==
X-Gm-Message-State: AOAM532bkx5HHPoI6G/yE93ra0mInT84aj5n745RWB3846qT5SzA8ZXk
        o72Da+tNKlqkpaFOzyyJcbxRbw==
X-Google-Smtp-Source: ABdhPJx+p/J/UmtOIKmFNatkBElLn81HQzlpbugT6PblqvElzb35xaht8zzK6Vd6GySW97vMRf08Cw==
X-Received: by 2002:a63:e350:: with SMTP id o16mr20556164pgj.98.1627340694696;
        Mon, 26 Jul 2021 16:04:54 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:c253:e6ea:83ee:c870])
        by smtp.gmail.com with ESMTPSA id a20sm545465pjh.46.2021.07.26.16.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 16:04:54 -0700 (PDT)
Date:   Tue, 27 Jul 2021 09:04:42 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v3 5/5] fanotify: add pidfd support to the fanotify API
Message-ID: <YP8/itVISGZhDhad@google.com>
References: <cover.1626845287.git.repnop@google.com>
 <02ba3581fee21c34bd986e093d9eb0b9897fa741.1626845288.git.repnop@google.com>
 <CAOQ4uxgO3oViTSFZ0zs6brrHrmw362r1C9SQ7g6=XgRwyrzMuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgO3oViTSFZ0zs6brrHrmw362r1C9SQ7g6=XgRwyrzMuw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 21, 2021 at 10:05:17AM +0300, Amir Goldstein wrote:
> On Wed, Jul 21, 2021 at 9:19 AM Matthew Bobrowski <repnop@google.com> wrote:
> >
> > Introduce a new flag FAN_REPORT_PIDFD for fanotify_init(2) which
> > allows userspace applications to control whether a pidfd info record
> > containing a pidfd is to be returned with each event.
> >
> > If FAN_REPORT_PIDFD is enabled for a notification group, an additional
> > struct fanotify_event_info_pidfd object will be supplied alongside the
> > generic struct fanotify_event_metadata within a single event. This
> > functionality is analogous to that of FAN_REPORT_FID in terms of how
> > the event structure is supplied to the userspace application. Usage of
> > FAN_REPORT_PIDFD with FAN_REPORT_FID/FAN_REPORT_DFID_NAME is
> > permitted, and in this case a struct fanotify_event_info_pidfd object
> > will follow any struct fanotify_event_info_fid object.
> >
> > Currently, the usage of FAN_REPORT_TID is not permitted along with
> > FAN_REPORT_PIDFD as the pidfd API only supports the creation of pidfds
> > for thread-group leaders. Additionally, the FAN_REPORT_PIDFD is
> > limited to privileged processes only i.e. listeners that are running
> > with the CAP_SYS_ADMIN capability. Attempting to supply either of
> > these initialization flags with FAN_REPORT_PIDFD will result with
> > EINVAL being returned to the caller.
> >
> > In the event of a pidfd creation error, there are two types of error
> > values that can be reported back to the listener. There is
> > FAN_NOPIDFD, which will be reported in cases where the process
> > responsible for generating the event has terminated prior to fanotify
> > being able to create pidfd for event->pid via pidfd_create(). The
> 
> I think that "...prior to event listener reading the event..." is a more
> accurate description of the situation.

Yes, and to be fair, I actually forgot to update this specific commit
message and comments within the commit after making these exact adjustments
to the man-pages.

> > there is FAN_EPIDFD, which will be reported if a more generic pidfd
> > creation error occurred when calling pidfd_create().
> >
> > Signed-off-by: Matthew Bobrowski <repnop@google.com>
> > ---
> >
> > Changes since v2:
> >
> >  * The FAN_REPORT_PIDFD flag value has been changed from 0x00001000 to
> >    0x00000080. This was so that future FID related initialization flags
> >    could be grouped nicely.
> >
> > * Fixed pidfd clean up at out_close_fd label in
> >   copy_event_to_user(). Reversed the conditional and it now uses the
> >   close_fd() helper instead of put_unused_fd() as we also need to close the
> >   backing file, not just just mark the pidfd free in the fdtable.
> >
> > * Shuffled around the WARN_ON_ONCE(FAN_REPORT_TID) within
> >   copy_event_to_user() so that it's inside the if (pidfd_mode) branch. It
> >   makes more sense to be as close to pidfd creation as possible.
> >
> > * Fixed up the comment block within the if (pidfd_mode) branch.
> >
> >  fs/notify/fanotify/fanotify_user.c | 88 ++++++++++++++++++++++++++++--
> >  include/linux/fanotify.h           |  3 +-
> >  include/uapi/linux/fanotify.h      | 13 +++++
> >  3 files changed, 98 insertions(+), 6 deletions(-)
> >
> 
> [...]
> 
> >
> > @@ -489,8 +526,9 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
> >         struct path *path = fanotify_event_path(event);
> >         struct fanotify_info *info = fanotify_event_info(event);
> >         unsigned int info_mode = FAN_GROUP_FLAG(group, FANOTIFY_INFO_MODES);
> > +       unsigned int pidfd_mode = info_mode & FAN_REPORT_PIDFD;
> >         struct file *f = NULL;
> > -       int ret, fd = FAN_NOFD;
> > +       int ret, pidfd = FAN_NOPIDFD, fd = FAN_NOFD;
> >
> >         pr_debug("%s: group=%p event=%p\n", __func__, group, event);
> >
> > @@ -524,6 +562,34 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
> >         }
> >         metadata.fd = fd;
> >
> > +       if (pidfd_mode) {
> > +               /*
> > +                * Complain if the FAN_REPORT_PIDFD and FAN_REPORT_TID mutual
> > +                * exclusion is ever lifted. At the time of incoporating pidfd
> > +                * support within fanotify, the pidfd API only supported the
> > +                * creation of pidfds for thread-group leaders.
> > +                */
> > +               WARN_ON_ONCE(FAN_GROUP_FLAG(group, FAN_REPORT_TID));
> > +
> > +               /*
> > +                * The PIDTYPE_TGID check for an event->pid is performed
> > +                * preemptively in attempt to catch those rare instances where
> > +                * the process responsible for generating the event has
> > +                * terminated prior to calling into pidfd_create() and acquiring
> 
> I find the description above to be "over dramatic".
> An event listener reading events after generating process has terminated
> could be quite common in case of one shot tools like mv,touch,etc.

Agree, will adjust.

/M
