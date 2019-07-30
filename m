Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCDA97AB5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 16:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbfG3Osl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 10:48:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41188 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731560AbfG3Osk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fbUXO6aERABszi1JdLygfngtRGTRqJkpked0b/5H4Es=; b=JiUIb5LoVrQ5Ad2IRWbUwi1Rh
        Fa6P+CIwwXRwxtYA3MiOGA6tEwViJVM/Z0N86o+3TIJLiUJsZ6J2Y/1JdFIioLd//MvhMs2tVRpBy
        Gb3v9AC6k7lcpJroN/uV57whDHUvaMxCMeutNL85xJCSDRWvRi4LVTn8wVe/TEpRi6VdaxOmN2aoq
        W2UPzsuumARtfSHznGGBDBb4y6oUnkc5LZJHgyiTU10DYpGMnuicTpcDaQ77AnKeORip9l7VyywYs
        DHFadtPu3la2th13ErR2UqIV4RO8C95/r0E8ElxKodakr/OAaYgoUXixo+G/P9K9Ti7W5kS7gHuJc
        Qa0Z2s1Jw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hsTQd-0005mh-Ev; Tue, 30 Jul 2019 14:48:39 +0000
Date:   Tue, 30 Jul 2019 07:48:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Damien.LeMoal@wdc.com,
        agruenba@redhat.com
Subject: Re: [PATCH v4 0/6] iomap: lift the xfs writepage code into iomap
Message-ID: <20190730144839.GA17025@infradead.org>
References: <156444945993.2682261.3926017251626679029.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156444945993.2682261.3926017251626679029.stgit@magnolia>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I don't really see the point of the split, but the result looks fine
to me.

