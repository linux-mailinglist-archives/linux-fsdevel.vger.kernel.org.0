Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4EFE404D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 01:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbfJXXPy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 19:15:54 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:56356 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfJXXPy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 19:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1571958953; x=1603494953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yzypQ7FgiUXDAdU9c5k8PPyJ8/uARgK8nT+dj8pvnQ8=;
  b=KcWizcLuAsXWTyDo8Efqi2E8yZ45mAY71I6j3FEQbkNumlTi0I1ZQLq1
   VRkD3MWBfEjL6/642yw/u+YVMoXpVMpM9vR2245M/5qHNMsyA4Q+n9fdF
   t8z1StPcAM7p908Qfc/5qDcfp7OBuDn03o9FA73Ktwunp0wia+D44nR/L
   0=;
IronPort-SDR: f/gQn3iYjvI2pqDCQHW9RIEMPhK0eou0OXYAaRBjoa3ptqvcVsgtgkIKVHYPEOcmMCxFzhc3k5
 QJnjmJ92vAdA==
X-IronPort-AV: E=Sophos;i="5.68,226,1569283200"; 
   d="scan'208";a="412386"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 24 Oct 2019 23:15:51 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (Postfix) with ESMTPS id A230CA2B9E;
        Thu, 24 Oct 2019 23:15:49 +0000 (UTC)
Received: from EX13D12UEA004.ant.amazon.com (10.43.61.62) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 24 Oct 2019 23:15:48 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D12UEA004.ant.amazon.com (10.43.61.62) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 24 Oct 2019 23:15:48 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Thu, 24 Oct 2019 23:15:48 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 140A2C450C; Thu, 24 Oct 2019 23:15:48 +0000 (UTC)
Date:   Thu, 24 Oct 2019 23:15:48 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Chuck Lever <chucklever@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/35] user xattr support (RFC8276)
Message-ID: <20191024231547.GA16466@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
 <9CAEB69A-A92C-47D8-9871-BA6EA83E1881@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9CAEB69A-A92C-47D8-9871-BA6EA83E1881@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Chuck,

Thanks for your comments.

On Thu, Oct 24, 2019 at 04:16:33PM -0400, Chuck Lever wrote:
> - IMO you can post future updates just to linux-nfs. Note that the
> kernel NFS client and server are maintained separately, so when it
> comes time to submit final patches, you will send the client work
> to Trond and Anna, and the server work to Bruce (and maybe me).

Sure, I'll do that.

> 
> - We like patches that are as small as possible but no smaller.
> Some of these might be too small. For example, you don't need to add
> the XDR encoders, decoders, and reply size macros in separate patches.

True, I might have gone overboard there :-) If you can send further
suggestions offline, that'd be great!

> - Please run scripts/checkpatch.pl on each patch before you post
> again. This will help identify coding convention issues that should
> be addressed before merge. sparse is also a good idea too.
> clang-format is also nice but is entirely optional.

No problem. I think there shouldn't be many issues, but I'm sure
I mixed up some of the coding styles I've had to adhere to over
the decades..

> 
> - I was not able to get 34/35 to apply. The series might be missing
> a patch that adds nfsd_getxattr and friends.

Hm, odd. I'll check on that - I might have messed up there.

> 
> - Do you have man page updates for the new mount and export options?

I don't, but I can easily write them. They go in nfs-utils, right?

> - I'm not clear why new CONFIG options are necessary. These days we
> try to avoid adding new CONFIG options if possible. I can't think of
> a reason someone would need to compile user xattr support out if
> NFSv4.2 is enabled.
> 
> - Can you explain why an NFS server administrator might want to
> disable user xattr support on a share?

I think both of these are cases of being careful. E.g. don't enable
something by default and allow it to be disabled at runtime in
case something goes terribly wrong.

I didn't have any other reasons, really. I'm happy do to away with
the CONFIG options if that's the consensus, as well as the
nouser_xattr export option.

> - Probably you are correct that the design choices you made regarding
> multi-message LISTXATTR are the best that can be done. Hopefully that
> is not a frequent operation, but for something like "tar" it might be.
> Do you have any feeling for how to assess performance?

So far, my performance testing has been based on synthetic workloads,
which I'm also using to test some boundary conditions. E.g. create
as many xattrs as the Linux limit allows, list them all, now do
this for many files, etc. I'll definitely add testing with code
that uses xattrs. tar is on the list, but I'm happy to test anything
that exercises the code.

I don't think a multi-message LISTXATTR will happen a lot in practice,
if at all.

> 
> - Regarding client caching... the RFC is notably vague about what
> is needed there. You might be able to get away with no caching, just
> as a start. Do you (and others) think that this series would be
> acceptable and mergeable without any client caching support?

The performance is, obviously, not great without client side caching.
But then again, that's on my synthetic workloads. In cases like GNU
tar, it won't matter a whole lot because of the way that code is
structured.

I would prefer to have client side caching enabled from the start.
I have an implementation that works, but, like I mentioned, I
have some misgivings about it. But I should just include it when
I re-post - I might simply be worrying too much.

> 
> - Do you have access to an RDMA-capable platform? RPC/RDMA needs to
> be able to predict how large each reply will be, in order to reserve
> appropriate memory resources to land the whole RPC reply on the client.
> I'm wondering if you've found any particular areas where that might be
> a challenge.

Hm. I might be able to set something up. If not, I'd be relying
on someone you might know to test it for me :-)

I am not too familiar with the RDMA RPC code. From what I posted, is 
there any specific part of how the RPC layer is used that would
be of concern with RDMA?

I don't do anything other parts of the code don't do. The only special
case is using on-demand page allocation on receive, which the ACL code
also does (XDRBUF_SPARSE_PAGES - used for LISTXATTR and GETXATTR).

> 
> 
> Testing:
> 
> - Does fstests already have user xattr functional tests? If not, how
> do you envision testing this new code?

https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/ has some xattr
tests. I've, so far, been using my own set of tests that I'm happy
to contribute to any testsuite.

> 
> - How should we test the logic that deals with delegation recall?

I believe pyNFS has some logic do test this. What I have been doing
is manual testing, either using 2 clients, or, simpler, setting
xattrs on a file on the server itself, and verifying that client
delegations were recalled.

> 
> - Do you have plans to submit patches to pyNFS?

It wasn't in my plans, but I certainly could. One issue I've noticed,
with pyNFS and some other tests, is that they go no further than 4.1.
They'll need some more work to do 4.2 - although that shouldn't be
a lot of work, as most (or was it all?) features in 4.2 are optional.

I've not had much time to work on this in the past few weeks, but
next week is looking much better. Here's my plan:

* address any issues flagged by checkpatch
* merge some patches, with your input
* clean up my nfs-ganesha patches and test some more against that
* test against Rick's FreeBSD prototype
* repost the series, split in to client and server

In general, what do people do with code changes that affect both
client and server (e.g. generic defines)?

Thanks,

- Frank
