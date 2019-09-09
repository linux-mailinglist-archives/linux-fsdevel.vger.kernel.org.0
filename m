Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C184ADECF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 20:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbfIIS13 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 14:27:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35754 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730720AbfIIS12 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 14:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kJxl3z0+t1HtCZJpudjSastTrtIPsx6LPANJc9Z0ErU=; b=FXLI9Mf5NESRfzvvasoJi4MNB
        uLU5oFZ9CFr/E00aWZ3nDQ6vM/zAGby1hBRFlgiiT3bELcGOHlAI90Qw8Uj+ypn0ZVHb8RZUYeSU2
        OuKkKULVtLQWLCdZilxLGhX1E5+A4z0pPDc4sGi7MMrO+Dhyth1pV0HTy0YcKqgxtpYzCj6vvKFNx
        CGZNYIHRcyldqsMcQaqPC/LZ1vCiMY6AxKYfLi3bUESInGcnNYsXgeADayG2le1CHcSgdZe2ugfd2
        KhW3wtSYJIHiu3b+jmzpktlwaEbKqNJykTF+Ft/ka/lxm9ZiPO4H0+yoKNdkqvzVGUhdv+hep7jyf
        X7y89qgTw==;
Received: from [2001:4bb8:180:57ff:412:4333:4bf9:9db2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i7ONr-0001tX-T7; Mon, 09 Sep 2019 18:27:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: iomap and xfs COW cleanups
Date:   Mon,  9 Sep 2019 20:27:03 +0200
Message-Id: <20190909182722.16783-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series started out based on a review of the btrfs iomap series
from Goldwyn.  I've taken his main srcmap patch and modified it a bit
based on my experience of converting xfs over to use the feature.
That led to comments that the xfs code is a mess, so I resurrected
an old series to clean that up and merged it in.  That series also
happens to massively clean up the unshare path in the iomap and xfs
code as well.
