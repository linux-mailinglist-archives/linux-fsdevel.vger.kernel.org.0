Return-Path: <linux-fsdevel+bounces-77747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPBPDq2Ll2n/0AIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 23:16:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A567B163169
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 23:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35BA430765D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 22:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E999329E7E;
	Thu, 19 Feb 2026 22:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gBWwAYZ0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B297F2DCC13
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 22:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771539275; cv=pass; b=JgzqAklsQxgTWqzyHWx+XXHkKE+Rt1NrugqpKOlZgQT2XYcdqy15/VH7jgiFQoBqyL8axe6+vkNEGRpuvQhwS3tmXvMTaThXs2eZhqADyleWNg/nk0CTP0xtyAH931s4faufYpc/uWtS+tCrfqys8EHXb2lFFdK9UCbLETsVn9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771539275; c=relaxed/simple;
	bh=JpGwHvT/3hhwHza/ym7K4teVN7Fl9ZYoYYQm9v2aG84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWDE9+Jx/BgnWuNYR+3aLbM4WCj9elF//xn3SJ8PLvX+BUJJhIy2XJqBhHo07YGOSO88EwbjDefZYZ+9LT5riSceUowBqs4RnwTw63D67k0vfGrAEtBmhSpPdudHxD299pFE6hxBr5W6gwynKQERRgH0Peh6ZZCyCSHc1ncTK2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gBWwAYZ0; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2aaf43014d0so10199075ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 14:14:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771539273; cv=none;
        d=google.com; s=arc-20240605;
        b=k+w3OEJzQOHrKlOWL/Bqc6WSwb0ynT4NKgcpHAqXTJwp09KJdhcsp4obiB7H8aopJf
         h0xQGwwLNIky7TWPQQVZwu3WLLvyvA0uOCNznV3YWZConmc2KVcWpmeoVldSAzFdd2bH
         EAlaTbhQCyL3ywtsAuniqpcdUSLmR7oTQIiDdWFl7qH3WqGmB4eq0lFr9gcGGRjq8kUp
         8oqYdOwBO4/Vk7LH2ziEKgLdkZt5mMSHFUyH0cm/TQZBUOjtbqkjnmuM6Ebu6AxBKAo9
         eXKNUI0znVV0VMok+j/8QjB4nZaQ4APyx8l4IEWqhRV89kH8Rf7Ghg8RW50XUHPhOT+P
         DxPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uuWksm/z64CkDA8wVi+HNFlxh1fV4OvGcIJUKwatE7Q=;
        fh=LbBq5LM5Hr2fZogQOn27aqzojfQl865QXWwp0jnrVVc=;
        b=FvcUHKjkO+ZL9IzzKRJoYKV6JNpgBgbUbv+X4Tyzd5i+Z8INFSXGTOp6Vc1V1wiicG
         y6edDYqN8n24ljcBjqCcKM5z1TNVJRvDQSNAkKBzvRNEqgdkyOr4yCrHmGs095UafygQ
         qf7tdEl7ouY5at1b3ZQSmOTRGXlOt4xjewej+jh4Nf1LxwDXiGxjiXRqe+G1na6XXzL5
         W5mVqf1IPWM/QJrFVlMw46EUfnSXRcUwdNHMzrFIMrP+NubllrtHT3WRTbawt3tLoDrh
         wIuNltsIZUCtUV1dhvQchN9Q+EBP7EGWaqXGWK1vkkqhEqyQFz0uftL8zy8cZbSd9UPM
         SLYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771539273; x=1772144073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuWksm/z64CkDA8wVi+HNFlxh1fV4OvGcIJUKwatE7Q=;
        b=gBWwAYZ0NP5c3k5eI5W515q4ZiQjAQP1NluNSOYuZqTBbJALLybWKFllVjM/OETrOx
         w0jq0m/2fgHr3miMYFt8V3LK5p8OLlEs0zzgO56uNNSYFo+tthN50AgUzXBApG3DK/2D
         F6hU7WKMiEaTyo+HvjkU1VJvO/Yn6CQYTeogqhOkE/GpJ4kAOzYx6hwwGOtmS7+vKxB3
         PNU9OH9ERxX45GFrHebMN1ga+tnJivwoBeWRGHTogINlY7X6UijK36d4OzhOuWMvlsew
         F3GLTc4q7soZtQOZ6uR+jF+bbYOxCOaLTTpHeFOCf6hNfYGZhkEKCnuPoQdMFViwaTun
         pyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771539273; x=1772144073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uuWksm/z64CkDA8wVi+HNFlxh1fV4OvGcIJUKwatE7Q=;
        b=DGENGsxfCCjcfrIqf2t58dzUvK4l/EFTL1PaaewyiNrcINxzEn1VMSJcPQQzg9gNSY
         BRVIlgmzSsztT6XWP6CrCW65lid0+EuVWnGX4LtEdRheBC2xcMOefzvH5kKj45uycWEj
         OcsGUAYy3HAK79kkWNZlmPkij8+YVSIU4Sa5xXmlVUNvsT4JapFWuUy3CARrB8Q9n4zt
         bXhVPJuC5Dl0nzWQcMSQy6gN4r8uqnRVaSdMok80wWYHYhcJTXGo5hQAl9t1bVdRRxTO
         IPT+OLXZPS5CL7XN8lSoEkjMJnpwMxC6xHgFcDKesDU9WGfN27KQ8lq9tTbEOwQMaI2X
         8RoA==
X-Forwarded-Encrypted: i=1; AJvYcCWyxcuWxyyK1sl2At0c//Iwt3rdrHNEFZNOBFO3Fx7xo5x1eook87VFaGvD9MAw42F3ZIg154wLHnpHozQI@vger.kernel.org
X-Gm-Message-State: AOJu0YxuD4zeJ0a7cb8az3LaNkMfBIJBYxjfbLjd8TDNCkPpsH4kTJ04
	yGLU3ZHKTymLaEvR8M3aqXBf/k/dSQ+Kfn/wot9Ek6wUMY/3Fl3T78v7CF6TtdmVxt3jeVj7U/q
	WXH2aQ7X1vy1aJ2UyJXcdfU7VY64S8oRLlZzsrw06
X-Gm-Gg: AZuq6aI8kdFEANOKBwlQcSJLUxv9hN1PzL2yiVPfyv7ANpN3/hKzH0GZ1FvbQ6sBG8o
	7M0QwEAYCpkrPg9uirIi+5pprfvmWt9rG+E0syoPciZi+KpixwpzarQSiIPE0Tpa/VK2tWCoRjE
	UBgqWEDsYWv0MqBUBKP/ubhs9fvh/L7/b9tu6Y7YTqAK7HfU9svg19Pd2tXHcpVmuDiljVftbQ0
	B+KMpevElxWvuhbORRSIFbChyEHix6+oa7fIbkM7nXFALG+d6RxS/5hBh4JWitd8T4qTMhzpJ7U
	gixgrlM=
X-Received: by 2002:a17:902:d545:b0:2aa:eaa7:2a9 with SMTP id
 d9443c01a7336-2ab4cf4f959mr206906725ad.8.1771539273002; Thu, 19 Feb 2026
 14:14:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206201918.1988344-1-longman@redhat.com> <20260212180820.2418869-3-longman@redhat.com>
In-Reply-To: <20260212180820.2418869-3-longman@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 19 Feb 2026 17:14:21 -0500
X-Gm-Features: AaiRm51RDgNBu0z7rNLTqXSyUOVNwxPkgUEsGNbLDaPD_6KPUkH0zhu8FG_KoSI
Message-ID: <CAHC9VhQXK__Qbyr3TXF5gjQEhRROkOtva3nPZhp7YUy2orgj8Q@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 2/2] audit: Use the new {get,put}_fs_pwd_pool()
 APIs to get/put pwd references
To: Waiman Long <longman@redhat.com>
Cc: Eric Paris <eparis@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, audit@vger.kernel.org, 
	Richard Guy Briggs <rgb@redhat.com>, Ricardo Robaina <rrobaina@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77747-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,paul-moore.com:dkim,paul-moore.com:url,paul-moore.com:email]
X-Rspamd-Queue-Id: A567B163169
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 1:09=E2=80=AFPM Waiman Long <longman@redhat.com> wr=
ote:
>
> When the audit subsystem is enabled, it can do a lot of get_fs_pwd()
> calls to get references to fs->pwd and then releasing those references
> back with path_put() later. That may cause a lot of spinlock contention
> on a single pwd's dentry lock because of the constant changes to the
> reference count when there are many processes on the same working
> directory actively doing open/close system calls. This can cause
> noticeable performance regresssion when compared with the case where
> the audit subsystem is turned off especially on systems with a lot of
> CPUs which is becoming more common these days.
>
> To avoid this kind of performance regression, use the new
> get_fs_pwd_pool() and put_fs_pwd_pool() APIs to acquire and release a
> fs->pwd reference. This should greatly reduce the number of path_get()
> and path_put() calls that are needed.
>
> After installing a test kernel with auditing enabled and counters
> added to track the get_fs_pwd_pool() and put_fs_pwd_pool() calls on
> a 2-socket 96-core test system and running a parallel kernel build,
> the counter values for this particular test run were shown below.
>
>   fs_get_path=3D307,903
>   fs_get_pool=3D56,583,192
>   fs_put_path=3D6,209
>   fs_put_pool=3D56,885,147
>
> Of the about 57M calls to get_fs_pwd_pool() and put_fs_pwd_pool(), the
> majority of them are just updating the pwd_refs counters. Only less than
> 1% of those calls require an actual path_get() and path_put() calls. The
> difference between fs_get_path and fs_put_path represents the extra pwd
> references that were still stored in various active task->fs's when the
> counter values were retrieved.
>
> It can be seen that the number of path_get() and path_put() calls are
> reduced by quite a lot.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/auditsc.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Apologies on the delay in responding, I had limited network access and
it looked like you and Al had this under control.  Regardless, the
audit part of this patchset looks fine to me, my ACK is below if Al
wants to take this, otherwise I can merge the patchset via the audit
tree if Al ACKs it.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

