Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBD11684D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 18:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgBURZQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 12:25:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51660 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgBURZQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0QbnwMFeVDLkBAGPBi1AUe4OscAIJxG3K9y7ARTuVaw=; b=L4KkbhOjqVkaypvNUDvOXfv7t9
        K8/nVTJ8ARQLzQ406m0TrAdMdH6OeXkWGN6J9igcsSDbSWR8EDOKSM5wL2J331ZcVoCv9N2YTmZE6
        Vgch7/k4A1to0u5jHWFQdIEHyjlcQPj9WpbX3sCR0X3oZime9NNEs9TKjvrBeLd2h26UlndUS09PJ
        /pNrXUuiNO5xRrRX8lY+V9rKjITZanhEiwHrEzZL2Q1nZSk46vckirBd2QpK7OagqEFGiqn9hgfgv
        gZSQvRmoMXY0LSNR2UAWX9Zd3u8FHcgA+M/sDsjsms2HOCyZekSVrqCA6EszYMwMY83HFhtgJwybk
        FZOmizkg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5C3A-0007Wf-2X; Fri, 21 Feb 2020 17:25:16 +0000
Date:   Fri, 21 Feb 2020 09:25:16 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v7 3/9] block: blk-crypto-fallback for Inline Encryption
Message-ID: <20200221172516.GA23976@infradead.org>
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

That REQ_NO_SPECIAL think really needs a separate patch and be
explained.  In fact I hope we can get away without it as it is horrible,
so maybe the explanation will lead to a better outcome.
