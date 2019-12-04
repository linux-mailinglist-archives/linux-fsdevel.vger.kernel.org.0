Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC07112D65
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 15:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfLDOZC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 09:25:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44182 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfLDOZC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 09:25:02 -0500
Received: by mail-wr1-f67.google.com with SMTP id q10so8774591wrm.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2019 06:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dCNInubYDqlO66XRYe9hy1rNnkQmFtQqKTbaoNinUSM=;
        b=Jk0OaY9M/rXWxlouQPDgbsvnok6FQUbEafumGHLiT9nbTWvK3exykqs7u01BcZyzJG
         qn1yCbwPlNHeTAeI0f9NMZBhkaMNuSQ42K+nqNR76UdBQ9R+zKSrGlvTsr35bR0O5CT1
         SUtNTCKh7jxskGOgdYd0NaYHE6eMLxaQAUBdTtyA2Mwpb4BJVUuiYa6bqtbFeQolZeKm
         biqP+CPmzzIxx9ZkJs1zxObIsrHhdy49lSRbIkvUDrA9TqwUI1YEeMfM20BUdKNgusR/
         1oz/iYGiCOSGuHTj01fKGlZLukF8INIvKFcn0PjUYvkIeMMMnLPJg7aoBmRsPKk5RurI
         jEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dCNInubYDqlO66XRYe9hy1rNnkQmFtQqKTbaoNinUSM=;
        b=ucb6s2k25zn84EesjyK/Gw+0vO+saBYdPqEnz+iSyqGnZPKFOIVcA+iKPcT/Ooqynm
         JGOQVZM4ug0+uNJrzbjwwYM3Kn5Yclg4k5/zO9UaipUPxPZ7yxbx2RMR3ptBTe37lEw8
         yY/ZnoVI4ItUqSY2zbffuNM8rJ28GzBZxh9hSbHhJb5ol6Qayp1OJfon5qM0JI2FGjoA
         0QY1mcPSgmVQUdeLsPSK50CNDvnZ1VG8ixmStM4H7bnwbuEe305GjPx2nOe2d6PwVSk/
         2fNFQiPMKecJNkYc5soKOR/HRr3Q2Ae5elGvNggrUlgog+lyzPKkSeHNm3jIgl5U0A+F
         82Iw==
X-Gm-Message-State: APjAAAXS3aIfxNkuyK1NXHnjbQjmbWLDqKhAFrvh3g2a81kWT/Bh+WIR
        jYgv4LloFQ4rtBvHzPKGbt2Y3eECNXky9Julm1s=
X-Google-Smtp-Source: APXvYqwU223ebSWrYZG2E7uTcpjodM6s2VwLj9s5DtEO2xNjHI6UF0pgW0PvIN2GsHlRVlapZQqNHKtUdnyI3vOEhNU=
X-Received: by 2002:a5d:5091:: with SMTP id a17mr4265512wrt.362.1575469499998;
 Wed, 04 Dec 2019 06:24:59 -0800 (PST)
MIME-Version: 1.0
References: <CADKPpc2RuncyN+ZONkwBqtW7iBb5ep_3yQN7PKe7ASn8DpNvBw@mail.gmail.com>
 <CAOQ4uxiKqEq9ts4fEq_husQJpus29afVBMq8P1tkeQT-58RBFg@mail.gmail.com>
In-Reply-To: <CAOQ4uxiKqEq9ts4fEq_husQJpus29afVBMq8P1tkeQT-58RBFg@mail.gmail.com>
From:   Mo Re Ra <more7.rev@gmail.com>
Date:   Wed, 4 Dec 2019 17:54:48 +0330
Message-ID: <CADKPpc33UGcuRB9p64QoF8g88emqNQB=Z03f+OnK4MiCoeVZpg@mail.gmail.com>
Subject: Re: File monitor problem
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 4, 2019 at 4:23 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Wed, Dec 4, 2019 at 12:03 PM Mo Re Ra <more7.rev@gmail.com> wrote:
> >
> > Hi,
> >
> > I don`t know if this is the correct place to express my issue or not.
> > I have a big problem. For my project, a Directory Monitor, I`ve
> > researched about dnotify, inotify and fanotify.
> > dnotify is the worst choice.
> > inotify is a good choice but has a problem. It does not work
> > recursively. When you implement this feature by inotify, you would
> > miss immediately events after subdir creation.
> > fanotify is the last choice. It has a big change since Kernel 5.1. But
> > It does not meet my requirement.
> >
> > I need to monitor a directory with CREATE, DELETE, MOVE_TO, MOVE_FROM
> > and CLOSE_WRITE events would be happened in its subdirectories.
> > Filename of the events happened on that (without any miss) is
> > mandatory for me.
> >
> > I`ve searched and found a contribution from @amiril73 which
> > unfortunately has not been merged. Here is the link:
> > https://github.com/amir73il/fsnotify-utils/issues/1
> >
> > I`d really appreciate it If you could resolve this issue.
> >
>
> Hi Mohammad,
>
> Thanks for taking an interest in fanotify.
>
> Can you please elaborate about why filename in events are mandatory
> for your application.
>
> Could your application use the FID in FAN_DELETE_SELF and
> FAN_MOVE_SELF events to act on file deletion/rename instead of filename
> information in FAN_DELETE/FAN_MOVED_xxx events?
>
> Will it help if you could get a FAN_CREATE_SELF event with FID information
> of created file?
>
> Note that it is NOT guarantied that your application will be able to resolve
> those FID to file path, for example if file was already deleted and no open
> handles for this file exist or if file has a hardlink, you may resolve the path
> of that hardlink instead.
>
> Jan,
>
> I remember we discussed the optional FAN_REPORT_FILENAME [1] and
> you had some reservations, but I am not sure how strong they were.
> Please refresh my memory.
>
> Thanks,
> Amir.
>
> [1] https://github.com/amir73il/linux/commit/d3e2fec74f6814cecb91148e6b9984a56132590f



Hi Amir,
Thanks for your attention.

Fanotify project had a big change since Kernel 5.1 but did not meet
some primiry needs.
For example in my application, I`m watching on a specific directory to
sync it (through a socket connection and considering some policies)
with a directory in a remote system which a user working on that. Some
subdirectoires may contain two milions of files or more. I need these
two directoires be synced completely as soon as possible without any
missed notification.
So, I need a syscall with complete set of flags to help to watch on a
directory and all of its subdirectories recuresively without any
missed notification.

Unfortuantely, in current version of Fanotify, the notification just
expresses a change has been occured in a directory but dot not
specifiy which file! I could not iterate over millions of file to
determine which file was that. That would not be helpful.

Inevitably, xxx_SELF would not help me to meets all I need. Just to
clarify, I dont mean xxx_SELF flags are useless. I mean Fanotify is a
good project but the current version of that is not a project which
meets some basic needs.

Thanks,
Mohammad Reza.
