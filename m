Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6592DF663
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Dec 2020 19:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgLTSFf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Dec 2020 13:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgLTSFe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Dec 2020 13:05:34 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07267C061285;
        Sun, 20 Dec 2020 10:04:54 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id k8so6932192ilr.4;
        Sun, 20 Dec 2020 10:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ixmxmZhKoDf2RkElaFC29a/RIHw0EHzwr0FA0F3b/Q=;
        b=SD55zzlLMABsZSFBMtNkknr0u5piwTG/FfdjPMpQiignW1BsiWzBO2+1hsl5K2qTeW
         LWawWOfgwELRTvpYE0Ucu3WHv7ZUlRR94vCk05xAE1OmaktiIOi+lrKt7nutyXCcpM1B
         ApPsYjdk/RXcUqDNRcZJPt1LTVYvfe7rLRcViftkmwwezIPGwLmJQ35llb3x6+EUcbgA
         /Zf91c4Ezl9V7TWFn/X2yWD7cDOqwMqTsrTv5NsZREhlQo+97HG3Oay2wXVNd5ETRtak
         aZkTM3BE4qkOLGROSd4fglWFr66+8SRy4YQXjOCbYxScF3Sc3Te/MHshn4FNS0GBBE53
         e3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ixmxmZhKoDf2RkElaFC29a/RIHw0EHzwr0FA0F3b/Q=;
        b=pKAj4SbDcHgiRgbHF8ul+ihf6/8SglkRLmdQSBZxyMeqHrEAJ5A9+5+20Pb/jeswR/
         CabtjYTFyrS1ek/xL0htwgSskmYGxe5B+RdoKolN5iF6EfldyR3pF5H+CCxUkkxjskYR
         8lklGF4hc4/jeKyumUjzCtVwLogM0IRXsTfj+MOpKjgHFJ3HQ/327YNxCdghyzTGLQR9
         PRJlbg660kWxNPwWnx5/0zdOC21QAqnEtZcQX5yWxBu9xtqfgsOw+BnHtwFbJ+M7Mb3s
         z6Qcd3VGfdmeU9gF1bKOcafKqfm4eAFw9W9leQzTLyi8u8qoAppScvSGBbEb/IL7+Vxi
         0g9w==
X-Gm-Message-State: AOAM530rl0jjlEJWGsZkLeRs7A7S/cKz2i5jjxuswFj4XUPgG71xEKLN
        hZh75s6B7a++tmmWchxII88vdk+Lcq1lVEpt18g=
X-Google-Smtp-Source: ABdhPJwGvZR/rphd75wgiDyajttuLLbYs9pQGNwJiZi+1Y5RNalVgy4soAsJQg7OSj5gL9COKVktRads97+2Q/WSsD0=
X-Received: by 2002:a92:da82:: with SMTP id u2mr13421454iln.137.1608487493326;
 Sun, 20 Dec 2020 10:04:53 -0800 (PST)
MIME-Version: 1.0
References: <20201218221129.851003-1-shakeelb@google.com> <CAOQ4uxiyd=N-mvYWHFx6Yq1LW1BPcriZw++MAyOGB_4CDkDKYA@mail.gmail.com>
 <CALvZod6uT+bH7NqooEbqMLC6ppcbu-v=QDQRyTcfWGUsQodYjQ@mail.gmail.com>
 <CAOQ4uxh3vEBMs8afudFU3zxKLpcKG7KuWEGkLiH0hioncum1UA@mail.gmail.com>
 <CALvZod6fua_SQ=1+MX_R52w8PVbFafSHgjcmhXdaRWkZtfe+cg@mail.gmail.com>
 <CAOQ4uxhNw12XSb7dVbUAGh+LdDzpVaF=LozoPTuXOjL8DGXn4Q@mail.gmail.com> <CALvZod4jMF96Un_wM019pQxjJZemokrwed2PgPpXW9-EhhQnUw@mail.gmail.com>
In-Reply-To: <CALvZod4jMF96Un_wM019pQxjJZemokrwed2PgPpXW9-EhhQnUw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 20 Dec 2020 20:04:42 +0200
Message-ID: <CAOQ4uxiy9yHcdB9zgPapDJGYytXaWMXbMo7KELfbLiQwg1TrFw@mail.gmail.com>
Subject: Re: [PATCH] inotify, memcg: account inotify instances to kmemcg
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 20, 2020 at 7:56 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Sun, Dec 20, 2020 at 3:31 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Sun, Dec 20, 2020 at 6:24 AM Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > On Sat, Dec 19, 2020 at 8:25 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > > >
> > > > On Sat, Dec 19, 2020 at 4:31 PM Shakeel Butt <shakeelb@google.com> wrote:
> > > > >
> > > > > On Sat, Dec 19, 2020 at 1:48 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > > >
> > > > > > On Sat, Dec 19, 2020 at 12:11 AM Shakeel Butt <shakeelb@google.com> wrote:
> > > > > > >
> > > > > > > Currently the fs sysctl inotify/max_user_instances is used to limit the
> > > > > > > number of inotify instances on the system. For systems running multiple
> > > > > > > workloads, the per-user namespace sysctl max_inotify_instances can be
> > > > > > > used to further partition inotify instances. However there is no easy
> > > > > > > way to set a sensible system level max limit on inotify instances and
> > > > > > > further partition it between the workloads. It is much easier to charge
> > > > > > > the underlying resource (i.e. memory) behind the inotify instances to
> > > > > > > the memcg of the workload and let their memory limits limit the number
> > > > > > > of inotify instances they can create.
> > > > > >
> > > > > > Not that I have a problem with this patch, but what problem does it try to
> > > > > > solve?
> > > > >
> > > > > I am aiming for the simplicity to not set another limit which can
> > > > > indirectly be limited by memcg limits. I just want to set the memcg
> > > > > limit on our production environment which runs multiple workloads on a
> > > > > system and not think about setting a sensible value to
> > > > > max_user_instances in production. I would prefer to set
> > > > > max_user_instances to max int and let the memcg limits of the
> > > > > workloads limit their inotify usage.
> > > > >
> > > >
> > > > understood.
> > > > and I guess the multiple workloads cannot run each in their own userns?
> > > > because then you wouldn't need to change max_user_instances limit.
> > > >
> > >
> > > No workloads can run in their own user namespace but please note that
> > > max_user_instances is shared between all the user namespaces.
> >
> > /proc/sys/fs/inotify/max_user_instances is shared between all the user
> > namespaces, but it only controls the init_user_ns limits.
> > /proc/sys/user/max_inotify_instances is per user ns and it is the one that
> > actually controls the inotify limits in non init_user_ns.
> >
> > That said, I see that it is always initialized to MAX_INT on non init user ns,
> > which is exactly the setup that you are aiming at:
> >
> > $ unshare -U
> > $ cat /proc/sys/user/max_inotify_instances
> > 2147483647
> > $ cat /proc/sys/fs/inotify/max_user_instances
> > 128
>
> From what I understand, namespace-based limits are enforced
> hierarchically. More specifically in the example above, the
> application running in a user namespace with
> /proc/sys/user/max_inotify_instances = 2147483647 and
> /proc/sys/fs/inotify/max_user_instances = 128 will not be able to
> create more than 128 inotify instances. I actually tested this with a
> simple program which calls inotify_init() in a loop and it starts
> failing before the 128th iteration.

Right, it is.
Thanks for the clarification.

Thanks,
Amir.
