Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A78227D57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 12:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbgGUKnC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 06:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgGUKnC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:43:02 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C497C061794;
        Tue, 21 Jul 2020 03:43:02 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id p26so3823160oos.7;
        Tue, 21 Jul 2020 03:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=UNz5YDIjnc+/glRNuHqLP+jGMzFk6rM7f2h+4Pejht4=;
        b=Xby1dlCgO5JX0noqj11LnK4Oxsgm+3GSJtZ1+OzSg066w73HKhDIYFy3CNCKBe4eon
         Fdmk1II2o4vk6Mfh+hljvFu7nTOXSm5tBc++qxH/py9XogId+6ektuh0vCefXX9O4JFd
         tbGWrMILnn6GGvf7BaW1x8IZtK++ks+D85sSs0mt+w8f7WpV0pinvIzubvnDX/hqQcn2
         CPwn4S4X6yAMhg1jdYEcCAHQdWrj0Zo5Wgh2S9A/+CJmraowsbazpKMqD2Og+3S4CTii
         9JC5htBiy8Xkb7/8HsktWeWK73VS+LWeXNrIWvlw/aTvqb0MZSJRc2UmSItFJz+ADr7t
         5kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=UNz5YDIjnc+/glRNuHqLP+jGMzFk6rM7f2h+4Pejht4=;
        b=WYHvdOMMLAmomgFI8nwLlDwhLt0dhEJBz6dbJTQa7lPMWamVZpRV68XOQWztY8QA7I
         oGqOaFkSe8DIAl9dxmBf068STarYyCmc0QdfZkgVE4+JN8x23+hgJPe+7wP0wS8xNSJY
         5lCnuYMxKM368pHDl2QlvwmhWVWoFw5QsYsOcpC0OwpAv9BYksQsklyciLK+npKH3eFQ
         sWuWFFx9ddLo/Wz7sEsibaXDQF/fARZOCrJl6U14sf6tWG8XDik1NCZCBG4l0z7zD27J
         s57WNxmkM8hHCObZXuly1i7Osf/aDO3XnxzXTtgjiekJG+NM6wBh4J//jHKT4B0HQxic
         V8mw==
X-Gm-Message-State: AOAM532BIaWBV1YEiIrZFaNFM6CBQDAHyuRBcp0snJ6W1bx3sVU03xOO
        AIxie6UFaTOLw0lpATjzMYDShU/Z38Yt6WEr0C4=
X-Google-Smtp-Source: ABdhPJwhqkBe8my83KDOxmHPecoxD3Ck0cl0Tc48n+pLmU5s/77Gf1AvoY8UIftzZ6l+U+k1cb1DPwqN71FEf4GspBY=
X-Received: by 2002:a4a:ba8b:: with SMTP id d11mr23500215oop.80.1595328181243;
 Tue, 21 Jul 2020 03:43:01 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Tue, 21 Jul 2020 12:42:50 +0200
Message-ID: <CAKgNAkjyXcXZkEczRz2yvJRFBy2zAwTaNfyiSmskAFWN_3uY1g@mail.gmail.com>
Subject: Mount API manual pages
To:     David Howells <dhowells@redhat.com>
Cc:     Petr Vorel <pvorel@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello David,

In October last year you sent some draft manual pages[1] for the new
mount API (fsconfig(), fsmount(), fsopen(), fspick(), move_mount(),
open_tree()).

I noted at the time that the mails were a bit confusing since several
of the pages were sent twice, and to different lists. You said [2]
that you'd resend in a more orderly fashion following any feedback
that you got to those drafts. However, things stalled at that point.

I'd like to restart this process, so that we actually get the pages
into the man-pages set. (This is in part triggered by the
mount_settr() manual page that Christian recently sent.)

Would you be willing to do the following please:

1. Review the pages that you already wrote to see what needs to be
updated. (I did take a look at some of those pages a while back, and
some pieces--I don't recall the details--were out of sync with the
implementation.)

2. Resend the pages, one patch per page.

3. Please CC linux-man@, linux-api@, linux-kernel@, and the folk in CC
on this message.

Cheers,

Michael

[1]
https://lore.kernel.org/linux-man/15449.1531263162@warthog.procyon.org.uk/
[MANPAGE PATCH] Add manpages for move_mount(2) and open_tree(2)

https://lore.kernel.org/linux-man/15519.1531263314@warthog.procyon.org.uk/
[MANPAGE PATCH] Add manpage for fsinfo(2)

https://lore.kernel.org/linux-man/15488.1531263249@warthog.procyon.org.uk/
[MANPAGE PATCH] Add manpage for fsopen(2), fspick(2) and fsmount(2)

etc.

[2] https://lore.kernel.org/lkml/27446.1570738938@warthog.procyon.org.uk/
-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
