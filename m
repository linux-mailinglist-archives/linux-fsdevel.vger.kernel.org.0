Return-Path: <linux-fsdevel+bounces-77993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MI3vFumcnGmyJgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 19:31:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FE817B841
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 19:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 040C430DFED5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 18:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E4D340D86;
	Mon, 23 Feb 2026 18:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwYOM4iD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5992D33B6C9
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771871353; cv=pass; b=aJORndBgLCT7SBz7FhTW8ETJH0xUwPdgWNaYiopKnoQIScy16/VFexBPalWlqFh5oF2dA2eWF1UZzNdbGlFup6o0NzCVIrR436zSPJLFI9/3KU/Ita0g2BXw3jH0XGA5zTVHlIkFRzjRs2U1e78AfFOjbv2G6nJUb0gJjPRkiU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771871353; c=relaxed/simple;
	bh=0Whh66IdtUGy70gmAC1xBj/5A+oOvnKahSu95aS7N60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJHiUR4AdFIAU5/TYLMNxx+eZ7UIhS8sAKOMvQPlGOtY3DK1thYt9Lg2mMPHPZv2IflXJ0R7ViUybR8mVxmSsOMXZ2Iqx1mk8xbAWSTEUIC4qdqpN2xexKcE1W1/8DM1QV/rRhNPtw99Jm8hgFfk5iRQvdV6Wt2Lhxdq09knK4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwYOM4iD; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-40ea36b56b7so2548145fac.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 10:29:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771871351; cv=none;
        d=google.com; s=arc-20240605;
        b=aao0tMoSWBzXvZIumqiURvjsS9R4W0IXJKDr7tV8A5zDlU5dDsyO0awf1ooYB3ti3I
         vhBwDl7uJxaUPWiEslt9otFSbjOndnBMfKm+b6jWiy2cg00hNw2Se5Uh5ORWX+QVyYAD
         Ka0O+7sziKFcV/FxYnDRLq272O5LDOhRlkOYFqoZO9/S6y5X7tZyMyjPopRXA1nBzLO5
         /uLoc/WWX4+JgrWAJivycRFknjHO4TxoBChkvSzx0LLYtByR3gPkesXcmHBg1ilg6RWF
         ncbdHbvLYaagO9RsjqwfZpBFZsQCj6suOB8jTR8AzMCTZlYKnanmHzy5glWDoma1G6sd
         Cpzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0Whh66IdtUGy70gmAC1xBj/5A+oOvnKahSu95aS7N60=;
        fh=Rk3yuZf9s/gY/YZw/cQMwN/V/Y8jv7/GN/Lqr4j1OAA=;
        b=JyPJ+KAWzQAJWRrAgJkkr2QBjmpAYm/UOUareaKvLDEsGzuUvWhG/7vDQDrWqGTGFV
         59P7RPHWqrcflj+SE7BjaSgtj8GIAV2vPXYNNQr2bDYPXk4Z3eWCEIUYZ6vcjhrJLNFr
         9PNc+/CB/pDqUg5rB593PiQbyzXXx6Wi1urnrWL9NOJDor7hVeAlNdfcWFz0wYVf5N1k
         b5tqPTEXTNsqpcc+9Rb3RnfMRNnDbW8on156I9gf8e6GPNOtid0JkcMoyqpBbvRV9dpA
         tjqb5pfeX5dDmB1+dLb8loFW2abntPbpoHTdPT66q0Z0WtL1aOMQJuavWwgQjpaCvRQe
         5Y7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771871351; x=1772476151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Whh66IdtUGy70gmAC1xBj/5A+oOvnKahSu95aS7N60=;
        b=IwYOM4iDWnPfuZgSYZRCtI4/oif6ihNDNZcTlNdbqgRaGuo/1JsIrIEaiaWwpkqouH
         cOuJ90UVgwA+HI6VtuPCal5P8RaZ3bAkwtF4HsvqaeQ4PZmyCv8TredQfFsckifeFCSD
         +yaqVZEqyz388zZSkFE+jgiu98EwWrQJjVMKrrX9ayKMFaqxjrGoyGLcrpgb3iPt/jHs
         SiRLQG4brjohBFkZB8cSaFRqGSxIELraCbprUU0QzB5wKYr80+NbxTLW9+oUqjLMI2LX
         UNvsfVd7B6YOAe1HzEWGwKnro+hz8hOh4JzgXUsE3Z87HoOpT4xl6TkNVRuhdusMxMpB
         rKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771871351; x=1772476151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Whh66IdtUGy70gmAC1xBj/5A+oOvnKahSu95aS7N60=;
        b=klo+7W8Rfz03L/RJZsauoElMHZEoGk3KIoeM2XNHcewsaj9hkAHj3WO5IvyHnOWjwz
         ALc17mjIYFYtE4lOX1Fru/IWc8tKJhhjucf3Dfaj2XqEa4EHjY0IbpVZUCsZUkKO1KNs
         p2h/YU4evu0A5VOoFfjJ7+gzCEnBrqyB2ZbdJ9Zi2IPjBA14TFY1izdQ8ivBQ3R59TnG
         x0I27r6zTjHfEzmB7+6jNP6gKTSY+UOuyMi2Hc3Zv/LaoDwFRFxb08ogmWSIH/eF9t4N
         1rmVwgiHFhzhzERd20GPbCx5LVztux8ENnoQjbZU2/YHefEgRvUKDA/JwDbA60Ks1Alf
         K7Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWtO2j1zfycBDNSEvl2O1kG1eIsVCAzlTFI0OZsSm3DmQcCFeuQA17FAM89DsFTAkL23qUUa6g3ILv/LPPi@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi4zPOzZ3BLcuMaReUdRa/AUPZ7bWHKafwGjPCVYQCiWJVmaaV
	Uk0lQjaV9pezdbrnpz4BGwxhXLZ6TthuZ+KZT8Kko8mxeVorQaiW+lde2gtDe0xObDpSNwDP4FY
	tKgTkDFJjN/MCgCtkCM6Bw5UOomsuVQ4=
X-Gm-Gg: ATEYQzwLPTbksGFqTGatndbgPS1zwj7dUW2nQ1sD0kVwLBiir94ibCZvt2tVIz0Z0C4
	MzfNBZR6Hh0AQh4p1szqPOiwNQwOWPDObrKAoE2rJP4qvYQSsc/hRSKAFPyDpxJm994pIPDK7IH
	zcYOFbrdCKrX2P/nr8gkVp6vyCIFXmopaijBuMPnA5Ixxm/wjI6uYa12c5dIAWG/BzbQQ6etW11
	mY86rXlMmVUjVOEUH3bWCjEv4Ta1yj8CgRx+vK3/cllrdksKjyU0maWgdEQM0DtFgzl+T6fMoQ0
	pdNvfZ0=
X-Received: by 2002:a05:6870:a79f:b0:409:728e:3f2b with SMTP id
 586e51a60fabf-4157ac28b31mr4638255fac.1.1771871351139; Mon, 23 Feb 2026
 10:29:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217180108.1420024-1-avagin@google.com>
In-Reply-To: <20260217180108.1420024-1-avagin@google.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Mon, 23 Feb 2026 10:29:00 -0800
X-Gm-Features: AaiRm516DL4wdtFRf7EQJjraaJNo9amL-ln10-8gw16pLLQ7cUL2md0iZsvWpvk
Message-ID: <CANaxB-wNJWhyM7JUKT3y0Wp73=+8XZRnSkdudxqDwEo2FaJpwQ@mail.gmail.com>
Subject: Re: [PATCH 0/4 v4] exec: inherit HWCAPs from the parent process
To: Kees Cook <kees@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Cyrill Gorcunov <gorcunov@gmail.com>, 
	Mike Rapoport <rppt@kernel.org>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, criu@lists.linux.dev, 
	Chen Ridong <chenridong@huawei.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Koutny <mkoutny@suse.com>, 
	Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77993-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,kernel.org,mihalicyn.com,vger.kernel.org,kvack.org,lists.linux.dev,huawei.com,xmission.com,oracle.com,suse.com,google.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D4FE817B841
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 10:01=E2=80=AFAM Andrei Vagin <avagin@google.com> w=
rote:
>
> This patch series introduces a mechanism to inherit hardware capabilities
> (AT_HWCAP, AT_HWCAP2, etc.) from a parent process when they have been
> modified via prctl.
>
> To support C/R operations (snapshots, live migration) in heterogeneous
> clusters, we must ensure that processes utilize CPU features available
> on all potential target nodes. To solve this, we need to advertise a
> common feature set across the cluster.
>
> Initially, a cgroup-based approach was considered, but it was decided
> that inheriting HWCAPs from a parent process that has set its own
> auxiliary vector via prctl is a simpler and more flexible solution.
>
> This implementation adds a new mm flag MMF_USER_HWCAP, which is set when =
the
> auxiliary vector is modified via prctl(PR_SET_MM_AUXV). When execve() is
> called, if the current process has MMF_USER_HWCAP set, the HWCAP values a=
re
> extracted from the current auxiliary vector and inherited by the new proc=
ess.
>
> The first patch fixes AUXV size calculation for ELF_HWCAP3 and ELF_HWCAP4
> in binfmt_elf_fdpic and updates AT_VECTOR_SIZE_BASE.
>
> The second patch implements the core inheritance logic in execve().
>
> The third patch adds a selftest to verify that HWCAPs are correctly
> inherited across execve().
>
> v4: minor fixes based on feedback from the previous version.

Kees,

I think it is ready to be merged. Let me know if you have any other
comments/concerns/questions.

Thanks,
Andrei

