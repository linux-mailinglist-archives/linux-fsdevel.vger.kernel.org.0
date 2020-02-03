Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B33415025C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 09:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgBCIQC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 03:16:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:52756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727540AbgBCIQC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 03:16:02 -0500
Received: from localhost (unknown [83.216.75.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 088BF2070A;
        Mon,  3 Feb 2020 08:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580717761;
        bh=rG8mHjMai7mwuySARFt6RxcCm4lcKPvI6i8XuZ6E/jA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YvGR5Tw1EXbAf1mwCNUwPXgDJibXQp71boP4fREe/GT+59ybJcCGQxBe+RO/IKKr8
         xPTS9pxxHqIOYConRhoTdXEoXDk6ZLttkIi51HqVqiDIz9H0yEeG/1TVZehbgNNiZ+
         NTHbHIpWmRzpnJJmzYdnLaE719iqK3XB18u6fZdY=
Date:   Mon, 3 Feb 2020 08:15:59 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>,
        devel@driverdev.osuosl.org,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Mori.Takahiro@ab.mitsubishielectric.co.jp,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: exfat: remove DOSNAMEs.
Message-ID: <20200203081559.GA3038628@kroah.com>
References: <20200203163118.31332-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
 <20200203080532.GF8731@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203080532.GF8731@bombadil.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 03, 2020 at 12:05:32AM -0800, Matthew Wilcox wrote:
> On Tue, Feb 04, 2020 at 01:31:17AM +0900, Tetsuhiro Kohada wrote:
> > remove 'dos_name','ShortName' and related definitions.
> > 
> > 'dos_name' and 'ShortName' are definitions before VFAT.
> > These are never used in exFAT.
> 
> Why are we still seeing patches for the exfat in staging?

Because people like doing cleanup patches :)

> Why are people not working on the Samsung code base?

They are, see the patches on the list, hopefully they get merged after
-rc1 is out.

thanks,

greg k-h
