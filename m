Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B14337356
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 14:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbhCKNCf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 08:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbhCKNC2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 08:02:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B6CC061574;
        Thu, 11 Mar 2021 05:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=vvez9Nnovn+8IwwZ0bWHZDR4Jj
        XexZrzZ0mRnzPLfMWZNxG3NIIav3dOy3dTeI/5q8pdAtCgFwIsXf8I0lOR4gM9a2DsLn7eZbRhBVp
        v+gVd4JYRknGDESWGpBhDcyMTk4Jr33z+dBqr2vvZU+0JIG2EKgSe0Sal6K+BhFiSOBxy8wSwXt2b
        bqR8x0GnXoc+tXvppcQqqrl3sO8GxdvM3Sm4/nS2yLlT5EtW0Xok8co93jZbD73u6sqDt7+SiNpZV
        W3pzqud3crqpYsNFalyZweAr1agrSFSuSV512/cQE9U3Wpfj44jCLo7Hzmy5eEbkpOCRQp5tUGjMC
        7/pK98jQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lKKwq-007Kl1-Mb; Thu, 11 Mar 2021 13:02:00 +0000
Date:   Thu, 11 Mar 2021 13:01:52 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, anju@linux.vnet.ibm.com,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCHv2] iomap: Fix negative assignment to unsigned sis->pages
 in iomap_swapfile_activate
Message-ID: <20210311130152.GG1742851@infradead.org>
References: <93fa3d674cda41261e529e1e9b75c2efb2e325be.1615445004.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93fa3d674cda41261e529e1e9b75c2efb2e325be.1615445004.git.riteshh@linux.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
