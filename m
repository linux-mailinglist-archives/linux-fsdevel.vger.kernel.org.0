Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 834DF11AC9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 14:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbfLKN64 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 08:58:56 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41773 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfLKN64 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:58:56 -0500
Received: by mail-yw1-f68.google.com with SMTP id l22so8950040ywc.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 05:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r2Fl2ODxdeg5fMEhbblJuZIVaZdxfvgpVmuNYieGtAI=;
        b=F4HW/mYp+O+FtnTn7Sd360WhNNp8iv4Enw/GWAY63yjDSnz9Rdl2vewf83N5zmEP0Q
         q/WhCByNP+w4mZ43HoqqFn+A1VuN3mffTTDJR3tOHDXrWgxSxi25eHYfTxgA2wUvq53J
         SB7YI4aiAoIMORXIPkekfJJd3B2gP/35/6uBlUSbcCNdE4FjplJtpfOVFrmNRb/RNVq3
         1yRN56AWlMwg+C568CtzVy+vkCZuyiOAl0tHMeYq/IPKLmD21k3LzQfvDcVZ5ZU2ZWZJ
         DbYtSLuqiMwKJK2bFmNUBL/Bv/5XiVuHVbAfAu8TfUl53MfigN1X2QUnNivTUMhIYG0M
         iPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r2Fl2ODxdeg5fMEhbblJuZIVaZdxfvgpVmuNYieGtAI=;
        b=Y7qMMrvMJYHHRtEBIrFanctBWSQPmPvSwaAssPqrH0vf/mZ2pkl73zzl2gg5E+9t7d
         kOEvhAf5e9TDkZt5EhdK/vamTD3wNarBqEKeXaYQD81ndrCEt04JipI6Geo7H85P3HOO
         u9llHwey6f3ztfjCatiRX3/F/MZLLyVBVT/Qy6QVTq91X3xt3E6uNqbG4ek5WcJLbS4i
         DC9rQhkp+2Q1ubJSbYCJBWBS5LrgLaJRCesl9r4Ut28WJ6b136ODRbWpeZ1Tokkm0RdF
         g1m334vmel0osh1gjTPiFq2dR2OnUunIdY0o9QXZh0ABFC4USL96ZACvQ/2vkUUB+EQK
         cbvw==
X-Gm-Message-State: APjAAAV9zPmAuZ3Fe9qybW7n9UO8c4kL1mkaO1zvs7792aAWA8bXCutw
        Nuu1Klyl0h1JLwORyLRupO47CtET1ONINJP292M=
X-Google-Smtp-Source: APXvYqwXbkQzQue66vFqHsGAqwn9HvuL+IX+5pdYJvSd+RaOqeV5Zf1npCZrYnwiyC0zRU4U7xriaeCBwusTecQ1ANw=
X-Received: by 2002:a81:4686:: with SMTP id t128mr2343708ywa.183.1576072735349;
 Wed, 11 Dec 2019 05:58:55 -0800 (PST)
MIME-Version: 1.0
References: <CADKPpc2RuncyN+ZONkwBqtW7iBb5ep_3yQN7PKe7ASn8DpNvBw@mail.gmail.com>
 <CAOQ4uxiKqEq9ts4fEq_husQJpus29afVBMq8P1tkeQT-58RBFg@mail.gmail.com>
 <CADKPpc33UGcuRB9p64QoF8g88emqNQB=Z03f+OnK4MiCoeVZpg@mail.gmail.com>
 <20191204173455.GJ8206@quack2.suse.cz> <CAOQ4uxjda6iQ1D0QEVB18TcrttVpd7uac++WX0xAyLvxz0x7Ew@mail.gmail.com>
 <20191204190206.GA8331@bombadil.infradead.org> <CAOQ4uxiZWKCUKcpBt-bHOcnHoFAq+nghWmf94rJu=3CTc5VhRA@mail.gmail.com>
 <20191211100604.GL1551@quack2.suse.cz>
In-Reply-To: <20191211100604.GL1551@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 11 Dec 2019 15:58:44 +0200
Message-ID: <CAOQ4uxij13z0AazCm7AzrXOSz_eYBSFhs0mo6eZFW=57wOtwew@mail.gmail.com>
Subject: Re: File monitor problem
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mo Re Ra <more7.rev@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Wez Furlong <wez@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 12:06 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 04-12-19 22:27:31, Amir Goldstein wrote:
[...]
> > The way to frame this correctly IMO is that fsnotify events let application
> > know that "something has changed", without any ordering guaranty
> > beyond "sometime before the event was read".
> >
> > So far, that "something" can be a file (by fd), an inode (by fid),
> > more specifically a directory inode (by fid) where in an entry has
> > changed.
> >
> > Adding filename info extends that concept to "something has changed
> > in the namespace at" (by parent fid+name).
> > All it means is that application should pay attention to that part of
> > the namespace and perform a lookup to find out what has changed.
> >
> > Maybe the way to mitigate wrong assumptions about ordering and
> > existence of the filename in the namespace is to omit the event type
> > for "filename events", for example: { FAN_CHANGE, pfid, name }.
>
> So this event would effectively mean: In directory pfid, some filename
> event has happened with name "name" - i.e. "name" was created (could mean
> also mkdir), deleted, moved. Am I right?

Exactly.

> And the application would then
> open_by_handle(2) + open_at(2) + fstat(2) the object pointed to by

open_by_handle(2) + fstatat(2) to be exact.

> (pfid, name) pair and copy whatever it finds to the other end (or delete on
> the other end in case of ENOENT)?

Basically, yes.
Although a modern sync tool may also keep some local map of
remote name -> local fid, to detect a local rename and try to perform a
remote rename.

>
> After some thought, yes, I think this is difficult to misuse (or infer some
> false guarantees out of it). As far as I was thinking it also seems good
> enough to implement more efficient syncing of directories.

Great, so I will work on the patches.

> Mohammad, would
> this kind of event be enough for your needs? Frankly, I'd like to see a
> sample program (say dir-tree-sync) that uses this event before merging the
> kernel change so that we can verify that indeed this event is usable for
> practical purposes in a race-free way...
>

I will prepare demo code for the new API based on inotifywatch.
Mohammad, if you like you could use the demo code to present a sync tool.
I am hoping to be able to integrate the new API with Watchman as a demo.

Thanks,
Amir.
