Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E75B7412BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 15:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjF1Nl3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 09:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjF1Nl2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:41:28 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74282129;
        Wed, 28 Jun 2023 06:41:27 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-440db8e60c8so1800445137.0;
        Wed, 28 Jun 2023 06:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687959686; x=1690551686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPaxtyuBCwLPaD8RSS8EaZb02FifsjqRTvpRb30GE3g=;
        b=MeeC6RLWsSHHMKVgYkYX5Lq5xXO530qEXgoVCmjTnZDhhtqQqxfvpry/S6KRJCYMGA
         NpHRteUA6IubdjUoHto6TVrdJ2ZBm0Bl2+moTjlGHKkGZqQzZMzhO7H27SJ11yMtwpK0
         Hp1506xYRo9SsYl3u7wTVSmvTzyjcNd6CeXgqC97J/eTsXk5qJ3P+BqT3YSn8FxSFVWe
         SPp4MR1Vq7uUoz6QjvNVr6jeOMU3j4rDB3ul/nZ6B72ACvdhJ6ecq/myYX4dtgqQ1O4s
         QIXHdHRR0a4LO8cLJe9MKPCRqSY5Fg1wLXzHLRxxF6Sht8Vy0yLUpgZQ547ZjLE8ynRx
         TQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687959686; x=1690551686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPaxtyuBCwLPaD8RSS8EaZb02FifsjqRTvpRb30GE3g=;
        b=giKXdLRajMKvcABJyOCoYrEYwHIitFXb0exjnzwpqj7RwcUT8g3YrAUTsr11VZVit3
         RSIqb7+TJkChE4t8gkaLG67b8nCHXXJOJ8pPbNBOLRiXiKnEn4AFl4qUfUdfeor0TtxR
         i9fI5FLJ1+h/synjKUmZ5oeDhuYspjsfWY6lTlDxba6C/hwew/fXwDAAiQEY9NfGCL84
         H/rxGuY7oLsNIiJ1i2v+j5lr5HCyToh7kT7d3Dmza0SSuduv3mdhjzOd2zq9ARofgdou
         qKhwH2q782pQkPNLFvEpHw3jRPA1nJpcW6MfIKEv01K/1cQwPWNHVypG9/fMyqJAxA95
         0rEw==
X-Gm-Message-State: AC+VfDwCjYpgW8q8IgP8DLn4xWwJdWzGtivSm+XHX8tr04hgoRrIqccr
        D+HZEwNmAhlCwXqrT6Y3yl0wsLtDojzD/Z7vgYI=
X-Google-Smtp-Source: ACHHUZ5Lg9ZKuMYnhSqkSRu8lw7tcb/Q7Xk8kxyHjxhE0dtI1K7l83efi2hrJEz2uoI/7v3W+Y+mxpkO3EdHcrzbpaE=
X-Received: by 2002:a67:f711:0:b0:443:9248:3410 with SMTP id
 m17-20020a67f711000000b0044392483410mr484425vso.32.1687959686332; Wed, 28 Jun
 2023 06:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <t5az5bvpfqd3rrwla43437r5vplmkujdytixcxgm7sc4hojspg@jcc63stk66hz>
 <cover.1687898895.git.nabijaczleweli@nabijaczleweli.xyz> <20230628113853.2b67fic5nvlisx3r@quack3>
In-Reply-To: <20230628113853.2b67fic5nvlisx3r@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 28 Jun 2023 16:41:14 +0300
Message-ID: <CAOQ4uxhcZY1XSZ74wUuy=3tqfEW0vbOuwghc4ZoQt=FZ+Lw4-A@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] fanotify accounting for fs/splice.c
To:     Jan Kara <jack@suse.cz>
Cc:     =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chung-Chiang Cheng <cccheng@synology.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 2:38=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> Hello!
>
> On Tue 27-06-23 22:50:46, Ahelenia Ziemia=C5=84ska wrote:
> > Always generate modify out, access in for splice;
> > this gets automatically merged with no ugly special cases.
> >
> > No changes to 2/3 or 3/3.
>
> Thanks for the patches Ahelena! The code looks fine to me but to be hones=
t
> I still have one unresolved question so let me think about it loud here f=
or
> documentation purposes :). Do we want fsnotify (any filesystem
> notification framework like inotify or fanotify) to actually generate
> events on FIFOs? FIFOs are virtual objects and are not part of the
> filesystem as such (well, the inode itself and the name is), hence
> *filesystem* notification framework does not seem like a great fit to wat=
ch
> for changes or accesses there. And if we say "yes" for FIFOs, then why no=
t
> AF_UNIX sockets? Where do we draw the line? And is it all worth the
> trouble?
>
> I understand the convenience of inotify working on FIFOs for the "tail -f=
"
> usecase but then wouldn't this better be fixed in tail(1) itself by using
> epoll(7) for FIFOs which, as I've noted in my other reply, does not have
> the problem that poll(2) has when there are no writers?
>
> Another issue with FIFOs is that they do not have a concept of file
> position. For hierarchical storage usecase we are introducing events that
> will report file ranges being modified / accessed and officially supporti=
ng
> FIFOs is one more special case to deal with.
>
> What is supporting your changes is that fsnotify mostly works for FIFOs
> already now (normal reads & writes generate notification) so splice not
> working could be viewed as an inconsistency. Sockets (although they are
> visible in the filesystem) cannot be open so for them the illusion of bei=
ng
> a file is even weaker.
>
> So overall I guess I'm slightly in favor of making fsnotify generate even=
ts
> on FIFOs even with splice, provided Amir does not see a big trouble in
> supporting this with his upcoming HSM changes.
>

I've also thought about this.

The thing about the HSM events is that they are permission events
and just like FAN_ACCESS_PERM, they originate from the common
access control helpers {rw,remap}_verify_area(), which also happen
to have the file range info (with ppos NULL for pipes).

Ahelenia's patches do not add any new rw_verify_area() to pipes
so no new FAN_ACCESS_PERM events were added.

If we could go back to the design of fanotify we would have probably
made it explicit that permission events are only allowed on regular
files and dirs. For the new HSM events we can (and will) do that.

In any case, the new events are supposed to be delivered with
file access range records, so delivering HSM events on pipes
wouldn't make any sense.

So I do not see any problem with these patches wrt upcomping
HSM events.

However, note that these patches create more inconsistencies
between IN_ACCESS and FAN_ACCESS_PERM on pipes.

We can leave it at that if we want, but fixing the inconsistencies
by adding more FAN_ACCESS_PERM events on pipes - this
is not something that I wouldn't be comfortable with.

If anything, we can remove FAN_ACCESS_PERM events from
special files and see if anybody complains.

I don't know of any users of FAN_ACCESS_PERM and even for
FAN_OPEN_PERM, I don't think that AV-vendors have anything
useful to do with open permission events on special files.

Thanks,
Amir.
