Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1802B750D80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 18:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjGLQGv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 12:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbjGLQGu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:06:50 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF381BE4
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 09:06:47 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fb96e2b573so11506612e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 09:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1689178006; x=1691770006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8X6ArMXh62A5UxRR3ZN+q1CvObhoeb8ltfmXU1xj+zw=;
        b=V0Mwyzpfv5NHo344FebMkemb4OkDhqesSJzk3oLJrC1sXingJzi/DqoHJPX3cM7/kU
         /daZbGumusx7p3ETz9bL+dV7+a249DzrdJ5ucaxUqFs1cH4q4UNK1aBbCP0kRMVezgvK
         Gb0u18D1omT5qk875/bvJSIuyWWXlLKu5WnA0OT929rTcOY7rHqZVsWOvIcdQTq+Q4TI
         Xty8IQiQ2uEFjkBqRHhjaYUeIIjdk3TlKuW6ZBNL29/kZI8LKdOXvAAi+FiRNxSMUXsG
         92h/diWQ5jGfG/Pc/9JTOLcLZ2bS8Hyd3sIfxIs/rFITeR6YjIQmonhcUevYE5m/zN7s
         SmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689178006; x=1691770006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8X6ArMXh62A5UxRR3ZN+q1CvObhoeb8ltfmXU1xj+zw=;
        b=QHBPEcxnKQyNINLvwk72nI+ikCw+tWCLTCtk7E0MbJDs52wiSi0kIycU8yEgJjnJwK
         BHCnWkjtnFwaJ6FdRsS600bG9CWu1X8l0+0x5+aSeZZpYzEUUJFEXdl0W+XQxdMYrjz1
         2PrjZO8chMAnvno6gLyP7Wv64PFNiZgCxfrbBLC9DKDb8lXBRh3WjLOJNXG/QaezExqY
         UJDxvgIYZWIBqa7XsfHMfLK4BuITCRdCmu2lCgAFILWti5dNrv7k65DfPi19H3GJ+a2v
         DVPCYq6R91BwKYHuYdZL2dlUkyfMRFA5pi+mi6kovqfI8mLqgGAFsbh0UiwSkpEb4D9g
         /fDQ==
X-Gm-Message-State: ABy/qLYTcNVx5ZZBLlniMuecR5sb574Ej+dAVofEBsRSzVVb82a0wVyA
        PGfQjSfCOTyqjH8FiiPyAPh7zCoww/B15Aeqj3uhmQ==
X-Google-Smtp-Source: APBJJlHjPtNIqZNhhKZT3JSG1orBAozCwd3+TwwvFjulJuToD7D5iIrA7grwKZQU8Z67qc0UJ0oDxWof6WbkdfMRi3A=
X-Received: by 2002:ac2:5b1d:0:b0:4fb:7a90:1abe with SMTP id
 v29-20020ac25b1d000000b004fb7a901abemr15797051lfn.49.1689178006211; Wed, 12
 Jul 2023 09:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230629165206.383-1-jack@suse.cz> <20230704122224.16257-1-jack@suse.cz>
 <ZKbgAG5OoHVyUKOG@infradead.org>
In-Reply-To: <ZKbgAG5OoHVyUKOG@infradead.org>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Wed, 12 Jul 2023 18:06:35 +0200
Message-ID: <CAJpMwyiUcw+mH0sZa8f8UJsaSZ7NSE65s2gZDEia+pASyP_gJQ@mail.gmail.com>
Subject: Re: [PATCH 01/32] block: Provide blkdev_get_handle_* functions
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anna Schumaker <anna@kernel.org>, Chao Yu <chao@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        David Sterba <dsterba@suse.com>, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com, Gao Xiang <xiang@kernel.org>,
        Jack Wang <jinpu.wang@ionos.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        jfs-discussion@lists.sourceforge.net,
        Joern Engel <joern@lazybastard.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Minchan Kim <minchan@kernel.org>, ocfs2-devel@oss.oracle.com,
        reiserfs-devel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Song Liu <song@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        target-devel@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 6, 2023 at 5:38=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Tue, Jul 04, 2023 at 02:21:28PM +0200, Jan Kara wrote:
> > Create struct bdev_handle that contains all parameters that need to be
> > passed to blkdev_put() and provide blkdev_get_handle_* functions that
> > return this structure instead of plain bdev pointer. This will
> > eventually allow us to pass one more argument to blkdev_put() without
> > too much hassle.
>
> Can we use the opportunity to come up with better names?  blkdev_get_*
> was always a rather horrible naming convention for something that
> ends up calling into ->open.
>
> What about:
>
> struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *ho=
lder,
>                 const struct blk_holder_ops *hops);
> struct bdev_handle *bdev_open_by_path(dev_t dev, blk_mode_t mode,
>                 void *holder, const struct blk_holder_ops *hops);
> void bdev_release(struct bdev_handle *handle);

+1 to this.
Also, if we are removing "handle" from the function, should the name
of the structure it returns also change? Would something like bdev_ctx
be better?

(Apologies for the previous non-plaintext email)

>
> ?
