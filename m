Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271043CF658
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 10:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbhGTIMP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 04:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbhGTIG2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 04:06:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE07C061762;
        Tue, 20 Jul 2021 01:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TYrfXp7lvUaJbM47WY1+OZGsQG1/Fv1bsVM3y35pY34=; b=A2owzeL00jyMQ2HZrkLumIPFFf
        KJKNCzJsbElw+9hwk67K8I5wCbolbUzoPJgggXQwM9ELc+HsGvdqDG/tCIJifk9bO533mEBg2mP/N
        WSlhu/pjIp3sLzolaWWxbDY8mYvEZd/IwRIN9/3rmDKE6UHE8sV+ACP82au7ZtVvyMa0Yfo8sbkGI
        GiWKA/VSCiIB85t+pL3FpCq0VywSQ4lFMoB7oPrqJADKdfrwpFOQVC/+GrnL5Mo1QnOdIJXF8zwHq
        mM6hlQfseZhmgh2rdjG6z/UC7Igsp9+ItgbYYuCE6sUx+7SJnEx0RgroWgDroxkbZ3ZOk9oXr0gMt
        27WVN/qA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5lMa-007vNj-Qe; Tue, 20 Jul 2021 08:44:38 +0000
Date:   Tue, 20 Jul 2021 09:44:28 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v15 00/17] Folio support in block + iomap layers
Message-ID: <YPaM7IsHKT0tu2Dc@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719184001.1750630-1-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Btw, this seems to miss a Cc to linux-block.
