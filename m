Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2F72A90FB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 09:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgKFIHD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 03:07:03 -0500
Received: from verein.lst.de ([213.95.11.211]:50514 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgKFIHD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 03:07:03 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E530368B05; Fri,  6 Nov 2020 09:07:00 +0100 (CET)
Date:   Fri, 6 Nov 2020 09:07:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH v2 01/18] mm/filemap: Rename generic_file_buffered_read
 subfunctions
Message-ID: <20201106080700.GA31585@lst.de>
References: <20201104204219.23810-1-willy@infradead.org> <20201104204219.23810-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104204219.23810-2-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Not 100% my preferred naming, but much better than what we had before,
so:

Reviewed-by: Christoph Hellwig <hch@lst.de>
