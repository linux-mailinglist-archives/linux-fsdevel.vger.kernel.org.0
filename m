Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CC3344EAB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 19:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhCVSjL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 14:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhCVSip (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:38:45 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E1BC061574;
        Mon, 22 Mar 2021 11:38:44 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id x16so15018550iob.1;
        Mon, 22 Mar 2021 11:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oAP81Pb5bkRA0MthMgfGZDu3/DG1NZ2ofYB/Ig4dLak=;
        b=lAgYe9RRPq3q5wGGQpx57/cfcs08SPWyZXwLKFI8IxZCz/2zQ46THQ/zdTRWMy4ovf
         SdrePf2M4I2/pK+yCJYyOE60C2766kSIeOLuyKxVIsL3rwplZkBfyQxh4gIXasIHBWxr
         M0FjZWxltnaMZneNiDp/F4TgrJPM6zdTpTgh4Dd/bWU24qbCorurkzzNisW1UKKBc7bl
         VY0qB+w62K0TWee294toyARq2RuntBPqxD8xk0EuCdkv2SZcBkn9WmeCBipbTLOKbDTU
         Ur4datwdqnuz+Crzd1NMUB2DmmsYxja3SzWnVkzO5zL+3Z9B7QlxAriICCRjTbLgP0WK
         id6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oAP81Pb5bkRA0MthMgfGZDu3/DG1NZ2ofYB/Ig4dLak=;
        b=jvDcPfsCVw7TjuLaJMPELe5QyrUyyjMvJEi4PrETKtHKAux6g3dzCCnzv2aoYnQbLb
         sG/TuY5WRjJgNEdwSvZ/cuY4Pm0eD6ZXwaATQcWaBs0+i+HmZrtqRP3V1amdiMlIH4Rz
         90oW34v3C+DTlYj/80e1jfR3XxZY8mI3/PkmJ1GhXfmzMki3Q+FVt/G4eMblyByWjfYG
         f8/e1+oO/jiymdHstaStgYvsYgeMj+6/EdMSl17jL77hmspHorQ1MIxMHqwXdV4FZOIt
         o3PFHTijt7+edWaQxdAsj2m3rmJojoCrU1WSWP/3YtXNH8e2kB0CtrVr8hyTcMKm7kIM
         ZP3Q==
X-Gm-Message-State: AOAM532D7QQwN/66WcD0BH/4S6EBXpZ9mcdeMNv29AOV/7AxevzfH7cb
        1fiC7wXdyhMAnjB8hlrQ7MOUg52rJcBRdyAkM/bRxNK470M=
X-Google-Smtp-Source: ABdhPJweFlIZgIJn8op6xTbJ1UPAJiVgocjYmKnecXqIsrJL1T/Mxq2YKHse6FFyN+jyq1owK9wam7mS8QnfaamxWv8=
X-Received: by 2002:a5e:8e41:: with SMTP id r1mr930689ioo.5.1616438324093;
 Mon, 22 Mar 2021 11:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210304112921.3996419-1-amir73il@gmail.com> <20210316155524.GD23532@quack2.suse.cz>
 <CAOQ4uxgCv42_xkKpRH-ApMOeFCWfQGGc11CKxUkHJq-Xf=HnYg@mail.gmail.com>
 <20210317114207.GB2541@quack2.suse.cz> <CAOQ4uxi7ZXJW3_6SN=vw_XJC+wy4eMTayN6X5yRy_HOV6323MA@mail.gmail.com>
 <20210318154413.GA21462@quack2.suse.cz> <CAOQ4uxhpB+1iFSSoZy2NuF2diL=8uJ-j8JJVNnujqtphW147cw@mail.gmail.com>
In-Reply-To: <CAOQ4uxhpB+1iFSSoZy2NuF2diL=8uJ-j8JJVNnujqtphW147cw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 22 Mar 2021 20:38:32 +0200
Message-ID: <CAOQ4uxj4OC5cSwJMizBG=bmarxMwSVfqYnds4wYabieEDM_+eQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] unprivileged fanotify listener
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > The problem here is that even if unprivileged users cannot compromise
> > > security, they can still cause significant CPU overhead either queueing
> > > events or filtering events and that is something I haven't been able to
> > > figure out a way to escape from.
> >
> > WRT queueing overhead, given a user can place ~1M of directory watches, he
> > can cause noticable total overhead for queueing events anyway. Furthermore
>
> I suppose so. But a user placing 1M dir watches at least adds this overhead
> knowingly. Adding a overhead on the entire filesystem when just wanting to
> watch a small subtree doesn't sound ideal. Especially in very nested setups.
> So yes, we need to be careful.
>

I was thinking about this some more and I think the answer is in your example.
User can only place 1M dir watches if ucount marks limits permits it.

So whatever we allow to do with subtree or userns filtered marks should
also be limited by ucounts.

> > the queue size is limited so unless the user spends time consuming events
> > as well, the load won't last long. But I agree we need to be careful not to
> > introduce too big latencies to operations generating events. So I think if
> > we could quickly detect whether a generated event has a good chance of
> > being relevant for some subtree watch of a group and queue it in that case
> > and worry about permission checks only once events are received and thus
> > receiver pays the cost of expensive checks, that might be fine as well.
> >
>
> So far the only idea I had for "quickly detect" which I cannot find flaws in
> is to filter by mnt_userms, but its power is limited.
>

So I have implemented this idea on fanotify_userns branch and the cost
per "filtered" sb mark is quite low - its a pretty cheap check in
send_to_group()
But still, if an unbound number of users can add to the sb mark list it is
not going to end well.

<hand waving>
I think what we need here (thinking out loud) is to account the sb marks
to the user that mounted the filesystem or to the user mapped to admin using
idmapped mount, maybe to both(?), probably using a separate ucount entry
(e.g. max_fanotify_filesystem_marks).

We can set this limit by default to a small number (128?) to limit the sb list
iteration per filesystem event and container manager / systemd can further
limit this resource when creating idmapped mounts, which would otherwise
allow the mapped user to add "filtered" (*) sb marks.
</hand waving>

Thanks,
Amir.

(*) "filtered" can refer to both the userns filter I proposed and going forward
     also maybe to subtree filter
