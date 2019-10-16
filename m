Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACCED9708
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 18:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406122AbfJPQWR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 12:22:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406119AbfJPQWR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:22:17 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E743F20663;
        Wed, 16 Oct 2019 16:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571242937;
        bh=KFBtm5iJWUA4wxim3LDUKOG7zCrPJp5DCTkanoJ0k9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eTXTM/L9NWb8/NdyzwZZPi0OEedrfLvfGiv0fACfuKwbZZI7lDpaVO8UE8BbK96vs
         09zQi+JyE2O4PWIP9Xt8ZJR56F2+mnPSL8IPlGuDauw+9nCXuRUThpKEoyv0BmhtOr
         UGU8xzoTLpeIhaEuWFW56kD55nVaVfjoT6H61iSo=
Date:   Wed, 16 Oct 2019 09:22:11 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org,
        Christoph Hellwig <hch@infradead.org>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20191016162211.GA505532@kroah.com>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190829205631.uhz6jdboneej3j3c@pali>
 <184209.1567120696@turing-police>
 <20190829233506.GT5281@sasha-vm>
 <20190830075647.wvhrx4asnkrfkkwk@pali>
 <20191016140353.4hrncxa5wkx47oau@pali>
 <20191016143113.GS31224@sasha-vm>
 <20191016160349.pwghlg566hh2o7id@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191016160349.pwghlg566hh2o7id@pali>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 16, 2019 at 06:03:49PM +0200, Pali Rohár wrote:
> > Can I assume you will be implementing TexFAT support once the spec is
> > available?
> 
> I cannot promise that I would implement something which I do not know
> how is working... It depends on how complicated TexFAT is and also how
> future exfat support in kernel would look like.
> 
> But I'm interesting in implementing it.

What devices need TexFAT?  I thought it the old devices that used it are
long obsolete and gone.  How is this feature going to be tested/used?

thanks,

greg k-h
