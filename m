Return-Path: <linux-fsdevel+bounces-25587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C889A94DAFD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 07:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CFDC28292E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 05:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFE647F46;
	Sat, 10 Aug 2024 05:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bitron.ch header.i=@bitron.ch header.b="I9mMPaOM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from nov-007-i651.relay.mailchannels.net (nov-007-i651.relay.mailchannels.net [46.232.183.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4943D0A9
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Aug 2024 05:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.232.183.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723269397; cv=none; b=nNTzwnbiykRnAzcG9IB3PDNKq2U+GoT+h3X5HK0QK8/yEFvCZoKjE5KegNwkHEOqxjkSE7d82Nm4oloawUtchdCZuMZ/3LiBIZsLTK0seWbdqDrhyWV8oAGliTp0r/g0EtQQfnNzetE5A2D1TsM79z/OkSocZm7T8lIGUEmX0VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723269397; c=relaxed/simple;
	bh=VxgaU1LK9xtJ0JbcMhju+WzSssGxxFYTn5cSdpfNky4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M0nQnP2deBWCbFbSzsBf13r1qwCE6Qz+xPFWbMYPunHq9jyuV952+uN4Wholb9j4tZ+aQvW8SGWQcUmTaoQxEJ5UhmnkTQk0md+CgtjyNPcWr9+sZX/zoF2yXlFSgyzHhrK19HWwIKEyCUXT67kS+Bf2l2F/qIbeoIk+zwBxvig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitron.ch; spf=pass smtp.mailfrom=bitron.ch; dkim=pass (2048-bit key) header.d=bitron.ch header.i=@bitron.ch header.b=I9mMPaOM; arc=none smtp.client-ip=46.232.183.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitron.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitron.ch
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D4D3B7E000F;
	Sat, 10 Aug 2024 05:56:29 +0000 (UTC)
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
X-MC-Relay: Neutral
X-MailChannels-SenderId: novatrend|x-authuser|juerg@bitron.ch
X-MailChannels-Auth-Id: novatrend
X-Tank-Obese: 75ea7ae33ffd7d1e_1723269389321_906078804
X-MC-Loop-Signature: 1723269389321:2065153395
X-MC-Ingress-Time: 1723269389321
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitron.ch;
	s=default; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=J2Iw9kGo2ORryaAUGaJlxOEenGCMX0xfNB34sdFoAFw=; b=I9mMPaOMJRF9Z5P4uUgy+xLgpW
	dVamQ+XssGgUm6GVdf/UWQfQr8c16bXrDfcKlNkgZdfFUt0LKyTZEOsq5Ua4OD8qayaXd5X1Uc1uy
	YE7OD6S4tdVAIg1/VjmBs8aWDWhoejAADzL8758Se21DOlYLYrkjaO2J/cYPf7cWv8egFV9Zx+w/9
	gWkWjnDYtxciYU2juHc//H/IMe89Pcex8AlrbAS+0TCMEs+yuCWBY6UhFWlcS1lF4c7lxg+NFAEp8
	3OUNXqyEOLwVmK6w0Hh96x8EMsJ2loLtmzJym6JUCO4ihUESCTvo+19WZxNirbYPkc0JY6Wq7H8br
	Hf5CwTwg==;
Message-ID: <5b54cb7e5bfdd5439c3a431d4f86ad20c9b22e76.camel@bitron.ch>
Subject: Re: [REGRESSION] fuse: copy_file_range() fails with EIO
From: =?ISO-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
To: Matthew Wilcox <willy@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	regressions@lists.linux.dev
Date: Sat, 10 Aug 2024 07:56:21 +0200
In-Reply-To: <ZrY97Pq9xM-fFhU2@casper.infradead.org>
References: <792a3f54b1d528c2b056ae3c4ebaefe46bca8ef9.camel@bitron.ch>
	 <ZrY97Pq9xM-fFhU2@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: juerg@bitron.ch

Hi Matthew,

Thanks for the quick response.

On Fri, 2024-08-09 at 17:03 +0100, Matthew Wilcox wrote:
> Do you have CONFIG_DEBUG_VM enabled?=C2=A0 There are some debugging asser=
ts
> which that will enable that might indicate a problem.

With CONFIG_DEBUG_VM enabled, I get:

page: refcount:2 mapcount:0 mapping:00000000b2c30835 index:0x0 pfn:0x12a113
memcg:ffff9d8e3a660800
aops:0xffffffff8a056820 ino:21 dentry name:"bash"
flags: 0x24000000000022d(locked|referenced|uptodate|lru|workingset|node=3D0=
|zone=3D2)
raw: 024000000000022d ffffd9ce04a827c8 ffffd9ce04a84508 ffff9d8e0bbc99f0
raw: 0000000000000000 0000000000000000 00000002ffffffff ffff9d8e3a660800
page dumped because: VM_BUG_ON_FOLIO(folio_test_uptodate(folio))
------------[ cut here ]------------
kernel BUG at mm/filemap.c:1534!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
CPU: 0 UID: 1000 PID: 1638 Comm: buildbox-fuse Not tainted 6.11.0-rc2+ #26
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
RIP: 0010:folio_end_read+0xa2/0xb0
Code: 37 8a e8 21 1b 05 00 0f 0b 48 c7 c6 48 7f 39 8a e8 13 1b 05 00 0f 0b =
31 f6 e9 7a f9 ff ff 48 c7 c6 a8 7f 39 8a e8 fe 1a 05 00 <0f> 0b 90 66 66 2=
e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
RSP: 0018:ffffaa0ec289fc68 EFLAGS: 00010246
RAX: 0000000000000040 RBX: ffffd9ce04a844c0 RCX: 0000000000000027
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff9d8f77c1c8c0
RBP: ffff9d8e07298a38 R08: 00000000ffffefff R09: ffffffff8a6b0d68
R10: 0000000000000003 R11: 0000000000000002 R12: 0000000000000000
R13: 0000000000000001 R14: ffff9d8e305ba098 R15: 0000000000000000
FS:  00007f83d62b4140(0000) GS:ffff9d8f77c00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564ef5598078 CR3: 00000001013be000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ? __die+0x56/0x97
 ? die+0x2e/0x50
 ? do_trap+0x10a/0x110
 ? do_error_trap+0x65/0x80
 ? folio_end_read+0xa2/0xb0
 ? exc_invalid_op+0x50/0x70
 ? folio_end_read+0xa2/0xb0
 ? asm_exc_invalid_op+0x1a/0x20
 ? folio_end_read+0xa2/0xb0
 ? folio_end_read+0xa2/0xb0
 fuse_readpages_end+0xc3/0x150
 fuse_request_end+0x84/0x170
 fuse_dev_do_write+0x24d/0x1050
 ? __kmalloc_node_noprof+0x25e/0x480
 ? fuse_dev_splice_write+0x9d/0x390
 fuse_dev_splice_write+0x2b0/0x390
 do_splice+0x311/0x8b0
 __do_splice+0x204/0x220
 __x64_sys_splice+0xb2/0x120
 do_syscall_64+0x54/0x140
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f83d5f29a03
Code: 64 89 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 =
80 3d 29 48 0d 00 00 49 89 ca 74 14 b8 13 01 00 00 0f 05 <48> 3d 00 f0 ff f=
f 77 75 c3 0f 1f 40 00 55 48 83 ec 30 44 89 4c 24
RSP: 002b:00007fff2c0b8ce8 EFLAGS: 00000202 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 00007fff2c0b8eb0 RCX: 00007f83d5f29a03
RDX: 0000000000000105 RSI: 0000000000000000 RDI: 0000000000000106
RBP: 0000564ef555a4f0 R08: 0000000000004010 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000202 R12: 00007fff2c0b8e20
R13: 0000000000000001 R14: 00000000000000fb R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:folio_end_read+0xa2/0xb0
Code: 37 8a e8 21 1b 05 00 0f 0b 48 c7 c6 48 7f 39 8a e8 13 1b 05 00 0f 0b =
31 f6 e9 7a f9 ff ff 48 c7 c6 a8 7f 39 8a e8 fe 1a 05 00 <0f> 0b 90 66 66 2=
e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
RSP: 0018:ffffaa0ec289fc68 EFLAGS: 00010246
RAX: 0000000000000040 RBX: ffffd9ce04a844c0 RCX: 0000000000000027
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff9d8f77c1c8c0
RBP: ffff9d8e07298a38 R08: 00000000ffffefff R09: ffffffff8a6b0d68
R10: 0000000000000003 R11: 0000000000000002 R12: 0000000000000000
R13: 0000000000000001 R14: ffff9d8e305ba098 R15: 0000000000000000
FS:  00007f83d62b4140(0000) GS:ffff9d8f77c00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564ef5598078 CR3: 00000001013be000 CR4: 0000000000350ef0
Kernel panic - not syncing: Fatal exception
Kernel Offset: 0x8000000 from 0xffffffff81000000 (relocation range: 0xfffff=
fff80000000-0xffffffffbfffffff)

Cheers,
J=C3=BCrg

