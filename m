Return-Path: <linux-fsdevel+bounces-75131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CF3/LBJqcmnckQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 19:18:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9B26C38C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 19:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 74136301C0C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6279039F31F;
	Thu, 22 Jan 2026 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TIpC9eCY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554BC39DB24
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 17:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102847; cv=pass; b=bS4+H+M+O8MlCGjmh+9CtA1dY9Ljycp4lBwYAld07950nqR4m/XxKYqVw2kOw70vsev5fObFl+376/5IFx5YC8wKutlnPM2LJAIgJe/x3nvPzJT6IKF0Zp1A1FX8neGKvoISWxTSCc/FD9fxxmxQYAR7/RmsQYlGSDmiGok1Pow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102847; c=relaxed/simple;
	bh=i8wRRwgcRBRX/QtBIFh7w+tGkhK9mt5SnMal1LQmNU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s4C36rOyid3162pz1SSx3C6+W3HQKQhCmRVBDnh3mL7MgBGIqUXoW74CllX29B+0xRmLHAyhnAInWLOeBCD8GdB5efHV63bWaz9UWPRWNpv3Voy7gvq7u+uwwkmAhuzOfZcZyOmFmjdYom3k2tXtHDdqJCQuKdX6GKHwvnEtUbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TIpC9eCY; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a1022dda33so8118845ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 09:27:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769102832; cv=none;
        d=google.com; s=arc-20240605;
        b=jvqm/ckvJmmDQzrwn5NzsMQNsAf34EvwCqzTNGA6DqeFKViC52COod6mnDu9ARtnfW
         TIj+LSq3sGoGFI6T5V/2Usrb48nJmJOAGrMEz8zpEyCuZdTDeV77Lhc9XuBC+TkpWQJH
         sKeKXFwjk0CLqphDrPmdLnYw2EhItx3Rje824Yc3dCddD5atdG0rsdsfit1PCPRBlzQT
         GXJQda68Jj8ikDHjKWzlGB7k/Uh3LktwGGgCqSCuBnMenCUaRwvUFj9/HVJcPIpPNeKB
         75WEMEqxnEZ2ZYR6Rr1BScxHn/zXQC24tU+/NR1XeG0z8szkHYBjeI65bZAk4j84YPGA
         gshg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t2OpF/78edG0DEw7aAeFXM5BMMrCw0GoSViw0JiFp8k=;
        fh=HY7522TMcPfLXFPMXmQ3GLgy5AF8Pf/j3v17YkNtC3o=;
        b=UFWNwhpW/HhY9IOk6ZUtrGvXN1A6ZUP7lKFNcrXxhHrMMFG8/TGDBip7iIwyw30t+I
         tIkUueoBsolT33LwF3t6Jlw/7LMfEiGSWWJztpNEn2Lp/vwqc+8IwWzSEx5YjGrj+rZw
         JESoXWlz03fFhHJz3Tk/FRBB2KVZPFXqsamiFd1zM+FL/4lvnCXQx8WINPP3y/5nhsql
         hN2z127KO1K+ZJYJkxwBSj447YYHedHpshsUCOmE9sZEAIQC+8EfxNMGdxupUXAc8bHT
         dL+nSTeszs9SyAO2mlF/Qg6prQ0BmzUy6tsOEdY+S+JW5+xZSfWNDnLGk7kuxVBnbzH9
         yDWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769102832; x=1769707632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2OpF/78edG0DEw7aAeFXM5BMMrCw0GoSViw0JiFp8k=;
        b=TIpC9eCYYmP/8eAsufXnWfk19A6gwFSMJhwsyZO6KpJQLjosuWfxLdcSL4wS1GlXcw
         Ug7TJlzwAai2JjaVu9fkv048nDt7ajKnPypGlD20dtrv2G02hzpL78SewscmE9TcAmlC
         4fWeubFHYy2ub1amXcLOFPoywOWGlp4BVA2a6KX/FnV/6l2IxuBNFp8i/WIdaKFbx95y
         De0TK8thxowJW+DfGSF1QtBadyzK6CAfXiOqu+ENMGrK8VMZMgsBJFqsqi6jCoQw9CXJ
         /jArDod06bGKlyOC2nA7YxZfVFStgPbp0RfcizS2BE5l3vEchsykK3zzHEDXevErnCQU
         UO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769102832; x=1769707632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t2OpF/78edG0DEw7aAeFXM5BMMrCw0GoSViw0JiFp8k=;
        b=CKBH7ZSd7XD6rH2tLFI1MNkSLS2CK3Tb8qU82X6CDL20aKRJ+gXr0b9H9EpjKeOR99
         GuGTj65TwJohXRmIoQLlfHi+WhPSBTQCzhdSGuL5RDrKMfIAXlM78JEn91taPgix6hb7
         obTGgdxHpVYh+S5t01Uc+bG8QAYSgmR6zF3Ma9YvT7eoC2nb8PNHW3v8a0z4YXx/7xxM
         FkeiBCd2kjDhFXa/ciGlrVOlc34RJxm/gq41XtlvC2RpcJ8o0g1FuJPCEPz5F2HFSJvo
         ZbkzTgDPKVrMLqiFmFYeG/o6643ZeTJpoclPofPwW8zj2h0RvAAAYivLczri2JWR7H+N
         SoLw==
X-Forwarded-Encrypted: i=1; AJvYcCXOx3YFRdy1Qg8bPiuq/LKaJSuHMNxaq+0tX+2r9va2cyajoCis5A+IaD/KaJjkXEmTwMU6gvlriXiCCIOA@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0itaEMMzcj7VtHmnOZ+KDNNN8Sf+Gm49KxTT4NS7QWJT/DBiz
	4v7VXbX7xws19A/087eMxwZkIxpi/OP5dBrk7vRyM8YGY2Wndm9o7jmwH8gDdlfLLjRKaVyw2Qo
	yXK2w6E0kivDkgui0unEEn86VFRk/rQUoHiMRIQ6X
X-Gm-Gg: AZuq6aIYw0zD51b+QsQWdCPBjC593/pSBxsaQKdjyYFzBnQp9l03JjU2SRv0lwijOgl
	+hw0kfcncRnkN8Seb5ihNTJd1LKiOP8UfUFfOaj372OcNbHmAilQdcNA1x6P+ap41JJ1W4/G9ce
	xcBnLy8W5iCVvxB5zP+Glck+V3wuc7XE8u9H45PfyEl/5c2Bwa0SoFcdLJ7MZeL3uTt5fYMxogU
	qS0tznMCM0zBM1D8N7HBBoe3jIwVgzwoWtro+R3dq8L+LlUrkqZ6n9sG2wveWRz+uOCYNM=
X-Received: by 2002:a17:902:d4c8:b0:2a2:dc3f:be4c with SMTP id
 d9443c01a7336-2a7fe442a86mr1368065ad.10.1769102831964; Thu, 22 Jan 2026
 09:27:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhsuW4=heDwYEkmRzSnLHDdW=da71qDd1KqUj9sYUOT5uOx3w@mail.gmail.com>
 <CAHC9VhRU_vtN4oXHVuT4Tt=WFP=4FrKc=i8t=xDz+bamUG7r6g@mail.gmail.com> <CAPhsuW6vCrN=k6xEuPf+tJr6ikH_RwfyaU_Q9DvGg2r2U9y+UA@mail.gmail.com>
In-Reply-To: <CAPhsuW6vCrN=k6xEuPf+tJr6ikH_RwfyaU_Q9DvGg2r2U9y+UA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 22 Jan 2026 12:27:00 -0500
X-Gm-Features: AZwV_QibKES0kD4tscaEcwePngrOSwTB4wIlklspWkjv8E3aPoOucAI-iTyzcnk
Message-ID: <CAHC9VhSSmoUKPRZKr8vbaK1222ZAWQo51G5e3h65g135Q3p8jw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Refactor LSM hooks for VFS mount operations
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	lsf-pc@lists.linux-foundation.org, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75131-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:url,sessionize.com:url,mail.gmail.com:mid,paul-moore.com:email,paul-moore.com:url,paul-moore.com:dkim]
X-Rspamd-Queue-Id: 9D9B26C38C
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 10:00=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> On Wed, Jan 21, 2026 at 4:14=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Wed, Jan 21, 2026 at 4:18=E2=80=AFPM Song Liu <song@kernel.org> wrot=
e:
> > >
> > > Current LSM hooks do not have good coverage for VFS mount operations.
> > > Specifically, there are the following issues (and maybe more..):
> >
> > I don't recall LSM folks normally being invited to LSFMMBPF so it
> > seems like this would be a poor forum to discuss LSM hooks.
>
> Agreed this might not be the best forum to discuss LSM hooks.
> However, I am not aware of a better forum for in person discussions.

The Linux Security Summit (LSS), held both in North America and Europe
each year, typically has a large number of LSM developers and
maintainers in attendance.  The CfP for LSS North America just
recently opened (link below), and it closes on March 15th with LSS-NA
taking place May 21st and 22nd; reworking the LSM mount APIs would
definitely be on-topic for LSS.  While there is a modest conference
fee to cover recordings (waived for presenters), anyone may attend LSS
as no invitation is required.

https://sessionize.com/linux-security-summit-north-america-2026

The CfP for Linux Security Summit Europe will open later this year,
you can expect a similar CfP as LSS North America.

https://events.linuxfoundation.org/linux-security-summit-europe

> AFAICT, in-tree LSMs have straightforward logics around mount
> monitoring. As long as we get these logic translated properly, I
> don't expect much controversy with in-tree LSMs.

It seems very odd, and potentially a waste of time/energy, to discuss
a redesign of an API without the people needed to sign-off on and
maintain the design, but what do I know ...

--=20
paul-moore.com

