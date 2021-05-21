Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19F838C476
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 12:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbhEUKRX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 06:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbhEUKRW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 06:17:22 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7AEC061763
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 May 2021 03:15:56 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 29so2760354pgu.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 May 2021 03:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NpMofB5UuqutKSnJfM4oYhP+b14qdU1SFR/5N7swfNw=;
        b=XY/mnqlpgL+odHk9dEQ9B0XPrwjNBSPr2MVTY9elt4rL9+2IOpDujoIFAOs7sCruL+
         k2I0agrmnvD8b1KnY2RV7ljk+NOZRmG9JfRiqRw9QWsc32XqqXWIC3lA2yF4ssEIgYmt
         nRzasamocevPWh2krMqRgYArQQCwLD1TBYy2DUkHVRtN62fwFGqbaGGNn6PCvJbiu3rM
         Y5hlyp9g16qAv751dlAYldhV8oxtiJQOqUdaktmIK8dfzr7Y3x46Z/9ungyXQYiOrWfT
         Yy3F+HIwjmFFGxVqF2ddSRMhmX/syR0nM6b2I9+CIVezIsFHoLq5sIqQSCAX+IkcWsxr
         ss+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NpMofB5UuqutKSnJfM4oYhP+b14qdU1SFR/5N7swfNw=;
        b=mwbkMNuX5r/IwTwPysd6ObXbxnpq1q/Vq9150lQpLZ5JT7DYr+FqCw3XYlKFEQid/k
         FEIiY8q9ifFc7Oqiifja41kTJEPivRSyhtu2yzpelVkkAR/6BbTobjZVG/mxbQ3B/Wp2
         i1gJ7A8HCiyAiv2fiboNFKOglonJrVjVglqY3kbzhWIoY/MMEBv3XV4Fo1nmoIvcWniq
         jULj+ikL6nO6mEdYshXVTDGcN5G/w8LH6VSDIxx3u1YqOl9cKnKxthUdhfdpJivLl0BN
         5N64YR4WfdmWIWuMvWebTYQuby+SStIl3sbPuoYgvSCKU835c8KRwX+6yEjce+F8zSUi
         o0ow==
X-Gm-Message-State: AOAM532hM+kXyt+40mqNUarJ5DK5HqZ1hli2wMbAYhUAtpZg9zx4q1Ub
        Qz/qv6bZmvWYauXcDG/BpDk8PLeDlxeecw==
X-Google-Smtp-Source: ABdhPJwowwtSpyETyIMa/SzQnwcYqILcVnA+91Ib9UuE5p8or/tSs16vypznqs+H62WA68cC14Frzw==
X-Received: by 2002:a63:cc43:: with SMTP id q3mr9175791pgi.50.1621592156031;
        Fri, 21 May 2021 03:15:56 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:42b2:c084:8468:626a])
        by smtp.gmail.com with ESMTPSA id q23sm3941832pgj.61.2021.05.21.03.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 03:15:55 -0700 (PDT)
Date:   Fri, 21 May 2021 20:15:35 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Jan Kara <jack@suse.cz>
Cc:     amir73il@gmail.com, christian.brauner@ubuntu.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 0/5] Add pidfd support to the fanotify API
Message-ID: <YKeIR+LiSXqUHL8Q@google.com>
References: <cover.1621473846.git.repnop@google.com>
 <20210520135527.GD18952@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520135527.GD18952@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Jan!

On Thu, May 20, 2021 at 03:55:27PM +0200, Jan Kara wrote:
> On Thu 20-05-21 12:09:45, Matthew Bobrowski wrote:
> > Hey Jan/Amir/Christian,
> > 
> > This is the updated patch series for adding pidfd support to the
> > fanotify API. It incorporates all the suggestions that had come out of
> > the initial RFC patch series [0].
> > 
> > The main difference with this patch series is that FAN_REPORT_PIDFD
> > results in an additional info record object supplied alongside the
> > generic event metadata object instead of overloading metadata->pid. If
> > any of the fid flavoured init flags are specified, then the pidfd info
> > record object will follow any fid info record objects.
> > 
> > [0] https://www.spinics.net/lists/linux-fsdevel/msg193296.html
> 
> Overall the series looks fine to me - modulo the problems Christian & Amir
> found. Do you have any tests for this? Preferably for LTP so that we can
> extend the coverage there?

Cool and thanks for glancing over this series.

I've written some simple programs to verify this functionality works in
FID and non-FID modes. I definitely plan on writing LTP tests,
although it's something I'll do once we've agreed on the approach and
I've received an ACK from yourself, Amir and Christian. This series
passes all current LTP regressions. Also, I guess I'll need to write
some patches for man-pages given this is an ABI change.

There's one thing that I'd like to mention, and it's something in
regards to the overall approach we've taken that I'm not particularly
happy about and I'd like to hear all your thoughts. Basically, with
this approach the pidfd creation is done only once an event has been
queued and the notification worker wakes up and picks up the event
from the queue processes it. There's a subtle latency introduced when
taking such an approach which at times leads to pidfd creation
failures. As in, by the time pidfd_create() is called the struct pid
has already been reaped, which then results in FAN_NOPIDFD being
returned in the pidfd info record.

Having said that, I'm wondering what the thoughts are on doing pidfd
creation earlier on i.e. in the event allocation stages? This way, the
struct pid is pinned earlier on and rather than FAN_NOPIDFD being
returned in the pidfd info record because the struct pid has been
already reaped, userspace application will atleast receive a valid
pidfd which can be used to check whether the process still exists or
not. I think it'll just set the expectation better from an API
perspective.

/M
