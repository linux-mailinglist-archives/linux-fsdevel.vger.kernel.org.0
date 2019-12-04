Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E36A113667
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 21:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbfLDU1n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 15:27:43 -0500
Received: from mail-yb1-f181.google.com ([209.85.219.181]:32828 "EHLO
        mail-yb1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbfLDU1n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 15:27:43 -0500
Received: by mail-yb1-f181.google.com with SMTP id o63so534238ybc.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2019 12:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vEDSAxVJspsQkapB0d5b7P2Bq260gk60i1fi74v126o=;
        b=L3isL41Gela8eoUTdM5MD24d9O2Hc53AOjoSE+o6HTNSlHXcjYeXGJ1yVOsfYcTAHm
         dfq0KRPm6Pa3N5ylphRqrlPHsE99IxvN+5DTtzaHdRED0vfSnYSBhyU3Xu1dcAnQnOJY
         HCTvy+TL1GIxrzSuG5JT0kBEhzz9mvWvPCYQs882//prfuoerfXvvIwK4Sq+E+/0j/RK
         SCJ+2IE3gHOW0p5Wy9ig6NBrSrb78vY3IzE9PpFTUUFdqDtMJbG43RyPT5ZUo7+4YMSg
         UE3+j8lQT2RAjtbO4iXGmcJvVRuuWF2m9+qzUnF0eGxh1VImbwkaUCb13BSurNIDoVNT
         jLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vEDSAxVJspsQkapB0d5b7P2Bq260gk60i1fi74v126o=;
        b=jQjTm0n9thyc+WQau+t/NmXFbR/43qbhTrlJJFjXyQhtkcvE4hdFxbCGpyuMjtxzMd
         8J8zpCyXZi1rdT65mOUN2oqWa773SOexaBwL6PH8kqCtW9BrmpKghk0i9NC6EgCJ6o1t
         p3pB//aRhGKU+1jGbN79zVfzndz60S5QtxR5Svsao5LLWmOYXEf92uKUiOb24ARBDe0+
         Ji4lqLJvq3KVqqJ36HiVMhPbT89vAsm6IiBRms+Dn+ROzPejUhdnLXAHbEctSQoSHLWR
         bqKhNkV/dOees/BAUANMEpWDEgN+BL6vG0Zy8ehbvoXiWnuehTj9I0JAB66Dz+F76dZ7
         KOsQ==
X-Gm-Message-State: APjAAAXyMKPlWOuyLHweGedtJLG8GiMZiuOoPd+EGAnHXrY7VvVnVfOu
        4ESGJI4ALYI9XUlwtd2ZxJJbWpqkCWabLblr8PrlvM5n
X-Google-Smtp-Source: APXvYqwlTkSpCmN6MfEgNZrchjkI0ShXPK92vWrFlGWGLBLFZnVmqc3ozNTmlOZh3alaXEcND6zSMrBMHek6v/sFXqg=
X-Received: by 2002:a25:240a:: with SMTP id k10mr3354082ybk.132.1575491262647;
 Wed, 04 Dec 2019 12:27:42 -0800 (PST)
MIME-Version: 1.0
References: <CADKPpc2RuncyN+ZONkwBqtW7iBb5ep_3yQN7PKe7ASn8DpNvBw@mail.gmail.com>
 <CAOQ4uxiKqEq9ts4fEq_husQJpus29afVBMq8P1tkeQT-58RBFg@mail.gmail.com>
 <CADKPpc33UGcuRB9p64QoF8g88emqNQB=Z03f+OnK4MiCoeVZpg@mail.gmail.com>
 <20191204173455.GJ8206@quack2.suse.cz> <CAOQ4uxjda6iQ1D0QEVB18TcrttVpd7uac++WX0xAyLvxz0x7Ew@mail.gmail.com>
 <20191204190206.GA8331@bombadil.infradead.org>
In-Reply-To: <20191204190206.GA8331@bombadil.infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 4 Dec 2019 22:27:31 +0200
Message-ID: <CAOQ4uxiZWKCUKcpBt-bHOcnHoFAq+nghWmf94rJu=3CTc5VhRA@mail.gmail.com>
Subject: Re: File monitor problem
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Mo Re Ra <more7.rev@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 4, 2019 at 9:02 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Dec 04, 2019 at 08:37:09PM +0200, Amir Goldstein wrote:
> > On Wed, Dec 4, 2019 at 7:34 PM Jan Kara <jack@suse.cz> wrote:
> > > The problem is there's no better reliable way. For example even if fanotify
> > > event provided a name as in the Amir's commit you reference, this name is
> > > not very useful. Because by the time your application gets to processing
> > > that fanotify event, the file under that name need not exist anymore, or
> >
> > For DELETE event, file is not expected to exist, the filename in event is
> > always "reliable" (i.e. this name was unlinked).
>
> Jan already pointed out that events may be reordered.  So a CREATE event
> and DELETE event may arrive out of order for the same file.  This will
> confuse any agent.
>

Right. Re-ordering of events is an issue that needs to be addressed.
But the truth is that events for the same file are not re-ordered, they
are merged (though a DELETE_SELF and CREATE could be re-ordered
because they are not on the same object).

The way to frame this correctly IMO is that fsnotify events let application
know that "something has changed", without any ordering guaranty
beyond "sometime before the event was read".

So far, that "something" can be a file (by fd), an inode (by fid),
more specifically a directory inode (by fid) where in an entry has
changed.

Adding filename info extends that concept to "something has changed
in the namespace at" (by parent fid+name).
All it means is that application should pay attention to that part of
the namespace and perform a lookup to find out what has changed.

Maybe the way to mitigate wrong assumptions about ordering and
existence of the filename in the namespace is to omit the event type
for "filename events", for example: { FAN_CHANGE, pfid, name }.

I know that defining a good API is challenging, but I have no doubt
that the need is real.
If anyone doubts that, please present an alternative that users can
actually use.

Ignoring users demand and leaving Linux filesystem notification API
functionality decades behind Windows and MacOS is not acceptable IMO.
We have made a big step forward with fanotify dirent events, but I think
we will need to make a few more adjustments to the API before we get to
what most users need.

Thanks,
Amir.
