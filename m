Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9863D8B22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 11:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbhG1JwN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 05:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbhG1JwN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 05:52:13 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9E9C061757;
        Wed, 28 Jul 2021 02:52:11 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id h1so2262395iol.9;
        Wed, 28 Jul 2021 02:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Gl5yKnnnXk1ZZ9W2CvCpjkieAWrOTayTVRuhnyyS2A=;
        b=tJJhdYDgpfaS/of679bqGpm6ttt0guS76v3xlyTTDNpGC23fZhQkBx839/xBzYwv/r
         bMxXqgYRjIVOPXo9edEag/ujh9Q1ijnBOWVdfB9SBiG7DS6+jACcXHskvI/gPOtGjbLp
         dDsIsz1O9yrxEhQXz7BDcAyXmWyLiTjP0KxVIqD79/U+526IA7l2353QlS8x2pgnzEG0
         ZnbjgIh/bRGDSW4h+h55k9v99ZaWbrXH3KXn8RG/gTQlg6/erma/7Gjp3csq7CY21F5F
         KsModwnjL7lXQva5a8FZbvw4F6KWc4t8pH8Vhm8+kHtpxeyzBnwwYzD8O1IZ2CeziJ9n
         qqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Gl5yKnnnXk1ZZ9W2CvCpjkieAWrOTayTVRuhnyyS2A=;
        b=ZiLyzIUOX+wOGi9TndjKCKYDR0F+/jpIURermKrgLeRvG8JblWO0NgGiTSJ/wy3q1v
         vlJS77SvIXZkjkP8sIOD25rQ82weenYFeK0AGwAWztU3mipXjx98Fmi8JugYs4ky+U82
         DmhEAn4aHXR796FUs6aioCCuXQu21QjfivN2T3+hQx0Nlbp+MVmx221pRDkYufnwDjd4
         FxbrEYkf+JFqqXww98vemThRv9IHxnFYwnnMOxApgepa1UMbA40C3CC+AVxi4efa5TgF
         bkXt6vtTp4SkKliz0gez58qyDhWJa9s0o/5VooPxV440hlQf6jNFWhhZpr/jghu9MlUu
         5odg==
X-Gm-Message-State: AOAM531ZpjrvgoEP0pqX/kgnGKcD70a4YaTDZenBvI5KWbIaPFaXtV51
        4C+hng83vIsOSj9a+zEwvVpMsraiZwR6h3DYqVQ=
X-Google-Smtp-Source: ABdhPJwzmbjWzXm46dMehQD8J+uVfI9iD/EAnjGLfzR63SUwwxrfDn07VGBqZF9SQHgt6TtSzI9/ts7DwZQJrLS3h5o=
X-Received: by 2002:a02:908a:: with SMTP id x10mr25256456jaf.30.1627465930719;
 Wed, 28 Jul 2021 02:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxgckzeRuiKSe7D=TVaJGTYwy4cbCFDpdWMQr1R_xXkJig@mail.gmail.com>
 <20210712111016.GC26530@quack2.suse.cz> <CAOQ4uxgnbirvr-KSMQyz-PL+Q_FmBF_OfSmWFEu6B0TYN-w1tg@mail.gmail.com>
 <20210712162623.GA9804@quack2.suse.cz> <CAOQ4uxgHeX3r4eJ=4OgksDnkddPqOs0a8JxP5VDFjEddmRcorA@mail.gmail.com>
 <YO469q9T7h0LBlIT@google.com> <CAOQ4uxgkMrMiNNA=Y2OKP4XYoiDMMZLZshzyviirmRzwQvjr2w@mail.gmail.com>
 <YPDKa0tZ+kIoT8Um@google.com> <20210716094755.GD31920@quack2.suse.cz>
 <CAOQ4uxhxa9PL4CTkXNe6_iH2qNOf-TW8FdWgwSDa-ZiCGzb=UQ@mail.gmail.com> <CAOQ4uxhuQ71pxyK5DqPa=-toAL2-w=0mUwnZjwGLjbYm72AuKQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxhuQ71pxyK5DqPa=-toAL2-w=0mUwnZjwGLjbYm72AuKQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 28 Jul 2021 12:51:59 +0300
Message-ID: <CAOQ4uxjYDDk00VPdWtRB1_tf+gCoPFgSQ9O0p0fGaW_JiFUUKA@mail.gmail.com>
Subject: Re: FAN_REPORT_CHILD_FID
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+linux-api

On Tue, Jul 27, 2021 at 1:44 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Fri, Jul 16, 2021 at 2:24 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Fri, Jul 16, 2021 at 12:47 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Fri 16-07-21 09:53:15, Matthew Bobrowski wrote:
> > > > On Wed, Jul 14, 2021 at 03:09:56PM +0300, Amir Goldstein wrote:
> > > > > I am still debating with myself between adding a new event type
> > > > > (FAN_RENAME), adding a new report flag (FAN_REPORT_TARGET_FID)
> > > > > that adds info records to existing MOVE_ events or some combination.
> > > >
> > > > Well, if we went with adding a new event FAN_RENAME and specifying that
> > > > resulted in the generation of additional
> > > > FAN_EVENT_INFO_TYPE_DFID_NAME_{FROM,TO} information record types for an
> > > > event, wouldn't it be weird as it doesn't follow the conventional mechanism
> > > > of a listener asking for additional information records? As in,
> > > > traditionally we'd intialize the notification group with a flag and then
> > > > that flag controls whether or not one is permitted to receive events of a
> > > > particular type that may or may not include information records?
> > > >
> > > > Maybe a combination approach is needed in this instance, but this doesn't
> > > > necessarily simplify things when attempting to document the API semantics
> > > > IMO.
> > >
> > > So there are couple of ways how to approach this I guess. One is that we
> > > add a flag like FAN_REPORT_SECONDARY_DFID and FAN_REPORT_SECONDARY_NAME
> > > which would add another DFID(+NAME) record of new type to rename event. In
> > > principle these could be added to MOVED_FROM and/or MOVED_TO events
> > > (probably both are useful). But I'd find the naming somewhat confusing and
> > > difficult to sensibly describe.
> > >
> > > That's why I think it may be clearer to go with new FAN_RENAME event that
> > > will be triggered when the directory is on either end of rename(2) (source
> > > or target). If DFID(+NAME) is enabled for the group, the event would report
> > > both source and target DFIDs (and names if enabled) instead of one. I don't
> > > think special FAN_REPORT_? flag to enable the second DFID would be useful
> > > in this case (either for clarity or enabling some functionality).
> > >
> >
> > I agree that FAN_RENAME without any new REPORT flag is possible.
> > Still, I would like to at least try to come up with some UAPI that is more
> > compatible with existing semantics and simlifies them rather than creating
> > more special cases.
> >
> > For example, if FAN_REPORT_ALL_FIDS would start reporting all the
> > relevant fid records for all events, then nothing would change for
> > FAN_OPEN etc, but FAN_CREATE etc would start reporting the
> > target fid and FAN_MOVED_* would start reporting source, target and self
> > fids or dfid/name records and then FAN_MOVED_* pair can be "merged"
> > because they carry the exact same information.
> > (I suppose FAN_MOVE_SELF could be "merged" with them as well)
> >
> > When I write "merged" I mean queued as a single recorded event
> > depending on backend flags, like we do with event ON_CHILD and
> > event on self for inotify vs. fanotify.
> >
> > With this scheme, listeners that only set FAN_MOVED_FROM in
> > mask would get all relevant information and users that only set
> > FAN_MOVED_TO would get all relevant information and we avoid
> > the spam of different event formats for the same event in case
> > users set FAN_MOVED|FAN_RENAME|FAN_MOVE_SELF in the mask.
> >
> > That just leaves the question of HOW to describe the info records
> > in a consistent way.
> >
> > I was thinking about:
> >
> > #define FAN_EVENT_INFO_OF_SELF           1
> > #define FAN_EVENT_INFO_OF_SOURCE    2
> > #define FAN_EVENT_INFO_OF_TARGET     3
> >
> > struct fanotify_event_info_header {
> >         __u8 info_type; /* The type of object of the info record */
> >         __u8 info_of;     /* The subject of the info record */
> >         __u16 len;
> > };
> >
> > The existing info_type values determine HOW that info can be used.
> > For example, FAN_EVENT_INFO_TYPE_DFID can always be resolved
> > to a linked path if directory is not dead and reachable, while
> > FAN_EVENT_INFO_TYPE_FID is similar, but it could resolve to an
> > unknown path even if the inode is linked.
> >
> > Most events will only report records OF_SELF or OF_TARGET or both.
> > FAN_MOVED_* will also report records OF_SOURCE.
> >
> > One way to think about it is that we are encoding all the information
> > found in man page about what the info record is describing, depending
> > on the event type and making it available in the event itself, so application
> > does not need to code the semantics of the man page w.r.t info records
> > meaning for different event types.
> >
> > w.r.t backward compatibility of event parsers, naturally, the REPORT_ALL
> > flag protects us from regressions, but also adapting to the new scheme is
> > pretty easy. In particular, if application ignored the info_of field the only
> > event where things could go wrong is FAN_MOVED_TO because the
> > first info record is not what it used to be (assuming that we report the
> > info of source dirent first).
> >
>
> > Thoughts?
>
> Jan,
>
> I know you are catching up on emails and this is a very low priority.
> Whenever you get to it, here is a POC branch I prepared for
> FAN_REPORT_FID_OF:
>
> https://github.com/amir73il/linux/commits/fanotify_fid_of
>

Slight change of plans. I pushed new branches:
https://github.com/amir73il/linux/commits/fanotify_target_fid
https://github.com/amir73il/ltp/commits/fanotify_target_fid

With the following changes:
1. Uses FAN_REPORT_TARGET_FID as you suggested
2. Requires FAN_REPORT_NAME (to reduce test matrix)
3. Implements 3rd record only for MOVED_FROM event

> This does not include the unified move event with 3 info records
> only the basic extension of the UAPI with the sub_type info
> concept, which is used to report child fid records for dirent events.
>

So I dropped the plan for a "unified rename event".
Adding one extra record only to MOVED_FROM was really easy
because we already have that information available in the "moved"
dentry passed to the backend.

I kept the info record subtype concept and second info record
I created with type DFID_NAME and subtype FID_OF_PARENT2,
but now this UAPI detail is up for debate.

We can easily throw away the subtype and use info type DFID2_NAME
instead.

The thing is, in an earlier version I did not require FAN_REPORT_NAME
and it was useful to reuse the subtype without having to create two new
types (i.e.  DFID2 and DFID2_NAME).

All-in-all it's a very minor difference in the UAPI and I could go either way.
I am leaning towards dropping the subtype, but I am not sure, so I kept
it to hear what other people have to say (CC: linux-api).

There is also the possibility to use the same info record type for the
second info record (DFID_NAME) because this record can only be
reported after a first valid DFID_NAME record, but I do not like this option.

Thoughts?

Amir.
