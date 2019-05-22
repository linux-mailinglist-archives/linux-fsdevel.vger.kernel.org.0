Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3634326FF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 22:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbfEVUAh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 16:00:37 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:45481 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730417AbfEVUAg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 16:00:36 -0400
Received: by mail-yb1-f194.google.com with SMTP id e128so1331355ybc.12;
        Wed, 22 May 2019 13:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C0nqHgtmLn6G5z3RJOs6vtscGJVqhj3bMBlmrel04/w=;
        b=UwrWn/u8rZGHhLI1P6V35RgRkAPjVS/PxkAM7CyXBT57jgKfWPjOpICtY0LSDJ69R5
         BR1pjI85gspBLojZnrGuHIoT7C1QYhMFQ8AzeX5PQxmtBJwl53tIIfhleT7WoP6SGPW3
         jPdv59bh5Sa2ThqPAQ4OBK6GDwS6g8LbujSzQM3Tuw0ktnD94bnRHaBYgMKwC2kKWQQ6
         5kzL/+N3o/Ng1GSLrlzTGO3gpwnvWtcdyUy9AFrcbALi0/YbADrfxNK2CgiEaggfncgI
         tXzBRPf8wMX+N0XQhCjZ8BSZ0iVGeiFVdqV5bElUz8JFoV2ZwwYG9j8045SyZEvu8bbm
         X2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C0nqHgtmLn6G5z3RJOs6vtscGJVqhj3bMBlmrel04/w=;
        b=OS6lK7/kXFyxq3Ltpi1R3wYqOD8HRQGktQYRmsLpm8PK5veUAP+7c6kgqgTq5iFzX/
         EQA8/B1XAlHUX359aLo5JSZ4xe++Jc1Vsizj6XiHHSTmrCLy35PdnfFOYaP7fMTIlvKG
         RU7ntNsgLyxx0JNOhw3gUpuFbqoiqJneOmMyQ8jil5QyQkacdkuczX+XgI7AJd0dxo7j
         J3PWhgevfmzZbmOUG0h5rQC+58UiFxLa11BfbPUW+lZ56q8HBmtzeRAz03vQTEVGHtUE
         MGbhlYTuWynjRkX6xC+7BaK5FlWEZK1jKK4MJ0cnJrj6om2hWfA+ZziNvAwrjnDNe/C5
         Ji5A==
X-Gm-Message-State: APjAAAUd8LYFYKlq/vy8TuSVKMja1eyo/RIbje4Ancdvu5wrmeoSTfVh
        WtbG84EWh8hl/V0D2zd6elwMVnFETXjHfcplciRaehUE
X-Google-Smtp-Source: APXvYqwdAn8/163JIv01+5q5jhQOxY8oXTq/RXsrw1M8Va4VH8MacySFCdZpVj8OETAqO7j5G2cNQQLwLLLgipcKhts=
X-Received: by 2002:a25:7a41:: with SMTP id v62mr19992787ybc.14.1558555235261;
 Wed, 22 May 2019 13:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190522163150.16849-1-christian@brauner.io> <CAOQ4uxjV=7=FXuyccBK9Pu1B7o-w-pbc1FQXJxY4q6z8E93KOg@mail.gmail.com>
 <EB97EF04-D44F-4320-ACDC-C536EED03BA4@brauner.io>
In-Reply-To: <EB97EF04-D44F-4320-ACDC-C536EED03BA4@brauner.io>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 22 May 2019 23:00:22 +0300
Message-ID: <CAOQ4uxhodqVw0DVfcvXYH5vBf4LKcv7t388ZwXeZPBTcEMzGSw@mail.gmail.com>
Subject: Re: [PATCH] fanotify: remove redundant capable(CAP_SYS_ADMIN)s
To:     Christian Brauner <christian@brauner.io>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 22, 2019 at 9:57 PM Christian Brauner <christian@brauner.io> wrote:
>
> On May 22, 2019 8:29:37 PM GMT+02:00, Amir Goldstein <amir73il@gmail.com> wrote:
> >On Wed, May 22, 2019 at 7:32 PM Christian Brauner
> ><christian@brauner.io> wrote:
> >>
> >> This removes two redundant capable(CAP_SYS_ADMIN) checks from
> >> fanotify_init().
> >> fanotify_init() guards the whole syscall with capable(CAP_SYS_ADMIN)
> >at the
> >> beginning. So the other two capable(CAP_SYS_ADMIN) checks are not
> >needed.
> >
> >It's intentional:
> >
> >commit e7099d8a5a34d2876908a9fab4952dabdcfc5909
> >Author: Eric Paris <eparis@redhat.com>
> >Date:   Thu Oct 28 17:21:57 2010 -0400
> >
> >    fanotify: limit the number of marks in a single fanotify group
> >
> >There is currently no limit on the number of marks a given fanotify
> >group
> >can have.  Since fanotify is gated on CAP_SYS_ADMIN this was not seen
> >as
> >a serious DoS threat.  This patch implements a default of 8192, the
> >same as
> >inotify to work towards removing the CAP_SYS_ADMIN gating and
> >eliminating
> >    the default DoS'able status.
> >
> >    Signed-off-by: Eric Paris <eparis@redhat.com>
> >
> >There idea is to eventually remove the gated CAP_SYS_ADMIN.
> >There is no reason that fanotify could not be used by unprivileged
> >users
> >to setup inotify style watch on an inode or directories children, see:
> >https://patchwork.kernel.org/patch/10668299/
> >
> >>
> >> Fixes: 5dd03f55fd2 ("fanotify: allow userspace to override max queue
> >depth")
> >> Fixes: ac7e22dcfaf ("fanotify: allow userspace to override max
> >marks")
> >
> >Fixes is used to tag bug fixes for stable.
> >There is no bug.
> >
> >Thanks,
> >Amir.
>
> Interesting. When do you think the gate can be removed?

Nobody is working on this AFAIK.
What I posted was a simple POC, but I have no use case for this.
In the patchwork link above, Jan has listed the prerequisites for
removing the gate.

One of the prerequisites is FAN_REPORT_FID, which is now merged.
When events gets reported with fid instead of fd, unprivileged user
(hopefully) cannot use fid for privilege escalation.

> I was looking into switching from inotify to fanotify but since it's not usable from
> non-initial userns it's a no-no
> since we support nested workloads.

One of Jan's questions was what is the benefit of using inotify-compatible
fanotify vs. using inotify.
So what was the reason you were looking into switching from inotify to fanotify?
Is it because of mount/filesystem watch? Because making those available for
unprivileged user sounds risky...

Thanks,
Amir.
