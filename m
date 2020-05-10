Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2611CC76B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 09:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgEJHCr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 03:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725810AbgEJHCr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 03:02:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BBEC061A0C;
        Sun, 10 May 2020 00:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bKDpvGvB+JB2+xQj5dN3ItF3LjGTr5pkdv7ViMbK54s=; b=Ukjv6NFsPq1ss+fmk6TqslK1cz
        LPqqb/pT4zg6D25Gjy+GSErRr/OIts7kkzEP/++rwJv27gQQY+wtR/rF7+ddrFw4k18KRa+5S+9qm
        2FQkA9yTTQAZByAiYvwZ1hPqPM7usaZHfmSvEXVyNPgBzmNT/nqc6ocfu6FGVRBgWbuvDJAG4vgY/
        OxhFXC1rancOkxVRGvauy+JKaKNFODyCWhBnuAVQnDewv9H7ysIh25iCBr7JTuNcFw/2GKFO/HpqT
        NA51MgE083RS53al51fD3Kp811h8jRuVblAnmhLGcXYTofmWzy0TMUmg72xbIUSebG/ufFZQ96MUc
        Jp6A9Fsw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXfyz-000114-Ty; Sun, 10 May 2020 07:02:41 +0000
Date:   Sun, 10 May 2020 00:02:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/20] FIEMAP: don't bother with access_ok()
Message-ID: <20200510070241.GA23496@infradead.org>
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
 <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
 <20200509234557.1124086-4-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509234557.1124086-4-viro@ZenIV.linux.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 10, 2020 at 12:45:41AM +0100, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> we use copy_to_user() on that thing anyway (and always had).

I already have this patch in this series:

https://lore.kernel.org/linux-fsdevel/20200507145924.GA28854@lst.de/T/#t

which is waiting to be picked up [1], and also has some chance for conflicts
due to changes next to the access_ok.

[1] except for the first two patches, which Ted plans to send for 5.7
