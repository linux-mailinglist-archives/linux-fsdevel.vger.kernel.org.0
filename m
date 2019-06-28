Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10EB2594C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 09:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfF1HZW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 03:25:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49804 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfF1HZV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 03:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=L59glztjBFdzd0vpM/vAEVkumpBm6raQTV6rgoEfnoA=; b=Zer0a/jPvQOc99VEP2rbwm2/r
        584J1SYdkxFucp5cUWZZtRfM2ngZMJlyoVBRF7VAcuc9sdLj4zpuDbbeDkVeZ7SE2NFhttNNXosU4
        vVv5+fJP/Yfs975tI2b2X3ophH2KxjRVMrFHOUsdEsHpaPWhmD8RtnDj6skxrqp6ERc7mGcKHBWHC
        3xG9cHW7TpLICuZD6pgbV07Wi6izh7qeZmTFqyTl6lkqlBv9GQnZMm3F0S2sQ9khVB1bBCAkN+4Se
        BpfeStB3nggiwQp3CYx98ofVBk9bQxwWNPyq7Izwiad12RzO1bJ/LVqYNjVgfidNRGBtM7eGj65dx
        4/jZ5dS9g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hglG2-0001az-TF; Fri, 28 Jun 2019 07:25:18 +0000
Date:   Fri, 28 Jun 2019 00:25:18 -0700
From:   'Christoph Hellwig' <hch@infradead.org>
To:     kanchan <joshi.k@samsung.com>
Cc:     'Christoph Hellwig' <hch@infradead.org>, 'Jan Kara' <jack@suse.cz>,
        "'Martin K. Petersen'" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, anshul@samsung.com,
        linux-fsdevel@vger.kernel.org, prakash.v@samsung.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 0/7] Extend write-hint framework, and add write-hint
 for Ext4 journal
Message-ID: <20190628072518.GA25577@infradead.org>
References: <CGME20190425112347epcas2p1f7be48b8f0d2203252b8c9dd510c1b61@epcas2p1.samsung.com>
 <1556191202-3245-1-git-send-email-joshi.k@samsung.com>
 <20190510170249.GA26907@infradead.org>
 <00fb01d50c71$dd358e50$97a0aaf0$@samsung.com>
 <20190520142719.GA15705@infradead.org>
 <20190521082528.GA17709@quack2.suse.cz>
 <20190521082846.GA11024@infradead.org>
 <20190522102530.GK17019@quack2.suse.cz>
 <00f301d52c1d$58f1e820$0ad5b860$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00f301d52c1d$58f1e820$0ad5b860$@samsung.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 26, 2019 at 06:17:29PM +0530, kanchan wrote:
> Christoph, 
> May I know if you have thoughts about what Jan mentioned below? 

As said I fundamentally disagree with exposting the streams mess at
the block layer.  I have no problem with setting a hint on the journal,
but I do object to exposting the streams mess even more.
