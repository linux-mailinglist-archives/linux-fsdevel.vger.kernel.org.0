Return-Path: <linux-fsdevel+bounces-2436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF0C7E5F0B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 21:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59E82811DA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 20:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D790337173;
	Wed,  8 Nov 2023 20:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="KaaFW83v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E4A3715B;
	Wed,  8 Nov 2023 20:19:29 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794EE2126;
	Wed,  8 Nov 2023 12:19:29 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 28E6940E014B;
	Wed,  8 Nov 2023 20:19:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id s5bZ6vUXjwC1; Wed,  8 Nov 2023 20:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1699474764; bh=p3oNlV39zW+VkL07Q/wVe7gatTo8JHkNdexu2jQ6/hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KaaFW83vgNee41ulVZxpEViUksXxIlY5aDDMYQRhwTFo+0WzrIyKqsnHhW7fs+PKe
	 lu2Mm3p9D1fQaFMLcPhsXhk9mksRX34/yj27ov71NrfDbYlJNsxdX5GwzUyLEj5Ih9
	 w1UdfcrLxCvLzeSTV7gyozY2LIg5d2+xMg16mgxdO3ZKZwL/QuX7UwUHokNkIw3qaT
	 yyds7aWs+vhOwC5CxgFz4/CDsdUt7BYNqj0letNrkktNL6fSUrRb+kDZppHvLV0/UK
	 mEB/efv3OP/30SH7OhkQjBcxVHJ0xAe4g+PjhnSxKPAdfTg+VXDPnTbx6r0OpnkoMF
	 /arK6Nc5L+THFi+wNAaHAJp4q4IOUR2zoWpcD9b8AtqphVcfWO0kIM2swyv/9jM3qF
	 InZVaXEUMoK+6yWK71vnoHGew2wk1Mb3U5za/UYewnd6FOcgLqogROjhIUv2Xjdby6
	 0f+gFtDc1amRnRzsXO08xbKlx2tMdv8pzC/MCOCLOu1S1aNoqdjTl5d9k/Y3v1BIj3
	 np31c5Nvzp7Cdk6qRAU+N0hLduMJUxFeRQ9f8hf40v1G7Aip1JwoJQmLlqOT2B55np
	 6cuN6BOE2QK6eKwFk8fehDWDEmKg84vtsBsOuXiJIUiwTrqzKLagUqgVPqNobZB2GU
	 azPoapBxqnSmgpobzmpPw27Y=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EFB0440E0031;
	Wed,  8 Nov 2023 20:19:11 +0000 (UTC)
Date: Wed, 8 Nov 2023 21:19:05 +0100
From: Borislav Petkov <bp@alien8.de>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
	james.morse@arm.com, tony.luck@intel.com,
	gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, alexey.kardashevskiy@amd.com,
	yazen.ghannam@amd.com, avadnaik@amd.com
Subject: Re: [RESEND v5 1/4] ACPI: APEI: EINJ: Refactor
 available_error_type_show()
Message-ID: <20231108201905.GCZUvtOSDkVqFPBmfk@fat_crate.local>
References: <20231107213647.1405493-1-avadhut.naik@amd.com>
 <20231107213647.1405493-2-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231107213647.1405493-2-avadhut.naik@amd.com>

On Tue, Nov 07, 2023 at 03:36:44PM -0600, Avadhut Naik wrote:
> +static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
> +	{BIT(0), "Processor Correctable"},
> +	{BIT(1), "Processor Uncorrectable non-fatal"},
> +	{BIT(2), "Processor Uncorrectable fatal"},
> +	{BIT(3), "Memory Correctable"},
> +	{BIT(4), "Memory Uncorrectable non-fatal"},
> +	{BIT(5), "Memory Uncorrectable fatal"},
> +	{BIT(6), "PCI Express Correctable"},
> +	{BIT(7), "PCI Express Uncorrectable non-fatal"},
> +	{BIT(8), "PCI Express Uncorrectable fatal"},
> +	{BIT(9), "Platform Correctable"},
> +	{BIT(10), "Platform Uncorrectable non-fatal"},
> +	{BIT(11), "Platform Uncorrectable fatal"},
> +	{BIT(12), "CXL.cache Protocol Correctable"},
> +	{BIT(13), "CXL.cache Protocol Uncorrectable non-fatal"},
> +	{BIT(14), "CXL.cache Protocol Uncorrectable fatal"},
> +	{BIT(15), "CXL.mem Protocol Correctable"},
> +	{BIT(16), "CXL.mem Protocol Uncorrectable non-fatal"},
> +	{BIT(17), "CXL.mem Protocol Uncorrectable fatal"},

Might as well put spaces between the '{' and '}' brackets for better
readability.

>  static int available_error_type_show(struct seq_file *m, void *v)
> @@ -607,8 +607,9 @@ static int available_error_type_show(struct seq_file *m, void *v)
>  	if (rc)
>  		return rc;
>  	for (int pos = 0; pos < ARRAY_SIZE(einj_error_type_string); pos++)
> -		if (available_error_type & BIT(pos))
> -			seq_puts(m, einj_error_type_string[pos]);
> +		if (available_error_type & einj_error_type_string[pos].mask)

Call that variable simply "error_type". Those are simple functions, one
can see that it is the available error type.

> +			seq_printf(m, "0x%08x\t%s\n", einj_error_type_string[pos].mask,
> +				   einj_error_type_string[pos].str);
>  
>  	return 0;

But those are just nitpicks.

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

