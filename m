Return-Path: <linux-fsdevel+bounces-2890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E9A7EC25A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 13:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F25C281516
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 12:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E90A18B0C;
	Wed, 15 Nov 2023 12:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="COo4qct5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5207156F3;
	Wed, 15 Nov 2023 12:34:17 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC5BC7;
	Wed, 15 Nov 2023 04:34:16 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 00CDF40E0030;
	Wed, 15 Nov 2023 12:34:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JAL49dTD3Lvc; Wed, 15 Nov 2023 12:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1700051651; bh=KifOVDlMp/2ycw5mH0oTXzCLORPNzCMwO+1bbYkzOw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=COo4qct5KW0h1D+oINnaVz0DL8zmHPebfPPBxZnUP8cJkXf+aI6O6eBk+RXi1bcR8
	 ZdLJHxKAJHQbzr70NhHkXe7dleR8epuhN7JUzA0s1xfBrNlga8ETET4qiSg+ONHDEC
	 zCdnB99unmXHLxSydJoE8kROe7B05Sv2yL9cFrD5MV9N3hHLkgk7+tZYw/CtClepRy
	 y4FQ/5ryU/7dsrAa2V2a6OKtkEpDkR08TPeCLHfC3pjkqFFtlqumroytPWKRebPkH5
	 wBDv0JjoRXfGgHzJHveMc4lb5DD8v0kpbouuPWzh1mpmQencCGhBr/MldZDofX8D2i
	 4YCCUH9zfgl5iqyfH53SLYLJeb9S63KRqKhfCLMHemNUlNl3b9caXqahvn2DaTgcYv
	 Jhnooza2EpX07rCqCWwQaRtnvcZiIpPCiYhcBjAYuFM4uSCx+M7B+8sRVtzlDhPjR8
	 r46NlZGyL+bpMtmEscKRQkz7JRFnM6DH4jSQE6bMJpB1bnpI3bSEEAnD7yJ3d6O3vf
	 mHLOaBKASztaJnxFYTVkJjGf7d/H4uwcB+rUNVFgyQhhfsw5KjH/88VqXUgj7tejnj
	 C2Q2LXt9Of0BO8lY8XiAUlrzR+MLjc1XH0GoRnAD8Nt72bI0Wx3c56ICCywKvvTsnJ
	 cTbaK/x/EqjIiQdeBhOFOYNE=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CF20140E0032;
	Wed, 15 Nov 2023 12:33:58 +0000 (UTC)
Date: Wed, 15 Nov 2023 13:33:54 +0100
From: Borislav Petkov <bp@alien8.de>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
	james.morse@arm.com, tony.luck@intel.com,
	gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, alexey.kardashevskiy@amd.com,
	yazen.ghannam@amd.com, avadnaik@amd.com
Subject: Re: [RESEND v5 4/4] ACPI: APEI: EINJ: Add support for vendor defined
 error types
Message-ID: <20231115123354.GDZVS6suUf0ZIVqlh6@fat_crate.local>
References: <20231107213647.1405493-1-avadhut.naik@amd.com>
 <20231107213647.1405493-5-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231107213647.1405493-5-avadhut.naik@amd.com>

On Tue, Nov 07, 2023 at 03:36:47PM -0600, Avadhut Naik wrote:
> From: Avadhut Naik <Avadhut.Naik@amd.com>
> 
> Vendor-Defined Error types are supported by the platform apart from
> standard error types if bit 31 is set in the output of GET_ERROR_TYPE
> Error Injection Action.[1] While the errors themselves and the length
> of their associated "OEM Defined data structure" might vary between
> vendors, the physical address of this structure can be computed through
> vendor_extension and length fields of "SET_ERROR_TYPE_WITH_ADDRESS" and
> "Vendor Error Type Extension" Structures respectively.[2][3]
> 
> Currently, however, the einj module only computes the physical address of
> Vendor Error Type Extension Structure. Neither does it compute the physical
> address of OEM Defined structure nor does it establish the memory mapping
> required for injecting Vendor-defined errors. Consequently, userspace
> tools have to establish the very mapping through /dev/mem, nopat kernel
> parameter and system calls like mmap/munmap initially before injecting
> Vendor-defined errors.
> 
> Circumvent the issue by computing the physical address of OEM Defined data
> structure and establishing the required mapping with the structure. Create
> a new file "oem_error", if the system supports Vendor-defined errors, to
> export this mapping, through debugfs_create_blob(). Userspace tools can
> then populate their respective OEM Defined structure instances and just
> write to the file as part of injecting Vendor-defined Errors. Similarly,
> the tools can also read from the file if the system firmware provides some
> information through the OEM defined structure after error injection.
> 
> [1] ACPI specification 6.5, section 18.6.4
> [2] ACPI specification 6.5, Table 18.31
> [3] ACPI specification 6.5, Table 18.32
> 
> Suggested-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
> ---
>  drivers/acpi/apei/einj.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

