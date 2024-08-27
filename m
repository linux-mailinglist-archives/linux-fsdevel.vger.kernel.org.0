Return-Path: <linux-fsdevel+bounces-27324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CD39603F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 10:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3CB9B216AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 08:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A920194085;
	Tue, 27 Aug 2024 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shakik.de header.i=@shakik.de header.b="gLleTIEc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.shakik.de (box.shakik.de [116.203.140.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C3D156C49;
	Tue, 27 Aug 2024 08:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.140.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745986; cv=none; b=EswHNHQb8HuJdHbzTEOlv5/MizK6PcSMNh1Ydjck0/tZ8UhaGKzVcfNhOyxjjw2rc7YQEBBza01+3wnS91XTpHDjBFg32zwxst4XmF60Jy3ED6CLRzkCZEUHx7qQE+XOK9ZMt35bpCwNtbP9W20DwT2z7+ly0f0b5PEYaH5MdLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745986; c=relaxed/simple;
	bh=x5Pj9oSF8F7SMFZouWhZwab6mt9d56x6IG0J66/C/GI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JthilAirBOQaDwgqfBHt1s0S561JuELvHi1Y/qsXBAAV5MHqZh6EsL2x2K639sKfzERj7Uc8JUO05V+BeLPuRSfI7bXCqj+WJILYovy0sogtgeVCrgNKzrIHSbubMdE+1yZ0ye5z0NVy/+r2iS3ydrXzh1bhzNl+bKfExMxZOjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=shakik.de; spf=pass smtp.mailfrom=shakik.de; dkim=pass (2048-bit key) header.d=shakik.de header.i=@shakik.de header.b=gLleTIEc; arc=none smtp.client-ip=116.203.140.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=shakik.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shakik.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shakik.de; s=mail;
	t=1724745477; bh=x5Pj9oSF8F7SMFZouWhZwab6mt9d56x6IG0J66/C/GI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=gLleTIEcM06lwZsH1d9ngCYDgO5dum05PjaXU6RATH3Tl91W4r5fDcUcemNutW+Sy
	 zM141PD+9Dch5rXEHO4cjiSacpt4X6n9Cfc3iwrTStKKf4v7jLIqljcd099iRGTLrs
	 3O0HxKAMKimWYfT+wyOLIdkthhVeDwoEBiGD0RLmakQXhlvfUe8F0w7O6XJOZ9KvwB
	 rNqKOave/r32iMtjEoAi/Sr14VcXOw/lTKulyA7cX24v4CC3UNGpSAoDyOTLENeXbr
	 3kiuZVGTwAmofXjZuB/oemb1wjGLMFAz6uyJ7Qa/bC+ipxwW7ZqPROQ3z8GsmQagFp
	 8AwxeIF1hUEpQ==
Received: from authenticated-user (box.shakik.de [116.203.140.107])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by box.shakik.de (Postfix) with ESMTPSA id AC5743EAD2;
	Tue, 27 Aug 2024 09:57:57 +0200 (CEST)
Message-ID: <706de714-9293-4d8c-b2bf-f91b87adc313@shakik.de>
Date: Tue, 27 Aug 2024 09:57:56 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: bcachefs dropped writes with lockless buffered io path,
 COMPACTION/MIGRATION=y
To: Kent Overstreet <kent.overstreet@linux.dev>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-bcachefs@vger.kernel.org
References: <ieb2nptxxk2apxfijk3qcjoxlz5uitsl5jn6tigunjmuqmkrwm@le74h3edr6oy>
Content-Language: de-DE
From: clonejo <clonejo@shakik.de>
Autocrypt: addr=clonejo@shakik.de; keydata=
 xjMEW66ldBYJKwYBBAHaRw8BAQdAbHC49tBmtjX3w64VrV7Re1J7jyWzI6TV4ABU1KAv3ETN
 G2Nsb25lam8gPGNsb25lam9Ac2hha2lrLmRlPsKWBBMWCAA+AhsDBQsJCAcCBhUKCQgLAgQW
 AgMBAh4BAheAFiEE6nsRNRhMkT4iIivMeOyFQfuclLEFAmV/Y+gFCQ2TJXAACgkQeOyFQfuc
 lLEkWQD/Wd6Bx5JlJDuMximEa8ieyPjbOt+9OI5AGXsThFFlJyAA/3X2hY4v1iGeHYB2oKXZ
 jYM/S6uuF+3t9OiN1ld2Tn0AzjgEW66ldBIKKwYBBAGXVQEFAQEHQPEGZ6WBh4zAwJ6thLpf
 q7G3/PcoqkQEAe1Kf2zRoJw2AwEIB8J+BBgWCAAmAhsMFiEE6nsRNRhMkT4iIivMeOyFQfuc
 lLEFAmV/Y/MFCQ2TJX8ACgkQeOyFQfuclLEy/gD7BXXW/1XXO9KPGzkrXfyMfk/x5E70Vumc
 kSNUnzof0TsBAMpr+/quFw0Rt9R5oUB/g+DvlQ/BOnIcwIvKKywg9TkP
In-Reply-To: <ieb2nptxxk2apxfijk3qcjoxlz5uitsl5jn6tigunjmuqmkrwm@le74h3edr6oy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/08/2024 05:29, Kent Overstreet wrote:
> Interestingly, it only triggers for QEMU - the test fails pretty
> consistently and we have a lot of nixos users, we'd notice (via nix
> store verifies) if the corruption was more widespread. We believe it
> only triggers with QEMU's snapshots mode (but don't quote me on that).

I have had this with 6.10.6 #1-NixOS (with nocow_lock patch added) _on 
bare hardware_, no qemu involved.

So far, i have seen it only on files in /var/lib/nixos, similar to 
https://github.com/NixOS/nixpkgs/issues/126971.

nix-store --verify --check-contents is still running, but no errors yet.

Also, copygc and rebalance block suspends for me, though the fs gets 
unmounted fine on shutdown.

Mount options:
> /dev/nvme0n1p2:/dev/sdc3:/dev/sdd2:/dev/sde3:/dev/sdb3:/dev/sda3 on / type bcachefs (rw,relatime,metadata_replicas=2,data_replicas=2,background_compression=zstd,metadata_target=ssd,foreground_target=ssd.tlc,background_target=hdd,promote_target=ssd)


