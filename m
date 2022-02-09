Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0C94AEA97
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 07:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbiBIGtR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 01:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiBIGtQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 01:49:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C320DC05CB82;
        Tue,  8 Feb 2022 22:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b/WCJj+IAa3iXel/d+P/0rJsMFgdLOczPIXqs1W2hP0=; b=lbYRkj2zLwFVlbeJRNox44n4Aa
        qQHSLuqtNu2uUND7p9zm8vLv7n2VLBVlmvk9qO7E8GJgxe5tZgGaZRaYDaXfJQxiJ6c6hub/xPcKr
        mJqlvLQ5N7dTcndix9674lGeUMYAdZT0LSezI7R1uZDNqta/so6/kfmuMcE7b0aeIqhvK1KwlV6/3
        n6o5eALqiW++om+Z8bfSbIP51OL5LGS4rmBMkxsXwgPozh/rDARVx265mqHkYjkRFrRNqmclJrOmE
        COzRIhp16varAp2LA+Gam5hM1f079OAoZfGYxwkkHC4eIUF0QAO1sSRUpZ7scCJkJ258RJrDARE5c
        QPTyfkTA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHgmr-00GOWe-Se; Wed, 09 Feb 2022 06:49:09 +0000
Date:   Tue, 8 Feb 2022 22:49:09 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     zhenggy <zhenggy@chinatelecom.cn>
Cc:     bcrl@kvack.org, viro@zeniv.linux.org.uk, ebiggers@kernel.org,
        axboe@kernel.dk, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] aio: inform block layer of how many requests we are
 submitting
Message-ID: <YgNj5SLMjwGON+Q+@infradead.org>
References: <8e0186ed-04bb-7bb8-ff09-581a7b9fdf03@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e0186ed-04bb-7bb8-ff09-581a7b9fdf03@chinatelecom.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 08, 2022 at 05:47:17PM +0800, zhenggy wrote:
> After commit 47c122e35d7e ("block: pre-allocate requests if plug is
> started and is a batch"), block layer can make smarter request allocation
> if it know how many requests it need to submit, so switch to use
> blk_start_plug_nr_ios here to pass the number of requests we will submit.
> 
> Signed-off-by: GuoYong Zheng <zhenggy@chinatelecom.cn>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
