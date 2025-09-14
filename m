Return-Path: <linux-fsdevel+bounces-61246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19052B56780
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 12:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B7E27AF628
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 10:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAF323F42D;
	Sun, 14 Sep 2025 10:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGhVWy4h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF7D2367CE;
	Sun, 14 Sep 2025 10:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757844399; cv=none; b=U10IkLk32jlXqGWB8kIeTkJlaEUiZOW7Hm6YjLIut3Oi8j3V/X5Kq+pWh+2LDMPqq3+/mcepabrqZBPhvJq727vxmBtYku0K8XrgK8Th7K4BFD9Nc1RGMFP2SLNTqLppaD6XNmpCcbcC7FS0UZKAfKv2M7peq8wWdEhRo7qBGhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757844399; c=relaxed/simple;
	bh=sAkxjJJfEShLrXBVvUbe5Nbuot2UFPkdNXybwJxcBYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nWq5ftAsqD07HZlujyPjUwHrWIpZLZzINE3spy5tybyUwAbONLL0o3N1oCGfB+G3FgcxT9fiNa7vTkbE01/T45MSlHOd1RJqcgldkPhqSE9PRud1lIiXd2cLQQ6/8na09PAtQEQc8+59MhMSIOzht2LCHlhXo96BfzKA9tnWJbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGhVWy4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4082AC4CEF0;
	Sun, 14 Sep 2025 10:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757844399;
	bh=sAkxjJJfEShLrXBVvUbe5Nbuot2UFPkdNXybwJxcBYY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hGhVWy4h/gu84b8AUY5CAxhBjA4oE+f4FI8q2AbORfRl5Mzbjbj6lhOkyStQ0oi9M
	 W8QoYlTDAMmDvzc22PRN4vIf6UvnWIEgHfPK3nbIaO6+Bgc4ot987GJoAgiZ4Qoss+
	 dxJ+3IkBSVZOwu+N2Z4n4dxeuzzil+8fSxn4vpD6k3VBKvJUfWYkKTYv+ULvYtpxSe
	 ARcPnImrypfujumW2c+Tkx9maY07yERhC6rWJz/fkMGgSqGvpdn/rBYS9IbwIOKyKB
	 hvuk4ypNdLPnSksQeCF7GqwSkxro5/n9s5UJO1kqWTpzV4Z4DDYeQc9CzvLJ70Fc+A
	 sMyziae1DQ/+A==
Message-ID: <a079375f-38c2-4f38-b2be-57737084fde8@kernel.org>
Date: Sun, 14 Sep 2025 12:06:24 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 21/62] init: remove all mentions of root=/dev/ram*
To: Askar Safin <safinaskar@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Aleksa Sarai <cyphar@cyphar.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Julian Stecklina <julian.stecklina@cyberus-technology.de>,
 Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Eric Curtin <ecurtin@redhat.com>,
 Alexander Graf <graf@amazon.com>, Rob Landley <rob@landley.net>,
 Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org,
 initramfs@vger.kernel.org, linux-api@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-ext4@vger.kernel.org, "Theodore Y . Ts'o" <tytso@mit.edu>,
 linux-acpi@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
 devicetree@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
 Kees Cook <kees@kernel.org>, Thorsten Blum <thorsten.blum@linux.dev>,
 Heiko Carstens <hca@linux.ibm.com>, patches@lists.linux.dev
References: <20250913003842.41944-1-safinaskar@gmail.com>
 <20250913003842.41944-22-safinaskar@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250913003842.41944-22-safinaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/09/2025 02:38, Askar Safin wrote:
> Initrd support is removed, so root=/dev/ram* is never correct

For all your other patches (here is correct):

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597


> 
> Signed-off-by: Askar Safin <safinaskar@gmail.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt          | 3 +--
>  Documentation/arch/m68k/kernel-options.rst               | 9 ++-------
>  arch/arm/boot/dts/arm/integratorap.dts                   | 2 +-
>  arch/arm/boot/dts/arm/integratorcp.dts                   | 2 +-
>  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-cmm.dts     | 2 +-
>  .../boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dts    | 2 +-
>  .../arm/boot/dts/aspeed/aspeed-bmc-facebook-minipack.dts | 2 +-
>  .../arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge100.dts | 2 +-
>  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge40.dts | 2 +-
>  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yamp.dts    | 2 +-
>  .../boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi  | 2 +-

No, don't do that. DTS is always separate. Don't mix DTS into such huge
patchbom, either.

>  arch/arm/boot/dts/hisilicon/hi3620-hi4511.dts            | 2 +-
>  .../boot/dts/intel/ixp/intel-ixp42x-welltech-epbx100.dts | 2 +-
>  arch/arm/boot/dts/nspire/nspire-classic.dtsi             | 2 +-
>  arch/arm/boot/dts/nspire/nspire-cx.dts                   | 2 +-
>  arch/arm/boot/dts/samsung/exynos4210-origen.dts          | 2 +-
>  arch/arm/boot/dts/samsung/exynos4210-smdkv310.dts        | 2 +-
>  arch/arm/boot/dts/samsung/exynos4412-smdk4412.dts        | 2 +-
>  arch/arm/boot/dts/samsung/exynos5250-smdk5250.dts        | 2 +-
>  arch/arm/boot/dts/st/ste-nomadik-nhk15.dts               | 2 +-
>  arch/arm/boot/dts/st/ste-nomadik-s8815.dts               | 2 +-
>  arch/arm/boot/dts/st/stm32429i-eval.dts                  | 2 +-
>  arch/arm/boot/dts/st/stm32746g-eval.dts                  | 2 +-
>  arch/arm/boot/dts/st/stm32f429-disco.dts                 | 2 +-
>  arch/arm/boot/dts/st/stm32f469-disco.dts                 | 2 +-
>  arch/arm/boot/dts/st/stm32f746-disco.dts                 | 2 +-
>  arch/arm/boot/dts/st/stm32f769-disco.dts                 | 2 +-
>  arch/arm/boot/dts/st/stm32h743i-disco.dts                | 2 +-
>  arch/arm/boot/dts/st/stm32h743i-eval.dts                 | 2 +-
>  arch/arm/boot/dts/st/stm32h747i-disco.dts                | 2 +-
>  arch/arm/boot/dts/st/stm32h750i-art-pi.dts               | 2 +-
>  arch/arm/configs/assabet_defconfig                       | 2 +-
>  arch/arm/configs/at91_dt_defconfig                       | 2 +-
>  arch/arm/configs/exynos_defconfig                        | 2 +-

To me your patchset is way too big bomb, too difficult to review. You
touch too many subsystems in the same commits. In few cases I saw
dependency, in other cases like here - there is no dependency! So why
grouping independent things together? It only makes it difficult to review.

Anyway, combining here DTS is a no-go for me.

Best regards,
Krzysztof

