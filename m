Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEC25ABBD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2019 16:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfF2OVM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jun 2019 10:21:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37884 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfF2OVM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jun 2019 10:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B10rj/zJAvUcZgoWGg0MK7uvwIZSspRWsN8j3lAA3vY=; b=BFX/3Qi/s+f3FOjjU/M1Fi5JI
        pg/DzjEoxeO1Mhi+oRenD3+XCtD6rZbjSl551gBabExCFkkGoBNhNVu4BYK/UymOoEdUG0Mqgk5rv
        Si5B/pU2wlg4yOKYOgcWrQc+Bti4TLggFcEA5ZEPX0DJzLLgLqkFDcK0udjEuKDFx3JfiN/RvTXyU
        kx+dfy6TJ6UEEpRkPBcgmu5hde3hSvPHegmGv4Nz1UaDKN0ThCEdRjwifUDEZYYawVSmFN5zWZhD8
        i3I414nmqHRzOnehvcz2AseLpR5HQz9I/AI2RyfIaeD9BZCKZC4emDaTazb3UEVbUna5iAtsYXlYt
        NMOTJv+oA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hhEDt-0007CP-My; Sat, 29 Jun 2019 14:21:01 +0000
Date:   Sat, 29 Jun 2019 07:21:01 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        houtao1@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH] fs: change last_ino type to unsigned long
Message-ID: <20190629142101.GA1180@bombadil.infradead.org>
References: <1561811293-75769-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561811293-75769-1-git-send-email-zhengbin13@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 29, 2019 at 08:28:13PM +0800, zhengbin wrote:
> tmpfs use get_next_ino to get inode number, if last_ino wraps,
> there will be files share the same inode number. Change last_ino
> type to unsigned long.

Is this a serious problem?  I'd be more convinced by a patch to use
the sbitmap data structure than a blind conversion to use atomic64_t.
