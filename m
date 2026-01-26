Return-Path: <linux-fsdevel+bounces-75545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eM+mIJ7md2k9mQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 23:11:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9498DDFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 23:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76A0A303EAA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 22:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08A02FF643;
	Mon, 26 Jan 2026 22:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zs9LA8kU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E83E2EAB82
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 22:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769465440; cv=pass; b=B9gMhgZdykCQDoERg9LUQWOqZMTRib9hoPkQj5RHYFKNlUPJsJV8GImzVsIkWW2JsHll38TwNAoV6kKrKf/jH+GA288ZcWpzlNcvCUK0F5mDvyvAbWtRP+C3xUUJZnxT0VWA+/vylqVU8ZotB9hfDmLm2HW46AAI4cDNm4emmvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769465440; c=relaxed/simple;
	bh=KF042WMwtWjjl4pmi595H1OUEPLk6M01DQjVf67rgNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hh3cQRxF74ooYNSRxyUxj11Nu1rbeAULbgjanUYUEqSfH51YW+SGdQJb8CCvAyscsAxOxvXkUuSMrePHggU6ed0BF4Qh3IWw/fjET0NbOQFqWrrAvPzIbjxdgrytZ0NYF+PhwbAe5P2KVapwPGu2YvrykAB5RaUflWTjfxhQljg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zs9LA8kU; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5029901389dso46194311cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 14:10:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769465438; cv=none;
        d=google.com; s=arc-20240605;
        b=dCp24nbNfUgbSJyAP9SYkZn9FTjTs8Izyfeh9ANLczY1uY0fN1bc+0/tJwHPa+pFbS
         nuz465tCuSqCWTIbVyZmG0XqI/ArFAjML+43R3v5hzFiDWb1x38NsdxdXQLaPUZesVL/
         EFKOBv5Y+5OTG37scuREA8rwJvIdTkh/avHkbehtoYTJlabm+9W8J4kSD2vx1BPa1sbw
         ETNryprwEatyuru7f/cGSMzM3fXKyZ1uvHpb4BfLxu83WpZhoHVvvFSBScIZxm+dY84T
         P8IlzNKeOOeWkrWZ+0s/0UkK5nUf4HYTw7Dm49ANCJjVkYbZe5xmxZBxLRF0HyEE99PK
         knsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KF042WMwtWjjl4pmi595H1OUEPLk6M01DQjVf67rgNA=;
        fh=VOsUtuvV4US2hsmiZdf5MuxRIkyZXnMaI7nG5X3egt0=;
        b=BvElyrlKjjFMVulcg7FA+KL6wr4dFatitp4GOwbDRWi1B4xxXlaSdfQk8FZIjVOXMQ
         upA9W7/N3ob245lXPWT3ZFq4KxPRLC6t7ku9FNWEKG1vIjKj8P4JXDW9u6L2cCPLBIxO
         pJlMqCCJPuViNXT7XYA/nF/FKhFH29Y/ckfibXLCZNXnipCi63hrnU7boViKlzUGr1AQ
         49u/L0L2cubEZTQAYgqZB5W+p5ZhaD+IXoFLZH+Out4KrXJfj/98E0tHyHpCjV3R5mWp
         ZJsES3eh3I0kR6MR3d7VoNYmn5Z5zop/XeihdcFOQ35x6t3CA2vVZhWkYyNLnTdJSqlQ
         xC/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769465438; x=1770070238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KF042WMwtWjjl4pmi595H1OUEPLk6M01DQjVf67rgNA=;
        b=Zs9LA8kUhpxFmX5Fd90KEqFuA+rht4JYcIsfD4eaqelgDVtXfnF1exB9JiCgshO10u
         RXooaYm7wgOyD9R97kizuZc7j6/TB1DWbRVN7jv7lUa68Px8aYOCDyXMU+wwDvG8AKHY
         7JTEAjBGJH/uP+EaT2PtzJig6+OM6TflSjfmUpzbFQsy68TTTtnJRC4jOpiy0aZ7Whqt
         9uqswBIUBWOJywMcdp2le+O58puf8sQ2fAEf0wXH0pSg8xx9DoKAxX+96ppn3rSHqs2m
         pRB/BxH4d4jenKiJ7Mkrp04J/ZQG62alSViASxJU3i68Y3lE8hSs3hkJTiEFn8wpPIjO
         S+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769465438; x=1770070238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KF042WMwtWjjl4pmi595H1OUEPLk6M01DQjVf67rgNA=;
        b=V8PDzsUGi7j2ElcOyKk/wqNwJZ5s83dbpmni6VjbFyLxDw/I20DQ5OtRET3/LDyBhY
         rqn4qELT7pNfMHFUWG8tXf7u6Pt1vG2OcZiahb1pHMAQZLi7AQz3vMD5VS+akI6GeU9v
         s6O/2F9E5aOuvWEhYmNp4+9paCixzw2eLkHMaQK2vT9nws4a6nrt6o+1zu5ya9WXPjGK
         0LETqg62oaHyzrxoRieo7ughD7xbC/7Yib1PqEvq75CQ8V58K9PlQ5AZ1+atZIXnQ5G7
         HK3bdsAAIkaU/n2+p9aZR+QQOYhznPFeZoO+OPqlgLsORx6flYe/OhLYVy3+n53IsP/8
         Ra+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAXAsM2tasA2lJ05W2FwZRjk5yJKyXlWPBswPA/wcMxXR0+hnh9MlpwRY13LWqveBJ6pMj9G9c8Rjuuur0@vger.kernel.org
X-Gm-Message-State: AOJu0YxePcyyOxkJ4V+lMBwfeIecQ9r/XVDMO3pFufPurvqwBFQjazXr
	tPmPGdYBOcOlG51pwHntAed5cL+vzWVAp50Y7SOiCIJRNBywmvNfY8byJddhkQ1w/1ow0bEQbZu
	YYaDPhJgQzu4UlnxS2FlnQvj9F6Wz9yk=
X-Gm-Gg: AZuq6aKbtcGVUYE0TyQWTbAqmorcDOSxMtQ3H1Ol3ISLg7HlchH3ni2wuwDaicDzwHB
	C54GlHtaS3Kj49CehF1/4H+QI9+Jlq4d/ZdGhdmvIhbEawM5ZjVhlrs5FZZoyN4iaf8/jKA3MF0
	y5JaGE4INxFGZzUQ2HflIRWxEL2qBOKZcFVvdcyOkoO68Bvn8HXV8ZH1kiRY2IUoKvEmghJx9S6
	jDE3lvVSJQnW3mupyuBnMISXQFMRYQx69Q4K7i1MwCXNDCpM1qZP2V3nKlAM7CRVo/RklVcKZJB
	fmOziV/BP90=
X-Received: by 2002:a05:622a:153:b0:4ed:67ea:1e5d with SMTP id
 d75a77b69052e-50314d183femr74501211cf.53.1769465438095; Mon, 26 Jan 2026
 14:10:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123235617.1026939-1-joannelkoong@gmail.com>
 <20260123235617.1026939-2-joannelkoong@gmail.com> <aXb_trkyt-uzdIkd@infradead.org>
 <aXeAY8K12KKf9d4_@casper.infradead.org> <CAJnrk1aQ8s04Co_Ncd41EpbMJEexPEF2qtAhGnG1rop8LLvWHA@mail.gmail.com>
 <aXffs1jcO0u85KpO@casper.infradead.org>
In-Reply-To: <aXffs1jcO0u85KpO@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 26 Jan 2026 14:10:27 -0800
X-Gm-Features: AZwV_QhVczB5tnXCYY7qpjyJZXN17-uPtrQ8reifcF72MabuKLY394xg27LW-As
Message-ID: <CAJnrk1Y_WAHbq7x+MYvuzsW3FbiYxO7Q1Up42Lks3kOoHiYgTw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] iomap: fix invalid folio access after folio_end_read()
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org, djwong@kernel.org, 
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75545-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,infradead.org:email]
X-Rspamd-Queue-Id: CE9498DDFD
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 1:42=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> > I'll drop the change for the new iomap_read_submit_and_end() helper
> > and submit that later as a separate patch to Christian's tree.
>
> I don't think it deserves to be factored out into a separate function,
> honestly.

I'll drop this altogether then.

Thanks,
Joanne

