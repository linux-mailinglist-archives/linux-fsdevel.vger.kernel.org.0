Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7806723C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 17:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjARQne (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 11:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjARQnH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:43:07 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1520837B76;
        Wed, 18 Jan 2023 08:42:37 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AB09068AFE; Wed, 18 Jan 2023 17:42:34 +0100 (CET)
Date:   Wed, 18 Jan 2023 17:42:34 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [Cluster-devel] [PATCH 7/9] gfs2: handle a NULL folio in
 gfs2_jhead_process_page
Message-ID: <20230118164234.GB7584@lst.de>
References: <20230118094329.9553-1-hch@lst.de> <20230118094329.9553-8-hch@lst.de> <Y8gXodKIUneO+XQb@casper.infradead.org> <CAHc6FU7Exz2kr+x7jvK1mi5ENOVCOXruP7qKSdPsyhSwmfMhDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU7Exz2kr+x7jvK1mi5ENOVCOXruP7qKSdPsyhSwmfMhDA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 18, 2023 at 05:24:32PM +0100, Andreas Gruenbacher wrote:
> We're actually still holding a reference to the folio from the
> find_or_create_page() in gfs2_find_jhead() here, so we know that
> memory pressure can't push the page out and filemap_get_folio() won't
> return NULL.

Ok, I'll drop this patch.
