Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73B9C2685C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 18:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbfEVQeG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 12:34:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40176 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbfEVQeG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 12:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XAl6XStfwn9ykHM+UMfrM7hmTarBLo+XcSj1ABpfYiY=; b=Nz5EWsqumDwGY/radcevcHEjO
        f/fyXL7GxouaJwIvI2j/gwTdQMiVik5ZtdWUHCSso4nZOwBrh4V5pU8rLaNs36LiEfwMfvZSQ8X8U
        LQWGxsC7JOwQiMcBb8PBrvxjxa+Y32UA+x7YUmr2HfQC3XLq/K+DnVdbdHWPAD+/5zdN6Ib00SEy7
        KrGyN/8NqLjqNTm2njntZ7y7KG8KN7WVrm8VpJ5FbwI+4coh+f71J+OOoLOUgH8rAzm+KpyV5Cyew
        wj/VpUOgXJ1tQOsfFK36Uyg4ROKXF3bD7GypkcdeoRKRiWodB7tq0KLwcJLM9aL3ew/fu1/1SahMI
        xZnOiJfrg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTUBp-0007Ev-8B; Wed, 22 May 2019 16:34:05 +0000
Date:   Wed, 22 May 2019 09:34:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCHSET 0/3] io_uring: support for linked SQEs
Message-ID: <20190522163405.GA27743@infradead.org>
References: <20190517214131.5925-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517214131.5925-1-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This just apparead in your for-linus tree.  I don't think queueing
up unreviewed features after -rc1 is acceptable..
