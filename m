Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 049DF2F953
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2019 11:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfE3JXH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 May 2019 05:23:07 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:56286 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfE3JXG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 May 2019 05:23:06 -0400
Received: by mail-it1-f195.google.com with SMTP id g24so8733071iti.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2019 02:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a+5aEhVutop7tTeywzU7pWYUCUGkPUoyIEB0oJC3s4w=;
        b=X2KxT+ZWbhdBIXQIbPAxqr3e7c2pnXc5lo5pEwP58+veIa2y/EfnZ7yFBLnq13R/QM
         EPynTGlLEeMAKOg3EH91ZeTSSRzmoyMHy7AOQ0yFNmgNJpiF0MPqx3v1E3D5FkB4ZNAd
         A2D98ATFoOu3bq5VDVvNp46ULKYcwlIUX8SvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a+5aEhVutop7tTeywzU7pWYUCUGkPUoyIEB0oJC3s4w=;
        b=qT4A5oPBY0MC3Vi1sltBoeKzdlfEhIVmvzGIB/U0p4PtnMwqQ8ibVRya8Sbm++bXz+
         OeCNLtbBOTQdaClFkHhszrLci42hfa2GmE6N7zFlYy/vvwJ/Q+gfpxDsekwbfT3aV7Yj
         3LD5DDvDFY3kACh62P+jwKJ9xu7aVnKP6bOMB6c9NZK+720poVYZJp50U4KH/Qbb2RbS
         x37vbqE09m4WvNw11zWO9z+hahDGYyD2ki5UxvFpPDU1vN8JW1j/Z7NUdTQJdQvLXsMg
         12UDhyAv/GB8CdvEpJr3tzFTLf5oqP0uXJD4+MKeoGpf73f+CHpqe8ok6B9bALTPKasb
         RM+A==
X-Gm-Message-State: APjAAAXZnLHGmp/g+e5cXGc8b2bzWHnQzp5USzBYxu1rkqOSMGQKAMsh
        Ihe3n1C/mm7/k8qEO8amwS32Nn5wWpRs1fzaTAJN+A==
X-Google-Smtp-Source: APXvYqxGtgaxGvZRnxZZeT7U0mE9T7MAFKM92+yT+LMximCAZ/y+JjinSYPIBOIjEaFSaGKNREat1XifEPO8Sd6x50A=
X-Received: by 2002:a24:1acc:: with SMTP id 195mr1367036iti.118.1559208185554;
 Thu, 30 May 2019 02:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190502040331.81196-1-ezemtsov@google.com> <CAOQ4uxhmDjYY5_UVWYAWXPtD1jFh3H5Bqn1qn6Fam0KZZjyprw@mail.gmail.com>
 <20190502131034.GA25007@mit.edu> <20190502132623.GU23075@ZenIV.linux.org.uk>
 <CAK8JDrFZW1jwOmhq+YVDPJi9jWWrCRkwpqQ085EouVSyzw-1cg@mail.gmail.com>
 <CAOQ4uxhDYvBOLBkyYXRC6aS_me+Q=1sBAtzOSkdqbo+N-Rtx=Q@mail.gmail.com>
 <CAK8JDrGRzA+yphpuX+GQ0syRwF_p2Fora+roGCnYqB5E1eOmXA@mail.gmail.com>
 <CAOQ4uxjbVxnubaPjVaGYiSwoGDTdpWbB=w_AeM6YM=zVixsUfQ@mail.gmail.com>
 <CAK8JDrEQnXTcCtAPkb+S4r4hORiKh_yX=0A0A=LYSVKUo_n4OA@mail.gmail.com>
 <CAJeUaNCvr=X-cc+B3rsunKcdC6yHSGGa4G+8X+n8OxGKHeE3zQ@mail.gmail.com>
 <CAJfpegvmFJ63F2h_gFVPJeEgWS8UmxAYCUgA-4=j9iCNXaXARA@mail.gmail.com>
 <CAJeUaNC5rXuNsoKmJjJN74iH9YNp94L450gcpxyc_dG=D8CCjA@mail.gmail.com>
 <CAJfpegs=4jMo20Wp8NEjREQpqYjqJ22vc680w1E-w6o-dU1brg@mail.gmail.com> <CAJeUaNBn0gA6eApgOu=n2uoy+6PbOR_xjTdVvc+StvOKGA-i=Q@mail.gmail.com>
In-Reply-To: <CAJeUaNBn0gA6eApgOu=n2uoy+6PbOR_xjTdVvc+StvOKGA-i=Q@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 30 May 2019 11:22:54 +0200
Message-ID: <CAJfpeguys2P9q5EpE3GzKHcOS9GVLO9Fj9HB3JBLw36eax+NkQ@mail.gmail.com>
Subject: Re: Initial patches for Incremental FS
To:     Yurii Zubrytskyi <zyy@google.com>
Cc:     Eugene Zemtsov <ezemtsov@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 29, 2019 at 11:06 PM Yurii Zubrytskyi <zyy@google.com> wrote:

> Yes, and this was _exactly_ our first plan, and it mitigates the read
> performance
> issue. The reasons why we didn't move forward with it are that we figured out
> all other requirements, and fixing each of those needs another change in
> FUSE, up to the level when FUSE interface becomes 50% dedicated to
> our specific goal:
> 1. MAP message would have to support data compression (with different
> algorithms), hash verification (same thing) with hash streaming (because
> even the Merkle tree for a 5GB file is huge, and can't be preloaded
> at once)

With the proposed FUSE solution the following sequences would occur:

kernel: if index for given block is missing, send MAP message
  userspace: if data/hash is missing for given block then download data/hash
  userspace: send MAP reply
kernel: decompress data and verify hash based on index

The kernel would not be involved in either streaming data or hash, it
would only work with data/hash that has already been downloaded.
Right?

Or is your implementation doing streamed decompress/hash or partial blocks?

>   1.1. Mapping memory usage can get out of hands pretty quickly: it has to
> be at least (offset + size + compression type + hash location + hash size +
> hash kind) per each block. I'm not even thinking about multiple storage files
> here. For that 5GB file (that's a debug APK for some Android game we're
> targeting) we have 1.3M blocks, so ~16 bytes *1.3M = 20M of index only,
> without actual overhead for the lookup table.
> If the kernel code owns and manages its own on-disk data store and the
> format, this index can be loaded and discarded on demand there.

Why does the kernel have to know the on-disk format to be able to load
and discard parts of the index on-demand?  It only needs to know which
blocks were accessed recently and which not so recently.

> > There's also work currently ongoing in optimizing the overhead of
> > userspace roundtrip.  The most promising thing appears to be matching
> > up the CPU for the userspace server with that of the task doing the
> > request.  This can apparently result in  60-500% speed improvement.
>
> That sounds almost too good to be true, and will be really cool.
> Do you have any patches or git remote available in any compilable state to
> try the optimization out? Android has quite complicated hardware config
> and I want to see how this works, especially with our model where
> several processes may send requests into the same filesystem FD.

Currently it's only a bunch of hacks, no proper interfaces yet.

I'll let you know once there's something useful for testing with a
real filesystem.

BTW, which interface does your fuse filesystem use?  Libfuse?  Raw device?

Thanks,
Miklos
