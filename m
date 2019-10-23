Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C940E15B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 11:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390866AbfJWJ1U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 05:27:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43136 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390400AbfJWJ1U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CS6l8CT81d+rQTdwvtyepLT7A36udW9pzFL6uXC4imE=; b=BLqXj+n0cwZj+xiVhD0XhdVei
        navF1Vt+rLXP1v7NYN0DwsLlyVpVgZh+yFR10a5/X2B7j/Lh0O6eW4BPu/ng3uRA/b7oM5S6SGWai
        T2du0PWd3hVEF1n4vFNAZCk3h1rFrgbgjnuIjEdY5nDO90O6MwpyCPhVjiKmUkObL0obrudYfo6hI
        jPO7TRXi/sVj1GzA5tyQ2h0gKfgewSqnR2TfQH03LAru5wMdXnjuKtCQGvIjvyNYy35Lg+/WawQvz
        wsunSBUm4u2U9h5hHI+mT+7qLtlQ2j5WzJcHjJlfMHS6gFPZmOTeVzZtqnTJLBm73f4ilwewrH/Oc
        l+a00VBKw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNCvH-0006p0-0m; Wed, 23 Oct 2019 09:27:19 +0000
Date:   Wed, 23 Oct 2019 02:27:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Dave Chinner <david@fromorbit.com>, linux-fscrypt@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/3] fscrypt: add support for inline-encryption-optimized
 policies
Message-ID: <20191023092718.GA23274@infradead.org>
References: <20191021230355.23136-1-ebiggers@kernel.org>
 <20191021230355.23136-2-ebiggers@kernel.org>
 <20191022052712.GA2083@dread.disaster.area>
 <20191022060004.GA333751@sol.localdomain>
 <20191022133001.GA23268@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022133001.GA23268@mit.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 22, 2019 at 09:30:01AM -0400, Theodore Y. Ts'o wrote:
> If and when we actually get inline crypto support for server-class
> systems, hopefully they will support 128-bit DUN's, and/or they will
> have sufficiently fast key load times such that we can use per-file
> keying.

NVMe is working on a key per I/O feature.  So at very least the naming
of this option should be "crappy_underwhelming_embedded_inline_crypto"
