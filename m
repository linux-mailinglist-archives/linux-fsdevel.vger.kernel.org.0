Return-Path: <linux-fsdevel+bounces-78217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBaXJw8YnWlTMwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 04:16:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1849F18157B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 04:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FFF0307E260
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 03:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7421229B76F;
	Tue, 24 Feb 2026 03:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJtA40K9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC8023EA83
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 03:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771902977; cv=pass; b=RoYW5e4CSZtjVnxbRwhbW/zzvahYsz6SK1dwkxZSlB9U9ycwDoMZDwZXCudgEWFNlRQSoPceJF8oWHJptYIciTSGTlXztW9cEAOykMuYgcFlkIGCbfu3fub/DNMit/cKS8c0TB8zOQmZioApQTkD71rBEIy0EAiE6ZX42VMBv30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771902977; c=relaxed/simple;
	bh=/DZt0xtYa5lr6976gZvjB7WdGufQG5+fQI8ZuixrTvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Avt+oU8kNyAvDHtXwvAna4W/xPl4nDwbSc20J4mQNF5RmGWfoP86D3ReNF+ghE6h+G6uLdLMgYR4x63gfJuNurbJovVl1R+gnCPqBt3EgjtPAbLTe5TitF9ZOqSEz7Voc6VvU6BoeZFmxNKweuQWCbhHUpPtkPxMHmt8w8OlrYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJtA40K9; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b885e8c6727so880926366b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 19:16:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771902974; cv=none;
        d=google.com; s=arc-20240605;
        b=RDmYaWHaYXQI/swzOOIPPjokws/1QEy4ksRCxFg4YyUqpAu5PsOB9VWs6zXjbQETqk
         ZHhxO+Hp3gxU8oFaQR/FzR8FpJZAr7H8ZBnluDX7gN8RK/HbfG97j3fRZDJofKkMesY9
         c8A2N1pokvuOMCV69xzggUIbW26hHaAfHSeDsPD3vh0x+JnjUsu2WVNVNLlAkzGXgX3N
         Wng203zZ5DaH2GWk3+/1DLxtSakbTi2xOJBcFlPLqv5Ouc9rtu1WJHhpqb8boLDQ0Msl
         uwItSkPESMz9pTLUkZI2RSxTL/nrAKWyIek3Clyg9no95QzwJC8TtP5HoUmG8LO59BUW
         nUcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/DZt0xtYa5lr6976gZvjB7WdGufQG5+fQI8ZuixrTvM=;
        fh=V2lkiwaqEfVkQAMXWdr9SsAbGc7TvPDAJnSwLr1XaOw=;
        b=PJTWIRGVoLCxKLwk6O96c1+B+rfsk+cKvUzP7S6TYM0bcAsaniWxWOYi28GJC0vivK
         +5zXLJil5tQoqghKvEPm3Orm7/x4qsXmlzevmfj4mHLHZbFzGicZIwcxSLV/5KHEJKaB
         2//NOboUw5f4w947ASgT661aZzfCz26Mtlv05+ydsIRgEFDCsjrEcKwghin4W2ApgwB0
         5VgXZhnCTZrIPjEqLH3pLcxP1Ga0W9lvFTUqnaYqccDm9w6liHnYGrbIFGlvBFLqrRKi
         7yhnfqt4yhRECqQlqTr+wbgEdZNbegdgFklyMbTlmffhdheEiwGGewhRAOTy9OxssMMS
         Gk7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771902974; x=1772507774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DZt0xtYa5lr6976gZvjB7WdGufQG5+fQI8ZuixrTvM=;
        b=EJtA40K9HAoSdu5Nf5Nq2aG9PozmLTjJXiVzaSxUyZRnHGlsmpYrUVq/RE7WvoHJPa
         no/pdzQxnix8+xy8EOWY06jvz1LcZ4pWLu1F6rSQxFy12H/n/olMkaZg/r4zn/yiAj5s
         UKa1/Vfmc0yGnCsnK8aVMhdkc/EUlUgIQPR9ADi/gkvxat9lWFnOLpzRaSdrHUSSWXvP
         FWGJWa0DRFgIe2GFB7xjQjcgICPCoFCsooilZP4uExpbXEdORWr5lJPz5pSJNw/Zk5Lo
         CjK0Gqc4Bz53LuDP46VFJfRsdYjgtXuh23ulzt/IrTDzLwUSQdGtLu47rGMkfxvgda/O
         aiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771902974; x=1772507774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/DZt0xtYa5lr6976gZvjB7WdGufQG5+fQI8ZuixrTvM=;
        b=v+Gy/Tw85QRVAhvgkNNlVkoQExSBOfV/jaEAW5R+IUM/kIcqkhBTynCrQ+jVRMIQWq
         evm3k2uU6DplV/pDBoPuFaSIedbVXqO5t50togkhTy3LlJuz8FWgIuN/U4/w+UtjqbYu
         NrevlaERa8uSNsLX7rnkp2lGxkquUXFSACA5h/ACV2xmza6cxskq/0D/TE9SAjiFQfJZ
         bzd8tQ7q5j+5gyHdCRXBcROcCjpUn9flM/ikeGNEwuf+FT1Q/cSO/r5nP9ktXS/Tz6MU
         nwwae+PvpRuSA7XH4TTFCvvsanK9FYip0udQ8Rn8UkyTimgWS4hg2adqAprHQEySf+Ka
         q1nA==
X-Forwarded-Encrypted: i=1; AJvYcCXhT1OA7l+7qAz+Y/6fOyGJmIQY0/R2lMBdSqjVrv5ap7UoQQW+YYCohcWSWyqd4W9RzqU2j6ofRMqOInBU@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0TPHKfA33sCf6bZKedx2cc3o6xjmpBcgFyccV1E9qrBGWWqYg
	lPzIsw+esnteZ1qsnxSsGXtnnCEdESN7Him9ODCwSqVmPdseb2bWSejdb5RKWTWtgKr23LQQv5K
	7QOAqqAeEq4S2xxJIxUyposwo+qKj+Cg=
X-Gm-Gg: AZuq6aKBWPA1fAVXZUc37EkNhadVrB8qEics431QCiL0XZs9rZpWN2QlbkLAr6OnsXw
	zPk8tvCXk+nEmcEteYFq+wMS2yhCiF8NNCu49H3FYksFHklXZ1UH2aeeifL8XD1e4lG52B4u8cg
	PmTuKt8sgXIRGv1Lpa9sx6Idy5ZoJm2nxa7OLZphKnW0PaDJ9T09hg7UuDIY2Ny4TZxUTLxX5iF
	wyYx4cpj3KUeBcNfk9M7pTPlZ7bbcQNPrJwVEO1CRRBwLMw6yVptCCrhPA8PH4Dd/3SSIpx5RPY
	9E4zSw==
X-Received: by 2002:a17:907:268c:b0:b8e:380:5669 with SMTP id
 a640c23a62f3a-b905448b905mr922119166b.32.1771902973804; Mon, 23 Feb 2026
 19:16:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANT5p=rDxeYKXoCJoWRwGGXv4tPCM2OuX+US_G3hm_tL3UyqtA@mail.gmail.com>
 <7570f43c-8f6c-4419-a8b8-141efdb1363a@app.fastmail.com> <CANT5p=rpJDx0xXfeS3G01VEWGS4SzTeFqm2vO6tEnq9kS=+iOw@mail.gmail.com>
 <510c1f0a-4f42-4ce5-ab85-20d491019c53@app.fastmail.com>
In-Reply-To: <510c1f0a-4f42-4ce5-ab85-20d491019c53@app.fastmail.com>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Tue, 24 Feb 2026 08:45:57 +0530
X-Gm-Features: AaiRm51Gum82xCPbCea-rxtnj6tTimqhg7EvD-Mp_KEO3nKBntLMk04j3n-RZRE
Message-ID: <CANT5p=q05gni_jd4=KHsmR0LnF5HE9gNfo17q6f8ngsjY5EZdw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Namespace-aware upcalls from kernel filesystems
To: Chuck Lever <cel@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, keyrings@vger.kernel.org, 
	CIFS <linux-cifs@vger.kernel.org>, linux-nfs@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-78217-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1849F18157B
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 7:51=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
>
>
> On Mon, Feb 16, 2026, at 11:14 PM, Shyam Prasad N wrote:
> > On Sat, Feb 14, 2026 at 9:10=E2=80=AFPM Chuck Lever <cel@kernel.org> wr=
ote:
> >>
> >>
> >> On Sat, Feb 14, 2026, at 5:06 AM, Shyam Prasad N wrote:
> >> > Kernel filesystems sometimes need to upcall to userspace to get some
> >> > work done, which cannot be achieved in kernel code (or rather it is
> >> > better to be done in userspace). Some examples are DNS resolutions,
> >> > user authentication, ID mapping etc.
> >> >
> >> > Filesystems like SMB and NFS clients use the kernel keys subsystem f=
or
> >> > some of these, which has an upcall facility that can exec a binary i=
n
> >> > userspace. However, this upcall mechanism is not namespace aware and
> >> > upcalls to the host namespaces (namespaces of the init process).
> >>
> >> Hello Shyam, we've been introducing netlink control interfaces, which
> >> are namespace-aware. The kernel TLS handshake mechanism now uses
> >> this approach, as does the new NFSD netlink protocol.
> >>
> >>
> >> --
> >> Chuck Lever
> >
> > Hi Chuck,
> >
> > Interesting. Let me explore this a bit more.
> > I'm assuming that this is the file that I should be looking into:
> > fs/nfsd/nfsctl.c
>
> Yes, clustered towards the end of the file. NFSD's use of netlink
> is as a downcall-style administrative control plane.
>
> net/handshake/netlink.c uses netlink as an upcall for driving
> kernel-initiated TLS handshake requests up to a user daemon. This
> mechanism has been adopted by NFSD, the NFS client, and the NVMe
> over TCP drivers. An in-kernel QUIC implementation is planned and
> will also be using this.
>
>
> > And that there would be a corresponding handler in nfs-utils?
>
> For NFSD, nfs-utils has a new tool called nfsdctl.
>
> The TLS handshake user space components are in ktls-utils. See:
> https://github.com/oracle/ktls-utils
>
> --
> Chuck Lever

Thanks Chuck. Will explore this in more detail.

--=20
Regards,
Shyam

