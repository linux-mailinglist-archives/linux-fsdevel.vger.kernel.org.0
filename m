Return-Path: <linux-fsdevel+bounces-79486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKzRFil9qWnl8wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 13:55:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BE32122B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 13:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FE60304B4FE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 12:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2028D372EE0;
	Thu,  5 Mar 2026 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjL+5i9y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45AE2417C3
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Mar 2026 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715202; cv=none; b=jrgw2i/2cdTRO30KCCkWfjtJX7S4aCPGttq05nmPWhPksuNDYrPwCBgKp54zlJNn5BLHuFXPmAjmdCPEbOsNL25Efpdl3NkLcz1B58NnoXDLu6JlRF8hmSWNVeBvMiOLKNTwfmtPu16T2QclxjSBx+9w057CBpwqxmtJRTNi4QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715202; c=relaxed/simple;
	bh=lt+sVXtr13h+xEkHDpHWUtQvm92jyk/gvfkLJu5XHZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DcewC2YhZQZhYVMyWBmvo+WpaRf+pzjUTjkPyD4O+iF3PCxnLKFKyg8QzVKgwpZyEdWku7xquuMhRJRmfWXgczMMOr0n1JgXUWq7ttmD6lwfKB1wbUPHf6vGPfiDpIkpPU5t354BgM9p3VDTA/E98BBj0j6/QZU2Dp8awC5wLBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjL+5i9y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3A4C2BC9E
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Mar 2026 12:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772715202;
	bh=lt+sVXtr13h+xEkHDpHWUtQvm92jyk/gvfkLJu5XHZg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MjL+5i9y6wq+lV69hRJQVKMYDwn1CEcZbz980MkPJt9NWNh5h9aOnwZX+W+DY83ej
	 0WV4Q/pUoYJpXXdyi07h+OU7wK3Z5D+B/lqTS8iQeKF+2XOXD+LY8SppIJhP5A2Uoq
	 QZ1kPyE2kC4vTl//ZQc4RnneMVQAmDuTqicE8lGPnr8/7U+ug3+SK4lj7YICFarAaV
	 BajebqfDYU5csdq3dQrx5pnlImTcFgM114IgyIdAnUqIU1yvunDP5BriYs2veu4xuZ
	 M1kjFzZxN9IoYq3IMCgB3RztdXaiTEBoJUOfh56JdiV2Dbo+l9HzjWLcaNn18/276Q
	 jRNGgjbWeKiJg==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65bfc858561so4988413a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Mar 2026 04:53:22 -0800 (PST)
X-Gm-Message-State: AOJu0Yy3V1m/afsFiImgnBcBPMYZLwbnkWCFBVj21JBSVpREs7aY25yM
	pcCPSJ2e8xHeRbb6g1HVtLPR0o2895yTpU0AiKjXCK+1LQTm1aUHKR0DrJNQHf2RVl2MvRxhdfJ
	nS+KrWjtg9WLj3sTN4ogX7IL91Zkg+14=
X-Received: by 2002:a17:907:d0e:b0:b8f:b222:34d with SMTP id
 a640c23a62f3a-b93f1160032mr378108266b.5.1772715200824; Thu, 05 Mar 2026
 04:53:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKYAXd_8vG6V0NRT_kb76n_yo+d9vvcx6JZbMARC5+C1ovboqw@mail.gmail.com>
 <20260304141713.533168-1-dxdt@dev.snart.me> <20260304141713.533168-2-dxdt@dev.snart.me>
In-Reply-To: <20260304141713.533168-2-dxdt@dev.snart.me>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 5 Mar 2026 21:53:08 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_RiCKF1nJK_Jg385VeGxeOUo08s0a_SNgtty2508wDmg@mail.gmail.com>
X-Gm-Features: AaiRm51E38GQm-fjbvQ3wwYaQ20TrUhCIJw0G7Q3bc2RfIPILeqXb4Kq5B-JvmA
Message-ID: <CAKYAXd_RiCKF1nJK_Jg385VeGxeOUo08s0a_SNgtty2508wDmg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] exfat: EXFAT_IOC_GET_VALID_DATA ioctl
To: David Timber <dxdt@dev.snart.me>
Cc: linux-fsdevel@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 62BE32122B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79486-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

> diff --git a/include/uapi/linux/exfat.h b/include/uapi/linux/exfat.h
> index 46d95b16fc4b..da65aef416cc 100644
> --- a/include/uapi/linux/exfat.h
> +++ b/include/uapi/linux/exfat.h
> @@ -12,7 +12,9 @@
>   * exfat-specific ioctl commands
>   */
>
> -#define EXFAT_IOC_SHUTDOWN _IOR('X', 125, __u32)
> +#define EXFAT_IOC_SHUTDOWN             _IOR('X', 125, __u32)
> +/* Get the current valid data length(VDL) of a file */
> +#define EXFAT_IOC_GET_VALID_DATA       _IOR('r', 0x14, __u64)
It uses 'r' (0x14), which is shared with the FAT-fs. However, since
VDL (Valid Data Length) is a specific feature of exFAT, using the 'r'
range might lead to potential conflicts with future FAT updates or
Android-specific extensions. What do you think about having its own
dedicated magic number (e.g., EXFAT_IOCTL_MAGIC : 0xEF) for
exFAT-specific extensions?

