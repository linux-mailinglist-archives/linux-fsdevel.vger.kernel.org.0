Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 349C71409C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 13:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgAQMb7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 07:31:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43268 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgAQMb7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 07:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nZrBKTkYJeqcb/cXGamX396QKjxFmliww7OTt1Ylid8=; b=hiJtxfwjhqJa9nokZWYLYX7OI
        JRfsiyJjs5tsU8pvG6Yh3cLx3vmXA729b5fQ7PMcI+nPi9x4rqNa1RRLmQdwmrZExc11yVHoGCGZj
        +RzNKQoyfueuOTnuZvIoKfoThLiNl+srvy7F3ZZj5+ghKIL8zRRp8Du5Ka/vJgh8dBBj8ZL5MU4Rk
        vPtJFort+fWwLuty8vXNdf4Ta2IobUr5txSUbfaiOwHkZDpF8RTymGAS+AcsWs88pxnTqiVUb9gHG
        Ky4u+cjUGLIzLLBxSjwRvbkFpp5MUNbw01aXQ9cAV9uJGHAYL+a3Etebo8EUWilSvtc0IRIhFcwax
        m34ReJbiw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1isQn7-0002E1-OF; Fri, 17 Jan 2020 12:31:57 +0000
Date:   Fri, 17 Jan 2020 04:31:57 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v6 4/9] scsi: ufs: UFS driver v2.1 spec crypto additions
Message-ID: <20200117123157.GA8481@infradead.org>
References: <20191218145136.172774-1-satyat@google.com>
 <20191218145136.172774-5-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218145136.172774-5-satyat@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 06:51:31AM -0800, Satya Tangirala wrote:
> Add the crypto registers and structs defined in v2.1 of the JEDEC UFSHCI
> specification in preparation to add support for inline encryption to
> UFS.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  drivers/scsi/ufs/ufshcd.c |  2 ++
>  drivers/scsi/ufs/ufshcd.h |  5 +++
>  drivers/scsi/ufs/ufshci.h | 67 +++++++++++++++++++++++++++++++++++++--
>  3 files changed, 72 insertions(+), 2 deletions(-)

I'd merge this into the next patch.
