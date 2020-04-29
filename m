Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9DF1BD1C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 03:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgD2Bgi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 21:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgD2Bgi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 21:36:38 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29084C03C1AC;
        Tue, 28 Apr 2020 18:36:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49Bh1s0GwXz9sSb;
        Wed, 29 Apr 2020 11:36:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1588124194; bh=aX6yuTZNfS6VpnGOKXY3BwUwvbi+L3YPZlT8aZPIt/Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sLXdyA3asl4Ggu+8sp54jw2RxX89A307Eca03BspfzrH5LAbDE8tcQ7GXelho0cJ4
         h0+ugwPDC0ylK0WrGGYom841yaBKVxl7ZDsBwTGt479MPHm3YLsyUenIawkyqeWeGK
         5DgdA4AH+ve27bFPyGSW2irceBlfdO/Gh7x7XdgVxt5LrczFlchU5WPu7RUCRPVQc1
         HfirjIkc2a/MCcXSnZbs+R2OHfX57P2JK9lUGvooL70+eH91x52qwtRjqokz+RhUfg
         Vh39zw4qpqmfBzNS5pZKFPyHdzDIS4NVysxTIj+8RIta8BZUH/ukIKyK7nrpvRDcTf
         UABIFc++ieJAQ==
Message-ID: <e1ebea36b162e8a3b4b24ecbc1051f8081ff5e53.camel@ozlabs.org>
Subject: Re: [RFC PATCH] powerpc/spufs: fix copy_to_user while atomic
From:   Jeremy Kerr <jk@ozlabs.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 29 Apr 2020 09:36:30 +0800
In-Reply-To: <20200428171133.GA17445@lst.de>
References: <20200427200626.1622060-2-hch@lst.de>
         <20200428120207.15728-1-jk@ozlabs.org> <20200428171133.GA17445@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

> FYI, these little hunks reduce the difference to my version, maybe
> you can fold them in?

Sure, no problem.

How do you want to coordinate these? I can submit mine through mpe, but
that may make it tricky to synchronise with your changes. Or, you can
include this change in your series if you prefer.

Cheers,


Jeremy


