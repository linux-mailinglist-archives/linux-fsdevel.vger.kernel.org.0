Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9888A1B8558
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Apr 2020 11:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgDYJn4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Apr 2020 05:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726046AbgDYJn4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Apr 2020 05:43:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC03C09B04A;
        Sat, 25 Apr 2020 02:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3DlQ8ZnRScvyKzq/lpT+XdAwEdxgGA1reTTkPrNBrJQ=; b=BEJTMa6qlqlanHbw9YGhD4RCHg
        6xgFoTyFKTtwzhDhlHDcDo1wgwyHzBlPGsgSbV/OK5Q3USFRLANCGbYqs8cGYVvOTh5qCLKwpcgJx
        ooU80jPHqxo8oYBGCLKvyS1XjcPZwVnog7GJ7QG8+LdhoiCwqx0Ubt8R25pVZi98E6WxXJho3fD0M
        U696Zy/CsCyP2nMWlt6I3Bii6CHG60NFcTXvpaS8OgmcvRxJqGNdH+uTWeDm/jKaRtgSwLCaozZ//
        vPQNBfytELNn6LXvJlTUJ6CBiAHHubpi0QtirCTIweNIaDTf9UZg0xh1KECOvvDveygu5ziCNcjq3
        8RK9Yfeg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSHLi-0003RE-V8; Sat, 25 Apr 2020 09:43:50 +0000
Date:   Sat, 25 Apr 2020 02:43:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ext4 <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Subject: Re: [PATCH 0/5] ext4/overlayfs: fiemap related fixes
Message-ID: <20200425094350.GA11881@infradead.org>
References: <cover.1587555962.git.riteshh@linux.ibm.com>
 <20200424101153.GC456@infradead.org>
 <20200424232024.A39974C046@d06av22.portsmouth.uk.ibm.com>
 <CAOQ4uxgiome-BnHDvDC=vHfidf4Ru3jqzOki0Z_YUkinEeYCRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgiome-BnHDvDC=vHfidf4Ru3jqzOki0Z_YUkinEeYCRQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 25, 2020 at 12:11:59PM +0300, Amir Goldstein wrote:
> FWIW, I agree with you.
> And seems like Jan does as well, since he ACKed all your patches.
> Current patches would be easier to backport to stable kernels.

Honestly, the proper fix is pretty much trivial.  I wrote it up this
morning over coffee:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/fiemap-fix

Still needs more testing, though.
