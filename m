Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5494D6B690
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 08:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfGQGWD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 02:22:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55576 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfGQGWC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 02:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=KQK/F29wnx0iGndd3kzqC6Lqb
        yFOy6tIwc48ZjMwCnkMDpY9F80EZ4OwoLbaKq9oOVR5Vkwqlcy/RRW6pQy3QL8Nhlo2YhqEGv0PkY
        3VfbMEuuQGLEl++Dp9XO91UXVU2J1TB7mylxdeBIIrEwnkuN1HTfOtvypjlETgljubC4lFw1D7DH/
        wnEdZmH8YHn6mfRiFOVdmg9nTiGm/XiH7RMoZzbEPe+L8fSMCTKLKTXxzeTfQqoaWIiTd1KRHg1ls
        B6Y/oy1c4c9WKX+ZmspdXhMMuubaYbOhl6/uRWxrWf7sIRtDmdJMdOxyqrJ3M4FOoDHl4zGfWTlXZ
        JjmHj/DAg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hndKE-00080a-Gt; Wed, 17 Jul 2019 06:22:02 +0000
Date:   Tue, 16 Jul 2019 23:22:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agruenba@redhat.com
Subject: Re: [PATCH 1/8] iomap: start moving code to fs/iomap/
Message-ID: <20190717062202.GA27285@infradead.org>
References: <156334313527.360395.511547592522547578.stgit@magnolia>
 <156334314167.360395.8240505366577542787.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156334314167.360395.8240505366577542787.stgit@magnolia>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
