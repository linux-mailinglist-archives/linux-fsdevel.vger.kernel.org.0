Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B35DA3C6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 18:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfH3QpG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 12:45:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57830 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfH3QpG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EjPCP/lS5BrD823XNmGioFrhKTKS0xVzCVHwqNjQBtk=; b=SWCZr5rZtRbnf8uRCrgJMU40xs
        eunE6E1zwoUByK//GcqH7bKvr38BC3tFi8C5et3Hy0dyt25VumssQd0n6iWbQ6Xni+8qOTHGjxE9f
        Xow44G+iF0N7rTeEXJ9G7ZVsl8m35PcBG+aqWacvUn3PKBmMkqzsjPJlBvsk2YkpvrOVxGDdrAX7z
        vHwtOtPXg99AL/dal2+kH1z2fdvBGs8Gkcyv5yix/JWF6H4BqeJyCTIkCHdh5bqJDv2SBV/X5Ha1z
        l7B1HjR/ilLg2Pr//FiEeSLDhAUgLpTOIdkoFoZi5CJm9lzj9oTDByNwsfuVwhkCbjCd8WswL9caE
        cIOTg5ZA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3k1H-0004UA-M5; Fri, 30 Aug 2019 16:45:03 +0000
Date:   Fri, 30 Aug 2019 09:45:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/staging/exfat - by default, prohibit mount of
 fat/vfat
Message-ID: <20190830164503.GA12978@infradead.org>
References: <245727.1567183359@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <245727.1567183359@turing-police>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 30, 2019 at 12:42:39PM -0400, Valdis Klētnieks wrote:
> Concerns have been raised about the exfat driver accidentally mounting
> fat/vfat file systems.  Add an extra configure option to help prevent that.

Just remove that code.  This is exactly what I fear about this staging
crap, all kinds of half-a***ed patches instead of trying to get anything
done.  Given that you signed up as the maintainer for this what is your
plan forward on it?  What development did you on the code and what are
your next steps?
