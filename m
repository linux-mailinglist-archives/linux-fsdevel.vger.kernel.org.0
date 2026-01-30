Return-Path: <linux-fsdevel+bounces-75960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNPXKE38fGnLPgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 19:45:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8BEBDEDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 19:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A29FF300C0EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 18:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E19E3816F0;
	Fri, 30 Jan 2026 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b/hp4WsF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC882D2390;
	Fri, 30 Jan 2026 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769798727; cv=none; b=m+GpZ8/bYSb5muM7qcIONNJHs1lXO6ivpYJ6OYUTEvaQw8420+3L++ywjrNKn0uYTvcJYGHrKIG6mt+Y1dmuZHrqDlfgaQEzYMvftMPjDQzjTtCwzdUueJUZtb/50eEupOFYteAcHY7pmUJidq2gYaJonId758Y6zfU3gutUnSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769798727; c=relaxed/simple;
	bh=GV1EDzSVnR14uH0ML62kANZdik6ElsHLicNglYyVUE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gk0bspX4ZUVqKIgOPCeZr+wPMkltw7UlI2TQ5XGayDnP8lNleKfvyNeNyw6sQ4uz1ZuJ8Ic2thEqJ1ACgj7qjwZk0AIL7BP9NwcyxlkmqhqRTZCds0f1fAFYpTF34L5dy0kfjCIhXUvZR8HdY6XQ8saG7YLFUCHzDx93OuawWqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b/hp4WsF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=OUUR4v1IqP1ZGcGCcmEMkan62AxQPG+ILCLFSj4KfZs=; b=b/hp4WsFoBHaxdPIVr4tMGdI77
	fnEo2nNJTw40VH/mtv4ccBLGybaVqvKiPJ8f36La/lLLP6m5qO9RfT6BZstx4Wy+CqLpYnRtEFQzR
	AOid2Vd9X0K7lyz8Vxn7sKl9CWl45hi6eXb5b1hv8hnTh8q9yEv1v2PeQmuFh8A+qx2hxBldwXdb/
	S430MkWcTCpL3FIsIjb+a4QPeinZD+H9KqjU53Do0Vs0Jn7F80Bb9COaLDLPcnbIHGHqZ6NbkKK/5
	d4TmvdQnbO62OQRNKcomu2x/H35rr46JGBN4WNyX2Vc0pgCM7zowDeS81/ZIq/mk3ikjRXjp7NodW
	AyCBt5Pw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vltUZ-00000001r5K-31E3;
	Fri, 30 Jan 2026 18:45:15 +0000
Message-ID: <5917d82f-742e-4c19-993e-182551153c6d@infradead.org>
Date: Fri, 30 Jan 2026 10:45:14 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: filesystems: ensure proc pid substitutable is
 complete
To: =?UTF-8?Q?Thomas_B=C3=B6hler?= <witcher@wiredspace.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260130-ksm_stat-v1-1-a6aa0da78de6@wiredspace.de>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260130-ksm_stat-v1-1-a6aa0da78de6@wiredspace.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75960-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,seibold.net:email,wiredspace.de:email]
X-Rspamd-Queue-Id: 3C8BEBDEDD
X-Rspamd-Action: no action



On 1/30/26 7:25 AM, Thomas Böhler wrote:
> The entry in proc.rst for 3.14 is missing the closing ">" of the "pid"
> field for the ksm_stat file. Add this for both the table of contents and
> the actual header for the "ksm_stat" file.
> 
> Signed-off-by: Thomas Böhler <witcher@wiredspace.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/filesystems/proc.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 8256e857e2d7..346816b02bac 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -48,7 +48,7 @@ fixes/update part 1.1  Stefani Seibold <stefani@seibold.net>    June 9 2009
>    3.11	/proc/<pid>/patch_state - Livepatch patch operation state
>    3.12	/proc/<pid>/arch_status - Task architecture specific information
>    3.13  /proc/<pid>/fd - List of symlinks to open files
> -  3.14  /proc/<pid/ksm_stat - Information about the process's ksm status.
> +  3.14  /proc/<pid>/ksm_stat - Information about the process's ksm status.
>  
>    4	Configuring procfs
>    4.1	Mount options
> @@ -2289,7 +2289,7 @@ The number of open files for the process is stored in 'size' member
>  of stat() output for /proc/<pid>/fd for fast access.
>  -------------------------------------------------------
>  
> -3.14 /proc/<pid/ksm_stat - Information about the process's ksm status
> +3.14 /proc/<pid>/ksm_stat - Information about the process's ksm status
>  ---------------------------------------------------------------------
>  When CONFIG_KSM is enabled, each process has this file which displays
>  the information of ksm merging status.
> 
> ---
> base-commit: 6b8edfcd661b569f077cc1ea1f7463ec38547779
> change-id: 20260130-ksm_stat-4d14366630ea
> 
> Best regards,

-- 
~Randy

