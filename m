Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38AD3D88BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 08:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388090AbfJPGny (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 02:43:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46538 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfJPGny (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 02:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RlX7GJA1mPLD3DZ4u1ksZQlVybr4nI9WtXqdX6/HNAI=; b=E21R+IZHsbiYeZprJLL7Bwber
        u5gP7U/A1/qmRpkMDA2njgnRtbisZyBRQiDIrdtJ0XpblzccJMYtOysbM3DXrCr8hxfvPnce13Uzf
        xeSb+g7zPxAT+yEcESNTcNhZmgr+rGuos8M0NIMyrVnd47t4QqDIstN8suzvKre4wHIkP6bm+LnZU
        P9hJfWij6CzsJn1F0AO2OxU3VhH+imaEwItRYRm/bSb3GKPON2nuscyo9+Wd8S3y0CtdZDKibXwJ1
        x/8kSFgOlOH710WQmIfNy6cnYkReK2rGp3aQNjbWr9eUD3xpmtY4qcqLnQWXJ5Iy5kVJ71wQEiiuZ
        P9KgrDLxw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKd2H-0007Ek-Sw; Wed, 16 Oct 2019 06:43:53 +0000
Date:   Tue, 15 Oct 2019 23:43:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] iomap: iomap that extends beyond EOF should be marked
 dirty
Message-ID: <20191016064353.GA25846@infradead.org>
References: <20191016051101.12620-1-david@fromorbit.com>
 <20191016060604.GH16973@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016060604.GH16973@dread.disaster.area>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I wonder if the i_size check should be done in core, similar to the
iomap_block_needs_zeroing helper.  But independent of what is nicer
this version does look correct to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
