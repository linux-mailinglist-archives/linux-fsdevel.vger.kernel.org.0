Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260AB3EA1E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 11:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbhHLJWC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 05:22:02 -0400
Received: from verein.lst.de ([213.95.11.211]:43609 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235618AbhHLJWC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 05:22:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8DC3A67373; Thu, 12 Aug 2021 11:20:44 +0200 (CEST)
Date:   Thu, 12 Aug 2021 11:20:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 2/3] mm/gup: small refactoring: simplify
 try_grab_page()
Message-ID: <20210812092043.GA4827@lst.de>
References: <20210811070542.3403116-1-jhubbard@nvidia.com> <20210811070542.3403116-3-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811070542.3403116-3-jhubbard@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

Note: the __maybe_unused on try_grab_compound_head should be dropped now
that there is always a user.
