Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6323129A4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2019 20:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfLWTPF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Dec 2019 14:15:05 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34225 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfLWTPF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Dec 2019 14:15:05 -0500
Received: by mail-io1-f68.google.com with SMTP id z193so17120699iof.1;
        Mon, 23 Dec 2019 11:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kf0gsePYy7Hm2sIm0G4CqUMti1z92znyS4Kfbx4tVrc=;
        b=WALroa75ICLqLAknapPMMyhXn8NsOEbWa7tz4HTtkJeyUcLOgNgieRYkDat3aUxGzD
         jmX0u99ZTsxsiwDrKsnxhEFUHjSExzpOw7oTREg8NBEw2eY13H70bmwO2QUulsR82Eo0
         t5j5kI3HXQA1U8tcz6RulKlqKgYoxSQEtSv9HFxUOpg7a2SWATSza9+UumY9mg8jEcoT
         cKKE0zqytdvrleoODXFgRnt5CxuhkcNUvmXMjl5QsF8toj+Hh/LwYE+LhX4kCcRURHUJ
         6aBbuoLD71kKlZBGcB2Iugi2jXV2jKcaa3opTLH4R819JTyD4LKPifY+W0hCU81IYyDG
         FrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kf0gsePYy7Hm2sIm0G4CqUMti1z92znyS4Kfbx4tVrc=;
        b=k8pzkUK9OXqOGbZX4qLmZlBLoYPvQvrK1fhDIZ4G5IbZSrsNrGjccrQxFDI6fTEJr6
         xZQmUOz/O3aBEc+VixmFpNdqiZTkk3pJBjJzg4rFUV2ie8Q6SToqTjnW9gnpw1LWAK0n
         dba8tYdoLg+pMxhWW7lPJXKnK+p/gNo8525E0+GENcYJ4VYXFcULgB2onw1JEezaTUi4
         rRLohtlxL+0Vo+IBBOO8UXXTLbA6UJCSUltQEzdHp31cLhAWkhv3q/opsWhWylk6OlUZ
         x72v6BBSjI9FLhCwrpHCa5cbhiSOW/4c8T1LkBm8JoEzvFoDwnsJDyGTrx9afmlcUr8/
         faQQ==
X-Gm-Message-State: APjAAAVEbAG9FZyXmQPvCD9z0tBFWUQcqGp5J8Bu8jx1N8GQnW8Hflkl
        JUfcv4oYUHjDFE5jxcSt/KEW/AdXRIzVCVtiA+s=
X-Google-Smtp-Source: APXvYqwn33YeTicFe67UgebLrbVqFaAnHnEu4TkXC/DzpRD+EYOzwF183Mjk+amc9+PxCkFQ37KgBz1CdyJ0xubn9Y8=
X-Received: by 2002:a02:a481:: with SMTP id d1mr24735926jam.81.1577128504506;
 Mon, 23 Dec 2019 11:15:04 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxiKqEq9ts4fEq_husQJpus29afVBMq8P1tkeQT-58RBFg@mail.gmail.com>
 <CADKPpc33UGcuRB9p64QoF8g88emqNQB=Z03f+OnK4MiCoeVZpg@mail.gmail.com>
 <20191204173455.GJ8206@quack2.suse.cz> <CAOQ4uxjda6iQ1D0QEVB18TcrttVpd7uac++WX0xAyLvxz0x7Ew@mail.gmail.com>
 <20191204190206.GA8331@bombadil.infradead.org> <CAOQ4uxiZWKCUKcpBt-bHOcnHoFAq+nghWmf94rJu=3CTc5VhRA@mail.gmail.com>
 <20191211100604.GL1551@quack2.suse.cz> <CAOQ4uxij13z0AazCm7AzrXOSz_eYBSFhs0mo6eZFW=57wOtwew@mail.gmail.com>
 <CAOQ4uxiKzom5uBNbBpZTNCT0XLOrcHmOwYy=3-V-Qcex1mhszw@mail.gmail.com>
 <CAOQ4uxgBcLPGxGVddjFsfWJvcNH4rT+GrN6-YhH8cz5K-q5z2g@mail.gmail.com> <20191223181956.GB17813@quack2.suse.cz>
In-Reply-To: <20191223181956.GB17813@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 23 Dec 2019 21:14:53 +0200
Message-ID: <CAOQ4uxhUGCLQyq76nqREETT8kBV9uNOKsckr+xmJdR9Xm=cW3Q@mail.gmail.com>
Subject: Re: File monitor problem
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mo Re Ra <more7.rev@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Wez Furlong <wez@fb.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 23, 2019 at 8:20 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 19-12-19 09:33:24, Amir Goldstein wrote:
> > On Mon, Dec 16, 2019 at 5:00 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > On Wed, Dec 11, 2019 at 3:58 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > Hi Jan,
> > >
> > > I have something working.
> > >
> > > Patches:
> > > https://github.com/amir73il/linux/commits/fanotify_name
> > >
> > > Simple test:
> > > https://github.com/amir73il/ltp/commits/fanotify_name
> > >
> > > I will post the patches after I have a working demo, but in the mean while here
> > > is the gist of the API from the commit log in case you or anyone has comments
> > > on the API.
> > >
> > > Note that in the new event flavor, event mask is given as input
> > > (e.g. FAN_CREATE) to filter the type of reported events, but
> > > the event types are hidden when event is reported.
>
> Makes some sense I guess but at the same time won't this be rather
> confusing for users of the API?
>

<shrug/> I guess it will be confusing for users that we obfuscate the event
mask in the first place. I though that taking away the ability to
filter by event
type would be too much, but I can change that if you think otherwise.


> Also I've read you proposal and I'm somewhat wondering whether we are not
> overengineering this.

Possibly. Won't be my first time..

> I can see the need for FAN_DIR_MODIFIED_WITH_NAME
> (stupid name, I know) - generated when something changed with names in a
> particular directory, reported with FID of the directory and the name
> inside that directory involved with the change. Directory watching
> application needs this to keep track of "names to check". Is the name
> useful with any other type of event? _SELF events cannot even sensibly have
> it so no discussion there as you mention below. Then we have OPEN, CLOSE,
> ACCESS, ATTRIB events. Do we have any use for names with those?
>

The problem is that unlike dir fid, file fid cannot be reliably resolved
to path, that is the reason that I implemented  FAN_WITH_NAME
for events "possible on child" (see branch fanotify_name-wip).

A filesystem monitor typically needs to be notified on name changes and on
data/metadata modifications.

So maybe add just two new event types:
FAN_DIR_MODIFY
FAN_CHILD_MODIFY

Both those events are reported with name and allowed only with init flag
FAN_REPORT_FID_NAME.
User cannot filter FAN_DIR_MODIFY by part of create/delete/move.
User cannot filter FAN_CHILD_MODIFY by part of attrib/modify/close_write.
FAN_CHILD_MODIFY implies FAN_EVENT_ON_CHILD for directory watch,
but also works on sb/mount mark as if all directories are watched.

And there is nothing stopping user from requesting also _SELF events
and other events without name on the same group.

Does that sound better?

Thanks,
Amir.
