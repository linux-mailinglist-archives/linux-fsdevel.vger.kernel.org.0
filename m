Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E66A2A92B5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 10:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgKFJ3l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 04:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgKFJ3k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:29:40 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B48C0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2020 01:29:40 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id m184so102749vkb.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2020 01:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cj9aU3bU6Mlez1/jNuR19+XJKdPcL+MH8EXhEAlY4Uo=;
        b=lol22UeLwiMXamApuDJFhU2xmyUymt91OXHzV2LUp33ZXuJpYQgpx6XtX1QJ6WmtCC
         OZYJnZAuJI/irOUzVyzDgJlNyZ7+w+mSX4A3mORO2OG2i9eJqfgqx8LAU5/d0gfnjsHV
         iVMnqrg5+zRNArjxud2hqEv5d2S6/ypVev6HY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cj9aU3bU6Mlez1/jNuR19+XJKdPcL+MH8EXhEAlY4Uo=;
        b=aHFLyVtx/Xoazltwk9Tx9et3JRNHvoKZkRsvQ2NlvFplgquRMsge55olsBZ4HCbWWe
         /c337QIRPfxciISzTVrivK7SGNLOW/cqKjdNsKDXVmEJYgCVNbNvc2hB6q2eltmBgoF0
         6e01NoxPxW9nIfD27+pGc8krxC2Gtp969YY7sGi3zlY5I2FUBIUFqCwPoNyd44Yq2AoP
         xZ/z06hSSwwZPfnli8S8SN0YSInxqjh4gGk4JpsXMI4UpVAjzCaotsHt3vqR7OxU4A6V
         4KwqWCxXBR60PfABqJFJC/xe+31+dZyuA3XwO5hIuZqsfkdOa5ROcmFgaLyhmYE3x7Vk
         LM9Q==
X-Gm-Message-State: AOAM531QnbfZ7LoNBW9nA6pbdoMizB7Rxwi34PalTSkwpxVb9PntZH8e
        Lg+ewrIeVOXkfvH+mLkhs23nNdhgHTZ3TeApYNwH0g==
X-Google-Smtp-Source: ABdhPJwYMBk6DgsNBPwPBzdMrNTso1k3rWC9JOmOv5gtlW3KF8WbhOME+GBbu7AT/j3IwLPruz/DpS+rTdRepgo7JhY=
X-Received: by 2002:ac5:c80e:: with SMTP id y14mr426190vkl.3.1604654979446;
 Fri, 06 Nov 2020 01:29:39 -0800 (PST)
MIME-Version: 1.0
References: <c4cb4b41655bc890b9dbf40bd2c133cbcbef734d.camel@redhat.com>
 <89f0dbf6713ebd44ec519425e3a947e71f7aed55.camel@redhat.com>
 <CAJfpegv4jLewQ4G_GdxraTE8fGHy7-d52gPSi4ZAOp0N4aYJnw@mail.gmail.com> <77529e99ca9c2d228a67dd8d789d83afdcd1ace3.camel@redhat.com>
In-Reply-To: <77529e99ca9c2d228a67dd8d789d83afdcd1ace3.camel@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 6 Nov 2020 10:29:28 +0100
Message-ID: <CAJfpegsuYAW+W7xN3QGdfzEHROdMhVOJS5K=u8JQe-_WaY8VsA@mail.gmail.com>
Subject: Re: WARN_ON(fuse_insert_writeback(root, wpa)) in tree_insert()
To:     Qian Cai <cai@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 2, 2020 at 3:26 PM Qian Cai <cai@redhat.com> wrote:
>
> On Thu, 2020-10-29 at 16:20 +0100, Miklos Szeredi wrote:
> > On Thu, Oct 29, 2020 at 4:02 PM Qian Cai <cai@redhat.com> wrote:
> > > On Wed, 2020-10-07 at 16:08 -0400, Qian Cai wrote:
> > > > Running some fuzzing by a unprivileged user on virtiofs could trigger the
> > > > warning below. The warning was introduced not long ago by the commit
> > > > c146024ec44c ("fuse: fix warning in tree_insert() and clean up writepage
> > > > insertion").
> > > >
> > > > From the logs, the last piece of the fuzzing code is:
> > > >
> > > > fgetxattr(fd=426, name=0x7f39a69af000, value=0x7f39a8abf000, size=1)
> > >
> > > I can still reproduce it on today's linux-next. Any idea on how to debug it
> > > further?
> >
> > Can you please try the attached patch?
>
> It has survived the testing over the weekend. There is a issue that virtiofsd
> hung, but it looks like a separate issue.

Thanks very much for the testing.   Queued up the patch.

Miklos
