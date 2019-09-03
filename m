Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03622A6124
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 08:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfICGQF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 02:16:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52274 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfICGQE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 02:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xuEBZWOCInCyL2ssbEtjYC1CQKH+4u9D0fLGnPJ4ZQE=; b=Ar8AVZVTD6fmXNlmZYSXzJgSi
        IkYykApZ8rEj5oI8HcXgnnFWzaOZxzJgH1SYPYctW2EyZXAsr7gsPqoJj+K/FeddZhQjY8kbJ2bdg
        mA1LWnBHxu0qlRucxdVqumq4+GgqIOD8u0UwRIUrpod+MrInNE8PRVBKQ074DwQ8QVe2V9ssk8EmB
        LBaaMXgmKo7/28Cl0cl3yfbBD5q1t5HCrbJ/NzAq7q9sdyhu+c4ReTHdENYuAcvqHBLBHRYsUN6Ur
        HoSnIXRFJ3Y9LLr10P0y3I/iOn0rg/ej6eCwQwLg/yY25kELxXpO65QplBMwLnOb0oBO8lp5aB8ab
        s47b8Y7LQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i526k-0008R6-Ol; Tue, 03 Sep 2019 06:16:02 +0000
Date:   Mon, 2 Sep 2019 23:16:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Dave Chinner <david@fromorbit.com>,
        Hannes Reinecke <hare@suse.de>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH V4] fs: New zonefs file system
Message-ID: <20190903061602.GB26583@infradead.org>
References: <20190826065750.11674-1-damien.lemoal@wdc.com>
 <BYAPR04MB5816E881D9881D5F559A3947E7B90@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20190903032601.GV5354@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903032601.GV5354@magnolia>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 02, 2019 at 08:26:01PM -0700, Darrick J. Wong wrote:
> 
> Given that the merge window apparently won't close until Sept. 29, that
> gives us more time to make any more minor tweaks.

I think 5.3 final should be out at about Sep 15.  Isn't that the
traditional definition of closing the merge window?
