Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5221431EA1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 14:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbhBRM5J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 07:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbhBRKx3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 05:53:29 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A5CC061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Feb 2021 02:52:47 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id z18so1053623ile.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Feb 2021 02:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tLh++AN0vk0Kz9kYD8F8l9GYNXNgzZ2GC7OuRNEoNRE=;
        b=QP9FYl4jZT9MfDw2MNKuyG4dGlOjpJCG3InXrJ+VG9xxAfBKHFKqYvpMzptOBlugnK
         lAbRYO9/J9iNyqIFse3OCTSKbPU+zHzvwQK6AFWRizb221bO1PHfBl+4wXxktel4BdUG
         61BktqyYbNVqRT6iaxdlQe6Hj1N+HiF5Q+1DGTZunxN6PTnrkjyBYUIjfc46BdTFdKHF
         azoD/ge0YPQGCVwUiK2EqXptyI90JGdgvEaSB1BKiR1PRQAB3Y1Ceg8/g9aFGiw4GONH
         J2ZSfZffabft41IMI41DVbtPzFayCjGb6Bzgf2x5B03I2rbjrDtXGrmL3ognfDuYFpL+
         gtyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tLh++AN0vk0Kz9kYD8F8l9GYNXNgzZ2GC7OuRNEoNRE=;
        b=WHtzzQMfyxliYtGGDLM6LNYyOJ2W68qs+jwA+QHt3sB7+lOfJcVhA3Fd9ElMzpkV6h
         fP1srqS3RqcjT2yEQ1wmA91y5TB6oZIhKNjSGZZC/fY2XbBiYy7LGBsdjkAX5AdnGVWM
         I5RPSxu4I8CZzPECtihL1fN3nWYaw97U39butFVfAP3GNQiH812qzkKBWt6d69AMvNCH
         5rylKNHcPTF2k1j+jXZVSKo7xgKHrOtuzuN0Sw69v6pZWlrUx0Db8nghvMMNHtcWVjoc
         +Ow8PZaD4WRYwE2s3Z4JGP5/+Lbw7U1ukZFCDMscmIIfCbUyyVbr5uyxRM2B7pzx+wEU
         7NVg==
X-Gm-Message-State: AOAM532aOEbaD0fvuX+Qjw99r06MfdoBmkU+eSu9qTXmjOmxZkKdApdT
        5D/1hgV+hte7UMHe4HPLyrLApO2QWuls7emsVsc=
X-Google-Smtp-Source: ABdhPJwKSp15LjonrR8rpjp9Y784VijPa/vCNNQYEMXpxBKUs/JVrDUjCvsguJMN1pokCb+GmJtEtAfZKDTBpJVJaBE=
X-Received: by 2002:a92:c90b:: with SMTP id t11mr3248833ilp.275.1613645566822;
 Thu, 18 Feb 2021 02:52:46 -0800 (PST)
MIME-Version: 1.0
References: <20210202162010.305971-1-amir73il@gmail.com> <20210202162010.305971-3-amir73il@gmail.com>
 <20210216150247.GB21108@quack2.suse.cz> <CAOQ4uxhLQBPd3aeVOj0E3HpKiYoqpfzPv9wZ8H8ncWTG4FOrtA@mail.gmail.com>
 <20210217134837.GD14758@quack2.suse.cz> <CAOQ4uxjWXJpLBFQU8Z1WsaWxYTFB6_3HwAnUv5A5nKkTRtrXzA@mail.gmail.com>
In-Reply-To: <CAOQ4uxjWXJpLBFQU8Z1WsaWxYTFB6_3HwAnUv5A5nKkTRtrXzA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 18 Feb 2021 12:52:35 +0200
Message-ID: <CAOQ4uxgD-qnPDBzhnWcm+1E8xZzYdYk98_X+YAhGUNXgb-fkcQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] fsnotify: support hashed notification queue
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 17, 2021 at 5:42 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Wed, Feb 17, 2021 at 3:48 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 17-02-21 14:33:46, Amir Goldstein wrote:
> > > On Tue, Feb 16, 2021 at 5:02 PM Jan Kara <jack@suse.cz> wrote:
> > > > > @@ -300,10 +301,16 @@ static long inotify_ioctl(struct file *file, unsigned int cmd,
> > > > >       switch (cmd) {
> > > > >       case FIONREAD:
> > > > >               spin_lock(&group->notification_lock);
> > > > > -             list_for_each_entry(fsn_event, &group->notification_list,
> > > > > -                                 list) {
> > > > > -                     send_len += sizeof(struct inotify_event);
> > > > > -                     send_len += round_event_name_len(fsn_event);
> > > > > +             list = fsnotify_first_notification_list(group);
> > > > > +             /*
> > > > > +              * With multi queue, send_len will be a lower bound
> > > > > +              * on total events size.
> > > > > +              */
> > > > > +             if (list) {
> > > > > +                     list_for_each_entry(fsn_event, list, list) {
> > > > > +                             send_len += sizeof(struct inotify_event);
> > > > > +                             send_len += round_event_name_len(fsn_event);
> > > > > +                     }
> > > >
> > > > As I write below IMO we should enable hashed queues also for inotify (is
> > > > there good reason not to?)
> > >
> > > I see your perception of inotify_merge() is the same as mine was
> > > when I wrote a patch to support hashed queues for inotify.
> > > It is only after that I realized that inotify_merge() only ever merges
> > > with the last event and I dropped that patch.
> > > I see no reason to change this long time behavior.
> >
> > Ah, I even briefly looked at that code but didn't notice it merges only
> > with the last event. I agree that hashing for inotify doesn't make sense
> > then.
> >
> > Hum, if the hashing and merging is specific to fanotify and as we decided
> > to keep the event->list for the global event list, we could easily have the
> > hash table just in fanotify private group data and hash->next pointer in
> > fanotify private part of the event? Maybe that would even result in a more
> > compact code?
> >
>
> Maybe, I am not so sure. I will look into it.
>

I ended up doing something slightly different:
- The hash table and lists remained in fsnotify (and in a prep patch)
- event->key remains in fsnotify_event (and event->mask moved too)
- backend gets a callback insert() from fsnotify_add_event() to do it's thing
- event->next is in fanotify_event
- fanotify_insert() callback takes care of chaining all events by timeline

Hope you will like the result (pushed it to fanotify_merge branch).

Thanks,
Amir.
