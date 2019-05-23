Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63FA527530
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 06:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbfEWEZd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 00:25:33 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53270 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfEWEZd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 00:25:33 -0400
Received: by mail-it1-f193.google.com with SMTP id m141so7449108ita.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2019 21:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RPKik6HmIGmg8hObsFgp5iJFVVMnEU4PUKI7gQr54gc=;
        b=RN28E7D3coVAl0eUUzAv2e2sXZxi40ZTq+J3moDkhTkcq8ROMYSlyLT/WFl5QfdIu0
         YdINrsdWB6zg6+3d7YcNgtV+yZfmKtDZiABXpgfVHPedrPE/jfUYb001O1WFjwc4jinW
         ZHR301IB9nzZUDKu29WXPyEYwBRKmcml2H9FI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RPKik6HmIGmg8hObsFgp5iJFVVMnEU4PUKI7gQr54gc=;
        b=AiCTH27jfyS1VPlQI17lvwPpe40GN4vX+yMhND1VeOuTyslqYbB9eDeh1X6nd2ZO3J
         fjoNUPmmlGSLmRwu6yDsCxO8hsLUkIm7xh4cvzlGdnhWyLx5DICdfjp8uDOUQaX/gnc0
         mX5zcY+zhr3hVcudb+eZ0UerfhgB2E/6e921xn6/wft4DEvTre/ViJmDooGzoSzn4iBQ
         dcSfdQ0iC44X2k9BOVEbkM+cvz+94Wm7Zpv9Q9RNnTlii/sOZt79U0K+OKZ3c+8CVny+
         F+Vxj0WntKrELdxlhbpOpGtm0Qh+xj/A6IYk8YSlx87MxLtOurFS41dCUn2g2zKtPtLi
         iLsw==
X-Gm-Message-State: APjAAAWnr02+tWJuhWqWyE621TqoVEzc45vQwfAtlEiJkBq7346uqYMj
        GUAlirIquqFCjbXvjwdgBTyBKpV6cp7tbXkOsW85yw==
X-Google-Smtp-Source: APXvYqzNgzfllSbqeNItwfTQqpnfIDbUbhgociSm/lTY0454s3TQLER3zxB273vVJk+wn0Ea6nmgn+C13/oAZRHBn9I=
X-Received: by 2002:a02:7f96:: with SMTP id r144mr21920294jac.77.1558585532395;
 Wed, 22 May 2019 21:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190502040331.81196-1-ezemtsov@google.com> <CAOQ4uxhmDjYY5_UVWYAWXPtD1jFh3H5Bqn1qn6Fam0KZZjyprw@mail.gmail.com>
 <20190502131034.GA25007@mit.edu> <20190502132623.GU23075@ZenIV.linux.org.uk>
 <CAK8JDrFZW1jwOmhq+YVDPJi9jWWrCRkwpqQ085EouVSyzw-1cg@mail.gmail.com>
 <CAOQ4uxhDYvBOLBkyYXRC6aS_me+Q=1sBAtzOSkdqbo+N-Rtx=Q@mail.gmail.com>
 <CAK8JDrGRzA+yphpuX+GQ0syRwF_p2Fora+roGCnYqB5E1eOmXA@mail.gmail.com>
 <CAOQ4uxjbVxnubaPjVaGYiSwoGDTdpWbB=w_AeM6YM=zVixsUfQ@mail.gmail.com>
 <CAK8JDrEQnXTcCtAPkb+S4r4hORiKh_yX=0A0A=LYSVKUo_n4OA@mail.gmail.com>
 <CAJeUaNCvr=X-cc+B3rsunKcdC6yHSGGa4G+8X+n8OxGKHeE3zQ@mail.gmail.com>
 <CAJfpegvmFJ63F2h_gFVPJeEgWS8UmxAYCUgA-4=j9iCNXaXARA@mail.gmail.com> <CAJeUaNC5rXuNsoKmJjJN74iH9YNp94L450gcpxyc_dG=D8CCjA@mail.gmail.com>
In-Reply-To: <CAJeUaNC5rXuNsoKmJjJN74iH9YNp94L450gcpxyc_dG=D8CCjA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 23 May 2019 06:25:21 +0200
Message-ID: <CAJfpegs=4jMo20Wp8NEjREQpqYjqJ22vc680w1E-w6o-dU1brg@mail.gmail.com>
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

On Wed, May 22, 2019 at 7:25 PM Yurii Zubrytskyi <zyy@google.com> wrote:
>
> > Hang on, fuse does use caches in the kernel (page cache,
> > dcache/icache).  The issue is probably not lack of cache, it's how the
> > caches are primed and used.  Did you disable these caches?  Did you
> > not disable invalidation for data, metadata and dcache?  In recent
> > kernels we added caching readdir as well.  The only objects not cached
> > are (non-acl) xattrs.   Do you have those?
> Android (which is our primary use case) is constantly under memory
> pressure, so caches
> don't actually last long. Our experience with FOPEN_KEEP_CACHE has
> shown that pages are
> evicted more often than the files are getting reopened, so it doesn't
> help. FUSE has to re-read
> the data from the backing store all the time.

What would benefit many fuse applications is to let the kernel
transfer data to/from a given location (i.e. offset within a file).
So instead of transferring data directly in the READ/WRITE messages,
there would be a MAP message that would return information about where
the data resides (list of extents+extra parameters for
compression/encryption).  The returned information could be generic
enough for your needs, I think.  The fuse kernel module would cache
this mapping, and could keep the mapping around for possibly much
longer than the data itself, since it would require orders of
magnitude less memory. This would not only be saving memory copies,
but also the number of round trips to userspace.

There's also work currently ongoing in optimizing the overhead of
userspace roundtrip.  The most promising thing appears to be matching
up the CPU for the userspace server with that of the task doing the
request.  This can apparently result in  60-500% speed improvement.

> We didn't use xattrs for the FUSE-based implementation, but ended up
> requiring a similar thing in
> the Incremental FS, so the final design would have to include them.
>
> > Re prefetching data:
> > there's the NOTIFY_STORE message.
> To add to the previous point, we do not have the data for prefetching,
> as we're loading it page-by-page
> from the host. We had to disable readahead for FUSE completely,
> otherwise even USB3 isn't fast enough

Understood.  Did you re-enable readahead for the case when the file
has been fully downloaded?

Thanks,
Miklos
