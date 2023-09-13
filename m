Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BBC79EE4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 18:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjIMQdW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 12:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIMQdW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:33:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425B019A7;
        Wed, 13 Sep 2023 09:33:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C43C433C8;
        Wed, 13 Sep 2023 16:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694622797;
        bh=/BE0SzPSHWJUDQnPrCfnTnaEO0Ee7ixrpqIiDWWi4pg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JEIWOoDeYw0Lf9hWj/zCyZ4x/rGCa/NQnygF+m0lMZeczRYWp/+IE53tvWyCKZsG+
         up2zc8mQP9OdLjIt3ieHpSW+DbqQjZbKoxHgYka+ox5B/duraDYwWYC2flCW6yQuBT
         cv0SrfJZcsbNKoo8+UUGobBcO+5vSh//zaB0oCO1AkX/JNOxsSLnUA74YuG8d2qy//
         xSekU6sH/2OHlD59lMaI3d2pMSviFkxZRQRw7TX7MfD7+om+CEtOj6/4xJ6+C+s9aW
         E5R98PPdfp9ZT0xmFjYnC4VDDVH+LzbtHDEh8winSlhdDUVsFOEtHvfQKUUr5vKlnV
         kky/flcyBX0+w==
Date:   Wed, 13 Sep 2023 18:33:10 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
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
        linux-mm@kvack.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 03/12] filemap: update ki_pos in generic_perform_write
Message-ID: <20230913-aufgreifen-fehlleiten-204b36f3069d@brauner>
References: <20230601145904.1385409-1-hch@lst.de>
 <20230601145904.1385409-4-hch@lst.de>
 <20230827194122.GA325446@ZenIV>
 <20230827214518.GU3390869@ZenIV>
 <20230913110010.GA31292@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230913110010.GA31292@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 13, 2023 at 01:00:10PM +0200, Christoph Hellwig wrote:
> > direct_write_fallback(): on error revert the ->ki_pos update from buffered write
> 
> Al, Christian: can you send this fix on top Linus?

Wasn't aware of this, sorry. I've picked it up and placed it with
another set of small fixes I already have.
I'm happy to have Al take it ofc.
