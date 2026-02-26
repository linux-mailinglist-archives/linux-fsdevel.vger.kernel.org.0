Return-Path: <linux-fsdevel+bounces-78500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cK0cDFBZoGl2igQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:31:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 782341A7942
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E350130995C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA83136CDE4;
	Thu, 26 Feb 2026 14:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6sO2eJx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4715133A9F7;
	Thu, 26 Feb 2026 14:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772114955; cv=none; b=ZWKpKF89ln6VilsltSPQA+nTQD3erhAh+k/z1CHp3bVCidMlEgjvo07ogBqIYELJlhLUrGGyLOVzPoXFfPeIoKOGtDr3pgz9zaPaBCnjcHlCCWe2qyGLoHGQ15Wp7sQu7aJNLBekkwYqsh4mlHHEAd/jFg/VHqwpZF3anw+rPmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772114955; c=relaxed/simple;
	bh=8WDXKaLHom5c3E/DwCunlAjOlHZNSGTUJkRY5uIDLx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbBeudcFUGzQ3mUbRC+G+Nb6Sxsd7dH3Rd24xINUQOZ1LKVYmk3jjzsUHDAcq+VG3m9j0LiweQKbrI1GXyugaO25nfp6jRca10nIDd78YVw6AUSOJrdD1IE0NUM25jByrZaGKnsyXsHXnjIzZtQjYnCmdZEkfQL2XqbFl4uU3bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6sO2eJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B342AC116C6;
	Thu, 26 Feb 2026 14:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772114954;
	bh=8WDXKaLHom5c3E/DwCunlAjOlHZNSGTUJkRY5uIDLx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W6sO2eJxeOLvlQ9mpL1mZ9pdNYgf/x6X5Vk3jytPpF4EeK4GOxcnfskcBjkXwDBBV
	 2qq5q2kU1XKnmM99cg64n+IdHCe8KdA2GjbHFihYphUV1uUGBG91N+11GIsz5QtpxO
	 0NfvN2cBrEpXNTvuy1xGq2lBTE/GPrPkgLdRTOLnEwCvFpV6DltN0qx3CTZ+6BQNW0
	 bfqqlUuRoRHyRAybpbDIk8nqS68HJ4O1ryrNqw3k/JN6CCEIo6TVj99sko3SfM1NS7
	 ZTJSJllW0WTGH/QTTJFxoIZiGN4fcxYT5Wq7wKdCUt1+oYza8TsdDQ9MqHgVaZ/wQ7
	 71YDJv0xlj/Ug==
Date: Thu, 26 Feb 2026 09:09:13 -0500
From: Sasha Levin <sashal@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, patches@lists.linux.dev,
	stable@vger.kernel.org, Jakub Acs <acsjakub@amazon.de>,
	Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.19-5.15] fsnotify: Shutdown fsnotify before
 destroying sb's dcache
Message-ID: <aaBUCU50P-GYMnne@laps>
References: <20260214212452.782265-1-sashal@kernel.org>
 <20260214212452.782265-85-sashal@kernel.org>
 <CAOQ4uxgKwp2FSAUwqhHN-kTBcy0DsFmLstGUY+zJWppOzTAmHA@mail.gmail.com>
 <z6nyopsvzubwxowiqxdg2yt5v6yu4i3uzlflvryjwuk2su7z4m@35ikyzqbxb46>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <z6nyopsvzubwxowiqxdg2yt5v6yu4i3uzlflvryjwuk2su7z4m@35ikyzqbxb46>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.linux.dev,vger.kernel.org,amazon.de,kernel.org,zeniv.linux.org.uk];
	TAGGED_FROM(0.00)[bounces-78500-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 782341A7942
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 11:00:42AM +0100, Jan Kara wrote:
>On Sun 15-02-26 09:11:30, Amir Goldstein wrote:
>> On Sat, Feb 14, 2026 at 11:27 PM Sasha Levin <sashal@kernel.org> wrote:
>> >
>> > From: Jan Kara <jack@suse.cz>
>> >
>> > [ Upstream commit 74bd284537b3447c651588101c32a203e4fe1a32 ]
>> >
>> > Currently fsnotify_sb_delete() was called after we have evicted
>> > superblock's dcache and inode cache. This was done mainly so that we
>> > iterate as few inodes as possible when removing inode marks. However, as
>> > Jakub reported, this is problematic because for some filesystems
>> > encoding of file handles uses sb->s_root which gets cleared as part of
>> > dcache eviction. And either delayed fsnotify events or reading fdinfo
>> > for fsnotify group with marks on fs being unmounted may trigger encoding
>> > of file handles during unmount.
>>
>> In retrospect, the text "Now that we iterate inode connectors..."
>> would have helped LLM (as well as human) patch backports understand
>> that this is NOT a standalone patch.
>
>Good point :)
>
>> Sasha,
>>
>> I am very for backporting this fix, but need to backport the series
>> https://lore.kernel.org/linux-fsdevel/20260121135513.12008-1-jack@suse.cz/
>
>Yes. Without commits 94bd01253c3d5 ("fsnotify: Track inode connectors for a
>superblock") and a05fc7edd988c ("fsnotify: Use connector list for
>destroying inode marks") the reordering alone can cause large latencies
>during filesystem unmount.

Looks like going even to 6.18 requires a bunch of dependencies, so a backport
would be appreciated :)

-- 
Thanks,
Sasha

