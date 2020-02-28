Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBAE173CCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 17:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgB1QYf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 11:24:35 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:38488 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgB1QYf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:24:35 -0500
Received: by mail-io1-f67.google.com with SMTP id s24so4026966iog.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2020 08:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bB98tLoF0u0YAiQkQFd8a6MwFlRbdwFA2a9rJyqMwcU=;
        b=inr1/qyOInYmFN6D425GzWVmy0IT7QRJk3SjPLoFYSH/pO1voh/EdW+SfD8OofD6Bn
         wvNaWCaLKbDpnb6pOCFOt0X9wayPiilDqg7EASARHhnxnaUyVoJrs35dzHFojcJnpWDF
         dEnNQkAT4yoK8tzeRd9BPUclNV9H8sVGfsSfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bB98tLoF0u0YAiQkQFd8a6MwFlRbdwFA2a9rJyqMwcU=;
        b=ShgHsNcFhaDHl7O8ERdrs1Kbv5mqmnZy5HskwsTd3i3E3uE6uM4xusG3EItytn7Nff
         kAKKRXoqRNswQ/lcFDSsVg0nzbR7BeV3sBZbs9eAc0zv7i9NaUJ3ea/qspmkqk28sFu6
         I6jHmQhLAFbcLZ4qGzHpOYYW48As2wRd1tBGkolZ63StY32tcjIkEI03496ZZLMbUZdm
         dyah6kIJbDnLDI+a4VcD1jGQRi55tw659CV60BQ+3i0iTUzmlY7AS7IiwLccWr7pGCvG
         ZN+UZj1lWm1nYfW3VOBxL9yxS/Nc5N1lwL55s7/GvGKwgibsdCiYEYlSRe9+/gfZrkn0
         V1Jg==
X-Gm-Message-State: APjAAAWifLJlqKgbL/s18BZOUcxMkap+/+XhQ+lCjf9YkZSSOnk8Po/k
        1nfUPln8moIZWVlwCqqwDRTGbZHzz6SKYY/3nyWqZQ==
X-Google-Smtp-Source: APXvYqzW4AhONnArihOqANfWi8suDYP+nTtZwmEhAQutobth5sBaSR8sSuEmoVmIoU8B7DsyWsdjOGmol0a5XteeUNc=
X-Received: by 2002:a02:9988:: with SMTP id a8mr4117936jal.33.1582907074679;
 Fri, 28 Feb 2020 08:24:34 -0800 (PST)
MIME-Version: 1.0
References: <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com>
 <1582644535.3361.8.camel@HansenPartnership.com> <CAOssrKfaxnHswrKejedFzmYTbYivJ++cPes4c91+BJDfgH4xJA@mail.gmail.com>
 <1c8db4e2b707f958316941d8edd2073ee7e7b22c.camel@themaw.net>
 <CAJfpegtRoXnPm5_sMYPL2L6FCZU52Tn8wk7NcW-dm4_2x=dD3Q@mail.gmail.com>
 <3e656465c427487e4ea14151b77d391d52cd6bad.camel@themaw.net>
 <CAJfpegu5xLcR=QbAOnUrL49QTem6X6ok7nPU+kLFnNHdPXSh1A@mail.gmail.com>
 <20200227151421.3u74ijhqt6ekbiss@ws.net.home> <ba2b44cc1382c62be3ac896a5476c8e1dc7c0230.camel@themaw.net>
 <CAJfpeguXPmw+PfZJFOscGLm0oe7dUQY4CYXazx9=x020Fbe86A@mail.gmail.com> <20200228122712.GA3013026@kroah.com>
In-Reply-To: <20200228122712.GA3013026@kroah.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 28 Feb 2020 17:24:23 +0100
Message-ID: <CAJfpegsGgjnyZiB+ionfnnk+_e+5oaC-5nmGq+mLxWs1RcwsPw@mail.gmail.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ian Kent <raven@themaw.net>, Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        David Howells <dhowells@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Lennart Poettering <lennart@poettering.net>,
        =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>,
        util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 28, 2020 at 1:27 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:

> > Superblocks and mounts could get enumerated by a unique identifier.
> > mnt_id seems to be good for mounts, s_dev may or may not be good for
> > superblock, but  s_id (as introduced in this patchset) could be used
> > instead.
>
> So what would the sysfs tree look like with this?

For a start something like this:

mounts/$MOUNT_ID/
  parent -> ../$PARENT_ID
  super -> ../../supers/$SUPER_ID
  root: path from mount root to fs root (could be optional as usually
they are the same)
  mountpoint -> $MOUNTPOINT
  flags: mount flags
  propagation: mount propagation
  children/$CHILD_ID -> ../../$CHILD_ID

 supers/$SUPER_ID/
   type: fstype
   source: mount source (devname)
   options: csv of mount options

Thanks,
Miklos
