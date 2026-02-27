Return-Path: <linux-fsdevel+bounces-78730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIP+IQ25oWkYwAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:32:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E03351B9D5F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FB2831A8503
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25D142DFE8;
	Fri, 27 Feb 2026 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XA/QaRea"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71769220F2D
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205577; cv=none; b=Jbg2Km6bX3c0gDRlFa/8EcOAC3+qB5xbnTZKsUTrdUB2l61rj1Ail9giTFXGZjO0lH5XTCYrFlU5z92In26nVJ42Y8LSvxZgWH7YyvvDOem7h9OYP/anQfxZxEHHkaUju7LeCnUxukn7Tk/54gPyKVnQdfPPURkn+fJisj8zv/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205577; c=relaxed/simple;
	bh=04FZaqkVEhg84Q1umwpvGK79aJfyhgFm3Bcy6v5nt7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujvC+kAY9QAWLutCCfe1aJfaPU5ZNMqNDfQDfj3A8YyqmktzgF/QJOmLiSnsgqJNviYXWZ7u5WRPsj9ZmT0GWlPBpT4H/aAOTQiXZiYxbTDGgRR4oTdsEfbNqEziPTX3Yi++aQ/UkwjpEkG7awwciAJ5vvqgxRUTuQ8ivJB9GrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XA/QaRea; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M+rMQQjpfREnEirMRx1pwCQH+CtMm8K++5IcPtNx06M=; b=XA/QaReaOg1VPXHDZKNFKEBUJP
	ZiNv7OegJsQ3TbeBPvQyNwPkoLvLe7gnDkIowV/7lJk5qVYQt5Z9D7hDejcqxvyKPcgmvclO3UPGs
	qVcGToKYpVUbv70l/HXSxaADc3kpQe3maGdQ/CE3frgHwdI4dY3xLFFqmNzZLtxPUTtgt2NlvKr7J
	ibdkQax4Tj3oEEZW6rAkR2zG1ysYuXmIuXizW5P0na6yJ+Dc1PcRs3fa684p0GKBXT2IvaELBizHL
	p6zGA/WFowpBVsshQUYKz7h7+uSvv95B1+YRZHrQzSVxaps4WPufei8MoWz3vS7a07C6DRIw/sA5G
	g7YGjRJg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vvzfP-00000008Meb-3k0S;
	Fri, 27 Feb 2026 15:22:12 +0000
Date: Fri, 27 Feb 2026 15:22:11 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: "J. R. Okajima" <hooanon05g@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: v7.0-rc1, name_to_handle_at(..., AT_EMPTY_PATH)
Message-ID: <20260227152211.GB3836593@ZenIV>
References: <14544.1772189098@jrotkm2>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14544.1772189098@jrotkm2>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-78730-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.org.uk:dkim]
X-Rspamd-Queue-Id: E03351B9D5F
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 07:44:58PM +0900, J. R. Okajima wrote:
> Hello Al Viro,
> 
> By the commit in v7.0-rc1,
> 	154ef7dce6a4d 2026-01-16 name_to_handle_at(): use CLASS(filename_uflags)
> name_to_handle_at(2) stopped handling AT_EMPTY_PATH, and an application
> which issues
> 	name_to_handle_at(fd, "", handle, &mnt_id, AT_EMPTY_PATH);
> started failing.
> 
> It is due to the commit dropped setting LOOKUP_EMPTY to lookup_flags in
> name_to_handle_at(2).

Huh?
	CLASS(filename_uflags, filename)(name, flag);
*does* accept empty path if flag & AT_EMPTY_PATH is non-zero.

So if you are really observing such failures, something else must've gone
wrong.  Details, please.

This
struct filename *getname_uflags(const char __user *filename, int uflags)
{
        int flags = (uflags & AT_EMPTY_PATH) ? LOOKUP_EMPTY : 0;

	return getname_flags(filename, flags);
}
is where AT_EMPTY_PATH is handled; could you check the arguuments it's getting
in your reproducer and argument passed to getname_flags()?

