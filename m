Return-Path: <linux-fsdevel+bounces-76462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGeDKzTIhGk45QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 17:41:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CF978F55B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 17:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A048230091FB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 16:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BB1439012;
	Thu,  5 Feb 2026 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="I7gIGQDG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CDF3D9027
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770309652; cv=pass; b=qfuNhEL0LDnsMY5PVB48WeXwO60kaY8/x1a+kRNDpZ+d5BIsrt9GJH1zfV3WY60wgNMxAiDLgnm7eRA8Rmj3rso9P3z9sevY4Fk32c82TTAum8REmVotRsLHEr28GYxs5PE+XclMzqqNhaViccl2y1XdjYOUSKahQcRkrHchN7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770309652; c=relaxed/simple;
	bh=xwzG2Ogh4J2uFhZawtzchjseHiH8POO4drcnSGr4eYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFvMfmrp/umN3KsQXn98vjNHQzcSww0wp22sFQKNYuKwLHDMqzAvNdrt2TvDYc6b1tpE1Zrnj680KCIXbRhBun0ZQQNWMuqIK668IWa1ISJVMBl8ydrW6Mdxtb1M6WoJZpIviRJMeL6dN3ibkOmkCLKOvcOiia0qXSma9KcC68Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=I7gIGQDG; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-385da75c6e6so11331301fa.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 08:40:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770309650; cv=none;
        d=google.com; s=arc-20240605;
        b=dwekom0S+QE7woyUMbZaNVFzybTOH2Qkg0BtExDukdvXiOlBIl2EXoMXkherQ7/KkT
         DycPaxoe3+S4lcfwz8nWiFueSsx7UqIG1vhlMbWPfijUFJXX/4sCoDXN6YfE/Y/2zbnJ
         R56PkxgD4nk6fjBuXV0LR1LiZt6ihPpiGLbg2lfMTuAJIIHgiKH5+rvI+IT0NO4Y+iua
         ZXFXULtvY5hqMmk1844LwXwEmgtae+EEy3rX4uNQL4+1tBAJTrHYBg8P8YrLjgombuv9
         G5J46tOnKAyxshU2DCTHdHOnyAPbCHaqGkBUinFwUNCMPlNj4x6i9wgVEthTmOvoe2B7
         qfsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j8o2goC0ypz7sAm3yTvsQ1LLpo4GKpdQO8NpPSiwx6c=;
        fh=5Sur3Je9a5VK4xShblqtOeqetA4cBrCHyi6BnMJixeI=;
        b=cqoVIaXeH7uVkSUznyaNdGRDfHnZigKoGv8dmphg/RquPdy2ZsTRVZYkObGQlzWIPs
         ayyzW860i1EsoLxh2e4thhel8qz+onag8c9mB3+VvFMjvCU2m4/a2QBBY0IgvjOGZ4Rd
         lxTFQpYDBZiM9firlv7uQ/w98aTS24cdgnUifP7wAQ+2R/h0X6omDNVlZ0qWsh/aFTWu
         UAzrXvpSEYARB/MZF/20N9L4kEvjc0Q7bedpzXRXi1y0GIBcT28teLkvNjhARzQZkOGT
         WzT+GdBozjqZBYI+FIISQQ15RhWuP2oOI0hSJ3sckvNUD+CZTw8GTiiOny2Ej2JrUXKZ
         Xg8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1770309650; x=1770914450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8o2goC0ypz7sAm3yTvsQ1LLpo4GKpdQO8NpPSiwx6c=;
        b=I7gIGQDGevnIjfO3BC9CI7Y6QpFDKEaHHK9ja4EqIoCuHGWfasDEKHuF37GeN0iKp9
         pWmTBaCcVdEbyucTBQbBH10GOqnxAm8N4igijj7XaD9pwuU0je8UX/SkGUSaq8SbJiM8
         DEpPfQk3zfL5/QLKb03UazTWf9Q84BzOEx7jEpTb6QXdlI0en3/u5frmYII4zHOB9uDf
         WfzpUfXCUp4xiHR3JwUB3A43JxhGqhtNaF8vOvrcAxM5VtGa8OiR+EbivKzfDKez6ePX
         r1QKCcK6md2WlOrdzxr0Rp+uImMlI3w6y7VX58HTlYDmB5b5Co9ylG+spuVDWjNsGGkl
         MsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770309650; x=1770914450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j8o2goC0ypz7sAm3yTvsQ1LLpo4GKpdQO8NpPSiwx6c=;
        b=P6ZPgqEWfqxTlkiwe3mHEHiQdYU4vCxB8TZ77P4rnHbLQHsfvm+I7q6qelac0IbO+e
         atRatTUvtjkihFXg83LKOK9kd0fj4EiX8mbqs9zeklXFLzKw5FA6Gv5DnoZVFKATYtb4
         tddGmtjDG/Br+JRTr2GOZLON2UgHdhwMyw07TV8sNn9qZOUR4GzwpAoPBRxkYdAaxfkR
         8/LKt+GFRaF303lCJNgCUvWX1oBVV8pR/2qnju60iuRPJYKrZZ4oFwn2VcadLhBulfPO
         icwEAWsnxsNO0+ZrY4zPpuvpd5f/vqDMwJOEpQabWTqBqQMa89TxRJxiC0PYAyRAlFsg
         Eang==
X-Forwarded-Encrypted: i=1; AJvYcCWJ0tl+f+zosMQXKqBLohiLvzdNbKaEZE8ormxma25dC1cz0nfbsIeid8N0PEk0NF6oq18z0Fabkq3jIA93@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoudfk0/IjVNxwA4g9mjyogB8n0AVqPl7T+qCxxSBHj2tNsdDw
	KBPU7BKq7Bempbj+BLrVtgKx6IlL8p24/mdnnPpRgt5y2ev0bnLiClZFUs1pIFqL2IlwUvPu840
	unkZ6CRWzLXqaikkDG04eQaPQ1JPr7DME6NoZ3g5l7A==
X-Gm-Gg: AZuq6aK8ZJooirE4KrsVnGzZTqf2CLdMMueKaifpIldQqwyeCPkrsVeu5zTril7cCHe
	mhtgNoBCd1PAlvKGPt0wNRqumSD5HYcQCMAKq5OGVxr45/+AmN6qaY9GVknp7R3MI3zNPE45UAg
	UyBXoJpIQGkV/1UxPCusKX385nRPnS+nyL93h3nsGqE96nkXYU9Xm65GWvlrPyh82aHJyeG4gqQ
	C5Kw90X/iaL/KJTHs8r+k/NXDtsqh0cO/Y3SId9BvnGtXGg2xCEYj3yxuOGzYtQf5naWdg9Oj1z
	Hg3DrqM9VHUlHooGG5XRbz9Nc3gOVir/SgrCh8iDxb1By2UQWEEtUm1y
X-Received: by 2002:a05:651c:31ce:b0:385:da28:1e4d with SMTP id
 38308e7fff4ca-38691e38f7cmr23240501fa.24.1770309649567; Thu, 05 Feb 2026
 08:40:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <32e620691c0ecf76f469a21bffaba396f207ccb9.camel@HansenPartnership.com>
In-Reply-To: <32e620691c0ecf76f469a21bffaba396f207ccb9.camel@HansenPartnership.com>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Thu, 5 Feb 2026 17:40:37 +0100
X-Gm-Features: AZwV_QjmZRCeTXVDFflMu1LZl_ZSuoZx08sEIUmia56TUKmCgVvLJHiLQYSMHpw
Message-ID: <CAJpMwyg4Etv3qOw2Ur+L9YmWbt7Rw19uTs0=RsRtuORaEOoHnQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Documenting the correct pushback on AI
 inspired (and other) fixes in older drivers
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[ionos.com,reject];
	R_DKIM_ALLOW(-0.20)[ionos.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76462-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[ionos.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haris.iqbal@ionos.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hansenpartnership.com:email,ionos.com:dkim]
X-Rspamd-Queue-Id: CF978F55B9
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 10:52=E2=80=AFAM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> To set the stage, we in SCSI have seen an uptick in patches to older
> drivers mostly fixing missing free (data leak) and data race problems.
> I'm not even sure they're all AI found, but we don't really need to
> know that. The problem, that the submitters often don't appreciate, is
> that every "fix" has some chance of being wrong, so it requires code
> inspection (which is also not free, and which may get it wrong too) and
> testing, for which, often, no-one has any immediate hardware. The
> problems we see is that missed frees (often in error legs) represent
> tiny amounts of memory over the lifetime of the driver (they're often
> in the remove legs) and so we have to ask set against the risk of a
> wrong patch, is the problem even worth fixing? The same goes for data
> races ... and here the suggested fixes are often somewhat complex and,
> on analysis, problematic in some way. I've cc'd fsdevel, because I
> think you're seeing a similar thing for less well maintained
> filesystems.
>
> I'd like to see us formulate a document we can put into the kernel and
> point to when they come along. Probably formulated along the lines of
> "first do no harm" and pointing out that every "fix" carries risk and
> we have to set that risk against what we actually get in terms of
> benefits. So require the submitter to specify:
>
>  * What are the user visible effects (memory leak =3D none), transient
>    bad stats data, or actual data corruption or kernel crash (latter
>    being most serious)
>  * how likely (or often) will this be seen?  If about once a kernel boot(
>    or less), at this point if you have anything less than corruption or
>    a crash, don't bother fixing it because the effect is too minor
>  * For bad stats data, is there an existing tool that uses the data, if
>    not don't bother and even if so show it leads to issues
>  * How was the fix tested (to reduce risk) i.e. do you have the
>    hardware or an acceptable emulation?  If not, report the issue, but
>    don't bother sending the fix.
>
> I think this is just a starting point, and, obviously, it's a bit
> driver centric, but we can probably add generalizations for filesystems
> (and even mm and bpf).

It is an interesting proposal, but I feel the problem statement
overlaps with some other, already being discussed, or covered topics.
For example, the topic of fixes requiring effort and time of the
maintainer/reviewer, and the fact that AI now potentially leads to too
many such fixes is being discussed in the following link,

https://lore.kernel.org/ksummit/20251114183528.1239900-1-dave.hansen@linux.=
intel.com/#t

TL;DR
The submitter has to mention the tools used to generate the fix.
And the maintainer can choose how to handle fixes from certain tools,

+As with all contributions, individual maintainers have discretion to
+choose how they handle the contribution. For example, they might:
+
+ - Treat it just like any other contribution.
+ - Reject it outright.
+ - Treat the contribution specially like reviewing with extra scrutiny,
+   or at a lower priority than human-generated content
+ - Suggest a better prompt instead of suggesting specific code changes.
+ - Ask for some other special steps, like asking the contributor to
+   elaborate on how the tool or model was trained.
+ - Ask the submitter to explain in more detail about the contribution
+   so that the maintainer can feel comfortable that the submitter fully
+   understands how the code works.

The topic of how big are the effects, or how likely (or often) the
effects happens may just be linked to the main and IMHO an important
topic; availability of the hardware for testing.
For this too, the previous discussion explicitly asks the submitter
for the following,

+ - How is the submission tested and tools used to test the fix?

I am not sure if this discussion can be linked to the above mentioned
one, but there are definitely parallels here.

>
> Regards,
>
> James
>
>

