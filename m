Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861B03D755C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 14:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbhG0Mye (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 08:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbhG0Myc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 08:54:32 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF2DC061757
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jul 2021 05:54:32 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id i1so15643906plr.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jul 2021 05:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pt2HioaCUkHDTd54iHZ7jB4jD4gkKnEQQMifPAzN2+E=;
        b=jS0EqtJgPWabg6STwhqIFrzJMm1if/eXnzc5XF0RGGDBouvI60R0bVVsEfzREylG65
         SGIzzuglFH1UAsN1VuXScdMTuzHty046kjfW97qYIOsdjJ3IfB/290m/iGVdjD6+p7l1
         lohtgnGwmlkNZ1xrrncF2IaHrrnMMTIpzJtuz13ABBPtdAYxu+hunbMrU99C/UcK47HY
         KpgQTDWfTGQONNpmYlbhsvvEHzPB95Vdwk3EzFlIqFTVTEA8WfbDdTvU82N4kdN8ScsN
         9v2WsQAtQC5BQCzfFv4ocQeADOUIBEWZ+Pe8SbhyTawBk2fi9hAdlsy/3DsiA22rXKlm
         8mcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pt2HioaCUkHDTd54iHZ7jB4jD4gkKnEQQMifPAzN2+E=;
        b=m9oTUkn8Gk5+IisstNsnCbDXF/mMWUO/5gBoFeoRAnr9s9c1Y1YNPFtBXC99LsR6gg
         4b1Jkr+hgxaz+iRWBg721cBjoENCtURIwk4Vcae6Fc+A17QG58dVICWB1zpEt2tN8yVv
         vmUaf4jcpxI3Oroc2sKgebE8uvl5pzUxLvTHUWtq0QGJuYmPOrDwNBrmf9EBpNHWahdB
         QOgREhkyKk4Wx7yWn8CgUWoTirB/9xLBsjVfl3KiLKh2C4jSH8kLTpmRHXIJ1W2UPCBG
         TTE0DXlwS24F2ZrJ+AJnevEyXj+vyUcXWaB23mheFZ1Ex6cniGhNZiaQT56uMssbCqCF
         V5+Q==
X-Gm-Message-State: AOAM533RqfsboGQspp2gnjh1kfd90tVkb16SyAstOiunWF3mKAhXV2qB
        NSLL6O9kdGVMQR1IyeyOJtY+aQ==
X-Google-Smtp-Source: ABdhPJzG7EpW1vnk/GhqPo9TMTo4M3O/HBQKDfATBsA48CksPedAxiBzK8T+7z0QAGghQbU6CnSfOg==
X-Received: by 2002:a65:5949:: with SMTP id g9mr13738298pgu.195.1627390471706;
        Tue, 27 Jul 2021 05:54:31 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:c654:968d:5171:3855])
        by smtp.gmail.com with ESMTPSA id 78sm3752608pfw.189.2021.07.27.05.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 05:54:31 -0700 (PDT)
Date:   Tue, 27 Jul 2021 22:54:18 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Jann Horn <jannh@google.com>
Cc:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 5/5] fanotify: add pidfd support to the fanotify API
Message-ID: <YQAB+peigKOy/66O@google.com>
References: <cover.1626845287.git.repnop@google.com>
 <02ba3581fee21c34bd986e093d9eb0b9897fa741.1626845288.git.repnop@google.com>
 <CAG48ez3MsFPn6TsJz75hvikgyxG5YGyT2gdoFwZuvKut4Xms1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3MsFPn6TsJz75hvikgyxG5YGyT2gdoFwZuvKut4Xms1g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Jann,

On Tue, Jul 27, 2021 at 02:23:38AM +0200, Jann Horn wrote:
> On Wed, Jul 21, 2021 at 8:21 AM Matthew Bobrowski <repnop@google.com> wrote:
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
> > there is FAN_EPIDFD, which will be reported if a more generic pidfd
> > creation error occurred when calling pidfd_create().
> [...]
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
> > +                * a valid pidfd. Report FAN_NOPIDFD to the listener in those
> > +                * cases. All other pidfd creation errors are represented as
> > +                * FAN_EPIDFD.
> > +                */
> > +               if (metadata.pid == 0 ||
> > +                   !pid_has_task(event->pid, PIDTYPE_TGID)) {
> > +                       pidfd = FAN_NOPIDFD;
> > +               } else {
> > +                       pidfd = pidfd_create(event->pid, 0);
> > +                       if (pidfd < 0)
> > +                               pidfd = FAN_EPIDFD;
> > +               }
> > +       }
> > +
> 
> As a general rule, f_op->read callbacks aren't allowed to mess with
> the file descriptor table of the calling process. A process should be
> able to receive a file descriptor from an untrusted source and call
> functions like read() on it without worrying about affecting its own
> file descriptor table state with that.

Interesting, thanks for bringing this up. I never knew about this general
rule. Do you mind elaborating a little on why f_op->read() callbacks aren't
allowed to mess with the fdtable of the calling process? I don't quite
exactly understand why this is considered to be suboptimal.

/M
