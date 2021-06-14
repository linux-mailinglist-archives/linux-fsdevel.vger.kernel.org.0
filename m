Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A4F3A5FA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 12:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbhFNKFk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 06:05:40 -0400
Received: from verein.lst.de ([213.95.11.211]:43440 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232579AbhFNKFj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 06:05:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C9C1368AFE; Mon, 14 Jun 2021 12:03:34 +0200 (CEST)
Date:   Mon, 14 Jun 2021 12:03:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: require ->set_page_dirty to be explicitly wire
 up
Message-ID: <20210614100334.GA10629@lst.de>
References: <20210614061512.3966143-1-hch@lst.de> <20210614061512.3966143-4-hch@lst.de> <20210614095107.GD26615@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614095107.GD26615@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 14, 2021 at 11:51:07AM +0200, Jan Kara wrote:
> On Mon 14-06-21 08:15:12, Christoph Hellwig wrote:
> > Remove the CONFIG_BLOCK default to __set_page_dirty_buffers and just
> > wire that method up for the missing instances.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Make sense. Did you somehow autogenerate this? If this patch would race
> with addition of new aops struct, we'd get null-ptr-defer out of that so
> maybe providing the script would be better. But other than that the changes
> look good to me. You can add:

No, this was done manually as I audited all instances for actually being
able to dirty pages.
