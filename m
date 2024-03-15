Return-Path: <linux-fsdevel+bounces-14438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EDB87CD2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 13:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC891C21935
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 12:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437D61C2A0;
	Fri, 15 Mar 2024 12:22:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BDE1C680;
	Fri, 15 Mar 2024 12:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710505355; cv=none; b=lbBQLyERS2jQElU70NPigHcPgrk4kGGkKFYhYtBdfOCfM+pf64c2S6O16rqzv0Vthdir557uOyu+CBeqiTvWkx6/WAsx46RqXowfYBWQ23L+IQ+vn/lMV66cEAP+b2R87gtrYV6zamLuTBJsf1vm1luhzSJORQca5tYFhRrZ/IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710505355; c=relaxed/simple;
	bh=HUfDdYdUi6gjRNj8lEKfG2Jv49xYpw5gcot6qzNYAyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8ZbhKM8TskxIF3THU2QVjUkfRWqWMSdQ6nciJ39GUXzLLVwTmdIBWQuwQDaidSpvt/OeI5EPBeEuHCxKpRLNe3n0lF7RM0kvp/FI/UvLF0cVUql49S57nFuzLP1yl1hq6Mh3snfKfCDcQlzOC5kNXY0yJ/qrFfdubeM0kY03sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 62B3121DCE;
	Fri, 15 Mar 2024 12:22:32 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5644313460;
	Fri, 15 Mar 2024 12:22:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ueisFIg99GVxFAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 15 Mar 2024 12:22:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 026C0A07D9; Fri, 15 Mar 2024 13:22:31 +0100 (CET)
Date: Fri, 15 Mar 2024 13:22:31 +0100
From: Jan Kara <jack@suse.cz>
To: Enzo Matsumiya <ematsumiya@suse.de>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-cifs@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM ATTEND] Over-the-wire data compression
Message-ID: <20240315122231.ktyx3ebd5mulo5or@quack3>
References: <rnx34bfst5gyomkwooq2pvkxsjw5mrx5vxszhz7m4hy54yuma5@huwvwzgvrrru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rnx34bfst5gyomkwooq2pvkxsjw5mrx5vxszhz7m4hy54yuma5@huwvwzgvrrru>
X-Spam-Score: -4.00
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Queue-Id: 62B3121DCE

Hello Enzo,

it is good to also CC appropriate public mailing lists so that other
attendees can discuss about your proposal. Added some I found relevant.

								Honza

On Thu 14-03-24 15:14:49, Enzo Matsumiya wrote:
> Hello,
> 
> Having implemented data compression for SMB2 messages in cifs.ko, I'd
> like to attend LSF/MM to discuss:
> 
> - implementation decisions, both in the protocol level and in the
>   compression algorithms; e.g. performance improvements, what could,
>   if possible/wanted, turn into a lib/ module, etc
> 
> - compression algorithms in general; talk about algorithms to determine
>   if/how compressible a blob of data is
>     * several such algorithms already exist and are used by on-disk
>       compression tools, but for over-the-wire compression maybe the
>       fastest one with good (not great nor best) predictability
>       could work?
> 
> - overlapping modules/areas that have the need/desire to compress
>   transmitting data and their status quo in the topic; difficulties
>   where I could help and/or achievements that I could learn from
> 
> 
> Cheers,
> 
> Enzo
> _______________________________________________
> Lsf-pc mailing list
> Lsf-pc@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

