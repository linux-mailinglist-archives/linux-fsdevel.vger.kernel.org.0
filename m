Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167381BB42D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 04:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgD1CwC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 22:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726264AbgD1CwC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 22:52:02 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C95C03C1A9;
        Mon, 27 Apr 2020 19:52:02 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49B5lL0BjJz9sRY;
        Tue, 28 Apr 2020 12:51:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1588042319; bh=r5Tvdog+oekyzSzSlTc7HgiNfwz4L1TcZBGr5ZE+R9Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=I8N3xVH+hQtt50jVi6Jl7REeiYhE+Ms2nP1zfHzGZCOaJxtALGlwrn+1EedXTMiI/
         5FhMU67SHJd2vI0nhihcCftizAnuSUxBuMXwXIKH63+aeCRDClv7C0oO3NNphbTbUw
         gO3zmC+2mDlaFpvp24+UUVBJNqeZ/w56gwe29raW3TFZq1Eq3JDGF8Q8MSs5TVl8bG
         XmjXpEADeFeBz3Zkrf9sfMtKLciDNIczRo3QZJ1LU8MHD2CIbJDfCJJn/DXu4dxxsR
         A0g8HIJXHRNy97HlStw9iDlAvS99j3d6NIz39OKFty1f5KF5FMmDorhb2CZhu2smcD
         LnhwwQ0e38M8Q==
Message-ID: <fc3b45c91e5cd50baa1fec7710f1e64cbe616f77.camel@ozlabs.org>
Subject: Re: [PATCH 1/5] powerpc/spufs: simplify spufs core dumping
From:   Jeremy Kerr <jk@ozlabs.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 28 Apr 2020 10:51:56 +0800
In-Reply-To: <20200427204953.GY23230@ZenIV.linux.org.uk>
References: <20200427200626.1622060-1-hch@lst.de>
         <20200427200626.1622060-2-hch@lst.de>
         <20200427204953.GY23230@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al & Christoph,

> Again, this really needs fixing.  Preferably - as a separate commit
> preceding this series, so that it could be
> backported.  simple_read_from_buffer() is a blocking operation.

I'll put together a patch that fixes this.

Christoph: I'll do it in a way that matches your changes to the _read
functions, so hopefully those hunks would just drop from your change,
leaving only the _dump additions. Would that work?

Cheers,


Jeremy

