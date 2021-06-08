Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2CD3A0653
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 23:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbhFHVn7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 17:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbhFHVn6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 17:43:58 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4001C061574
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jun 2021 14:42:04 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 3FB5CC022; Tue,  8 Jun 2021 23:42:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1623188520; bh=BzT3wyhqpB6185zh00HzeGjst0xNZzNRNRcMkS0h4Ek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TPCVJJPheMdSOTumApcB7X+1E/NcOwTUaPkWOc0lpWofraySQuqK/Fcz1QR6mNJu/
         JbIBKs/drSoZzxeIaf8DU0tcv9YgrMNiR9LgzEx5Jp9SRNagHzDD3i7zi+FOEo/XNJ
         PbSCFfPCoCcvdEbuB9SHmSId3kCsa3A9i6hzSXy45RUsscxetLrLqsMCTUaNMm49UN
         bwYG+NWjh/K8BEQOhSdGCCVa17ZOAdaJ6qeDg+T+pKZf2Yhee13uQc7YW8WObvi3GL
         70AEi/UPGVfR2Jv2x6K94NNblVioAzUPYNkVqPqAoBESmnu/nAN5SlJ3uRurgWzvvm
         BCngHHHE4/VLg==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id B5FE2C01A;
        Tue,  8 Jun 2021 23:41:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1623188519; bh=BzT3wyhqpB6185zh00HzeGjst0xNZzNRNRcMkS0h4Ek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hZs7zDSzWVrirXlYRkb+jr8ZfGHEWgLxIP6E4ym/fYo38OHCnrgAXLk03GvlJ80wc
         x4mK1vQ5pH8UOHFvd8L4zqag2eWJnnMdHYfznLUafJ+oP8csmM21fusFJhPGd2IHMP
         x2A+h/66ugFwS/ecXQDBFnfvvyZGsFSNO6ofK0bLXiyzQARFG4DcbZyQFti3B4i1my
         A1JVbDm/2VNinrbZODsGhJfERVUeNRvAsCBcacT/cJA9HGmH/LIBAiFl42Et7hhdXk
         NDJ/fB7kpmf30DKYvH2PI4iaXRNGopmekboUxPqkpuDH/pgxlmDD+K+kI4L1avIiaK
         H/hT4xQFNqKGw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 4cf7185a;
        Tue, 8 Jun 2021 21:41:53 +0000 (UTC)
Date:   Wed, 9 Jun 2021 06:41:38 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Vivek Goyal <vgoyal@redhat.com>,
        Changbin Du <changbin.du@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        stefanha@redhat.com,
        Richard Weinberger <richard.weinberger@gmail.com>,
        dgilbert@redhat.com, v9fs-developer@lists.sourceforge.net,
        Enrico Weigelt <lkml@metux.net>
Subject: Re: [PATCH] init/do_mounts.c: Add root="fstag:<tag>" syntax for root
 device
Message-ID: <YL/kEpcaYE/Jr0J7@codewreck.org>
References: <20210608153524.GB504497@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210608153524.GB504497@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

... And that's why I told Changbin Du a few times his patches needed
more Ccs :/

FWIW: we just got last month a couple of patches that would allow
initrd-less 9p root mount (using the nfs/cifs method described below
with root=/dev/v9fs)

Vivek Goyal wrote on Tue, Jun 08, 2021 at 11:35:24AM -0400:
> NFS and CIFS use "root=/dev/nfs" and CIFS passes "root=/dev/cifs" and
> actual root device details come from filesystem specific kernel
> command line options.
> 
> virtiofs does not seem to fit in any of the above categories. In fact
> we have 9pfs which can be used to boot from but it also does not
> have a proper syntax to specify rootfs and does not fit into any of
> the existing syntax. They both expect a device "tag" to be passed
> in a device to be mounted. And filesystem knows how to parse and
> use "tag".
> 
> So this patch proposes that we add a new prefix "fstag:" which specifies
> that identifier which follows is filesystem specific tag and its not
> a block device. Just pass this tag to filesystem and filesystem will
> figure out how to mount it.


...However I agree something more generic would be welcome in my
opinion, so I like this approach.

I'll give it a try for 9p over the weekend and report back.

-- 
Dominique
