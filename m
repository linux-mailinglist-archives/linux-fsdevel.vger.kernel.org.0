Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306C266D5C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 06:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbjAQF4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 00:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbjAQFzx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 00:55:53 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D5A222E1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 21:55:51 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 171BE67373; Tue, 17 Jan 2023 06:55:47 +0100 (CET)
Date:   Tue, 17 Jan 2023 06:55:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: remove most callers of write_one_page
Message-ID: <20230117055546.GA13795@lst.de>
References: <20230116085523.2343176-1-hch@lst.de> <Y8W7dULuW5oFGm/J@ZenIV> <20230116133011.81f6e4e42805ed47aa61270d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116133011.81f6e4e42805ed47aa61270d@linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 01:30:11PM -0800, Andrew Morton wrote:
> On Mon, 16 Jan 2023 21:02:45 +0000 Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > OK...  Mind if I grab minix/sysv/ufs into a branch in vfs.git?
> > There's a pile of kmap_local() stuff that that would interfere with
> > that and I'd rather have it in one place...
> 
> Please grab the whole series in that case?

After dropping the last patch that removes write_one_page they are
independent, so splitting is fine with me, as is Al picking all of
them up.  Note that minix probably needs the same update for the
set_link fix as Jan pointed out for ext2.
