Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54167A3C63
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 18:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfH3Qn4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 12:43:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51894 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbfH3Qn4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5H1k8k4c3qyB9sMdciUC0lqd1YQSr7q8u+qPOEaPU88=; b=LEcBOoLDbhJUeam5JA69m/xmc
        6BLCOtAiSQW7m75ROOzCDLzdm6xAaf7Xr1mOMyedOQ9CrmwCYvbz4Q7o50yc27Ak9EQIhbbarEUTC
        F78Ee1J0fkWi5uQl41ggmR6X+rA/hL41Alcwp82lDSpzDVhv7wL0beLuN9bKlUkJPtBBV/nXPGZFe
        VDBcPzExZesCEQKWOLyqBE2/MBZwAnjoEpDEUsc1+JXEeOOG0dTrsbbQg28AaCmYGWFKWfhm1C/Hs
        DsJst1LzUlIKl50cN7o+ilqdxzKHzQMFPIHW3aRNMEptgRM+diufHAAgyXuAxKCJxijzPDHpLDfoD
        dMJ0geFsg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3k0B-0003L5-4E; Fri, 30 Aug 2019 16:43:55 +0000
Date:   Fri, 30 Aug 2019 09:43:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Merging virtualbox shared-folder VFS driver through
 drivers/staging?
Message-ID: <20190830164354.GA11197@infradead.org>
References: <f2a9c3c0-62da-0d70-4062-47d00ab530e0@redhat.com>
 <20190811074005.GA4765@kroah.com>
 <20190811074348.GA13485@infradead.org>
 <c8495f31-5975-d4b1-1dd4-28d01b594a9a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8495f31-5975-d4b1-1dd4-28d01b594a9a@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 29, 2019 at 05:05:49PM +0200, Hans de Goede wrote:
> So what is the plan going forward for vboxsf now?

ping Al and/or Andrew.
