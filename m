Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF034D7E89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Mar 2022 10:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237999AbiCNJ3w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Mar 2022 05:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238060AbiCNJ3t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:29:49 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6466944764
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Mar 2022 02:28:35 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id w2so8565944oie.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Mar 2022 02:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L0pQdhciSLEo8ODgeNmtOyhZZVOQXKK2htAYQJl5hKg=;
        b=C5d4NFJxdTfvVr+SNTS9BQAzqr/wE0nx7N5+jcKpKBMw1//fOBrhed4x99gNtS0qlv
         vHVRt610Bixs5cZ2S6P12xXCVr264es4RicnVRDpdhM8FcsLtznCaeSTbZXXzHO624Ba
         1qSVJfVaaBagNPO3Q3I2w8ff8C4rKSJnSl/fNqrB74TK0Xb4qBCJl9+fnRuyY5OA8gZU
         SBMNmYevzfTtzclwegkFEUkdSqONZVVTZyOJpZjlslbZrQNqw4w6kq87GJFm403Fk/2D
         hIJBWlkGb4et/CHmjk8HAbKPxv/uFJN5Cqo20c2saab8sn+Yhrdq7tlQlIAKVhE3/+gY
         0k6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L0pQdhciSLEo8ODgeNmtOyhZZVOQXKK2htAYQJl5hKg=;
        b=c8Zm90XSqx/SkPMW8jK+klL/jjy2ERMEXWz13RSkdugIeTCbfA8mNZqXHal+oOzndy
         6qUmTXalDivEVnI2C3tQb44kpRq22GDBQqv0YVgg8CjIRuxhK/Om0DWlC+MEc/o54lIl
         AFRABRgQFDSHtvssiRWiL+KO2rGMRXOobGbjwN517x0ruAjNeDa5vm2G//6nzeaWMHZ8
         F1S7qulCfhHse34FURQSHg+1ytiBUHvVXFSHpmKAYyN/nNJtAo9vHEdoSiwN8qihT6Fu
         95lVqVONDL7thh7iydz894NS4gHvacejJn5F3is5MPCeFZJK8ImgTztBconJNKqr/pZh
         d+Rg==
X-Gm-Message-State: AOAM530Ckg7nwg2/YsHdx0vJwagPx072GgWVKgfkKYmBSxNiobZAQh3k
        z2HfsCtJhXKizqbyVMHTSLPmw+QbHdteb+HZrZDJUUJeIUk=
X-Google-Smtp-Source: ABdhPJzGwbTkSjY+3tnVeq+Nx/JNRWKay1O74ZEDIdphVIN1BOfSitaNFC+RXb2JVts1I/pmvHlhz6ecsA4XydkiTDk=
X-Received: by 2002:aca:b845:0:b0:2d4:4207:8fd5 with SMTP id
 i66-20020acab845000000b002d442078fd5mr20522234oif.98.1647250114622; Mon, 14
 Mar 2022 02:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <1357949524.990839.1647084149724.ref@mail.yahoo.com>
 <1357949524.990839.1647084149724@mail.yahoo.com> <20220314084706.ncsk754gjywkcqxq@quack3.lan>
In-Reply-To: <20220314084706.ncsk754gjywkcqxq@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 14 Mar 2022 11:28:23 +0200
Message-ID: <CAOQ4uxiDubhONM3w502anndtbqy73q_Kt5bOQ07zbATb8ndvVA@mail.gmail.com>
Subject: Re: Fanotify Directory exclusion not working when using FAN_MARK_MOUNT
To:     Jan Kara <jack@suse.cz>
Cc:     Srinivas <talkwithsrinivas@yahoo.co.in>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
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

On Mon, Mar 14, 2022 at 10:47 AM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 12-03-22 11:22:29, Srinivas wrote:
> > If a  process calls fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,
> > FAN_OPEN_PERM, 0, "/mountpoint") no other directory exclusions can be
> > applied.
> >
> > However a path (file) exclusion can still be applied using
> >
> > fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_IGNORED_MASK |
> > FAN_MARK_IGNORED_SURV_MODIFY, FAN_OPEN_PERM | FAN_CLOSE_WRITE, AT_FDCWD=
,
> > "/tmp/fio/abc");  =3D=3D=3D> path exclusion that works.
> >
> > I think the directory exclusion not working is a bug as otherwise AV
> > solutions cant exclude directories when using FAN_MARK_MOUNT.
> >
> > I believe the change should be simple since we are already supporting
> > path exclusions. So we should be able to add the same for the directory
> > inode.
> >
> > 215676 =E2=80=93 fanotify Ignoring/Excluding a Directory not working wi=
th
> > FAN_MARK_MOUNT (kernel.org)
>
> Thanks for report! So I believe this should be fixed by commit 4f0b903ded
> ("fsnotify: fix merge with parent's ignored mask") which is currently
> sitting in my tree and will go to Linus during the merge (opening in a
> week).

Actually, in a closer look, that fix alone is not enough.

With the current upstream kernel this should work to exclude events
in a directory:

fanotify_mark(fd, FAN_MARK_ADD, FAN_EVENT_ON_CHILD |
                       FAN_OPEN_PERM | FAN_CLOSE_WRITE,
                       AT_FDCWD, "/tmp/fio/");
fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_IGNORED_MASK |
                       FAN_MARK_IGNORED_SURV_MODIFY,
                       FAN_OPEN_PERM | FAN_CLOSE_WRITE,
                       AT_FDCWD, "/tmp/fio/");

The first call tells fanotify that the inode mark on "/tmp/foo" is
interested in events on children (and not only on self).
The second call sets the ignored mark for open/close events.

The fix only removed the need to include the events in the
first call.

Should we also interpret FAN_EVENT_ON_CHILD correctly
in a call to fanotify_mark() to set an ignored mask?
Possibly. But that has not been done yet.
I can look into that if there is interest.
In retrospect, FAN_EVENT_ON_CHILD and FAN_ONDIR would have
been more clear as FAN_MARK_ flags, but that's too late.

Thanks,
Amir.
