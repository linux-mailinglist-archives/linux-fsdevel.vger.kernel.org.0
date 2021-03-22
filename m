Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C903343B51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 09:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhCVIKx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 04:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhCVIKl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 04:10:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66962C061574;
        Mon, 22 Mar 2021 01:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0Gom5lIOcdXHDFkwwTX/JWMweB4RudLWTzTu1Kol3XM=; b=JyJG6OQw9jHUMAM4Ha8nIensbI
        9fZiw/I5PHU+KACQauDg9T+mvu6hIIUAwAXbWasK7pdDRaKG98c2hqagwjW6Ay1hIKXKnFNc2p26o
        BId9OrjcFEM5zhFLk9MMy6f6kGnEeXar1ZVotYRwHdZ5zBVMIZgToOz36vhi7lffHa+KFbJy2v09a
        e8TyGo2crikf1T/fodSFlmVdvvk30haS4s95hnoSh+41au08sn8ScErTl58edbOIyZKJHKUAUUIhx
        Lm33TT6XoLTpBOnLqhqFKKZM2Nk5r56IXwWL5vaJSjRD34k/rRMfvJ7Nht+Ov2NcRl2dipUfU9O3Y
        M8zY187A==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOFcB-008BcB-Vl; Mon, 22 Mar 2021 08:09:01 +0000
Date:   Mon, 22 Mar 2021 08:08:43 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v5 03/27] afs: Use wait_on_page_writeback_killable
Message-ID: <20210322080843.GD1946905@infradead.org>
References: <20210320054104.1300774-1-willy@infradead.org>
 <20210320054104.1300774-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210320054104.1300774-4-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 20, 2021 at 05:40:40AM +0000, Matthew Wilcox (Oracle) wrote:
> Open-coding this function meant it missed out on the recent bugfix
> for waiters being woken by a delayed wake event from a previous
> instantiation of the page.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
