Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8771EE15BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 11:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390874AbfJWJ2Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 05:28:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43164 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390165AbfJWJ2Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uGan0qkqY3Baf+Gu4EO36oLW37gG3cinwDiYCMyfjkw=; b=IPtlkSVbKd9G6jeWwzkZUcoqb
        4NVDb3fhL/u7bjVcexVJA80NrHgxO0mhThUzgtgQ543HR7W6XGJZ4U6xWi7m8tXDkiye2nX4Iy7tq
        Zo8VGdc+FuZ3+dVi4dGltCQJIux+pcP5Mo/CMVpWbGcV5khHPpEs5vjDiDjrMP+ulqaZ3VcJZF97N
        dAZzJ09V2tAZ/iMf+YsGSFaAE9+Tl7a945g6zchy+gJ2bgjSs4tcNAP2LdWu4lCPXVuvnaOXCGl4Y
        Ye4lqxGDjhYoyNu2MP1lc/2/gtxhSm01HlvGYUrbZ6jO0kCf8idq7xB+sAkRHsdaddi1xkOVxJY81
        gpahDH58A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNCwC-0007Zj-C9; Wed, 23 Oct 2019 09:28:16 +0000
Date:   Wed, 23 Oct 2019 02:28:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>, linux-fscrypt@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/3] fscrypt: add support for inline-encryption-optimized
 policies
Message-ID: <20191023092816.GB23274@infradead.org>
References: <20191021230355.23136-1-ebiggers@kernel.org>
 <20191021230355.23136-2-ebiggers@kernel.org>
 <20191022052712.GA2083@dread.disaster.area>
 <20191022060004.GA333751@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022060004.GA333751@sol.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 21, 2019 at 11:00:04PM -0700, Eric Biggers wrote:
> An alternative which would work nicely on ext4 and xfs (if xfs supported
> fscrypt) would be to pass the physical block number as the DUN.  However, that
> wouldn't work at all on f2fs because f2fs moves data blocks around.

XFS can also move data blocks around.  Even ext4 can do that for limited
cases (defrag).
