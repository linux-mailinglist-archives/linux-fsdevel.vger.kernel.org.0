Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CD430CF2D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 23:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbhBBWi3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 17:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbhBBWho (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 17:37:44 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49C6C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Feb 2021 14:37:03 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 8B768C021; Tue,  2 Feb 2021 23:37:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1612305421; bh=IMrtttN1mi28dq233XNJOGfQCzxwUb1Bj3ffhZBkhcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PrCUhJ2/1qS5npk8AwSvuEA4/+DChPsN1FqzAbFrLdXZHjMIUk3z86s39qbc8cmbO
         NwaPxKDF6iXanJ6FsCAZYoYIOpbiCK5rReHP4pltJX7OM9Aep7NN90ebhQArnIvA/6
         ZYfp5zix9ZFEe0TieYHxMAHBcytB8VFhkJcjt6WvRYjLQNWm/aDu8Ou+sNWy/fn7gS
         SiUp56FdZe9d9jJDatNLlBAn/JQYS9vxS/twKKFEC+5y4vAiOK6eP3fJmUbvgvdcsi
         jA4ufFKi/zLXxYAPhnsjA2A7ZEjWBlxUxpC923BOMry6zAaheJusGvCWwJU/5xJaxf
         Wm+G7qFOu9HNw==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from tyr.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTP id 87D1CC01C;
        Tue,  2 Feb 2021 23:37:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1612305421; bh=IMrtttN1mi28dq233XNJOGfQCzxwUb1Bj3ffhZBkhcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PrCUhJ2/1qS5npk8AwSvuEA4/+DChPsN1FqzAbFrLdXZHjMIUk3z86s39qbc8cmbO
         NwaPxKDF6iXanJ6FsCAZYoYIOpbiCK5rReHP4pltJX7OM9Aep7NN90ebhQArnIvA/6
         ZYfp5zix9ZFEe0TieYHxMAHBcytB8VFhkJcjt6WvRYjLQNWm/aDu8Ou+sNWy/fn7gS
         SiUp56FdZe9d9jJDatNLlBAn/JQYS9vxS/twKKFEC+5y4vAiOK6eP3fJmUbvgvdcsi
         jA4ufFKi/zLXxYAPhnsjA2A7ZEjWBlxUxpC923BOMry6zAaheJusGvCWwJU/5xJaxf
         Wm+G7qFOu9HNw==
Received: from tyr.codewreck.org (localhost [127.0.0.1])
        by tyr.codewreck.org (Postfix) with SMTP id 43C2D28076C;
        Wed,  3 Feb 2021 07:36:59 +0900 (JST)
Received: (from asmadeus@codewreck.org)
        by tyr.codewreck.org (mini_sendmail/1.3.9 19Oct2015);
        Wed, 03 Feb 2021 07:36:59 JST
        (sender asmadeus@tyr.codewreck.org)
Date:   Wed, 3 Feb 2021 07:36:44 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] 9p: Convert to cut-down fscache I/O API rewrite
Message-ID: <20210202223644.GA27614@tyr>
References: <241017.1612263863@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <241017.1612263863@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

David Howells wrote on Tue, Feb 02, 2021 at 11:04:23AM +0000:
> Here's a draft of a patch to convert 9P to use the cut-down part of the
> fscache I/O API rewrite (I've removed all the cookie and object state machine
> changes for now).  It compiles, but I've no way to test it.  This is built on
> top of my fscache-netfs-lib branch:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-netfs-lib

Thanks for going the extra mile with all this, it's appreciated!

> I'm hoping to ask Linus to pull the netfs lib, afs and ceph changes in the
> next merge window.
> 
> Would you be able to give it a whirl?

I'm afraid I won't have much time to give for the next merge window (in
roughly 2-4 weeks iiuc)
I can probably find some time to run very basic tests from my usual
setup but testing actual fscache capabilities will take more time and
I'm quite short right now -- I honestly have no idea if anyone uses
fscache or if it's even working right now so I'd rather take a moment to
test it properly before/after, and it's time I don't have right now.


OTOH I'd support getting the netfs lib in as planned this merge window,
and I'll definitely take the time to test this patch into my tree before
the next one in ~3months.
I think the whole point of the rework you've done is we can do things
more smoothly and there is no reason to rush it anymore, having the new
lib get tested through afs/ceph in the real world can only be reassuring
for other filesystems.

Cheers,
-- 
Dominique
