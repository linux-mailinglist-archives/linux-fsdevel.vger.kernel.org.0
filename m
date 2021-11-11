Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C79E44D842
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 15:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbhKKOcP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 09:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbhKKOcO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 09:32:14 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64193C061767;
        Thu, 11 Nov 2021 06:29:25 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id ED658C01F; Thu, 11 Nov 2021 15:29:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1636640958; bh=FLQzEjkMg/HyEOuGGfg/HD+FqViJ2CfzeI4vtlX4CKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=14LM0lsJlo8UFQwB0ITWsURyJMpC6p7GbMWBmlWlqq78qjvpvHZ8JhvcPHLW7x4hr
         +kZ2yJi9efxxriJ4dOjWjYW+aOEKLr8uCABtSbW/hMVGtMwroMA8YU+zBEuAVuq1y+
         Eh77/eihcaliAQHZyqXMXIUlD/yf4gwHCBY0h03Ug83aaMJ8M7RL6e8DxaEhg+DhXN
         5bnrEUdsfpqlhB0wWaX1t+ZbQ0j6nXY0wzg/fNBvEGCzcg8RqpVYk71bKwMEREbWst
         c+VGu21kWdEw3CC7yKbyoDgS1rpHQfaJPUG4W0PIbnPgPBuKYi5B/NuoBMYZp6Sz18
         yKHs6nCXq36cg==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id F18D9C009;
        Thu, 11 Nov 2021 15:29:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1636640958; bh=FLQzEjkMg/HyEOuGGfg/HD+FqViJ2CfzeI4vtlX4CKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=14LM0lsJlo8UFQwB0ITWsURyJMpC6p7GbMWBmlWlqq78qjvpvHZ8JhvcPHLW7x4hr
         +kZ2yJi9efxxriJ4dOjWjYW+aOEKLr8uCABtSbW/hMVGtMwroMA8YU+zBEuAVuq1y+
         Eh77/eihcaliAQHZyqXMXIUlD/yf4gwHCBY0h03Ug83aaMJ8M7RL6e8DxaEhg+DhXN
         5bnrEUdsfpqlhB0wWaX1t+ZbQ0j6nXY0wzg/fNBvEGCzcg8RqpVYk71bKwMEREbWst
         c+VGu21kWdEw3CC7yKbyoDgS1rpHQfaJPUG4W0PIbnPgPBuKYi5B/NuoBMYZp6Sz18
         yKHs6nCXq36cg==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 33223ae0;
        Thu, 11 Nov 2021 14:29:09 +0000 (UTC)
Date:   Thu, 11 Nov 2021 23:28:53 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     David Howells <dhowells@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-afs@lists.infradead.org, Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-cachefs@redhat.com, Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel@vger.kernel.org, kafs-testing@auristor.com,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, devel@lists.orangefs.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/4] netfs, 9p, afs, ceph: Support folios, at least
 partially
Message-ID: <YY0opaUbuiqMGHpr@codewreck.org>
References: <163657847613.834781.7923681076643317435.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <163657847613.834781.7923681076643317435.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells wrote on Wed, Nov 10, 2021 at 09:07:56PM +0000:
> Here's a set of patches to convert netfs, 9p and afs to use folios and to
> provide sufficient conversion for ceph that it can continue to use the
> netfs library.  Jeff Layton is working on fully converting ceph.
> 
> This has been rebased on to the 9p merge in Linus's tree[5] so that it has
> access to both the 9p conversion to fscache and folios.

Ran basic tests on 9p with this; it'd probably deserve a bit more
soak-in but at least doesn't seem to break anything obvious:
(Re-)Tested-by: Dominique Martinet <asmadeus@codewreck.org>

-- 
Dominique
