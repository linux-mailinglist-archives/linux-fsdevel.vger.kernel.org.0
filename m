Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A3625F3A6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Sep 2020 09:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgIGHMx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Sep 2020 03:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgIGHMw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:12:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E056C061573;
        Mon,  7 Sep 2020 00:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=lIUMQRBKQTrciZ46Z7wiI1odJn
        cJBFL3tZPO/6UCK9mZaij9BHVUNXZ84AmVpFspB9TG6OPeBxE+QISXAokCxxGuSpwnVP801y5YTSZ
        rGciVV3kEZMbSWv8J06cTw+90JHc/+SAao6X6hdznyb1MnK0Ih+duXgSrjtusI36EtAp3snoqanxq
        0bjncS3wyyFuB+P9rh+OLlgkRqfikgLteWlFbZGSAIo+4NsdpbzccXvz8DFFqPFutCq5m/x72xPTo
        kEyrtPXnu6yJ4vR7lKxI9v4tFS+Mo0hfOF1XaiSxPLx36OYw64yo5jLLRFJtZv6l4dpvSJ8JjIi0d
        oMixV9VA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFBKc-0007Lq-RQ; Mon, 07 Sep 2020 07:12:50 +0000
Date:   Mon, 7 Sep 2020 08:12:50 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        yebin <yebin10@huawei.com>, Andreas Dilger <adilger@dilger.ca>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] block: Do not discard buffers under a mounted
 filesystem
Message-ID: <20200907071250.GB27898@infradead.org>
References: <20200904085852.5639-1-jack@suse.cz>
 <20200904085852.5639-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904085852.5639-3-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
