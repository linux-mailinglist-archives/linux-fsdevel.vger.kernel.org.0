Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB51494838
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 08:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238415AbiATHZ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 02:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiATHZ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 02:25:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB696C061574;
        Wed, 19 Jan 2022 23:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=xD3AB2sQgh7Yo9RGWsGUZUVWjM
        9wk8abWqwWjaDSv7+X0ysbXkmiWE4WLkWO/ONELlZoU1KL6JOGqLXGplnaYuuRWasPbEggAJymcuU
        HsW0vanHA21A+isph13xhSS1vXNajt4dyZS1STl30SxlD2Xmx1F17+DSkiPe9dZhnL/BRs2VQY+Pr
        C71JpPAqSdctLoUpEcesEeSHKN69FQxNzykmwNHWvrD0OQ4DZZzo0ycQsaocJtR3DYeUPmO1/THka
        W0v9IEPaFjxpbrVZIp5cU6z/Qp1n9fUY2cKthBs0PZ+4zMP4c8q67GRP4g+OXOFYIklf78chQ6OpZ
        24plwS1Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nARpP-009KS6-DK; Thu, 20 Jan 2022 07:25:51 +0000
Date:   Wed, 19 Jan 2022 23:25:51 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Anthony Iliopoulos <ailiop@suse.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] mount: warn only once about timestamp range
 expiration
Message-ID: <YekOf0DjnAaVt0rq@infradead.org>
References: <20220119202934.26495-1-ailiop@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119202934.26495-1-ailiop@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
