Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887454C801B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 02:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbiCABKJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 20:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiCABKC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 20:10:02 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6AF6140
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 17:09:22 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id q17so19980514edd.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 17:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XQU+v0ncJKQsq8KVJD+e40cIco7m2GBd4rHARca/WR4=;
        b=0jmzKwCWF4tyUOMYPO79E8fZ5IPNMaa8ViRAkdhJVQ+rpvYnB807H9RFMUbcIp7BZU
         gZHQ1rDBx3PK62BLmbBlNNAT3jyzYaL4Q2y1jktn63TwPT5ab7vdpiN4MQeP1MOCyfW/
         1hrpDZVGloDoRW/S3YgB7ZGNi+EX7JpeqF+27/Xd6NI08vCg4fnWr5/UMmQ3YP+rWN2q
         yIGHsrbeKMCBBBgIhh1S5ZwIKqOb+wr4/4iLEbQ7SulNvHeNpE2lVCx7J+vfXvAVBYuU
         4/QobemQ3yboRwLVKSLl98uQ/+1XfxEHp6My70akJWohmiB80lkECn8ozqFNVuNZKksq
         Vmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XQU+v0ncJKQsq8KVJD+e40cIco7m2GBd4rHARca/WR4=;
        b=oucWfdA6i8MlsQIbSTSTC6kWpw6bx4513iHjxGiez5VpJeJAB4hNQ+GzUkP55q8Pn6
         sLqXlUaugT2wtHTtdEHHiakc9ZPRXvg6YwoI6nxWSF2I3EL8yQI7By5/ijgw0ryZVX/2
         6XaWInJHYjnwBjnzp5MHtXoAiryJ9J4UjRrNx1kQw7OZSrsiNP0Hc4rUff9pe9jQVEM3
         vE6NS1cpLEsGQGSBIhV9DHTcNeS7fglY9OLpw/guQralZIaWI+VfQt1QcG7pGM4mDDiT
         dWX4rKUmeHF8j5KYOifchMhURXCX9tWLYV+zwIvVyf1WlaapB0AN3GvISB3d17aMxGOB
         bIEw==
X-Gm-Message-State: AOAM5307rl3vGH2hxVxNtcoDFVMSsQZOZ+qBj+ar/7tfYCtaMRdWSTMw
        dMZS/8HiPXdyFCJz6sdpKED7usQVzpAex1RxRE8c
X-Google-Smtp-Source: ABdhPJyMYQib71KmGDawe2Sa6f6s4SJDfyMQRJedtkVd+Ib0jlueXrtB/26onK1/CMnUCdwxIX5WHVCU4U1exe/oGNQ=
X-Received: by 2002:a05:6402:1e8e:b0:412:cfd8:4d12 with SMTP id
 f14-20020a0564021e8e00b00412cfd84d12mr21942842edf.343.1646096960582; Mon, 28
 Feb 2022 17:09:20 -0800 (PST)
MIME-Version: 1.0
References: <20211117015806.2192263-1-dvander@google.com> <CAOQ4uxjjapFeOAFGLmsXObdgFVYLfNer-rnnee1RR+joxK3xYg@mail.gmail.com>
 <Yao51m9EXszPsxNN@redhat.com> <CAOQ4uxjk4piLyx67Ena-FfypDVWzRqVN0xmFUXXPYa+SC4Q-vQ@mail.gmail.com>
 <YapjNRrjpDu2a5qQ@redhat.com>
In-Reply-To: <YapjNRrjpDu2a5qQ@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 28 Feb 2022 20:09:09 -0500
Message-ID: <CAHC9VhQTUgBRBEz_wFX8daSA70nGJCJLXj8Yvcqr5+DHcfDmwA@mail.gmail.com>
Subject: Re: [PATCH v19 0/4] overlayfs override_creds=off & nested get xattr fix
To:     Vivek Goyal <vgoyal@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        David Anderson <dvander@google.com>
Cc:     Mark Salyzyn <salyzyn@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Stultz <john.stultz@linaro.org>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        kernel-team <kernel-team@android.com>, selinux@vger.kernel.org,
        paulmoore@microsoft.com, Luca.Boccassi@microsoft.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I wanted to try and bring this thread back from the dead (?) as I
believe the use-case is still valid and worth supporting.  Some more
brief comments below ...

On Fri, Dec 3, 2021 at 1:34 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> I am not sure. In the early version of patches I think argument was
> that do not switch to mounter's creds and use caller's creds on
> underlying filesystem as well. And each caller will be privileged
> enough to be able to perform the operation.

The basic idea is that we can now build Linux systems with enough
access control granularity such that a given process can have the
necessary privileges to mount a filesystem, but not necessarily access
all of the data on the filesystem, while other processes, with
different access rights, are allowed to read and write data on the
mounted filesystem.  Granted, this is a bit different from how things
are usually done, but in my opinion it's a valid and interesting use
case in that it allows us to remove unneeded access rights from
historically very privileged system startup services/scripts: the
service that runs to mount my homedir shouldn't be allowed to access
my files just to mount the directory.

Unfortunately, this idea falls apart when we attempt to use overlayfs
due to the clever/usual way it caches the mounting processes
credentials and uses that in place of the current process' credentials
when accessing certain parts of the underlying filesystems.  The
current overlayfs implementation assumes that the mounter will always
be more privileged than the processes accessing the filesystem, it
would be nice if we could build a mechanism that didn't have this
assumption baked into the implementation.

This patchset may not have been The Answer, but surely there is
something we can do to support this use-case.

> Our take was that how is this model better because in current model
> only mounter needs to be privileged while in this new model each
> caller will have to be privileged. But Android guys seemed to be ok
> with that. So has this assumption changed since early days. If callers
> are privileged, then vfs_getxattr() on underlying filesystem for
> overaly internal xattrs should succeed and there is no need for this
> change.
>
> I suspect patches have evolved since then and callers are not as
> privileged as we expect them to and that's why we are bypassing this
> check on all overlayfs internal trusted xattrs? This definitely requires
> much close scrutiny. My initial reaction is that this sounds very scary.
>
> In general I would think overlayfs should not bypass the check on
> underlying fs. Either checks should be done in mounter's context or
> caller's context (depending on override_creds=on/off).
>
> Thanks
> Vivek

-- 
paul-moore.com
