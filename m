Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF27A49D047
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 18:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243387AbiAZRDa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 12:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243366AbiAZRDY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:03:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC72DC061747;
        Wed, 26 Jan 2022 09:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MyiJNyGw1KD3tuTh8P/+VDolgP9cBH010XLn0PmxTs0=; b=vBfuwZpOTDG4JzLXno9tbWAn3A
        EADMrWrDTwEd1BJFc6FaWSwFConCuMf1225uHAgdS0WPT9tzvLFc13Db/WV970QQR55SF7OY4YzXf
        1mG1Azgi1R4xjIVOgZUUrSf3zL9gh8BNXvmdYVmBli5K8fewPlFngRlnMum0gbk8c/kAfD4hAjs9D
        9dHGrPuCQvEJA17AR/EBXrxkJo/9sROotv2mQGgm7950dZLWlJgXuh2Eq3OLaAr/BA9LXxferdOU6
        Tgu8LQJAKxk2HqHawzuGd3MFi3HvosGHoRfTX5tKyafAhvWL2XEXfe6i5g0jzmzlD3stNsZsbTkB+
        HhQLcObA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nClhb-00Cqda-Dz; Wed, 26 Jan 2022 17:03:23 +0000
Date:   Wed, 26 Jan 2022 09:03:23 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.com
Subject: Re: [PATCH 4/4] xfs: return errors in xfs_fs_sync_fs
Message-ID: <YfF+2zPRdjEJAV5Z@infradead.org>
References: <164316348940.2600168.17153575889519271710.stgit@magnolia>
 <164316351155.2600168.3007243245021307622.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164316351155.2600168.3007243245021307622.stgit@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 25, 2022 at 06:18:31PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Now that the VFS will do something with the return values from
> ->sync_fs, make ours pass on error codes.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
