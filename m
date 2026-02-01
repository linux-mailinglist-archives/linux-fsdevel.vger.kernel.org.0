Return-Path: <linux-fsdevel+bounces-76001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 91a3M9XQfml4fAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Feb 2026 05:04:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F06DC4E32
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Feb 2026 05:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2011D3017387
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Feb 2026 04:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705132C2ABF;
	Sun,  1 Feb 2026 04:04:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C19632;
	Sun,  1 Feb 2026 04:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769918670; cv=none; b=aLrqfE0YT+cTr7xAvmLnTF3J/tTp7R+ONNJNikdL6g625VRpl02iT778rfX2oFwWDuYiuaR9/Oi8KzGH3c9nHsOa2J1DFuemo8BtMt/f8Hzya+Muk5p4svUFjJEQHWCfoUwWoFC5kY8OpN8Wv0dwo5Q64mZWqq2cm4sUbMJYENE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769918670; c=relaxed/simple;
	bh=EStvTcxikrXcdrr14MrE8GgxL02wJVrJaIZKvpxq3xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=boiqJ27v+Y3/fNZXqLwt+BpJuu30fw9lAtCaWrJmalEz5L1TL1NWs0P6M+AvuNkewZAUUrKWlJ6/MrTQ2iNy+wrG7pjJjmy0a+sP0SvQ0b7s+yAVBI4UZl/nV35kWgmaixbE2WmVR5K8qQ4+XFWBnht//Aisrf3OqsH95MSJNvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 61143aHn013995;
	Sun, 1 Feb 2026 13:03:36 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 61143aSs013992
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 1 Feb 2026 13:03:36 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ad88d665-1df2-41f8-a76c-3722dcb68bb6@I-love.SAKURA.ne.jp>
Date: Sun, 1 Feb 2026 13:03:36 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hfsplus: pretend special inodes as regular files
To: Christian Brauner <brauner@kernel.org>,
        Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "jack@suse.cz" <jack@suse.cz>, "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+f98189ed18c1f5f32e00@syzkaller.appspotmail.com"
 <syzbot+f98189ed18c1f5f32e00@syzkaller.appspotmail.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "kapoorarnav43@gmail.com" <kapoorarnav43@gmail.com>
References: <da5dde25-e54e-42a4-8ce6-fa74973895c5@I-love.SAKURA.ne.jp>
 <20260113-lecken-belichtet-d10ec1dfccc3@brauner>
 <92748f200068dc1628f8e42c671e5a3a16c40734.camel@ibm.com>
 <20260114-kleben-blitzen-4b50f7bad660@brauner>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260114-kleben-blitzen-4b50f7bad660@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav103.rs.sakura.ne.jp
X-Virus-Status: clean
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.cz,vivo.com,vger.kernel.org,dubeyko.com,syzkaller.appspotmail.com,googlegroups.com,physik.fu-berlin.de,zeniv.linux.org.uk,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76001-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,f98189ed18c1f5f32e00];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F06DC4E32
X-Rspamd-Action: no action

On 2026/01/15 1:05, Christian Brauner wrote:
> On Tue, Jan 13, 2026 at 05:18:40PM +0000, Viacheslav Dubeyko wrote:
>> On Tue, 2026-01-13 at 09:55 +0100, Christian Brauner wrote:
>>> On Mon, 12 Jan 2026 18:39:23 +0900, Tetsuo Handa wrote:
>>>> Since commit af153bb63a33 ("vfs: catch invalid modes in may_open()")
>>>> requires any inode be one of S_IFDIR/S_IFLNK/S_IFREG/S_IFCHR/S_IFBLK/
>>>> S_IFIFO/S_IFSOCK type, use S_IFREG for special inodes.
>>>>
>>>>
>>>
>>> Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
>>> Patches in the vfs-7.0.misc branch should appear in linux-next soon.
>>>
>>> Please report any outstanding bugs that were missed during review in a
>>> new review to the original patch series allowing us to drop it.
>>>
>>> It's encouraged to provide Acked-bys and Reviewed-bys even though the
>>> patch has now been applied. If possible patch trailers will be updated.
>>>
>>> Note that commit hashes shown below are subject to change due to rebase,
>>> trailer updates or similar. If in doubt, please check the listed branch.
>>>
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git  
>>> branch: vfs-7.0.misc
>>>
>>> [1/1] hfsplus: pretend special inodes as regular files
>>>       https://git.kernel.org/vfs/vfs/c/68186fa198f1  
>>
>> I've already taken this patch into HFS/HFS+ tree. :) Should I remove it from the
>> tree?
> 
> No, I'll drop it.

I still can't see this patch in linux-next tree. What is happening?


