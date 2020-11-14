Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDCE2B2CA9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 11:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgKNKWJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Nov 2020 05:22:09 -0500
Received: from verein.lst.de ([213.95.11.211]:50028 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbgKNKWJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Nov 2020 05:22:09 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 164D068AFE; Sat, 14 Nov 2020 11:22:07 +0100 (CET)
Date:   Sat, 14 Nov 2020 11:22:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hughd@google.com, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v4 14/16] mm: Remove pagevec_lookup_entries
Message-ID: <20201114102206.GO19102@lst.de>
References: <20201112212641.27837-1-willy@infradead.org> <20201112212641.27837-15-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112212641.27837-15-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
