Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77D6B8A172
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 16:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfHLOqB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 10:46:01 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39809 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbfHLOqA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:46:00 -0400
Received: by mail-lj1-f196.google.com with SMTP id x4so6408400ljj.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 07:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZaGlV5OBaG8I83pvsjihid45NFnJRTn9496TwujIaXI=;
        b=WIRUIIjknYqkFNwJtm38+0CsZRBPiSpzwtVX5R6JN55OGVYc4XsWYFX8X4zJLPeJKq
         CSjXoysXYS5Y5zwLr7gvMjHYEzFyJW8nEQ5lJPD4OIOjy0krjWl0/wh+o8ejQRuz8dyZ
         ZaqWAyxRJ7FHf86RVRZPM4Mv6VjuL49tMSTt4P5WgBhgovdP1LV++xjkwR3yhDFVvLPl
         hmishGIPfyKnJTy1MB+0lRaL3sbqpkDJCOfrhB1GQ4HFWcr+OZ9x0jy6TDwn/uN1uPdG
         jAOMLThn9V5WAjgyQKOBQDWZf80kAvxutL41GmstiWeFCnC8KZ0QjGZXxGjSpq5BI5FW
         sDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZaGlV5OBaG8I83pvsjihid45NFnJRTn9496TwujIaXI=;
        b=Hpexbb1YGme0gtrY4cDbP+9Wz0EHX21UNkBcsf0eyc5kgC+hXOb+swkDOtKayxMknB
         KEFhywaTbZGSMvBuvhQldQelHqvwzZ7mg6+z8jYK1JZqIVCdFY2KCycKnXwdSxXsoeSt
         pVrzE2df7t357xqR0wxyYCq1Kde+UB76DD6mvzcWEkwz5W01B/1zY1P0O4leBYrZqtJd
         GuqsdouAfDAZiOVkvjmTmy1XFUG7CME5Zi6WlS2Z6tSokghoUmt9gWaeHJXM9CQaJhlt
         R60fxtyG5FHjgQb6zvzXy4OHomVGqFDGWACgnxTHrnzWjpZcMQa7a/0ZqZM/BoV9COP5
         b2KQ==
X-Gm-Message-State: APjAAAWOkoSd4+AfDlFrZiv99cpcQpkhhq7ayO5O+3r1wYyaI9B2pxeg
        h1LexZ6t0YCQuHQKCYJXn4Z2UjsvLpiFV5rre+rO
X-Google-Smtp-Source: APXvYqzujkc2BH0FIqLuHrfT33Rlx6ggSYmZDFa3Ywl40gD0HkUkA9LWgXfs4wdbLflpo9wrcvV+NGkJ7yGDcN6IubE=
X-Received: by 2002:a2e:9dc1:: with SMTP id x1mr6576889ljj.0.1565621158391;
 Mon, 12 Aug 2019 07:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190731153443.4984-1-acgoide@tycho.nsa.gov> <CAHC9VhQUoDwBiLi+BiW=_Px18v3xMhhGYDD2mLdu9YZJDWw1yg@mail.gmail.com>
 <CAOQ4uxigYZunXgq0BubRFNM51Kh_g3wrtyNH77PozUX+3sM=aQ@mail.gmail.com>
 <CAHC9VhRpTuL2Lj1VFwHW4YLpx0hJVSxMnXefooHqsxpEUg6-0A@mail.gmail.com>
 <CAOQ4uxiGNXbZ-DWeXTkNM4ySFbBbo1XOF1=3pjknsf+EjbNuOw@mail.gmail.com>
 <16c7c0c4a60.280e.85c95baa4474aabc7814e68940a78392@paul-moore.com> <20190812134145.GA11343@quack2.suse.cz>
In-Reply-To: <20190812134145.GA11343@quack2.suse.cz>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 12 Aug 2019 10:45:46 -0400
Message-ID: <CAHC9VhTzQr3aUV8waM_VNQorDeWGz2SQuP9PVZO+oTWL+3oAHA@mail.gmail.com>
Subject: Re: [PATCH] fanotify, inotify, dnotify, security: add security hook
 for fs notifications
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>, selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 12, 2019 at 9:41 AM Jan Kara <jack@suse.cz> wrote:
> On Sat 10-08-19 11:01:16, Paul Moore wrote:
> > On August 10, 2019 6:05:27 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > >>>> Other than Casey's comments, and ACK, I'm not seeing much commentary
> > >>>> on this patch so FS and LSM folks consider this your last chance - if
> > >>>> I don't hear any objections by the end of this week I'll plan on
> > >>>> merging this into selinux/next next week.
> > >>>
> > >>> Please consider it is summer time so people may be on vacation like I was...
> > >>
> > >> This is one of the reasons why I was speaking to the mailing list and
> > >> not a particular individual :)
> > >
> > > Jan is fsnotify maintainer, so I think you should wait for an explicit ACK
> > > from Jan or just merge the hook definition and ask Jan to merge to
> > > fsnotify security hooks.
> >
> > Aaron posted his first patch a month ago in the beginning of July and I
> > don't recall seeing any comments from Jan on any of the patch revisions.
> > I would feel much better with an ACK/Reviewed-by from Jan, or you - which
> > is why I sent that email - but I'm not going to wait forever and I'd like
> > to get this into -next soon so we can get some testing.
>
> Yeah, sorry for the delays. I'm aware of the patch but I was also on
> vacation and pretty busy at work so Amir always beat me in commenting on
> the patch and I didn't have much to add. Once Aaron fixes the latest
> comments from Amir, I'll give the patch the final look and give my ack.

That is prefect, thanks.

-- 
paul moore
www.paul-moore.com
