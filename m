Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1DB5EF1FE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 01:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbfKEAdR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 19:33:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40998 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729137AbfKEAdR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 19:33:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wV0F6yJ/zqq3L+kv3YDjr6sdISX9U0BeCs3/AfpD054=; b=CqMn8kblt+lfvWoNWdFlWsw+b
        Zo46970njfdNwt3QRWM9lbscwc9/jQaLVesxeNBKAShK9e2cQSjxsjUhS85C40bAyBWBTnuyb7Ljz
        NFHdKav6y9rx8vgst5V757cV/xnMg/KxvvJ92IgGrgAJexdSuAzPinKiRSm0CQCvzN9mhSp/oJxcU
        uVGuEX3Ylo1UfXkB000SrVabC4tr09oc1IoKbg5Y65woTviF+Q6aeWyikT/pLKGhgOCpGt4OU7Vbp
        hpVnjG0kzFHdcpRDz6sSNaFh6pfqWMnvpykaV+euK5DXGTAWchpaXUTLXXI897GRsGrKXgClCt5yq
        /EGmKJ7uA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iRmmQ-00061c-1a; Tue, 05 Nov 2019 00:33:06 +0000
Date:   Mon, 4 Nov 2019 16:33:06 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-xfs@vger.kernel.org,
        Jan Kara <jack@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 10/10] errno.h: Provide EFSCORRUPTED for everybody
Message-ID: <20191105003306.GA22791@infradead.org>
References: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
 <20191104014510.102356-11-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104014510.102356-11-Valdis.Kletnieks@vt.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 03, 2019 at 08:45:06PM -0500, Valdis Kletnieks wrote:
> There's currently 6 filesystems that have the same #define. Move it
> into errno.h so it's defined in just one place.

And 4 out of 6 also define EFSBADCRC, so please lift that as well.
