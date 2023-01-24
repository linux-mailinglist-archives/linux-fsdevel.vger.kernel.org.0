Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3220C67925E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 08:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjAXHzA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 02:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjAXHy7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 02:54:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAE444A9;
        Mon, 23 Jan 2023 23:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bAydf+WiQ6pqZaniRSwU4PVukT6txqY5z6v0CCPKdGo=; b=U+Ma3g4YQwPiuCyDF2R7UeYudj
        7vQof1VgUer9eQFZYM9T8aBy2/LfCipIDAN7P0811g1D3awe/O1nhc293FNtPAPgkt3TFqkb5HmRN
        NMKCIYQbIBIGRIhYWB7b+9GsYqMjKbAsXwefzVKkqKYZGEc4Q77RUKCskEOV3YQUfwtm91nCKMS5n
        ki8cWiP+UNrACaX3xuKwYBT1cYVBqrsmcr8OZdtqhZn6qsoF2mAdHWbsjkgaiTcawVKxPFvrDgAjr
        0RGU3IQreqmTQm1FlNaNpNssAhkzfc1b4BaEe42bFGa/YXx2D/4xht9XoDBF34l6uR/wvjVpwJ78f
        3Yu9GhZg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKE8s-002gBO-Jo; Tue, 24 Jan 2023 07:54:54 +0000
Date:   Mon, 23 Jan 2023 23:54:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: What would happen if the block device driver/firmware found some
 block of a bio is corrupted?
Message-ID: <Y8+Ozqv0sNCd9Z3N@infradead.org>
References: <5be2cd86-e535-a4ae-b989-887bf9c2c36d@gmx.com>
 <Y89iSQJEpMFBSd2G@kbusch-mbp.dhcp.thefacebook.com>
 <08def3ca-ccbd-88c7-acda-f155c1359c3b@gmx.com>
 <Y897ZrBFdfLcHFma@infradead.org>
 <88b3df41-1a62-a6c8-911c-de8b4bca3196@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88b3df41-1a62-a6c8-911c-de8b4bca3196@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 03:52:38PM +0800, Qu Wenruo wrote:
> This also means, if some internal work (like btrfs scrub) is not triggered
> by MM, then we have to do the split all by ourselves...

Yes.
