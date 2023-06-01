Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85EC719344
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 08:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjFAGeV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 02:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjFAGeU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 02:34:20 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9830CE2;
        Wed, 31 May 2023 23:34:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 82D0F67373; Thu,  1 Jun 2023 08:34:14 +0200 (CEST)
Date:   Thu, 1 Jun 2023 08:34:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 10/12] fuse: update ki_pos in fuse_perform_write
Message-ID: <20230601063413.GB24071@lst.de>
References: <20230531075026.480237-1-hch@lst.de> <20230531075026.480237-11-hch@lst.de> <CAJfpegth2z06pAH5K5vxRsy1PqygBD=ShiQxoYGqjmJPvk1-aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegth2z06pAH5K5vxRsy1PqygBD=ShiQxoYGqjmJPvk1-aQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 31, 2023 at 11:11:13AM +0200, Miklos Szeredi wrote:
> Why remove generic_write_sync()?  Definitely doesn't belong in this
> patch even if there's a good reason.

Yes, this shouldn't have happened.  I think this was a bad merge
resolution after the current->backing_dev removal.
