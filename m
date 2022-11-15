Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED716293BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 10:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbiKOJAJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 04:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiKOJAG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:00:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E96B6578;
        Tue, 15 Nov 2022 01:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=70wOmkh8d4B1DUWzEWWtU+Sq0btacFoBTBMqgMJC8io=; b=yvrwTcDiCDBJgYNS3lBRJ7DXFg
        VVRn+4llyz8lYutVgRn5B5OxpOzSPMLPJv+NsFspPYWH5YXBuxsm35zJBfnAcqmJDjcYfbU6YfbeW
        gG3BK5jRZoUqS2XPjoe685v980GhqtTJyjxyHKZfQnWymSQHSmvLW8LZmMHA6O9rl/o5067YnMv/k
        qkhqnh0ilVRrnlNNVMTDGOV9SFRnsU47Fl/MxctGT1LBU+2nyogJFLnwvk+boYhPZToRPfMn6bwqs
        hOpzLY0gtrkWKTwYk3O1h039MXcDdoAFdM8txOU7ZwempzMncipwbcvmMiScgbZRmLo3N5Df72Mu0
        AHvQcr+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ournX-0096RB-6x; Tue, 15 Nov 2022 09:00:03 +0000
Date:   Tue, 15 Nov 2022 01:00:03 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     chuck.lever@oracle.com, linux-fsdevel@vger.kernel.org,
        trond.myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 3/3] filelock: remove redundant filp arg from
 vfs_cancel_lock
Message-ID: <Y3NVE9pcvQXaIBi1@infradead.org>
References: <20221114150240.198648-1-jlayton@kernel.org>
 <20221114150240.198648-4-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114150240.198648-4-jlayton@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Same nitpick once more :)

Otherwise:

Reviewed-by: Christoph Hellwig <hch@lst.de>
