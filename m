Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F187F6E3F60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 08:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjDQGHP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 02:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDQGHO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 02:07:14 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958C49C;
        Sun, 16 Apr 2023 23:07:13 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id f10so10399178vsv.13;
        Sun, 16 Apr 2023 23:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681711632; x=1684303632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FkOa290pQSu7Yiad6ob7YP0SrNBnVarBHAEhR+m7OY=;
        b=ka5OEDfZi7wvCtTPIJPI/MJiqyFidxK1FSQERrW+7KhnsJIJ6x6gmw1O/KKP5YmscO
         eqplWr9JSEAYM2XYuAQJSi9sLznG9mamx+Orb95GC2f+ONqBWCBKm8sI6Ihlw2BSKMtz
         XOE9DMRAKCmUt0XVzHqzIohzOQx2ga2e3xlwhRfMwMlB8DkZL+yjfyUqhi0+VJg1Fki8
         JoHow9BrgW8KV3J3sl7LsVyMX08df0HabftN7yTkhJ5Zxk8EBzChPcGhNIYh/TyaypYc
         /vaHqeNMyTnUvklOFMD5ttf55m71/R9xQHqlv8e4xDEhZSZGpMbOCgo1BlRE6VEkfBNA
         Wj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681711632; x=1684303632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FkOa290pQSu7Yiad6ob7YP0SrNBnVarBHAEhR+m7OY=;
        b=YvWzd6aqQq/NXZOe8QO/4XjF8HEtri24CPJOZBTXtIUQTnUWvQis0KFe0SChE1f0VZ
         jcrgD1al2VBLf6kSVK1erGkprNZPumApCvcfwIWWN7+g+dz4XqMCihQO/FlsI6g+D8Vy
         306Rjhr9l5zqzxXVt+/5iUO/8U+5I7KNSWbXS6Xcg7X34u+VdYp8mQ41lG4SDe8Hika7
         Zx8cBvx0A3ARHcV0H8PPMk946af30jpaIcBkcO6k/gNvkJlMn/L5teqdFXlJsRLD96xc
         a0wVpu7nkopnCuNIqLHiaZH4ZibvACahrklVlB6C/qLJuEPXoA6at92nR0l5Oto3FbKV
         BR2g==
X-Gm-Message-State: AAQBX9dfHPODWGzuVlu8VGBcaudIEwVj2Sz6Q3Bz5eaIbyvENuDR4cxa
        eBSrClvy+mPSfbeT+Xi6q7r+wFG/3PO2fjhvgqbyoytfzvE=
X-Google-Smtp-Source: AKy350ZdNlrvY6SfEP/KQCnkty7ZUMlHpXigx3KCKfGjfdYNyKBei1uMesVBrTPoHvkyEMsJbfbQJ/7eM7/vxaPq/jQ=
X-Received: by 2002:a67:d783:0:b0:42e:38a3:244b with SMTP id
 q3-20020a67d783000000b0042e38a3244bmr6775628vsj.5.1681711632628; Sun, 16 Apr
 2023 23:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <CACsaVZJGPux1yhrMWnq+7nt3Zz5wZ6zEo2+S2pf=4czpYLFyjg@mail.gmail.com>
 <ZDzgojYAZXS_D_OH@kroah.com>
In-Reply-To: <ZDzgojYAZXS_D_OH@kroah.com>
From:   Kyle Sanderson <kyle.leet@gmail.com>
Date:   Sun, 16 Apr 2023 23:07:00 -0700
Message-ID: <CACsaVZ+8iGR3sD7d4wO12LqKBZnJ+xhOs9+RXvqjrGKp35_-xg@mail.gmail.com>
Subject: Re: btrfs induced data loss (on xfs) - 5.19.0-38-generic
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-btrfs@vger.kernel.org,
        Linux-Kernal <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
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

On Sun, Apr 16, 2023 at 11:01=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Sun, Apr 16, 2023 at 10:20:45PM -0700, Kyle Sanderson wrote:
> > The single btrfs disk was at 100% utilization and a wa of 50~, reading
> > back at around 2MB/s. df and similar would simply freeze. Leading up
> > to this I removed around 2T of data from a single btrfs disk. I
> > managed to get most of the services shutdown and disks unmounted, but
> > when the system came back up I had to use xfs_repair (for the first
> > time in a very long time) to boot into my system. I likely should have
> > just pulled the power...
> >
> > [1147997.255020] INFO: task happywriter:3425205 blocked for more than
> > 120 seconds.
> > [1147997.255088]       Not tainted 5.19.0-38-generic #39~22.04.1-Ubuntu
>
> This is a distro-specific kernel, sorry, nothing to do with our releases
> as the 5.19 kernel branch is long end-of-life.  Please work with your
> distro for this issue if you wish to stick to this kernel version.
>
> good luck!
>
> greg k-h

Disappointing but fair (default kernel for Ubuntu Jammy, they offer no
lts options unfortunately) - thanks for taking a look anyway.

K.

On Sun, Apr 16, 2023 at 11:01=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Sun, Apr 16, 2023 at 10:20:45PM -0700, Kyle Sanderson wrote:
> > The single btrfs disk was at 100% utilization and a wa of 50~, reading
> > back at around 2MB/s. df and similar would simply freeze. Leading up
> > to this I removed around 2T of data from a single btrfs disk. I
> > managed to get most of the services shutdown and disks unmounted, but
> > when the system came back up I had to use xfs_repair (for the first
> > time in a very long time) to boot into my system. I likely should have
> > just pulled the power...
> >
> > [1147997.255020] INFO: task happywriter:3425205 blocked for more than
> > 120 seconds.
> > [1147997.255088]       Not tainted 5.19.0-38-generic #39~22.04.1-Ubuntu
>
> This is a distro-specific kernel, sorry, nothing to do with our releases
> as the 5.19 kernel branch is long end-of-life.  Please work with your
> distro for this issue if you wish to stick to this kernel version.
>
> good luck!
>
> greg k-h
