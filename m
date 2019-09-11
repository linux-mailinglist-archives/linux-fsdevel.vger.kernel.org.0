Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D15EAFA30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 12:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfIKKTa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 06:19:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58840 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfIKKTa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 06:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wVr5sXcwDs6pnyhJohgaa7TVQtRp5amDWn72nY3VOS4=; b=kUsENYAA0wKG3iKP/bPbzw9x4
        cIVr6LHCib8ChTdJHF3ZSbXA4zBihQhTzEhTgywimqtu73bzaTBgVyUPMgXC6BZ1WN10MIngw6aLP
        E9j4kOjV7990HBXfU9wOQNBIdtnWLpQRCMpLNprHwGNmBvhkcBySa7TVCqb3G8QekTBHP/MRkd1sE
        CP4Zkz+7K1/ve3J2YRSgt79KpNOqQbQf1D7qe3UW3ofOv6IMAuRNCTPuuK7JdHtEPUKwAwzSA2UFY
        HHKxXrLgMwNt/fA4fKPgsUysoXlX2TZCck3b/4V2oI7J3RnBm2zBeiql9YBvnkeL6icnNjRP+95zl
        5ZgeH9L5A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i7zic-0001bm-0O; Wed, 11 Sep 2019 10:19:22 +0000
Date:   Wed, 11 Sep 2019 03:19:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Andres Freund <andres@anarazel.de>
Cc:     Dave Chinner <david@fromorbit.com>,
        David Sterba <dsterba@suse.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, jack@suse.com, hch@infradead.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: Odd locking pattern introduced as part of "nowait aio support"
Message-ID: <20190911101921.GA6095@infradead.org>
References: <20190910223327.mnegfoggopwqqy33@alap3.anarazel.de>
 <20190911040420.GB27547@dread.disaster.area>
 <20190911093926.pfkkx25mffzeuo32@alap3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911093926.pfkkx25mffzeuo32@alap3.anarazel.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 11, 2019 at 02:39:26AM -0700, Andres Freund wrote:
> I do really wish buffered NOWAIT was supported...

Send a patch..
