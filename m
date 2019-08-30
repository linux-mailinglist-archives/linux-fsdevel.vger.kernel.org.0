Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B841AA3A76
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 17:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbfH3Pgt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 11:36:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57820 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfH3Pgs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=93WudhjZ/7xMl3hmNwhgEaX4yRqNBxu9/y9u0PV6xso=; b=NBtdgbKWOzN5GwzwZepTB6VHF
        xu8AdemKZdBmb29lTV5i609Dd4738mggdVIrYC1Z9L91PnBRbIz5ilAXJ8Xk2miyGlm7lBter5Hsl
        JaBPEVCwRADDacBN1at2pJ+u62vBMrcxE6l3QLu7UYytNdL+P1NZAdqAxorWqeEpUfW4/Z5uNQir1
        DB5OpT3k4z6KLIw2vb9Q/6vLncoZA0v9TLWGwG1BPrD+QcoNOpcTHFtuUKWUzTEGiq5ScRT9nhlXO
        C/TQOxogIY7h0Vhh+5GNfUNvkQn/i3B3gUqkUAuVnoNUCedCNBrcDzo/j3wncZMR4ANhCMjtZXjsM
        0ahObHONA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3ixA-000162-EL; Fri, 30 Aug 2019 15:36:44 +0000
Date:   Fri, 30 Aug 2019 08:36:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>, devel@driverdev.osuosl.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20190830153644.GA30863@infradead.org>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190828170022.GA7873@kroah.com>
 <20190829062340.GB3047@infradead.org>
 <20190829063955.GA30193@kroah.com>
 <20190829094136.GA28643@infradead.org>
 <20190829095019.GA13557@kroah.com>
 <20190829103749.GA13661@infradead.org>
 <20190829111810.GA23393@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829111810.GA23393@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 29, 2019 at 01:18:10PM +0200, Greg Kroah-Hartman wrote:
> Hey, that's not nice, erofs isn't a POS.  It could always use more
> review, which the developers asked for numerous times.
> 
> There's nothing different from a filesystem compared to a driver.  If
> its stand-alone, and touches nothing else, all issues with it are
> self-contained and do not bother anyone else in the kernel.  We merge
> drivers all the time that need more work because our review cycles are
> low.  And review cycles for vfs developers are even more scarce than
> driver reviewers.

A lot of the issue that are trivial to pick are really just very basic
issue that don't even require file system know how.  Or in other ways
just a little less lazy developer that looks out for similar code
outside their own little fiefdom.
