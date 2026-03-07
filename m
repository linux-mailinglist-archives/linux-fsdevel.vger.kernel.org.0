Return-Path: <linux-fsdevel+bounces-79684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCriIA/bq2luhQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 09:00:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD97322AB0A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 09:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5D283030EBD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2026 08:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A4037757E;
	Sat,  7 Mar 2026 08:00:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191E93563F0
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Mar 2026 08:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772870405; cv=none; b=lnrLNpE5Hy9Q74DHmwIbDZ+dvKNgpjYoMRNj91DyJtkHsfHv9RwBw89Kb00O8Bp7E3e9t52L6yY4Ms3YDwo/XNZn8sl0uYVT0gmZScw/7YxXRSvpkz8/KdDscyupelWJEWh2FESx7ewkzgdBVORLKVCix0LscPK9Pr8S3Hdu4c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772870405; c=relaxed/simple;
	bh=ahR8okVFg09x+dFpjVpGySK9pYRG7ZHPfyoaQbxMt20=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q6Wk6SoYH3UUNa2NIZczkXbcuayuwdD5jLck+aEwb36AMFMVLU/fNTtAesqMuf4sdNDDjEYSNJ3b7K1tru6Nx4e/34kCnATZIy2uFleF8MXl87Vbvzvgd7G2Rdau1c1zVGGsZNnWudgS2NuWTH/SWRO7nXMrBDKZY1ZqBVKtLBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-679ca40278bso147364589eaf.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Mar 2026 00:00:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772870402; x=1773475202;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oeYFU/cwdUHyWEw8Q/UgeICTLzKAyu8PtvzLTjGtZB0=;
        b=Ht36y+/AnYqfQ3ZT0UFP6x72iEzzc4NekoVLxtZYaAHF3owBRuX10Rsh0dNgGn7Zjo
         xzktoY4WxFC0GS8YlZ/mCo/sTnfbfv6oHeiUuOI6QiKrskz3Jn+7Hr0NO34gWWeOcw1F
         PMDfkbhsPY+e/hgnQnPZs5XBZC3SsaIpg7YgdC0RIBYKG/nN1wungNmIrdExPPFUHMkr
         okenB12oaeY0t0FGsDHLsOuYhjukahLArhEsRrs0gwvFcQHi5c8+KHsJeS0LMQc2AjqD
         P8yMHv6a6hO8CbJrlz1rI4MJ6MZ143wjwkcOyuSMIuEGL2L+mMBWeS+I9jhP2aXfKalK
         t2ow==
X-Forwarded-Encrypted: i=1; AJvYcCWfLS3xEhnO+YhvhAPEkopYWN85cHv/x0tWitKI9tcOazGTdqAPTcociyDyzvKvnZGyjav9dInHGu8MP6CN@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+jjYmQKN5gdCN3bqyFrG+SWTqHw/mItoNxeu5rqNHUwdNf3gq
	IXbynuFH6f6Zx2rWkFeeNksk2ambXpsLt54E8iU0NjairjiK4AfAevh5Cs7oTUYUiKx+Bx+Q/QT
	5ohndX3wGIziyO8OAx7bFrdjzPBUROoIu7a+V2tdTFuxbYVRfl9Cl97JDzkM=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:200a:b0:673:3cef:fc1f with SMTP id
 006d021491bc7-67b9bd1aee2mr2741470eaf.38.1772870402040; Sat, 07 Mar 2026
 00:00:02 -0800 (PST)
Date: Sat, 07 Mar 2026 00:00:02 -0800
In-Reply-To: <675785.1772868420@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69abdb02.050a0220.13f275.0043.GAE@google.com>
Subject: Re: [syzbot] [netfs?] BUG: unable to handle kernel NULL pointer
 dereference in netfs_unbuffered_write
From: syzbot <syzbot+7227db0fbac9f348dba0@syzkaller.appspotmail.com>
To: dhowells@redhat.com, kartikey406@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: DD97322AB0A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=976ba5a93c4add9e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79684-lists,linux-fsdevel=lfdr.de,7227db0fbac9f348dba0];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,vger.kernel.org,lists.linux.dev,manguebit.org,googlegroups.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.861];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7227db0fbac9f348dba0@syzkaller.appspotmail.com
Tested-by: syzbot+7227db0fbac9f348dba0@syzkaller.appspotmail.com

Tested on:

commit:         c107785c Merge tag 'modules-7.0-rc3.fixes' of git://gi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11d4db5a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=976ba5a93c4add9e
dashboard link: https://syzkaller.appspot.com/bug?extid=7227db0fbac9f348dba0
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1464db5a580000

Note: testing is done by a robot and is best-effort only.

