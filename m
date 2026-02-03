Return-Path: <linux-fsdevel+bounces-76125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MutOFSKgWnuGwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 06:40:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1CCD4C6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 06:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F3F03046524
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 05:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69A6366828;
	Tue,  3 Feb 2026 05:38:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F0C3570CC;
	Tue,  3 Feb 2026 05:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770097091; cv=none; b=MycMWEGcsn5B2S1RSbS3vF09uoNLl9VsS4u3h8XnjkzVdh9pQqGTGix9lJRTT2EXViVEH+ERz5WzskZnS2iAlx41tBavDovklZHn3cZ5vn7klRG1t2ZtCfE/oSobNOeoyZBTNyCm+0aeK/Pf9S/RlpEFZxLrq62f6KSSBbxC+7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770097091; c=relaxed/simple;
	bh=NKzpR3GFmqOh+Kv6INipr2JnSV+K2dFiZWMcX5Gc6gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJg69CAFleXR4o5KFAphZtU2roKPTrk/ie+lAli6uIRgR/SuCCLFnN7YpMz/NEwlKfhV1U++Fj3LLsDNComYMq3tle00ZnQ5H9Aq0g/H9bcQZYVlEz3hlD5kw8oKjeoBA8vjQC3Ej1UpPKEN6Ah+AzM9xxpU/rgynF4yR9HWFxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 960D668AFE; Tue,  3 Feb 2026 06:38:05 +0100 (CET)
Date: Tue, 3 Feb 2026 06:38:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, hch@lst.de, tytso@mit.edu, willy@infradead.org,
	jack@suse.cz, josef@toxicpanda.com, sandeen@sandeen.net,
	rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com,
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name,
	amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Subject: Re: [PATCH v6 03/16] fs: add generic FS_IOC_SHUTDOWN definitions
Message-ID: <20260203053805.GA16249@lst.de>
References: <20260202220202.10907-1-linkinjeon@kernel.org> <20260202220202.10907-4-linkinjeon@kernel.org> <20260202223657.GB1535390@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202223657.GB1535390@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76125-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,lst.de,mit.edu,infradead.org,suse.cz,toxicpanda.com,sandeen.net,suse.com,brown.name,gmail.com,vger.kernel.org,lge.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid,lst.de:email]
X-Rspamd-Queue-Id: 6E1CCD4C6D
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 02:36:57PM -0800, Darrick J. Wong wrote:
> Christian: any chance we could get this api cleanup queued for 7.0 even
> though we're past -rc8?

I assume the new ntrfs code is still aimed at 7.0, so it would be best
to just merge it with that.

Reviewed-by: Christoph Hellwig <hch@lst.de>


