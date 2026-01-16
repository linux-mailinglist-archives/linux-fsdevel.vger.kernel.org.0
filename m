Return-Path: <linux-fsdevel+bounces-74077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8B5D2EC54
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 10:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B9EE3038026
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 09:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1493570B1;
	Fri, 16 Jan 2026 09:30:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7625E356A1F;
	Fri, 16 Jan 2026 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768555831; cv=none; b=EHZr86V0VyLjjazsupgPF29rtHgqQH05ezJLpn8exByBwYs6A1eg8yNXSDHEF93stC0GyU/VEklgFXfWOG/vt1+nNlxOF8lMfEEVqyuEyJ9K6ovzaGWjaripBmySj1viAVbXx7AYc6MJzvqj7rQTuYRhg8xXox5WmXH4OQxfwOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768555831; c=relaxed/simple;
	bh=y15SnZZf0v+mN4riBkxA6qBsiJe1NeIfGoDwSriI2N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gchjSTOeHJMrGVlYKyPPKSGyZqPxouTccSQd+f+wivgrKiS31Rz1pX7ZZrq52JUMU+tSFFLbjxTveQ2EEvTG563T10D5cvF7MhyQE81/FaAf21yI0x7KU/tLbeVlCPUN7axienBh+Bo4ELGXXvbJG0+vUQqsfGym4StA+I0oqDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DD756227A8E; Fri, 16 Jan 2026 10:30:26 +0100 (CET)
Date: Fri, 16 Jan 2026 10:30:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@lst.de, tytso@mit.edu,
	willy@infradead.org, jack@suse.cz, djwong@kernel.org,
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com,
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org,
	ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com,
	gunho.lee@lge.com
Subject: Re: [PATCH v5 13/14] ntfs: add Kconfig and Makefile
Message-ID: <20260116093025.GD21396@lst.de>
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260111140345.3866-14-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111140345.3866-14-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +config NTFS_FS_POSIX_ACL
> +	bool "NTFS POSIX Access Control Lists"
> +	depends on NTFS_FS
> +	select FS_POSIX_ACL
> +	help
> +	  POSIX Access Control Lists (ACLs) support additional access rights
> +	  for users and groups beyond the standard owner/group/world scheme,
> +	  and this option selects support for ACLs specifically for ntfs
> +	  filesystems.
> +	  NOTE: this is linux only feature. Windows will ignore these ACLs.
> +
> +	  If you don't know what Access Control Lists are, say N.

This looks like a new feature over the old driver.  What is the
use case for it?

> @@ -0,0 +1,13 @@
> +# Makefile for the ntfs filesystem support.
> +#

I'd drop this, it's pretty obvious :)


