Return-Path: <linux-fsdevel+bounces-17158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D364B8A8870
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 18:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FBC2B21780
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 16:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EB21487F9;
	Wed, 17 Apr 2024 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="aGuzyX+B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8891C1487D2
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370033; cv=none; b=Ovmr3oiRvcAOnG5qxE6z4rBLXWjv3+xQ6wNfN38rWU8x3SiYSBRJ+Rc/bRPdumtTKNOAU/NslO8Iyjji2KZkrcQsWCad5DcHxHcxdodprqT2DC7k4i/jzH2eo03qJ0VYgaIXE3hpxPgPQXOzb17pnwj1jnWJ2dqbrgPS6XfaFVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370033; c=relaxed/simple;
	bh=JMdImt1rqEG+anLm+o4q9u965rHrPHelnM1X6Rzf8tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sUvEcGPbnj5Qd6EvZf2jt/K+bzhGBYvmbA1jKX+0tjoLQEGh7CqY4JXgPEBvhyXWC8/VXDIHID9hBe8M8ymAKC/6rFoMTNEgmb8r7p9pFLnrgZFkkxIf/aV5TIH+reTrQaYVJKz8Zyu0UoUqlADLjkQupHi9aPtF+8ijVwi9yMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=aGuzyX+B; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 2F7E71FE9;
	Wed, 17 Apr 2024 15:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713369579;
	bh=5HR+GG9SCNa/Fu4bWlTHqrfnklhDGqCwal0cb0yJpso=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=aGuzyX+Bef2BO+H53d4nZxDdDBmpoTpsESG8PiUklBG1ssfJtmzLjyKe4yDu2OtkN
	 UFkgRYAbeC1f9VZYgxcKAKfoq0LIO0XMB+nQ96m7hBTsS3w1TThJ5mr8KAdqfJQyvF
	 hDAScC9s8paOXd7SwVWsrLdTUkCvNlSXawQFUAJg=
Received: from [192.168.211.17] (192.168.211.17) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 17 Apr 2024 19:07:07 +0300
Message-ID: <015aa42b-abac-4810-8743-43913ab8e2d9@paragon-software.com>
Date: Wed, 17 Apr 2024 19:07:06 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ntfs3: remove warning
To: Christian Brauner <brauner@kernel.org>, Johan Hovold <johan@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Anton Altaparmakov
	<anton@tuxera.com>, Namjae Jeon <linkinjeon@kernel.org>,
	<ntfs3@lists.linux.dev>
CC: <linux-fsdevel@vger.kernel.org>, <linux-ntfs-dev@lists.sourceforge.net>,
	<regressions@lists.linux.dev>
References: <Zf2zPf5TO5oYt3I3@hovoldconsulting.com>
 <20240325-faucht-kiesel-82c6c35504b3@brauner>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20240325-faucht-kiesel-82c6c35504b3@brauner>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 25.03.2024 11:34, Christian Brauner wrote:
> This causes visible changes for users that rely on ntfs3 to serve as an
> alternative for the legacy ntfs driver. Print statements such as this
> should probably be made conditional on a debug config option or similar.
>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Johan Hovold <johan@kernel.org>
> Link: https://lore.kernel.org/r/Zf2zPf5TO5oYt3I3@hovoldconsulting.com
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>   fs/ntfs3/inode.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index eb7a8c9fba01..8cc94a6a97ed 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -424,7 +424,6 @@ static struct inode *ntfs_read_mft(struct inode *inode,
>   
>   	if (names != le16_to_cpu(rec->hard_links)) {
>   		/* Correct minor error on the fly. Do not mark inode as dirty. */
> -		ntfs_inode_warn(inode, "Correct links count -> %u.", names);
>   		rec->hard_links = cpu_to_le16(names);
>   		ni->mi.dirty = true;
>   	}
Hello Christian, all,

The initial and true reason for multiple warnings is the disregard of 
short (DOS) names when counting hard links.

This patch should fixes this bug:
https://lore.kernel.org/ntfs3/0cb0b314-e4f6-40a2-9628-0fe7d905a676@paragon-software.com/T/#u

There is no longer a need to suppress the message itself.



