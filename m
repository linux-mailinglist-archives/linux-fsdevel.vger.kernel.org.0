Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9C5CD34B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2019 18:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfJFQBY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Oct 2019 12:01:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56704 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfJFQBY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Oct 2019 12:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XDTB2wPNRQq/GtKTuuQ0G2EIkR/DKBwjHoejV6N/5wU=; b=gIkayCzt8TWph/0o6rd8g1qSS
        Hs7EOuShQb6WZb/iDIAEYk+rHTui2z6Kdpxyd2LVlRtZIKlFED4d4bwHOG6jyjgnqvf/L1xF8XTGJ
        ewrgWbGlUFWgybtANcNK/IME+rSnVsgNQR5d6aoPavODBGj/ws/I+XvCIYDskLn+IvFiYbK1FvSXe
        yTlBx8VxTWd6bKCi3jCoL/Y5gq78Ptt+fDbK2gZpGdBD5czXsme0uTvDyQFZhkWQCbFEij0lo5dUs
        Ll8BEFdzwdWPK4NbsCC1GHETIlkVEJiu28hX6WrPd3FdERmyoCmLTacKyEnOPnecmIQNr/HVvQ4an
        EwVBKpOsw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iH8yH-0004wj-9O; Sun, 06 Oct 2019 16:01:21 +0000
Date:   Sun, 6 Oct 2019 09:01:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Torin Carey <torin@tcarey.uk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/seq_file: export seq_put_hex_ll symbol
Message-ID: <20191006160121.GA13568@infradead.org>
References: <20191001135322.GA26299@kappa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001135322.GA26299@kappa>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 01, 2019 at 02:53:24PM +0100, Torin Carey wrote:
> The seq_put_hex_ll symbol should be exported to allow dynamically loaded
> modules to call the function.

Please send it along with the series for your patch adding a user.
