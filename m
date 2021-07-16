Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7473CB6B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 13:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhGPL2B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 07:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbhGPL14 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 07:27:56 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5C9C06175F
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jul 2021 04:25:01 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id v26so10178131iom.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jul 2021 04:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sSi8fN7uCkkegPVrlIWgJGLRi3Qf4iu+sJ0FbJPSDoc=;
        b=ImWWQEGxpxvWJ98puyHkL9u+q9lu8wmSsGpf/YqZjgkF8fkxP2sfqetGfCs0WQOt6L
         KFdwGmhDPg1fgO7rN+WVNwUKka/kgkKKmLoz2Y1EUALLcjIeR0/2qbV/o2n5RS8j9i+W
         RqCyOM9jvgc3LILBbb6bDnrVf/eOjznWVuRWHVzJUB/NzbAb6IWI8SWCUFruRcYR7ZP5
         voJbJYFyzxEzboGy2lu5IRFPWse/reItHsRCBRANfNgZ5oc/UrRgI9QO7qoXQfVjskex
         13NJSoAgDx50s2w1R5taZuT97836NETudo28rC1s7OfHWvq6Eb5JVhcOM5seZIuBppav
         ExqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sSi8fN7uCkkegPVrlIWgJGLRi3Qf4iu+sJ0FbJPSDoc=;
        b=HkPLEz88gaeSS08yTgWSK3IiY0zpynE1vGS1nMSYl13uScndwOjeLsGs9tu1Dmvshj
         zs3s2/NltzRrN7uX6fQ0X5h4wLdFMOKn9onyU6gaSTGqLVNCVejIOQqWYnvdkc6e3GPc
         pdw/0JyUG/JFsutHiV3iEsnVD87Ev3O0ub4HraB7riysNkRKhMxZWmJLx18Kmb9B74XR
         4RerTRE6B5a3Gx7mWvgO7a/fAuO8sqJQwQV1sE+H5ICgvCKFs/wl4DhHN4ceso9Hj99u
         7Nny0HI9gP6j648xgSA81jBa1/nL2B8yTKMJTqSk709ayKctu9NMAqFOax42od78XXQ3
         Ri6A==
X-Gm-Message-State: AOAM530EVceOJ68WEaozzL10LrPZ/oSQtjOshdICxc9K7StmOUMqoGo0
        Hj7sHZASEJhbk0/dDA0usRNEkXzXrfECZj+mTzK/HV6W6VI=
X-Google-Smtp-Source: ABdhPJxA4ZOYC+6yl3CQ8HT6xeBwivjWvOeYWFs4chqdVBHqsBLS6JO64GnHLrepGOC0BOsEqmhPjQ1aXgxmxNLqyNg=
X-Received: by 2002:a05:6602:146:: with SMTP id v6mr7022820iot.5.1626434700797;
 Fri, 16 Jul 2021 04:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxgckzeRuiKSe7D=TVaJGTYwy4cbCFDpdWMQr1R_xXkJig@mail.gmail.com>
 <20210712111016.GC26530@quack2.suse.cz> <CAOQ4uxgnbirvr-KSMQyz-PL+Q_FmBF_OfSmWFEu6B0TYN-w1tg@mail.gmail.com>
 <20210712162623.GA9804@quack2.suse.cz> <CAOQ4uxgHeX3r4eJ=4OgksDnkddPqOs0a8JxP5VDFjEddmRcorA@mail.gmail.com>
 <YO469q9T7h0LBlIT@google.com> <CAOQ4uxgkMrMiNNA=Y2OKP4XYoiDMMZLZshzyviirmRzwQvjr2w@mail.gmail.com>
 <YPDKa0tZ+kIoT8Um@google.com> <20210716094755.GD31920@quack2.suse.cz>
In-Reply-To: <20210716094755.GD31920@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 16 Jul 2021 14:24:49 +0300
Message-ID: <CAOQ4uxhxa9PL4CTkXNe6_iH2qNOf-TW8FdWgwSDa-ZiCGzb=UQ@mail.gmail.com>
Subject: Re: FAN_REPORT_CHILD_FID
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 16, 2021 at 12:47 PM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 16-07-21 09:53:15, Matthew Bobrowski wrote:
> > On Wed, Jul 14, 2021 at 03:09:56PM +0300, Amir Goldstein wrote:
> > > I am still debating with myself between adding a new event type
> > > (FAN_RENAME), adding a new report flag (FAN_REPORT_TARGET_FID)
> > > that adds info records to existing MOVE_ events or some combination.
> >
> > Well, if we went with adding a new event FAN_RENAME and specifying that
> > resulted in the generation of additional
> > FAN_EVENT_INFO_TYPE_DFID_NAME_{FROM,TO} information record types for an
> > event, wouldn't it be weird as it doesn't follow the conventional mechanism
> > of a listener asking for additional information records? As in,
> > traditionally we'd intialize the notification group with a flag and then
> > that flag controls whether or not one is permitted to receive events of a
> > particular type that may or may not include information records?
> >
> > Maybe a combination approach is needed in this instance, but this doesn't
> > necessarily simplify things when attempting to document the API semantics
> > IMO.
>
> So there are couple of ways how to approach this I guess. One is that we
> add a flag like FAN_REPORT_SECONDARY_DFID and FAN_REPORT_SECONDARY_NAME
> which would add another DFID(+NAME) record of new type to rename event. In
> principle these could be added to MOVED_FROM and/or MOVED_TO events
> (probably both are useful). But I'd find the naming somewhat confusing and
> difficult to sensibly describe.
>
> That's why I think it may be clearer to go with new FAN_RENAME event that
> will be triggered when the directory is on either end of rename(2) (source
> or target). If DFID(+NAME) is enabled for the group, the event would report
> both source and target DFIDs (and names if enabled) instead of one. I don't
> think special FAN_REPORT_? flag to enable the second DFID would be useful
> in this case (either for clarity or enabling some functionality).
>

I agree that FAN_RENAME without any new REPORT flag is possible.
Still, I would like to at least try to come up with some UAPI that is more
compatible with existing semantics and simlifies them rather than creating
more special cases.

For example, if FAN_REPORT_ALL_FIDS would start reporting all the
relevant fid records for all events, then nothing would change for
FAN_OPEN etc, but FAN_CREATE etc would start reporting the
target fid and FAN_MOVED_* would start reporting source, target and self
fids or dfid/name records and then FAN_MOVED_* pair can be "merged"
because they carry the exact same information.
(I suppose FAN_MOVE_SELF could be "merged" with them as well)

When I write "merged" I mean queued as a single recorded event
depending on backend flags, like we do with event ON_CHILD and
event on self for inotify vs. fanotify.

With this scheme, listeners that only set FAN_MOVED_FROM in
mask would get all relevant information and users that only set
FAN_MOVED_TO would get all relevant information and we avoid
the spam of different event formats for the same event in case
users set FAN_MOVED|FAN_RENAME|FAN_MOVE_SELF in the mask.

That just leaves the question of HOW to describe the info records
in a consistent way.

I was thinking about:

#define FAN_EVENT_INFO_OF_SELF           1
#define FAN_EVENT_INFO_OF_SOURCE    2
#define FAN_EVENT_INFO_OF_TARGET     3

struct fanotify_event_info_header {
        __u8 info_type; /* The type of object of the info record */
        __u8 info_of;     /* The subject of the info record */
        __u16 len;
};

The existing info_type values determine HOW that info can be used.
For example, FAN_EVENT_INFO_TYPE_DFID can always be resolved
to a linked path if directory is not dead and reachable, while
FAN_EVENT_INFO_TYPE_FID is similar, but it could resolve to an
unknown path even if the inode is linked.

Most events will only report records OF_SELF or OF_TARGET or both.
FAN_MOVED_* will also report records OF_SOURCE.

One way to think about it is that we are encoding all the information
found in man page about what the info record is describing, depending
on the event type and making it available in the event itself, so application
does not need to code the semantics of the man page w.r.t info records
meaning for different event types.

w.r.t backward compatibility of event parsers, naturally, the REPORT_ALL
flag protects us from regressions, but also adapting to the new scheme is
pretty easy. In particular, if application ignored the info_of field the only
event where things could go wrong is FAN_MOVED_TO because the
first info record is not what it used to be (assuming that we report the
info of source dirent first).

Thoughts?

Amir.
