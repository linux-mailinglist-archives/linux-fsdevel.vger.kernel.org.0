Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B16C1D15B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 15:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388131AbgEMNhJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 09:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgEMNhJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 09:37:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C86CC061A0C;
        Wed, 13 May 2020 06:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=MVaxU610c9eybajVqgfe7LMhGj
        0G6JXeev/stXsTgnTp3UH6rEQpguAXx6dTjxaoGGqCM23HZaWZaT/icu+eQ73Ei4/V8i3O6osopoi
        FePsBPznmdZ9XzKB5+4fRsW6S456FgZ15LZTNLZr5PRZEXRrJVIG7LITuROMw1AfKvJvbq4XB3vS5
        h9t7+8Zf855m06i7X2oWAoYDQtfX90ktn21uy4dbealbEAKMZXp58DJsQ2oYHJ4ZmdwHoHu/MBOYf
        673YxG1gVaE3GxzIETiLugIkV0SCBrDdYgr+b640JPSY5Pua2yBGKRlIv+q1KSGJvCX21LJkDi+fV
        FSY9tmsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYrZM-0007DE-UN; Wed, 13 May 2020 13:37:08 +0000
Date:   Wed, 13 May 2020 06:37:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v12 04/12] block: Make blk-integrity preclude hardware
 inline encryption
Message-ID: <20200513133708.GC10793@infradead.org>
References: <20200430115959.238073-1-satyat@google.com>
 <20200430115959.238073-5-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430115959.238073-5-satyat@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
