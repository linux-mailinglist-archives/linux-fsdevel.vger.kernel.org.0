Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66F91D15AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 15:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388063AbgEMNgq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 09:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgEMNgq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 09:36:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04883C061A0C;
        Wed, 13 May 2020 06:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MTm+io+HMLreqyOoq/Gxy8SLIywzVQ4X+H1LtVIs47k=; b=a7hp0YNbk++yuVE5NuE9L2UOiP
        A1FNTYC41aHrRapxB9q16NeHjY9xAsejt0fo3Fov63OZJxpe1su9n7rYCljBRKvsBqC6X/aT5xguF
        NQkv+v4Njtx6fNOeML/tWnwNK3IjeGxcixOe5JD6OKrJA239YxX+Gsg6ETGHY/pE/MbNaNABB1Nc9
        CTIQL4HJlxzN/xg1A3UjCj1uZNktEiY9thBRjfEpbUih4xjN5oPycuo5NSDIQMGNdTLgkhFmfKntD
        X93nGjmYIsYF2t8tlzpjVqZ14RP3n9OIqkP7M7qVOqqorwOQPdFw5H/O3Eouk50+9DFw81k2+YLCf
        HoEpYvJQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYrYz-0006t6-Rj; Wed, 13 May 2020 13:36:45 +0000
Date:   Wed, 13 May 2020 06:36:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v12 03/12] block: Inline encryption support for blk-mq
Message-ID: <20200513133645.GB10793@infradead.org>
References: <20200430115959.238073-1-satyat@google.com>
 <20200430115959.238073-4-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430115959.238073-4-satyat@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

although this will need a rebase to the latest block tree.
