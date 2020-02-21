Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBCB167FFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 15:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgBUOUU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 09:20:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36952 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgBUOUT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:20:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LytBCHQtySSQHC//YYsk3cTp1SDQnnhLtWFiulJBZy8=; b=DZyV9UxLlQ1dXSvWlM5ACgoz8S
        66UCzAs+/vDp19vCMf/XiGjrgq/QpQ5MSmVm/cq7+gbhKX2cMIX1taXRr/28lPIKdmzmh69nv04Ah
        jwc9CKCejXv0Yp4mbSM/q3/tDIhqtMMSmNl9pu3s8tg24ZdjHzYMMgLs+rc7QJw5HNC07Z3yyMc8F
        LrWSlmph5HCQzhVD6l+1jhZTBzUgoCltUXUStnxF/6+NXmWhqg6fe/7W9ZhC1tQlUPJRTzQ06pK5k
        wVCnFwUDhQ7pTnQaf3ggXDyfYcZZNw61QTbu1cIlLeHfVXYoXnrImvysZ5JDQhd9ynz72vOhOetCJ
        eJPdKzew==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j59AA-0005Lk-DL; Fri, 21 Feb 2020 14:20:18 +0000
Date:   Fri, 21 Feb 2020 06:20:18 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v6 0/9] Inline Encryption Support
Message-ID: <20200221142018.GA27636@infradead.org>
References: <20200108184305.GA173657@google.com>
 <20200117085210.GA5473@infradead.org>
 <20200201005341.GA134917@google.com>
 <20200203091558.GA28527@infradead.org>
 <20200204033915.GA122248@google.com>
 <20200204145832.GA28393@infradead.org>
 <20200204212110.GA122850@gmail.com>
 <20200205073601.GA191054@sol.localdomain>
 <20200205180541.GA32041@infradead.org>
 <20200221123030.GA253045@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221123030.GA253045@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 04:30:30AM -0800, Satya Tangirala wrote:
> Hi Christoph,
> 
> I sent out v7 of the patch series. It's at
> https://lore.kernel.org/linux-fscrypt/20200221115050.238976-1-satyat@google.com/T/#t
> 
> It manages keyslots on a per-request basis now - I made it get keyslots
> in blk_mq_get_request, because that way I wouldn't have to worry about
> programming keys in an atomic context. What do you think of the new
> approach?

I'll try to review it soon, thanks!
