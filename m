Return-Path: <linux-fsdevel+bounces-5649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02B680E858
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 10:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5074DB20A46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 09:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEF959154;
	Tue, 12 Dec 2023 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2K5kQv2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C0BCF;
	Tue, 12 Dec 2023 01:57:07 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50bf3efe2cbso6263812e87.2;
        Tue, 12 Dec 2023 01:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702375026; x=1702979826; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0XhAjLiUJcC0rNvKWnpkrZKgQ9xJEZySu3Dh5SmAMQs=;
        b=k2K5kQv2YNYC1e0ciiDUGGmJWdAJhuP93RmqmcfutFpLHUpvzEy1Jth3PufRCFQbL9
         R++jD7Rj6Yc2YNaKR5/k9Y8rlTHcVUqqwhxfoVZvcQ2oEy1tmNB/mUvoklJC/hsA6ZJt
         ZC5bgRAMMnrv/46zAymu/TNBTGUIsR4XnMOKS+gi6hMqfUCEhGEFmsdIVOHS0UHwh6Xg
         MJAXnZOjPRlYK4wOrYSWLkf7Ujcjj51qp/UQ+sa1quLFMum3pSufPcfkfv9zhUUkP7OG
         TvSIYX9e/ghIEahn+ZCiEZC8f1fggcD5ojiLi4hpQpPjunYMc+lPvLEfMBhLkJupmJQ9
         vurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702375026; x=1702979826;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0XhAjLiUJcC0rNvKWnpkrZKgQ9xJEZySu3Dh5SmAMQs=;
        b=UoDvxqDJd8cbPR8sBf4pjURaH90doP06xcXFwiKEdFSXQXUcL4a6YlWlMtduPCnR4G
         DYTecu/707R3HAqn2pSMRBauYpQ8yL7uVlkKiKc1nCW7gn8G28ZIT7Rn8squqGKdXmmB
         I5AMMyrVhZw6IhDoyU8Xb009DbIOAdTZ74QG9FhKW5VNnYNGb0ObMbyBn7sNeEexTddb
         Ls8Gu1Tj46IAZOdxhjlQXFMjoYoRgzUuTwoiFfcRgZospucq/mKsyhoLkaU0AOGgdKLY
         15PtD7N7c3DVXRf49YKYvSHRRY31g3B/guhkZYvMkaqRYt6AWnkM9cFNj+3KEsv23aHk
         3wpQ==
X-Gm-Message-State: AOJu0YyIFzhtOXGvIYd5eKc7VnowPKbM90mjm4ytvb4guDV1zZRJOW6G
	psqC9FhZD23UFAga9Hy3k88=
X-Google-Smtp-Source: AGHT+IH8Hvt4qL2QDC3yEtm8xQy8v+2WaIaTF1T6+u4IQ9TA+SgWg5d1PB1gvQzGXI171cN6ccvjkw==
X-Received: by 2002:ac2:5e26:0:b0:50b:f98b:dd61 with SMTP id o6-20020ac25e26000000b0050bf98bdd61mr997980lfg.205.1702375025602;
        Tue, 12 Dec 2023 01:57:05 -0800 (PST)
Received: from dy7lrfj8vfr2jm7whrhxy-4.rev.dnainternet.fi (dy7lrfj8vfr2jm7whrhxy-4.rev.dnainternet.fi. [2001:14bb:6d2:e21f:9123:ac75:6e46:71a6])
        by smtp.gmail.com with ESMTPSA id c10-20020ac25f6a000000b0050bf59d513bsm1300621lfc.94.2023.12.12.01.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:57:05 -0800 (PST)
Message-ID: <37bed7ea3e57c4a2d8de5a20b327f6fdd7c79677.camel@gmail.com>
Subject: Re: [PATCH 0/3] afs: Fix dynamic root interaction with failing DNS
 lookups
From: markus.suvanto@gmail.com
To: David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, 
	keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 12 Dec 2023 11:57:04 +0200
In-Reply-To: <2812152.1702374569@warthog.procyon.org.uk>
References: <d523ca40916a8c17ea8ab6d980265e2985e094b3.camel@gmail.com>
	 <59be73c8346ca0c0d6feddcdb56b043cfa0aea4d.camel@gmail.com>
	 <20231211163412.2766147-1-dhowells@redhat.com>
	 <2810523.1702371786@warthog.procyon.org.uk>
	 <2812152.1702374569@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> > masu@t470 ~ % grep rxrpc /proc/keys
> > 23e16cda I--Q---     1   3d 3b010000  1001   100 rxrpc     afs@movesole=
.com: ka
>=20
> Okay, I see the persistent keyring disappear, but I don't see a key linke=
d
> into my session keyring vanish.

Full log of my commands...

masu@t470 ~ % klist=20
klist: Credentials cache keyring 'persistent:1001:1001' not found
masu@t470 ~ % keyctl show  =20
Session Keyring
 388545754 --alswrv   1001 65534  keyring: _uid_ses.1001
 946177719 --alswrv   1001 65534   \_ keyring: _uid.1001
masu@t470 ~ % grep rxrpc /proc/keys
masu@t470 ~ %=20
masu@t470 ~ %=20
masu@t470 ~ %=20
masu@t470 ~ % kinit masu@MOVESOLE.COM
Password for masu@MOVESOLE.COM:=20
masu@t470 ~ % aklog-kafs-kdf movesole.com MOVESOLE.COM
masu@t470 ~ %=20
masu@t470 ~ %=20
masu@t470 ~ % grep rxrpc /proc/keys

2600d2d5 I--Q---     1   3d 3b010000  1001   100 rxrpc     afs@movesole.com=
: ka
masu@t470 ~ % klist=20
Ticket cache: KEYRING:persistent:1001:1001
Default principal: masu@MOVESOLE.COM

Valid starting       Expires              Service principal
12.12.2023 11.52.47  16.12.2023 11.52.40  afs/movesole.com@MOVESOLE.COM
	renew until 26.12.2023 11.52.40
12.12.2023 11.52.43  16.12.2023 11.52.40  krbtgt/MOVESOLE.COM@MOVESOLE.COM
	renew until 26.12.2023 11.52.40
masu@t470 ~ % keyctl show           =20
Session Keyring
 388545754 --alswrv   1001 65534  keyring: _uid_ses.1001
 946177719 --alswrv   1001 65534   \_ keyring: _uid.1001
 637588181 --als-rv   1001   100   \_ rxrpc: afs@movesole.com
masu@t470 ~ %=20
masu@t470 ~ %=20
masu@t470 ~ %=20
masu@t470 ~ %=20
masu@t470 ~ % ls /afs/notfound
ls: tiedostoa '/afs/notfound' ei voi k=C3=A4sitell=C3=A4: Tiedostoa tai hak=
emistoa ei ole
masu@t470 ~ %=20
masu@t470 ~ %=20
masu@t470 ~ %=20
masu@t470 ~ % klist
klist: Credentials cache keyring 'persistent:1001:1001' not found
masu@t470 ~ % grep rxrpc /proc/keys

masu@t470 ~ % keyctl show  =20
Session Keyring
1025218481 --alswrv   1001 65534  keyring: _uid_ses.1001
 322736164 --alswrv   1001 65534   \_ keyring: _uid.1001


