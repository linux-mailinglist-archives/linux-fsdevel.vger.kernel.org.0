Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505741B2464
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 12:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgDUKwG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 06:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbgDUKwE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 06:52:04 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A61C061A0F;
        Tue, 21 Apr 2020 03:52:04 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id w20so14535925iob.2;
        Tue, 21 Apr 2020 03:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O929yg+fLvoN/by1jc0EwDCf8KvNlk29JcmtP7raFgM=;
        b=S9EbP1qiavrPpV7afPpIf7pc2PBE8l8unmYOzYF967yvTE8KJXSvneeKNTjuvwgIW2
         hdtGwMb4SflsyrCZvhFZPLlX+ZKm1dyyZqKYDYIlONAlwB2q18M2Gg2LR9VAKPVY86An
         O5ReM6OKN/6Xc9vFjt3KLPdwJUTaqct0u+cmCUh69Nr8AnDVZFXn9bc19CRj/uSPn9H4
         iRQSdrk2ndv61RH7zrRxgsFxMBANYDWbfgeey7JQMjumCTNZuyFb1bfbpnMgebLNpb2Q
         7l1kbgwTNXqejvX208PO82RcjgIVMxKKJnOKpa3Lqp/5rGwanGkruZfV3CUkeEI8zSdz
         WbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O929yg+fLvoN/by1jc0EwDCf8KvNlk29JcmtP7raFgM=;
        b=Vkr00bRA7qZWtsgNHir/i8XBjCNqk9JItEloXK0AEhZg0pz65eXU4oB/wDEz1CGWfg
         Vkqf7J0jwmPBH+L/5vRei8YuscuAvzc81a5uzLZT0bxfpBoOgQgFwspQh9Wtt3eJYkHD
         ec+A3FmdudJmIZa80PtNEY4PxK+07aXvBuL9TiJtUqJaJnIWe9um4zWOYNUUt8n/uoSr
         Phvt3syn7m6uKfu8wE9I4e6HUTwJ6cqQv3JpPGEziUldTwksX5QRVuV9DxgG9EEYUjFC
         VNnNGMoDkdC7ZdxHoe44Ba4PqvB5HvIqoGMm8RNDJOLw/Ubh88io830jndRd1uWVcmfL
         u+HQ==
X-Gm-Message-State: AGi0PuZ+QHF7RgBJVUbhGHmOZnPXKY7bs+IVdnsBPIKRPvJGujPd8MQT
        SmGD+4a7QLu5nr1tRictfTpp715MjjYSJavVsDo=
X-Google-Smtp-Source: APiQypKk4tW88JY76r9/Er7wZ18e8ryyyi/UBlfc+uddacQ/gIzzjrB215ZfXqIkXrcyo8blfz9mbVHnS3qseIWlPn0=
X-Received: by 2002:a6b:b8d6:: with SMTP id i205mr20857175iof.123.1587466324033;
 Tue, 21 Apr 2020 03:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <1585733475-5222-1-git-send-email-chakragithub@gmail.com> <CAJfpegtk=pbLgBzM92tRq8UMUh+vxcDcwLL77iAcv=Mxw3r4Lw@mail.gmail.com>
In-Reply-To: <CAJfpegtk=pbLgBzM92tRq8UMUh+vxcDcwLL77iAcv=Mxw3r4Lw@mail.gmail.com>
From:   Chakra Divi <chakragithub@gmail.com>
Date:   Tue, 21 Apr 2020 16:21:52 +0530
Message-ID: <CAH7=fosGV3AOcU9tG0AK3EJ2yTXZL3KGfsuVUA5gMBjC4Nn-WQ@mail.gmail.com>
Subject: Re: [PATCH] fuse:rely on fuse_perm for exec when no mode bits set
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 20, 2020 at 4:55 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, Apr 1, 2020 at 11:31 AM Chakra Divi <chakragithub@gmail.com> wrote:
> >
> > In current code, for exec we are checking mode bits
> > for x bit set even though the fuse_perm_getattr returns
> > success. Changes in this patch avoids mode bit explicit
> > check, leaves the exec checking to fuse file system
> > in uspace.
>
> Why is this needed?

Thanks for responding Miklos. We have an use case with our remote file
system mounted on fuse , where permissions checks will happen remotely
without the need of mode bits. In case of read, write it worked
without issues. But for executable files, we found that fuse kernel is
explicitly checking 'x' mode bit set on the file. We want this
checking also to be pushed to remote instead of kernel doing it - so
modified the kernel code to send getattr op to usespace in exec case
too.

> Thanks,
> Miklos
