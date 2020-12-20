Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A002DF386
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Dec 2020 05:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgLTEZb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Dec 2020 23:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgLTEZ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Dec 2020 23:25:28 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFDDC0613CF
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Dec 2020 20:24:42 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id b26so6178829lff.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Dec 2020 20:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JFgiRqt389RYWGb/JlYYOu5sUPqgbDBylAV6+N6f2tM=;
        b=NG8/CPTIEWkExbDtSpmxwFwgXfdcgJY7+FFFEZ00n6mr2Ym8j6TQ5nfAXHk2dVNsEY
         +Jwx3B3CNGU50WTFaB+rCmrk7N7LcdJjx0JY7eSpsvBpapVVbLuWIaMW/AWY0h7rMv+w
         XWdFbXcwUpLM0JvrCEgJeuCxlewxa04sjKrbJp/hCZ626dq7m/FZuVfBammrT91R0hnQ
         1unNHu9ClyIDHq8oCcgf7XI2xo+bS5GNeRYuc1R9Gu5x2Ido9+SJf3GBEp7Qc+59OapG
         tG029o+Va7iRBSw0Al1Q58K9uWo+2Ka9YRxgWRvTDiTTxsxDFI1rT4Ft3EitEKGy+Mg9
         oc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JFgiRqt389RYWGb/JlYYOu5sUPqgbDBylAV6+N6f2tM=;
        b=tSKKyyO74sRY+luymxusWWGZoDL8iBFfjPT7QHmkbVICm5GOu0QoYY09zotopC3EVU
         iOR1j0aM174YjRmxC0a+4er7U6RvPziMgt0KTaec47L6yKCNJ9QhUpaxDXSorfXgd4Vm
         A2nReQtmSwrrcUtyftUDMifzVc/uy/flt516QurkbgYard76aLIyT8E7+ElZofbwIiYO
         OXNq9n4Tvuyc1VUGQH0BnzD/vZbr/5hld8YZTCitoSk2ik886Ew0Y/QJxLJKT2gk55VV
         hlC/MIm7TeG+o/gI2qv23841x/pMyyEKdWiQStJ3uQd7btdmHFTH30837v684vwA2B0h
         LONw==
X-Gm-Message-State: AOAM533SX7UPNKd+3ofSCKQqSSQmXDKhrPTdcJJFRFsdYSybH0TCnt9n
        RiKICqYm2Jg59vTU3KUGVjdE8UZqCt81EyS+nv0uUFm3JaUTZQ==
X-Google-Smtp-Source: ABdhPJx3gCsV/+khD7r04wyPsfQQRQzn/iOP9Tsgc7KYAprXKYWybinAxEkJ6S+asHTD4BhQBkZyfmqHBweeTp1yL80=
X-Received: by 2002:a2e:9985:: with SMTP id w5mr4851906lji.122.1608438280605;
 Sat, 19 Dec 2020 20:24:40 -0800 (PST)
MIME-Version: 1.0
References: <20201218221129.851003-1-shakeelb@google.com> <CAOQ4uxiyd=N-mvYWHFx6Yq1LW1BPcriZw++MAyOGB_4CDkDKYA@mail.gmail.com>
 <CALvZod6uT+bH7NqooEbqMLC6ppcbu-v=QDQRyTcfWGUsQodYjQ@mail.gmail.com> <CAOQ4uxh3vEBMs8afudFU3zxKLpcKG7KuWEGkLiH0hioncum1UA@mail.gmail.com>
In-Reply-To: <CAOQ4uxh3vEBMs8afudFU3zxKLpcKG7KuWEGkLiH0hioncum1UA@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 19 Dec 2020 20:24:29 -0800
Message-ID: <CALvZod6fua_SQ=1+MX_R52w8PVbFafSHgjcmhXdaRWkZtfe+cg@mail.gmail.com>
Subject: Re: [PATCH] inotify, memcg: account inotify instances to kmemcg
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 19, 2020 at 8:25 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Sat, Dec 19, 2020 at 4:31 PM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Sat, Dec 19, 2020 at 1:48 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Sat, Dec 19, 2020 at 12:11 AM Shakeel Butt <shakeelb@google.com> wrote:
> > > >
> > > > Currently the fs sysctl inotify/max_user_instances is used to limit the
> > > > number of inotify instances on the system. For systems running multiple
> > > > workloads, the per-user namespace sysctl max_inotify_instances can be
> > > > used to further partition inotify instances. However there is no easy
> > > > way to set a sensible system level max limit on inotify instances and
> > > > further partition it between the workloads. It is much easier to charge
> > > > the underlying resource (i.e. memory) behind the inotify instances to
> > > > the memcg of the workload and let their memory limits limit the number
> > > > of inotify instances they can create.
> > >
> > > Not that I have a problem with this patch, but what problem does it try to
> > > solve?
> >
> > I am aiming for the simplicity to not set another limit which can
> > indirectly be limited by memcg limits. I just want to set the memcg
> > limit on our production environment which runs multiple workloads on a
> > system and not think about setting a sensible value to
> > max_user_instances in production. I would prefer to set
> > max_user_instances to max int and let the memcg limits of the
> > workloads limit their inotify usage.
> >
>
> understood.
> and I guess the multiple workloads cannot run each in their own userns?
> because then you wouldn't need to change max_user_instances limit.
>

No workloads can run in their own user namespace but please note that
max_user_instances is shared between all the user namespaces.

>
[snip]
> > > Any reason why you did not include fanotify in this patch?
> >
> > The motivation was inotify's max_user_instances but we can charge
> > fsnotify_group for fanotify as well. Though I would prefer that to be
> > a separate patch. Let me know what you prefer?
> >
>
> I would prefer to add the helper fsnotify_alloc_user_group()
> that will use the GFP_KERNEL_ACCOUNT allocation flags
> internally.
>
> fsnotify_alloc_group() is used by all backends that initialize a single
> group instance for internal use and  fsnotify_alloc_user_group() will be
> used by inotify/fanotify when users create instances.
> I see no reason to separate that to two patches.
>

SGTM.
