Return-Path: <linux-fsdevel+bounces-76399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qM97IAB/hGl/3AMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 12:29:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E7BF1DE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 12:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EB5230467EB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 11:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BCB3AE6E1;
	Thu,  5 Feb 2026 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="OqWZXLFP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2212BFC85
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770290843; cv=pass; b=dHrzP6gzSSUF/kZoFWvWxFjmfWj6O9xfri5gZxBvCQ0AIhC6f/sFvS6Txlyc0OTZhvLVzMPEZbyaVMjKuJvGVmG6r0/REyyo1fuGKGoY95q5d2fRQyd/IsBGzLYy9OJGYLDLqrMo/PnIOHeqMYUiAWEtEwh9uIetWk/AaG7OTAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770290843; c=relaxed/simple;
	bh=VMZ7gH803ReScbBjYHJOeIUb0hkAuWgyGar2xBFxBZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0WJKdmMJ+Fhcs9sg1hExulWQpa+o7vrhZ9HwYb0kcB95ALHXIYAfn1H/OhZveuw3CNVsMJybGYtoKkeoYGVRExQ3DT4VLsemp+Om9EehHwYopV+tHgnQpQS0z/eSSbLlFqCIH+P2aFivlOkRyf0mheZ499vNu3vk45umCu+s80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=OqWZXLFP; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59b9fee282dso685097e87.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 03:27:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770290841; cv=none;
        d=google.com; s=arc-20240605;
        b=Dijob1IVvSNABMyS2uWtwS8Ue2o1C3YAKty3lb671ruxfGMBzGeL9Z/4oO2a5WLeWR
         rVLegoJ36eMHJ4MTEBMQjAD6X+BIAcYa7k015cxdGPMpGdkfJPj/KG5qmYfU3IsNc0g2
         WfRcpc5hSFdPnYwV8ELSdeeNZJx9xUrUirtwjBeiHpFpGhIP750SqroUS3ktz2ANC21C
         MUbCS/M6MqTJkwsx7SIrNV/wGrD1nQQiDKKyDUERD4XQdlXZhPW9nq8hjMpoLgkmWOvh
         Ddvkf9oz8LC4Mj0UkPHqPeU9xLebzA8MlT8iRkzTv3sc0vmjMsfX4MwS9+a3QdYGS/hu
         vRpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wB2O+cKVYBqmoEW7vQIPmoD4iADQ3byabRucTrKUGwg=;
        fh=L9eTZH7WM52H5b3nh1bIMDB3/Prn6zEtkbyEjYCneVg=;
        b=TkFLMgLT+uCULdb6NCIbSG+99hVlqo5dZSAP814RYy9DDxI1WVe0Pk0Ik0vnmTUbNS
         y1oQu7w8DfH/AT9H6sBkbi8Jc0oladaDig0WMRTP7HLgu24haXFsiKlnF93WbiRHtlzZ
         yLzSgIXhvzQj7OI/DMaSVyvVRjy1YXPlk37omTbqZRuOv2ebdzw1x4UvdUGZi+BIhmbv
         ta3XLw6Zs5WOoq86k6u6lfsr2qTbnCW6pWuaMLDHKdeAdX1ZO8G3jEwssUpWysn1zw8c
         bQs97EvLgyY5fdZuIvKyCxK1Fk6weu0gEUjc/LBBP/1e4+PqAqXJ/rwvM7KTvANJxdrG
         Fa3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1770290841; x=1770895641; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wB2O+cKVYBqmoEW7vQIPmoD4iADQ3byabRucTrKUGwg=;
        b=OqWZXLFPFuARHuoSt59LjiR8Zve6+DbrQSCRSqZRuiQNEGGciWQ9T+5uXLjPflIjoI
         MhLMPuewBpdBnm0GRvmv4uKDk8/N3wQmGWbcqBjLMIVuqm6BzO7it0rs8hZ3vbtLduWU
         ZgkC+cDuD4FDu4INE972C29qf8xqsG47SdIhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770290841; x=1770895641;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wB2O+cKVYBqmoEW7vQIPmoD4iADQ3byabRucTrKUGwg=;
        b=Mq4NWZbggOA+8MQDckmXPySYV8VJV/MgGtvhNXr9yhRV+HOfNA+AeCZEkPIBaGGwUj
         Z/f3sSwwc1C/WMnBLFdaTDskuZ4DsIqsBlGPqy/tWohCb73BRqO/4a+1cJ9rfAE1S5YM
         Yh5L04uKKiogfhvA4Cs+pS8CYdO9kimxRziJYBXYoyuy0m8HrfHlRZKL3arym1o9tk98
         JfbQTK+PE3pUED81lhEmT9izRDTec6kKyg7zMgRPMD7Wrxie06cqpszfwmil508H6wsM
         g1bljMWwg1Fqktex5bZIGHWU3CWpnE4Z3e9WdX/MpOXjzbiKnRMtcqZjFMrBXRDq6KO3
         NYuw==
X-Forwarded-Encrypted: i=1; AJvYcCUEvKCWdpJSAgIeSB6YC5ctRMvEX6HIrCMgehoYCNwgcEXTGbHopJa496mqDMhZB5pYlfrSN2Od5GrJAZ4z@vger.kernel.org
X-Gm-Message-State: AOJu0Yw988E2CdxNjYec9A52CZ2VwJHSTB1CJPkcvwSEhtvMB87piBKs
	We6c3lOAafP3S1u68E7pfnHCdJvHBGMBSXkYJJv+Ek0au5DaZHpkPlAuwm2Bn0fld6/zrM+l4uq
	Mbxd7Rr5X807PSe1MmTxZQsqdAbwxdFjZNE9JmtVPCw==
X-Gm-Gg: AZuq6aI7abvEYtNi6J/qRG6/EKzoThqxKgnoCQQf0SbQDRmnxulCDoaRQPm9lhqYKGH
	wo0HgdeHLjOp73f3qJDZ0E+Vgg5UlENh5cqHCwL/bYGR3ex8jeD67mvZf+D5biDWN7A94c21Cqn
	K+YkSIlWz5QKEluU2aBJPJ0pTNKj1UEOcCnFR40iIYKIoE9/K5w5EG8fwFpn8NpwcfKkWhoujj5
	pw7FC/gI1rdyoeNeFXiEaiZWbsZd5ByUjQFH+axpnr1Yf/F+8/0mHPybQD6S8PkF7gUHZ7JYtm2
	3xnNIPbP9s9llXJ78lOvKnjEBV0=
X-Received: by 2002:a05:6512:3e27:b0:59e:9b0:165c with SMTP id
 2adb3069b0e04-59e38c4a4cbmr2386140e87.43.1770290840891; Thu, 05 Feb 2026
 03:27:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205104541.171034-1-alexander@mihalicyn.com> <4502642b48f31719673001628df90526071649bc4555c5432d88d2212db3f925@mail.kernel.org>
In-Reply-To: <4502642b48f31719673001628df90526071649bc4555c5432d88d2212db3f925@mail.kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 5 Feb 2026 12:27:09 +0100
X-Gm-Features: AZwV_Qi3EfgySmXpzaYg6pmJ3PxLGQMqI9MaiDB1obuVcZkBWW47mj52bZU7S8Y
Message-ID: <CAJqdLrqRBhmrQQA0MA9f5Js6rTZkJFf6-=KT+eZahakgX4_3fw@mail.gmail.com>
Subject: Re: [PATCH] bpf: use FS_USERNS_DELEGATABLE for bpffs
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, jlayton@kernel.org, 
	brauner@kernel.org, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, aleksandr.mikhalitsyn@futurfusion.io, 
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[mihalicyn.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mihalicyn.com:s=mihalicyn];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76399-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,vger.kernel.org,futurfusion.io,meta.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander@mihalicyn.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[mihalicyn.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel,bpf-ci];
	RCPT_COUNT_TWELVE(0.00)[22];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mihalicyn.com:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 23E7BF1DE7
X-Rspamd-Action: no action

Am Do., 5. Feb. 2026 um 12:20 Uhr schrieb <bot+bpf-ci@kernel.org>:
>
> > diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> > index 005ea3a2c..c350857b2 100644
>
> [ ... ]
>
> > @@ -1077,7 +1073,7 @@ static struct file_system_type bpf_fs_type = {
> >       .init_fs_context = bpf_init_fs_context,
> >       .parameters     = bpf_fs_parameters,
> >       .kill_sb        = bpf_kill_super,
> > -     .fs_flags       = FS_USERNS_MOUNT,
> > +     .fs_flags       = FS_USERNS_DELEGATABLE,
> >  };
>
> FS_USERNS_DELEGATABLE does not appear to be defined anywhere in the kernel
> tree. A search of include/linux/fs.h shows only FS_USERNS_MOUNT is defined
> (at line 2268), not FS_USERNS_DELEGATABLE.
>
> The commit message states this flag was "recently introduced", but it is not
> present in this codebase. Will this cause a build failure due to an undefined
> identifier?

Yeah, this should be applied on top of
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs-7.0.misc&id=269c46e936f3b5f2b6b567ca124d5f5ea07a371c
in vfs/vfs-7.0.misc I think.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21708956860
>
> AI-authorship-score: low
> AI-authorship-explanation: The commit follows standard kernel contribution patterns with natural language and proper references, suggesting human authorship, though the undefined flag error could indicate incomplete context.
> issues-found: 1
> issue-severity-score: high
> issue-severity-explanation: The commit uses FS_USERNS_DELEGATABLE which is not defined in the kernel, causing a build failure that prevents kernel compilation.

