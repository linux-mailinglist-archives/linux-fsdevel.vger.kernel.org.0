Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05E328892F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2019 09:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfHJHdp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Aug 2019 03:33:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55950 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfHJHdo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Aug 2019 03:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gJYmqx91UW51PwstFu/SbwoN2sPZyfxSlyDhyB1diYY=; b=Nf/MKbkXd9zE6PPSILwzde3Sb
        r5lK9lMJrS0cd0kYwi5nJE4XYDJshkjQJDpSx4Jq6BZCGJNTp3JkHFiS0u5NgmoWWMnPPW02Ivrrs
        8vSanjo2z7qY/xauq89FEx+pxdaKixlL9Hj0E8bPs2I+mRKF4gF+ljaJRUrEnofQovY4EHK67aOJc
        LXNyItOurG0wKMKi5igKGRq0HEihdfoFsXZHEEqv4XgobUAu0UK8eSR4M3x+/aCvu6MGcO9C/LwTV
        WX3sNw0NyYpUjoD3ONblHSpX2095qPHeA1PInJhvxFYa0jbbExDWCgNOC36VXRdZL7Mda6CBUw5/2
        kG2IEpDkw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hwLsl-0003Qy-VD; Sat, 10 Aug 2019 07:33:43 +0000
Date:   Sat, 10 Aug 2019 00:33:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 1/3] ext4: return the extent cache information via fiemap
Message-ID: <20190810073343.GA12777@infradead.org>
References: <20190809181831.10618-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809181831.10618-1-tytso@mit.edu>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Fri, Aug 09, 2019 at 02:18:29PM -0400, Theodore Ts'o wrote:
> For debugging reasons, it's useful to know the contents of the extent
> cache.  Since the extent cache contains much of what is in the fiemap
> ioctl, extend the fiemap interface to return this information via some
> ext4-specific flags.

Nak.  No weird fs specific fiemap flags that aren't even in the uapi
header.  Please provide your own debug only interface.
