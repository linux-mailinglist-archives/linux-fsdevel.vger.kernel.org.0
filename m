Return-Path: <linux-fsdevel+bounces-56259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00672B15132
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 18:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F783AB7F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 16:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7012248BE;
	Tue, 29 Jul 2025 16:20:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773F5207A0C;
	Tue, 29 Jul 2025 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753806041; cv=none; b=ET8ZKP9MMInwjBXRFwpaYd2F6Coz/gsA7w5GLnORRS705l7cVdOCHqlVyEcRedweuUHpDRgVV5QomL/Rf5omj8EAq032y04j2lRVMlI3rhnphuaAVajSsYyE1GLSAaKLm+ZcK4SODO/rpMf6C0Tekl/+jQanCwTF/QflcCucuWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753806041; c=relaxed/simple;
	bh=i43610tvqBJuvGx7T80zPvL2glQBBrIB6lDokAxQyhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z48GamdVQOx04IkCXNSHAVNuQG7o5FCi3ZKh3fZP1Eya7RmrAkzDT0J2ozYI5LzJW2VHk6mftNxo8KUmu5Iv+0BrWHQ1m3Ey045WDhFfZP5zJRWXfsPs6ca7H0bXe5eqNr06YIl1faBjk8Q6mdnqwj1pcd27IuXB/4yBD1cH2VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bs0Cs1GQKz9tCB;
	Tue, 29 Jul 2025 17:50:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QjRJn_Dc9ZzD; Tue, 29 Jul 2025 17:50:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bs0Cs0JmCz9tC6;
	Tue, 29 Jul 2025 17:50:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id F2C4D8B76C;
	Tue, 29 Jul 2025 17:50:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id OVsTyMLIJHK4; Tue, 29 Jul 2025 17:50:00 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 608B28B763;
	Tue, 29 Jul 2025 17:50:00 +0200 (CEST)
Message-ID: <9e4e4a84-d929-4317-b920-d11f4bee60df@csgroup.eu>
Date: Tue, 29 Jul 2025 17:50:00 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/Kconfig: Enable HUGETLBFS only if
 ARCH_SUPPORTS_HUGETLBFS
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
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250714173109.265d1fbfa9884cd22c3a6975@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 15/07/2025 à 02:31, Andrew Morton a écrit :
> On Mon, 14 Jul 2025 11:49:09 +0200 Borislav Petkov <bp@alien8.de> wrote:
> 
>> On Mon, Jul 14, 2025 at 08:05:31AM +0530, Anshuman Khandual wrote:
>>> The original first commit had added 'BROKEN', although currently there
>>> are no explanations about it in the tree.
>>
>> commit c0dde7404aff064bff46ae1d5f1584d38e30c3bf
>> Author: Linus Torvalds <torvalds@home.osdl.org>
>> Date:   Sun Aug 17 21:23:57 2003 -0700
>>
>>      Add CONFIG_BROKEN (default 'n') to hide known-broken drivers.
> 
> Thanks.  That was unkind of someone.  How's this?
> 
> 
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: init/Kconfig: restore CONFIG_BROKEN help text
> Date: Mon Jul 14 05:20:02 PM PDT 2025
> 
> Linus added it in 2003, it later was removed.  Put it back.

Was removed by:

commit 3be71ba84f17f39131900f44e8ef513c696a5b11
Author: Linus Torvalds <torvalds@home.osdl.org>
Date:   Mon Sep 1 21:30:14 2003 -0700

     Instead of asking for "broken drivers", ask for a "clean compile".

     This makes "allyesconfig" do a better job.

diff --git a/init/Kconfig b/init/Kconfig
index 3b6e6d580e1d..c296f6bee03c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -32,16 +32,19 @@ config EXPERIMENTAL
  	  you say Y here, you will be offered the choice of using features or
  	  drivers that are currently considered to be in the alpha-test phase.

-config BROKEN
-	bool "Prompt for old and known-broken drivers"
-	depends on EXPERIMENTAL
-	default n
+config CLEAN_COMPILE
+	bool "Don't select drivers known to be broken" if EXPERIMENTAL
+	default y
  	help
-	  This option allows you to choose whether you want to try to
-	  compile (and fix) old drivers that haven't been updated to
-	  new infrastructure.
+	  Select this option if you don't even want to see the option
+	  to configure known-broken drivers.

-	  If unsure, say N.
+	  If unsure, say Y
+
+config BROKEN
+	bool
+	depends on !CLEAN_COMPILE
+	default y

  config BROKEN_ON_SMP
  	bool



> 
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Borislav Betkov <bp@alien8.de>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Thomas Gleinxer <tglx@linutronix.de>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>   init/Kconfig |    4 ++++
>   1 file changed, 4 insertions(+)
> 
> --- a/init/Kconfig~a
> +++ a/init/Kconfig
> @@ -169,6 +169,10 @@ menu "General setup"
>   
>   config BROKEN
>   	bool
> +	help
> +	  This option allows you to choose whether you want to try to
> +	  compile (and fix) old drivers that haven't been updated to
> +	  new infrastructure.
>   
>   config BROKEN_ON_SMP
>   	bool
> _
> 
> 


