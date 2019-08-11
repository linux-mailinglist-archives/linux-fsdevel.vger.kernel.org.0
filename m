Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 225D38903B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2019 09:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbfHKHnv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Aug 2019 03:43:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59760 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfHKHnv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Aug 2019 03:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2GtwKSGd90x27mJ5ljk2jwpDv5vOp5d62do3a+7TmVA=; b=ArQ/p+sYfXjOYba0LvScl+g1v
        ZPtu78OZpRnf0FrAu7AR1xh65d+ypk3MpvjI1stEhtUKQU2wMxodcnpjWppE1JSiNxQLetFws6Hl3
        irxp5altVdDxX36MutJUCYnmICIwtDe6fCp0GYdrXueD8xFbK8s0uR9+D429mzkZDN5RuTkh1m0Wo
        Ms648Ob6MfYqb/D09uTkVSPfPvHDPhb+qhtLuLJfZ9HRnQX0Hr0E+0wFNjt1jVeaeMKFNy6NOV1sm
        AOVG/6m1s/sM5zBrYZL0BQawgApZgXC7FPBmZq+4F8tJaY0b6ZqzVYuFVg7ZW/6+f/EqDq3vJ5X7C
        WvWl0+8uQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hwiW4-0003ax-EC; Sun, 11 Aug 2019 07:43:48 +0000
Date:   Sun, 11 Aug 2019 00:43:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Merging virtualbox shared-folder VFS driver through
 drivers/staging?
Message-ID: <20190811074348.GA13485@infradead.org>
References: <f2a9c3c0-62da-0d70-4062-47d00ab530e0@redhat.com>
 <20190811074005.GA4765@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811074005.GA4765@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 11, 2019 at 09:40:05AM +0200, Greg Kroah-Hartman wrote:
> > Since I do not see the lack of reviewing capacity problem get solved
> > anytime soon, I was wondering if you are ok with putting the code
> > in drivers/staging/vboxsf for now, until someone can review it and ack it
> > for moving over to sf/vboxsf ?
> 
> I have no objection to that if the vfs developers do not mind.

We had really bad experiences with fs code in staging.  I think it is
a bad idea that should not be repeated.
