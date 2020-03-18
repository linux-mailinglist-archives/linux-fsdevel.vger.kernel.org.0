Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44CB31897DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 10:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgCRJXS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 05:23:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38320 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgCRJXS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 05:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z47gR8NIC6patRmRmrCLnrKmVt+9xKkztcdCxbqOI5o=; b=mATEGjhYHxAWwmF5BjJF0Zrp4W
        G+6mPXlqkH0TP+CXQ5Sv8MJWnMWp1UIrAQWQzJgtG6TLyWSUsUHc2yrCT+H0DceS6RQ2OSaF1fGDI
        1XU7PoLIqas8Z0QmjftzIXkjqEImcDJWSktGQwQbb07JTYrkcpjgcq0WrK2erCPkqjU2AvtqY8l08
        eVxfwl0432yDEmSLUYi8yhYBXlk2wyBTgKLSZc+c+RUFzUnlXYXSJxxsptnwUYCPjyK3oyrw9ThJm
        mjVjjL0Jlm00KcJ3hjKRmE7oh+AbV5hJoX33kYrmY2+iKwXBDJiLBufkerYvPww1+I1l0B/7CgW1R
        BJfwqMUA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEUuq-0002p1-FG; Wed, 18 Mar 2020 09:23:08 +0000
Date:   Wed, 18 Mar 2020 02:23:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     yangerkun <yangerkun@huawei.com>
Cc:     hch@infradead.org, darrick.wong@oracle.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: fix comments in iomap_dio_rw
Message-ID: <20200318092308.GA10672@infradead.org>
References: <20200318095022.5613-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318095022.5613-1-yangerkun@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 18, 2020 at 05:50:22PM +0800, yangerkun wrote:
> Double 'three' exists in the comments of iomap_dio_rw.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
