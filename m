Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02E6717E83B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 20:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgCITWq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 15:22:46 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:52095 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726118AbgCITWq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:22:46 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0273F2165;
        Mon,  9 Mar 2020 15:22:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 09 Mar 2020 15:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=9OPUApP7XHwBJ2ua/845zHXN+Bx
        CiMndYLVmUljdPfs=; b=Zx+aJhCQuuW9zL3vV9mkX5vIdNdmN8/IWDffz8jj8Gb
        2VqO7mxto+/Dg70LiN2yzj5fiYHNKAZzx3yPelxgwUoQ+is2cdcJE5cIvJzPpLwP
        1xPCpmX1WtFmzCKNubm6b5P2EF7CkKxJXHsEs6ybNxRzQCPJzbqZOZSd96rAWA/s
        7nO1xn8GN/rhw5+44q9xquYivc/LsB5DNy1Sr7wODuT8vz1B9CEd7RzJQ6+yCPws
        Q4BQsksfc1slCjyk7DZeBxKlsDmu+IkwTWvjrJ+31T+ybHClZpCgA7ZxHxIt60ze
        0rjBlnXvVbJq19rll/30PhxY+fbw911ReY76p4D4+Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=9OPUAp
        P7XHwBJ2ua/845zHXN+BxCiMndYLVmUljdPfs=; b=Jz9WWT0OhfWbV49D+wIuxm
        3sJ9Kel6t8sFJrmVyv19hsEiQzOp4evJzLdEZVY55UsNPi/dB2hyJt29LHCe6dgR
        e9kD+L7Mfl3qIo5ngts0zeS4esAEGVEiQFlDYmvxdL6dProHeRHBKtaE/tUyf/00
        8oGdCWK0UbGe2iA2wkAaSoN7+HqKLQfmK+nd513rMwVTTJKW1TPnr406mI6fJgBD
        SO+dv4s23dzemFtebeyTZ4TOCeYWUAeWda6lC3gkrRn/vRPfMhiXV1tyvQYLY7M6
        H1SvTye3XXhWvy0SBwMOBi4R8fHduIcKySwDxPapJ+gRfXM3EFhrm2VGK8Ka2Q+A
        ==
X-ME-Sender: <xms:gpdmXp0izSospZhLf9jd8uC2VihdmnYjkksGoMYJO5iAvhtB2c7OrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddukedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecukfhppe
    eijedrudeitddrvddujedrvdehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegrnhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:gpdmXqsjquW8ESXmD9dxw71lrZxnA5nkpUkgfENiIXmvTlgnk7KhPw>
    <xmx:gpdmXt-8hZpIoe7KcTaKx1a6wafRA-cm_jvCbBkbXxQTt9fR8FhqqQ>
    <xmx:gpdmXsFJrGZGb8n1mvKJXXT6i_-ZMHWQeAlCmdtbguoV7-ys584J8Q>
    <xmx:g5dmXndVRmQTWz4NUF8L_57jSTW2SmewMAEhD-D5atrKfdws8K2IJA>
Received: from intern.anarazel.de (c-67-160-217-250.hsd1.ca.comcast.net [67.160.217.250])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0771F328005A;
        Mon,  9 Mar 2020 15:22:42 -0400 (EDT)
Date:   Mon, 9 Mar 2020 12:22:40 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, Theodore Ts'o <tytso@mit.edu>,
        Stefan Metzmacher <metze@samba.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-api@vger.kernel.org,
        raven@themaw.net, mszeredi@redhat.com, christian@brauner.io,
        jannh@google.com, darrick.wong@oracle.com, kzak@redhat.com,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] VFS: Filesystem information [ver #18]
Message-ID: <20200309192240.nqf5bxylptw7mdm3@alap3.anarazel.de>
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
 <2d31e2658e5f6651dc7d9908c4c12b6ba461fc88.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d31e2658e5f6651dc7d9908c4c12b6ba461fc88.camel@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 2020-03-09 13:50:59 -0400, Jeff Layton wrote:
> The PostgreSQL devs asked a while back for some way to tell whether
> there have been any writeback errors on a superblock w/o having to do
> any sort of flush -- just "have there been any so far".

Indeed.


> I sent a patch a few weeks ago to make syncfs() return errors when there
> have been writeback errors on the superblock. It's not merged yet, but
> once we have something like that in place, we could expose info from the
> errseq_t to userland using this interface.

I'm still a bit worried about the details of errseq_t being exposed to
userland. Partially because it seems to restrict further evolution of
errseq_t, and partially because it will likely up with userland trying
to understand it (it's e.g. just too attractive to report a count of
errors etc).

Is there a reason to not instead report a 64bit counter instead of the
cookie? In contrast to the struct file case we'd only have the space
overhead once per superblock, rather than once per #files * #fd. And it
seems that the maintenance of that counter could be done without
widespread changes, e.g. instead/in addition to your change:

> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index ccb14b6a16b5..897439475315 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -51,7 +51,10 @@ static inline void mapping_set_error(struct address_space *mapping, int error)
>  		return;
>
>  	/* Record in wb_err for checkers using errseq_t based tracking */
> -	filemap_set_wb_err(mapping, error);
> +	__filemap_set_wb_err(mapping, error);
> +
> +	/* Record it in superblock */
> +	errseq_set(&mapping->host->i_sb->s_wb_err, error);
>
>  	/* Record it in flags for now, for legacy callers */
>  	if (error == -ENOSPC)

Btw, seems like mapping_set_error() should have a non-inline cold path?

Greetings,

Andres Freund
