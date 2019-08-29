Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8297FA11AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 08:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfH2GXl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 02:23:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35886 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfH2GXl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 02:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Pnilb35Nyis35kILCtEZc4I5Fc543LaqAnG843dbBy8=; b=dk56+zO//nXBQQbjht/htHClI
        TMTs0VFQIU6jekV/YQ1dUzCP5SBy7nW3gmVc8b7NH7GRAwfwJvhz/jhrE3DkFGyKTeyD0v4Zbutox
        3wWHhcPePqmFoqNiv6KKjgg28GrJ9iZC81N8kZQGjueCucTfndbxggKNEI2N4iyM1xJaKLRIL8iB5
        pdHBEP//K+StFX3bZNedh4q+vL0DYHc7lTrXUgH3VWji8372/ZtvYeBLEW3/j2KUSg2ouxlKJ/XDl
        S2+9AaAwRPhjHhcwK3o//a7PQCq2pjL4RvAC9NSTyoiQ3jlvRe9ASOFD0H+a102Cvc9ohUeWBsnLr
        WZ92GXE+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3DqO-0002Sx-AL; Thu, 29 Aug 2019 06:23:40 +0000
Date:   Wed, 28 Aug 2019 23:23:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20190829062340.GB3047@infradead.org>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190828170022.GA7873@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828170022.GA7873@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Can we please just review the damn thing and get it into the proper
tree?  That whole concept of staging file systems just has been one
fricking disaster, including Greg just moving not fully reviewed ones
over like erofs just because he feels like it.  I'm getting sick and
tired of this scheme.
