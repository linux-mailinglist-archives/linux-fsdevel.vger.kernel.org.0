Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C64494A47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 10:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357642AbiATJD4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 04:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbiATJDz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:03:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DE4C061574;
        Thu, 20 Jan 2022 01:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vCmQST61Gssp/LtQabkAKar6zlZYErLWIVZSvHsW+Sg=; b=KTXARBZNDLnzHLigVKe5C8G1bR
        muRQKUxSWV7ViIBd19of16zhsKo/UGl9EV0KDVvimHXZEoFOnM6pEtaWhn3WiKwmBZtvFP4MXjF27
        jXIKyvt69RbaRWDCvdrmsK4ffKt5ElO7l3W+xhQZyy60Ndm42xm46j5/sGxSCnzxbYrqThpE53cAZ
        dgsDHnM2CBvApMJOV3WxD/YfuHEI0Uo4PVZQEBHNiF/wfjH6tQXv0EzCfWS0n7u2GF8EPMl+Fjji/
        2tvYfyk0zQhImSzBK8Xhj3xJfyCWw1S0HSBX+HnzaZ3RBxb1RjGeGeZKkd+K3ZLnuzEkhYpq5UTsk
        fpTDYmBA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nATMG-00A2Hw-KW; Thu, 20 Jan 2022 09:03:52 +0000
Date:   Thu, 20 Jan 2022 01:03:52 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     GuoYong Zheng <zhenggy@chinatelecom.cn>
Cc:     bcrl@kvack.org, viro@zeniv.linux.org.uk, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aio: inform block layer of how many requests we are
 submitting
Message-ID: <YekleGTvwbfHI/e2@infradead.org>
References: <1642497464-1847-1-git-send-email-zhenggy@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642497464-1847-1-git-send-email-zhenggy@chinatelecom.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 18, 2022 at 05:17:44PM +0800, GuoYong Zheng wrote:
> After commit 47c122e35d7e ("block: pre-allocate requests if plug is
> started and is a batch"), block layer can make smarter request allocation
> if it know how many requests it need to submit, so switch to use
> blk_start_plug_nr_ios here to pass the number of requests we will submit.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
