Return-Path: <linux-fsdevel+bounces-77813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLbrGTammGl5KgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 19:21:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D28B16A02C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 19:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C90B3008985
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 18:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5A5366553;
	Fri, 20 Feb 2026 18:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4eEyLm9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2DD301002
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771611697; cv=none; b=qHVJK3eLX/NQZUCh/mWdUzY13CRNi0kkK4SvlZhtdi2BS0vsVfWR2v7ipr3wPyP8S4dKD8D/F9Kz/Wq0lVRoEiiRNNfKQ484jTS4LFIigFy+RhKBS+tFYKHv1BdQKaJn2TY5tggzwG83/YXnRez2Ojj92NIdsUsno0GY6FbekTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771611697; c=relaxed/simple;
	bh=3+4VEzQbuRsWa2hjECT4rwyg5W11G7wHh2/Q6b9BRuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jp5YpJNEmEfe+U/OIOKJ/maDl4n6NmhS6yq+lhqY47X2A9wkvb0GcfACu/kO2/JyFnQIZ0ziqtnBqbQxx34jM+YSzREJA1Oitxwds2+BszFJEbwQXXydSHYv9sOreVuhLHQcSv9rn4+P2HXhgSWMl7TfTEoMjX/O6Vb6qQT5FZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4eEyLm9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63315C116C6;
	Fri, 20 Feb 2026 18:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771611697;
	bh=3+4VEzQbuRsWa2hjECT4rwyg5W11G7wHh2/Q6b9BRuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r4eEyLm9ZTaJZ/Zx0Fdc2VsKF0qr92Qq0KdD0wNylk5YSbFlHmBKC+gwGixdDHj+E
	 mO1hc3BFM6t2jSWiykOooqpfQuqeyew/lr7nFItZozu6pDy2O3smfU+7wb/B6hRrqx
	 0Myuw/xJxPL57qyW8FangascxOSfz3kSJVbuBGkjTs+HDyxO40TcARAAcpmc5ZGZJR
	 ZNsuklt8Eq140vO8IKzSSuzquwMzu6XVPaFwL2hDBmpZjMFHHHsf4yCMdAZTjxyaSG
	 fhk0QiLV3E1eRoquEZ6C6ouB00QZ4wsTWSu87B58OipQ+w2imq1HKobDc2uL84RuUl
	 f5T9Mzs2OiCFA==
Date: Fri, 20 Feb 2026 10:21:36 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] fs: remove fsparam_path / fs_param_is_path
Message-ID: <20260220182136.GS6467@frogsfrogsfrogs>
References: <20260219065014.3550402-1-hch@lst.de>
 <20260219065014.3550402-4-hch@lst.de>
 <20260219160428.GQ6467@frogsfrogsfrogs>
 <20260220152402.GB14300@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220152402.GB14300@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77813-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D28B16A02C
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 04:24:02PM +0100, Christoph Hellwig wrote:
> On Thu, Feb 19, 2026 at 08:04:28AM -0800, Darrick J. Wong wrote:
> > > diff --git a/Documentation/filesystems/mount_api.rst b/Documentation/filesystems/mount_api.rst
> > > index b4a0f23914a6..e8b94357b4df 100644
> > > --- a/Documentation/filesystems/mount_api.rst
> > > +++ b/Documentation/filesystems/mount_api.rst
> > > @@ -648,7 +648,6 @@ The members are as follows:
> > >  	fs_param_is_enum	Enum value name 	result->uint_32
> > >  	fs_param_is_string	Arbitrary string	param->string
> > >  	fs_param_is_blockdev	Blockdev path		* Needs lookup
> > 
> > Unrelated: should xfs be using fsparam_bdev for its logdev/rtdev mount
> > options?
> 
> Not sure what the point is in having separate string helpers with meaning,
> but maybe I'm missing something/

I'm not sure either -- it'd be one thing if the fsconfig code could
supply us with an open struct file to an O_EXCL bdev, but looking at the
sole user ext4, all it does is sample i_rdev and pass it to
bdev_file_open_by_dev.

> > Or, more crazily, should it grow logfd/rtfd options that use fsparam_fd?
> 
> What would the use case be for that?

I've no idea, I guess if we had mount helper magic then it would be
useful.

--D

