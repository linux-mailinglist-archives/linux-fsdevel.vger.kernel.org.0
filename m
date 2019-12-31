Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87CB112D8A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2019 13:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfLaMwv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Dec 2019 07:52:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35162 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfLaMwv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Dec 2019 07:52:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eK2vFgg397hCSVRa2xjSTfCRGKL3OTkCOPxpuJmtpSE=; b=DjJ/f06OTZ5u8SDIj0Ff5HvXz
        ygTGV4qmY5aq6TU4JxyyVRdg0n8i9ytHFmQ8VYH+TiHhezW7gzXMWpRspCJ/d02GgwDJGJRWqRRFE
        D0TSSWJWtKdO3oin5SmpqCxvIeNSN12oYILKltspjI4GpPLb2eIN1QkznHJtXe17B4VPLGBUg9HMZ
        dZ2hI9/CSHi5dOI1rSbiZLyGlr7M+mmGgc/PxU1f4ZOOAzXDKBI96FS8HoFt7bdE2n07+hcGAS0q5
        hpuyeL4yGK2MAaRLACjlMnFQvDYkRBXGULIm5mT/ldlsIqFnmdkt7LW0UYDDzErA0DRpekureSSlq
        r7DY7ZgIA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1imH0p-0001UC-6u; Tue, 31 Dec 2019 12:52:39 +0000
Date:   Tue, 31 Dec 2019 04:52:39 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chao Yu <chao@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] f2fs: introduce DEFAULT_IO_TIMEOUT_JIFFIES
Message-ID: <20191231125239.GC6788@bombadil.infradead.org>
References: <20191223040020.109570-1-yuchao0@huawei.com>
 <CAMuHMdUDMv_mMw_ZU4BtuRKX1OvMhjLWw2owTcAP-0D4j5XROw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUDMv_mMw_ZU4BtuRKX1OvMhjLWw2owTcAP-0D4j5XROw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 23, 2019 at 09:41:02AM +0100, Geert Uytterhoeven wrote:
> Hi,
> 
> CC linux-fsdevel
> 
> On Mon, Dec 23, 2019 at 5:01 AM Chao Yu <yuchao0@huawei.com> wrote:
> > As Geert Uytterhoeven reported:
> >
> > for parameter HZ/50 in congestion_wait(BLK_RW_ASYNC, HZ/50);
> >
> > On some platforms, HZ can be less than 50, then unexpected 0 timeout
> > jiffies will be set in congestion_wait().

It doesn't matter, congestion is broken and has been for years.

https://lore.kernel.org/linux-mm/20190923111900.GH15392@bombadil.infradead.org/
