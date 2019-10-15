Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA4C8D7C7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 18:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388402AbfJOQz4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 12:55:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44500 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388349AbfJOQzz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 12:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NkQI/DoO3NvaBhfGO35HB79wmv94VPW5Z/R214Mqcvc=; b=Hl9q/PoO4nBqwAKD9b2vvjvvx
        cRM22JzAcvWRvNV+a7wCcWhdDt/Z7KoGSHJa5DuliSy5uUxCr9FtnaNFzv+q7Jr88hi75MvsBaaCn
        EZUjN/ttn+WxfQx2MIyLCAN3pAvHhM0mxD/WBOb/oBH3kKQUR878qaBhcb1Q2qQSDDsYDAoeIt+bk
        0GC8QiuBAZri4kdRadndzgUknq0Curs7qBqC7idarwilzzEDruubXtFsIA0fHEsy3ilqKoH9RJgT8
        89S/aVnu8qnha7ANLZk3a30sLExgb9RAuYsDr6J7Qq6+FPkh+nXpDVQ9cvVFnuqguWgLx4E/3FMsR
        /dv/1n7kQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKQ70-0004HM-NG; Tue, 15 Oct 2019 16:55:54 +0000
Date:   Tue, 15 Oct 2019 09:55:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jan Kara <jack@suse.cz>, mbobrowski@mbobrowski.org
Subject: Re: [ANNOUNCE] xfs-linux: iomap-5.5-merge updated to c9acd3aee077
Message-ID: <20191015165554.GA10728@infradead.org>
References: <20191015164901.GF13108@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015164901.GF13108@magnolia>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 15, 2019 at 09:49:01AM -0700, Darrick J. Wong wrote:
> 
> Jan Kara (2):
>       [13ef954445df] iomap: Allow forcing of waiting for running DIO in iomap_dio_rw()
>       [c9acd3aee077] xfs: Use iomap_dio_rw_wait()

The second commit seems to be mis-titled as there is no function
called iomap_dio_rw_wait in that tree.
