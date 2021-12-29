Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC213481098
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Dec 2021 08:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239074AbhL2HKp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Dec 2021 02:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbhL2HKp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Dec 2021 02:10:45 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6C1C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Dec 2021 23:10:44 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id e128so25125096iof.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Dec 2021 23:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rlp4VRFlaQvcrJiJtb5dxBlkL5CmHTyPBV26aYsqzUY=;
        b=pQ0hsHEXz7BsCG1xx48PjgeH58oyV42LOc1wgR+k3UiF5ji0AM3BzC3wjqhH0SrDCo
         2xxEwaMpwTnMbL7SYIdqDGXQRUxcICZpZxvklhsYoVVlwwDzZqCQOKwfIoorZQcE/sVR
         9cvV7MY8MT45savJS7bTYkB6x+dcKpuV2L5F5+3YYrYdIvE0ajIPiLTgW5qPz/rqX6ZO
         EFCs5qm8npT3vfx+Bw0eBeUV32y5fITZtDxxqkHy6dy0tRPZN9KWh+EfDDkdUd+LeM4z
         MizcUmAWpvfwI6aNXV6KtPsrRy+hPhxFNEqZJ8k3JMBpKjMoEw4grwGRElQSP5fEMdGB
         ucjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rlp4VRFlaQvcrJiJtb5dxBlkL5CmHTyPBV26aYsqzUY=;
        b=N/11DfcZE3EJDk8pqzZOXpwskuLj/aX1EDk1pBAhz7HsMt76iZukrHVQq0U8seMxKV
         GJiWB6n0824OyuXBKKUTTmatGX9JBzzwdF6YOnO2Ud+KvTuykbhzOsCzuWBB+wOkPSfs
         TcvnFzdSnmS1BjveIqpQ8FJozDQIjg9y6W3H7xjdtOr9vTrEkFkgybpoH3csCis2L3po
         xap2hoYziZNEmsnF9hFutLv6w1TO9Yiixpwax5JkWx0wc9MCbsDSbkbZLwkgGi8JZj2j
         OS15fQs5vxcqJBjj9TEQA3VAtQbjKivCv10ucWZsepKRlmc45BSp8nF1kGqYpceuXTis
         bHXQ==
X-Gm-Message-State: AOAM530Ctj4RMXR86IWaR2mt9yb1b8diOl7I+o/4RnFNQGqZHtLIzGft
        Y3YGjKHHVel7ahrM/0eM1XpnrqKtXy2Y8QYNG8Y=
X-Google-Smtp-Source: ABdhPJzbWnjF0q64HfeQu4ixJKDCWBKwuZ52bKSLV3Ug9sq9kKjBVv5txOQJhjz4KsbZhyQBs6Qdw7O+nkctZtZ14Nk=
X-Received: by 2002:a05:6602:29c2:: with SMTP id z2mr11092361ioq.196.1640761844239;
 Tue, 28 Dec 2021 23:10:44 -0800 (PST)
MIME-Version: 1.0
References: <SE1P216MB12869894048CCEDFCAECE9098F449@SE1P216MB1286.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <SE1P216MB12869894048CCEDFCAECE9098F449@SE1P216MB1286.KORP216.PROD.OUTLOOK.COM>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 29 Dec 2021 09:10:33 +0200
Message-ID: <CAOQ4uxjUt-x7Jgn+D6j4p6V2TyFEatvAe=sadK1svd8cRLShhQ@mail.gmail.com>
Subject: Re: Inquiries about how to ignore sub-events when using a designated
 directory as 'ignore mark'.
To:     =?UTF-8?B?6rmA7Zic7J24?= <hyein.kim@ahnlab.com>
Cc:     "jack@suse.cz" <jack@suse.cz>,
        "repnop@google.com" <repnop@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 29, 2021 at 6:39 AM =EA=B9=80=ED=98=9C=EC=9D=B8 <hyein.kim@ahnl=
ab.com> wrote:
>
>
> Hello.
>
> I'd like to ask you about 'fanotify', a 'monitoring file system events'.
>
> I am using the 'fanotify_init' option below, and I used "fanotify" in Ubu=
ntu OS, where many file events occur.
>

Which kernel version?

> But the 'sy' value of the top command is almost 100 and OS Hang has occur=
red.
>

That is probably due to inefficient event merging.
If you are going to use FAN_UNLIMITED_QUEUE and have a workload with
large event bursts
you are going to need kernel >=3D v5.13 with commit
  94e00d28a680 ("fsnotify: use hash table for faster events merge")

Or at least one of the stable kernels (e.g. >=3D v5.10.67) with backported =
commit
"fanotify: limit number of event merge attempts"

> So, I deleted the 'FAN_UNLIMITED_QUEUE' option and monitored it again, an=
d the OS was operating normally.
>
> fanotify_init(FAN_CLASS_CONTENT | FAN_CLOEXEC | FAN_NONBLOCK | FAN_UNLIMI=
TED_MARKS | FAN_UNLIMITED_QUEUE, O_CLOEXEC | O_RDONLY | O_LARGEFILE)
>

Just to be sure, are you using permission events?
Otherwise, why are you using the class FAN_CLASS_CONTENT?
Is it for priority?

Please specify the fanotify_mark() arguments you used for the filesystem ma=
rk.

>
> Exception processing was performed using the option below in 'fanotify_ma=
rk' to exclude monitoring targets,
> and even if the directory was exceptionally processed, all events in thos=
e sub-files were delivered.
>
> fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_IGNORED_MASK | FAN_MARK_IGNORED=
_SURV_MODIFY, FAN_CLOSE_WRITE | FAN_OPEN, AT_FDCWD, path)
>
>
> I would like to ask you if there is a way to ignore all sub-events when t=
he designated directory is 'ignore mark'.
>

If you want the ignored mask to apply to events on children of the
directory you should add
FAN_EVENT_ON_CHILD to the mask.

And make sure that you are running with kernel >=3D v5.8 with commit 2f02fd=
3fa13e
("fanotify: fix ignore mask logic for events on child and on dir")
There may have been some other fix commits after this one.

Thanks,
Amir.
