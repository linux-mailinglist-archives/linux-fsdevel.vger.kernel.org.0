Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B229D15AF7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 19:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgBLSNb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 13:13:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39796 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgBLSNb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 13:13:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=exbKuTmB3BypNRUAcUVWw3Jh2/ptObaFi+H8fsEcxKE=; b=kfnqaCCT7YWX4nBMwDXdhFflTO
        GchhyNM5fm8RyKBM+/aj2h5Cuth7F4gsvGUO233CoUs/Jc9bqjOOO2tU2zM+ICd06jmGSkWZW4I/k
        xootPKLT7JvmY10K4LD5LdaVgfHHT0ofNUFoWq5s1wu7sfUCSds7gSMPkAVFGx2h9sDVnMvdbrMha
        UadJrwNB6Pd5MIPsfdkJ9ZHiYkkYTQ7iAJMXyfRnyQMqUJ9hPSorBBhCtwBP1k4l7m7L1NJA23Q6E
        DLvyHLGiztgzg8AQ6OWjDLFqLL/ytC981/NRCevE1vjEixMjTUWdlDnFOHo9gKGpBWg4t+WsmRGt9
        Qmymo12A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1wVu-0002f2-F4; Wed, 12 Feb 2020 18:13:30 +0000
Date:   Wed, 12 Feb 2020 10:13:30 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v5 02/13] mm: Ignore return value of ->readpages
Message-ID: <20200212181330.GB9756@infradead.org>
References: <20200211010348.6872-1-willy@infradead.org>
 <20200211010348.6872-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211010348.6872-3-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 10, 2020 at 05:03:37PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> We used to assign the return value to a variable, which we then ignored.
> Remove the pretence of caring.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
