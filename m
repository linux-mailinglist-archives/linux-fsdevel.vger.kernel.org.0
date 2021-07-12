Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322243C6266
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 20:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbhGLSLT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 14:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbhGLSLT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 14:11:19 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC59C0613DD
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jul 2021 11:08:30 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id h3so20431720ilc.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jul 2021 11:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ao800KVjrOGwtPoISqX03uLCMqYk6nh+FouZZAjasEU=;
        b=urAW8MZIu23ubtPMIPeY7vCNb+fS8wntefqsw2Exeu/0AQ1HzFfSIEUOpt7XWCxVJP
         qXAbzxylG95OYIXtdDlm7rtqCFNZm+mBI5K/jOEpukzxrZezpPIL8aCTkcHfxmlKogQh
         oTX2MloW+kr93PpdyX5MKCQVRNDbxJ+8SehbmESxwYjaYRJPGTf3d7WnBiY/YcNMI2zw
         LczXK65QOqztZLC/Fi4NCMyid80nkmNpLdq3QfBJxWe7qAYz+1T0KpnPxbCRmRcp1h0X
         RQbwGK2oT1yKIlhgOhqaMttWTmtttanPjREEQTsH+uZvvHUOoRA8nWMFDHBgxVMYgE00
         CtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ao800KVjrOGwtPoISqX03uLCMqYk6nh+FouZZAjasEU=;
        b=Kmo4xPftE1nSbnRKWbZKZMr7JNXvwXSg2x2QcexfAoMVrqokNMYvBGKQkvWh9yMsbx
         xMtdwgE0UDuiGfxWTFRYlV6G9DhRaTboD49VH3oBUXLC0De5TeG0DuMi977QWCGRuvv+
         /7M7iVlMXfeh0P/mkCmtUdrYUxKh2D7Hb1lCZcNYQKw4NPTEltGEzJjUGaALPbp6EyUj
         qBFzK0rWPVL6fha14UYHbyinuJGe1pwpG55GZ2rtGTIX0dfpx2fbuCWwCp0G5reiN7bB
         00/1BIzS1NmPGje6U6TKgv+eYjpDCFrubt9y1jZPcMSPGIThXliOiDSdtGi/D5ADeNXv
         LQfQ==
X-Gm-Message-State: AOAM530mrnRoKndGXrqTaUHDHs1FQjScUUbqjUXXUtZjJhK6cpzxR1RA
        k2eyRM+H1oUs7tonHI0UFdnaGOOHLddIQMYLNGI=
X-Google-Smtp-Source: ABdhPJxI8NZB6Gsq8npsuGAOb3qOI6q6jDZuUtLLuRpHDvR8vlIJbxdpTmozYiUQeLePLfsBAl5CoV/HWTOVEqeSV7Y=
X-Received: by 2002:a05:6e02:1c2d:: with SMTP id m13mr74790ilh.137.1626113310133;
 Mon, 12 Jul 2021 11:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxgckzeRuiKSe7D=TVaJGTYwy4cbCFDpdWMQr1R_xXkJig@mail.gmail.com>
 <20210712111016.GC26530@quack2.suse.cz> <CAOQ4uxgnbirvr-KSMQyz-PL+Q_FmBF_OfSmWFEu6B0TYN-w1tg@mail.gmail.com>
 <20210712162623.GA9804@quack2.suse.cz>
In-Reply-To: <20210712162623.GA9804@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 12 Jul 2021 21:08:18 +0300
Message-ID: <CAOQ4uxgHeX3r4eJ=4OgksDnkddPqOs0a8JxP5VDFjEddmRcorA@mail.gmail.com>
Subject: Re: FAN_REPORT_CHILD_FID
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 12, 2021 at 7:26 PM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 12-07-21 16:00:54, Amir Goldstein wrote:
> > On Mon, Jul 12, 2021 at 2:10 PM Jan Kara <jack@suse.cz> wrote:
> > > On Sun 11-07-21 20:02:29, Amir Goldstein wrote:
> > > > I am struggling with an attempt to extend the fanotify API and
> > > > I wanted to ask your opinion before I go too far in the wrong direction.
> > > >
> > > > I am working with an application that used to use inotify rename
> > > > cookies to match MOVED_FROM/MOVED_TO events.
> > > > The application was converted to use fanotify name events, but
> > > > the rename cookie functionality was missing, so I am carrying
> > > > a small patch for FAN_REPORT_COOKIE.
> > > >
> > > > I do not want to propose this patch for upstream, because I do
> > > > not like this API.
> > > >
> > > > What I thought was that instead of a "cookie" I would like to
> > > > use the child fid as a way to pair up move events.
> > > > This requires that the move events will never be merged and
> > > > therefore not re-ordered (as is the case with inotify move events).
> > > >
> > > > My thinking was to generalize this concept and introduce
> > > > FAN_REPORT_CHILD_FID flag. With that flag, dirent events
> > > > will report additional FID records, like events on a non-dir child
> > > > (but also for dirent events on subdirs).
> > >
> > > I'm starting to get lost in what reports what so let me draw a table here:
> > >
> > > Non-directories
> > >                                 DFID    FID     CHILD_FID
> > > ACCESS/MODIFY/OPEN/CLOSE/ATTRIB parent  self    self
> > > CREATE/DELETE/MOVE              -       -       -
> > > DELETE_SELF/MOVE_SELF           x       self    self
> > > ('-' means cannot happen, 'x' means not generated)
> > >
> > > Directories
> > >                                 DFID    FID     CHILD_FID
> > > ACCESS/MODIFY/OPEN/CLOSE/ATTRIB self    self    self
> > > CREATE/DELETE/MOVE              self    self    target
> > > DELETE_SELF/MOVE_SELF           x       self    self
> > >
> > > Did I get this right?
> >
> > I am not sure if the columns in your table refer to group flags
> > or to info records types? or a little bit of both, but I did not
> > mean for CHILD_FID to be a different record type.
>
> Yeah, a bit of both.
>
> > Anyway, the only complexity missing from the table is that
> > for events reporting a single record with fid of a directory,
> > (i.e. self event on dir or dirent event) the record type depends
> > on the group flags.
> >
> > FAN_REPORT_FID => FAN_EVENT_INFO_TYPE_FID
> > FAN_REPORT_DIR_FID => FAN_EVENT_INFO_TYPE_DFID
>
> Right, I didn't realize this.
>
> > > I guess "CHILD_FID" seems somewhat confusing as it isn't immediately clear
> > > from the name what it would report e.g. for open of a non-directory.
> >
> > I agree it is a bit confusing. FWIW for events on a non-dir child (not dirent)
> > FAN_REPORT_FID and FAN_REPORT_CHILD_FID flags yield the exact
> > same event info.
> >
> > > Maybe
> > > we could call it "TARGET_FID"? Also I'm not sure it needs to be exclusive
> > > with FID. Sure it doesn't make much sense to report both FID and CHILD_FID
> > > but does the exclusivity buy us anything? I guess I don't have strong
> > > opinion either way, I'm just curious.
> > >
> >
> > FAN_REPORT_TARGET_FID sounds good to me.
> > You are right. I don't think that exclusivity buys us anything.
>
> OK. I've realized that the exclusivity is needed if we want to report info
> enabled by FAN_REPORT_TARGET_FID as FAN_EVENT_INFO_TYPE_FID. Because
> otherwise it would not be well defined what information is contained in
> FAN_EVENT_INFO_TYPE_FID. So either we have to go for exclusivity or for new
> type of event information.
>
> > > > There are other benefits from FAN_REPORT_CHILD_FID which are
> > > > not related to matching move event pairs, such as the case described
> > > > in this discussion [2], where I believe you suggested something along
> > > > the lines of FAN_REPORT_CHILD_FID.
> > > >
> > > > [2] https://lore.kernel.org/linux-fsdevel/CAOQ4uxhEsbfA5+sW4XPnUKgCkXtwoDA-BR3iRO34Nx5c4y7Nug@mail.gmail.com/
> > >
> > > Yes, I can see FAN_REPORT_CHILD_FID (or however we call it) can be useful
> > > at times (in fact I think we made a mistake that we didn't make reported
> > > FID to always be what you now suggest as CHILD_FID, but we found that out
> > > only when DFID+NAME implementation settled so that train was long gone).
> >
> > Yes, we did. FAN_REPORT_TARGET_FID is also about trying to make amends.
> > We could have just as well called it FAN_REPORT_FID_V2, but no ;-)
>
> OK, I was suspecting that but wasn't sure :). I guess that's another reason
> why exclusivity makes more sense.
>
> > > > Either FAN_REPORT_CHILD_FID would also prevent dirent events
> > > > from being merged or we could use another flag for that purpose,
> > > > but I wasn't able to come up with an idea for a name for this flag :-/
> > > >
> > > > I sketched this patch [1] to implement the flag and to document
> > > > the desired semantics. It's only build tested and I did not even
> > > > implement the merge rules listed in the commit message.
> > > >
> > > > [1] https://github.com/amir73il/linux/commits/fanotify_child_fid
> > >
> > > WRT changes to merging: Whenever some application wants to depend on the
> > > ordering of events I'm starting to get suspicious.
> >
> > I completely agree with that sentiment.
> >
> > But note that the application does NOT require event ordering.
> >
> > I was proposing the strict ordering of MOVE_ events as a method
> > to allow for matching of MOVE_ pairs of the same target as
> > a *replacement* for the inotify rename cookie method.
>
> Aha, I see I got confused a bit. Sorry about that.
>
> > > What is it using these events for?
> >
> > The application is trying to match MOVE_ event pairs.
> > It's a best effort situation - when local file has been renamed,
> > a remote rename can also be attempted while verifying that the
> > recorded fid of the source (in remote file) matches the fid of the
> > local target.
> >
> > > How is renaming different from linking a file into a new dir
> > > and unlinking it from the previous one which is a series of events that
> > > could be merged?
> >
> > It is different because renames are common operations that actual people
> > often do and link+unlink are less common so we do not care to optimize
> > them. Anyway, as many other applications, our application does not
> > support syncing hardlinks to remote location, so link+unlink would be
> > handled as plain copy+delete and dedup of copied file is handled
> > is handled by the remote sync protocol.
> >
> > As a matter of fact, a rename could also be (and sometimes is) handled
> > as copy+delete. In that case, the remote content would be fine but the
> > logs and change history would be inaccurate.
> >
> > BTW, in my sketch commit message I offer to prevent merge of all dirent
> > events, not only MOVE_, because I claim that there is not much to be
> > gained from merging the CREATE/DELETE of a specific TARGET_FID
> > event with other events as there are normally very few of those events.
> >
> > However, while I can argue why it is useful to avoid merge of dirent events,
> > it's not as easy for me to come up with a name for that flag not to
> > easily explain the semantics in man page :-/
> > so any help with coming up with simplified semantics would be appreciated.
>
> Just a brainstorming idea: How about creating new event FAN_RENAME that
> would report two DFIDs (if it is cross directory rename)?

I like the idea, but it would have to be two DFID_NAME is case of
FAN_REPORT_DFID_NAME and also for same parent rename
to be consistent.

> On the uAPI side
> it is very straightforward I think (unlike inotify where this could not be
> easily done because of fixed sized event + name).

Right.

> On the kernel API side we
> need to somehow feed the second directory into fsnotify() but with the
> changes Gabriel is doing it should not be that painful anymore...

Right, but we also need to parcel the fanotify_name_event
for storing two DFID_NAME and one FID.

> And then
> we can just avoid any problems with event matching, event merging etc.
> Thoughts?

It certainly qualifies as "simplifying semantics" :)
I think it's worth a shot, so I'll take a swing at it.
However, that means that "FAN_REPORT_FID_V2" will have
to wait for another time or never...

Thanks,
Amir.
