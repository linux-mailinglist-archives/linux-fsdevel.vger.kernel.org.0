Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111AE777CC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 17:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjHJPyQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 11:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbjHJPxy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:53:54 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0BA2703;
        Thu, 10 Aug 2023 08:53:53 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0242267373; Thu, 10 Aug 2023 17:53:51 +0200 (CEST)
Date:   Thu, 10 Aug 2023 17:53:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 07/13] xfs: document the invalidate_bdev call in
 invalidate_bdev
Message-ID: <20230810155350.GE28000@lst.de>
References: <20230809220545.1308228-1-hch@lst.de> <20230809220545.1308228-8-hch@lst.de> <20230809223923.GX11352@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809223923.GX11352@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 09, 2023 at 03:39:23PM -0700, Darrick J. Wong wrote:
> > +	 * read from the same page in the pagecache.
> > +	 *
> > +	 * The unmount writes updated inode metadata to disk directly.  The XFS
> > +	 * buffer cache does not use the bdev pagecache, nor does it invalidate
> > +	 * the pagecache on umount.  If the above scenario occurs, the pagecache
> 
> This sentence reads a little strangely, since "nor does it invalidate"
> would seem to conflict with the invalidate_bdev call below.  I suggest
> changing the verb a bit:
> 
> "The XFS buffer cache does not use the bdev pagecache, so it needs to
> invalidate that pagecache on unmount."

Agreed. I'll forward it to the original author of the sentence time
permitting :)

