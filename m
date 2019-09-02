Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 409D2A5004
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 09:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbfIBHiL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 03:38:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39236 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729371AbfIBHiL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 03:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vsHiWU/4ZPU2tbVPI9rb4pxa+QdD8xZBTuST3h8mTdg=; b=BN3iSfPlTiY4WHZU3B40JcynXk
        62lMMna7KOeFVGs2Cxp4qgVDzy0YHdmoDwwWJFl7pyzAb1NM8f1BJtnxfm3cgVxeK2XqUUGb6mb9e
        yh07JrgQrpVusvB47SvIhV4FDGDBong6D1sHv3EtjFutIw8h46tGNSeei30o+/cx+fpmswfnRJ4ly
        Ank96Cer5yn0cMRjj6LYFelRK23g7FFJBUyrzIkd6pPC+cawbH/t4NerbWN9jZdr3LgPLNOjManfw
        fn279X5jf55iurjg780IWh/QCRTmcRa1B4FZgkcs/EgeJbSP4hR5NbOM5TliU4858fNmyJ5KoTlyi
        CJNnQ49A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4guZ-0008K2-CB; Mon, 02 Sep 2019 07:38:03 +0000
Date:   Mon, 2 Sep 2019 00:38:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/staging/exfat - by default, prohibit mount of
 fat/vfat
Message-ID: <20190902073803.GB18988@infradead.org>
References: <245727.1567183359@turing-police>
 <20190830164503.GA12978@infradead.org>
 <267691.1567212516@turing-police>
 <20190831064616.GA13286@infradead.org>
 <295233.1567247121@turing-police>
 <20190901010721.GG7777@dread.disaster.area>
 <339527.1567309047@turing-police>
 <20190901224329.GH7777@dread.disaster.area>
 <389078.1567379634@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <389078.1567379634@turing-police>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 01, 2019 at 07:13:54PM -0400, Valdis Klētnieks wrote:
> Any recommendations on how to approach that?   Clone the current fs/fat code
> and develop on top of that, or create a branch of it and on occasion do the
> merging needed to track further fs/fat development?
> 
> Mostly asking for workflow suggestions - what's known to work well for this
> sort of situation, where we know we won't be merging until we have several
> thousand lines of new code?  And any "don't do <this> or you'll regret it
> later" advice is also appreciated. :)

Just try to hack it in in your local tree and see if it works at all.
Normally you should have a feeling of where this is heading at this
point and start iterating.  One it looks somewhat presentable send it
out to the list and ask for comments.
