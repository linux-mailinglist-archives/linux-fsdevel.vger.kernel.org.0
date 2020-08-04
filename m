Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6601F23B23A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 03:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgHDBVY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 21:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgHDBVY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 21:21:24 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0557EC06174A
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2020 18:21:24 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2ldn-008o3X-DU; Tue, 04 Aug 2020 01:21:19 +0000
Date:   Tue, 4 Aug 2020 02:21:19 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     sfr@canb.auug.org.au, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] init: fix init_dup
Message-ID: <20200804012119.GJ1236603@ZenIV.linux.org.uk>
References: <20200803135819.751465-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803135819.751465-1-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 03, 2020 at 03:58:19PM +0200, Christoph Hellwig wrote:
> Don't allocate an unused fd for each call.  Also drop the extra
> reference from filp_open after the init_dup calls while we're at it.
> 
> Fixes: 36e96b411649 ("init: add an init_dup helper")
> Reported-by Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> 
> Al, feel free to fold this into the original patch, as that is the
> last one in the branch.

Done and pushed, along with regenerated #for-next
