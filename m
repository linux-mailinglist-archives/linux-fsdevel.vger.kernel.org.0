Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33118544E8E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 16:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242702AbiFIOSU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 10:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240678AbiFIOST (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:18:19 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B903B19EC3A
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jun 2022 07:18:17 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gl15so33918294ejb.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jun 2022 07:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sNzp4C1qM++RQ4FACeqwrrFOyAhv2Px7Z9Ri7JftW5Y=;
        b=b1m7OM5cqbcrqgtd/AKpeRcEYIWgPXr4ZkZF2pDpl/Wc1nENLtFZD7U+ojI+k8KWLS
         qEdGMp0E6B7xv833pvQP/n/yuZGAzzvcJGZEviFiTmxMC+hufZQgmqTSHuBGcVkaThKk
         sVJRu1zegkRmnyoc7yr31tikQKp6mN/w+U1FEHHByARLaT8QHE29klgHPpofkIGLaiHh
         hVEnVDRTohnYjcA/BKHx/3hFZMNmkuakFCiEllMXaR8HIjyztn4b/D+TX1b2QGC8FFtM
         dPHBK5prRBuuYan+nHwZagtszr4i+QjgEb+qOw1FEp+0ILQuzcgt/Q90K/y8K1RNKPi+
         C0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sNzp4C1qM++RQ4FACeqwrrFOyAhv2Px7Z9Ri7JftW5Y=;
        b=ajaSHfsN9h+snku5pp4sR50N5No/1QZ4ifAuCjAPMoM6vLfc6s/EmUVkximoWcxGsA
         xKlnBEGVUSq2653jg6LWRmLoNhapq4e8F2VnUfBV6h1O/PGNp88oRFIMg6HA6vI0xx1y
         baMGoOIn+06QtYb0ybZYsUKCghNLM5Sa5Y+gnjE5EqqQ968GDJ840k0rf55YTUa0j0xW
         Jlw0e+vamRhHoFJzHSOgX9z7k5CkZnVSstXhpE3Z39fSTYDyy0s90kWXVGhbS2Uhog+0
         rt0n8HDTfJiCLpgAu7yfyV5IPAxxs/NPCo7MCASF0i9ZkURbow95U0YyqiRMaRM+lVv6
         2yUA==
X-Gm-Message-State: AOAM533aDJtwG/AR2iJe538DM/2EGhcLH9TcPDrAH/zg5Opy9EWCIpvM
        QumLvuCz8Zh2HKFy4wmnOkyw2j3iYSD8PxJMD+S9
X-Google-Smtp-Source: ABdhPJw+RbjQz26spFvlqGhAjCnSEPPDW6WbKTY4YrAvbsUZuid1qv6lRSFQOVkFxVDnMbfNblWgtr8G/Z6rfKJWNYU=
X-Received: by 2002:a17:907:9805:b0:710:858f:ae0d with SMTP id
 ji5-20020a170907980500b00710858fae0dmr16201722ejc.360.1654784296284; Thu, 09
 Jun 2022 07:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220607110504.198-1-xieyongji@bytedance.com> <Yp+oEPGnisNx+Nzo@redhat.com>
 <CACycT3vKZJ4YhPgGq1VFeh3Tqnr-vK3X+rPz0rObH=MraxrhYA@mail.gmail.com>
 <YqCZt7tyEH50ktKq@redhat.com> <CACycT3sMe8EdBWxZhT0HTwVB7mGPk=eV3jG-8EkNK+W-Y_RAiw@mail.gmail.com>
 <YqH2GofHjS4nkWpQ@redhat.com>
In-Reply-To: <YqH2GofHjS4nkWpQ@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Thu, 9 Jun 2022 22:19:13 +0800
Message-ID: <CACycT3uOX97VxQ6v9rGJz=HDwFNi_-9=7pAp6Z1-mrC9m1x4yg@mail.gmail.com>
Subject: Re: [PATCH] fuse: allow skipping abort interface for virtiofs
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        =?UTF-8?B?5byg5L2z6L6w?= <zhangjiachen.jaycee@bytedance.com>,
        linux-fsdevel@vger.kernel.org,
        virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 9, 2022 at 9:31 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Jun 08, 2022 at 09:57:51PM +0800, Yongji Xie wrote:
> > On Wed, Jun 8, 2022 at 8:44 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Wed, Jun 08, 2022 at 04:42:46PM +0800, Yongji Xie wrote:
> > > > On Wed, Jun 8, 2022 at 3:34 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > >
> > > > > On Tue, Jun 07, 2022 at 07:05:04PM +0800, Xie Yongji wrote:
> > > > > > The commit 15c8e72e88e0 ("fuse: allow skipping control
> > > > > > interface and forced unmount") tries to remove the control
> > > > > > interface for virtio-fs since it does not support aborting
> > > > > > requests which are being processed. But it doesn't work now.
> > > > >
> > > > > Aha.., so "no_control" basically has no effect? I was looking at
> > > > > the code and did not find anybody using "no_control" and I was
> > > > > wondering who is making use of "no_control" variable.
> > > > >
> > > > > I mounted virtiofs and noticed a directory named "40" showed up
> > > > > under /sys/fs/fuse/connections/. That must be belonging to
> > > > > virtiofs instance, I am assuming.
> > > > >
> > > >
> > > > I think so.
> > > >
> > > > > BTW, if there are multiple fuse connections, how will one figure
> > > > > out which directory belongs to which instance. Because without knowing
> > > > > that, one will be shooting in dark while trying to read/write any
> > > > > of the control files.
> > > > >
> > > >
> > > > We can use "stat $mountpoint" to get the device minor ID which is the
> > > > name of the corresponding control directory.
> > > >
> > > > > So I think a separate patch should be sent which just gets rid of
> > > > > "no_control" saying nobody uses. it.
> > > > >
> > > >
> > > > OK.
> > > >
> > > > > >
> > > > > > This commit fixes the bug, but only remove the abort interface
> > > > > > instead since other interfaces should be useful.
> > > > >
> > > > > Hmm.., so writing to "abort" file is bad as it ultimately does.
> > > > >
> > > > > fc->connected = 0;
> > > > >
> > > >
> > > > Another problem is that it might trigger UAF since
> > > > virtio_fs_request_complete() doesn't know the requests are aborted.
> > > >
> > > > > So getting rid of this file till we support aborting the pending
> > > > > requests properly, makes sense.
> > > > >
> > > > > I think this probably should be a separate patch which explains
> > > > > why adding "no_abort_control" is a good idea.
> > > > >
> > > >
> > > > OK.
> > >
> > > BTW, which particular knob you are finding useful in control filesystem
> > > for virtiofs. As you mentioned "abort" we will not implement. "waiting"
> > > might not have much significance as well because requests are handed
> > > over to virtiofs immidiately and if they can be sent to server (because
> > > virtqueue is full) these are queued internally and fuse layer will not
> > > have an idea.
> > >
> >
> > Couldn't it be used to check the inflight I/O for virtiofs?
>
> Actually I might be wrong. It probably should work. Looking at
> implementation.
>
> fuse_conn_waiting_read() looks at fc->num_waiting to figure out
> how many requests are in flight.
>
> And either fuse_get_req()/fuse_simple_request() will bump up the
> fc->num_request count and fuse_put_request() will drop that count
> once request completes. And this seems to be independent of
> virtiofs.
>
> So looks like it should work even with virtiofs. Please give it a try.
>

OK.

> >
> > > That leaves us with "congestion_threshold" and "max_background".
> > > max_background seems to control how many background requests can be
> > > submitted at a time. That probably can be useful if server is overwhelemed
> > > and we want to slow down the client a bit.
> > >
> > > Not sure about congestion threshold.
> > >
> > > So have you found some knob useful for your use case?
> > >
> >
> > Since it doesn't do harm to the system, I think it would be better to
> > just keep it as it is. Maybe some fuse users can make use of it.
>
> I guess fair enough. I don't mind creating "control" file system for
> virtiofs. Either we don't create "abort" file or may be somehow
> writing to file returns error. I guess both the solutions should
> work.
>

I think so.

Thanks,
Yongji
