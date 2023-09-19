Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E5C7A6758
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 16:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjISOzW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 10:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjISOzV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:55:21 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9241EC
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 07:55:14 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7a50a1d1246so1961815241.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 07:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695135314; x=1695740114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79kaESdDW6K1sjZ/2sOd0sKjCTXjDh4eJwCuy4dJYCg=;
        b=Yq396UgeRK9tv6SnZNr3rjdriixNxEUjKFhOc4Dilc/9TyklSiB5lncdjPXCNC9FZA
         epMl4EB8XgHWbq0JV3aLW0HTs9XileIGGIzmfq0G9X9mcUeetvYtdKXBXLwIc11tClNq
         LoEllw0ueUQLF7Ki2hUMBi/b7DLXzRRkpFwgO/1GN6+TBi5e91P0hXUwr8qiNtcef42u
         0Jk4X6AMFHwdjVEpvgJoENS0tgr2U8J94lh98mjyjlTPI3g9Zpa7bllDnSr8WB5whuEq
         1h9XTelyi8EEtVfnKqTnAXuyMdPnKY0JXVghaaDdXsWzW4AGhMsUObVYjIZhFAMZREl0
         0LRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695135314; x=1695740114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79kaESdDW6K1sjZ/2sOd0sKjCTXjDh4eJwCuy4dJYCg=;
        b=m//F7H9YqdUw4rkKjOUVGCG2K2eF6P4xBvEvHAAZ0CmXbyOx0yUZXcxHJogebV66Fi
         FFIh+tWK7XdSMDejv+jM7cekaIMj7MDRB9Zq3K+7ulTmqUUTXz8IHim2ILmu9wRidKef
         Xm8EaXPRflt8Z2Dz9iH4XntAW06tbBzTypimhNV5blQ3d42L1SWXqkJ/BRQVcbBvR0iu
         iPKOGZS6kf3WQFvhr8qzs8qGVst6fMS8+hopleiIpJuP7g3JFrxmIIbD6h1eq8awxuJc
         6WkzfOH1TdMhXCwFkFr+7pj/fprPhR3Ru3ixsQ1qWPuxu6M2goK4Fv0UhawHevwTLEba
         LjDQ==
X-Gm-Message-State: AOJu0YxbeCyXLVGm9BKXgniBg16fHyZDgUj7EOSy8wiiVAm682J7/Pti
        su/U+EfKl9W571H/eNwCyYS43c28YNS0D9/l3S/oQL+WXEg=
X-Google-Smtp-Source: AGHT+IH7JtNyYDlxKqomSdNPu7FLJvbOg7HkDnVcEaQ0vqbJVpFRtvsYtThAGs21y7yp6xH48WNbXW+38gCaJCRkWkU=
X-Received: by 2002:a1f:d881:0:b0:496:1ad2:9d0f with SMTP id
 p123-20020a1fd881000000b004961ad29d0fmr50563vkg.1.1695135313824; Tue, 19 Sep
 2023 07:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230918123217.932179-1-max.kellermann@ionos.com>
 <20230918123217.932179-3-max.kellermann@ionos.com> <20230918124050.hzbgpci42illkcec@quack3>
 <CAKPOu+-Nx_cvBZNox63R1ah76wQp6eH4RLah0O5mDaLo9h60ww@mail.gmail.com>
 <20230918142319.kvzc3lcpn5n2ty6g@quack3> <CAOQ4uxic7C5skHv4d+Gek_uokRL8sgUegTusiGkwAY4dSSADYQ@mail.gmail.com>
 <CAOQ4uxjzf6NeoCaTrx_X0yZ0nMEWcQC_gq3M-j3jS+CuUTskSA@mail.gmail.com> <20230919094820.g5bwharbmy2dq46w@quack3>
In-Reply-To: <20230919094820.g5bwharbmy2dq46w@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 19 Sep 2023 17:55:02 +0300
Message-ID: <CAOQ4uxivnEDxz3OgYJ9nsSVZsWbidjOzvKJEOb0KiWonr1eEPQ@mail.gmail.com>
Subject: Re: inotify maintenance status
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Max Kellermann <max.kellermann@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 12:48=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 18-09-23 21:05:11, Amir Goldstein wrote:
> > [Forked from https://lore.kernel.org/linux-fsdevel/20230918123217.93217=
9-1-max.kellermann@ionos.com/]
> ...
> > BTW, before we can really mark inotify as Obsolete and document that
> > inotify was superseded by fanotify, there are at least two items on the
> > TODO list [1]:
>
> Yeah, as I wrote in the original thread, I don't feel like inotify should
> be marked as obsolete (at least for some more time) so we are on the same
> page here I think.
>
> > 1. UNMOUNT/IGNORED events
> > 2. Filesystems without fid support
> >
> > MOUNT/UNMOUNT fanotify events have already been discussed
> > and the feature has known users.
> >
> > Christian has also mentioned [1] the IN_UNMOUNT use case for
> > waiting for sb shutdown several times and I will not be surprised
> > to see systemd starting to use inotify for that use case before too lon=
g...
>
> Yup, both FAN_UNMOUNT and FAN_IGNORED should be easy. Unlike inotify, I'd
> just make these explicit events you can opt into and not something you
> always get.
>
> > Regarding the second item on the TODO list, we have had this discussion
> > before - if we are going to continue the current policy of opting-in to
> > fanotify (i.e. tmpfs, fuse, overlayfs, kernfs), we will always have odd
> > filesystems that only support inotify and we will need to keep supporti=
ng
> > inotify only for the users that use inotify on those odd filesystems.
> >
> > OTOH, if we implement FAN_REPORT_DINO_NAME, we could
> > have fanotify inode mark support for any filesystem, where the
> > pinned marked inode ino is the object id.
>
> Is it a real problem after your work to allow filehandles that are not
> necessarily usable for NFS export or open_by_handle()? As far as I rememb=
er
> fanotify should be now able to handle anything that provides f_fsid in it=
s

Not exactly. We still have a requirement for non-empty
dentry->d_sb->s_export_op in fanotify_test_fid(), to align with
the same requirement for AT_HANDLE_FID support.

> statfs(2) call. And as I'm checking filesystems not setting fsid currentl=
y are:
>
> afs, coda, nfs - networking filesystems where inotify and fanotify have
>   dubious value anyway
>
> configfs, debugfs, devpts, efivarfs, hugetlbfs, openpromfs, proc, pstore,
> ramfs, sysfs, tracefs - virtual filesystems where fsnotify functionality =
is
>   quite limited. But some special cases could be useful. Adding fsid supp=
ort
>   is the same amount of trouble as for kernfs - a few LOC. In fact, we
>   could perhaps add a fstype flag to indicate that this is a filesystem
>   without persistent identification and so uuid should be autogenerated o=
n
>   mount (likely in alloc_super()) and f_fsid generated from sb->s_uuid.
>   This way we could handle all these filesystems with trivial amount of
>   effort.

This sounds good to me.
I have a vague memory of suggesting the same and I think
Christian had objections, but I may be remembering wrong.

Possibly, the same opt-in fstype flag could allow also trivial
AT_HANDLE_FID support with the default export_encode_fh()?

>
> freevxfs - the only real filesystem without f_fsid. Trivial to handle one
>   way or the other.
>
> So I don't think we need new uAPI additions to finish off this TODO item.

Yes, I'd love that.
I can try to post something if there are no objections.

Thanks,
Amir.
