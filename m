Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655CF49D040
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 18:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243437AbiAZRDB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 12:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbiAZRDA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:03:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9625DC06161C;
        Wed, 26 Jan 2022 09:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mhXVWVx/kGAUaqLTlYZ9AkhdKx9LoYoAn2q8tCgAQIE=; b=piFyEY85eKo8ZwNptTeNtg1C9E
        aY6Pq5Yv95tWUZBleYy2pt/A87lut0ffOGwyoFVpNkbHBEzw0p34SdaYqYu5xHjfcgZvRRlzlImdX
        Owc4phijN7z7/E80VfSfvF73VEpDD4ut5DHvq/XSwnbi3uAojkJ3gZhHejmkKJMc5h36SMgxRUL81
        w7V90+XnV23257UyMgzNy8E/h1V2L1nvVdi0ZpxOfcAuJjMrO6imnSI2QxBBG5yByY7MtEIP2RIVv
        K7RcjpVHS6KwZ0QqoFZUXwS3SEuZ4S3M0tpesv68XaPj6RRtsnZQYn+tObUQBC8xyneb7o0m8Q8bp
        gUSYVRvg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nClhE-00CqS7-8s; Wed, 26 Jan 2022 17:03:00 +0000
Date:   Wed, 26 Jan 2022 09:03:00 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.com
Subject: Re: [PATCH 3/4] quota: make dquot_quota_sync return errors from
 ->sync_fs
Message-ID: <YfF+xGkK57i0I/FH@infradead.org>
References: <164316348940.2600168.17153575889519271710.stgit@magnolia>
 <164316350602.2600168.17959517250738452981.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164316350602.2600168.17959517250738452981.stgit@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 25, 2022 at 06:18:26PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Strangely, dquot_quota_sync ignores the return code from the ->sync_fs
> call, which means that quotacalls like Q_SYNC never see the error.  This
> doesn't seem right, so fix that.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
