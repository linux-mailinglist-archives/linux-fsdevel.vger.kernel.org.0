Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C93F2D7569
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 13:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395396AbgLKMQF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 07:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390915AbgLKMPe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 07:15:34 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D7FC0613CF;
        Fri, 11 Dec 2020 04:14:53 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id p5so8565520ilm.12;
        Fri, 11 Dec 2020 04:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8cDOQmfAFYW500ial9Oq88Pc66YtTXmAyFW9c8UAgL4=;
        b=Rqbii/hiZX2u0r18l9PaNyOelCIybBSpTX5d8V2zjZVvMfpnHjiTxbxSx1HGSjZz1t
         /xbiTcCJ7prSorIQUfLFROMBdAenBv/62DkEL8rcruahU62yVPM+WTR+QLkYN56KQqH3
         qxN3tivVA5gBWJMFb/15YAtwIE8kg0HF8MUO90RYuSDcOqRIunhfF8g1JAXcgY1C1zbM
         P7hn9iDmIHhmoLwV0gF0J9ffbWS4EBTUHMk24eN9F1EkGLxRsKs8pG/CYrl/dQUNihLH
         hOnlrk0up88A92PgONil61FP07hIJbe30jKchXvWAhGuPHU+535qXs9jmWtcTV6kRq8W
         56yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8cDOQmfAFYW500ial9Oq88Pc66YtTXmAyFW9c8UAgL4=;
        b=CMJ9hy+R2fDqwj/ihcRVDNnQavscnPUXdtNU198uop5r/U849H1GRzV4QbkuuNSokH
         7oMwmQk68fEbnxuXCs8Y9/duYk1uFoez6Rmehhs599vfPCj4fst/+yrApyv/hmIYgXqI
         as4rJwVaxpB5SoHE9yXROmMJG1/Hkq7MVwv7vifxZgnQiJGmkzvirOAv2T+yK0/aMTJF
         TA87XwnhRWYoYbEFfJ+AfKqAcyvKN5icf58kzQ4ffRXbg+rJvoVTh6+2ZSsnwmH37qww
         MaIgU/fAXpG+FdrvQtYVZ0aoxkULbLRaZ/oNzF39uva3nFhS1DlAMlXq5B1IY97dNqdI
         qcXg==
X-Gm-Message-State: AOAM532t0kqNoLUlMJgwCcawpKke8gNi81dA86/kIoykvILXwtbQwwXo
        MFCYMEq3Na4FyA9H7LH48/qHJJWewVugtfG0k+in1sRLgwg=
X-Google-Smtp-Source: ABdhPJw6MVAIQPYR8YKyTOZEiGMtAXbbgMxDqFV2f2okKngEmpajnNgqVhm3Mady1k/3rjCyf17nxQQCkX8TqnxQbKc=
X-Received: by 2002:a92:6403:: with SMTP id y3mr15806043ilb.72.1607688893239;
 Fri, 11 Dec 2020 04:14:53 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2012101507080.1100@eggly.anvils>
 <CAOQ4uxj6Vvwj84KL4MaECzw1jV+i_Frm6cuqkrk8fT3a4M=FEw@mail.gmail.com> <20201211104713.GA15413@quack2.suse.cz>
In-Reply-To: <20201211104713.GA15413@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 11 Dec 2020 14:14:42 +0200
Message-ID: <CAOQ4uxhq2RZruX_PtsHeq1JA2j=LPa6gSgqSb7Haxvu9rTyU-A@mail.gmail.com>
Subject: Re: linux-next fsnotify mod breaks tail -f
To:     Jan Kara <jack@suse.cz>
Cc:     Hugh Dickins <hughd@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 11, 2020 at 12:47 PM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 11-12-20 10:42:16, Amir Goldstein wrote:
> > On Fri, Dec 11, 2020 at 1:45 AM Hugh Dickins <hughd@google.com> wrote:
> > >
> > > Hi Jan, Amir,
> > >
> > > There's something wrong with linux-next commit ca7fbf0d29ab
> > > ("fsnotify: fix events reported to watching parent and child").
> > >
> > > If I revert that commit, no problem;
> > > but here's a one-line script "tailed":
> > >
> > > for i in 1 2 3 4 5; do date; sleep 1; done &
> > >
> > > Then if I run that (same result doing ./tailed after chmod a+x):
> > >
> > > sh tailed >log; tail -f log
> > >
> > > the "tail -f log" behaves in one of three ways:
> > >
> > > 1) On a console, before graphical screen, no problem,
> > >    it shows the five lines coming from "date" as you would expect.
> > > 2) From xterm or another tty, shows just the first line from date,
> > >    but after I wait and Ctrl-C out, "cat log" shows all five lines.
> > > 3) From xterm or another tty, doesn't even show that first line.
> > >
> > > The before/after graphical screen thing seems particularly weird:
> > > I expect you'll end up with a simpler explanation for what's
> > > causing that difference.
> > >
> > > tailed and log are on ext4, if that's relevant;
> > > ah, I just tried on tmpfs, and saw no problem there.
> >
> > Nice riddle Hugh :)
> > Thanks for this early testing!
> >
> > I was able to reproduce this.
> > The outcome does not depend on the type of terminal or filesystem
> > it depends on the existence of a watch on the parent dir of the log file.
> > Running ' inotifywait -m . &' will stop tail from getting notifications:
> >
> > echo > log
> > tail -f log &
> > sleep 1
> > echo "can you see this?" >> log
> > inotifywait -m . &
> > sleep 1
> > echo "how about this?" >> log
> > kill $(jobs -p)
> >
> > I suppose with a graphical screen you have systemd or other services
> > in the system watching the logs/home dir in your test env.
> >
> > Attached fix patch. I suppose Jan will want to sqhash it.
> >
> > We missed a subtle logic change in the switch from inode/child marks
> > to parent/inode marks terminology.
> >
> > Before the change (!inode_mark && child_mark) meant that name
> > was not NULL and should be discarded (which the old code did).
> > After the change (!parent_mark && inode_mark) is not enough to
> > determine if name should be discarded (it should be discarded only
> > for "events on child"), so another check is needed.
>
> Thanks for testing Hugh and for a quick fix Amir! I've folded it into the
> original buggy commit.
>

Test for original commit [1] extended to cover this bug as well:
Test #1: Group with child watches and other group with parent watch

Cheers,
Amir.

[1] https://github.com/amir73il/ltp/commits/fsnotify-fixes
