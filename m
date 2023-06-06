Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700EB72406D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 13:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjFFLEZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 07:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236845AbjFFLDO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:03:14 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEDFBE
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 04:00:37 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-4611eec56bdso1658816e0c.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 04:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686049236; x=1688641236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpgLb5wo0WB5C20UPW1gkeeos/SxD5rvpI//kQwf1u0=;
        b=ZqZl2itVkFewn3cfK90e7e3uNcKDasy0gL5MixMnr7ZXLZtJLQS+/nS1+oRZta/adW
         KX16lcPt9TPYh9aRCf+DCa3GfYZmnesh8NZKsxsrvIqDXLVWCngEO0rE+a/MfJ2Os9J2
         ZAz1KYgP01oAprnJpDgT4TTEyb3AtJWR5jPvDFiGPvfRJDGR1GFMD5GIdJ2x573zrKbv
         pJheXXqtjcyMG2cZHykL7z8Hvbgt4M2RifQe0TePQ7wPs+9wpjTxxfqEzfBKvx+l3Y5h
         ZRyDYgvUTFWMeIxw8cCGy1STB5tGRnlCSXDrcIknnyMauBPTWi8lj4FgaRFwR9cvOFyT
         By4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686049236; x=1688641236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NpgLb5wo0WB5C20UPW1gkeeos/SxD5rvpI//kQwf1u0=;
        b=XKO+AhU4q8vC7WUY8+OI4xXaTHIrPh88hL8R3EfzFHSXHuYtqgNQZ6m02U8jSGPf6F
         2ySR/KUwiijdUE2UVZIOyiOGT4GyetZ6ODvJZL+ZF5fd1QQzRt3/pWMI4q1H+e81ul4A
         zyMs0tIOokk6psyJdDWVAHshawhTEsVkKLcfb031H414ihvzLwhTNSJIiC5ILE4vyhXX
         Encc+YLGRZOJW+YYQ9YRscQIlL6o0kgEYsVpIt61+2kB/MpQ5FwEkdmiPMFnvRYCtmbK
         3U9P8VgmOhNUkfKM4lRiU5XryisLll6V7wgQk9bCQtAUks0GYrjdyjvPXAZYB//zFGfO
         WKpw==
X-Gm-Message-State: AC+VfDzzh+59zeF69a/+qT6T0JaJtNPdt3UkYKR0ZUOU7pJ/ivlTtVZZ
        tYflyZI0vhon9l+XEKqc8zrAvymlEkFXl7gcZzg=
X-Google-Smtp-Source: ACHHUZ6G1TeADdY1FFkG5BXkfLzsEHaZI64CDOtSSEi6L1850yaPHjquhxzprXKmI/qoSr8MkDn3w+6rCFycCiMp21k=
X-Received: by 2002:a67:fe98:0:b0:43b:1f8a:d581 with SMTP id
 b24-20020a67fe98000000b0043b1f8ad581mr977622vsr.31.1686049236661; Tue, 06 Jun
 2023 04:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <20230519125705.598234-11-amir73il@gmail.com>
 <CAJfpegv3sBfw2OKWaxDe+zEEbq5Q6vBDixLd6OYzeguZgGZ_fA@mail.gmail.com>
In-Reply-To: <CAJfpegv3sBfw2OKWaxDe+zEEbq5Q6vBDixLd6OYzeguZgGZ_fA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 6 Jun 2023 14:00:25 +0300
Message-ID: <CAOQ4uxhLFRHAfXs5ZZLf5yakYMVD9edMMofSzwC12MXGvMsnXg@mail.gmail.com>
Subject: Re: [fuse-devel] Fwd: [PATCH v13 10/10] fuse: setup a passthrough fd
 without a permanent backing id
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        Daniel Rosenberg <drosen@google.com>
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

On Tue, Jun 6, 2023 at 1:23=E2=80=AFPM Miklos Szeredi via fuse-devel
<fuse-devel@lists.sourceforge.net> wrote:
>
> On Fri, 19 May 2023 at 14:57, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > WIP
> >
> > Add an ioctl to associate a FUSE server open fd with a request.
> > A later response to this request get use the FOPEN_PASSTHROUGH flag
> > to request passthrough to the associated backing file.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Miklos,
> >
> > After implementing refcounted backing files, I started to think how
> > to limit the server from mapping too many files.
> >
> > I wanted to limit the backing files mappings to the number of open fuse
> > files to simplify backing files accounting (i.e. open files are
> > effectively accounted to clients).
> >
> > It occured to me that creatig a 1-to-1 mapping between fuse files and
> > backing file ids is quite futile if there is no need to manage 1-to-man=
y
> > backing file mappings.
> >
> > If only 1-to-1 mapping is desired, the proposed ioctl associates a
> > backing file with a pending request.  The backing file will be kept
> > open for as long the request lives, or until its refcount is handed
> > over to the client, which can then use it to setup passthough to the
> > backing file without the intermediate idr array.
>
> I think I understand what the patch does, but what I don't understand
> is how this is going to solve the resource accounting problem.
>
> Can you elaborate?
>

It does not solve the resource accounting in the traditional way
of limiting the number of open files to the resource limit of the
server process.

Instead, it has the similar effect of overlayfs pseudo files
non accounting.

A FUSE passthrough filesystem can contribute the same number
of non accounted open fds as the number of FUSE fds accounted
to different processes.

A non privileged user can indirectly cause unaccounted open fds
with a FUSE passthough fs in the exact same way that the same
user can cause unaccounted open fds with an overlayfs mount
if it can convince other users to open files on the FUSE/ovl that it
has mounted.

Am I making sense?

One possible improvement to this API is to include the nodeid
in FUSE_DEV_IOC_PASSTHROUGH_SETUP to make the
mapping per-inode.

If the mapping was already created during another open of
the same inode, the setup would fail with a special error
(EEXIST) so the caller would close the new backing fd, but
the request already takes a reference to the backing fd of
the inode, so FOPEN_PASSTHROUGH may proceed.

On the last close, the backing fd refcount drops to zero and
then is detached from the inode.

A server that wants to manage the mapping lifetime can still
use FUSE_DEV_IOC_PASSTHROUGH_OPEN/CLOSE to
do so (with nodeid) argument.

Thanks,
Amir.
