Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEAA2163B2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 04:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgBSD22 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 22:28:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:41104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgBSD22 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 22:28:28 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C791F24658;
        Wed, 19 Feb 2020 03:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582082908;
        bh=VSakUIZdUnh4kwjCiCYOK30SKm0FPJHaDrKhBHNH/O0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sSo+l0jqfJP5IDuZCWJUj4RO9pEWAB1W4p4Feik4xAkV3cci+4Xqzgigh+5tJwH9v
         sE1kq86XdWrgqVDsv1RolnDs1ziPSCTYBt6BD/mOmWDhMIlqCxeffX/y5V/4JZzwPR
         SQktNIjOJLPhkomAjO77iIh3++VkdKq2Nvgz61hQ=
Date:   Tue, 18 Feb 2020 19:28:26 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Junxiao Bi <junxiao.bi@oracle.com>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
        linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v6 10/19] fs: Convert mpage_readpages to mpage_readahead
Message-ID: <20200219032826.GB1075@sol.localdomain>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-18-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217184613.19668-18-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 10:45:58AM -0800, Matthew Wilcox wrote:
> diff --git a/include/linux/mpage.h b/include/linux/mpage.h
> index 001f1fcf9836..f4f5e90a6844 100644
> --- a/include/linux/mpage.h
> +++ b/include/linux/mpage.h
> @@ -13,9 +13,9 @@
>  #ifdef CONFIG_BLOCK
>  
>  struct writeback_control;
> +struct readahead_control;
>  
> -int mpage_readpages(struct address_space *mapping, struct list_head *pages,
> -				unsigned nr_pages, get_block_t get_block);
> +void mpage_readahead(struct readahead_control *, get_block_t get_block);
>  int mpage_readpage(struct page *page, get_block_t get_block);
>  int mpage_writepages(struct address_space *mapping,
>  		struct writeback_control *wbc, get_block_t get_block);

Can you name the 'struct readahead_control *' parameter?

checkpatch.pl should warn about this.

- Eric
