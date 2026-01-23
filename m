Return-Path: <linux-fsdevel+bounces-75254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG7KAvU6c2kztgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 10:10:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 787C773076
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 10:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A44E303265F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 09:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC06339B34;
	Fri, 23 Jan 2026 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sb2WZNO6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC1E263C8F;
	Fri, 23 Jan 2026 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769159138; cv=none; b=EqrL+L9vd01SZKlSD2YGBhn2i9qQ4qq9u+BtYo8KW3R5Jv7R7KgFJOnA/m+xArKyELDJc4BcN1ss05ZoF1VeYFzAjRKiiCpGuZkd1BbEnD+poKdvfWzHBHV3NEu9g4j4AEbkexn6YCQ0F9L6Il9qAomudOm3NiiFM1G+KLHPMiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769159138; c=relaxed/simple;
	bh=HWmmfjy2DzbD3cbOs9EbV/XFX+tdLVLHpPdE3Bb5zDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k0o/bPp87ebT5ocD40ESB0LB9Re1o5pYsi0zH8zRXYl+F2MjwLiU150frkxdRQeEISStSbXs566TpCtZPgJ4r0zn88p6hGI0tJjaCzEcsAgI1gEt/V6G6OOzicwcmUcjw6GArAjqlcAv1TZ2fUm1em5/xgmM+s3HkhmuUpFYWac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sb2WZNO6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641D4C4CEF1;
	Fri, 23 Jan 2026 09:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769159138;
	bh=HWmmfjy2DzbD3cbOs9EbV/XFX+tdLVLHpPdE3Bb5zDk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sb2WZNO64IReQSQ/jhK6tSkgC05qEkiUwYej70r8xi0FgNx/MHNcd82rugqxdUA3Z
	 EmmHySKqezOxI0VUjmxUKu5h7Z2Vb5VPAwYqmPlrmo1Sb/Ej6aBYV07OGA3/3rNmN6
	 RgiuMbVp3CDPP+WbtAqKDnAFH1lSy1PWWnuive7v64IZC5KxaAZqbOmqzx0QjfKeHn
	 52X1cAWxjRpxr0tYRkDgKsd3p9/SkdfpYQnRPB1drT8nEuyZ3o4mJbFqhO2RcUjpQO
	 HechAB2wIn2CijzPIU6Q1EjhbD0T52Qf0DdiswChGJ2IlvdH6X+fBOWeunJn39LRKQ
	 VWz87guAR33tQ==
Message-ID: <b4055f35-9730-456a-b028-84423490cd5f@kernel.org>
Date: Fri, 23 Jan 2026 20:05:34 +1100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] iomap: add a flag to bounce buffer direct I/O
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Qu Wenruo <wqu@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20260119074425.4005867-1-hch@lst.de>
 <20260119074425.4005867-14-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260119074425.4005867-14-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75254-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 787C773076
X-Rspamd-Action: no action

On 2026/01/19 18:44, Christoph Hellwig wrote:
> Add a new flag that request bounce buffering for direct I/O.  This is
> needed to provide the stable pages requirement requested by devices
> that need to calculate checksums or parity over the data and allows
> file systems to properly work with things like T10 protection
> information.  The implementation just calls out to the new bio bounce
> buffering helpers to allocate a bounce buffer, which is used for
> I/O and to copy to/from it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

