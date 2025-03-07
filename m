Return-Path: <linux-fsdevel+bounces-43449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6965A56BF5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 16:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17B1172A32
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 15:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C4521CC7D;
	Fri,  7 Mar 2025 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cslab.ece.ntua.gr header.i=@cslab.ece.ntua.gr header.b="T2zf5W+w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from achilles.noc.ntua.gr (achilles.noc.ntua.gr [147.102.222.210])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A8321CA0F;
	Fri,  7 Mar 2025 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.102.222.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361168; cv=none; b=RAQBCVN1SVXMxXM7WxN7LVFbxIVcO/AwVW3fMKF8c5bkFU3hkMkta8zV+vCfe4SSYpcJQ7gIY9AJzvAKBnM5+FShvTx0vLU+0XIUVlrOplXx8TY45KI2/p2msm7OmQU3ykSSiNAjVYRRedjPrFb3M9I1js3YEq0oZqEa/+vULRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361168; c=relaxed/simple;
	bh=oVpPMTXsg3bi3hi70RsuLhS3qOSUxyPhr8tXaNh8K5g=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=OgBG80aTxMB8mzoJ59sejwnOYOPHhEaoTciLfWUFXHrb6P4zCXZFGANo1CsfldVXn62tyh9f6B0RFynEb4lgdsuezo5dV6lG8I71qUEZXN/+CuhZd1uHdB89U+3WbRnkGpp24ULnp+ylLMwnAHqbKjNnTyk/KyAECIL5MS2mVkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cslab.ece.ntua.gr; spf=pass smtp.mailfrom=cslab.ece.ntua.gr; dkim=fail (1024-bit key) header.d=cslab.ece.ntua.gr header.i=@cslab.ece.ntua.gr header.b=T2zf5W+w reason="signature verification failed"; arc=none smtp.client-ip=147.102.222.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cslab.ece.ntua.gr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cslab.ece.ntua.gr
Received: from webmail.mail.ntua.gr (webmail.mail.ntua.gr [147.102.222.247])
	by achilles.noc.ntua.gr (8.15.2/8.15.2) with ESMTP id 527DBCEG025797;
	Fri, 7 Mar 2025 15:11:13 +0200 (EET)
	(envelope-from jimsiak@cslab.ece.ntua.gr)
Received: from webmail.ntua.gr ([IPv6:2001:648:2000:de:0:0:0:247])
	by webmail.mail.ntua.gr (8.15.2/8.15.2) with ESMTP id 527DB9nr096999;
	Fri, 7 Mar 2025 15:11:10 +0200 (EET)
	(envelope-from jimsiak@cslab.ece.ntua.gr)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cslab.ece.ntua.gr;
	s=ntuawebmail; t=1741353072;
	bh=oVpPMTXsg3bi3hi70RsuLhS3qOSUxyPhr8tXaNh8K5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=T2zf5W+wLagiy8P5No0no31FHpQrRE+eN4n0FMpeIzccfnKBL8kHzWJ2S1fsSuBN2
	 BCo/GrEVNabskXcfd8ERSuUqZS/N27ndecgWKkXsU/Bx7r+yYtbLRKoLwxiBKODdr3
	 zc9xoEfP9x+yiASASJmwRRtde56CgkWeSGCd3EAc=
X-Authentication-Warning: webmail.mail.ntua.gr: Host [IPv6:2001:648:2000:de:0:0:0:247] claimed to be webmail.ntua.gr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Fri, 07 Mar 2025 15:11:09 +0200
From: jimsiak <jimsiak@cslab.ece.ntua.gr>
To: Jinjiang Tu <tujinjiang@huawei.com>
Cc: peterx@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, wangkefeng.wang@huawei.com
Subject: Re: Using userfaultfd with KVM's async page fault handling causes
 processes to hung waiting for mmap_lock to be released
In-Reply-To: <46ac83f7-d3e0-b667-7352-d853938c9fc9@huawei.com>
References: <79375b71-db2e-3e66-346b-254c90d915e2@cslab.ece.ntua.gr>
 <20250307072133.3522652-1-tujinjiang@huawei.com>
 <46ac83f7-d3e0-b667-7352-d853938c9fc9@huawei.com>
Message-ID: <dee238e365f3727ab16d6685e186c53c@cslab.ece.ntua.gr>
X-Sender: jimsiak@cslab.ece.ntua.gr
User-Agent: Roundcube Webmail/1.3.10
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.6.2 (achilles.noc.ntua.gr [147.102.222.210]); Fri, 07 Mar 2025 15:11:13 +0200 (EET)

Hi,

 From my side, I managed to avoid the freezing of processes with the 
following change in function userfaultfd_release() in file 
fs/userfaultfd.c 
(https://elixir.bootlin.com/linux/v5.13/source/fs/userfaultfd.c#L842):

I moved the following command from line 851:
WRITE_ONCE(ctx->released, true);
(https://elixir.bootlin.com/linux/v5.13/source/fs/userfaultfd.c#L851)

to line 905, that is exactly before the functions returns 0.

That simple workaround worked for my use case but I am far from sure 
that is a correct/sufficient fix for the problem at hand.

Best Regards,
Dimitris

Στις 07/03/2025 10:07, Jinjiang Tu έγραψε:
> cc Peter Xu
> 
> 在 2025/3/7 15:21, Jinjiang Tu 写道:
>> Hi,
>> 
>> I encountered the same issue too. In my scenario, GUP is called by 
>> mlockall()
>> syscall.
>> 
>> Is there a solution to fix it?
>> 
>> Thanks.
>> 

