Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E97EF7247
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 11:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfKKKga (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 05:36:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57580 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKKga (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 05:36:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=Swru49g7s+A94QhHKZRBNdA6C
        k60AaFFEPs7AMy17/rEKs+sBONGiV2W42BotF5KCRcdxI+hx/S/PgvVwvbZcjiPZtqFATl74qkZWp
        k6dyUb94on2lnXQ4SY8ws/qbU5lATtgfKAzjXrHL3eTIzLCoJvI2OTxmL/sS+zX7MzL2EeIl1hrF0
        J6gtImUnhDKxgeBu1UlbCjo14cVJdcRPJJSW2zD2niWBiErzo/IK3+yVL25rCY15sC8Yjpbjf1FKw
        GGz2eSTK0O3fIZFrzceSD5Kah6lGgZLSZXZ32PkAJIPYRqR7/rmXmpu5oXfnYEkPVbHUkI965S7PZ
        MNG+g2EJw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iU73T-0007BK-Hy; Mon, 11 Nov 2019 10:36:19 +0000
Date:   Mon, 11 Nov 2019 02:36:19 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     darrick.wong@oracle.com, naresh.kamboju@linaro.org,
        hch@infradead.org, ltp@lists.linux.it, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, chrubis@suse.cz,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        broonie@kernel.org, arnd@arndb.de, lkft-triage@lists.linaro.org,
        linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH] iomap: fix return value of iomap_dio_bio_actor on 32bit
 systems
Message-ID: <20191111103619.GA25583@infradead.org>
References: <20191111083815.GA29540@infradead.org>
 <b757ff64ddf68519fc3d55b66fcd8a1d4b436395.1573467154.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b757ff64ddf68519fc3d55b66fcd8a1d4b436395.1573467154.git.jstancek@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
