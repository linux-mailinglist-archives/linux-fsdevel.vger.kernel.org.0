Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 478F2161ADA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 19:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbgBQSsn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 13:48:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50272 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729854AbgBQSsl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 13:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CZVbSaaYtwj3qyeImu1P+lH7PMVYW2dlgJQfIOhuLwI=; b=InMWRejZjziZ327gXZfH6Mbvr/
        C/eVJoLnvVckDeDyzrV7y7TgMN7L2n+c2kuawbG4CvlvTAyha1SY+K1dMvV+M/KVndPm9QVAOhiYo
        8o2+LVPKCXFmpk2cJIMtPz+PQe7MPFwlTqgCeHeus+DzjLHeMVZ2Zdtsj+MACIwCrSrxvG8dTTtZW
        IsGstqnGLWUQSUdZyALt6muTXBeoQ265Lj7NA7RwwyS1WYlqOrdhFvczcsXEHghUSOEddnFA/bh3o
        rlYzYW3LI/v4mBl1+4g7qezJwwaoolJXkQhuMF6EOe7aVsuIM/2l1RZhxe9liukxnsF/LosclOFnG
        HdvYL2KA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3lRh-0006jH-1W; Mon, 17 Feb 2020 18:48:41 +0000
Date:   Mon, 17 Feb 2020 10:48:40 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 00/19] Change readahead API
Message-ID: <20200217184840.GL7778@bombadil.infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217184613.19668-1-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 10:45:41AM -0800, Matthew Wilcox wrote:
> This series adds a readahead address_space operation to eventually

*sigh*.  Clearly I forgot to rm -rf an earlier version.  Please disregard
any patches labelled n/16.  I can send a v7 if this is too much hassle.
