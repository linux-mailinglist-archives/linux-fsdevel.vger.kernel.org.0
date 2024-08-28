Return-Path: <linux-fsdevel+bounces-27512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA79F961D95
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 06:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B945DB21333
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 04:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3964A145A0F;
	Wed, 28 Aug 2024 04:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ev0B8fFT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C9D18030;
	Wed, 28 Aug 2024 04:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724819207; cv=none; b=M+PGkzsTsFJs1vX0auGamhZuWBEEoAo6/iKHyvEpXgn5dYqHcS802AD9JgbvP5GtPz39kMgpOGDJ2pRYpUxXhPI8hd7w8IRXAtzqbz2eR8Kup5AMI9K7hm5Y9ihKipNaYivcKyDlDNnetoVK637o2U2q3P2C+JrsGQ+LYdHwGvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724819207; c=relaxed/simple;
	bh=QEbprjT5kmehF6XMhE7a7sFNC3wff46vJzh3QMdQjwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rb7EIS85WUEIBCIOuCZ1XP41PDTOjpzvZFmIssqEA2woQxJYIgbkB70ds59YgDv0o0EpuvqdBaCD/a9E7RAr7W3Tw/A9HAvanaCUVZs0FPlYa1ViA/GvkT1poZBybWGaxDnacvQLgL0QzoepWhranT6LWedRmM1JIjpos+TUN6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ev0B8fFT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C42DC4FF03;
	Wed, 28 Aug 2024 04:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724819207;
	bh=QEbprjT5kmehF6XMhE7a7sFNC3wff46vJzh3QMdQjwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ev0B8fFTBp/hMV8o4x5LL1I+vByFH9QfYx5ZC18U/xObPIQp1BJb0g8fX2HDqLhBP
	 Z09S0UKXraXayOIIBJIQYI9wX5pb8xoxf46hDk8FBJaLDWbY+/mOi0OnrPJn5h+A5V
	 5DKWiBUtjOgvJUFotzih6RgDyIZ8zexq4XSbioKduep4SBMHWf2jj5pLKHfw7eDzeF
	 1MoUJymIxPCp5XK5wo7YFP481mM3keo3RB7FNYMzq3jLC3l4xjn3orHeh8rFbU7szC
	 qmDeZJW9+bvcxmshDEwg6/uqTUbucwygdCHAVSrjo8p0CfXrLRIHvlL6KDLkMyAHkZ
	 BnQqC3ruxN5iA==
Date: Wed, 28 Aug 2024 00:26:46 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Trond Myklebust <trondmy@hammerspace.com>,
	"anna@kernel.org" <anna@kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH v13 19/19] nfs: add FAQ section to
 Documentation/filesystems/nfs/localio.rst
Message-ID: <Zs6nBhV6I_OnwkJy@kernel.org>
References: <>
 <aec659a886f7da3beded2b0ecce452e1599f9adc.camel@hammerspace.com>
 <172480206591.4433.15677232468943767302@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <172480206591.4433.15677232468943767302@noble.neil.brown.name>

On Wed, Aug 28, 2024 at 09:41:05AM +1000, NeilBrown wrote:
> On Wed, 28 Aug 2024, Trond Myklebust wrote:
> > On Wed, 2024-08-28 at 07:49 +1000, NeilBrown wrote:
> > > On Tue, 27 Aug 2024, Trond Myklebust wrote:
> > > > > 
> > > > > 
> > > > > > On Aug 25, 2024, at 9:56 PM, NeilBrown <neilb@suse.de> wrote:
> > > > > > 
> > > > > > While I'm not advocating for an over-the-wire request to map a
> > > > > > filehandle to a struct nfsd_file*, I don't think you can
> > > > > > convincingly
> > > > > > argue against it without concrete performance measurements.
> > > > > 
> > > > 
> > > > What is the value of doing an open over the wire? What are you
> > > > trying
> > > > to accomplish that can't be accomplished without going over the
> > > > wire?
> > > 
> > > The advantage of going over the wire is avoiding code duplication.
> > > The cost is latency.  Obviously the goal of LOCALIO is to find those
> > > points where the latency saving justifies the code duplication.
> > > 
> > > When opening with AUTH_UNIX the code duplication to determine the
> > > correct credential is small and easy to review.  If we ever wanted to
> > > support KRB5 or TLS I would be a lot less comfortable about reviewing
> > > the code duplication.
> > > 
> > > So I think it is worth considering whether an over-the-wire open is
> > > really all that costly.  As I noted we already have an over-the-wire
> > > request at open time.  We could conceivably send the LOCALIO-OPEN
> > > request at the same time so as not to add latency.  We could receive
> > > the
> > > reply through the in-kernel backchannel so there is no RPC reply.
> > > 
> > > That might all be too complex and might not be justified.  My point
> > > is
> > > that I think the trade-offs are subtle and I think the FAQ answer
> > > cuts
> > > off an avenue that hasn't really been explored.
> > > 
> > 
> > So, your argument is that if there was a hypothetical situation where
> > we wanted to add krb5 or TLS support, then we'd have more code to
> > review?
> > 
> > The counter-argument would be that we've already established the right
> > of the client to do I/O to the file. This will already have been done
> > by an over-the-wire call to OPEN (NFSv4), ACCESS (NFSv3/NFSv4) or
> > CREATE (NFSv3). Those calls will have used krb5 and/or TLS to
> > authenticate the user. All that remains to be done is perform the I/O
> > that was authorised by those calls.
> 
> The other thing that remains is to get the correct 'struct cred *' to
> store in ->f_cred (or to use for lookup in the nfsd filecache).
> 
> > 
> > Furthermore, we'd already have established that the client and the
> > knfsd instance are running in the same kernel space on the same
> > hardware (whether real or virtualised). There is no chance for a bad
> > actor to compromise the one without also compromising the other.
> > However, let's assume that somehow is possible: How does throwing in an
> > on-the-wire protocol that is initiated by the one and interpreted by
> > the other going to help, given that both have access to the exact same
> > RPCSEC_GSS/TLS session and shared secret information via shared kernel
> > memory?
> > 
> > So again, what problem are you trying to fix?
> 
> Conversely:  what exactly is this FAQ entry trying to argue against?
>
> My current immediate goal is for the FAQ to be useful.  It mostly is,
> but this one question/answer isn't clear to me.

The current answer to question 6 isn't meant to be dealing in
absolutes, nor does it have to (but I agree that "negating any
benefit" should be softened given we don't _know_ how it'd play out
without implementing open-over-the-wire entirely to benchmark).

We just need to give context for what motivated the current
implementation: network protocol avoidance where possible.

Given everything, do you have a suggestion for how to improve the
answer to question 6?  Happy to revise it however you like.

Here is the incremental patch I just came up with. Any better?

diff --git a/Documentation/filesystems/nfs/localio.rst b/Documentation/filesystems/nfs/localio.rst
index 4b6d63246479..5d652f637a97 100644
--- a/Documentation/filesystems/nfs/localio.rst
+++ b/Documentation/filesystems/nfs/localio.rst
@@ -120,12 +120,13 @@ FAQ
    using RPC, beneficial?  Is the benefit pNFS specific?
 
    Avoiding the use of XDR and RPC for file opens is beneficial to
-   performance regardless of whether pNFS is used. However adding a
-   requirement to go over the wire to do an open and/or close ends up
-   negating any benefit of avoiding the wire for doing the I/O itself
-   when we’re dealing with small files. There is no benefit to replacing
-   the READ or WRITE with a new open and/or close operation that still
-   needs to go over the wire.
+   performance regardless of whether pNFS is used. Especially when
+   dealing with small files its best to avoid going over the wire
+   whenever possible, otherwise it could reduce or even negate the
+   benefits of avoiding the wire for doing the small file I/O itself.
+   Given LOCALIO's requirements the current approach of having the
+   client perform a server-side file open, without using RPC, is ideal.
+   If in the future requirements change then we can adapt accordingly.
 
 7. Why is LOCALIO only supported with UNIX Authentication (AUTH_UNIX)?
 

