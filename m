Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A483C5CE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 15:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbhGLNDz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 09:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhGLNDy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 09:03:54 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3746FC0613DD
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jul 2021 06:01:06 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id g22so22559929iom.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jul 2021 06:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M34RACrH/vlbfAhPkuhQxNCZjCzm+HDNofPObtniYvw=;
        b=htSzRYV54oUJvFl1d4IopuB27V2pUNEKmNgqOIJEJ3mmmPXVadMOxcqA8ip+2T0TP3
         hYi7J2nI9DoFSVgILOKntnGWGd9UrshvwBH9oGpj9qv4eV7KPI/xXtEk9On2txTDJuF9
         ND27Jwz9hlJB3XtlZ/uBvkaeMDOcSjcszSv18sEI5SusnmFdDuA7XcaUu+KvNRWI2Fse
         6BC9DjKJXRjbYQY3A8wOgjyr3eQrE7N+7INBXOrCqWyiAdIqL/fbBHxmJO+tvzhQp/1/
         XK8ihOEBZbbBXXCeUFQeEVv3OQfxUOsltkpYbonkPO4H3vNt+24/Usx8zbdU/G+UjRT1
         WxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M34RACrH/vlbfAhPkuhQxNCZjCzm+HDNofPObtniYvw=;
        b=jehtNlx3AWqZWILjp1TVzwUB2z+Wu+a524b4O6yoN8OpXpra9F2IgqO0cj+wq5r6EL
         4Rg78q4mv+ITUc1HPnswPaIeESoSQ7Ynr9D/RRv6tjLnoCo03KkRUF8Fo8mFyt9dtCsv
         RKpDYKxdconziRLvd1xjYaYUnY+xKlKj1ZsvGupt3f1u95AVZt38p5BnfJyWGlwtwFZg
         MpqweZaGkfiRy1myhii6/RfLBfo9vcYuiEAAFG8DDC8zu69kmaODBjc+sv4gc0cNdzgj
         IGnxekOCZ/Ih9aXy8NjTNkcMP41cSuo86JhiUM83QATfl5dany1sQvhj/09Q9AdUAvJN
         GMUw==
X-Gm-Message-State: AOAM531hlxopXWe9oSH68m1JTrHZPsMwYLsYxdz/qrfRmX7CKB5M78/A
        k4uYm5AUVw2kbe9JMZ1b5ai950LsTCsF7gCRrqM=
X-Google-Smtp-Source: ABdhPJyLYJcXclzCY+hMscNr0D6hPFI25gRcfBw3AKNuDtCJN/4yCaR+l7kimuMW5azsfBxDvkViOdm3ZTtlme6uXiA=
X-Received: by 2002:a5e:dc44:: with SMTP id s4mr18346270iop.186.1626094865625;
 Mon, 12 Jul 2021 06:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxgckzeRuiKSe7D=TVaJGTYwy4cbCFDpdWMQr1R_xXkJig@mail.gmail.com>
 <20210712111016.GC26530@quack2.suse.cz>
In-Reply-To: <20210712111016.GC26530@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 12 Jul 2021 16:00:54 +0300
Message-ID: <CAOQ4uxgnbirvr-KSMQyz-PL+Q_FmBF_OfSmWFEu6B0TYN-w1tg@mail.gmail.com>
Subject: Re: FAN_REPORT_CHILD_FID
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 12, 2021 at 2:10 PM Jan Kara <jack@suse.cz> wrote:
>
> Hi Amir!
>
> On Sun 11-07-21 20:02:29, Amir Goldstein wrote:
> > I am struggling with an attempt to extend the fanotify API and
> > I wanted to ask your opinion before I go too far in the wrong direction.
> >
> > I am working with an application that used to use inotify rename
> > cookies to match MOVED_FROM/MOVED_TO events.
> > The application was converted to use fanotify name events, but
> > the rename cookie functionality was missing, so I am carrying
> > a small patch for FAN_REPORT_COOKIE.
> >
> > I do not want to propose this patch for upstream, because I do
> > not like this API.
> >
> > What I thought was that instead of a "cookie" I would like to
> > use the child fid as a way to pair up move events.
> > This requires that the move events will never be merged and
> > therefore not re-ordered (as is the case with inotify move events).
> >
> > My thinking was to generalize this concept and introduce
> > FAN_REPORT_CHILD_FID flag. With that flag, dirent events
> > will report additional FID records, like events on a non-dir child
> > (but also for dirent events on subdirs).
>
> I'm starting to get lost in what reports what so let me draw a table here:
>
> Non-directories
>                                 DFID    FID     CHILD_FID
> ACCESS/MODIFY/OPEN/CLOSE/ATTRIB parent  self    self
> CREATE/DELETE/MOVE              -       -       -
> DELETE_SELF/MOVE_SELF           x       self    self
> ('-' means cannot happen, 'x' means not generated)
>
> Directories
>                                 DFID    FID     CHILD_FID
> ACCESS/MODIFY/OPEN/CLOSE/ATTRIB self    self    self
> CREATE/DELETE/MOVE              self    self    target
> DELETE_SELF/MOVE_SELF           x       self    self
>
> Did I get this right?

I am not sure if the columns in your table refer to group flags
or to info records types? or a little bit of both, but I did not
mean for CHILD_FID to be a different record type.

Anyway, the only complexity missing from the table is that
for events reporting a single record with fid of a directory,
(i.e. self event on dir or dirent event) the record type depends
on the group flags.

FAN_REPORT_FID => FAN_EVENT_INFO_TYPE_FID
FAN_REPORT_DIR_FID => FAN_EVENT_INFO_TYPE_DFID

>
> I guess "CHILD_FID" seems somewhat confusing as it isn't immediately clear
> from the name what it would report e.g. for open of a non-directory.

I agree it is a bit confusing. FWIW for events on a non-dir child (not dirent)
FAN_REPORT_FID and FAN_REPORT_CHILD_FID flags yield the exact
same event info.

> Maybe
> we could call it "TARGET_FID"? Also I'm not sure it needs to be exclusive
> with FID. Sure it doesn't make much sense to report both FID and CHILD_FID
> but does the exclusivity buy us anything? I guess I don't have strong
> opinion either way, I'm just curious.
>

FAN_REPORT_TARGET_FID sounds good to me.
You are right. I don't think that exclusivity buys us anything.

> > There are other benefits from FAN_REPORT_CHILD_FID which are
> > not related to matching move event pairs, such as the case described
> > in this discussion [2], where I believe you suggested something along
> > the lines of FAN_REPORT_CHILD_FID.
> >
> > [2] https://lore.kernel.org/linux-fsdevel/CAOQ4uxhEsbfA5+sW4XPnUKgCkXtwoDA-BR3iRO34Nx5c4y7Nug@mail.gmail.com/
>
> Yes, I can see FAN_REPORT_CHILD_FID (or however we call it) can be useful
> at times (in fact I think we made a mistake that we didn't make reported
> FID to always be what you now suggest as CHILD_FID, but we found that out
> only when DFID+NAME implementation settled so that train was long gone).

Yes, we did. FAN_REPORT_TARGET_FID is also about trying to make amends.
We could have just as well called it FAN_REPORT_FID_V2, but no ;-)

> So I have no problem with that functionality as such.
>

Good, so I will try to see that I can come up with sane semantics that
also result in a sane man page.

> > Either FAN_REPORT_CHILD_FID would also prevent dirent events
> > from being merged or we could use another flag for that purpose,
> > but I wasn't able to come up with an idea for a name for this flag :-/
> >
> > I sketched this patch [1] to implement the flag and to document
> > the desired semantics. It's only build tested and I did not even
> > implement the merge rules listed in the commit message.
> >
> > [1] https://github.com/amir73il/linux/commits/fanotify_child_fid
>
> WRT changes to merging: Whenever some application wants to depend on the
> ordering of events I'm starting to get suspicious.

I completely agree with that sentiment.

But note that the application does NOT require event ordering.

I was proposing the strict ordering of MOVE_ events as a method
to allow for matching of MOVE_ pairs of the same target as
a *replacement* for the inotify rename cookie method.

> What is it using these events for?

The application is trying to match MOVE_ event pairs.
It's a best effort situation - when local file has been renamed,
a remote rename can also be attempted while verifying that the
recorded fid of the source (in remote file) matches the fid of the
local target.

> How is renaming different from linking a file into a new dir
> and unlinking it from the previous one which is a series of events that
> could be merged?

It is different because renames are common operations that actual people
often do and link+unlink are less common so we do not care to optimize
them. Anyway, as many other applications, our application does not
support syncing hardlinks to remote location, so link+unlink would be
handled as plain copy+delete and dedup of copied file is handled
is handled by the remote sync protocol.

As a matter of fact, a rename could also be (and sometimes is) handled
as copy+delete. In that case, the remote content would be fine but the
logs and change history would be inaccurate.

BTW, in my sketch commit message I offer to prevent merge of all dirent
events, not only MOVE_, because I claim that there is not much to be
gained from merging the CREATE/DELETE of a specific TARGET_FID
event with other events as there are normally very few of those events.

However, while I can argue why it is useful to avoid merge of dirent events,
it's not as easy for me to come up with a name for that flag not to
easily explain the semantics in man page :-/
so any help with coming up with simplified semantics would be appreciated.

> Also fanotify could still be merging events happening
> after rename to events before rename. Can the application tolerate that?

Yes. The application treats the name of the file as a property that
can be synced regardless of the file's data and metadata and it doesn't
need to be synced to remote in the same order that changes happened.
The destination is "eventually consistent" with the source.

> Inotify didn't do this because it is always merging only to the last event
> in the queue.
>
> When we were talking about FID events in the past (in the context of
> directory events) we always talked about application just maintaining a set
> of dirs (plus names) to look into. And that is safe and sound. But what you
> talk about now seems rather fragile at least from the limited information I
> have about your usecase...
>

It's true. The application uses the DFID as the main key for tracking changes -
i.e. which directories need to be synced.
Rename between directories is a case where syncing individual directories
looses information. It does not loose data, only the accuracy of reported
change history - IOW, its a minor functionality gap, but one that product
people will not be willing to waiver.

P.S. unlike rename of non-dir, rename of directories and large directory
trees specifically must be identified and handled as a remote rename,
but that is easy to achieve with MOVE_SELF, because as I wrote, the
application uses DFID as the key for tracking changes, so MOVE_SELF
of directory will carry a DFID whose "remote path" is stored in a db.

Thanks,
Amir.
