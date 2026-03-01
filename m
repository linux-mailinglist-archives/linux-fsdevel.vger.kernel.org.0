Return-Path: <linux-fsdevel+bounces-78851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKoAEERZpGn8eQUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 16:20:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C751D0683
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 16:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19DEC301DBA9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2026 15:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EFC33555B;
	Sun,  1 Mar 2026 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4sAIl9E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707BF2FD1B3
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Mar 2026 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772378402; cv=pass; b=dtIaKuicFLW7Qlia94m0PSTk5X40sOWx6rP5uVcsrzto/6ROM++nvTkIWA2IYUFVEQaKuMZssykoIWBTlxRpKsHCSKzpOklZCpztt8m/Q0b7wOiXSZxBZdhS6C9aCBEoXIb3ttYl58xmtzsV3imqR03PifiatgylNF6b2xBU+UE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772378402; c=relaxed/simple;
	bh=Fiwwjp3q58poFbwEi1UnSoyKncjAv5ZQQsyqXdz0VPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rBSiB7M8JPYf7rX7RieXqaWJaMl/XwvC4J0bbTOMBbzMTB3FIpD/C0Ye/YUsNJDxIMCVVPXjfy3QNhXczN/4ZEzlGOnyyfKteEKN5/sfxgTDKdt9KucoB2CjTicJ6zi98ybO+kK5Aq5GrKtrDPJQhuLjaqg9gnvl6+t/uDG7fMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4sAIl9E; arc=pass smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56a973a7bdfso3430476e0c.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Mar 2026 07:20:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772378400; cv=none;
        d=google.com; s=arc-20240605;
        b=Trs5hRK7x37+ce9r/ohtOpaFA9iftfnqVmR30cuDY8+x5WnipDZAsygbUGPq/WoWbV
         blbH6JRxk1q3OTTZulTMvE7tfH81FJQlFN0YLJ8Gx7ZEvc9cHa2lTTqhWkNcUhpal6MV
         N+Q+jHazGzRIh6dECaWJUy0WjSJtdUb7l+iAwZKf4RGD4HkHiB0UGPY9OyMiltdSlJN7
         TMt0JPZzuYZQnIbNC9yYdZDhtETRxi6cKMxTTchvmkcu5uoMyAQCVUHjd6o/q4PDAph7
         LzsKwHTWa0vijA7gpLKxEFd4RPr7bmMHGoZxWRYPexvcjSbzbtpqgLCIAq9g4i6hEgty
         4TxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fiwwjp3q58poFbwEi1UnSoyKncjAv5ZQQsyqXdz0VPE=;
        fh=QFWmsbLEBGpAi3iKgW5PN5bAARVbq2G6TqNTFlR8KHg=;
        b=JSJe+1sMNyDYxYVtq+S6NHgX1v8JINPjPmFOex0rYLDkUSqpXwDC55Hh/hWPt6Mjx0
         jA0aQf0+5DVs53DU+5mDbkgaBzaHdLMI/hVzwqK+KK+OBPk7VVVlVwlwswJFf7jX15tt
         KMNH36v9H6thJq6RYM6AQiNwk5jKulZNbMk30Oholl727AQLxK+8EYKUOAr4W4xQHnNp
         NjadbPE7eGmSv05siQCsxP/jwDYZGx0O+KrLBq7bzKf2iIapUMZjv5UXgW/DH2i6RVAy
         X8476oKU+ra7bgSeq3nCZld1TDkxnReNyHF612hvsFkb2J0G5ZbkdyfmzYMJjCp90mCd
         w4ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772378400; x=1772983200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fiwwjp3q58poFbwEi1UnSoyKncjAv5ZQQsyqXdz0VPE=;
        b=H4sAIl9El3DNOjSs6WpoPmMrg64nxdhM2ZU5p6QYdJgq0rtcVMiLtOknYAp3Sg1HnR
         zuEPbTmKD1ahGkEt3CE7W/3H5T9dhJifaqxhoa4FnJIn1ZHEkCrP0KrT0cHSvWzxETnb
         MbQOhGyR7CPg5xgLKg7YKeEJVtdUNLNdy+utBZZbL/Jp+UK/UYfxbYJC/r09iyrQkrq8
         mxKbP0RTNPaULQk5XcC0nqNjCJTCy9r4hOpSX+4eaoRxRsX2lGltWHfOVKOZiO6+5udc
         ZHmxplPmgnjfFEzR/g0/DYxbZ9xUIHWOxlu9NKNyarI58YO2J4A566bqfoxSDFengttt
         GXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772378400; x=1772983200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fiwwjp3q58poFbwEi1UnSoyKncjAv5ZQQsyqXdz0VPE=;
        b=VbMUpvFZfcTX3J+YgvcPtiOTWRVMh7/dY7IgwxPyRbkPbbsRCJ0VbXdXhqphCHLErD
         UTEVVk7M96FnPGflRIhKfuEOrIqLkn1zYkazWdzDumocmS7CXQTLT4brEpamkgnTGOZK
         hXw4bh5PaRIjMhiQ5CPAT+YptG5uIPBcouAyzquX6INzrCDkZ2AI7lO0/kZ8j0YKGPZm
         Y8E3nWkj2e0zaH/mEzO6ug2+Vvdj1bXrel3YxCrFKfNnb2fzeXS98kLDuTfqfo4DspvC
         PTg3/pQh3WI3/vKGanEajjZ6luUX94dfGZvCgTJWaTYfw5vvvTnj7PMjbFL6Wby6Ebqa
         QGfQ==
X-Gm-Message-State: AOJu0Yy3B4CP1sLRyNZP3ydfbwdbZOWFzLMoI5DqA2FOy1tj0tlTqdeC
	I3SfxU0GXgo/yy7FD9hJzBYlRKkdvDWv50+2PN+mhIUvrwEvyoey2ewmN3OesX6Hn1SoJrD4MY3
	LamKNur00mvfBUqT3mZ4eDPN446T0OQI=
X-Gm-Gg: ATEYQzxS1tsD7R0Y8Bc8H72WwRZHqF7otdt8ipddwKkTSwx28HV3UekS7PNmUoIVJKz
	eukAhaEcso/v/yF2Q/KDJykOCj/xLnUgUg0wtHX6zgUfKkynY6sBDsjvffv2w8VTK4/DiOWBBvl
	mdLHYczfUJoyeMShsbzWEZk55Tfs4FLwNv4NYB1I4XvmH3SI8FrmJxMURjaXzavv0W4UuCBTVvQ
	EAICSzc5PzfCGJ4MiDN3HdV+L+tFrxwbiZqGlAn1Iyg91Crp8mtqy5mU6dtyAYJRL/8OMCUF1Et
	nR425YofWBr2SMoQPiYEFcnbckmSBu3/EBSIVbDnVA==
X-Received: by 2002:a05:6102:160c:b0:5ff:1981:aba6 with SMTP id
 ada2fe7eead31-5ff31fab9ffmr5005001137.0.1772378400433; Sun, 01 Mar 2026
 07:20:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221145915.81749-1-dorjoychy111@gmail.com>
 <20260221145915.81749-2-dorjoychy111@gmail.com> <2f430eb613d4f6f6564f83d06f802ff47adea230.camel@kernel.org>
 <CAFfO_h7i86qdKZObdFpWd8Mh+8VXVMFYoGgYBgzomzhGJJFnEQ@mail.gmail.com>
 <ed5aeaa81ad9b87926fa7ebee0308aeb8df9f0ac.camel@kernel.org>
 <CAFfO_h5za6gV99TQS3pwHnf7zyCeVySn3CdRyV+_jFqjovGBqA@mail.gmail.com>
 <beead8bbff344ddfc279e0fc86db0dd5dd98562b.camel@kernel.org>
 <CAFfO_h4brg90tMNp6VAzs5Lo8Lbu=DK2csjDqr2zspOygKEFCg@mail.gmail.com> <73c8ea54bcda0b64093d84fe047914c0632c2d0c.camel@kernel.org>
In-Reply-To: <73c8ea54bcda0b64093d84fe047914c0632c2d0c.camel@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 1 Mar 2026 21:19:49 +0600
X-Gm-Features: AaiRm51DyMEBRNPI1HVDhCyC4qT7r77uNpEMtKgft97OSaudIMk11BvPwkDJ_3M
Message-ID: <CAFfO_h59LQSjncu_4YE5YB+mt-FL2c1GN-jF_WtoKj1u43DcuA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] openat2: new OPENAT2_REGULAR flag support
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, shuah@kernel.org, miklos@szeredi.hu, 
	hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78851-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[41];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 96C751D0683
X-Rspamd-Action: no action

On Sun, Mar 1, 2026 at 9:17=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Sun, 2026-03-01 at 21:15 +0600, Dorjoy Chowdhury wrote:
> > > >
> > > > I only added a kselftest for the new flag in
> > > > tools/testing/selftests/openat2/openat2_test.c in my second commit =
in
> > > > this patch series. Where are the fstests that I should add tests? I
> > > > think you added the wrong URL above, probably a typo.
> > > >
> > > >
> > >
> > > I did indeed, sorry. They're here:
> > >
> > > https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > >
> >
> > Thanks! This is a separate git repository, so I guess for both
> > manpages and fstests I need to submit separate patch series for
> > O_REGULAR. Do I need to wait first for this patch series to be merged?
> > How does it work?
> >
> >
>
> No, you can submit them in parallel, but they probably won't get merged
> until the kernel patches go in.
>

Alright. I can look into submitting patches in parallel. Thanks for
all the info!

Regards,
Dorjoy

