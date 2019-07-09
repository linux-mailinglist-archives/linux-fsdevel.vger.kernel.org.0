Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA11634D6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 13:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfGILVu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 07:21:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49838 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfGILVu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jD6kJP1W3EItQJ+7NNHoZaZ3Nsj5zGBFCoAMXOtbtkc=; b=PMXEfxna18N7zoPtVghvBrl82
        6CkURbmbsnlWPeKpUv8cQ0w5J7tX+k7iuusTSIBL3JVnKeIQCAnaVa+XdZClEXxIB8bdThXlz179v
        lntKfy3styjyfDlHqBP7ulfChcswyUC9neH2NAmWDhMQDMD1x55IORK+C2Hr79YpdWu/4dpJt9Gwm
        kRrEtsQHjzUijSV8oGHJIuQzuG5JOC1DUnQHHxIAxUrqnnDWcgWaYSh00zS+KwMdkoulU0Zs3HEVN
        JwjrAucNjUS2tvA1l7kClQV+NSnVKEcWBOe5tIjrphQLqs+RCKC5aUL5C73Vly1RoapBtXGB/v6kL
        nwgIcXK2A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hkoBk-000168-UK; Tue, 09 Jul 2019 11:21:36 +0000
Date:   Tue, 9 Jul 2019 04:21:36 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: Procedure questions - new filesystem driver..
Message-ID: <20190709112136.GI32320@bombadil.infradead.org>
References: <21080.1562632662@turing-police>
 <20190709045020.GB23646@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709045020.GB23646@mit.edu>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 09, 2019 at 12:50:20AM -0400, Theodore Ts'o wrote:
> How have you dealt with the patent claims which Microsoft has
> asserted[1] on the exFAT file system design?
> 
> [1] https://www.microsoft.com/en-us/legal/intellectualproperty/mtl/exfat-licensing.aspx
> 
> I am not making any claims about the validity of Microsoft's patent
> assertions on exFAT, one way or another.  But it might be a good idea
> for some laywers from the Linux Foundation to render some legal advice
> to their employees (namely Greg K-H and Linus Torvalds) regarding the
> advisability of taking exFAT into the official Linux tree.
> 
> Personally, if Microsoft is going to be unfriendly about not wanting
> others to use their file system technology by making patent claims,
> why should we reward them by making their file system better by
> improvings its interoperability?  (My personal opinion only.)

How does
https://www.zdnet.com/article/microsoft-open-sources-its-entire-patent-portfolio/
change your personal opinion?
