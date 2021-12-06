Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74F8469992
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 15:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344728AbhLFO6R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 09:58:17 -0500
Received: from verein.lst.de ([213.95.11.211]:50944 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245556AbhLFO6Q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:58:16 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 613D468B05; Mon,  6 Dec 2021 15:54:45 +0100 (CET)
Date:   Mon, 6 Dec 2021 15:54:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-doc@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] iov_iter: Add kernel-doc
Message-ID: <20211206145445.GB8794@lst.de>
References: <20211206145220.1175209-1-willy@infradead.org> <20211206145220.1175209-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206145220.1175209-3-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 06, 2021 at 02:52:19PM +0000, Matthew Wilcox (Oracle) wrote:
> Document enum iter_type, copy_to_iter() and copy_from_iter()

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
