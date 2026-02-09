Return-Path: <linux-fsdevel+bounces-76694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFaLKyu2iWlLBAUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 11:25:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F18B10E238
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 11:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB49130058CF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 10:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9790366DD5;
	Mon,  9 Feb 2026 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYZHI3PM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBD5366DA9
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770632745; cv=pass; b=ul0pwv3VULDptrv9NnOMM3WseGwL/dF1Zlli7fLlzVvlmDFhVGEM11o4m7sMZRhAv8PX7vkuZsTXmwGqxRcdb3PuLVY6sPCxKr++cLzurURmqnk5VPxVWf1TM1wJC3tV0hvO1EvlCF1kbxb+bPCw/xZh8LmKndRfaCx6EQohWlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770632745; c=relaxed/simple;
	bh=jJ7Ja3pq8GlBQQ3yJIz4WpWIK3mpfgNIH8F/1c40ZSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJqUEO450WnTMR6wAPONxrNcfEG9acAVxwSoAOKI8+emfuE5dNm5Y4F27VvdhXpy4hQrRqQ/57OynKGdpML06IevDp1X7YUjgTVr6zRUfLsVFk8PCHFORFA/+Z/ESeyxeJqZquFrmBE7D0BVlkfzJo0eVbQkqGrIvO3eLgOhmTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYZHI3PM; arc=pass smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c70ce93afaso451187685a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 02:25:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770632744; cv=none;
        d=google.com; s=arc-20240605;
        b=GZexYy76mdJCS2cPy9cub9AeVOu/4t9AmFfi9+gdzzFfJI/2VmfwL7+m1YVtiFmTBg
         PMCnqQ6KRWGiQ+a+1narxNJXrFtnytT2NqmSovhit7jiCSmMPUeAxrUCDruo3NEIYXlV
         CAP1gPqcwe5Ioh3lSrV/RCLwBVkQzcGveUnBxjWlgBd41iU4NWAxIuBea90NXDZ/hHhQ
         B1YOsTYso48kpxmZt/oSIEzaQt6xIRGNnbzJ5n8nG6lZkVEckGVrdCdGTATurs0oBgbi
         V9jfiWv8m7UzngQNQosI6sqOwF84FBlb7r1JXQouyt55QutXv4eJmaGPd9Dl1PfASdUM
         DuOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jJ7Ja3pq8GlBQQ3yJIz4WpWIK3mpfgNIH8F/1c40ZSw=;
        fh=tUkZjD6lYUkdqwPFVAyeCWDVXnDJ0V8lu7MrDLLdFo4=;
        b=IiHio0BupbFFTC0i9mbyE0HlAw/QNd2o/pNJE0bmBAaGJd+RNdS7jrEu4V/qtl2ga4
         gqSLQ9fHZQSrZM5P861h+upptMf1G2PAPBthCYsmgKdCIkqEnXqG49S0RXCzTUGDmomU
         Hn1OoD7KxlWp6nRPfHJz5PO3LJrP1O9Rj0LG5Pmb3KPMbEBROTlMFNt2c/ozk+CjUOOm
         czvQzXHdaxFqjq4+eEpTEQ8SgTm1RcH/cZLbCrpkqm940Snjo9p0xCjqkpitAaXDEgC6
         fhVfObSQCf8gkDpKcz66Jux+f6pa5UgrSs78xOG15X7fYeiLhKdMqaD8o7QO5ou25BF9
         ULfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770632744; x=1771237544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJ7Ja3pq8GlBQQ3yJIz4WpWIK3mpfgNIH8F/1c40ZSw=;
        b=MYZHI3PMILq5HL8PDZP5ejZGrQEI5ZK7N6CKav/oTjC7LVP+Gk9Lr2lpw/MNQEcK1I
         kde/JoChO2oHEmDHadQZJuTmgES9h4mZizkWvytpbxT8+6Z0vbAaT95FnSlmsk5ntMu2
         br+jBWBw6h8FcCIx7/mibxr9FtezEPa5+s+qlP0fqZUKIbFLIWVxA+n4PmuwfRuuqbFL
         /GzdNghfTi/5vzO7zF9zyOQVDWNnebux7hLdMxQ1dSNAo8wADj7XMzDdmdrAmPDF5J0m
         RZTRk4GHoKNk/DrQ4CZ8S2Esj9SEy4Tn3gChwqrD6LpvAktx5JI5LLxBHA4i5FwGXCti
         Euiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770632744; x=1771237544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jJ7Ja3pq8GlBQQ3yJIz4WpWIK3mpfgNIH8F/1c40ZSw=;
        b=rOfyD0QTlshPZEvtRSEGYMofidywnQ0SoX4i08qbadbGu+yUiDEc9KTbmfKO1jEEyJ
         tWHbEaGYdaeplXzAPfucbS2Pg8RSXTRHqO8VA3ARJSshFCp6sAUZ36OETExs0iLNwGc6
         B8V3kEfxxe7cvNlyBX5k9MqC5ocjkfEHdia3xV4MQeis2ROTN8xQiU2289a0FYCI1ArB
         IzFbKWPPd72AloUJQE8BzmKkdSN7DNY7JM1Ma9Y9Peglndxg0etGgCgkOf4WoQwqqrTW
         eCRSqbg2rH9krOibYS8vgfSOAU4YAfe8DcgoW7uF5V0JtAa+2VlNt4sxn4kXa2Cn1F74
         dbpg==
X-Forwarded-Encrypted: i=1; AJvYcCUpzhWtguEnZwP7Q9+PqUzJb5AteLwpyn86nffYpgchjrWXt3NQzlPyI8Ake7jMWzxw6M2MSO+jpw0ZxhPu@vger.kernel.org
X-Gm-Message-State: AOJu0YzInuxEgDVbnaNFmfEjbWKIlggmawLoRuQqvEbl9wEIHnJhTMQR
	0oL26n3DcFS4Y5IevNibtzLGWlfk68CY/4uBvO6TblSv7gHVBK67btdGY/e1eNd0PVMzjNnIe0w
	6HbaM/yUn1/QGVcUhvH3hxj0GZ01gnE8=
X-Gm-Gg: AZuq6aJHHuGPbFaow47bn9l1JeZinDJhiv/WMCWmXmK5+i51wp9ZB0UBkofI5GFXiQr
	ezd1xLEHv9/Ut2iNttuUUn0IXS1LRJbGQfVbSnvSTb7BUV1jn7Zi3IAES9knu8/2y4BXgUFbNBB
	lK4fR9qBzj/4e+guAD8n/JOpWXvTIvZjoZWFtvzKkhCxmcWLX5hajCLxT0Ad6A1QtF76KW7eQNS
	E7ATfVEjWLHtlUvCEpx3+zEXjNEfNGYS6K3pC2ek/h3/ROO26r7JuT9YJfSejtCH8VjnA==
X-Received: by 2002:a05:620a:2a14:b0:8ca:7b14:16d2 with SMTP id
 af79cd13be357-8caf1acb32fmr1351403485a.50.1770632743882; Mon, 09 Feb 2026
 02:25:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <47d21a6821c4b2d085f7b97bcdaa205bfcb0e0ad.camel@ibm.com>
In-Reply-To: <47d21a6821c4b2d085f7b97bcdaa205bfcb0e0ad.camel@ibm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 9 Feb 2026 18:25:31 +0800
X-Gm-Features: AZwV_Qhl0qsSwOQgOMCI7xSnmG-ncwg_fyRrIRycUWmzs6NMP7bdVr-wUKZ6eRc
Message-ID: <CAGsJ_4wgG6-FvDbLw4De0r_vPO1fTH_69A2VyntabmS6H5ZM8Q@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Machine Learning (ML) library in Linux kernel
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, 
	Viacheslav Dubeyko <vdubeyko@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76694-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[21cnbao@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F18B10E238
X-Rspamd-Action: no action

On Sat, Feb 7, 2026 at 3:40=E2=80=AFAM Viacheslav Dubeyko <Slava.Dubeyko@ib=
m.com> wrote:
>
> Hello,
>
[...]
>
> The continuous learning model can be adopted during training phase.
> It implies that kernel subsystem can receive ML model recommendations
> even during training phase. ML model proxy on kernel side can estimate
> the current kernel subsystem state, tries to apply the ML model
> recommendations, and estimate the efficiency of applied recommendations.
> Generally speaking, ML model proxy on kernel side can consider several
> modes of interaction with ML model recommendations: (1) emergency mode,
> (2) learning mode, (3) collaboration mode, (4) recommendation mode.
> The emergency mode is the mode when kernel subsystem is in critical state
> and it is required to work as efficient as possible without capability of
> involving the ML model recommendations (for example, ML model
> recommendations are completely inadequate or load is very high).
> The learning mode implies that kernel subsystem can try to apply
> the ML model recommendations for some operations with the goal of
> estimation the maturity of ML model. Also, ML model proxy can degrade
> the mode to learning state if ML model recommendations becomes inefficien=
t.
> The collaboration mode has the goal of using ML recommendations in
> 50% of operations with the goal of achieving mature state of ML model.
> And, finally, ML model proxy can convert kernel subsystem in recommendati=
on
> mode if ML model is mature enough and efficiency of applying
> the ML recommendations is higher than using human-made algorithms.

Hi Slava,

Do we have any concrete examples where an ML-based proxy,
together with its userspace ML agent, has demonstrated
measurable performance improvements over well-designed,
human-crafted kernel algorithms?

Such examples could be in scheduling, filesystem I/O, or memory
reclamation and readahead. I think having a real, data-backed
example would be much more helpful for this discussion than
reasoning about an abstract framework without a concrete use
case.

Thanks,
Barry

