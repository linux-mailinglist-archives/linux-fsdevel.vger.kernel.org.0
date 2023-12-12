Return-Path: <linux-fsdevel+bounces-5639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D1E80E7F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 10:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81F028097E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 09:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F79758ABF;
	Tue, 12 Dec 2023 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhoSrJiG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72395DC;
	Tue, 12 Dec 2023 01:41:51 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2cc2683fdaaso14240131fa.0;
        Tue, 12 Dec 2023 01:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702374109; x=1702978909; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aVLRsdYbktegNzx/Zud+ZtI8big1fblrhu7NGAxTQAw=;
        b=UhoSrJiGJ532dSxRZ2GtlJrhxqA0dRydAXdnIBka2HNV1twuSCEKnei3fPhee36NY6
         2joh0ZQMyfPIfYOCLG7HcWkyhqEc7YirrMNToT2UV0lLBOHk8mPsPfm6Gy2KLwre/2DT
         zAWtfD2iMNDgksIbPyExEb+5q4HvFOiNfKq1Ve+8IpId0TYHAOUaFb9DTi8y4hQM31QN
         2C6sxplfUCs2ab0QwOlUFLd1kI7oLy1J+7Vwj8QCN/EqS8xkjBU8SdFhlNtThpSRvFer
         aPITmU42fi+Q6SesVvTAYnWyF6DUR3qcC+26BJeSFecqL9UsPTOjVd6qivnk6nNiEyEt
         a0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702374109; x=1702978909;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aVLRsdYbktegNzx/Zud+ZtI8big1fblrhu7NGAxTQAw=;
        b=tN6IQ8kSIxek428Gb/0NOXylznFtDN3oAJ8iwlKHdVXrrw5eR/sEWo0Dpiy1WdgJ9h
         Aw/nrL8q8Q1lmTQSg+XCHrV/m50NxAXtzOazOie3zFgcDQtNVaAXASof/nW/urBpll/J
         +LpA7dfDW6wDQTXPOsk6iIIsN4qcgZsBaXguQDjJu9fh4RwnH/vN9RhT9A9EM3p7kFUC
         ElOwS00JPWus5rwg4F60IWXAzLgJoijapFhQJAaTNCzLlSrxO535yKlvrkM0DaeGZBWf
         CHdTjztCwyFlP8vx/lLXjt4XPpumx4tQ149o3p9wWqUy2guShtd6IAlv76vSMjtHBD0P
         hYUw==
X-Gm-Message-State: AOJu0Yw6nnXDUnMjn0DdSbksbYQD15O106D01+48OMKrKFCjUE4g8fa9
	1wNHZuVxSNVHocWjwpBUwdPJyYP8Qo5P7A==
X-Google-Smtp-Source: AGHT+IGjFCbfOwwOutwRYz9AG4gY6Bjb3gwTl7okXn4Z2UZjyVCgGejFArR0xoCO2FepI8R+GuIWdg==
X-Received: by 2002:a2e:be83:0:b0:2ca:135:2204 with SMTP id a3-20020a2ebe83000000b002ca01352204mr4525370ljr.16.1702374109370;
        Tue, 12 Dec 2023 01:41:49 -0800 (PST)
Received: from dy7lrfj8vfr2jm7whrhxy-4.rev.dnainternet.fi (dy7lrfj8vfr2jm7whrhxy-4.rev.dnainternet.fi. [2001:14bb:6d2:e21f:9123:ac75:6e46:71a6])
        by smtp.gmail.com with ESMTPSA id l25-20020a2e8699000000b002c9f16d5da9sm1477738lji.95.2023.12.12.01.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:41:49 -0800 (PST)
Message-ID: <d523ca40916a8c17ea8ab6d980265e2985e094b3.camel@gmail.com>
Subject: Re: [PATCH 0/3] afs: Fix dynamic root interaction with failing DNS
 lookups
From: markus.suvanto@gmail.com
To: David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, 
	keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 12 Dec 2023 11:41:42 +0200
In-Reply-To: <2810523.1702371786@warthog.procyon.org.uk>
References: <59be73c8346ca0c0d6feddcdb56b043cfa0aea4d.camel@gmail.com>
	 <20231211163412.2766147-1-dhowells@redhat.com>
	 <2810523.1702371786@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

ti, 2023-12-12 kello 09:03 +0000, David Howells kirjoitti:
> markus.suvanto@gmail.com wrote:
>=20
> > Reproduce:
> > 1) kinit ....
> > 2) aklog....
> > 3) keyctl show=20
> > Session Keyring
> >  347100937 --alswrv   1001 65534  keyring: _uid_ses.1001
> > 1062692655 --alswrv   1001 65534   \_ keyring: _uid.1001
> >  698363997 --als-rv   1001   100   \_ rxrpc: afs@station.com
> >=20
> > klist=20
> > Ticket cache: KEYRING:persistent:1001:1001
> > Default principal: .....
>=20
> Can you "grep rxrpc /proc/keys" at this point?
>=20
different cell though...

masu@t470 ~ % grep rxrpc /proc/keys
23e16cda I--Q---     1   3d 3b010000  1001   100 rxrpc     afs@movesole.com=
: ka


