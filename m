Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C866B78FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Mar 2023 14:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjCMN2r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Mar 2023 09:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjCMN2g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:28:36 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF61274AA
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Mar 2023 06:28:04 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id c19so12987993qtn.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Mar 2023 06:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1678714083;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyfnm20ZcESTZZICXzvfZBrwNfquIlw/nie6VPg8U74=;
        b=X+al1sOiAsPAhBRCww81YtjFkVTVxccjSPzp1nBHd2IQgpRx3v9o+RE806ZA0PRYG4
         BgpU56JUTbexA5gywGNmboNInkeEkEG7hTe6o+aLWyEZ/VIpEWivtJAMvgPcKjYgQFWx
         DqzS4Xpu8XEvnlm9t1nxPZLmSqEeVa9bTxD/IkDVQwEOnSraLGGxTsXaV6wgbvBdHOAW
         0mI5d4V3ujTO65mnXfRAmoVVDsrSWu4ymG2i3c4YQH/vn6kmXHcL0RcGvATqNNT8kWUW
         MdGyqQaSUIdUa0Y2DIcos61471PGhU6rMB2A7wyfpzevEs+476dYhdUyhsCoUia11lzZ
         tZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678714083;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wyfnm20ZcESTZZICXzvfZBrwNfquIlw/nie6VPg8U74=;
        b=xgnn5CfdSTpC6p+RTGp1hdHyS3Y4vKcGzYE0zFbtF9WeB8XZKGDQeim0TlCytj+3Ki
         D4l6sA6D2aDHWfgMbdCGwGHCie0jjUrZ3ZbQyQ2vWRdzGujloJ6IS0LcFUeRfp8wkvBe
         befcYQ2y1Xh7j5/8tXiV/wrtciYS/FTvlED4SY7d1ejCEuUWyx6s/+cQZsrTn4zGKO5p
         vLhyoiZ0GiX369JvxH2K3WmQ9+BrIVbiS/aZoYYcdy1SkXJeWI+YlIPGHs55FGHLfLF0
         ylLNfzblh9kr6hLNrbBbI8/44EBoTWrz7G1R14cCeTy0rYS5THSIXBH6J0J+Jzy+MK8e
         +llQ==
X-Gm-Message-State: AO0yUKUijHzp7P27kwuqebe9ViC6X8cL+jZQriuoJYsFR2ZXp8VUv/Kb
        dkmAJ9za9Tyk4rEPh00fOSNzng==
X-Google-Smtp-Source: AK7set9tuv7Xfd9Fa/zMlcJpqFBFMylrI/FwvAimLLz1Dc7kbKUinONv1rS/iHv0eiBgE5Mm0zynRA==
X-Received: by 2002:ac8:4e86:0:b0:3bf:c961:9309 with SMTP id 6-20020ac84e86000000b003bfc9619309mr55930056qtp.37.1678714083568;
        Mon, 13 Mar 2023 06:28:03 -0700 (PDT)
Received: from cs.cmu.edu (tunnel29655-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:582::2])
        by smtp.gmail.com with ESMTPSA id s138-20020a374590000000b007436d0e9408sm5296993qka.127.2023.03.13.06.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 06:28:03 -0700 (PDT)
Date:   Mon, 13 Mar 2023 09:28:00 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v17 05/14] coda: Implement splice-read
Message-ID: <20230313132800.ebjr2zk4utln5i6r@cs.cmu.edu>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>, John Hubbard <jhubbard@nvidia.com>,
        linux-unionfs@vger.kernel.org
References: <20230308165251.2078898-1-dhowells@redhat.com>
 <20230308165251.2078898-6-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308165251.2078898-6-dhowells@redhat.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

That actually looks better than the original code because this brings
in the experimental read intent hinting which allows userspace to
mediate access to partially cached files.

Jan


On Wed, Mar 08, 2023 at 11:53:19AM -0500, David Howells wrote:
> Implement splice-read for coda by passing the request down a layer rather
> than going through generic_file_splice_read() which is going to be changed
> to assume that ->read_folio() is present on buffered files.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Jan Harkes <jaharkes@cs.cmu.edu>

> cc: Jan Harkes <jaharkes@cs.cmu.edu>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: John Hubbard <jhubbard@nvidia.com>
> cc: David Hildenbrand <david@redhat.com>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: coda@cs.cmu.edu
> cc: codalist@coda.cs.cmu.edu
> cc: linux-unionfs@vger.kernel.org
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
> 
> Notes:
>     ver #17)
>      - Use vfs_splice_read() helper rather than open-coding checks.
> 
>  fs/coda/file.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/coda/file.c b/fs/coda/file.c
> index 3f3c81e6b1ab..12b26bd13564 100644
> --- a/fs/coda/file.c
> +++ b/fs/coda/file.c
> @@ -23,6 +23,7 @@
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
>  #include <linux/uio.h>
> +#include <linux/splice.h>
>  
>  #include <linux/coda.h>
>  #include "coda_psdev.h"
> @@ -94,6 +95,32 @@ coda_file_write_iter(struct kiocb *iocb, struct iov_iter *to)
>  	return ret;
>  }
>  
> +static ssize_t
> +coda_file_splice_read(struct file *coda_file, loff_t *ppos,
> +		      struct pipe_inode_info *pipe,
> +		      size_t len, unsigned int flags)
> +{
> +	struct inode *coda_inode = file_inode(coda_file);
> +	struct coda_file_info *cfi = coda_ftoc(coda_file);
> +	struct file *in = cfi->cfi_container;
> +	loff_t ki_pos = *ppos;
> +	ssize_t ret;
> +
> +	ret = venus_access_intent(coda_inode->i_sb, coda_i2f(coda_inode),
> +				  &cfi->cfi_access_intent,
> +				  len, ki_pos, CODA_ACCESS_TYPE_READ);
> +	if (ret)
> +		goto finish_read;
> +
> +	ret = vfs_splice_read(in, ppos, pipe, len, flags);
> +
> +finish_read:
> +	venus_access_intent(coda_inode->i_sb, coda_i2f(coda_inode),
> +			    &cfi->cfi_access_intent,
> +			    len, ki_pos, CODA_ACCESS_TYPE_READ_FINISH);
> +	return ret;
> +}
> +
>  static void
>  coda_vm_open(struct vm_area_struct *vma)
>  {
> @@ -302,5 +329,5 @@ const struct file_operations coda_file_operations = {
>  	.open		= coda_open,
>  	.release	= coda_release,
>  	.fsync		= coda_fsync,
> -	.splice_read	= generic_file_splice_read,
> +	.splice_read	= coda_file_splice_read,
>  };
> 
> 
