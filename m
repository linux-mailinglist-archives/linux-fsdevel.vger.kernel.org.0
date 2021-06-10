Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC203A36EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 00:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhFJWTI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 18:19:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38046 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhFJWTI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 18:19:08 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5BE481FD2F;
        Thu, 10 Jun 2021 22:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623363430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C4XdgvszwNNylBPzQpv8Jyf9m5plh2HyK5cppVlhPtM=;
        b=F4ozuAyrW+cLynMaTH/11ILGZgMUpLZLm5Cuk8H/52kwWZkMMCz8w+jWRJUOsGw7cl2Ib3
        8u1ViD5Cyy8FBk71YO92P+0WMWFzpc8/JlS7UCfAO+n/4T/0H7tpMugYTM/BafzHa0uOkT
        T4Gwzirvj4/ulApYx2ry5IuswerGQoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623363430;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C4XdgvszwNNylBPzQpv8Jyf9m5plh2HyK5cppVlhPtM=;
        b=lHTmVV9MWJSEtdSJ3rZgark3hvp0yAPexLTzS1XQcEh3A8w8raIB42ZOxPbK4GrJnyh3Df
        OGG32ls1E33TDbBg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 2D92E118DD;
        Thu, 10 Jun 2021 22:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623363430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C4XdgvszwNNylBPzQpv8Jyf9m5plh2HyK5cppVlhPtM=;
        b=F4ozuAyrW+cLynMaTH/11ILGZgMUpLZLm5Cuk8H/52kwWZkMMCz8w+jWRJUOsGw7cl2Ib3
        8u1ViD5Cyy8FBk71YO92P+0WMWFzpc8/JlS7UCfAO+n/4T/0H7tpMugYTM/BafzHa0uOkT
        T4Gwzirvj4/ulApYx2ry5IuswerGQoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623363430;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C4XdgvszwNNylBPzQpv8Jyf9m5plh2HyK5cppVlhPtM=;
        b=lHTmVV9MWJSEtdSJ3rZgark3hvp0yAPexLTzS1XQcEh3A8w8raIB42ZOxPbK4GrJnyh3Df
        OGG32ls1E33TDbBg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 7bJICWaPwmDSQQAALh3uQQ
        (envelope-from <ddiss@suse.de>); Thu, 10 Jun 2021 22:17:10 +0000
Date:   Fri, 11 Jun 2021 00:17:09 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/3] docs: remove mention of "crc" cpio format support
Message-ID: <20210611001709.46ea8210@suse.de>
In-Reply-To: <YMKLs8kgUbz2oSdp@casper.infradead.org>
References: <20210610214525.13891-1-ddiss@suse.de>
        <20210610214525.13891-3-ddiss@suse.de>
        <YMKLs8kgUbz2oSdp@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 10 Jun 2021 23:01:23 +0100, Matthew Wilcox wrote:

> >  In human terms, the initramfs buffer contains a collection of
> > -compressed and/or uncompressed cpio archives (in the "newc" or "crc"
> > -formats); arbitrary amounts zero bytes (for padding) can be added
> > -between members.
> > +compressed and/or uncompressed cpio archives (in the "newc" format);
> > +arbitrary amounts zero bytes (for padding) can be added between
> > +members.  
> 
> "arbitrary amounts of zero bytes", but even that doesn't sound quite
> right.  Maybe "arbitrary amount of zero-byte padding between members"?

Your suggestion sounds good to me. Can I squash it in with this change
for a v2, or would you prefer to handle it as a separate grammar fix?

Cheers, David
