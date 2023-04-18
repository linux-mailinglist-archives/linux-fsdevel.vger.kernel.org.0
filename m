Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB9E6E68C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 17:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjDRP5F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 11:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjDRP5E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:57:04 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DA21BC7;
        Tue, 18 Apr 2023 08:57:02 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id v18so9228557uak.8;
        Tue, 18 Apr 2023 08:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681833421; x=1684425421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFvk9gmhgZkAAjvzYaqZSKoXPDLyjqkrafwU+VuiAkw=;
        b=XIw0w3d9lT4i5bZevfx9VzES2JCC/LfbgQQuXsAdQaWkInfS8MR9U5VmyeH2DimWxB
         5c4vLW/WheTaAXdtZ3YoSmkOsGDuh9Cw7cQCm12WqgVunoHAioG3n2fS84l0aSlkQ6wi
         Sh77Kt9loIJ1owFpNjPokKVhWZtfO/SIYoXzysp8nmWQFwdVYhrflBCuhGe+34YJVhSq
         Bt3laOUqobIWs4omuzHDPWrKd/cVJT2e1SnR88ptu6LkDLi1bmcP/o2TQ9apMYJr50LV
         ZCRkn9ZPJPXGl9B+0IX51vKzabjbqEoFtkVyRWfDI2ZSZB/Q+ok+bPtNUIh68XxxpOia
         z78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681833421; x=1684425421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFvk9gmhgZkAAjvzYaqZSKoXPDLyjqkrafwU+VuiAkw=;
        b=BRN8XI+EoxpmqEb1lV5KhNc1bBZNQvu62NuG029RTpXSUuuiXVkZx3jfTsGQfAvc7X
         D8+fNVf1oUIcA6XCPiZ5H3V655cyei8AHThSoRvJp5T1NrvcgGyUfy7+kEi214kjEAB5
         4/JBTF/VZS0LusF8dQEH9hvZJKI/IWwMT6fQLW5kDxb/miHg6aQwiKBBlbwvCEnuhpYy
         PMROLFvbyIbx+TaFR6UUytFfgCg3u8HMU3XY5zPgo85m/fciSfPyWZmn9lAPmtlP7BwI
         0a11+qS1FhmZyYsBcD2VfXhzM1elk9kp+fREze/w6YjixuDMts2Lnkcea2Lt5ZnPGkRu
         vZ0A==
X-Gm-Message-State: AAQBX9f169Rj8uEEgjct7EYZwLsZjrxxoOSEU1pBUjYm1wHodqFxRfE9
        5VOwEmz7tPtjn4oacQ+io3rR7QYQzdgh6jtSbaU=
X-Google-Smtp-Source: AKy350ZEwp8dMkpMonlG6NCFsYEHd5elQ92IwQiuRO1KXNIp8vzYpYJyYLN+csB6Hga8XYlzgvi0aB1lzXGymJCq1ZY=
X-Received: by 2002:a1f:1652:0:b0:406:6b94:c4fe with SMTP id
 79-20020a1f1652000000b004066b94c4femr10863813vkw.0.1681833420848; Tue, 18 Apr
 2023 08:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com> <e57733cd-364d-84e0-cfe0-fd41de14f434@bytedance.com>
 <CAJfpegsVsnjUy2N+qO-j4ToScwev01AjwUA0Enp_DxroPQS30A@mail.gmail.com>
 <CAOQ4uxhYi2823GiVn9Sf-CRGrcigkbPw2x1VQRV3_Md92gJnrw@mail.gmail.com> <CAJfpegsLD-OxYfqPR7AfWbgE1EAPfWs672omt+_u8sYCMFB5Fg@mail.gmail.com>
In-Reply-To: <CAJfpegsLD-OxYfqPR7AfWbgE1EAPfWs672omt+_u8sYCMFB5Fg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 18 Apr 2023 18:56:49 +0300
Message-ID: <CAOQ4uxhz7g=N0V8iGiKa2+vupEuH_m9_27kas++6c0bLL2qRyA@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] fsinfo and mount namespace notifications
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Abel Wu <wuyun.abel@bytedance.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 18, 2023 at 11:54=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Sat, 15 Apr 2023 at 13:06, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > You indicated that you would like to discuss the topic of
> > "mount info/mount notification" in LSF/MM, so I am resurrecting
> > this thread [1] from last year's topic.
> >
> > Would you be interested to lead a session this year?
> > So far, it felt like the topic was in a bit of a stalemate.
> >
> > Do you have a concrete suggestion of how to escape this stalemate?
> > I think it is better that we start discussing it a head of LSF/MM if we=
 hope
> > to reach consensus in LSF/MM, so that people will have a chance to
> > get re-familiar with the problems and proposed solutions.
>
> The reason for the stalemate is possibly that we are not trying to
> solve the issue at hand...
>
> So first of all, here's what we currently have:
>
> - reading a process' mount table via /proc/$PID/mountinfo
>    o mount parameters (ID, parent ID, root path, mountpoint path,
> mount flags, propagation)
>    o super block parameters (devnum, fstype, source, options)
>    o need to iterate the whole list even if interested in just a single m=
ount
>
> - notification on mount table change using poll on /proc/$PID/mountinfo
>    o no indication what changed
>    o finding out what changed needs to re-parse possibly the whole
> mountinfo file
>    o this can lead to performance problems if the table is large and
> constantly changing
>
> - mount ID's do not uniquely identify a mount across time
>   o when a mount is deleted, the ID can be immediately reused
>
> The following are the minimal requirements needed to fix the above issues=
:
>
> 1) create a new ID for each mount that is unique across time; lets
> call this umntid
>

Do you reckon we just stop recycling mntid?
Do we also need to make it 64bit?
statx() has already allocated 64bit for stx_mnt_id.
In that case, should name_to_handle_at() return a truncated mnt_id?

> 2) notification needs to indicate the umntid that changed
>
> 3) allow querying mount parameters via umntid
>
> And I think here's where it gets bogged down due to everyone having
> their own ideas about how that interface should look like.
>
> Proposals that weren't rejected so far:
>
> - mount notifications using watch_queue
>
> https://lore.kernel.org/all/159645997768.1779777.8286723139418624756.stgi=
t@warthog.procyon.org.uk/
>
> I also explored fsnotify infrastructure for this.  I think the API is
> better fit, since we are talking about filesystem related events, but
> notifications l would need to be extended with the mount ID.

Like this? ;-)

https://lore.kernel.org/linux-fsdevel/20230414182903.1852019-1-amir73il@gma=
il.com/

I was considering whether fanotify should report a 32bit mntid
(like name_to_handle_at()) or 64bit one (like statx()).
I should probably go with the latter then.

>
> - getxattr(":mntns:$ID:info",...)
>
> https://lore.kernel.org/all/YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com/
>
> Christian would like to see the xattr based interface replaced with a
> new set of syscalls to avoid confusion with "plain" xattrs.
>

OK, I penciled the session - we can (re)try to iron the concerns
and reach consensus.

Thanks,
Amir.
