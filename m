Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A682364FE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 03:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhDTBgY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 21:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhDTBgX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 21:36:23 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD27DC06174A
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Apr 2021 18:35:52 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id em21-20020a17090b0155b029014e204a81e6so466966pjb.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Apr 2021 18:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eVivNCAEGUtIZChmB441G4IvsrobxBqjmpKfkg3ZBEk=;
        b=grJ7DVi57J0SaIJWOaPF8sXgyFe+vVrdEyBcKgBfsvtLsPY61oHKYPjDUKEolHMRRb
         Xsj5Q+xBdF2JpCfkh4kPQKdcO9FY1hGv6yCS0uvxNya12Jvs8F4ZUBtLj7rtONRnerdN
         FlB0gmP1KiHPFgVPjeynUSp+7yoES7DvuTL8hZCGKadIMYxtMNAjkmS4hUWqK4TX9FWf
         byNyUyA+77y8g+dC+OsmyUsqMntNg2ucwdmzse9H8kRmtoy8+XHc69c+7Ac6D4Mj1LYJ
         MCcpOEqVfLlD0wfOksPK/7kDfWrr3DDBAYjPDbPca/LlpOiGr7RRopeVfPEhop2KG2MP
         MDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eVivNCAEGUtIZChmB441G4IvsrobxBqjmpKfkg3ZBEk=;
        b=PX6Y68GVaNxQY6Z8wWyOXUqo3dfnrQz0wLHH9EjCP8a52QGtr19/SNyFjRtZaXBKsG
         opFzfLsIBzqOfiHDkMggY9ssRaWjYTshK9XMjZaB2haImefvPSTsUwYaI194g8Cfvx3U
         jClp/hLkuJs4zvi3asJlY+FQ6LxTAxW2u6SKlj2TR5wSTt5loKJYKFsd4D+np/kwhWWH
         53XWhqHlz8wS1owNoF0WZ4RV5UEJAzDsG8PQx8wTRu86lXkwyiNAHdfTasz7crfHWBXY
         neUCx0758ghr4+MKInXvuCh7ieNJFxALcKZ5L+FYZyKAWy1oanPYqIETnGSjWa36FcGY
         xJ0w==
X-Gm-Message-State: AOAM533RfEfqILSHWe4W9XyYmEVwehQaFNFSCHionFIAfJmU9AbI+nu0
        JbjwC/IdsmY26UdkPLhudtxQD3GqzMVeKCsa
X-Google-Smtp-Source: ABdhPJyelHplD4uxiUo1PCbwBtzL2HFMEzpwg1oHLv4pc0yVWWKsLcX4TDhlPnLQxbpW1PE1NSTMWg==
X-Received: by 2002:a17:902:a988:b029:eb:679:462b with SMTP id bh8-20020a170902a988b02900eb0679462bmr26251625plb.67.1618882552050;
        Mon, 19 Apr 2021 18:35:52 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:3810:ca7:eb2a:d336])
        by smtp.gmail.com with ESMTPSA id ft3sm603136pjb.54.2021.04.19.18.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 18:35:51 -0700 (PDT)
Date:   Tue, 20 Apr 2021 11:35:39 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Jan Kara <jack@suse.cz>
Cc:     amir73il@gmail.com, christian.brauner@ubuntu.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fanotify: Add pidfd support to the fanotify API
Message-ID: <YH4v65wM/RIlzC8V@google.com>
References: <cover.1618527437.git.repnop@google.com>
 <e6cd967f45381d20d67c9d5a3e49e3cb9808f65b.1618527437.git.repnop@google.com>
 <20210419102139.GD8706@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419102139.GD8706@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 19, 2021 at 12:21:39PM +0200, Jan Kara wrote:
> On Fri 16-04-21 09:22:25, Matthew Bobrowski wrote:
> > Introduce a new flag FAN_REPORT_PIDFD for fanotify_init(2) which
> > allows userspace applications to control whether a pidfd is to be
> > returned instead of a pid for `struct fanotify_event_metadata.pid`.
> > 
> > FAN_REPORT_PIDFD is mutually exclusive with FAN_REPORT_TID as the
> > pidfd API is currently restricted to only support pidfd generation for
> > thread-group leaders. Attempting to set them both when calling
> > fanotify_init(2) will result in -EINVAL being returned to the
> > caller. As the pidfd API evolves and support is added for tids, this
> > is something that could be relaxed in the future.
> > 
> > If pidfd creation fails, the pid in struct fanotify_event_metadata is
> > set to FAN_NOPIDFD(-1). Falling back and providing a pid instead of a
> > pidfd on pidfd creation failures was considered, although this could
> > possibly lead to confusion and unpredictability within userspace
> > applications as distinguishing between whether an actual pidfd or pid
> > was returned could be difficult, so it's best to be explicit.
> > 
> > Signed-off-by: Matthew Bobrowski <repnop@google.com>

> Overall this looks OK to me. Just one style nit & one question below in
> addition to what Amir wrote.

Thanks for the quick review Jan!

> > ---
> >  fs/notify/fanotify/fanotify_user.c | 33 +++++++++++++++++++++++++++---
> >  include/linux/fanotify.h           |  2 +-
> >  include/uapi/linux/fanotify.h      |  2 ++
> >  3 files changed, 33 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > index 9e0c1afac8bd..fd8ae88796a8 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -329,7 +329,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
> >  	struct fanotify_info *info = fanotify_event_info(event);
> >  	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
> >  	struct file *f = NULL;
> > -	int ret, fd = FAN_NOFD;
> > +	int ret, pidfd, fd = FAN_NOFD;
> >  	int info_type = 0;
> >  
> >  	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
> > @@ -340,7 +340,25 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
> >  	metadata.vers = FANOTIFY_METADATA_VERSION;
> >  	metadata.reserved = 0;
> >  	metadata.mask = event->mask & FANOTIFY_OUTGOING_EVENTS;
> > -	metadata.pid = pid_vnr(event->pid);
> > +
> > +	if (FAN_GROUP_FLAG(group, FAN_REPORT_PIDFD) &&
> > +		pid_has_task(event->pid, PIDTYPE_TGID)) {
> 
> Please align the rest of the condition to the opening brace. I.e., like:
> 
> 	if (FAN_GROUP_FLAG(group, FAN_REPORT_PIDFD) &&
> 	    pid_has_task(event->pid, PIDTYPE_TGID)) {

ACK.

> BTW, why is the pid_has_task() check here?

My thought was that we add a means of ensuring that event->pid holds a
reference to a thread-group leader as pidfds aren't supported for
individual threads just yet. The same check is implemented in
pidfd_open(), so I thought to make the preliminary checks consistent.

Actually, now that I've writeten that, perhaps the pid_has_task()
check can be rolled up into pidfd_create()?

> And why is it OK to fall back to returning pid if pid_has_task() is
> false?

Ah, I see, it's not OK. Good catch Jan! I will need to fix this up in
the follow up series.

/M
