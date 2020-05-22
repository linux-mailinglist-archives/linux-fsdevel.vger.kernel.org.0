Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774D41DE3AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 12:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgEVKF7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 06:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbgEVKF6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 06:05:58 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99510C08C5C0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 03:05:57 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id h16so8886235eds.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 03:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DtZfx2mo8Milc18ngyMfW1PIcYKBj/EvVpvJqR76B+Y=;
        b=jw5fHtL/RIM8xz3E7sdN0sc8voc91MwoIIXai4ooDW3LkOeQGwMZMR5x4k7IoykRVw
         nceGbEdL8kBLjrHQGcoqPbP3QWGcrvwJlGepODGT+tTiexRgI7/fxoU9Dg/0t/nOj0Ax
         W8a0S8U1i4xN8yv0ngkz1Mjhi30imTAiGDmW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DtZfx2mo8Milc18ngyMfW1PIcYKBj/EvVpvJqR76B+Y=;
        b=MSsM7ykvXWH6+0NcaRRAQauyTDZtrMXH+gEPGgm/hPOW9NsuSL5nOX9ZZxscoIUCAa
         lfQO8OChYgtIQGZ7q2uzZ2OvptadcKFljaZ00hg9H4NVkJfmOUEyOm1WMAVTwi6wdSfk
         iUf7HRnqJFsb+621xia0+Y5XAu/y8ko+LhmWgherhNyIOiSOWBNm1l25CeUHJo6JGm46
         tlZyzjUB+Sl+QusohVV9VqlFOR6AAiHryTE5P8yQtj32Y60kFjbd22orVDwRHYqLTBEg
         63pj6zcpSVe1OyLdNquT7iqeVfco90FVeZzRpSE0bl9rfOzvQbVu1V9vs60IHCywSBPT
         8v0A==
X-Gm-Message-State: AOAM533+Hu7J+sS+9Net/jO+wJr/Wi1W0Yzv776az2zSNEhgMSVjNw1/
        nMPhaAx01hLc3fYOTuHSaNT/wg==
X-Google-Smtp-Source: ABdhPJxesQBnmboD62I4SZU4WGLsBVnkI5YIilNVuotJbFhyVWl5+N/8HBerDSceQ46v2AtGVAVygQ==
X-Received: by 2002:a50:dac4:: with SMTP id s4mr2416371edj.84.1590141956086;
        Fri, 22 May 2020 03:05:56 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id s17sm7132537edr.84.2020.05.22.03.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 03:05:55 -0700 (PDT)
Date:   Fri, 22 May 2020 12:05:53 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Colin Walters <walters@verbum.org>,
        syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-unionfs@vger.kernel.org
Subject: Re: kernel BUG at mm/hugetlb.c:LINE!
Message-ID: <20200522100553.GE13131@miu.piliscsaba.redhat.com>
References: <000000000000b4684e05a2968ca6@google.com>
 <aa7812b8-60ae-8578-40db-e71ad766b4d3@oracle.com>
 <CAJfpegtVca6H1JPW00OF-7sCwpomMCo=A2qr5K=9uGKEGjEp3w@mail.gmail.com>
 <bb232cfa-5965-42d0-88cf-46d13f7ebda3@www.fastmail.com>
 <9a56a79a-88ed-9ff4-115e-ec169cba5c0b@oracle.com>
 <CAJfpegsNVB12MQ-Jgbb-f=+i3g0Xy52miT3TmUAYL951HVQS_w@mail.gmail.com>
 <78313ae9-8596-9cbe-f648-3152660be9b3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78313ae9-8596-9cbe-f648-3152660be9b3@oracle.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 20, 2020 at 10:27:15AM -0700, Mike Kravetz wrote:

> I am fairly confident it is all about checking limits and alignment.  The
> filesystem knows if it can/should align to base or huge page size. DAX has
> some interesting additional restrictions, and several 'traditional' filesystems
> check if they are 'on DAX'.


Okay, I haven't looked at DAX vs. overlay.  I'm sure it's going to come up at
some point, if it hasn't already.

> 
> In a previous e-mail, you suggested hugetlb_get_unmapped_area could do the
> length adjustment in hugetlb_get_unmapped_area (generic and arch specific).
> I agree, although there may be the need to add length overflow checks in
> these routines (after round up) as this is done in core code now.  However,
> this can be done as a separate cleanup patch.
> 
> In any case, we need to get the core mmap code to call filesystem specific
> get_unmapped_area if on a union/overlay.  The patch I suggested does this
> by simply calling real_file to determine if there is a filesystem specific
> get_unmapped_area.  The other approach would be to provide an overlayfs
> get_unmapped_area that calls the underlying filesystem get_unmapped_area.

That latter is what's done for all other stacked operations in overlayfs.

Untested patch below.

Thanks,
Miklos

---
 fs/overlayfs/file.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -757,6 +757,17 @@ static loff_t ovl_remap_file_range(struc
 			    remap_flags, op);
 }
 
+static unsigned long ovl_get_unmapped_area(struct file *file,
+				unsigned long uaddr, unsigned long len,
+				unsigned long pgoff, unsigned long flags)
+{
+	struct file *realfile = file->private_data;
+
+	return (realfile->f_op->get_unmapped_area ?:
+		current->mm->get_unmapped_area)(realfile,
+						uaddr, len, pgoff, flags);
+}
+
 const struct file_operations ovl_file_operations = {
 	.open		= ovl_open,
 	.release	= ovl_release,
@@ -774,6 +785,7 @@ const struct file_operations ovl_file_op
 
 	.copy_file_range	= ovl_copy_file_range,
 	.remap_file_range	= ovl_remap_file_range,
+	.get_unmapped_area	= ovl_get_unmapped_area,
 };
 
 int __init ovl_aio_request_cache_init(void)
