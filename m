Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFE92A3DBF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 08:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgKCHfO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 02:35:14 -0500
Received: from verein.lst.de ([213.95.11.211]:36020 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbgKCHfN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 02:35:13 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id BB06768B02; Tue,  3 Nov 2020 08:35:11 +0100 (CET)
Date:   Tue, 3 Nov 2020 08:35:11 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH 08/17] mm/filemap: Change filemap_create_page arguments
Message-ID: <20201103073511.GH8389@lst.de>
References: <20201102184312.25926-1-willy@infradead.org> <20201102184312.25926-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184312.25926-9-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
