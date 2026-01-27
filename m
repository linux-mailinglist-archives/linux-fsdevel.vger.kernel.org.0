Return-Path: <linux-fsdevel+bounces-75613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GP8dL0TUeGmNtQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 16:05:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A732D9648D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 16:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 482C730CB5D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 14:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B3D2C21C2;
	Tue, 27 Jan 2026 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvFulGeI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD75A30FF2A
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525709; cv=pass; b=eGZQRnYD34glFe6P660lc8Jm/dru8pS4A2zcrgYn+RJ7ZMAc8cfpbWyL3RWyVQwgt+t/RwPDDE9M/ydNMGNRXxSsArAkgMLkTtK/PhgpMw7Gno1p2ofrgYbGrVDZMMvJp8Bfvv4H65/CoT4ikMKQ1rjiKEoC4PnzAq/J/ldPn8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525709; c=relaxed/simple;
	bh=t2ybBJsNWtFjQaIkqKJiX+bUT4FayuvonReDdoNdNG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Igp762FS/8FOZTJpUuQefj8HndcQPRfzzgVMRIgsqjEihbPqdXnGvZnw6sh3C7Fedp/BD7nf6H9xfFLxXn+AObSH0c46uyReIxz3fyq/mAgJQdumaufkYLIY66du0sI+7OUKsv0ZUuF9hYfz4mPeaxZAOoQgXrIqOENtLH7Wftw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvFulGeI; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b884cb1e717so815771566b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 06:55:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769525706; cv=none;
        d=google.com; s=arc-20240605;
        b=SlWPbxBCi3eOxjPEHw/MOtKh5n7J7qhmLydtEQYBgKXaAXRuSDjOVaZzY4lMuMO375
         MBhUnA297m3cllsD6yzhoQXTpWz1tj364UkmIQWzORbw3rJwcHvEFHHbkLSK95iaaYS0
         nHUvVgZ8nT+GW+LYeVqbNG6glq65JnP6VKzupoG3Bt7+UjzKih9L2dzIZLERqURESxqP
         A2kgsvkvzo2kARytVhcm01J+NNfxsRylv9oGsBqZAo02CnEvmiXnIsrIm7lcNkT9xnrP
         eeKVqpLeqcJ4ux5z5v/aXuQLDK/KjK7v9KQgzn+7oIGH4NxbJnYMxZtdXxOjzs/jY5V5
         MctQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lCtQBBTytpHyzGbCjZPP22G47ZoJNaJiWCn03phHKmg=;
        fh=/T7uFoLg4VsE7F8T+8puRcvM8M7hsXtGFIdS4FGhfZk=;
        b=he2aqUpMR3dqg+WgHfezB1rnq/WCK+e577pEkhWzXn/0I/5CFUM5StMxhm6i4EAXbA
         RlJUMXQ4im10GRn5u3gqDzoxRQ0qjdseeGpFpEIH2rhaokWWZ0rg0MMooJvLn2FKFHzK
         nwj0jaBSJWz/EtDBna7JChE2wiwFldsyg8e0qtgb3PGPNA45OCKKV7NlomN34v2WqyCy
         k6V7RVfZWVoALVwNyCLpJ/2rcxO7DtrphTpm3MteJNt8nanvTOrlq9lIJqWei9RvocaM
         Ssa2Bcp5RRFJ7eRN2mAWTTVB5TQdxj36kr5DASTWQ/hvMHDq5E3MEPAsqsUbjDg+5/Jr
         7eOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769525706; x=1770130506; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lCtQBBTytpHyzGbCjZPP22G47ZoJNaJiWCn03phHKmg=;
        b=GvFulGeIrpJtBdSxwyjbfkhzgapKKMMVosbvI57UYBPI3aBbqCPmlDshU2BQeOeaH5
         nfKtfsgJqvSAr0xHpI+/qEtslAyIdDVwAJ8uMAL8caUYV7kCfHHx4iAthN9KunwhReyY
         PyZ9/BXHWpcqzo6bjfGxCyG+3DzRX+wtkVK+x0pz8VhEZwc4TUtpP3r9d8HJ19YJYDso
         +6utxDOUnhtIxerovJgQaRIE9joS5rywwPEeu0d+tbdGCH6OBFMiB9yw9Trq6dwJgnw6
         31xYd1sw5pCk+mkro2/D++5IYVlmCceH24urBYAVJBxqFwlS8/7GjoiiM6bDdVts6OrD
         YTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769525706; x=1770130506;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCtQBBTytpHyzGbCjZPP22G47ZoJNaJiWCn03phHKmg=;
        b=ZOK5nVpLGJWTbXeeHAEUA0m/vYB07r4uIKggXUVkAjKM+fPJ2+7J4Qr1VavqsPa/xO
         OuyaVXGutHQSyEhMMVL7htKl0TWY7nqSYqEVFDyFFGMhZrMwAwgNJXUUWwI/sZl63gy0
         npfHkcd1VpKv2NOioCU+quAoaPVnvEwe11dwqzU7VFMxDF1k89T5E1/UmJpHG2aT2GI9
         JutYxSVxNSMW+ddkmEA5unYypqwwYJ1lW4yGsGlj4htJqN0w7KWA4kzEc5A4R23/ju8S
         zgS1d6E/uy+4U0+qz1VweyGzJPxqsQjjFIdW9ZIxTMZiNHJzctrXe7fTkcOuNvhi1VFL
         MVsw==
X-Forwarded-Encrypted: i=1; AJvYcCWEPeG5zpde65EQkpaWitMWiiR5+0PVsu4qmzFsVFF0NXYuid7TMCixh76PhWBDQvFGlGmukFZUM5mBA/Up@vger.kernel.org
X-Gm-Message-State: AOJu0YwktMY/YO6Mb76NB8ZzJRvl6DhSTE/AJPgbwHXUW0gmJ+26jOkl
	d3+mSTRYXuML6870597IjeVxOJrLbk6V9XNfqVLi0800aWwwRaMx0wWQyFOG7mJFRNYGwiFMcwo
	QrsjvNUcCSlc3I6y4Er97zx0XDv+0gg==
X-Gm-Gg: AZuq6aLjhF8dBdoLPYTHU5FwV4YuxcBSnvPMjenEWSsQSrVm4pLYVmCPEB6qfhXxKTP
	T7tDM3PJeCg7aoNc7IY/KYzeE3zUzHhU422yOqU5NymIjMPps3X6NSZgnRAGMN4TPzj6YvM6Qaz
	1crdJdvlZsbyukWwkMkU8nWrHmSQOLil2NAYgTFw1HL7TWqlcF/3FhCK2ztVudpfACtQ2m3Mjlm
	JCYG9JeO55R0iuI5AYtD9QvVb4LCchfmcJSypYrnlnqmDCjClOdlJZpLLuUO7PyjYHmGWg62VXR
	eHPZlGmx7dlxIV/mwkEkp33GwCHWmmGARBiwQpLoxPlF9W5cr8Lpwk1GZQ==
X-Received: by 2002:a17:907:2d08:b0:b76:d8cc:dfd9 with SMTP id
 a640c23a62f3a-b8daca2128fmr161653366b.18.1769525705537; Tue, 27 Jan 2026
 06:55:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121064339.206019-1-hch@lst.de>
In-Reply-To: <20260121064339.206019-1-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 27 Jan 2026 20:24:28 +0530
X-Gm-Features: AZwV_QgrOpVy11EguRWdouecQbjVaZ_wK6fgRNHqWm4H5Y0Gztccb7HBO3aIMrA
Message-ID: <CACzX3AuDkwEw3v0bNmYLk8updk1ghVJa-T9o=EHXor9FA7badw@mail.gmail.com>
Subject: Re: support file system generated / verified integrity information
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Anuj Gupta <anuj20.g@samsung.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75613-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anuj1072538@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,samsung.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A732D9648D
X-Rspamd-Action: no action

Hi Christoph,

Here are the QD1 latency numbers (in usec)

Intel Optane:

Sequential read
  | size | xfs-bounce |  xfs-pi   |
  +------+------------+-----------+
  |   4k |    13.62   |    7.2    |
  |  64K |    99.66   |    34.16  |
  |   1M |    258.88  |    306.23 |
  +------+-------------------------+


Samsung PM1733

Sequential read
  | size | xfs-bounce |  xfs-pi   |
  +------+------------+-----------+
  |   4k |    118.92  |    91.6   |
  |  64K |    176.15  |    134.55 |
  |   1M |    612.67  |    584.84 |
  +------+-------------------------+


For sequential writes, I did not observe any noticeable difference,
which is expected.
The Optane numbers at bs=1M look a bit odd (xfs-pi slightly worse than
xfs-bounce), but they are reproducible across multiple runs.
Overall, the series shows a clear improvement in read performance,
which aligns well with the goal of making PI processing more efficient.

Feel free to add:
Tested-by: Anuj Gupta <anuj20.g@samsung.com>

