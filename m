Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256703BDC77
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jul 2021 19:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhGFRsA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jul 2021 13:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhGFRsA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jul 2021 13:48:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53ABEC061574;
        Tue,  6 Jul 2021 10:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2k//lQZ1oR8UEUZMP7yXp/YzbqPN1/QcyRRVdHeGZWA=; b=L9GOZHwbbPAbqgZWechngzs50L
        CXlJXA1s4nWTTwnYz4ohkPR2JFXiHJzKcs6Y1bzT0kZqtsI4+NQZoWUfoP3bDY+uhxSg48Ez958K0
        /8yEFkRpwKyNjilNFF3VFRFUKLlLwDhZKJBbfLkoDM0aZb1rtjG45aaQMjyCtONUZAjLtYzk3DauR
        0L4Dcca9AWTwMUFapdy3ONEDFLDPBfdPOc2D7m8rk9v7lTfAOPDm86XwKxpvqv/KgjZ+cg9HxbELF
        SVcBp0NMmOyMIcbMyFO+NVFIs42o2yjZZ/tJrq/zKUk69s0anlLsUeVeRjg/mVhrDHZufGdXOizZh
        t3Sc910w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0p84-00BcvP-W4; Tue, 06 Jul 2021 17:45:07 +0000
Date:   Tue, 6 Jul 2021 18:45:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Leizhen <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 1/2] iomap: remove the length variable in iomap_seek_data
Message-ID: <YOSWoMXPxYXX7K33@casper.infradead.org>
References: <20210706050541.1974618-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706050541.1974618-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 06, 2021 at 07:05:40AM +0200, Christoph Hellwig wrote:
> The length variable is rather pointless given that it can be trivially
> deduced from offset and size.  Also the initial calculation can lead
> to KASAN warnings.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reported-by: Leizhen (ThunderTown) <thunder.leizhen@huawei.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
