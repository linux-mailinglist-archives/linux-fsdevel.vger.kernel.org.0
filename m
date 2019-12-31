Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4257412D87E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2019 12:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfLaLyG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Dec 2019 06:54:06 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:34238 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfLaLyG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Dec 2019 06:54:06 -0500
Received: by mail-il1-f195.google.com with SMTP id s15so30084517iln.1;
        Tue, 31 Dec 2019 03:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k9vLrT1KjJzt2xInxIZ819KJ9/Svje6gaPuhAEXPP3E=;
        b=Z4Bz+bYVYySe3IX6Rbak/cbfA8c4c+yieQGY6uXrukeYHwpH3caPgxYCJI/p1EQu2G
         tiglNLEs7P2A7mu+SpU1r/wkikbARAlApR0IjDSAX3UQbUq/Z/Oc3ruMQxUw/wCAwXug
         6WO3sPUxB0PygVTBf/knnafIyrcV6DqWq4yD7whXWj0f8J5R5HPZzle6xqI7BSLBmo5G
         Q2LTr1zH0jtfnO+q6R2G+bux1nA8YN5A51Jsj/QBM/KTbmzt70FtJByetSI9OLBQi4SU
         sD4TX+5jFyeP7wIuSGwYxB2Zs7o7vYxeW/SrW+flffs5yqmHhrqXJm/W+SNk6c9Jj+kW
         wDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k9vLrT1KjJzt2xInxIZ819KJ9/Svje6gaPuhAEXPP3E=;
        b=GIWj29U80C/hnr2dMB1Y8Q0ZwtyZqFKRb8luqRQjJVySffiHw0aJlD0Rl1P/yhfxR+
         j1xtPmi97oKQVAVtohjqN2KLjGXTmLu3U7rShN25av6i5NLH8HXJMQ+NEduw9Vh5rB23
         dRoYxy7pcmzrn2bihPg6BX01x4ybjadtFPTh8W8UdgESA7LMjf7xSg0drWdn5xaFZAt0
         qh0unAF4OaD8tboSYCyCYL4uWH+rymtN9tiMB8etz+eLC0ekDxaNwNss1+UiQlXGS3K2
         F8VCOvLHrbPWbWqd18UYWAX/ZGlGUYpVDxZu4oNzboK67N/mXXAi7HtosvZ8hRwmNEbf
         SHDg==
X-Gm-Message-State: APjAAAVsllGf+Tyd1TFZK2EnosfE0N3gDakqSu1/BoViniZMecpI9U53
        t6KWTs0KTX3qIdCuf2W0Qf/mgeRPzh1ERQgoev8=
X-Google-Smtp-Source: APXvYqxYMZTiJcWI+/GAU2qjNw8e/o9SnhmChQCjVJ49reWy68lTn4qhfUDCWBKM54Y7kT/mRmT3PjjGc9sSihartOE=
X-Received: by 2002:a92:d5c3:: with SMTP id d3mr61208848ilq.250.1577793245385;
 Tue, 31 Dec 2019 03:54:05 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxiKqEq9ts4fEq_husQJpus29afVBMq8P1tkeQT-58RBFg@mail.gmail.com>
 <CADKPpc33UGcuRB9p64QoF8g88emqNQB=Z03f+OnK4MiCoeVZpg@mail.gmail.com>
 <20191204173455.GJ8206@quack2.suse.cz> <CAOQ4uxjda6iQ1D0QEVB18TcrttVpd7uac++WX0xAyLvxz0x7Ew@mail.gmail.com>
 <20191204190206.GA8331@bombadil.infradead.org> <CAOQ4uxiZWKCUKcpBt-bHOcnHoFAq+nghWmf94rJu=3CTc5VhRA@mail.gmail.com>
 <20191211100604.GL1551@quack2.suse.cz> <CAOQ4uxij13z0AazCm7AzrXOSz_eYBSFhs0mo6eZFW=57wOtwew@mail.gmail.com>
 <CAOQ4uxiKzom5uBNbBpZTNCT0XLOrcHmOwYy=3-V-Qcex1mhszw@mail.gmail.com>
 <CAOQ4uxgBcLPGxGVddjFsfWJvcNH4rT+GrN6-YhH8cz5K-q5z2g@mail.gmail.com>
 <20191223181956.GB17813@quack2.suse.cz> <CAOQ4uxhUGCLQyq76nqREETT8kBV9uNOKsckr+xmJdR9Xm=cW3Q@mail.gmail.com>
 <CAOQ4uxjwy4_jWitzHc9hSaBJwVZM68xxJTub50ZfrtgFSZFH8A@mail.gmail.com>
In-Reply-To: <CAOQ4uxjwy4_jWitzHc9hSaBJwVZM68xxJTub50ZfrtgFSZFH8A@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 31 Dec 2019 13:53:54 +0200
Message-ID: <CAOQ4uxitZ0eu=r4-oW8xV_NyRoDtz4Sv192ieGSsBHAkow2YGQ@mail.gmail.com>
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

On Tue, Dec 24, 2019 at 5:49 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> > > I can see the need for FAN_DIR_MODIFIED_WITH_NAME
> > > (stupid name, I know) - generated when something changed with names in a
> > > particular directory, reported with FID of the directory and the name
> > > inside that directory involved with the change. Directory watching
> > > application needs this to keep track of "names to check". Is the name
> > > useful with any other type of event? _SELF events cannot even sensibly have
> > > it so no discussion there as you mention below. Then we have OPEN, CLOSE,
> > > ACCESS, ATTRIB events. Do we have any use for names with those?
> > >
> >
> > The problem is that unlike dir fid, file fid cannot be reliably resolved
> > to path, that is the reason that I implemented  FAN_WITH_NAME
> > for events "possible on child" (see branch fanotify_name-wip).
> >
> > A filesystem monitor typically needs to be notified on name changes and on
> > data/metadata modifications.
> >

And just before 2019 ends, here is the promised demo.

The kernel branch was added support for events "on child" with name [1].
The inotifywatch demo created for FAN_REPORT_FID was extended to
watch events with FAN_REPORT_FID_NAME [2].

[1] https://github.com/amir73il/linux/commits/fanotify_name
[2] https://github.com/amir73il/inotify-tools/commits/fanotify_name

The demo branch includes the script test_demo.sh, whose output can be
seen here below, that does:

1. Create a small data set (in a filesystem mounted at /vdf)
2. Set up an fanotify filesystem mark watching for all fs changes
3. Make some filesystem changes on files and dirs
4. Read events with fid+name info after 2 seconds delay
5. Check the uptodate path of events with open_by_handle_at+faccessat
6. Print summary of all paths that require "attention"
7. Paths that are currently ENOENT are marked with "(deleted)"

The report includes all the information needed to sync filesystem
changes to mirror or to re-index filesystem after changes.

For example, the file a/b/c/1 was moved to a/b/c/d/e/f/g/1 and then
directory a/b/c/d/e/f/g was moved to a/b/c/d/e/G.
In the report, the paths a/b/c/1 and a/b/c/d/e/f/g are listed as (deleted)
and the paths a/b/c/d/e/G and a/b/c/d/e/G/1 are listed as changed.
There is no record in the report of the intermediate path a/b/c/d/e/f/g/1.

Happy new year!
Amir.

---------------
# ./test_demo.sh /vdf
+ WD=/vdf
+ cd /vdf
+ rm -rf a
+ mkdir -p a/b/c/d/e/f/g/
+ touch a/b/c/0 a/b/c/1 a/b/c/d/e/f/g/0
+ sleep 1
+ inotifywatch --global --writes --timeout -2 /vdf
Establishing filesystem global watch...
Finished establishing watches, now collecting statistics.
Sleeping for 2 seconds...
+
+ t=Create files and dirs...
+ touch a/0 a/1 a/2 a/3
+ mkdir a/dir0 a/dir1 a/dir2
+
+ t=Rename files and dirs...
+ mv a/0 a/3
+ mv a/dir0 a/dir3
+
+ t=Delete files and dirs...
+ rm a/1
+ rmdir a/dir1
+
+ t=Modify files and dirs...
+ chmod +x a/b/c/d
+ touch a/b/c/0
+
+ t=Move files and dirs...
+ mv a/b/c/1 a/b/c/d/e/f/g/1
+ mv a/b/c/d/e/f/g a/b/c/d/e/G
+
[fid=fd50.0.2007402;name='0'] /vdf/a/0 (deleted)
[fid=fd50.0.2007402;name='1'] /vdf/a/1 (deleted)
[fid=fd50.0.2007402;name='2'] /vdf/a/2
[fid=fd50.0.2007402;name='3'] /vdf/a/3
[fid=fd50.0.2007402;name='dir0'] /vdf/a/dir0 (deleted)
[fid=fd50.0.2007402;name='dir1'] /vdf/a/dir1 (deleted)
[fid=fd50.0.2007402;name='dir2'] /vdf/a/dir2
[fid=fd50.0.2007402;name='dir3'] /vdf/a/dir3
[fid=fd50.0.8c;name='d'] /vdf/a/b/c/d
[fid=fd50.0.8c;name='0'] /vdf/a/b/c/0
[fid=fd50.0.8c;name='1'] /vdf/a/b/c/1 (deleted)
[fid=fd50.0.2007403;name='1'] /vdf/a/b/c/d/e/G/1
[fid=fd50.0.10000c2;name='g'] /vdf/a/b/c/d/e/f/g (deleted)
[fid=fd50.0.2007403;name='G'] /vdf/a/b/c/d/e/G
total  filename
2      /vdf/a/0 (deleted)
2      /vdf/a/1 (deleted)
2      /vdf/a/3
2      /vdf/a/dir0 (deleted)
2      /vdf/a/dir1 (deleted)
1      /vdf/a/2
1      /vdf/a/dir2
1      /vdf/a/dir3
1      /vdf/a/b/c/d
1      /vdf/a/b/c/0
1      /vdf/a/b/c/1 (deleted)
1      /vdf/a/b/c/d/e/G/1
1      /vdf/a/b/c/d/e/f/g (deleted)
1      /vdf/a/b/c/d/e/G
