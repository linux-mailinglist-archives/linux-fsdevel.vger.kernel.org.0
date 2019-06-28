Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82C2C59DCB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 16:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfF1OcS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 10:32:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44652 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfF1OcS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 10:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=z59db2q7R3Qs4jp6ksud3JOvoxe9K7xlif6grC7p/kQ=; b=lTxr/EJA0YdHAqSEH5qzLBFLP
        42jOlBpT1JbuRG1wvwBpQ1qa/LBkUgDyp0fRyqB8o7sd7EqPfyrEM0WLXHygnty5VH2cmYV4+Z92O
        OYS5NAee8o2LgdZkFFeLtBEtyCczqi8Fj3ouPyTEnoTX2bkEL6xOByS5DFV8wulLt5WOrzz80KPoY
        1Fr240ld04fT4A1O5Cn6HNomln9tUVmVtT72MgirYml/jWFeYldqHdU4lDRP08MP1MTpPnhJRZYwI
        6N/HeiuZdzewgesoTQVrYFRrSG8hpRrPB0WsPnGngrIvd9FKAaAYRV8SJCfUIywKaotBoJbImlXaQ
        IKQmfjCwg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hgrvE-0001us-LS; Fri, 28 Jun 2019 14:32:16 +0000
Date:   Fri, 28 Jun 2019 07:32:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fat: Add nobarrier to workaround the strange behavior of
 device
Message-ID: <20190628143216.GA538@infradead.org>
References: <871rzdrdxw.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rzdrdxw.fsf@mail.parknet.co.jp>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 28, 2019 at 11:18:19PM +0900, OGAWA Hirofumi wrote:
> To workaround those devices and provide flexibility, this adds
> "barrier"/"nobarrier" mount options to fat driver.

We have deprecated these rather misnamed options, and now instead allow
tweaking the 'cache_type' attribute on the SCSI device.

That being said if the device behave this buggy you should also report
it to to the usb-storage and scsi maintainers so that we can add a
quirk for it.
