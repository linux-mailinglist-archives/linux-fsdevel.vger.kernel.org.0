Return-Path: <linux-fsdevel+bounces-77236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLIIFgIYkWl8fAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 01:49:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE4C13DD56
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 01:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7EDA301A901
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 00:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F187B8635D;
	Sun, 15 Feb 2026 00:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="mTMg/ISv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A6E1BF33
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Feb 2026 00:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771116541; cv=none; b=cSC4XjVaIhcDAeSpfXIXdqbOKFEEWruX6JtvyvGld7RR7qJQh983+RTFyIRNv+4oVPrtgKOVuKT4OXWXccajltFx1YvAzNQN+D4oriFmnT+iPKjA9+/uUYEnkUaASRLqHl/gk1o/XjC69aLLrS9XEOI9jRBvDT7BdseQelWacQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771116541; c=relaxed/simple;
	bh=gC/s7W4qjezTNs4gyxxqyqq3OJUnQ48o9UOqkIwhJfA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=BHAjoOXlO2dCGZs3gbdgSpNTiPtGK6Cd1XHR2zLdhDY4vaoyHMpbIOt91VRTu64vt3pDaEwvAjDbxyHZFdjFMchHMAizQKDft9EwHw0iIPu/OW/aUNUhXYaekY+8DpLFCEHcWj9AHiroMFUUR4Jq1hUAvR6zG4FKvBaLPiyG6/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=mTMg/ISv; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 61F0mOhB1882947
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 14 Feb 2026 16:48:24 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 61F0mOhB1882947
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1771116505;
	bh=ucneBYbwed6w+YiHQ22eRRibJvxCeTgoWr88bGmmlaE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=mTMg/ISv9qvu+nDSoDXvZs4YWL7kfEIJXm8vZUvrlZxY/G6fjdGAMwwSNLYmeMP3n
	 yQmn80QArjmubpP2+zmfxg8xccnr0jfqIZ4fzX6KVW+xeGIVUGoxT0oHdUtrGlVSsh
	 yP/sdaFhU0kG097/NzE+NRfrTyotT9FtkQhitEnop4B4cYEx7GTzXz4u1Mp5x6nf31
	 x2tZ06r4e0xxFLuD7Fs4S0IWOz4Goa/WgsRWk7SkBY/QOLVshcS98jK74aBDfHUTjj
	 yqhhGW9PLnLzDxOVR7NDGfR6q+NaRUiMa7kZyW3AdkKhV1B92WeIbZ7Y1tLV+Xi7hk
	 ZLRwIQhScEYlg==
Date: Sat, 14 Feb 2026 16:48:17 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Christian Brauner <brauner@kernel.org>
CC: Al Viro <viro@zeniv.linux.org.uk>, Askar Safin <safinaskar@gmail.com>,
        christian@brauner.io, cyphar@cyphar.com, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        werner@almesberger.net
Subject: Re: [RFC] pivot_root(2) races
User-Agent: K-9 Mail for Android
In-Reply-To: <20260214-unbekannt-ratifizieren-58de8ce30c18@brauner>
References: <1FC2FB1F-BDA5-472D-A7DB-D146F6F75B16@zytor.com> <20260213174721.132662-1-safinaskar@gmail.com> <1caf6a70-e49b-42c7-81d0-bd0d6f5027bf@zytor.com> <20260213222521.GQ3183987@ZenIV> <92837188-C667-4A2A-9D34-85E5F1A5D597@zytor.com> <20260214-unbekannt-ratifizieren-58de8ce30c18@brauner>
Message-ID: <2B0076BB-56E3-4477-900A-E9A34F45264B@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026012301];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77236-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,gmail.com,brauner.io,cyphar.com,suse.cz,vger.kernel.org,linux-foundation.org,almesberger.net];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[zytor.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zytor.com:mid,zytor.com:dkim,zytor.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.org.uk:email]
X-Rspamd-Queue-Id: 6CE4C13DD56
X-Rspamd-Action: no action

On February 14, 2026 4:42:32 AM PST, Christian Brauner <brauner@kernel=2Eor=
g> wrote:
>On Fri, Feb 13, 2026 at 03:00:49PM -0800, H=2E Peter Anvin wrote:
>> On February 13, 2026 2:25:21 PM PST, Al Viro <viro@zeniv=2Elinux=2Eorg=
=2Euk> wrote:
>> >On Fri, Feb 13, 2026 at 12:27:46PM -0800, H=2E Peter Anvin wrote:
>> >> On 2026-02-13 09:47, Askar Safin wrote:
>> >> > "H=2E Peter Anvin" <hpa@zytor=2Ecom>:
>> >> >> It would be interesting to see how much would break if pivot_root=
() was restricted (with kernel threads parked in nullfs safely out of the w=
ay=2E)
>> >> >=20
>> >> > As well as I understand, kernel threads need to follow real root d=
irectory,
>> >> > because they sometimes load firmware from /lib/firmware and call
>> >> > user mode helpers, such as modprobe=2E
>> >> >=20
>> >>=20
>> >> If they are parked in nullfs, which is always overmounted by the glo=
bal root,
>> >> that should Just Work[TM]=2E Path resolution based on that directory=
 should
>> >> follow the mount point unless I am mistaken (which is possible, the =
Linux vfs
>> >> has changed a lot since the last time I did a deep dive=2E)
>> >
>> >You are, and it had always been that way=2E  We do *not* follow mounts=
 at
>> >the starting point=2E  /=2E=2E/lib would work, /lib won't=2E  I'd love=
 to deal with
>> >that wart, but that would break early boot on unknown number of boxen =
and
>> >breakage that early is really unpleasant to debug=2E
>>=20
>> Well, it ought to be easy to make the kernel implicitly prefix /=2E=2E/=
 for kernel-upcall pathnames, which is more or less the same concept as, bu=
t should be a lot simpler than, looking up the init process root=2E
>
>I don't think parking kernel threads unconditionally in nullfs is going
>to work=2E This will not just break firmware loading it will also break
>coredump handling and a bunch of other stuff that relies on root based
>lookup=2E
>
>I think introducing all this new machinery just to improve
>pivot_root()'s broken semantics is pointless=2E Let's just let it die=2E =
We
>have all the tools to avoid it ready=2E OPEN_TREE_NAMESPACE for container=
s
>so pivot_root() isn't needed at all anymore for that case and
>MOVE_MOUNT_BENEATH for the rootfs for v7=2E1 and then even if someone
>wanted to replace the rootfs that whole chroot_fs_refs() dance is not
>needed at all anymore=2E
>
>The only reason to do it would be to make sure that no one accidently
>pins the old rootfs anymore but that's not a strong argument anyway:
>
>- If done during boot it's pointless because most of the times there's
>  exactly one process running and CLONE_FS will guaratee that kernel
>  threads pick up the rootfs change as well=2E
>
>- If done during container setup it's especially useless because again
>  only the process setting up the container will be around=2E
>
>- It doesn't at all deal with file descriptors that pin the old rootfs
>  which is the much more likely case=2E
>
>If anyone actually does pivot_root() on a live system in the initial
>user namespace with a full userspace running work without introducing
>all kinds of breakage they should probably reexamine some design
>decisions=2E
>
>I don't think we need to fix it I think we need to make it unused and I
>think that's possible as I tried to argue=2E

You missed the bit that the kernel tasks would use /=2E=2E to get to the "=
real" root=2E

