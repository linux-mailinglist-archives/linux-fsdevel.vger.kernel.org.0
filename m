Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942522A3DC6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 08:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgKCHgw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 02:36:52 -0500
Received: from verein.lst.de ([213.95.11.211]:36024 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgKCHgw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 02:36:52 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id BF59668B02; Tue,  3 Nov 2020 08:36:50 +0100 (CET)
Date:   Tue, 3 Nov 2020 08:36:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH 09/17] mm/filemap: Convert filemap_update_page to
 return an errno
Message-ID: <20201103073650.GI8389@lst.de>
References: <20201102184312.25926-1-willy@infradead.org> <20201102184312.25926-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184312.25926-10-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> -	if (err)
> +	if (err < 0)

Please check for AOP_TRUNCATED_PAGE explicitly here.
