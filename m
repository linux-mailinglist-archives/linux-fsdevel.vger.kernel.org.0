Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471B0469996
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 15:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344691AbhLFO7G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 09:59:06 -0500
Received: from verein.lst.de ([213.95.11.211]:50947 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344670AbhLFO7G (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:59:06 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1C68468AFE; Mon,  6 Dec 2021 15:55:35 +0100 (CET)
Date:   Mon, 6 Dec 2021 15:55:34 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-doc@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] iov_iter: Move internal documentation
Message-ID: <20211206145534.GC8794@lst.de>
References: <20211206145220.1175209-1-willy@infradead.org> <20211206145220.1175209-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206145220.1175209-4-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 06, 2021 at 02:52:20PM +0000, Matthew Wilcox (Oracle) wrote:
> Document the interfaces we want users to call (ie copy_mc_to_iter()
> and copy_from_iter_flushcache()), not the internal interfaces.

Except that no one actually calls them, and I have series to remove them
that just needs a little brushing off.
