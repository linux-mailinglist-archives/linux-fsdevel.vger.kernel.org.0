Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63F15155F00
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 21:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgBGUCV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 15:02:21 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38905 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgBGUCV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 15:02:21 -0500
Received: by mail-io1-f68.google.com with SMTP id s24so855551iog.5;
        Fri, 07 Feb 2020 12:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ObGffXOL5VBl+6FfHz5jFepyN+90co8pbuYkAV1+kJE=;
        b=PdrH595HtGa9FPdkP6FveQWORDzceL3dqn7chKwjW7CJ+op5ZGt5wOH40lbbNI+WCk
         jpHd1/lUpWA+gaCwXp6RVAM+Y1eokJg7ew/FJHA0E3xFM6zPlcCc0aSxaFlmhVC19UCz
         ZMnUSaa0LKX3n24qqEuOkvjz65meJHzemH5KKw0WbS2XskToFwkY5Ufx0FUPdIuWDBv0
         J2VHzWy9suqL0WnHQWHh4h71LFUUIT0XzDePf88IFmKqWXayoI3mwA7iw5UthFBTgJ0a
         mRUdvGhHAlvZHLzrZ2eQocbWC6gCXWb3nUc4UoqdnqVGrG4vxOZBUGLrPSZ4FGf45gMX
         9okg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ObGffXOL5VBl+6FfHz5jFepyN+90co8pbuYkAV1+kJE=;
        b=CbTVxlY2LHCIomUyOn2wIUT0QU/FKm3iKQAwDm+mGCesmzFdmlZy8xBhBPc7mcUeqh
         idO1Z7+Loa12gXZXFeImZHo/9tdA4vJ4Vr3c34uwE1e/fl9F1h7sFmmXt8SDl1QxSZLi
         05LOIMIg9fp6NcdMmESEaH02rQyjS/KCHP0lIwDyUHIbNBWuoi1muJhVjf89/7Fkq6Xk
         svlTdhf+hXXrv8zzLf5kBAc6pbvkUly+Qm9hDyVQriBSybUW6qGM5gANpt02sYj6K/r0
         cgb/XVCFs9pZXrD0NfJvoKDjPpFuFiXIxvTef1y0JHRkAJ85hFLlsmvKA9rHchg+5fw7
         d+GQ==
X-Gm-Message-State: APjAAAX+Oy6j6cvH4XrTJV01Jr7O1V8iSRZfgb00nkElsd1EqEvkCnCz
        wRL65tzm8YBXuchGfp4BcdMGb9PlO+y6c2dGtTk=
X-Google-Smtp-Source: APXvYqzr9EKMP9gEcMKsqVij2k0eQYE1W3W48hKowb/xTOZi90SWhlNjvEDfr1GsLUtEJl0v4PiyYDyNQyO8E9KAEko=
X-Received: by 2002:a5d:8956:: with SMTP id b22mr102017iot.263.1581105740222;
 Fri, 07 Feb 2020 12:02:20 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ad5:5442:0:0:0:0:0 with HTTP; Fri, 7 Feb 2020 12:02:19 -0800 (PST)
In-Reply-To: <CAK8P3a2n6qttV0hhMHjb7XngA6-Aj4Q9Q_6LdK7LgyoYSvQJSw@mail.gmail.com>
References: <20191217221708.3730997-21-arnd@arndb.de> <20200207072210.10134-1-youling257@gmail.com>
 <CAK8P3a2n6qttV0hhMHjb7XngA6-Aj4Q9Q_6LdK7LgyoYSvQJSw@mail.gmail.com>
From:   youling 257 <youling257@gmail.com>
Date:   Sat, 8 Feb 2020 04:02:19 +0800
Message-ID: <CAOzgRdZGLoWyjXdw+BHmfqJBzfskwC+4ANTxTdaS2wmRoNgPpA@mail.gmail.com>
Subject: Re: [PATCH v2 20/27] compat_ioctl: simplify the implementation
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Test [PATCH] compat_ioctl: fix FIONREAD on devices, fixed my problem.

2020-02-08 1:06 GMT+08:00, Arnd Bergmann <arnd@arndb.de>:
> On Fri, Feb 7, 2020 at 8:22 AM youling257 <youling257@gmail.com> wrote:
>>
>> This patch cause a problem on 64bit kernel 32bit userspace.
>> My 32bit Androidx86 userspace run on 64bit mainline kernel, this patch
>> caused some app not detect root permission.
>
> Thanks for you work in bisecting the issue to my patch, sorry to have
> caused you trouble. After Christian Zigotzky
> also reported a problem in this file, I have been able to find a
> specific bug and just submitted a patch for it.
>
> Please have a look if that fix addresses your problem, as it's
> possible that there was more than one bug introduced
> by the original patch.
>
>        Arnd
>
