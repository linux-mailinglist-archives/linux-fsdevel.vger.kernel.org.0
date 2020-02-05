Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD8F153916
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 20:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgBET2F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 14:28:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53168 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgBET2F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 14:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QABBpGTAcCBsCMraQQqa4epo9mEJxyTHyWGoCeCqXq4=; b=UZeijFCYL90Ju1tY93FKw+Ovyk
        zxCkS0hA6/VyUT88ABiVyLEvL2YmCfkBb+A5F9s0mC8s/ttjcpKCfkawMH5vbl1cVbvyllyb9Vray
        Qwx98snsC4nwoQ5uqWqpLG8lnEtICzQlig426NvljpsdDTZQdxM+8yA3CUKBDNloVPOLA+KWNl3gY
        pdTHrBK7bfxsxTOpOGv7f+mlSVW8M+AsZNqpHtb+Sm+AQQSgJ6Z8JKOPjNysr0WkZweH/5Q8c8rJ8
        9KXmVJsMkUkhbLDV0rPwbmOXJ95a3EArWndpMQa6OY8loopDTn0OYvPKz6m+2I4y/7wPWkESncpiB
        u/TaB2UQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izQLC-0000eg-2S; Wed, 05 Feb 2020 19:28:02 +0000
Date:   Wed, 5 Feb 2020 11:28:02 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     dan.j.williams@intel.com, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org, willy@infradead.org, jack@suse.cz
Subject: Re: [patch] dax: pass NOWAIT flag to iomap_apply
Message-ID: <20200205192802.GA2425@infradead.org>
References: <x49r1z86e1d.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49r1z86e1d.fsf@segfault.boston.devel.redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 05, 2020 at 02:15:58PM -0500, Jeff Moyer wrote:
> fstests generic/471 reports a failure when run with MOUNT_OPTIONS="-o
> dax".  The reason is that the initial pwrite to an empty file with the
> RWF_NOWAIT flag set does not return -EAGAIN.  It turns out that
> dax_iomap_rw doesn't pass that flag through to iomap_apply.
> 
> With this patch applied, generic/471 passes for me.
> 
> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
