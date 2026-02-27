Return-Path: <linux-fsdevel+bounces-78740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QL83I7a7oWmswAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:43:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 077361BA22E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 794CA31752C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE5043DA51;
	Fri, 27 Feb 2026 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gfNQjr/k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F4D43CEE9
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 15:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206490; cv=pass; b=XuEB8fnIyGGMKvpS4yGH95Y7YU0H7o7KH96tTNwIky2Zo45j8g5C+LPjmvOfa5gSPm9dQ4bGXs2nYx3dMeBshIKwfuZzXswS+vWW4Jf6n2yeMzRdSzJ+ebGQtm9Rkr6bUfIFwwuNjgynB0pnmanGcKVtJY3iRV4OB2EkmAw9AYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206490; c=relaxed/simple;
	bh=suqfaEcgAZrntyjq3ycHMFQA+8Hv+XKhnDLCv0g00kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EqXdxS1nS215Wo+TaFpPVOBH+yHw6zvVSVtqBDS8QCuGKd0W7ivAcVzCqJoPanZ4NaSZkryko1xBr0NAFPjsa+aDwMwJhHUy1JpNhITTIBPXqESsNWatuhleC5Kfd5VinY186N7htJ1OUwz6JQYAXobYuMqKeCTceefsBJGe3Us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=gfNQjr/k; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-506a3400f30so18929501cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 07:34:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772206488; cv=none;
        d=google.com; s=arc-20240605;
        b=dGqy4PPygHOjCjTxIiy2LPnVygZSK6iaoBG6yxcqIBwRLnX8NTx2JeolfVH4oPNE6W
         M6lZk8F3YAbUXPrj0MT8UEQxNYN1bQ3Jf9NC6z+MfJEv29fep/QGetKv8ttS9dkWGDUm
         3aktual4md2Czb6cyfi6YvjtJvz4neL7liSQSrpHK4GB/kQQTSk5LkeqIasXC53RhFEc
         dWh6E4A1FwVcyOab0g/grCwBOlkhkXH/NbGRRbAajMQzuAldn1fzREmAzspG5wzqA+we
         2TC6npmq+xvtmTCE/p0Y4CAM77GNy5uBA3L0dgFbKFeQHSK1r3lzQ1e/i+FG/oHcg/iv
         X/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=N7wVn5532g/w1wEPrem5YwBw+ywVcwRHRuGGZ7DwaHk=;
        fh=HiRe2iq5/zrlU2zS7FN7rZ3LrLrL3nyZWfKODYsTasw=;
        b=CLJRu69ME7RJMQcVRqBIOuk1SjVA7786RphTeSUKB6iI1vcA5auH97OJDUCe7PGjH1
         4LOW28qVaXUTj0SaZNu0P+WNPTgIfvllrc+6wUICZCBDQr1qo/buPYz7QW5o+yGRj3vx
         Acwmhb4RzX+17sqrKsNvAizuuAEqZfnsM0HB7Kmp5iA5RsvyEa7Xsu5p2k15z6hAGGxy
         LEABSK5tdlOdMTK61ZsXtW50PtwQe5UVbiOESLP2vTu2b4xV5yTmse9KrHAmyVLGGYFi
         DLbtGUTEUB3VQuZER4syQKagfNVmyrCjUGQSyHFt5lz3fci/2Fxiw7xLV7Pt+TfbOdqj
         Y6mA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1772206488; x=1772811288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N7wVn5532g/w1wEPrem5YwBw+ywVcwRHRuGGZ7DwaHk=;
        b=gfNQjr/kLZagnmtbUdUQTEBh/no6SMmHTci7TdWOecoSj0nGsxI5ms+8eIy+E5BeO2
         lF9IVDdKmL6IUl0mP6o4d/UKOFxPd7ewQQUOct3Zd3g9vY2H9nLYwl4eUbTtULyC9Zcq
         5DMQHiCemPjlkQ5dKXidwZHX0fm9zh3qIOnUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772206488; x=1772811288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7wVn5532g/w1wEPrem5YwBw+ywVcwRHRuGGZ7DwaHk=;
        b=a4tcON45JilzxWNrzPsZvNebT8m2dbsbgcZgUId4Y3dzkKjbqZfeOVoZGy0aZkHQ+V
         JWzCBCMtOFc9dIwGWBijMr80EY3gUU/ROnnTr9n1HbdV/GMnvWtpa5sOOA1KWLTO/mVd
         h3O3qnqC/zNWbruYFH5cfd5mID2+uu3yln/bVgnMbD2JR1ZwmtaSNuoZqmL4GZqwROjm
         e/SwoAphMZLVv4nLxTDxjiJwRSAio0Nb1bS5Wlb8Pr6m3DF4qxwmgPUxdkP4Vp5+xcgR
         qFx9yM+LogTU2cE+G5sMrJB1K3aOWVPrMbFzDBfNn2+G1ULtUA7rseDp4EeUufYvkaHq
         +cRw==
X-Gm-Message-State: AOJu0Yyam/lDqi2w+QRIjcEwnSy1k0Z2OQCcGtfclfeUg36TwjLZ2Ac+
	qnX0xtAQw2joBUnl9YSVfBtYsl/+hNdZdr8bU/d5sKzXR51GWwgbrVuZwAP+y/mwWmMCuNkM00b
	PZeerOhQF2jcRwjuB/QE4fuEtKN0hk4wy3a3SGnF9Cg==
X-Gm-Gg: ATEYQzzXo05lw/SeeWIIpp+/Wdda+c3p5KkywvNUDypKO6FfWrI7dcYn2TgDh/9mITM
	UkCLBrbyuGxJ7juiJF8uhnqaz879GhV94sEgG86IKibF7sGyr7ZVnHfJc6GbCXckCJKG8EJdieo
	Ap2e73MEjFtiXUOtSQVheT5HeXZQGeoj3nOfXT81RY1ThpYrXI3p0mlDzwF2kfoovnoVkttQJ7O
	A0wzqJrxb95RBYzNnEGrAVl4anTyr0brFRDiz5xGb7n5vDlvVkXofxaDdaBg5LX+0exEtSzEnxd
	24Fi2VY0ZTV0ErLj
X-Received: by 2002:ac8:59d3:0:b0:506:2048:36c9 with SMTP id
 d75a77b69052e-507522c1c0amr38958761cf.1.1772206487711; Fri, 27 Feb 2026
 07:34:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226125001.16287-1-zhangtianci.1997@bytedance.com>
In-Reply-To: <20260226125001.16287-1-zhangtianci.1997@bytedance.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 27 Feb 2026 16:34:36 +0100
X-Gm-Features: AaiRm50E3_J_FiL3x21Wm9OylcHGk1TP7mxbbeXfgxK53HEVx_NfC3vOaXNjj3Q
Message-ID: <CAJfpeguobO4UHmb1n+zQUMrSCH0FYh6DLAWNfGYNj29iX9Pxjg@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: send forget req when lookup outarg is invalid
To: Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bernd@bsbernd.com, Xie Yongji <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78740-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,szeredi.hu:dkim,bytedance.com:email]
X-Rspamd-Queue-Id: 077361BA22E
X-Rspamd-Action: no action

On Thu, 26 Feb 2026 at 13:50, Zhang Tianci
<zhangtianci.1997@bytedance.com> wrote:
>
> We shall send forget request if lookup/create/open success but returned
> outarg.attr is invalid, because FUSEdaemon had increase the lookup count

These are cases when the fuse daemon is broken anyway.  Keeping it
working does not make much sense, and adds complexity to the kernel.

So NAK unless there's a use case which explains why this would be a good thing.

Thanks,
Miklos

