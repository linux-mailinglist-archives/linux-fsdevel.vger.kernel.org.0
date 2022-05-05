Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9404D51CCDA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 01:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386872AbiEEXsP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 19:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241016AbiEEXsO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 19:48:14 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1B945507
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 May 2022 16:44:33 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id k1so5822474pll.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 May 2022 16:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WTZLoXoKjdOoslPkvGwdybHct+TXtnw+/P8a/e4Grq8=;
        b=NUEANmru8YT6qTqgCDSbrNBNzun/XrKDm7Ig/R3KMD/XYU4tbo2z4ojajEp0P77Cue
         lTuIl/tT/7s5MdiNxEcKeifQtvtPRaNlN68OohX6NBOeC4MZ8peP/fT4EraXivF1l2XG
         MKSrzcfyrWc39gb9Bd4ZqsF5HfzmyyarqwvT2WHBZ749b3fyM2tb7w0AMa/Akj1PpniB
         muTeqxOAuPF9wGeM56E63KY1LUBuI0DYPOJRHQbSJ1eAaLyPYQEuAtg5LO33xwLnzmyv
         5bu+5tg1QgBeutmUTK7dGFJtGV98vnwF8VM520lNrNXYg/4ZmC5BOyEgctPE110nJHx7
         Cgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WTZLoXoKjdOoslPkvGwdybHct+TXtnw+/P8a/e4Grq8=;
        b=TWR51rchSmo8vLU78yda4ac+6SxrXpfJm18uVQ0qKYMazM8wbqTiCePmzJyWbd+AcX
         TCCwmR3iOIHz6l1X1RKRZpRuDDsIajRKkqCQk2XDgZyK1Pbm+Xa2X0m5pB7G4JFqrg2s
         dqEueyjOa5Y+rGT1GoLnQmV3kdAUs8pdJiai2Hp5eJ6aP25CaldwP9+vFSIUAibbrN4C
         9ccZuVwkNfkwyzbsVnwejxYUozIpdGgFRfpEbIiOVt7lnU5d+/Br+IYZeHD/eJ5MsxOY
         MCbnwPL4COskJUe3YCbqhIRdZmvE+Qyj+xo10e8bnQA9KGNQi5cg14KrH4uzuVcOPnKX
         8bXA==
X-Gm-Message-State: AOAM5326p99FvD4J1VPF6vIq8jjXescL//eK5tquc+UWs+YCYPemji5l
        1+2DU72ta4obXUMxz2BSGka+Z7Ss0vtw6w==
X-Google-Smtp-Source: ABdhPJxwMK1zXKtAUP/TITk0VK0dPr0gaF4aDqZ4IaB+DA3H56qFk+e/FjtthUZ6/uhtdKVlRXJGxQ==
X-Received: by 2002:a17:90a:a78c:b0:1b8:b769:62d0 with SMTP id f12-20020a17090aa78c00b001b8b76962d0mr840537pjq.227.1651794272696;
        Thu, 05 May 2022 16:44:32 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:7328:d8bd:6152:780a])
        by smtp.gmail.com with ESMTPSA id c6-20020aa79526000000b0050dc7628155sm1983831pfp.47.2022.05.05.16.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 16:44:32 -0700 (PDT)
Date:   Fri, 6 May 2022 09:44:22 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Fanotify API - Tracking File Movement
Message-ID: <YnRhVgu6JKNinarh@google.com>
References: <YnOmG2DvSpvvOEOQ@google.com>
 <20220505112217.zvzbzhjgmoz7lr6w@quack3.lan>
 <CAOQ4uxhJFEoV0X8uunNaYjdKpsFj6nUtcNFBx8d3oqodDO_iYA@mail.gmail.com>
 <20220505133057.zm5t6vumc4xdcnsg@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505133057.zm5t6vumc4xdcnsg@quack3.lan>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 05, 2022 at 03:30:57PM +0200, Jan Kara wrote:
> On Thu 05-05-22 15:56:16, Amir Goldstein wrote:
> > On Thu, May 5, 2022 at 2:22 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > Hello Matthew!
> > >
> > > On Thu 05-05-22 20:25:31, Matthew Bobrowski wrote:
> > > > I was having a brief chat with Amir the other day about an idea/use
> > > > case that I have which at present don't believe is robustly supported
> > > > by the fanotify API. I was wondering whether you could share some
> > > > thoughts on supporting the following idea.
> > > >
> > > > I have a need to track file movement across a filesystem without
> > > > necessarily burdening the system by having to watch the entire
> > > > filesystem for such movements. That is, knowing when file /dir1/a had
> > > > been moved from /dir1/a to /dir2/a and then from /dir2/a to /dir3/a
> > > > and so on. Or more simply, knowing the destination/new path of the
> > > > file once it has moved.
> > >
> > > OK, and the places the file moves to can be arbitrary? That seems like a
> > > bit narrow usecase :)
> > >
> > > > Initially, I was thinking of using FAN_MOVE_SELF, but it doesn't quite
> > > > cut it. For such events, you only know the target location or path of
> > > > a file had been modified once it has subsequently been moved
> > > > elsewhere. Not to mention that path resolution using the file
> > > > identifier from such an event may not always work. Then there's
> > > > FAN_RENAME which could arguably work. This would include setting up a
> > > > watch on the parent directory of the file of interest and then using
> > > > the information record of type FAN_EVENT_INFO_TYPE_NEW_DFID_NAME to
> > > > figure out the new target location of the file once it has been moved
> > > > and then resetting the mark on the next parent directory once the new
> > > > target location is known. But, as Amir rightfully mentioned, this
> > > > rinse and repeat mark approach is suboptimal as it can lead to certain
> > > > race conditions.
> > >
> > > It seems to me you really want FAN_MOVE_SELF but you'd need more
> > > information coming with it like the new parent dir, wouldn't you? It would
> > > be relatively easy to add that info but it would kind of suck that it would
> > > be difficult to discover in advance whether the directory info will arrive
> > > with the event or not. But that actually would seem to be the case for
> > > FAN_RENAME as well because we didn't seem to bother to refuse FAN_RENAME on
> > > a file. Amir?
> > >
> > 
> > No, we did not, but it is also not refused for all the other dirent events and
> > it was never refused by inotify too, so that behavior is at least consistent.
> > But if we do want to change the behavior of FAN_RENAME on file, my preference
> > would be to start with a Fixes commit that forbis that, backport it to stable
> > and then allow the new behavior upstream.
> > I can post the fix patch.
> 
> Yeah, I think we should do that. Thanks for looking into this!
> 
> > > > Having briefly mentioned all this, what is your stance on maybe
> > > > extending out FAN_RENAME to also cover files? Or, maybe you have
> > > > another approach/idea in mind to cover such cases i.e. introducing a
> > > > new flag FAN_{TRACK,TRACE}.
> > >
> > > So extending FAN_MOVE_SELF or FAN_RENAME looks OK to me, not much thoughts
> > > beyond that :).
> > 
> > Both FAN_RENAME and FAN_REPORT_TARGET_FID are from v5.17
> > which is rather new and it is highly unlikely that anyone has ever used them,
> > so I think we can get away with fixing the API either way.
> > Not to mention that the man pages have not been updated.
> > 
> > This is from the man page that is pending review:
> > 
> >        FAN_REPORT_TARGET_FID (since Linux 5.17)
> >               Events for fanotify groups initialized with this flag
> > will contain additional information
> >               about the child correlated with directory entry
> > modification events...
> >               For the directory entry modification events
> >               FAN_CREATE,  FAN_DELETE,  FAN_RENAME,  and  FAN_MOVE,
> > an  additional...
> > 
> >        FAN_MOVED_TO (since Linux 5.1)
> >               Create an event when a file or directory has been moved
> > to a marked parent directory...
> > 
> >        FAN_RENAME (since Linux 5.17)
> >               This  event contains the same information provided by
> > events FAN_MOVED_FROM
> >               and FAN_MOVED_TO, ...
> > 
> >        FAN_MOVE_SELF (since Linux 5.1)
> >               Create an event when a marked file or directory itself
> > has been moved...
> > 
> > I think it will be easier to retrofit this functionality of FAN_RENAME
> > (i.e. ...provided
> > by events FAN_MOVED_FROM, FAN_MOVED_TO, and FAN_MOVE_SELF).
> > Looking at the code, I think it will also be much easier to implement
> > for FAN_RENAME
> > because it is special-cased for reporting.
> > 
> > HOWEVER! look at the way we implemented reporting of FAN_RENAME
> > (i.e. match_mask). We report_new location only if watching sb or watching
> > new dir. We did that for a reason because watcher may not have permissions
> > to read new dir. We could revisit this decision for a privileged group, but will
> > need to go back reading all the discussions we had about this point to see
> > if there were other reasons(?).
> 
> Yeah, this is a good point. We are able to safely report the new parent
> only if the watching process is able to prove it is able to watch it.
> Adding even more special cases there would be ugly and error prone I'm
> afraid. We could certainly make this available only to priviledged
> notification groups but still it is one more odd corner case and the
> usecase does not seem to be that big.

Sorry, I'm confused about the conclusion we've drawn here. Are we hard
up against not extending FAN_RENAME for the sole reason that the
implementation might be ugly and error prone?

Can we not expose this case exclusively to privileged notification
groups/watchers? This case seems far simpler than what has already
been implemented in the FAN_RENAME series, that is as you mentioned,
trying to safely report the new parent only if the watching process is
able to prove it is able to watch it. If anything, I would've expected
the privileged case to be implemented prior to attempting to cover
whether the super block or target directory is being watched.

> So maybe watching on sb for FAN_RENAME and just quickly filtering
> based on child FID would be better solution than fiddling with new
> event for files?

Ah, I really wanted to stay away from watching the super block for all
FAN_RENAME events. I feel like userspace wearing the pain for such
cases is suboptimal, as this is something that can effectively be done
in-kernel.

/M
