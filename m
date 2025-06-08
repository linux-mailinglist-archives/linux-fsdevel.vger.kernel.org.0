Return-Path: <linux-fsdevel+bounces-50940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA27FAD1453
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 22:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABF716797C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 20:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8521C1FF1D1;
	Sun,  8 Jun 2025 20:53:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FAC19D880
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Jun 2025 20:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749415982; cv=none; b=dYnYW8ThVtqbRmS9ss9INNRCywN5xw211MYrrauVR3pAHDE7tVXz9xUVJRYdG27KLXgp9zQWwHRNww69a3hnhNA1eLumhYAZgRy6oev4fcOCrKWD97BArIEkp2D+SvI+NeWSgRmP1hl//zr5yelVNUuh5dOlrSNPh9pLBct+KNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749415982; c=relaxed/simple;
	bh=l8h6ntuarC4i9078wFjskTdtbTyvaj8gqJ2oA6CRIRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4CaBCE9e85s6K8TYyT+mLk/ulbgMZVrYsqqsEJJaBwAHPsFYy+0vQPEUqoDBVZbHpF9hu+dEcrpn3rZcTTQL7tXA/QglFgIL+IuKYF3AG7cOnpKTZtAuNtlb94Dn+cWor1XdqNPcm5JVparbZu3WwDfmunELSTNqXCM5eviZgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([191.96.150.126])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 558KqkSL030613
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 8 Jun 2025 16:52:54 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id DE770346B91; Sun, 08 Jun 2025 16:52:44 -0400 (EDT)
Date: Sun, 8 Jun 2025 20:52:44 +0000
From: "Theodore Ts'o" <tytso@mit.edu>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Cedric Blancher <cedric.blancher@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: LInux NFSv4.1 client and server- case insensitive filesystems
 supported?
Message-ID: <20250608205244.GD784455@mit.edu>
References: <CALXu0Ufzm66Ors3aBBrua0-8bvwqo-=RCmiK1yof9mMUxyEmCQ@mail.gmail.com>
 <CALXu0Ufgv7RK7gDOK53MJsD+7x4f0+BYYwo2xNXidigxLDeuMg@mail.gmail.com>
 <44250631-2b70-4ce8-b513-a632e70704ed@oracle.com>
 <20250607223951.GB784455@mit.edu>
 <643072ba-3ee6-4e5b-832a-aac88a06e51d@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <643072ba-3ee6-4e5b-832a-aac88a06e51d@oracle.com>

On Sun, Jun 08, 2025 at 12:29:30PM -0400, Chuck Lever wrote:
> 
> For some reason I thought case-insensitivity support was merged more
> recently than that. I recall it first appearing as a session at LSF in
> Park City, but maybe that one was in 2018.

commit b886ee3e778ec2ad43e276fd378ab492cf6819b7
Author: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Date:   Thu Apr 25 14:12:08 2019 -0400

    ext4: Support case-insensitive file name lookups

> nfs(5) describes the lookupcache= mount option. It controls how the
> Linux NFS client caches positive and negative lookup results.

Has anyone just tried it?  It might just work.  To create a
case-folded directory:

# mke2fs -Fq -t ext4 -O casefold /dev/vdc
# mount /dev/vdc /vdc
# mkdir /vdc/casefold
# chattr +F /vdc/casefold
# cp /etc/issue /vdc/casefold/MaDNeSS
# cat /vdc/casefold/madness

Then export the directory and mount it via NFS, and let us know how it
goes.  I'm currently on a cruise ship so it's a bit harder for me to
do the experiment myself.  :-)

						- Ted

