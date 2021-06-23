Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE16D3B160E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 10:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhFWInX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 04:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhFWInW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:43:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40470C061574;
        Wed, 23 Jun 2021 01:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=f+/7THUzicFw3diHwN+k3aOEpc
        ysL4yU/NZ7DeA4ALpGSTk3s6fgLaqEZlFjs2zIwkGcxJ7A1mq8ePFmwm/q9LDXWB9qERynuibfO5m
        oSkjFXS94lhHT29tQDEhcNG2klTOFjDh0AmqBXN8PgXLhDMSTHvK2mtzvzMfNHZn1Th40G6AQ/lg+
        NIL1LjZh68RvaT05ZySfATeIalJfSoecgkOVrMBI7U0k2svHi9LuG3KRiyT83+ihqmkUwIK8nTwwS
        bTwH/OJTXbCSuyk1MxS0m59wse7Mds7S3usyCahapQyETMZWeQ60gNIIgrxN3bsVgxadg1y/9g7tA
        7DYmty/g==;
Received: from 089144193030.atnat0002.highway.a1.net ([89.144.193.30] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvyQX-00FDmP-JM; Wed, 23 Jun 2021 08:40:22 +0000
Date:   Wed, 23 Jun 2021 10:37:53 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 21/46] mm/writeback: Rename __add_wb_stat() to
 wb_stat_mod()
Message-ID: <YNLy4b83SWza0UG1@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-22-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-22-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
