Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0E988EEE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2019 02:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfHKAuQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Aug 2019 20:50:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49124 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfHKAuP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Aug 2019 20:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N9qHG5FobHFmT4rkQo3PFVZpSKU0NN5IiUhERipZ6h0=; b=ikfD3Oo2xpw64ZFgVtbEFnSvx
        amgrD0dTm+fHAtzsqaZW13EoxyDYc1KI2BzNf0AfMtIvkWg8e/X9MyK33ZlFt+soyxRq10PV4VFN5
        taT5y4WWl/2oz4eAxuc5XlKLdDJxZcbA+9Lh9Ns0foroNuI3XPBXS9v2GfcwUBwMsOh19aMY79+pL
        AT3pBAev2oStp9iyZkVu0aQV+NGFy3wrzUyJ9/EdssipmHSWZLim6AL5RsNWjekIoqp/V6SGjUEvf
        o0wta94KpY7mmVVDoTZSXSSFnPkO7w+D8LSJCP3zwVd85Syqp5w/PGcA4lT3lmu6OnZrCbHn98Mhk
        Zl7ROOP5w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hwc3p-0005K5-3i; Sun, 11 Aug 2019 00:50:13 +0000
Date:   Sat, 10 Aug 2019 17:50:13 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Merging virtualbox shared-folder VFS driver through
 drivers/staging?
Message-ID: <20190811005012.GA7491@bombadil.infradead.org>
References: <f2a9c3c0-62da-0d70-4062-47d00ab530e0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2a9c3c0-62da-0d70-4062-47d00ab530e0@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 11, 2019 at 12:25:03AM +0200, Hans de Goede wrote:
> But ATM, since posting v12 of the patch, it has again been quiet for
> 2 months again. Since this driver is already being used as addon /
> our of tree driver by various distros, I would really like to get it
> into mainline, to make live easier for distros and to make sure that
> they use the latest version.

fwiw, v12 never made it to the list.  0/1 did, but 1/1 didn't.
