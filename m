Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3960414EC2A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 13:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgAaMCz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 07:02:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43268 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgAaMCz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 07:02:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gYnF/PvwAzhZhFIs75dzhd6wJf8+DktW1gUKuPEenJA=; b=vBUXilMHNLtj1vS9yWywJsvLU
        6QBOCaaZFC+xh0ePodm/bvb7RFQrovybFb7UZeS3hk63TXS2BB4QXNkGwMKthoFqzKpAuUze04vW/
        kgSSBTuPK/as4JiP3B+pXhH+d4oShNs7hWl92rgExHG7BcUVsmLI8CY6wE+711DH7/O8fTUoSNRLc
        pwNMlMCDhAgl9g1LhSFkrZpJ+7iC8ngo9pMKrfYOYJD+M+yZzj0yeIRP0slhbzZxgbqlnzPa+0LWL
        U30de0I1uhrCECSOs7aOF8cWRZcBtyzdMGo9eT902vJX29lo7hzLj8/TADm22bNqeBNHA4TCLB4oI
        x88wyBR3Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixV0g-0007OX-Ed; Fri, 31 Jan 2020 12:02:54 +0000
Date:   Fri, 31 Jan 2020 04:02:54 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] xarray: Fix incorrect comment in header file
Message-ID: <20200131120254.GB4437@bombadil.infradead.org>
References: <20191206102903.9492-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206102903.9492-1-cgxu519@mykernel.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 06, 2019 at 06:29:03PM +0800, Chengguang Xu wrote:
> 256 means Retry entry and 257 means Zero entry,
> so fix it.

Thanks, applied.
