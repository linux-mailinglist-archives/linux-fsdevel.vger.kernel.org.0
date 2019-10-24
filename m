Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15506E27B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 03:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390265AbfJXB2C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 21:28:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54750 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfJXB2C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 21:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oOJSv5AEO1P0oZySMka50rrSmMrrts/dJHKNuIUqNOo=; b=p0Wf+fyQKYQ+zmCljn+rA0DQl
        8YlfbIoi3u8Tc3vTG6MHb2BO+ialHTOQFunLNZ9gMdwbAMwG6gy6Q/TvM2k3NUvJF7ABzsT3zRfBt
        xcExWeK/TDjIQNu4gvsin8QqUt8gEEGaHXq4Q4dOWbGbrUCSqdKuotJTFmSOWmujaR0ZWYoUppVRK
        hBWeP5HCQRP3zpYSAYFf5HwokDoRdTCXs+lu3HbOGuM9WsaX16oG9zU9j9COwUyeEWDwEkDYjrymV
        kV4QiUrHqqJ4wSjVB3uX/suXqft0eZckiYWyJKyJOya03V/uoD6KUPpcN52hKGhI5zR5uMVawR9G+
        D9uTgaupA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNRux-00005c-2V; Thu, 24 Oct 2019 01:27:59 +0000
Date:   Wed, 23 Oct 2019 18:27:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/3] fscrypt: add support for inline-encryption-optimized
 policies
Message-ID: <20191024012759.GA32358@infradead.org>
References: <20191021230355.23136-1-ebiggers@kernel.org>
 <20191021230355.23136-2-ebiggers@kernel.org>
 <20191022052712.GA2083@dread.disaster.area>
 <20191022060004.GA333751@sol.localdomain>
 <20191022133001.GA23268@mit.edu>
 <20191023092718.GA23274@infradead.org>
 <20191023125701.GA2460@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023125701.GA2460@mit.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> If and when the vaporware shows up in real hardware, and assuming that
> fscrypt is useful for this hardware, we can name it
> "super_duper_fancy_inline_crypto".  :-)

I think you are entirely missing the point.  The point is that naming
the option someting related to inline encryption is fundamentally
wrong.  It is related to a limitation of existing inline crypto
engines, not related to the fudamental model.  And all the other
rambling below don't matter either.
