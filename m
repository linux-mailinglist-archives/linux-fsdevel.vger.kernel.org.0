Return-Path: <linux-fsdevel+bounces-76336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8H3zB4R+g2mHnwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 18:14:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DFAEAEA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 18:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BF940305E0C0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 17:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF503491D6;
	Wed,  4 Feb 2026 17:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="XSvW+/Tm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C533833B976
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Feb 2026 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770224745; cv=none; b=R40ZJmjLxWx4rB6iVpAE4JjyH9FQToitTG2IcTYPPFvzUIObSkKNo37dc4ICXhFFm/cy3A/SaPDipAsVdGqS8d/EMfwgmS2nqM8rDLnluatsVxrYqnJXq0b2EkhnlPhjKijK3eH7VQVfSY3gSGmx1akqlTEvSPaOHRgS5Gthxlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770224745; c=relaxed/simple;
	bh=xFQM54uGaR/iYy8YOmQaUKV73kfJeQv/WoyPYNqwXBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0mFmSK78xVFWHi2zIOiYA7BuLbVelEPh7gg5QgHVfszZb7C42bD7EUZt+ARluYzOscK264KwQKrPJ9PhRUTT4KvZb+ABNLAIro8OZHvUJGM/Z+UfHwSiRbhgqocZYppyciE29eyc99YyuisbiYwwyfKBDI6uuByUVeTwH+DsZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=XSvW+/Tm; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-119-77.bstnma.fios.verizon.net [173.48.119.77])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 614H5BIR023448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Feb 2026 12:05:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1770224714; bh=FJ3l4j3asswhM7XjwUVXUk5e7OhriV8G+Oiht6GM9xY=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=XSvW+/TmM5z/lRQHdkTU5AkYvflunoywwW4VEjZ7mOj2d6jBDXJyaPqZviQG1xUD5
	 ALqW4v85qBHo2o1ncEHVqA5uTz6WDkJ/7yIfm1oE4HpgajkRn7UkHDoZWE9mEpUCzK
	 7IwsBd+t2EUJUORqF2lWOBSqWs6lT8Wl53Npn5M/WC4q1yRR5EfmcGcS9zBa722dN4
	 ZQQN4mF5lynJecNEvw4Pi8HGXN58BaH0fQVBlQ9/aawjZGzzt577rE3WIi6tHt6fGI
	 kI9R79SK2uXBq9MvH4cyFhBt1Ul8fHUxn8qttJEyVM6V1CbButT2iWP6g2vIjdp06z
	 sA2qZlsJvKQkw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 6119A5738D5B; Wed,  4 Feb 2026 12:04:11 -0500 (EST)
Date: Wed, 4 Feb 2026 12:04:11 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Christian Brauner <brauner@kernel.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Orphan filesystems after mount namespace destruction and tmpfs
 "leak"
Message-ID: <20260204170411.GC31420@macsyma.lan>
References: <aYDjHJstnz2V-ZZg@thinkstation>
 <20260203-bestanden-ballhaus-941e4c365701@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203-bestanden-ballhaus-941e4c365701@brauner>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-76336-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[mit.edu:+]
X-Rspamd-Queue-Id: 30DFAEAEA2
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 03:58:52PM +0100, Christian Brauner wrote:
> I don't believe we need to do anything here unless you want some tmpfs
> specific black magic where you can issue a shutdown ioctl on tmpfs that
> magically frees memory. And I'd still expect that this would fsck
> userspace over that doesn't expect this behavior.

I think if we were going to do anything like this, adding support to
FS_IOC_SHUTDOWN to tmpfs is the only way we could go.  Yeah, it will
fsck over userspace that's not expecting it, but normally, if you're
tearing down a file system, whether it's a read-only iSCSI device that
provides a software package that needs to go away because the iSCSI
target has gone away, or zapping a tmpfs file system, killing the
userspace which depends on it with extreme perjudice *is* actually the
right thing.  We use FS_IOC_SHUTDWN on an ext4 file system that is
being served via iSCSI, and when that happens, killing the container
and the userspace processes running in it as quickly as possble
without harming other containers is the goal.

It might make fsck over userspace, granted, but so does "kill -9".  :-)

   	      	   		   	    	   - Ted

