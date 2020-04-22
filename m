Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A991B47F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 16:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgDVO7n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 10:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgDVO7n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 10:59:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E7FC03C1A9;
        Wed, 22 Apr 2020 07:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3wiOlfuET1e01r1zvjRWWoC2fuMUHigHjGVaVH8nUb8=; b=I1fdJitkAE8vmrzgpzZ7MnV2/S
        K3URUqqRY1BjUGUiINf2H78+s4hQ+NoIkjZhJoADkDKOMyhPb2AckGBLueqmWoJ3fD+iFBB2KdizQ
        ilQw0iP2AOAe6TK+lXK0HDgySWKgzdaH6GeYajWajHOsh9S83C5dS0wCGTzhjpK5TCeQm4xGXapVf
        G7ujKmAxhWjU24+2i8eM6LpOAuZMfRW0GeROlr8sBqvizHGxVTCRNVsF+daVAvzCHLucBQ0/0mxZf
        l1ohhRY819ZmiYcu/Ak1fnjh1BlsIGaQ0kiFpxSxr3oFtJL5EgNDWrhx/LTFQShJ9ltUjWnGLMm5y
        d3XvFMOw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRGqY-0007IK-Gd; Wed, 22 Apr 2020 14:59:30 +0000
Date:   Wed, 22 Apr 2020 07:59:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild test robot <lkp@intel.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <skhan@linuxfoundation.org>,
        bjorn.andersson@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        kbuild-all@lists.01.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v3 6/7] misc: bcm-vk: add Broadcom VK driver
Message-ID: <20200422145930.GA12731@infradead.org>
References: <20200420162809.17529-7-scott.branden@broadcom.com>
 <202004221945.LY6x0DQD%lkp@intel.com>
 <20200422113558.GJ2659@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422113558.GJ2659@kadam>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 22, 2020 at 02:35:58PM +0300, Dan Carpenter wrote:
> Sorry, you asked me about this earlier.  You will need to add
> -D__CHECK_ENDIAN__ to enable these Sparse warnings.

Endian checking has been enabled by default for quite a while.
