Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CE6442805
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 08:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhKBHSJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 03:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhKBHSJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:18:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC94AC061714;
        Tue,  2 Nov 2021 00:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r7DaAUHTQiiX4IU13GTnhiwZHmeTOvB98JGdCb1gFv4=; b=kmGK2xbhlybRFmU23rreT77v6u
        sDO0hK4s8QlN3h2eNmyUrFV5Pbc2Hd3Lu1jFkhCjmtFd4une2PqqCvaIU9aThAD90XFEmtYvqhvqE
        luLAqFqKkigO06LauNHPI3je8g2MVpuEswwB2ySWFqabuAuNR0dPH8P5QSxYqN7lz4Pi+9XNolfad
        ugA94JDNj86tODXBXlCFhN72azpyaT9qYpPl+OmLiW/Dt5EojZ8wQxvv28hCMDNSwcnhxIG4NmeXU
        Ihq2dFmiQgrP1rimmLzHQJWGOZ/e+hO6Gii+Tk31i7/Rx6mA7me4nQA8c8lvJNowkdPfOkYMadzHE
        z/7ejn0Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mho17-000kIM-O2; Tue, 02 Nov 2021 07:15:33 +0000
Date:   Tue, 2 Nov 2021 00:15:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 08/21] iomap: Add iomap_invalidate_folio
Message-ID: <YYDllTnfdn49Hd1+@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101203929.954622-9-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 01, 2021 at 08:39:16PM +0000, Matthew Wilcox (Oracle) wrote:
> Keep iomap_invalidatepage around as a wrapper for use in address_space
> operations.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
