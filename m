Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73B6F13D7BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 11:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732351AbgAPKPy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 05:15:54 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40086 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729476AbgAPKPx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 05:15:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so3120000wmi.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2020 02:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=q6qXzTqIJXI64+JQqXYlDYTi5mdBUYPQrfX4biDQEjQ=;
        b=evrBXHeAGMbjg8kWLuzpLAV6mTeoy9z3z9id3PZ+5PuDikzd3fV4MdM+WT+6WzZiSr
         o0L0TYGXvqotq/P+OKyHcfmCAMhDRHmpatfAMdtCQvKi+d8iF1OqZRYmH5+U6AH3KEoo
         u9z7mPKc7PvncGC9QGI+miGepSrnNbqbkptXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=q6qXzTqIJXI64+JQqXYlDYTi5mdBUYPQrfX4biDQEjQ=;
        b=KfXFaW/ULOGIAnlJRjvGsY3InHWVMZzHiYA2sIv9pssCkx50tQARRGIm/uqcCNGF1l
         AdkCGwt+uEJmDFiWYZQjrHcrR6G2NN1nqjUuKtLf11trJ2ezrRp10xX402p+oxnctJjo
         GASlvQr2FuE+r/lP5pRau0a0DGAX8YrlXxkVzk6nVEpGf2xaaTRg0YnSV+rXWohYsdKU
         bAl/IsofU+Qr249FsTFWYiZVsdoupwz2k6yqXo8V2QgK5aDHZQK/cbEULwmdg5GLEO/F
         WDjXSa4fT1Lrsa0P9gei//vvtA/kU3km5y4yMFiwcKXmf9tXJN6aOSJUCTudYGpzrH+p
         jNKA==
X-Gm-Message-State: APjAAAUSvlWkMcaPN2lmvdspUVw5tgwfckoeeQEMKt16NpoBUNWvI7FD
        IW9ME4vbpk/YI7JiB96LE964lN3Y4PgPcQ==
X-Google-Smtp-Source: APXvYqyJWfd29yA/ZDyMSeNHrj+Ym36qg4A0Nx2mrTambpA01c7bWMHN2pa/qpreV7JvkMxWS7DxFA==
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr5167495wmc.168.1579169751579;
        Thu, 16 Jan 2020 02:15:51 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (94-21-106-198.pool.digikabel.hu. [94.21.106.198])
        by smtp.gmail.com with ESMTPSA id t12sm28310970wrs.96.2020.01.16.02.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 02:15:51 -0800 (PST)
Date:   Thu, 16 Jan 2020 11:15:45 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Ondrej Holy <oholy@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: Weird fuse_operations.read calls with Linux 5.4
Message-ID: <20200116101545.GA28605@miu.piliscsaba.redhat.com>
References: <CA+wuGHCr2zJKFkHyRECOLAXsijLAcQgHVoACcNbvLbXnqarOtg@mail.gmail.com>
 <CAJfpegsECDNeL0FmaB=BsYdYrmZSLpG5etvwhW5uQWGJJjODeg@mail.gmail.com>
 <CA+wuGHBV=YH5-bnNZvZSMzB+Tt0VyuEKFUZV8d_Htptxp3=_eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+wuGHBV=YH5-bnNZvZSMzB+Tt0VyuEKFUZV8d_Htptxp3=_eQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 01:24:52PM +0100, Ondrej Holy wrote:
> st 15. 1. 2020 v 12:41 odesílatel Miklos Szeredi <miklos@szeredi.hu> napsal:
> >
> > On Wed, Jan 15, 2020 at 9:28 AM Ondrej Holy <oholy@redhat.com> wrote:
> > >
> > > Hi,
> > >
> > > I have been directed here from https://github.com/libfuse/libfuse/issues/488.
> > >
> > > My issue is that with Linux Kernel 5.4, one read kernel call (e.g.
> > > made by cat tool) triggers two fuse_operations.read executions and in
> > > both cases with 0 offset even though that first read successfully
> > > returned some bytes.
> > >
> > > For gvfs, it leads to redundant I/O operations, or to "Operation not
> > > supported" errors if seeking is not supported. This doesn't happen
> > > with Linux 5.3. Any idea what is wrong here?
> > >
> > > $ strace cat /run/user/1000/gvfs/ftp\:host\=server\,user\=user/foo
> > > ...
> > > openat(AT_FDCWD, "/run/user/1000/gvfs/ftp:host=server,user=user/foo",
> >
> > Hi, I'm trying to reproduce this on fedora30, but even failing to get
> > that "cat" to work.  I've  replaced "server" with a public ftp server,
> > but it's not even getting to the ftp backend.  Is there a trick to
> > enable the ftp backend?  Haven't found the answer by googling...
> 
> Hi Miklos,
> 
> you need gvfs and gvfs-fuse packages installed. Then it should be
> enough to mount some share, e.g. over Nautilus, or using just "gio
> mount ftp://user@server/". Once some share is mounted, then you should
> see it in /run/user/$UID/gvfs. I can reproduce on Fedora 31 with
> kernel-5.4.10-200.fc31.x86_64, whereas kernel-5.3.16-300.fc31.x86_64
> works without any issues.

Thanks, I was missing the "gio mount ..." command.

Here's a patch that should fix it.  Will go into 5.5-rc7 and will be backported
to 5.4.x stable series.

Thanks,
Miklos

---
From: Miklos Szeredi <mszeredi@redhat.com>
Subject: fuse: fix fuse_send_readpages() in the syncronous read case

Buffered read in fuse normally goes via:

 -> generic_file_buffered_read()
   -> fuse_readpages()
     -> fuse_send_readpages()
       ->fuse_simple_request() [called since v5.4]

In the case of a read request, fuse_simple_request() will return a
non-negative bytecount on success or a negative error value.  A positive
bytecount was taken to be an error and the PG_error flag set on the page.
This resulted in generic_file_buffered_read() falling back to ->readpage(),
which would repeat the read request and succeed.  Because of the repeated
read succeeding the bug was not detected with regression tests or other use
cases.

The FTP module in GVFS however fails the second read due to the
non-seekable nature of FTP downloads.

Fix by checking and ignoring positive return value from
fuse_simple_request().

Reported-by: Ondrej Holy <oholy@redhat.com>
Link: https://gitlab.gnome.org/GNOME/gvfs/issues/441
Fixes: 134831e36bbd ("fuse: convert readpages to simple api")
Cc: <stable@vger.kernel.org> # v5.4
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/file.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -882,6 +882,7 @@ static void fuse_send_readpages(struct f
 	struct fuse_args_pages *ap = &ia->ap;
 	loff_t pos = page_offset(ap->pages[0]);
 	size_t count = ap->num_pages << PAGE_SHIFT;
+	ssize_t res;
 	int err;
 
 	ap->args.out_pages = true;
@@ -896,7 +897,8 @@ static void fuse_send_readpages(struct f
 		if (!err)
 			return;
 	} else {
-		err = fuse_simple_request(fc, &ap->args);
+		res = fuse_simple_request(fc, &ap->args);
+		err = res < 0 ? res : 0;
 	}
 	fuse_readpages_end(fc, &ap->args, err);
 }
