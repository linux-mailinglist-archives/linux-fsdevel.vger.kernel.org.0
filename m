Return-Path: <linux-fsdevel+bounces-75842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2A12Jiwee2msBQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 09:45:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5E7ADAC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 09:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 001B2301DEE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 08:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F00379961;
	Thu, 29 Jan 2026 08:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="bGXai3Ra"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF0235293C
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 08:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769676255; cv=pass; b=lRv3ZKJw+u+iv81qVcG++UyLnlSE6DK36LqRk2naPQVixd58Xui/Z+vQRQgatzgFbHCGmyzakaBE1H/olBKDZyemAC30geG2kqP/OxoQZOmu/0ZAK7smoj2jO+TO5PL7BayEEa0c4qlYb+ccx7lPbZ1Q+DLM4p4ecRzlBdg7Gy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769676255; c=relaxed/simple;
	bh=aNBF2tfc1d7N1rBEkGHPce+HjG2Uc3PNS9wxeknnHFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OnvEQ8u79nphglG2S0p22XfGhrgu/OJNgYtEUWgyCZXnI+jMwIbwbz3yKSfsR+pIvMxBeuXlSxvt1bEYf6rvrQwED/p36vOD/YAM9TSjfoQGjQxdC7uS/U7l+7j0GKJtyFCuQQ9Umb5RXyCj/LXlCzyDCXPFHpxJqjs18yzGZCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=bGXai3Ra; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-501488a12cbso7804891cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 00:44:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769676251; cv=none;
        d=google.com; s=arc-20240605;
        b=XkotLIxf8fKs36t7VeTfY8EaGwO7yMVNeu3Dftto9HHqITLYz7Ede8LTcHRLUKW6Xt
         Sf8sbdm7hgyIdo10XjC07tF2ebP4MmcZHRbmMuxXHrKPnQJNGzoXKjZYXJZ+EBWkzTRq
         rfTH0CjYsTYFzhNcmxKrWQkAlZBejHF8n8M22GfJuLH7WGpMyJFJYWxUUZ4AKoozeLHZ
         3iXJsycoCv8yMGD66D29ZmwfOhhJFYEWVbwbOPcnl4PsVjWTsYk+4Kl+VYEPyuhabYDx
         8ySybw3DCR9Tp0hi06kTCWzkTI17rf9nQ3AdhzL6TrqaoABgKz8Vho/0GN4te3KhVbZY
         YNYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Nmq4jeEyP1daRxqgd0+ar4RlYr0t2eY5PfXIJffiuBA=;
        fh=UFffeb6CkQDaphvZjAJV9jxq+7HyRvDpYkOu0ZKfItA=;
        b=VzVBCWsnlEFAqfFT2vx3MXZQChtzSrO5cZN92UcMPqQ4xdF61W4uYmPiMvSRHR6q1B
         n0R3g8+f3zceO9H94Tt2fKz6iqf+VC9q2gJnSuKpfjlsMBL62wiyUVFkHzcBocUC2qYS
         lPRJ3ijHtRssCi46MxCggb9q/WUrlC6gxilw5DGSjr7DDRIr2Dqqnqp+ol4LjTVNQKkS
         bx3ToREbd0wOY9DTh9Uf8DWWj8KpL1vcZ4sfYGzhuWz84VEp7r40rEUi9wQP66zjOmgQ
         zpjPbAM0Ry5N6vfAzllXiQUQnqGlXOWM3nj+8cQMxMRPvP7QamO4gIFlT/SKy+ZKcpfr
         fwAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1769676251; x=1770281051; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nmq4jeEyP1daRxqgd0+ar4RlYr0t2eY5PfXIJffiuBA=;
        b=bGXai3RaGJqADXtcnpgE5vlDWM3Qub8CaIFMI57kSnjEJ8SQg2fWHhqKMw8grHig5C
         kPM6FWakWtWRABwAcg4b64KmTcGhDOhIItd+U/POX7BNvj6rWqb9a16jjBrlOWfuXIDK
         uINhuhPf9XjsIG1EJjoG9NaIpqH9uQfrD52hE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769676251; x=1770281051;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nmq4jeEyP1daRxqgd0+ar4RlYr0t2eY5PfXIJffiuBA=;
        b=Um/SjW9coBPw+UY94BJeQNsOm00QrMxVmmttR0CMcDZQKmdWmqyr1wxzItHFmEVs4V
         GOe4QXI+tBYP29+ylgVP/bvbIrZL+C3kMTQUXSs35r/sNmCxSYMjSFhvmHlxrP3UP5t9
         I3c1grN5x6gPPL28avkwUR+62CaQ5MRHlEBRrMRJ73fg7Pvit88dLzVsw56Og+JueVEf
         rFNMPI+VxnH6P2weVxNIc9osP0KlGI+F1F8g58FZFS5qLRbFmfc4xPT/6qtTtK6K8kVy
         1GELn2myvKdAGIgGZi7W9xWJw4PZLsVKZimaEqoX7AJEBGQq4hpZz2lKV/SdroVIrfba
         Tzvg==
X-Forwarded-Encrypted: i=1; AJvYcCW3K7Gj0LEUPz0svqMPYua18MleRNF/Cksed+mUobHVlohA7fZQdB5SYwsMBzq2vk2MO/WM1KpCGzPqNpRn@vger.kernel.org
X-Gm-Message-State: AOJu0YwSQohIGTo4SI7ypcBrnI6O3Bg5tasViSS6VyCPUs6NfGD0rba/
	+pRu4rTyYUagsvN77VwRPu2oUIfmuuSS0aF0FYkEVC3KyE3ZUgMjBPZaC4Gyq8mcood29krxe1W
	rG/j/BEQPS8BlO0lsca/Sxqp2je3MpJ/r2HVbpbh0Fw==
X-Gm-Gg: AZuq6aLwT27i/fA3Rz3s8Mz8SBpNLMu1MWSikELkfKvk81jSTYu39CwEZ6uOhoz+wml
	DG1LuXnP/ILA+aeKJgQ0dEXiXNMwOObFmcULYvtITAtX14FPfb6GRUuNX/68v8fv9H5X3XKBEc3
	wJl0l8KIk/YfJEHZyFaHF0smNQ48S74NBdrbCEN1KUMS3yRbnGZNWHqH8nEUgxhPV73tabgltsf
	rBL0AIAV/88ay3qE+hs7s3KLzK23S51Le5JFf0Z0ar2jUlP78MSsvzfRZmRdrgeGwScsQb+/8SP
	a6VCvA==
X-Received: by 2002:ac8:5f93:0:b0:4e8:baad:9875 with SMTP id
 d75a77b69052e-5032f7703f0mr103157531cf.4.1769676251543; Thu, 29 Jan 2026
 00:44:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128132406.23768-1-amir73il@gmail.com> <20260128132406.23768-2-amir73il@gmail.com>
In-Reply-To: <20260128132406.23768-2-amir73il@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 29 Jan 2026 09:44:00 +0100
X-Gm-Features: AZwV_QhTORoCIcikGWuj-UN4jliOmcUObBb7dF7LwnNwDRty0uXM6TNS_9tay2Q
Message-ID: <CAJfpegu8owOkpyNkcKHbz-eQWLWhrSE06hY2b-kQqSPq7gbH_Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] ovl: Fix uninit-value in ovl_fill_real
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Qing Wang <wangqing7171@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	syzbot+d130f98b2c265fae5297@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75842-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_RCPT(0.00)[linux-fsdevel,d130f98b2c265fae5297];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,szeredi.hu:dkim,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 1F5E7ADAC0
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 at 14:24, Amir Goldstein <amir73il@gmail.com> wrote:
>
> From: Qing Wang <wangqing7171@gmail.com>
>
> Syzbot reported a KMSAN uninit-value issue in ovl_fill_real.
>
> This iusse's call chain is:
> __do_sys_getdents64()
>     -> iterate_dir()
>         ...
>             -> ext4_readdir()
>                 -> fscrypt_fname_alloc_buffer() // alloc
>                 -> fscrypt_fname_disk_to_usr // write without tail '\0'
>                 -> dir_emit()
>                     -> ovl_fill_real() // read by strcmp()
>
> The string is used to store the decrypted directory entry name for an
> encrypted inode. As shown in the call chain, fscrypt_fname_disk_to_usr()
> write it without null-terminate. However, ovl_fill_real() uses strcmp() to
> compare the name against "..", which assumes a null-terminated string and
> may trigger a KMSAN uninit-value warning when the buffer tail contains
> uninit data.
>
> Reported-by: syzbot+d130f98b2c265fae5297@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d130f98b2c265fae5297
> Fixes: 4edb83bb1041 ("ovl: constant d_ino for non-merge dirs")

Cc: stable@vger.kernel.org
Acked-by: Miklos Szeredi <mszeredi@redhat.com>

Thanks,
Miklos

