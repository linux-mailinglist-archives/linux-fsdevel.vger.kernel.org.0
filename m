Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07C57168516
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 18:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgBURfk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 12:35:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53690 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgBURfj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:35:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wf0h9wuAEcKNRqQhK7eYyrG9qa7B8zzOGponbVZ3cRs=; b=qv4T8VovROjkqztEW3g3nhCy5f
        gufHvXfCuF+Z6HXVdrnqn11v47JRrQd3KMc2Fb/NXQnDX0L8RgKN14XJA2vlmNyMfe8JNpLhmUVxc
        z25YaTqKCBiGK2Hw+2/bd4pbgopKAf4/ve6jLC7QPgm5ZDn5+iUMGtD+1h9m9riV8t/UT8f4E2FIQ
        ++ryHJSQL+q4p3uXFau3HwiSPe27IGSZ+hWHJ1wE/QCzd7pdwceRoXgVy0rGkR8NzQA6rJe3DsDAG
        fBH7BRytlaQRbZINis5xOw58oyyhiPiKjWEb9vUxnB2uZFIru9OjRckeEqfDgK73xZAiXwS1jNsGy
        osPBEkFQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5CDD-0003J6-9C; Fri, 21 Feb 2020 17:35:39 +0000
Date:   Fri, 21 Feb 2020 09:35:39 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v7 3/9] block: blk-crypto-fallback for Inline Encryption
Message-ID: <20200221173539.GA6525@infradead.org>
References: <20200221115050.238976-1-satyat@google.com>
 <20200221115050.238976-4-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221115050.238976-4-satyat@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

High-level question:  Does the whole keyslot manager concept even make
sense for the fallback?  With the work-queue we have item that exectutes
at a time per cpu.  So just allocatea per-cpu crypto_skcipher for
each encryption mode and there should never be a slot limitation.  Or
do I miss something?
