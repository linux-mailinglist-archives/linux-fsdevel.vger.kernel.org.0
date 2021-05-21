Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D12C38D207
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 May 2021 01:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhEUXeT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 19:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhEUXeN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 19:34:13 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44622C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 May 2021 16:32:49 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id m190so15431884pga.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 May 2021 16:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=purBBHjJnoQ+HpnRHXn+Th4dctTqM8bSVhw3bAuqGs4=;
        b=aWsjNqpez8oLW0RT/qXktnN35upgDQ7UKoWLrDB8iFJ8esRxu4/34GiIXBntvbp8b4
         5qLRwOuGiu44/olUYXlGnYc146HRjVrFVzZKWpx6ie8SVS7qBED5f5SHYrMI7JSu9d5o
         s2gJbc9KAMVekm4GnvpecPkbvSzv6F6D+L5/KS/yAClIRyTsjEGjLTBKRdrqZOxuqVFs
         XjKWLxku7Dkrr8M17vk01IzlCMZJuxuuGIx/QE73Eo5SOZAZmBevFut9E0SrrYyb0+fE
         0SWeXQa22iehYljGjp3pePEYFcA3pwYr4M5P6q3F5zNJzTQvYXwZmUJlSpBo1J+rLKwK
         ZRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=purBBHjJnoQ+HpnRHXn+Th4dctTqM8bSVhw3bAuqGs4=;
        b=jAdyTFjT3qpfk0js34+FA9EosgBlmXFMlLym8z4m7XgcKKHTUBA/TLVrKbdd8Un5tU
         zyoL7zkWDVpN5UFgf8Lkqdj1BOTzZmmnIL5M8ISTsdHINcjLM1U2/w2NXhVbHGlavWff
         BUAaIMZrC3ebG5GWRgzyBh+IXRel4UO+qu72IOt3wMxQubBl7Th2JOc6y74IMkymrFEz
         +/hZWHawRlp+U8YU/n5fuZsU/XQehFWvlpuaa95wnZf8TovKtNezN77tTDMwuLKScRuf
         POgSZLdiAWxsW1cHYnGtgL3gFczg+Myiz85EdENdBdqIPXD7hf6A9Wb4e1pLXn9eTyRR
         b7+w==
X-Gm-Message-State: AOAM533HwzjYv3c0FA2aW8QdUqhgjbFp+1siZVpWCSTxYr8qsDgktRfw
        j6ryy7gaaxDMwu9qjOeodZoTyw==
X-Google-Smtp-Source: ABdhPJydSlJCNoG+KrdyFcXEOpcpP5VHqL8MUvR4KgIkpv8AsTDKsd+OBDpnABzWFRAWVFaMhH0eqg==
X-Received: by 2002:a63:e4a:: with SMTP id 10mr1214993pgo.67.1621639968566;
        Fri, 21 May 2021 16:32:48 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:42b2:c084:8468:626a])
        by smtp.gmail.com with ESMTPSA id b124sm5096735pfa.27.2021.05.21.16.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 16:32:47 -0700 (PDT)
Date:   Sat, 22 May 2021 09:32:36 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Jan Kara <jack@suse.cz>
Cc:     amir73il@gmail.com, christian.brauner@ubuntu.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 0/5] Add pidfd support to the fanotify API
Message-ID: <YKhDFCUWX7iU7AzM@google.com>
References: <cover.1621473846.git.repnop@google.com>
 <20210520135527.GD18952@quack2.suse.cz>
 <YKeIR+LiSXqUHL8Q@google.com>
 <20210521104056.GG18952@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521104056.GG18952@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 21, 2021 at 12:40:56PM +0200, Jan Kara wrote:
> On Fri 21-05-21 20:15:35, Matthew Bobrowski wrote:
> > On Thu, May 20, 2021 at 03:55:27PM +0200, Jan Kara wrote:
> > There's one thing that I'd like to mention, and it's something in
> > regards to the overall approach we've taken that I'm not particularly
> > happy about and I'd like to hear all your thoughts. Basically, with
> > this approach the pidfd creation is done only once an event has been
> > queued and the notification worker wakes up and picks up the event
> > from the queue processes it. There's a subtle latency introduced when
> > taking such an approach which at times leads to pidfd creation
> > failures. As in, by the time pidfd_create() is called the struct pid
> > has already been reaped, which then results in FAN_NOPIDFD being
> > returned in the pidfd info record.
> > 
> > Having said that, I'm wondering what the thoughts are on doing pidfd
> > creation earlier on i.e. in the event allocation stages? This way, the
> > struct pid is pinned earlier on and rather than FAN_NOPIDFD being
> > returned in the pidfd info record because the struct pid has been
> > already reaped, userspace application will atleast receive a valid
> > pidfd which can be used to check whether the process still exists or
> > not. I think it'll just set the expectation better from an API
> > perspective.
> 
> Yes, there's this race. OTOH if FAN_NOPIDFD is returned, the listener can
> be sure the original process doesn't exist anymore. So is it useful to
> still receive pidfd of the dead process?

Well, you're absolutely right. However, FWIW I was approaching this
from two different angles:

1) I wanted to keep the pattern in which the listener checks for the
   existence/recycling of the process consistent. As in, the listener
   would receive the pidfd, then send the pidfd a signal via
   pidfd_send_signal() and check for -ESRCH which clearly indicates
   that the target process has terminated.

2) I didn't want to mask failed pidfd creation because of early
   process termination and other possible failures behind a single
   FAN_NOPIDFD. IOW, if we take the -ESRCH approach above, the
   listener can take clear corrective branches as what's to be done
   next if a race is to have been detected, whereas simply returning
   FAN_NOPIDFD at this stage can mean multiple things.

Now that I've written the above and keeping in mind that we'd like to
refrain from doing anything in the event allocation stages, perhaps we
could introduce a different error code for detecting early process
termination while attempting to construct the info record. WDYT?

> Also opening pidfd in the context of event generation is problematic
> for two reasons:
>
> 1) Technically, the context under which events are generated can be rather
> constrained (various locks held etc.). Adding relatively complex operations
> such as pidfd creation is going to introduce strange lock dependencies,
> possibly deadlocks.
> 
> 2) Doing pidfd generation in the context of the process generating event is
> problematic - you don't know in which fd_table the fd will live. Also that
> process is unfairly penalized (performance wise) because someone else is
> listening. We try to keep overhead of event generation as low as possible
> for this reason.

Fair points, thanks for sharing your view. :)

/M
