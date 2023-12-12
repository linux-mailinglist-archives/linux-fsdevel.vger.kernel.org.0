Return-Path: <linux-fsdevel+bounces-5740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B021580F747
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 20:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5023DB20F42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 19:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362DB52751;
	Tue, 12 Dec 2023 19:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUMvXQqI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9B7A7;
	Tue, 12 Dec 2023 11:53:56 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50be9e6427dso6435608e87.1;
        Tue, 12 Dec 2023 11:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702410835; x=1703015635; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e2vmGJtT06lMObqbVrODvwA1ExW7qrLrSKj89Om+PAg=;
        b=RUMvXQqIZgVOXJADybnWpArGz3pEFeYFRNTrEs1QFHdihVxk5JPqeFheqgVxEemXo6
         yey0r84tBNYLAn3mKYqeHBo5xd8UuDNCS4CY9DBd5Mta3zYi03a1/6NtfVSA6aSMGG+g
         rQUo4Gx0rhnSW0As6p9UOBUyrCAx+mWjMAvfHHG9AfAfsYT18Dv/JUoxZgo/NJC27cvs
         DPqOYmjORr6iwoMDWiW0dpAucxQvDF0hSpCeCjyfC2mWpysSpXmSSCPijNBdzGTe1yUm
         jhrgn6qFKNLvm61MkyKuiiQcLRrETU4mCSNraqqY+QvVX0LrzR5My5bQc9+eQ8Pcp75o
         642g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702410835; x=1703015635;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e2vmGJtT06lMObqbVrODvwA1ExW7qrLrSKj89Om+PAg=;
        b=LsSeoym4awgAL92hF8I6qLG/5mLhbBxojitrNtzvMZvYW43h4dKSB2qE+prMqX3r8S
         6UsKcaqJ7oNY/1OPfv41Di5Q6bCzKyh65mMNUB9fnGPljdurtXyjQiRqHRnZFe8PxUCX
         x+hq2CgSyf+2Ghwj2R7d7C04HjnE47plzAEoRKR2kXm+ssNi2VbRzr4PdOnSMmjE5lqS
         Mh80IjhwVNFPofPBkgyUuW5oVKnjG2boj8maznCoE7DNGB0hRv3qnwIQOobPvLVDxeud
         aTmwdoYaISS5Gs7aT9jnE246X2vzhJglKqzGqp9+wqexk3B3qgAJoSE2QhRc0UD/FJDV
         mjdw==
X-Gm-Message-State: AOJu0YytDtVelV+rdX3pnN44nNFfUvJutdvaXwgE0rgZqGxdPJW+fsSf
	8hlvHkXB4AKT0Tkua8JNdW36F5W7TeHOPw==
X-Google-Smtp-Source: AGHT+IF6h5otwjr09XDONbrADhkSex8XrWBrK2FjBKZjNbxHIMenMlVdJHmi/uEjTeXjTOCspbP/Ww==
X-Received: by 2002:a05:6512:3c96:b0:50d:15d0:6337 with SMTP id h22-20020a0565123c9600b0050d15d06337mr4469837lfv.56.1702410834563;
        Tue, 12 Dec 2023 11:53:54 -0800 (PST)
Received: from t470.station.com (dy7rw6k3pjf9dx1z0m9fy-4.rev.dnainternet.fi. [2001:14bb:6dd:2d22:ec39:3a39:d69e:5748])
        by smtp.gmail.com with ESMTPSA id u10-20020a056512128a00b0050bbb90533bsm1430198lfs.186.2023.12.12.11.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 11:53:54 -0800 (PST)
Message-ID: <e98a26355533de0beb463464c73fb8781ab089bb.camel@gmail.com>
Subject: Re: [PATCH v3 0/3] afs: Fix dynamic root interaction with failing
 DNS lookups
From: markus.suvanto@gmail.com
To: David Howells <dhowells@redhat.com>, Marc Dionne
 <marc.dionne@auristor.com>
Cc: linux-afs@lists.infradead.org, keyrings@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 12 Dec 2023 21:53:48 +0200
In-Reply-To: <20231212144611.3100234-1-dhowells@redhat.com>
References: <20231212144611.3100234-1-dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

ti, 2023-12-12 kello 14:46 +0000, David Howells kirjoitti:
> Hi Markus, Marc,
>=20
> Here's a set of fixes to improve the interaction of arbitrary lookups in
> the AFS dynamic root that hit DNS lookup failures[1]:
>=20
>  (1) Always delete unused (particularly negative) dentries as soon as
>      possible so that they don't prevent future lookups from retrying.
>=20
>  (2) Fix the handling of new-style negative DNS lookups in ->lookup() to
>      make them return ENOENT so that userspace doesn't get confused when
>      stat succeeds but the following open on the looked up file then fail=
s.
>=20
>  (3) Fix key handling so that DNS lookup results are reclaimed as soon as
>      they expire rather than sitting round either forever or for an
>      additional 5 mins beyond a set expiry time returning EKEYEXPIRED.
>=20
> The patches can be found here:
>=20
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/lo=
g/?h=3Dafs-fixes
>=20
> Thanks,
> David
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216637 [1]
> Link: https://lore.kernel.org/r/20231211163412.2766147-1-dhowells@redhat.=
com # v1
> Link: https://lore.kernel.org/r/20231211213233.2793525-1-dhowells@redhat.=
com # v2
>=20
> Changes
> =3D=3D=3D=3D=3D=3D=3D
> ver #3)
>  - Rebased to v6.7-rc5 which has an additional afs patch.
>  - Don't add to TIME64_MAX (ie. permanent) when checking expiry time.
>=20
> ver #2)
>  - Fix signed-unsigned comparison when checking return val.
>=20
> David Howells (3):
>   afs: Fix the dynamic root's d_delete to always delete unused dentries
>   afs: Fix dynamic root lookup DNS check
>   keys, dns: Allow key types (eg. DNS) to be reclaimed immediately on
>     expiry
>=20
>  fs/afs/dynroot.c           | 31 +++++++++++++++++--------------
>  include/linux/key-type.h   |  1 +
>  net/dns_resolver/dns_key.c | 10 +++++++++-
>  security/keys/gc.c         | 31 +++++++++++++++++++++----------
>  security/keys/internal.h   | 11 ++++++++++-
>  security/keys/key.c        | 15 +++++----------
>  security/keys/proc.c       |  2 +-
>  7 files changed, 64 insertions(+), 37 deletions(-)
>=20

masu@t470 ~ % uname -r
6.7.0-rc5-gb946001d3bb1

This fixes my problem :)  https://bugzilla.kernel.org/show_bug.cgi?id=3D216=
637

Tested-by: Markus Suvanto <markus.suvanto@gmail.com>

-Markus



