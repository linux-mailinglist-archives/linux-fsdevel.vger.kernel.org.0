Return-Path: <linux-fsdevel+bounces-77200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM71FlBJkGkJYQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 11:07:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E529613B9D4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 11:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3566D302E7A8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 10:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53866285C91;
	Sat, 14 Feb 2026 10:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJWG/0TD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C187C253932
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 10:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771063597; cv=pass; b=P4DAiVC1V0bfMc30jaCMHHAOq+0G7clw+uCL0ujtAbLzWt79NODD/L0Xs5gJXo2Byk4m0N1sKdkDx/upgW3Vv/uTNPWghZuAWrXfSnOy8nRZ0V8HsGXa9YfBIVJmiPeQGV64fCCIoZUCcOjdtsVM5vEl4hMIRVSvnrk2hhMl8y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771063597; c=relaxed/simple;
	bh=jY3VYgfZdwcEWaDFOTWHCBRqnN2ieQGX76J1TWV/hN8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MYViDjjMXckgwvZMSmHnDBJ3DMEoeZ6TjPtIETgwSREX/AxT+ur732EPfXTohk9ypMn9KIitSkkFWcZZISIN3FPUiYP45VOtiDgOOSZ/Wo/JfYP64/6wQ2SzRXgX9H9EcqQEQ2TKQ6JFnLxdzEnRj6SluccjJIJbm5xqgmgT4mM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJWG/0TD; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-65a414a6859so3065716a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 02:06:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771063595; cv=none;
        d=google.com; s=arc-20240605;
        b=Xu/N/8wqGoTVjs4xoYebRjdZZ/ZU9Zx7D7RS8WMbc94MNoDR0vzLYVRkj3mlkFEPCu
         GU+5k2CLl6iRHcKzbth/9B0uXPOdaBpmIokZGslibU+6EpGeYFUgvsOYo8raqhxC5+F2
         hFQAKpSALwXaFdPDrLnEnoeqh8oI/uZCE2VTporwrH1OWIA+11M+jgFEPaWLojGIp7ha
         vWtboeQpJt6jlSdT1uEOmokUuIbQFBtdSO1zLITq1tvhhKk61mR4C7sMILUEy4a0uEn1
         hLPF8cJMdFOdnBpxy13+UemaHfzeox+UAoTWMpOcapXZAEitg6nLvPLB1TWS6bKHVnoB
         nMww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=PGGVJbddt208w/rGIVrn/yfhIsOw/8PIkZU+nOzBAdQ=;
        fh=thzeMrdY5ZDzDL8M7bcdBWxPQiu16AmjbQnHEFhrZV4=;
        b=QzCB2jHqXUuPs60pOZTO6pxFFjIZ18WIbePUj8vJRuDsvXhYNUwHXxVHLF6S7/ZgTj
         DQ+Fb6RH1SEtR9DtkcNvjDF0/AIVHoQO9ylmTRwIJ7S9vKH9Ho226c0q+Og17kCc6GxK
         2EQ3vpdtGdAk0ZHjUXHiOwjiGj51nEjF1mRn6xpKAElPTadaQ3czxX8T06KkNO/aS57u
         WT/N5ev/bKRXl7PvPN7EntvohPTt9zlh/J04REAnG8Nwi20mwBrwuzEVGIqVRI9eMFyS
         zsQ7KoCpkdtrwo4TYGF6lLNmmE0xeGbtxM0xWb6o/6OetafTrNWGWKfhNc7kVulT1uud
         ZvqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771063595; x=1771668395; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PGGVJbddt208w/rGIVrn/yfhIsOw/8PIkZU+nOzBAdQ=;
        b=iJWG/0TDNqvsdOWejxmu1z4K6eR6SkFFPeweAMKUuf4LjlqhwlPSq5tZSYCbHIPKm1
         EltXd2Tsle99bwwM3BWsEjIOZ+nolbgkUOW7pdQB3oScmn5W6gdTWWtnF1vbCuKB2nOf
         we0xiWFbptRLuR1m/hb43AuR2tOT69JGivipnH8le1LKrV6Y8EMxSJVeaAF6KkG/75Jg
         Th1xMmTon+pabWXfcBFHEA1Uh3V3RC8EaYDqxLc7yl348ADM3jt9Gzme7RyUZgyvhBqC
         EOi/GKPhKPDijFB3bTJejzBSKCQij/BWO0zam99kZ7rACGVRhnrpWBaJr8uaVKdf4CWu
         Exfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771063595; x=1771668395;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PGGVJbddt208w/rGIVrn/yfhIsOw/8PIkZU+nOzBAdQ=;
        b=jTQaibfjmvBQoqfBoUxkWzPO7jc+GwBVmBO6Sufu3oMWJt+F7rz+LtXNL9k36ukWBH
         2eACSqJpAj96fQtImhdMGyMBHJLs2k0alnwHxRBidWZnXuEFWR/zF5y+jzvXoJ3XjMkd
         KMMVCOR/dixQMK1wBtstm8PTIM0XgrefCP5lhrItaOaJLhR8XuEvaTNG+Z//AiCeMSEx
         QiD11cvfBuxhjWBildZh87f+IyosdzUS8EOqkiHyGuU/SYhHI6aB9S89yBk7/5QrLL7s
         K6pwnU36xIykUw2xcmlYpgGsevN1kABwep9hKMq7+PzHdv3CS9pS1kLjUKEeAyeE5VyK
         ePOA==
X-Gm-Message-State: AOJu0YxQFl9udGLOBcyxyhWNWFDR2lNOJNc/4xR31K8POUgbGADquO+c
	nmzZsdUOkbGBUXHpF9TCZHwSgHqFak23lIsyKNJDB+UWN/+9512V/nNlsikie+J0fwrj6I49NLg
	0Q++KU5wOQunGgpfAUI8IgvWFXSkprwo=
X-Gm-Gg: AZuq6aJi5voovDKtvwW5oXmy3ELU18//dACuyAv1gK3dAi6dI7opXGBOQBQrMneHtuR
	L3ltsGPkXjVZbHEdg9x9g7xFvOM/tHLurQsBBgo20zug3VgDP/Z+Ci7KuJXEGOF06tC1UJjtyFh
	BYm3oMjuw51BYLE8miWdKFN/M4GCPaJcYfHjK/z7LnFODQtR56HodLKoeujQp/fsWTYQywqswTh
	Ikz40yos3kCxfa5P/9xKkk86n2J+OH9jiyrHI4qFBdUlHZoxtU6KDGMfYWHcBoFc1YTWS5bCGgQ
	8cnX3A==
X-Received: by 2002:a17:906:c14d:b0:b87:6d6b:1366 with SMTP id
 a640c23a62f3a-b8fb4462ebdmr258928566b.41.1771063594865; Sat, 14 Feb 2026
 02:06:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Sat, 14 Feb 2026 15:36:22 +0530
X-Gm-Features: AaiRm53SFCWgM_DXMfR7wPwL0TsGianlEbiEEbkirbl4xvQ7utf0iFrM8-H5s6I
Message-ID: <CANT5p=rDxeYKXoCJoWRwGGXv4tPCM2OuX+US_G3hm_tL3UyqtA@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Namespace-aware upcalls from kernel filesystems
To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, keyrings@vger.kernel.org, 
	CIFS <linux-cifs@vger.kernel.org>, linux-nfs@vger.kernel.org, brauner@kernel.org, 
	David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77200-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,spinics.net:url]
X-Rspamd-Queue-Id: E529613B9D4
X-Rspamd-Action: no action

Kernel filesystems sometimes need to upcall to userspace to get some
work done, which cannot be achieved in kernel code (or rather it is
better to be done in userspace). Some examples are DNS resolutions,
user authentication, ID mapping etc.

Filesystems like SMB and NFS clients use the kernel keys subsystem for
some of these, which has an upcall facility that can exec a binary in
userspace. However, this upcall mechanism is not namespace aware and
upcalls to the host namespaces (namespaces of the init process).

This can be an inconvenience or a blocker for container services,
which run most code from containers and do not like to host any
binaries in the host namespace. They now need to host an upcall
handler in the host namespace, which can switch to the appropriate
namespaces based on the parameters sent before getting the work done.

I tried to prototype a namespace aware upcall mechanism for kernel keys here:
https://www.spinics.net/lists/keyrings/msg17581.html
But it has not been successful so far. I'm seeking reviews on this
approach from security point of view.

Another option that I could think of is to host a device file in
devfs. The mount could register with keys subsystem by keeping an FD
open from inside a container. The keys subsystem could then upcall on
the "right" FD based on some parameter supplied to it.

Looking forward to hearing if there is a better approach to solving
this problem.

-- 
Regards,
Shyam

