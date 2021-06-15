Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619AC3A78D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 10:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhFOIOB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 04:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbhFOIOA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 04:14:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED19C061574;
        Tue, 15 Jun 2021 01:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OtM1MtK/V9fA4aa2itcOdpgo19UPGo/YGDTF5kwIUQ0=; b=PfGSnynkOoxSAG2smELhAqGyAV
        F5k58xqRMvkFw197DcPwWE/jpVUErvTNWK2FvP1Yt3TaJAH7T9/C1iE67BCjCSurcv7X1zBASKCym
        RQqUZYRbw8rfkSQk4Bn5PQSJXO5YXaPDRHGhSVDr2ZqgmdONJ2AjX26acBh2tyEBAdElAtU9lE1DM
        lbj6sBp4ZZQFzoMI5ceYoA3VuJv5YQlA5Rb8y8ezekCRh7kqGQNWN0BNVPqKeM+XNWwKSQo1kP9/R
        AeGtyoF4nxyQbvl+fV/IzehPU3iUg7Rsu1h9N44Oks7ThHPnuApNVpNgoPDwx8DTn4EsfZBViAKeB
        5uFBBh4w==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lt4AO-006ETY-TZ; Tue, 15 Jun 2021 08:11:29 +0000
Date:   Tue, 15 Jun 2021 09:11:24 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org, smfrench@gmail.com,
        stfrench@microsoft.com, willy@infradead.org,
        aurelien.aptel@gmail.com, linux-cifsd-devel@lists.sourceforge.net,
        senozhatsky@chromium.org, sandeen@sandeen.net, aaptel@suse.com,
        hch@infradead.org, viro@zeniv.linux.org.uk,
        ronniesahlberg@gmail.com, hch@lst.de, dan.carpenter@oracle.com,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Hyunchul Lee <hyc.lee@gmail.com>
Subject: Re: [PATCH v4 03/10] cifsd: add trasport layers
Message-ID: <YMhgrNGLhORjok1H@infradead.org>
References: <20210602034847.5371-1-namjae.jeon@samsung.com>
 <CGME20210602035816epcas1p240598e76247034278ad45dc0827b2be7@epcas1p2.samsung.com>
 <20210602034847.5371-4-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602034847.5371-4-namjae.jeon@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 02, 2021 at 12:48:40PM +0900, Namjae Jeon wrote:
> This adds transport layers(tcp, rdma, ipc).

Please split this into one patch for each, which is a much more sensible
patch split that many of the others.

This also seems to include a lot of mgmt/ code.
