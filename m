Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC5DF6B5C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 07:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfGQFFw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 01:05:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50624 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfGQFFw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 01:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=u07mpxIq6n4P5jfzGpWVKhHRL
        kiVqsJOdeAu3JcorirlSkA0wP12tBVO9Dr6UBRSw3PtaTuaWKbbv4LCl7sXFbsAfTeXQ29+MPymT+
        oD5TkFp16u2iBHW5YhRNekJV/cPDMhBmR2hWzm9wGJT0hlaDaMOiQ4qy2sdnOkUvUlQfB7FYoMm7Y
        01OprpzYMkWkFMB7S0tl6bQKV/U8RHlrzLHfCQ3TNrGzrLNLp+3GABt0x6FbLGXd9Gtt7fXkw6b2L
        cFut82ALBnL4FTXvalNbVNcdZoKBA7UU2O+wSFRsXT51ZzbdXXYeF1Yf9YCRkxgpPFMs+nzmwpE4C
        g/V6okkJw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hnc8V-0004lU-VV; Wed, 17 Jul 2019 05:05:51 +0000
Date:   Tue, 16 Jul 2019 22:05:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agruenba@redhat.com
Subject: Re: [PATCH 9/9] iomap: move internal declarations into fs/iomap/
Message-ID: <20190717050551.GI7113@infradead.org>
References: <156321356040.148361.7463881761568794395.stgit@magnolia>
 <156321361878.148361.6616574884425585291.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156321361878.148361.6616574884425585291.stgit@magnolia>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
