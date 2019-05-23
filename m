Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2C9F280C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 17:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbfEWPPw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 11:15:52 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:40673 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730709AbfEWPPw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 11:15:52 -0400
Received: by mail-yb1-f193.google.com with SMTP id g62so2399700ybg.7;
        Thu, 23 May 2019 08:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7C1w/R/OVTf4arN5cUtfYsrYHtgapRpkZjh95wSXEAk=;
        b=tcOc5YsXCSi1Yb1sUWJZtzMcDdpA71BN7GYZHf4blrMX615X5vBq+DE1b4F0SoDzJx
         tuUas/HuW1yWtemL5riFUXptbnfm2rD/o2hdhPUyz3YVRdkEZKbSP7ayL2tFE6AaiJJi
         8jfe4FKX7Q3K6XOI2RyLL0S/pM2XeRfgu4JHyf5O2+VRKWAISL8w8ASHOrNM9g9f0TCE
         yXAnzU6rQOTiXtnjtOLUYvgtQCm6lYlx9plQ55yr1gLJ9ls8mRGIU3EFqa3HepqRQvbM
         f03ni8BWmldzeuB8i+7T25VldToaMWLarkS99f/2t/kBJCf0ThLb3PHZExDGGXybNxd2
         UtqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7C1w/R/OVTf4arN5cUtfYsrYHtgapRpkZjh95wSXEAk=;
        b=Sy12gfgWVqzkPranXQlSYWC3NwJoasi8PviT4et88+JDv+Lk5SbSXRRHYmtSOWL259
         AwSCTTNY2Auv8BzFiOR1IzIvmqX/9DRZyT6co+4zjmSXkcJk4T6BWFGoobJxh/OSB89I
         NkkP+1lnEy6Lve6hxTGlFjiGNzM/rGHSvXkYsWUN3j7s5BbY0WYZAvqouksxxnpgukP8
         ruBD4gaBuLcw4bWyc9eBCwJoxxPmOEoFQA2wEA2JaAdNE0ciX4vVa1CLmTdF7UDmKvZI
         X253+o8bJgzxLEPEUBXr9+KaV849a8HMsKPX9pcCjJ35C4OKQ7xXXaYKlB7e4gu6MBHb
         iysQ==
X-Gm-Message-State: APjAAAVQdeo0me8fwZHYflcnehrwBHJu1hgBXRMrk/h/DMBEf/QPmjYo
        yidvdb4yEDiYCnZRwnGAXAsE/7vBLHcvt/V7v30=
X-Google-Smtp-Source: APXvYqyIlXnuW1PFvP2f8GN1hDcVzuoKOug9nygfLYxgELZIHvOTTZNefJEz7WsS+r2MYSJdvccFxF3bmDnflawCokM=
X-Received: by 2002:a25:cb0c:: with SMTP id b12mr21649228ybg.144.1558624551110;
 Thu, 23 May 2019 08:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxjV=7=FXuyccBK9Pu1B7o-w-pbc1FQXJxY4q6z8E93KOg@mail.gmail.com>
 <EB97EF04-D44F-4320-ACDC-C536EED03BA4@brauner.io> <CAOQ4uxhodqVw0DVfcvXYH5vBf4LKcv7t388ZwXeZPBTcEMzGSw@mail.gmail.com>
 <20190523095506.nyei5nogvv63lm4a@brauner.io> <CAOQ4uxiBeAzsE+b=tE7+9=25-qS7ohuTdEswYOt8DrCp6eAMuw@mail.gmail.com>
 <20190523104239.u63u2uth4yyuuufs@brauner.io> <CAOQ4uxji4jRvJnLvXe0yR4Ls7VxM_tjAypX1TqBe5FYr_7GnXw@mail.gmail.com>
 <20190523115845.w7neydaka5xivwyi@brauner.io> <CAOQ4uxgJXLyZe0Bs=q60=+pHpdGtnCdKKZKdr-3iTbygKCryRA@mail.gmail.com>
 <20190523133516.6734wclswqr6vpeg@brauner.io> <20190523144050.GE2949@quack2.suse.cz>
In-Reply-To: <20190523144050.GE2949@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 23 May 2019 18:15:39 +0300
Message-ID: <CAOQ4uxhF4WLZRcQcBYGvy+J+cmkUvNLfjGrwvqfBqyfPEHAdhw@mail.gmail.com>
Subject: Re: [PATCH] fanotify: remove redundant capable(CAP_SYS_ADMIN)s
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <christian@brauner.io>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 5:40 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 23-05-19 15:35:18, Christian Brauner wrote:
> > So let's say the user tells me:
> > - When the "/A/B/C/target" file appears on the host filesystem,
> >   please give me access to "target" in the container at a path I tell
> >   you.
> > What I do right now is listen for the creation of the "target" file.
> > But at the time the user gives me instructions to listen for
> > "/A/B/C/target" only /A might exist and so I currently add a watch on A/
> > and then wait for the creation of B/, then wait for the creation of C/
> > and finally for the creation of "target" (Of course, I also need to
> > handle B/ and C/ being removed again an recreated and so on.). It would
> > be helpful, if I could specify, give me notifications, recursively for
> > e.g. A/ without me having to place extra watches on B/ and C/ when they
> > appear. Maybe that's out of scope...
>
> I see. But this is going to be painful whatever you do. Consider for
> example situation like:
>
> mkdir -p BAR/B/C/
> touch BAR/B/C/target
> mv BAR A
>
> Or even situation where several renames race so that the end result creates
> the name (or does not create it depending on how renames race). And by the
> time you decide A/B/C/target exists, it doesn't need to exist anymore.
> Honestly I don't see how you want to implement *any* solution in a sane
> way. About the most reliable+simple would seem to be stat "A/B/C/target"
> once per second as dumb as it is.
>

Just wanted to point out that while looking at possible solutions for
"path based rules" for fanotify (i.e. subtree filter) I realized that the audit
subsystem already has a quite sophisticated mechanism to maintain
and enforce path based filesystem rules.

I do not love that code at all, I can hardly follow it, but if someone would
have wanted a way to be notified when an object of a given path name
appears or disappears from the namespace, it seems like something in
the kernel is already going to a great deal of effort to do that already.
Or maybe I am misunderstanding what this code does.

Thanks,
Amir.
