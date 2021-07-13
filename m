Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF013C7002
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 13:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbhGML52 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 07:57:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235797AbhGML52 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:57:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5879161073;
        Tue, 13 Jul 2021 11:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626177278;
        bh=EOF664GU/JirSb7RMAso8Dcg/Y3qoOHNWnB1kKbxHjg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tmz32O2m6om0NPJsfboZXP6uqvtAQnEG7DYsbEjS3+k/Xe5etqlymRxdbECnGmh1C
         z5j0RA6nJwMhBhsLG8pU4AcDr6W5/W9k31qSzMiAkOog/pCTqhDog/GUlhN1KqX8zD
         gZY7QBWlB8fCJBHNdlztMY1WAwP+4G5nELTX+beQabqbFnQxXRapd9Ni5DvvCKrQBd
         KE/NuQJ4oOR35RzxA/QH6uenAUXFKonUmppkjol8V7MxjytMXiX4KZfySngMEB7VGQ
         QguKVYt+FQkfbsgeBnbUSJGZepWrIlGGLOyr2jNAOezKdIeulmTtMthlV+Tqj6MP0Y
         PDzr8J/Jc774g==
Message-ID: <f36adf661f37582b51b05c9d8d0a41ea60812b68.camel@kernel.org>
Subject: Re: [PATCH] netfs: Add MAINTAINERS record
From:   Jeff Layton <jlayton@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 13 Jul 2021 07:54:36 -0400
In-Reply-To: <YO0oJvuIXlcmSd7F@infradead.org>
References: <162609279295.3129635.5721010331369998019.stgit@warthog.procyon.org.uk>
         <YO0oJvuIXlcmSd7F@infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-07-13 at 06:44 +0100, Christoph Hellwig wrote:
> On Mon, Jul 12, 2021 at 01:26:32PM +0100, David Howells wrote:
> > Add a MAINTAINERS record for the new netfs helper library.
> 
> Btw, any reason why this code is called netfs?  It is a library
> that seems to mostly be glue code for fscache as far as I can tell and
> has nothing to do with networking at all.

It's infrastructure for network filesystems.

The original impetus was hooking up fscache, though the helper code also
works with fscache disabled. We also have some work in progress to plumb
in fscrypt support, and David is also looking at adding
writepage/writepages support too.

readpage/readpages/writepage/writepages operations in network
filesystems are quite "fiddly", and they all do it in subtly different
ways (and not always for good reasons).

The new read helper infrastructure abstracts a lot of that away, and
gives netfs's a simpler set of operations to deal with. We're hoping to
do the same with writepage/writepages helpers soon.
-- 
Jeff Layton <jlayton@kernel.org>

