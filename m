Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3333D7390
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 12:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbhG0Ko7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 06:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236269AbhG0Ko6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 06:44:58 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1078AC061757
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jul 2021 03:44:58 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id r18so15425400iot.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jul 2021 03:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m0XGZGDgCsdMkQgJ6m/fS8fImgLN5ZcFU8urf8IBU8A=;
        b=TEj6bd1Ave3DHoTOw5LoiuAgMOCIBcZLL0bEdR9sKle0HLOwy1kLZpAEUh2FoB4xkr
         uKQ/LWm/vJKbQGn290SxWiIQVZZaYGCJ/RMotYtmZlZOKqjDZhy9sgrQ3gxoErZIY8zq
         Xz+FqHE7jV79VbyOR+uULv/dcqWNafnXtaAZIwBNkf1yUas8E0LmY5oGbwflHofJHLkX
         SXqGKKYmzSWNseFLHJXLWruar0U8atpQhJl8cc2T/Bt61zM69L4yXd+H8gY8Nlp5viIz
         1MLYr5scsoXFoDYlzHQc+p85eBNXT7lybGEe3hfMPtiAaCr2FMQ6zjtpJy0Rn7iIfROY
         86ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m0XGZGDgCsdMkQgJ6m/fS8fImgLN5ZcFU8urf8IBU8A=;
        b=hd1IUztzXuckQpZVvZ/9UtuTgYM7dsAqZw5l3opkeMgyFXok+HCJ5lflKJSn/E+WwE
         Ek+HM72DSWD4a7S8b6SNu6lohOjiKd+DxDE7ToUpGxiYoXIhaGKM1KlhkfYPqFNr8FmB
         qYruBnkhzAb/ps7rJAd+QATc0ar1Hiyf0pvz3tCpSiqkbmGvhRtpeMb08nJhOJuHBLoE
         +/FMjg1KCX0w84tTajE18wesNHU4He2SpliPr/G8z3lWqlNurPmUJU4lPx2wj0Tp4lGg
         hb1n7EXTJAYxqbZURITHwFUSNcdl2tlnXC0EMZl1p6FFQhyzELuB6ZoEo0//dQDG7cH9
         z0Rg==
X-Gm-Message-State: AOAM531qi44nm4a8M9GxFsnVODTybDhCcRYqn2mLpwNETEDQ1WHz22ZS
        gYaBZKAsi5rqeJEpYNf6I1nH+xoHFIwQq09j0RU=
X-Google-Smtp-Source: ABdhPJx89y7WPJagRTgHlXKlHY+Ouau3zjL/jGqrAp4mDIbQ4nUgdn1oflpTaGUa/cjAGrDIrayX/ccjec/eDdwTa+0=
X-Received: by 2002:a05:6638:3292:: with SMTP id f18mr21503192jav.120.1627382697526;
 Tue, 27 Jul 2021 03:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxgckzeRuiKSe7D=TVaJGTYwy4cbCFDpdWMQr1R_xXkJig@mail.gmail.com>
 <20210712111016.GC26530@quack2.suse.cz> <CAOQ4uxgnbirvr-KSMQyz-PL+Q_FmBF_OfSmWFEu6B0TYN-w1tg@mail.gmail.com>
 <20210712162623.GA9804@quack2.suse.cz> <CAOQ4uxgHeX3r4eJ=4OgksDnkddPqOs0a8JxP5VDFjEddmRcorA@mail.gmail.com>
 <YO469q9T7h0LBlIT@google.com> <CAOQ4uxgkMrMiNNA=Y2OKP4XYoiDMMZLZshzyviirmRzwQvjr2w@mail.gmail.com>
 <YPDKa0tZ+kIoT8Um@google.com> <20210716094755.GD31920@quack2.suse.cz> <CAOQ4uxhxa9PL4CTkXNe6_iH2qNOf-TW8FdWgwSDa-ZiCGzb=UQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxhxa9PL4CTkXNe6_iH2qNOf-TW8FdWgwSDa-ZiCGzb=UQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 27 Jul 2021 13:44:46 +0300
Message-ID: <CAOQ4uxhuQ71pxyK5DqPa=-toAL2-w=0mUwnZjwGLjbYm72AuKQ@mail.gmail.com>
Subject: Re: FAN_REPORT_CHILD_FID
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 16, 2021 at 2:24 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Fri, Jul 16, 2021 at 12:47 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 16-07-21 09:53:15, Matthew Bobrowski wrote:
> > > On Wed, Jul 14, 2021 at 03:09:56PM +0300, Amir Goldstein wrote:
> > > > I am still debating with myself between adding a new event type
> > > > (FAN_RENAME), adding a new report flag (FAN_REPORT_TARGET_FID)
> > > > that adds info records to existing MOVE_ events or some combination.
> > >
> > > Well, if we went with adding a new event FAN_RENAME and specifying that
> > > resulted in the generation of additional
> > > FAN_EVENT_INFO_TYPE_DFID_NAME_{FROM,TO} information record types for an
> > > event, wouldn't it be weird as it doesn't follow the conventional mechanism
> > > of a listener asking for additional information records? As in,
> > > traditionally we'd intialize the notification group with a flag and then
> > > that flag controls whether or not one is permitted to receive events of a
> > > particular type that may or may not include information records?
> > >
> > > Maybe a combination approach is needed in this instance, but this doesn't
> > > necessarily simplify things when attempting to document the API semantics
> > > IMO.
> >
> > So there are couple of ways how to approach this I guess. One is that we
> > add a flag like FAN_REPORT_SECONDARY_DFID and FAN_REPORT_SECONDARY_NAME
> > which would add another DFID(+NAME) record of new type to rename event. In
> > principle these could be added to MOVED_FROM and/or MOVED_TO events
> > (probably both are useful). But I'd find the naming somewhat confusing and
> > difficult to sensibly describe.
> >
> > That's why I think it may be clearer to go with new FAN_RENAME event that
> > will be triggered when the directory is on either end of rename(2) (source
> > or target). If DFID(+NAME) is enabled for the group, the event would report
> > both source and target DFIDs (and names if enabled) instead of one. I don't
> > think special FAN_REPORT_? flag to enable the second DFID would be useful
> > in this case (either for clarity or enabling some functionality).
> >
>
> I agree that FAN_RENAME without any new REPORT flag is possible.
> Still, I would like to at least try to come up with some UAPI that is more
> compatible with existing semantics and simlifies them rather than creating
> more special cases.
>
> For example, if FAN_REPORT_ALL_FIDS would start reporting all the
> relevant fid records for all events, then nothing would change for
> FAN_OPEN etc, but FAN_CREATE etc would start reporting the
> target fid and FAN_MOVED_* would start reporting source, target and self
> fids or dfid/name records and then FAN_MOVED_* pair can be "merged"
> because they carry the exact same information.
> (I suppose FAN_MOVE_SELF could be "merged" with them as well)
>
> When I write "merged" I mean queued as a single recorded event
> depending on backend flags, like we do with event ON_CHILD and
> event on self for inotify vs. fanotify.
>
> With this scheme, listeners that only set FAN_MOVED_FROM in
> mask would get all relevant information and users that only set
> FAN_MOVED_TO would get all relevant information and we avoid
> the spam of different event formats for the same event in case
> users set FAN_MOVED|FAN_RENAME|FAN_MOVE_SELF in the mask.
>
> That just leaves the question of HOW to describe the info records
> in a consistent way.
>
> I was thinking about:
>
> #define FAN_EVENT_INFO_OF_SELF           1
> #define FAN_EVENT_INFO_OF_SOURCE    2
> #define FAN_EVENT_INFO_OF_TARGET     3
>
> struct fanotify_event_info_header {
>         __u8 info_type; /* The type of object of the info record */
>         __u8 info_of;     /* The subject of the info record */
>         __u16 len;
> };
>
> The existing info_type values determine HOW that info can be used.
> For example, FAN_EVENT_INFO_TYPE_DFID can always be resolved
> to a linked path if directory is not dead and reachable, while
> FAN_EVENT_INFO_TYPE_FID is similar, but it could resolve to an
> unknown path even if the inode is linked.
>
> Most events will only report records OF_SELF or OF_TARGET or both.
> FAN_MOVED_* will also report records OF_SOURCE.
>
> One way to think about it is that we are encoding all the information
> found in man page about what the info record is describing, depending
> on the event type and making it available in the event itself, so application
> does not need to code the semantics of the man page w.r.t info records
> meaning for different event types.
>
> w.r.t backward compatibility of event parsers, naturally, the REPORT_ALL
> flag protects us from regressions, but also adapting to the new scheme is
> pretty easy. In particular, if application ignored the info_of field the only
> event where things could go wrong is FAN_MOVED_TO because the
> first info record is not what it used to be (assuming that we report the
> info of source dirent first).
>

> Thoughts?

Jan,

I know you are catching up on emails and this is a very low priority.
Whenever you get to it, here is a POC branch I prepared for
FAN_REPORT_FID_OF:

https://github.com/amir73il/linux/commits/fanotify_fid_of

This does not include the unified move event with 3 info records
only the basic extension of the UAPI with the sub_type info
concept, which is used to report child fid records for dirent events.

Here is an update of LTP test to support my claim about
ease of adaptation for existing applications to new UAPI:

https://github.com/amir73il/ltp/commits/fanotify_fid_of

I haven't bothered to create a man page draft, but I did go over the
existing documentation to estimate how much of it would need to change
and I think it would require surprisingly little changes as the man page
sections about expected info records were written in quite a broad language.

Thanks,
Amir.
