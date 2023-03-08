Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3D46B0DDA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 16:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjCHP6Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 10:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjCHP5w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:57:52 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FFD591E9;
        Wed,  8 Mar 2023 07:57:19 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4D71F67373; Wed,  8 Mar 2023 16:56:09 +0100 (CET)
Date:   Wed, 8 Mar 2023 16:56:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
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
Subject: Re: [PATCH v16 03/13] overlayfs: Implement splice-read
Message-ID: <20230308155609.GA21508@lst.de>
References: <CAJfpeguGksS3sCigmRi9hJdUec8qtM9f+_9jC1rJhsXT+dV01w@mail.gmail.com> <20230308143754.1976726-1-dhowells@redhat.com> <20230308143754.1976726-4-dhowells@redhat.com> <2011735.1678290876@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2011735.1678290876@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 08, 2023 at 03:54:36PM +0000, David Howells wrote:
> Using do_splice_to() as a helper is probably a good idea, though both Willy
> and Christoph seem to dislike it.

That's not true.  What I'm fundamentlly against is pointless wrappers
like the call_* that add no value.  do_splice_to adds useful checks,
so if properly named and documented, I'm absolutely in favour.
