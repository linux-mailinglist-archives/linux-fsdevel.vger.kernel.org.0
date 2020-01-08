Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57088134493
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 15:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgAHOHe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 09:07:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56220 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgAHOHd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:07:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xn98h6aGpP7VX3AhP8VR25fODRZwIrLZDwToIQ0C3fk=; b=Q9k5DfWVhLXiQOF+5vf8sD0+w
        DCK56TOfdJ2AMFqXuQda+Ojc3wG26J3z2+4u6C15S2rMGjVhtz1Y0bbwO3v3zQAtO/B9kVOtGDqfP
        dxXUSTB62Vd2co5wpnhXy1OHmIGTPZWG+xdZOGWmvZC2NZoBztIC6HX9djljxzDeKmngl2roN/RLh
        Z9qqeyj+2gEGU8wx0JKcthyUKQCV7MX6Jyg1y0cUxmqgBIsqNxkGzDtItdvs5WjeVR57I2y9oHeRz
        Jl0pG86B9CEW8fusSwBfdbD2rfaccSuz7S9euWVD6o8EH/xD4DBsbhf1gon9q88AkbO1VMyq5ZP20
        yTiMtpXKw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipBze-0008Ol-UU; Wed, 08 Jan 2020 14:07:30 +0000
Date:   Wed, 8 Jan 2020 06:07:30 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v6 2/9] block: Add encryption context to struct bio
Message-ID: <20200108140730.GC2896@infradead.org>
References: <20191218145136.172774-1-satyat@google.com>
 <20191218145136.172774-3-satyat@google.com>
 <20191218212116.GA7476@magnolia>
 <yq1y2v9e37b.fsf@oracle.com>
 <20191218222726.GC47399@gmail.com>
 <yq1fthhdttv.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1fthhdttv.fsf@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 07:47:56PM -0500, Martin K. Petersen wrote:
> Absolutely. That's why it's a union. Putting your stuff there is a
> prerequisite as far as I'm concerned. No need to grow the bio when the
> two features are unlikely to coexist. We can revisit that later should
> the need arise.

With NVMe key per I/O support some form of inline encryption and PI are
very likely to be used together in the not too far future.
