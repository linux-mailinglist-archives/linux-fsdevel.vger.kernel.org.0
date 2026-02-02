Return-Path: <linux-fsdevel+bounces-76096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOBeJhAdgWm0EAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 22:54:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1381AD1E10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 22:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F43330327CE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 21:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FF5314A7A;
	Mon,  2 Feb 2026 21:51:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5355A26FA6F;
	Mon,  2 Feb 2026 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770069102; cv=none; b=dCj5KtuB/q0D1pm4poLLNpikWlU+WHEd86zuywLr3qCnsY9ZTnNC0zqKlj0NEwbwCCOjJd3k9YudUghq/bhYprjU6T5b3MjVFkOKrs65qgHyvFepThfUH3xYMG3YQxTLZOf5xUXCpwEWdMPKvHoraASRkOqBfaLGjCiWV+innbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770069102; c=relaxed/simple;
	bh=3h9SY0d1v4cFAzvBUc/m0UD2epR8s2CuluXajEhqRZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QBXG/ypGlB+aVVbRCHzjCwSdAkCHe9KeYyGbEtiqSM3fipvCKyy+V9lKln2qGYbwEi29L/9mPWe+jwXKxd+uM6YAQyM58xgVeTU5EQfUT2Jp5CH5ixk+fGJvgBBCs4+Vskm3yZQtPzbWx8mmW82oRlcT6IP+/E3FcqSsCRPBnKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 612Loxak045220;
	Tue, 3 Feb 2026 06:50:59 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 612LoxRW045216
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 3 Feb 2026 06:50:59 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <322f98bb-128e-4138-9871-ae9d5bafb055@I-love.SAKURA.ne.jp>
Date: Tue, 3 Feb 2026 06:50:59 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hfsplus: pretend special inodes as regular files
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "brauner@kernel.org" <brauner@kernel.org>
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
 <ad88d665-1df2-41f8-a76c-3722dcb68bb6@I-love.SAKURA.ne.jp>
 <de541759cfa4d216e342bf15b07f93a21f46498b.camel@ibm.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <de541759cfa4d216e342bf15b07f93a21f46498b.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav101.rs.sakura.ne.jp
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.cz,vivo.com,vger.kernel.org,dubeyko.com,syzkaller.appspotmail.com,googlegroups.com,physik.fu-berlin.de,zeniv.linux.org.uk,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76096-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,I-love.SAKURA.ne.jp:mid]
X-Rspamd-Queue-Id: 1381AD1E10
X-Rspamd-Action: no action

On 2026/02/03 2:30, Viacheslav Dubeyko wrote:
>>>> I've already taken this patch into HFS/HFS+ tree. :) Should I remove it from the
>>>> tree?
>>>
>>> No, I'll drop it.
>>
>> I still can't see this patch in linux-next tree. What is happening?
> 
> The patch in HFS/HFS+ tree. I will send it in pull request for 6.20-rc1.
> 

Patches are expected to be tested in the linux-next tree
before sending a pull request for the linux tree.


