Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47BA031674C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 13:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhBJM6d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 07:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbhBJM5n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:57:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DD8C0613D6;
        Wed, 10 Feb 2021 04:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SGAIOBNUj9OSbPY+0bXagC3zuJ1Bdm0CDwlnEQirSc8=; b=dTyIUjcND5JzcCbae6DADZuxLV
        YRHONEqUMaoeAue709YkIlt0BqtQBFeTVJ09TUmIqwsOu3NKdS5w9PaeQr6CdCBMIronvbntDra2+
        a+yCx0+cEmW7KJhE10v2CiN2VejC1AYdJk4/o4iATgZPxMe+Xh0XlmuivMZdsvvTiTrn8tp6EerkN
        i68GQBrxVqh9Abuw+LuqRuazFxlfeEWEDwDUywaULX4/u1N69b07WBjw0RX07KGcPZwOD8Q1NTF4y
        BEqtP7Hx7wqSRMa24LEafRkG6nNJeUoszR48Rbhj71Ld2t9i6AJcYRi2Na3Ilj6R4fnR0abjfTcqI
        JdOrfKnA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l9p1p-008rZB-US; Wed, 10 Feb 2021 12:55:34 +0000
Date:   Wed, 10 Feb 2021 12:55:33 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     ira.weiny@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>,
        Christoph Hellwig <hch@infradead.org>, clm@fb.com,
        josef@toxicpanda.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V2 5/8] iov_iter: Remove memzero_page() in favor of
 zero_user()
Message-ID: <20210210125533.GE2111784@infradead.org>
References: <20210210062221.3023586-1-ira.weiny@intel.com>
 <20210210062221.3023586-6-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210062221.3023586-6-ira.weiny@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 10:22:18PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> zero_user() is already defined with the same interface and contains the
> same code pattern as memzero_page().  Remove memzero_page() and use the
> already defined common function zero_user()

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
