Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5834D6D7E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Mar 2022 09:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiCLIPG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Mar 2022 03:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiCLIPG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Mar 2022 03:15:06 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6F61261A;
        Sat, 12 Mar 2022 00:14:00 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 7F113C020; Sat, 12 Mar 2022 09:13:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1647072836; bh=jFy3V5tJygVoG+31/6kc8XlbG5/C7Z4Td0QKNDh9/WU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=busjI0t7vgzULY8jXBsjcE6B8BrO6/e1n352++NjPRTXLTBOuK7XBO6As8kBlRnwV
         T4jabpmD0ADkGHN57LmECyjH+mS/nMWJ93nxoPtHJTM0a61Il4V0mjGyog1I8diFL1
         TWyq91VE4qWaDm/WWL948pRLP85S1yWoRgdS/q22+u8ffNdnSuPyU2V9SIIkgbq8UU
         VKmJ/yrzKkjJqjgtTmTZMb7bnIXYpm5/HG4/vnrXgePXpNUOnS/UZgktyp7FMtd+2S
         smMi2f+b5FY162ibvUm6R+rnwx6dJi4Kvlq7UFYlNbmz1fnMqBr9xAh2Pguhnp8tfE
         fTnd+bfqV6E1g==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 1ADC3C009;
        Sat, 12 Mar 2022 09:13:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1647072835; bh=jFy3V5tJygVoG+31/6kc8XlbG5/C7Z4Td0QKNDh9/WU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iSKF4cf4U0hmfSjiK8vQqls/D/IdiX53/xbtJCnilU20M24d8ieUWHg3NYDYmC7Jj
         HWTZ/dgs1XPBXRpO4znrreaXG2trQiKcivKx9K7+h95oxej/WvQbITBQxI3SEO0sq/
         48iK7CoijX4VI0/vm1uuI0RI4UlXC5l9qf+322YcqDE3knM4dGf3gYZ/bjCzv89rWX
         shs44QSDOm4XstiOgZPhFXhohmVIL9f0I+JcolbPqqvHNA9yG6VJeW7Bux5xs4Fz10
         mWZY/vKUwk16AeA3GuzQQzWI03/GehZ6uU5nDerRoSYRrqDcQjmf7IFkgWCMBpPvTR
         VEskXuzquTMeQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 72c8ef7a;
        Sat, 12 Mar 2022 08:13:47 +0000 (UTC)
Date:   Sat, 12 Mar 2022 17:13:32 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, ceph-devel@vger.kernel.org,
        Jeff Layton <jlayton@redhat.com>,
        linux-afs@lists.infradead.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/20] netfs: Prep for write helpers
Message-ID: <YixWLJXyWtD+STvl@codewreck.org>
References: <164692883658.2099075.5745824552116419504.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <164692883658.2099075.5745824552116419504.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells wrote on Thu, Mar 10, 2022 at 04:13:56PM +0000:
> The patches can be found on this branch:
> 
> 	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-next

Looks good to me from the 9p side:
Tested-by: Dominique Martinet <asmadeus@codewreck.org> # 9p

writes being done by 4k chunk is really slow so will be glad to see this
finished, keep it up! :)

-- 
Dominique
