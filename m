Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8AD9A55FB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 14:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbfIBM1L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 08:27:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45148 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730711AbfIBM1K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zmlFqohBdGnD9okb+s9Q0ZrXBWISBFgz5ZPgdIgZAow=; b=c4of95qTH/D9oMJ8yJH/UpKmL
        dELjvOjPwso+4MEzXPQU/x5qrxw8uyyNx99UbRljAXI6z6mXWbVjKM8d3d5evCLS/H2oAm+06CZvv
        oodNl0dTdD+tBu780qhrG1Y6Oag1PkeAFofSgdPw1FKp3z+0l7IpNcrZPV4t/0E6KjgwYlbdAVAwe
        xL0JkAd+yBOA2DCVvWWM5zaQ6fh3/bLQ/L3U+k5hM3rOMH5r9DK2mQaQCe3XAUYJQ+ALfqRW0xv4s
        8q6xP8Y4WCWxd9RWkaP3BhjXYPqq9Fzx8mA2jwh8Ot9pbAj3bOWFK3GcJ3KGSWXYH+JPRXKGYeh/U
        YH/5l3Jmg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4lQK-000473-GM; Mon, 02 Sep 2019 12:27:08 +0000
Date:   Mon, 2 Sep 2019 05:27:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH 17/21] erofs: use a switch statement when dealing with
 the file modes
Message-ID: <20190902122708.GO15931@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190901055130.30572-18-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901055130.30572-18-hsiangkao@aol.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks,

this looks much nicer.
