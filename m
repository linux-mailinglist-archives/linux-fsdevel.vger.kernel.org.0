Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733BF1F8DCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 08:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgFOG1G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 02:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgFOG1G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:27:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CBEC061A0E
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2020 23:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=02zSAVs97b+4S+6UUvwmIgk/E7Qh5yuK4icT2t8Fjcc=; b=pBLZWQmtGQNEFpnUmqdoKMx0Qa
        xD647YILRxm8MNFgnLsn6oRXcNfjiuNonRm4ywoUexuNSp62ZyvJSYuYNox5iuvrhzYLa2y53oswh
        mu9A93GpjPsvqcAv1SlimXez/jO16KV5Gs68r8JN548m7HCUhX0Pa1Ne6ReTM4Svxny+ThLyzZSwW
        bV/pUV6o8yErhbEAdtSHt3TE9Ai3bzeCfEx4Hf3RacWU7/rIVA3l37xsLHMT22QMD1zX79M8tIbO3
        CDNiR+zTTSkKM54gOoc8xSr8stmWkjxvxFgm/59kF1Yowu4lH1c7594+JfSfg5JYqM2eFEmjd4I9t
        f7HmLDMg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkiaF-00074b-8w; Mon, 15 Jun 2020 06:27:03 +0000
Date:   Sun, 14 Jun 2020 23:27:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Martijn Coenen <maco@android.com>
Subject: Re: [PATCH 1/4] writeback: Protect inode->i_io_list with
 inode->i_lock
Message-ID: <20200615062703.GA26438@infradead.org>
References: <20200611075033.1248-1-jack@suse.cz>
 <20200611081203.18161-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611081203.18161-1-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 11, 2020 at 10:11:52AM +0200, Jan Kara wrote:
> Currently, operations on inode->i_io_list are protected by
> wb->list_lock. In the following patches we'll need to maintain
> consistency between inode->i_state and inode->i_io_list so change the
> code so that inode->i_lock protects also all inode's i_io_list handling.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
