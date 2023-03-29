Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE5F6CF7CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 01:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjC2X4V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 19:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjC2X4U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:56:20 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C1C1FD2;
        Wed, 29 Mar 2023 16:56:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id EB42C68C7B; Thu, 30 Mar 2023 01:56:15 +0200 (CEST)
Date:   Thu, 30 Mar 2023 01:56:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nilfs@vger.kernel.org
Subject: Re: return an ERR_PTR from __filemap_get_folio v2
Message-ID: <20230329235615.GA2012@lst.de>
References: <20230121065755.1140136-1-hch@lst.de> <20230328160433.4f3dc32b480239bce9e2f9ef@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328160433.4f3dc32b480239bce9e2f9ef@linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 28, 2023 at 04:04:33PM -0700, Andrew Morton wrote:
> > Note that the shmem patches in here are non-trivial and need some
> > careful review and testing.
> 
> How are we going with the review and testing.  I assume that
> we're now OK on the runtime testing front, but do you feel that
> review has been adequate?

Yes, I think we're fine, mostly due to Hugh.  I'm a little sad about
the simplification / descoping from him, but at least we get the main
objective done.  Maybe at some point we can do another pass at
cleaning up the shmem page finding/reading mess.
