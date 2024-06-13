Return-Path: <linux-fsdevel+bounces-21600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55871906491
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 09:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692691C22A57
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 07:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E68C13791E;
	Thu, 13 Jun 2024 07:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="Rxnluk4o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4605F87D
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 07:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718262329; cv=none; b=pryi36H1PX7igTBoewOvo55Z2uZnNImNRSigixlqqPgbWC+e8lLcS/15g+htq9cZwKM8I4dTO/iOpfxJPBZQRhbXWUKt4T6i7cUB4s4rmXIOTrZyy8MQNM9Og0/OvEwgJR99DFCg3yP213mlKVoDS7ER254en8jFI7nr5EMfYu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718262329; c=relaxed/simple;
	bh=P3oNv5AxizLRzW4ucIcMlRlwou0XCogU7FarJQZ+bZ4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=KHtv9602lmuApQyomg40DVtU0KMQaFjp6eJYkZq03aBhGmHhBQE5r+UjlANPzIzF35GFpBLMLQ7GHvRF4D1DGOWiYwo32rW0+vECZz+PW/WXtBrBkJ3U43ALm3D8auHJBzLpkMumhrIw+1tKSe2b2XcoCNs+9O5dmXiwk5u4UYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=Rxnluk4o; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2C16320009;
	Thu, 13 Jun 2024 07:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1718262319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=94/HQ7UFsg3zLtaBFFGaUMR4/4ICG6Lrs8af0wpASsI=;
	b=Rxnluk4omhHGSkigsY+MaP0/dqLBlDNpcHc/n0I2xlQzToeEpPS9WJCnvXwVfnBTxT76nl
	xPMiSlm+CjVPm5ia+VyZtUmKTJ7STyL4qu/nQjxCaG5vD4erBbOx23/xV4fwZGqNczalem
	R3cQ8B0utWrs/6aTlEeAI23bfG8wFhaitZGx55nAXV4GkO9pbtBxpDcnuPWUkY93IQjPNo
	A98QxlOaNOCOqMfz7NTPT4aV4Rh98sU45owukA+MQjpo3olp54mnoMT9hF4HHfjwTApW3v
	VPA7llYeAw7Sxf63F/sdD6bKtE8i010U2/fRTQwR1c+5pIjDnwyu47EJDFZxTQ==
Message-ID: <0b657056-3a7f-46ba-8e99-a8fe2203901f@yoseli.org>
Date: Thu, 13 Jun 2024 09:05:17 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-mtd@lists.infradead.org
Cc: willy@infradead.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-m68k@lists.linux-m68k.org
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Subject: Issue with JFFS2 and a_ops->dirty_folio
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi everyone !

I am currently working on a Coldfire (MPC54418) and quite everything 
goes well, except that I can only execute one command from user space 
before getting a segmentation fault on the do_exit() syscall.

I tried to debug it and it appears to be failing in folio_mark_dirty() 
on the 'return mapping->a_ops->dirty_folio(mapping, folio);' call.

I added a VM_BUG_ON_FOLIO():
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index c2a48592c258..122ca2253263 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2857,9 +2857,9 @@ bool folio_mark_dirty(struct folio *folio)
                  */
                 if (folio_test_reclaim(folio))
                         folio_clear_reclaim(folio);
-               if (mapping->a_ops->dirty_folio)
-                       return mapping->a_ops->dirty_folio(mapping, folio);
-               return noop_dirty_folio(mapping, folio);
+
+               VM_BUG_ON_FOLIO(!mapping->a_ops->dirty_folio, folio);
+               return mapping->a_ops->dirty_folio(mapping, folio);
         }

         return noop_dirty_folio(mapping, folio);

And it appears that this is because if tries unconditionally to call the 
a_ops->dirty_folio() function in JFFS2. The bug report is at the bottom 
of this mail. We see: aops:0x41340ae0

Which, in my build, leads to jffs2_file_address_operations.
And indeed, there is no .dirty_folio nor anything relating to folios in 
there.

I don't really know how to solve this though, as I am no expert in this 
specific part at all !

Thanks for your answers,
BR
JM

---

bash-5.2# ls
bin       etc       lib32     mnt       root      sys       usr
data      home [    9.730000] page: refcount:2 mapcount:1 
mapping:42097964 index:0x97 pfn:0x27f01
      [    9.740000] aops:0x41340ae0 ino:b6 dentry name:"libc.so.6"
     9.740000] flags: 0x28(uptodate|lru|zone=0)
;36ml[    9.750000] raw: 00000028 4fed39bc 4ffd9d24 42097964 00000097 
00000000 00000000 00000002
inux[    9.760000] raw: 4fe02000
rc   9.760000] page dumped because: 
VM_BUG_ON_FOLIO(!mapping->a_ops->dirty_folio)
[m  [    9.770000] kernel BUG at mm/page-writeback.c:2861!
  [    9.770000] *** TRAP #7 ***   FORMAT=4
[    9.770000] Current process id is 24
[    9.770000] BAD KERNEL TRAP: 00000000
[    9.770000] PC: [<41058ff2>] folio_mark_dirty+0x68/0x82
[    9.770000] SR: 2010  SP: 41dcddb4  a2: 418fb710
[    9.770000] d0: 00000027    d1: 0000009e    d2: 4ffd9c24    d3: 60160000
[    9.770000] d4: 4fe03419    d5: 4ffd9c24    a0: 41dcdd00    a1: 414491f0
[    9.770000] Process ls (pid: 24, task=418fb710)
[    9.770000] Frame format=4 eff addr=413d4c3c pc=413dbd16
[    9.770000] Stack from 41dcddf0:
[    9.770000]         00000b2d 413dea77 413dbce8 4fe03419 41dcdf1a 
410750ee 4ffd9c24 00000000
[    9.770000]         ffffffff fffffffe 41dcde9e 60164000 00000001 
41317ea4 41074d0c 41078bb0
[    9.770000]         00000001 41d67034 ffffffff 41dd6600 60164000 
41dd6600 41d6e3d0 41dcc000
[    9.770000]         41d6e3fc 00000000 00000000 00000000 00000000 
41dcdf5c 410753f2 41dcdf1a
[    9.770000]         41d67034 60160000 60164000 41dcde9e 41d6e3fc 
41dcdef6 41dcdf1a 4102a940
[    9.770000]         41d6e3d4 41d67344 41d6e3d0 41dc0000 00000100 
00000003 4107ad24 41dcdf1a
[    9.770000] Call Trace: [<410750ee>] unmap_page_range+0x3e2/0x672
[    9.770000]  [<41317ea4>] mas_find+0x0/0xfa
[    9.770000]  [<41074d0c>] unmap_page_range+0x0/0x672
[    9.770000]  [<41078bb0>] vma_next+0x0/0x14
[    9.770000]  [<410753f2>] unmap_vmas+0x74/0x98
[    9.770000]  [<4102a940>] up_read+0x0/0x34
[    9.770000]  [<4107ad24>] exit_mmap+0xd4/0x1c0
[    9.770000]  [<410093f8>] arch_local_irq_enable+0x0/0xc
[    9.770000]  [<410093ec>] arch_local_irq_disable+0x0/0xc
[    9.770000]  [<41006bfa>] __mmput+0x2e/0x86
[    9.770000]  [<4100a168>] do_exit+0x21e/0x6f2
[    9.770000]  [<4100a7ba>] sys_exit_group+0x0/0x14
[    9.770000]  [<4100a778>] do_group_exit+0x22/0x64
[    9.770000]  [<4100a7ce>] pid_child_should_wake+0x0/0x56
[    9.770000]  [<410058c8>] system_call+0x54/0xa8
[    9.770000]
[    9.770000] Code: bd16 4879 413d 4c3c 4eb9 4132 b30a 4e47 <2f02> 2f0b 
4e90 508f 241f 265f 4e75 2f02 42a7 4eb9 4105 8f56 60ec 2f0b 266f 0008
[    9.770000] Disabling lock debugging due to kernel taint
[    9.770000] note: ls[24] exited with irqs disabled
     9.780000] Fixing recursive fault but reboot is needed!


