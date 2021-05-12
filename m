Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A0437C000
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 16:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhELO2h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 10:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhELO2f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 10:28:35 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94625C06175F;
        Wed, 12 May 2021 07:27:26 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q5so4374995wrs.4;
        Wed, 12 May 2021 07:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Gnut4OIHTXdVQYAppZgBdNW7G0zU+f0bBxT1EkyKo3w=;
        b=nxtlgtVDKKK09WGXu8w92Dt3k38zDtEvYs4dhEHtjnVdTBQ7ks/WOpSw7vK1yJ3AeT
         TCltmWqWaAGzPvUA5CUXiTwXqIayAXlLJJ0TVK3Ed/twryKfA2xjHOw6KZLqEh/IGJr2
         GmGlL16m150mME/ConsCmR0OX22VbZA0H2+FdxtIZUBjCwYyVOXP8zny3BYCRNx2LkAf
         e6Ut5wHylVEAD7huOb0lawllWRwgC9dy6BEQBiOtW4+WcHzsdkCmVwD6GmPMs4xDSYdJ
         k3KFh0iVc9SDyjZ8od51Hr640rWFMYMoRBzyu6ZxM12y3SStWFSqrxDPJIs1mly1nUcn
         rmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Gnut4OIHTXdVQYAppZgBdNW7G0zU+f0bBxT1EkyKo3w=;
        b=MpmlBmSqzC5LYTD5x69n2oDMtT5XN1ScZBW2o3hUWrpG4o4ou5VD7Kf5NPOauJkZDW
         UqtaexTtwnmEa3j3BdyvPo/uX73SntLfiT4OeaTKi0NfKCzCBtDW6ql1b7Z32jKc4I7G
         yDa25uriRtaKqBB8vvnzzH7ah5zI6gxRnOrxM+K68pLq3cUuGNjn45BRx5Wr1ySbvPVD
         +nJW6AT18zkPqO1wIYFUN9C8asFI96OSdlKuGAibzGmpV5FdKmdB5PzdaWDqvQOj/pLf
         m1wKbChOF0Q03EA2KrW7BhnhaEcatL38v8I9Rf/HIOACTkfcBvT/exsQMTSSWvHXrMIi
         GKbA==
X-Gm-Message-State: AOAM533/9NPnKTWDVPoU7EvYYJnTQ/28SERqz5ZB01zNCNFDz9nF/xr5
        m5uMM9rmEWhrM69NKRaWyLeNQqw2xPem1g==
X-Google-Smtp-Source: ABdhPJzRI6zer+b/poTlxVR4Srb/PR2nX8edgyzCBBC3blwp5gEww864uicHqbQOhglYn4gfeRPYwA==
X-Received: by 2002:a5d:64c7:: with SMTP id f7mr44751387wri.257.1620829645413;
        Wed, 12 May 2021 07:27:25 -0700 (PDT)
Received: from lpc (bzq-79-177-27-162.red.bezeqint.net. [79.177.27.162])
        by smtp.gmail.com with ESMTPSA id j13sm37639927wrd.81.2021.05.12.07.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 07:27:24 -0700 (PDT)
Date:   Wed, 12 May 2021 17:27:22 +0300
From:   Shachar Sharon <synarete@gmail.com>
To:     "Richard W.M. Jones" <rjones@redhat.com>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, eblake@redhat.com,
        libguestfs@redhat.com
Subject: Re: [PATCH v2] fuse: Allow fallocate(FALLOC_FL_ZERO_RANGE)
Message-ID: <YJvlyiTR7LVM4q1n@lpc>
References: <20210512103704.3505086-1-rjones@redhat.com>
 <20210512103704.3505086-2-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210512103704.3505086-2-rjones@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 12, 2021 at 11:37:04AM +0100, Richard W.M. Jones wrote:
>libnbd's nbdfuse utility would like to translate fallocate zero
>requests into NBD_CMD_WRITE_ZEROES.  Currently the fuse module filters
>these out, returning -EOPNOTSUPP.  This commit treats these almost the
>same way as FALLOC_FL_PUNCH_HOLE except not calling
>truncate_pagecache_range.
>
Why don't you call 'truncate_pagecache_range' ?

>A way to test this is with the following script:
>
>--------------------
>  #!/bin/bash
>  # Requires fuse >= 3, nbdkit >= 1.8, and latest nbdfuse from
>  # https://gitlab.com/nbdkit/libnbd/-/tree/master/fuse
>  set -e
>  set -x
>
>  export output=$PWD/output
>  rm -f test.img $output
>
>  # Create an nbdkit instance that prints the NBD requests seen.
>  nbdkit sh - <<'EOF'
>  case "$1" in
>    get_size) echo 1M ;;
>    can_write|can_trim|can_zero|can_fast_zero) ;;
>    pread) echo "$@" >>$output; dd if=/dev/zero count=$3 iflag=count_bytes ;;
>    pwrite) echo "$@" >>$output; cat >/dev/null ;;
>    trim|zero) echo "$@" >>$output ;;
>    *) exit 2 ;;
>  esac
>  EOF
>
>  # Fuse-mount NBD instance as a file.
>  touch test.img
>  nbdfuse test.img nbd://localhost & sleep 2
>  ls -lh test.img
>
>  # Run a read, write, trim and zero request.
>  dd if=test.img of=/dev/null bs=512 skip=1024 count=1
>  dd if=/dev/zero of=test.img bs=512 skip=2048 count=1
>  fallocate -p -l 512 -o 4096 test.img
>  fallocate -z -l 512 -o 8192 test.img
>
>  # Print the output from the NBD server.
>  cat $output
>
>  # Clean up.
>  fusermount3 -u test.img
>  killall nbdkit
>  rm test.img $output
>  --------------------
>
>which will print:
>
>  pread  4096 524288    # number depends on readahead
>  pwrite  512 0
>  trim  512 4096
>  zero  512 8192 may_trim
>
>The last line indicates that the FALLOC_FL_ZERO_RANGE request was
>successfully passed through by the kernel module to nbdfuse,
>translated to NBD_CMD_WRITE_ZEROES and sent through to the server.
>
>Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
>---
> fs/fuse/file.c | 9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)
>
>diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>index 09ef2a4d25ed..22e8e88c78d4 100644
>--- a/fs/fuse/file.c
>+++ b/fs/fuse/file.c
>@@ -2907,11 +2907,13 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
> 	};
> 	int err;
> 	bool lock_inode = !(mode & FALLOC_FL_KEEP_SIZE) ||
>-			   (mode & FALLOC_FL_PUNCH_HOLE);
>+			   (mode & FALLOC_FL_PUNCH_HOLE) ||
>+			   (mode & FALLOC_FL_ZERO_RANGE);
To stay aligned with existing code style, consider:
-			   (mode & FALLOC_FL_PUNCH_HOLE);
+»      »       »          (mode & (FALLOC_FL_PUNCH_HOLE |
+»      »       »       »           FALLOC_FL_ZERO_RANGE));

>
> 	bool block_faults = FUSE_IS_DAX(inode) && lock_inode;
>
>-	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
>+	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
>+		     FALLOC_FL_ZERO_RANGE))
> 		return -EOPNOTSUPP;
>
> 	if (fm->fc->no_fallocate)
>@@ -2926,7 +2928,8 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
> 				goto out;
> 		}
>
>-		if (mode & FALLOC_FL_PUNCH_HOLE) {
>+		if ((mode & FALLOC_FL_PUNCH_HOLE) ||
>+		    (mode & FALLOC_FL_ZERO_RANGE)) {
> 			loff_t endbyte = offset + length - 1;
>
> 			err = fuse_writeback_range(inode, offset, endbyte);
>-- 
>2.31.1
>
