Return-Path: <linux-fsdevel+bounces-56263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B077B151A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 18:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781B418A3E34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 16:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27342220F4C;
	Tue, 29 Jul 2025 16:50:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AF24F5E0;
	Tue, 29 Jul 2025 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753807840; cv=none; b=IhzbUzNNoBM2e9yywyAyq76i8VOQUbAOmAsprkDDS+Ifb+ux1Nh5Hq/AL5CcJ8oEi53ik0PiitAz/F3xBHsPyA9IorX91AVQpsWxRKDRFf0V35Xs1lCEjS+rDUdliOYDI2BOebCS7VKlvPlJAn9as4OnmFpbIiARgxaWDe7tv7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753807840; c=relaxed/simple;
	bh=YhCu13q3EaOM9+19rgoO9TQAPpoXFGMXcSNVdaJcCwM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oIWE4n//l7hePMaJXicxay8IY/MSw1Mu4TBXESrH/+Dq4Vo1eFBhA2pQyAJ6Ht2D7G6HfG1vU/gy1NEnSov61IIPvFN4/UyQ8JnPis+OJ7AtIehpfNeRsM35cqptcxk7fi0xWdq2O2TAJNtvsBHNzTbkTcocc7fkqXwMMJrAUso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bs0H82Rfxz9s2l;
	Tue, 29 Jul 2025 17:52:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id foIBeN0qtQ-W; Tue, 29 Jul 2025 17:52:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bs0H81KxLz9s28;
	Tue, 29 Jul 2025 17:52:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 27C058B76C;
	Tue, 29 Jul 2025 17:52:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id AvByEn6-Kv3I; Tue, 29 Jul 2025 17:52:52 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 95C748B763;
	Tue, 29 Jul 2025 17:52:51 +0200 (CEST)
Message-ID: <1c37a89e-cfc7-4d4c-89e1-1b3f1217b11e@csgroup.eu>
Date: Tue, 29 Jul 2025 17:52:51 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/Kconfig: Enable HUGETLBFS only if
 ARCH_SUPPORTS_HUGETLBFS
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
 "David S. Miller" <davem@davemloft.net>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250711102934.2399533-1-anshuman.khandual@arm.com>
 <20250712161549.499ec62de664904bd86ffa90@linux-foundation.org>
 <f86c9ec6-d82d-4d0c-80b2-504f7c6da22e@arm.com>
 <20250714094909.GBaHTSlW8nkuINON9p@fat_crate.local>
 <20250714173109.265d1fbfa9884cd22c3a6975@linux-foundation.org>
 <9e4e4a84-d929-4317-b920-d11f4bee60df@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <9e4e4a84-d929-4317-b920-d11f4bee60df@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 29/07/2025 à 17:50, Christophe Leroy a écrit :
> 
> 
> Le 15/07/2025 à 02:31, Andrew Morton a écrit :
>> On Mon, 14 Jul 2025 11:49:09 +0200 Borislav Petkov <bp@alien8.de> wrote:
>>
>>> On Mon, Jul 14, 2025 at 08:05:31AM +0530, Anshuman Khandual wrote:
>>>> The original first commit had added 'BROKEN', although currently there
>>>> are no explanations about it in the tree.
>>>
>>> commit c0dde7404aff064bff46ae1d5f1584d38e30c3bf
>>> Author: Linus Torvalds <torvalds@home.osdl.org>
>>> Date:   Sun Aug 17 21:23:57 2003 -0700
>>>
>>>      Add CONFIG_BROKEN (default 'n') to hide known-broken drivers.
>>
>> Thanks.  That was unkind of someone.  How's this?
>>
>>
>> From: Andrew Morton <akpm@linux-foundation.org>
>> Subject: init/Kconfig: restore CONFIG_BROKEN help text
>> Date: Mon Jul 14 05:20:02 PM PDT 2025
>>
>> Linus added it in 2003, it later was removed.  Put it back.
> 
> Was removed by:
> 
> commit 3be71ba84f17f39131900f44e8ef513c696a5b11
> Author: Linus Torvalds <torvalds@home.osdl.org>
> Date:   Mon Sep 1 21:30:14 2003 -0700
> 
>      Instead of asking for "broken drivers", ask for a "clean compile".
> 
>      This makes "allyesconfig" do a better job.

Which was then later removed by:

commit 3636641bb2c7a806c1099ca092ec8cd180063f9b
Author: Adrian Bunk <bunk@stusta.de>
Date:   Fri Feb 3 03:04:00 2006 -0800

     [PATCH] don't allow users to set CONFIG_BROKEN=y

     Do not allow people to create configurations with CONFIG_BROKEN=y.

     The sole reason for CONFIG_BROKEN=y would be if you are working on 
fixing a
     broken driver, but in this case editing the Kconfig file is trivial.

     Never ever should a user enable CONFIG_BROKEN.

     Signed-off-by: Adrian Bunk <bunk@stusta.de>
     Signed-off-by: Andrew Morton <akpm@osdl.org>
     Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/init/Kconfig b/init/Kconfig
index b9923b1434a2f..8b7abae87bf9c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -31,19 +31,8 @@ config EXPERIMENTAL
  	  you say Y here, you will be offered the choice of using features or
  	  drivers that are currently considered to be in the alpha-test phase.

-config CLEAN_COMPILE
-	bool "Select only drivers expected to compile cleanly" if EXPERIMENTAL
-	default y
-	help
-	  Select this option if you don't even want to see the option
-	  to configure known-broken drivers.
-
-	  If unsure, say Y
-
  config BROKEN
  	bool
-	depends on !CLEAN_COMPILE
-	default y

  config BROKEN_ON_SMP
  	bool


