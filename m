Return-Path: <linux-fsdevel+bounces-76379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDgMHG9jhGkM2wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 10:31:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C227BF0CAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 10:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 298C83005D3D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 09:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDD33921FA;
	Thu,  5 Feb 2026 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ofk9IZTB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80B0361DD0
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770283686; cv=pass; b=UOQdLpg9DTKS2Gs7+rDsIMNG27GyBkxS4iW9uzaiwjZ7ZZuw57xgnvYvp2eH//XgSTBQIFNsqaF19mdllbMr6mD8LeC/uW6zXeTzQHvy4Hdp56ema/yd8a72kLyyrqvmKY8T9bmbTmOTe/+532yVayVs8UbWbxQu+ocjwWD2enU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770283686; c=relaxed/simple;
	bh=gLtGWJSudW6YxgHcGJSc8B4NJH40TO/x2/44PMVla6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LAbymvsglXI1X7SZFg9MdFFiuB0xRfmcayqOT7rYSIIM2uFvwxSq72fHMCg3gTZOHo4Ei+UF2jbNcOaxO0V6t7ki5MREfYwti34PeaRgk2mPXCZRRB8GNouc+lLLY5nXBAcbJoNPj90vPFhUPYCZhCfe56B7jwDS48t37MGhqGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ofk9IZTB; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6597a7bd7d6so87101a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 01:28:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770283684; cv=none;
        d=google.com; s=arc-20240605;
        b=ikmvf4gzsXiXujdf/DHANVnOXPjgZpX8n0CLUjr8Z1RsbzFMcicwMQHokban3ZpmQt
         /jguin9zBK7m2WaJlkXOvV7p/kebGJ0qW28Jn8xJRbra1Bq71nm4vwhQAvENE2Sh9Ciy
         6yEL4cSmRLTkoQfPGol10NOJ8tLQ9XkrfC5ujePeQZZuDvwFHviGcPvMl8rwONzw4273
         q+NFaUzGdE6VvNIgrZYHRNkhDxPqWHZoZGd7eVA87TKR1B1aCUlTzcQUs73h7QEJXQr5
         sywpkv8/Bt3Lci7BBnregTo2Nvw0EcETYoO22i/vOHhqm5hwIGWiJwa8mauPze29oq5r
         4b2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xM+ySPLTh5y0cBU3PAJKP5UDzQbU++C5n24/oevIMb0=;
        fh=fr8gfTzu6HoxN+5oPlTkOokKel7YhK6+DfeRNfzrFp0=;
        b=c+fhjWE2qhnioxKKwEkIRK6999vXHQTL92YQY7Fo4JHsAshq8tnHSrV68XA5IS4I1w
         M/ZTO8haZYoqT3PngtpVisqcFQjTlpg0OfCC3qbL9TnyU8HJFYESn++m66UvI9ED9+4W
         I0EesPuTmFlrKAlkEFwaUrKeBI4tS0Qj0UxadZ6l6Fy/ZdksM8rHdzgzXtln/vNlP2Hs
         diiarOs4AS+nqD42OusHCrCHCTmvjYCuEbnANlDvd7BCi8XUcYaAGrVMOgp9ZafBYfgW
         mQx/k3UK1jeT1AwowpffuOUm2RPQpugA+4NpkJJD38H2yG+Oo8pAln/OBBa3uWI5yvK2
         teaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770283684; x=1770888484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xM+ySPLTh5y0cBU3PAJKP5UDzQbU++C5n24/oevIMb0=;
        b=Ofk9IZTB5IZuoUEPIYMSdhy2N2kxbRjC4l2QzVf72UYTqMRXi3kr56ph0jzWcDoBlk
         pSh6Wo6JTmheOIYX9ohaUhBFeEg4najr74kIW0NKbzdf2VyKR3yhNKYH4yDMdIfjtbDx
         d43PqUXXQK/8G4XTGl21vW6J4XxcixprLZQ56s5xj8tDG5+OFxbCOW1YiWnyAC4AvBIV
         xUZp1qwF6RCdYweApT/mP7WEhDlLNN5kG54ntwqekhqtygFHyTZDA34bpNZPOCW5XM7k
         DiZANUnQmOaLlr57tfKb/mAwVG8lNSPJEYvy6mCC3tq4ky/7/oiMz0Txosgny9lDWTIh
         +BXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770283684; x=1770888484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xM+ySPLTh5y0cBU3PAJKP5UDzQbU++C5n24/oevIMb0=;
        b=no6VTSdzwHehkpW5fWFtSIagwXOtocvu+6GzDDNG/2SsdYcAJCc0HVkYwqy+cJ0DNA
         rq2GbC8YDmt9zioaigP4S3jzoMEPYPvJCT0x9fgHchIQnwKop7PrtUR3ir8fOLTYx4U5
         ZfqMciFQxVnuIpQ1ABip+55QiEk6YEI4siM7ZU9ZkyVum2O621jen6bprcQq7XAGUS9o
         r5ZKaERXLKlwhALwilO3IZaUInyKpaMqrHmKl6z8dj7uwmRU+H348rLX45VEZffcJBEF
         qAygKjsAuYv0zlM5bpHuomJjGPNOE+xBT3sB4qygpDxmnX2eCUElvcn01NqtIPXk5/qm
         a9Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXDFkKLh4cuYI507fsLb98yXgInJisJ5RKF5dQshEVZ/eEXMDbTmjQycFCg0vc2A93xz8EOTPxg7VETzHyp@vger.kernel.org
X-Gm-Message-State: AOJu0YxMRBSFEj+2gvDQNunLqOhVhWGlS49cCsKO18BEVEDal/EukI+Z
	7UcFbDobs+OnxUS3yVRDu30jieOE9/JI5ZsOBj4s/nz2JYbReo8TX7oj6PzLf3rtQtCAzQ8D6k0
	7WMgZ27BstWZ16h5NPF/OUXoeRxygWDk=
X-Gm-Gg: AZuq6aLDWy/luC/PaM7P/HSApoS31ktAdZggS71Kc6xtqx3UgC76GbNgi1VCCw1WVKe
	qmBQRmUJpZGnnyHwxSBDTI+TogBtfNlNxGmVkipkgfPxJP+INdxwL/wapRdk8p1gS89VqHQApT8
	PrLjbY2vmZVBVco9uCYemuhOHjs6K63bKg5AeYBolJeFRYmicQKZqPIAxSkwe8AwDCn63fq/OGR
	TlnrO0x5+xgkAiNNt0HhI6T6vvpZFsfidocLhc69DFv+TVTt07QuxhEwukTGSeFp2jDZsQRHkoS
	oBNQJdT/wrD3RuA0WiOWt/7W+BRFTA==
X-Received: by 2002:a17:906:eec1:b0:b87:2536:fd9a with SMTP id
 a640c23a62f3a-b8e9f396528mr412083966b.59.1770283683695; Thu, 05 Feb 2026
 01:28:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <aYQNcagFg6-Yz1Fw@groves.net> <20260204190649.GB7693@frogsfrogsfrogs> <0100019c2bdca8b7-b1760667-a4e6-4a52-b976-9f039e65b976-000000@email.amazonses.com>
In-Reply-To: <0100019c2bdca8b7-b1760667-a4e6-4a52-b976-9f039e65b976-000000@email.amazonses.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Feb 2026 10:27:52 +0100
X-Gm-Features: AZwV_Qg5w8SQmb-gp9zZZXQk6O6tOOaGFPAlJAw46x2YMnuS5JAyQAbEt6547yw
Message-ID: <CAOQ4uxhzaTAw_sHVfY05HdLiB7f6Qu3GMZSBuPkmmsua0kqJBQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
To: john@groves.net
Cc: "Darrick J. Wong" <djwong@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	"f-pc@lists.linux-foundation.org" <f-pc@lists.linux-foundation.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Joanne Koong <joannelkoong@gmail.com>, 
	Bernd Schubert <bernd@bsbernd.com>, Luis Henriques <luis@igalia.com>, 
	Horst Birthelmer <horst@birthelmer.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76379-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,szeredi.hu,lists.linux-foundation.org,vger.kernel.org,gmail.com,bsbernd.com,igalia.com,birthelmer.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: C227BF0CAA
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 4:33=E2=80=AFAM John Groves <john@jagalactic.com> wr=
ote:
>
> On 26/02/04 11:06AM, Darrick J. Wong wrote:
>
> [ ... ]
>
> > >  - famfs: export distributed memory
> >
> > This has been, uh, hanging out for an extraordinarily long time.
>
> Um, *yeah*. Although a significant part of that time was on me, because
> getting it ported into fuse was kinda hard, my users and I are hoping we
> can get this upstreamed fairly soon now. I'm hoping that after the 6.19
> merge window dust settles we can negotiate any needed changes etc. and
> shoot for the 7.0 merge window.
>

I think that the work on famfs is setting an example, and I very much
hope it will be a good example, of how improving existing infrastructure
(FUSE) is a better contribution than adding another fs to the pile.

I acknowledge that doing the latter is way easier (not for vfs maintainers)
and I very much appreciate your efforts working on the generic FUSE support
that will hopefully serve the community and your users better in the long r=
un.

Thanks,
Amir.

