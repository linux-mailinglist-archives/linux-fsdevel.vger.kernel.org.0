Return-Path: <linux-fsdevel+bounces-75941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPYUCjGrfGkaOQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 13:59:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE274BAD13
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 13:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 76F85300B18F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 12:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7590137F734;
	Fri, 30 Jan 2026 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYWwVwOl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8861237F10C
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769777963; cv=pass; b=epokdvgMIDDmCNVYJ9d8NOyiOesX4uSgKMqFVEGXuR9eeVZcqGuENpd7nq9s85AuL8GAI65QcEzSqXoGna0zWg9mz9bzm5pl9W9m+niA9rkjGMC4smaBmweBjToWMQKH2jz/qcxTRaySdoC2EoPyL5NK77p0mgotxxk7+hspbOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769777963; c=relaxed/simple;
	bh=xG0HoGtWgtaeO6rMJ6ftZ42hhmA+SOj2D6UatodVRxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=EQl5JkIoxmGpbcfGbbNbpZVbkmOA9HvoEVDFmw4Y9tdgCaafRgQ7P10m24uqOd1TNWPAmyrkJ4dKfj0f91dc/8j8x+nBmiHL2eoUjjU8PaCZaRl5Lc8ULErNa8IaNEB4ukUCpsE5RHSrTDt/Nn28LIG5SEORlhTe7HvRu85wFhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYWwVwOl; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8710c9cddbso263285566b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 04:59:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769777960; cv=none;
        d=google.com; s=arc-20240605;
        b=Hs/tZF7MOCDVkr/n3JO1m3O+EnkzosPzeYFWLu1VYFioOF1KOSOGCIRFZvc0gVAPvk
         K5ZERYakCU6Xo+KUVZKxviLJ6oD3s7DGqWvcbSXy9TlGsldh8Aw3dOzmnUagJRuMZzkq
         1r+PHVDi3boNQRzXYhSCft0YNg3sQryWdqHCDMJFLC1v+i/MoW2ZuIyPXtmTecMwlvtU
         wcjsNAQPV3U/m4vH7Uq7koa5Li+v7TsC2lM8jeO+h+ZpcT/iSFyNpGquqJ6fWycYogNJ
         5VmtIy8yZaD0ehKEnosur0NKmXmWuvSYmHG//hQiCypQWzOz6IyAGn/hlAyJz6hKFGvm
         /ZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=/5hVLHdfoH2KEaRhGo53o2eC57XReA1/Lk8YzkL01/8=;
        fh=SBXIz1FQh0WagkUPGhoZpOIYDSP6PNTjGQt6wA0liak=;
        b=X4PLpy/U86NVBPMtQmciPkNcVUyhpfy3zqKDqvq3Z8PMkOkyO4h4Nx/2Nsb4JDuUWG
         znOHA+myoriYZxjAOlTHBKbkl3TMoUejR99/Pb3ZoiBPlVoFZbAkWHwYCLsk8DmJ0byH
         atE5cM9lBiq4SDYPlocN5icfYMUcqTZ5FcNrSJ3Qbo2a+P8pOqSXSk5AoZUc6HMr1Jvp
         S8e5pgZJ/QCHm0Uw1VYYCsA4nPoH1iEJMflWJ4eHS/NUoehou+L1Kd0Xqy6w3X534RZO
         jTC+RyHqwMHlJNa09ukvINqk/JgyCDKvY/tEpjwKH0fRUXCrY/UABBn4TGjzU/zDL7s7
         u5yQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769777960; x=1770382760; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/5hVLHdfoH2KEaRhGo53o2eC57XReA1/Lk8YzkL01/8=;
        b=lYWwVwOlgaPWDuDiRwKlFgDXMzdOrGvIXHLY8DKNG1lenuvrI5RvK4G8Qw/jlkBjCW
         TuWUcRkZnTBpUv6AgjdMngTt+a+7mLecXSFWkg6w/ZBldxl5T6FxafK+tYJ64IiW1x9x
         zQwTvmL42+yNz9VkV03ndd5W8ER1d8x644mZfRWDrKU3WzDxkVwWVA9/QHiyENZDIh7Z
         DQszxYhE0zB6XXH+jqYCvT+8cKE063yS+0nep5Wn/bvYXBxuwPtGa69zQ7wYTZ1/fb8g
         Phh6r2HZGMR4/JL/pk16RkMCJ3dFw91M+gHWP6Pe7fWLPa/Es7KGLGg+83Izlope8zSk
         39Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769777960; x=1770382760;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/5hVLHdfoH2KEaRhGo53o2eC57XReA1/Lk8YzkL01/8=;
        b=hYOpiNu026T4qpj3C7CAqzsryKP/Zo9lIx6uXEoOD3/3fMt8ebRisdfzPRK2i3h3Ve
         0SoBy3loPQGblttsLgrZJ2qakY3JwAZkXTaeHet7P8WbgBm8YNAZlblk5eit0KicwbPq
         Qqit2agy0uFcguU62U1T4un7UT7eAAgIB6Kz5JwU9R5z3QJ12ROX5P3Uu2ctepjWvwqV
         /lGoVaOosvcEXlJIJRbZmYt2e00z33BGt0lEZAzOg2P/zb2j4qMl6LNXtfU30sCdH1Di
         dFRiCt8riFvj4E8UxU5ta2a5+wdtyhfcNMFkB48yXfadmHb1nl00wFA+rwM82MXI4GPA
         M6jQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8XeNKArUZ4ahyd+MypaRzataVAY1HwsqU9FQQlT4K5gylLiyGs4uYxIscFt8bHuzDIZ+fhzBM8ePhrX2n@vger.kernel.org
X-Gm-Message-State: AOJu0YxG41y/4tFfb9EmeMEF6OZtNweulJCEgFRK/MsWbYqGAAM0CBAj
	7XQZAMTkJdHnlePIk2ShtsBkfp8cxBcf8dd4H7lKu7l5Chh7QdU615BdcjNiZitdjYLEmqfFmli
	6Al0R/XhVyh1X4gsxIW+QnY5m/+R6EjkfHA==
X-Gm-Gg: AZuq6aLB58WZI3ahqqhSURKntJSNTj5o5UI3wLuWqxZEhdQIwNcg9WltC+p7KY35tEZ
	PwPjwJawqHVF4Pcyk8KiTzjoJof0NxXfOIxDtdIUPs/CGo+Nckqn6eMT4TF0ZttReVfwWULKwIy
	E0NE0ep2KTslYyncntM1NmnlRJ4VvNlNLqX98u76PEVBhlYUrSVtKPM/T12i7xZ43j0oZmiRq8m
	fkanGHSg0Z1HLBUIG+QskdBwLU69BMvEWnK5ql4K3pIQmsN/6bqdi4kcpKXIZ+RJXCu2A==
X-Received: by 2002:a17:907:9303:b0:b87:1b2b:32fc with SMTP id
 a640c23a62f3a-b8dff221092mr159144566b.0.1769777959652; Fri, 30 Jan 2026
 04:59:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769026777.git.bcodding@hammerspace.com> <0aaa9ca4fd3edc7e0d25433ad472cb873560bf7d.1769026777.git.bcodding@hammerspace.com>
In-Reply-To: <0aaa9ca4fd3edc7e0d25433ad472cb873560bf7d.1769026777.git.bcodding@hammerspace.com>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Fri, 30 Jan 2026 13:58:42 +0100
X-Gm-Features: AZwV_Qg9cHb_cy5s1iZbkKmSD6O6rh8Vs18I0Fb-ECMjeghOuBS5bTI7gCCvHXs
Message-ID: <CAPJSo4XhEOGncxBRZcOL6KmyBRY+pERiCLUkWzN7Zw+8oUmXGg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] NFSD: Sign filehandles
To: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75941-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lionelcons1972@gmail.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE274BAD13
X-Rspamd-Action: no action

On Wed, 21 Jan 2026 at 22:03, Benjamin Coddington
<bcodding@hammerspace.com> wrote:
>
> NFS clients may bypass restrictive directory permissions by using
> open_by_handle() (or other available OS system call) to guess the
> filehandles for files below that directory.
>
> In order to harden knfsd servers against this attack, create a method to
> sign and verify filehandles using siphash as a MAC (Message Authentication
> Code).  Filehandles that have been signed cannot be tampered with, nor can
> clients reasonably guess correct filehandles and hashes that may exist in
> parts of the filesystem they cannot access due to directory permissions.
>
> Append the 8 byte siphash to encoded filehandles for exports that have set
> the "sign_fh" export option.  The filehandle's fh_auth_type is set to
> FH_AT_MAC(1) to indicate the filehandle is signed.  Filehandles received from
> clients are verified by comparing the appended hash to the expected hash.
> If the MAC does not match the server responds with NFS error _BADHANDLE.
> If unsigned filehandles are received for an export with "sign_fh" they are
> rejected with NFS error _BADHANDLE.

Random questions:
1. CPU load: Linux NFSv4 servers consume LOTS of CPU time, which has
become a HUGE problem for hosting them on embedded hardware (so no
realistic NFSv4 server performance on an i.mx6 or RISC/V machine). And
this has become much worse in the last two years. Did anyone measure
the impact of this patch series?
2. Do NFS clients require any changes for this?

Lionel

