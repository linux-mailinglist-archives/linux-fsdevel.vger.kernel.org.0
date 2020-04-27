Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9B91BA54F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 15:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgD0NqX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 09:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgD0NqV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 09:46:21 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E53C0610D5;
        Mon, 27 Apr 2020 06:46:20 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id r2so16691839ilo.6;
        Mon, 27 Apr 2020 06:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IPXAcvXcV2/d9kI79OZTRlGrFnnhZBRTqFBK9NFYYNo=;
        b=ZQ9vgXpuNsftTocxa/gp7w7Z0HBor8F0po5cZ172t1RmqMKsnkmMShjqqnG86eH3hw
         Qn4vCrTz5XhM9B8frrKmP/E17ibTUNT3CFJJmg6/ZVN1TGo02U7TQGjcfhXY7vuu1L7s
         PuaU1W/28Bg2FTMtQMZaYU/rAn7sSIcjnFSMPeTTMH6yG1zLBx7dC9jgI2JeLKfAii2s
         vgOF7qxce8q8n1JUDs2n/GfEDRzgMluH58WhzFAUwdlt/B82iw6WDFtdMe57EqdIvRA2
         mh3y0fY9pV+3+HsbcwDFGsxZMo1Tx5RJfdoFoRZIDlo3DVc7W/5ExoF+IYS+4SWknnJf
         EXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IPXAcvXcV2/d9kI79OZTRlGrFnnhZBRTqFBK9NFYYNo=;
        b=iuxxgcm7tz6VF1ZAYTiPatVsbQfrDczsWDcw9cJGpeXCt7hELViT6M5wxmNvBQQaKP
         t+9+i18UhrLmjZiTq4dvOkCcuuvnPnsZvJe8j1YE4iXd4oyx7moJhfAfWlFPydLcl8at
         NKB1lVUdO0gK/a3CscAsbmt8VEMdw+PsfAlZdA+zbwLJauYpXqGzWLx41Pa62Hp/eiPu
         oJ6gIhofJ3KvaoK2xqvcCvR6njAGOzHteM4T4oT3yWQ8BMpfcPfl/H+NZWHc+2xl93l4
         f7TpUK+TG0ilAEz3IRvC52LyHFqYqM9gUJd2KA3ReqSRis+08rqsobNZrnMTtqBAavnx
         /Jmw==
X-Gm-Message-State: AGi0Pubqu2/Yb3tTcWDt/8DXTKdiGaKsNJaAKeKXcnO3YjIip+qjN52y
        DXBwEddSHTggfIWhiC9KNRQ2B6l3OzWYnlT3kQkmnA==
X-Google-Smtp-Source: APiQypK7D37fKCrZtwyePnZthU9HYU9KSD5Wvh23aJVqiLnBbCT4KflS88nPjzfJLwHo17STaFUE2v8rD2naPgLKPo8=
X-Received: by 2002:a92:d2c1:: with SMTP id w1mr18902521ilg.96.1587995180392;
 Mon, 27 Apr 2020 06:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <1585733475-5222-1-git-send-email-chakragithub@gmail.com>
 <CAJfpegtk=pbLgBzM92tRq8UMUh+vxcDcwLL77iAcv=Mxw3r4Lw@mail.gmail.com> <CAH7=fosGV3AOcU9tG0AK3EJ2yTXZL3KGfsuVUA5gMBjC4Nn-WQ@mail.gmail.com>
In-Reply-To: <CAH7=fosGV3AOcU9tG0AK3EJ2yTXZL3KGfsuVUA5gMBjC4Nn-WQ@mail.gmail.com>
From:   Chakra Divi <chakragithub@gmail.com>
Date:   Mon, 27 Apr 2020 19:16:08 +0530
Message-ID: <CAH7=fosz9KDSBN86+7OxYTLJWUSdUSkeLZR5Y0YyM6=GE0BdOw@mail.gmail.com>
Subject: Re: [PATCH] fuse:rely on fuse_perm for exec when no mode bits set
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 21, 2020 at 4:21 PM Chakra Divi <chakragithub@gmail.com> wrote:
>
> On Mon, Apr 20, 2020 at 4:55 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Wed, Apr 1, 2020 at 11:31 AM Chakra Divi <chakragithub@gmail.com> wrote:
> > >
> > > In current code, for exec we are checking mode bits
> > > for x bit set even though the fuse_perm_getattr returns
> > > success. Changes in this patch avoids mode bit explicit
> > > check, leaves the exec checking to fuse file system
> > > in uspace.
> >
> > Why is this needed?
>
> Thanks for responding Miklos. We have an use case with our remote file
> system mounted on fuse , where permissions checks will happen remotely
> without the need of mode bits. In case of read, write it worked
> without issues. But for executable files, we found that fuse kernel is
> explicitly checking 'x' mode bit set on the file. We want this
> checking also to be pushed to remote instead of kernel doing it - so
> modified the kernel code to send getattr op to usespace in exec case
> too.

Any help on this Miklos....

Thanks,
Chakra
> > Thanks,
> > Miklos
