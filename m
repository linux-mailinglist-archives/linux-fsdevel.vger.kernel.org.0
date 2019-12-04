Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78849112C17
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 13:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfLDMxp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 07:53:45 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:36194 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfLDMxp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 07:53:45 -0500
Received: by mail-yw1-f68.google.com with SMTP id u133so2735033ywb.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2019 04:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wq/65GMqEQlHJ0DzxQb6kgHs103/vL/Arf8O+0eOh5k=;
        b=GcRAbZH68Wpwwk2+m1PtERhJ/aYq5LuOxqBCOoWR+8/aytRXSwHVtTPpOCFID8LsWt
         rWwJQkBZIaCgJHyqx4EzJKSdhd1uxVqIkPtS0ufeCw/Qsw60E5vrJyPx2plV6PWerSfo
         PkOSkjxOzySXdYpQZlGrxdrmUF+pYq83yEG4PzpjXIi4SB7ZhKwpcKsToKCUOUUFyL4Y
         oMcaWAw98/oZhy2EN3Le8VZHv2pQic0Q/RHnltwunSN0ide+rSyIjI4DfTWc5FW8lgry
         R8ye/uQGK806uShmYAGlvEvMUf9w5l7NyDWU+U5o1Q3tHen//y1D43iaIZ3YQq+diYh4
         +Z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wq/65GMqEQlHJ0DzxQb6kgHs103/vL/Arf8O+0eOh5k=;
        b=NZ1JhUCQCwbRKVDB2Ou8QnxTeu6cIkrsCwfSZBFHR5bwaYrzLetmcPwUSOe9RU8QKx
         Re5HdIjcplLSwjSYyd/Cn5KJNZRA7qRTHSU7AnmFbv7iBrtH4KDbkN6h171wILQk+pf8
         tsmlk+DR9IT/Ct6mnhmM746V2eZQdzjS4uCx6CEorIa39k6RKdmA3JFfKxaN7xuSRcxI
         356dAhUHP7bSGxmGau5/TegV4QZDnlil7AqLi9JiJiPykeFWuMBB/Pfpfj0SIRL2abW7
         Hq+sqWb7wFFLLnX8rxap4LWPNZsjW3ZRrQwsB19k+PCBQzsoH77hXR3ng115mjkmGclv
         adkg==
X-Gm-Message-State: APjAAAU3rLKmLGfzEtu+haOIW0twQoqCIhOZlSlcx/FYfjs9KT8dtoPR
        2u+rkoIucgr6imK4RlYaNIFDnfKZhUJtnOb1noFLllBD
X-Google-Smtp-Source: APXvYqwys756uaZw9gH/TGwWq588d+soheBXapcpcpLq/S4uMCutKfh2Bp3cn+rK3c1S3vknxI6IpqrbKwHPWuE7M9U=
X-Received: by 2002:a81:1cd5:: with SMTP id c204mr1768379ywc.379.1575464024182;
 Wed, 04 Dec 2019 04:53:44 -0800 (PST)
MIME-Version: 1.0
References: <CADKPpc2RuncyN+ZONkwBqtW7iBb5ep_3yQN7PKe7ASn8DpNvBw@mail.gmail.com>
In-Reply-To: <CADKPpc2RuncyN+ZONkwBqtW7iBb5ep_3yQN7PKe7ASn8DpNvBw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 4 Dec 2019 14:53:33 +0200
Message-ID: <CAOQ4uxiKqEq9ts4fEq_husQJpus29afVBMq8P1tkeQT-58RBFg@mail.gmail.com>
Subject: Re: File monitor problem
To:     Mo Re Ra <more7.rev@gmail.com>, Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 4, 2019 at 12:03 PM Mo Re Ra <more7.rev@gmail.com> wrote:
>
> Hi,
>
> I don`t know if this is the correct place to express my issue or not.
> I have a big problem. For my project, a Directory Monitor, I`ve
> researched about dnotify, inotify and fanotify.
> dnotify is the worst choice.
> inotify is a good choice but has a problem. It does not work
> recursively. When you implement this feature by inotify, you would
> miss immediately events after subdir creation.
> fanotify is the last choice. It has a big change since Kernel 5.1. But
> It does not meet my requirement.
>
> I need to monitor a directory with CREATE, DELETE, MOVE_TO, MOVE_FROM
> and CLOSE_WRITE events would be happened in its subdirectories.
> Filename of the events happened on that (without any miss) is
> mandatory for me.
>
> I`ve searched and found a contribution from @amiril73 which
> unfortunately has not been merged. Here is the link:
> https://github.com/amir73il/fsnotify-utils/issues/1
>
> I`d really appreciate it If you could resolve this issue.
>

Hi Mohammad,

Thanks for taking an interest in fanotify.

Can you please elaborate about why filename in events are mandatory
for your application.

Could your application use the FID in FAN_DELETE_SELF and
FAN_MOVE_SELF events to act on file deletion/rename instead of filename
information in FAN_DELETE/FAN_MOVED_xxx events?

Will it help if you could get a FAN_CREATE_SELF event with FID information
of created file?

Note that it is NOT guarantied that your application will be able to resolve
those FID to file path, for example if file was already deleted and no open
handles for this file exist or if file has a hardlink, you may resolve the path
of that hardlink instead.

Jan,

I remember we discussed the optional FAN_REPORT_FILENAME [1] and
you had some reservations, but I am not sure how strong they were.
Please refresh my memory.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commit/d3e2fec74f6814cecb91148e6b9984a56132590f
