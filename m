Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F57B1B31EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 23:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgDUVat (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 17:30:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgDUVas (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 17:30:48 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05AC3206E9;
        Tue, 21 Apr 2020 21:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587504648;
        bh=mG0iEI2vowwwZ8w7ZAJgJpuwjSgD+woCxqTTePYKf6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kyq9XJIVK9LFHEn/1nwvYdV5K3Sz8y+wNKJH7BViDfJy22vHVj1Xy72AJIHYPTrG+
         dn/VveamzvPTi/n+eqqiFhYx1hBM/Hx7eHQfxMtHVAKscMjZoPPJcwH0+8IAiADb3r
         eemdiru+MhZb/tIiUgwRHiEzo2bG4FnJuBVfz5i4=
Received: by pali.im (Postfix)
        id E7E38A4B; Tue, 21 Apr 2020 23:30:45 +0200 (CEST)
Date:   Tue, 21 Apr 2020 23:30:45 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: exfat upcase table for code points above U+FFFF (Was: Re: [PATCH]
 staging: exfat: add exfat filesystem code to staging)
Message-ID: <20200421213045.skv2dvgm3xuspbl7@pali>
References: <184209.1567120696@turing-police>
 <20190829233506.GT5281@sasha-vm>
 <20190830075647.wvhrx4asnkrfkkwk@pali>
 <20191016140353.4hrncxa5wkx47oau@pali>
 <20191016143113.GS31224@sasha-vm>
 <20191016160349.pwghlg566hh2o7id@pali>
 <20191016203317.GU31224@sasha-vm>
 <20191017075008.2uqgdimo3hrktj3i@pali>
 <20200213000656.hx5wdofkcpg7aoyo@pali>
 <20200213211847.GA1734@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200213211847.GA1734@sasha-vm>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday 13 February 2020 16:18:47 Sasha Levin wrote:
> On Thu, Feb 13, 2020 at 01:06:56AM +0100, Pali Rohár wrote:
> > In released exFAT specification is not written how are Unicode code
> > points above U+FFFF represented in exFAT upcase table. Normally in
> > UTF-16 are Unicode code points above U+FFFF represented by surrogate
> > pairs but compression format of exFAT upcase table is not clear how to
> > do it there.
> > 
> > Are you able to send question about this problem to relevant MS people?
> > 
> > New Linux implementation of exfat which is waiting on mailing list just
> > do not support Unicode code points above U+FFFF in exFAT upcase table.
> 
> Sure, I'll forward this question on. I'll see if I can get someone from
> their team who could be available to answer questions such as these in
> the future - Microsoft is interested in maintaining compatiblity between
> Linux and Windows exFAT implementations.

Hello Sasha! Have you got any answer from exfat MS team about upcase
table for Unicode code points above U+FFFF?
