Return-Path: <linux-fsdevel+bounces-76218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IE+bNlhAgmlHRQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 19:37:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C35DDB0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 19:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66B7730BF62A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 18:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7344365A10;
	Tue,  3 Feb 2026 18:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jotschi-de.20230601.gappssmtp.com header.i=@jotschi-de.20230601.gappssmtp.com header.b="lhZtyPgR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E987531B83B
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 18:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770143384; cv=pass; b=dUaNv4tb6wwkwWxc4RV88+CM/Gg0MP8iRGrI30aUo5476c/NpiWkTuOpVWhF7B8oH8mqfAqy1Cz0vzxstOoWKOhdg/TJBlY350VCprndrY5sg1tarKUsRqplFvlzVDz4T8X2MJIK7Ilgz50YH3fULjS99wlsmGIoKMl45rfhhE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770143384; c=relaxed/simple;
	bh=+O8+UcYgnJABqa1+tztj9i2L3+z5VJHlpVYliL8nobQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SBlQY4vPleL9QRcsclZMpu6FF/WKrM2EZegSvnN+8vUhB5FdaqIeudz5UsmRkeJ0huVWs+ZW8m+w1ssI4HQyerX2gr5lbUEooppbCFRiFv9dcFheEM3BVrK+9awMO6vvINJDSjJh7/MRwm2JLfcTmTqgge8gltILYHEZJIxuWLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jotschi.de; spf=none smtp.mailfrom=jotschi.de; dkim=pass (2048-bit key) header.d=jotschi-de.20230601.gappssmtp.com header.i=@jotschi-de.20230601.gappssmtp.com header.b=lhZtyPgR; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jotschi.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jotschi.de
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82418b0178cso247891b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 10:29:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770143381; cv=none;
        d=google.com; s=arc-20240605;
        b=VMN4ROJTVpOLf2K1MfTFkdEjY9aKiaggpaUdLsIZQhtAohxgNgp6GsBoBs2ypGi5/g
         6B2HBwEkH3hROdt/pCwGWLnK+6Y6iarLwYnVLRKAHp4Dz9VHluNVZRhwc/++raDicIR7
         q49jyct6pN/nElwso9kct/FvVrhK/nTPsQsRPCd0u089b7cUD6GtlnD7wr1Vlq0HS8R8
         n9ppX2bSgLw5sq3njSTxQJ79rrx0hZxgqTxvVnw02FuqyvRa1gzpHrLUfUkUe7dw+zal
         RySsQZOuO8X2om8TiH9WTB5GxXtqsDlSS1bjcpAndnuGWZ2KKdqhHiOB/AyYMMh6bVuh
         gLPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+O8+UcYgnJABqa1+tztj9i2L3+z5VJHlpVYliL8nobQ=;
        fh=S4qsqFUL/mjEqk8g3SK/38+tBxxlFYJ19ivX8AP7+Qs=;
        b=a5pAV5bpIjuh5YKofqNkaZCnuM1OGKR71iEC2zuzOS+d9J8Qu7Ukz3Fc4VU7PVZloV
         RZ73i6ZnC5JDbO8jF8BPQ7RKfvmDiK4wm52IEPl4y/ds7MuSpVSbgPaz4G7nqLF5Rm4a
         PhH7tvqDZNT2GXnHygMcg3zNSO1XHV4mM5H+p1ol4e4cqdR6t/QqvL2eAY6UviLra6Fl
         dgXDJe9s1+aNY7iABxSlv17tqhhdiv+faO8Tr5Hl4A8bWJX2QbupW6Xhlws0Tr1czcYe
         5wOINQqMuRw4hggzh/0PkXNAnBeue9tMKrMF3lAtBU6NfzM6X5tYwFf0FJ8oxTt8SxNb
         9aEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jotschi-de.20230601.gappssmtp.com; s=20230601; t=1770143381; x=1770748181; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+O8+UcYgnJABqa1+tztj9i2L3+z5VJHlpVYliL8nobQ=;
        b=lhZtyPgRIWwtdcQEEOmitbN73LxyFZ9uyzCNkVdE5+mx5yiWmmbjWSCzdqaiIBYGUc
         yolntBsJNxK1H6ebG/80y3x7QE1/sT7UufBqNIP5tD+iYKtYvJ2mflHdHZGFG+x7mMeu
         WITgEZl8SdwhwSL2j/cUd5Ii50jV4Txa1lNRW/7dOEHqfE76i7mVf1ZoJhvfUE4MwGCb
         Geyt4QhFkmWp/OtXfl7o8sZeiL8qtnjK+9uR05aDGVkzD30CKpK+6RpXCMuulJYlKLOw
         9S5DtagWU6i7NFfBSZk69vgCRM+8gwrzraF8S0mPdT3rg3ZEI/1FVdc77EXyKGcUi+xM
         z3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770143381; x=1770748181;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+O8+UcYgnJABqa1+tztj9i2L3+z5VJHlpVYliL8nobQ=;
        b=d6ch/vhB1rOElMmPaCjpykcPNBaRFLw1C9ynOimenRGXPbXeEWeaIbQcSujughOx9P
         EeuHv1FMBctKgTUddHToWICaoguFV3dE/3qi9TtUF7FMovlWqk3nQgcDyOwQqg5fO5/K
         +Nzt42b93lOPVjeOTAWUWwKrn4WgCpooE1dfzffGPu40RVDY/JuiiulWIoEtb8HAsi01
         O2ZR8iPpql2FMrZC9V/T96WOfIi0eVpivtWmC5UrM5lzJisIbqEd7E0ph1A9ugXmeju0
         BON5EawVOCfIxY58CwF28R1sbHXLSEAnVagTymqqk6Xr9wi6Kgf/n6XePalZuB48PvTD
         GzBg==
X-Forwarded-Encrypted: i=1; AJvYcCVi9MXtIvz5+M4Jj9H9Gb49NORQD81//XUBuMfY7esKEvbc4LaiO4J9Q4LbW5jiIsnlNTWbbA0A/5dkaaao@vger.kernel.org
X-Gm-Message-State: AOJu0YxpJhVnj+8OlQP6uiZXwsjq1TWm0+qoVeGZqiaZ99Fj7rQilGmK
	t0OxuOO4A0yNHp/spkzQjfpsfcs4Zpr3gnMNTkQu6WMAVg9RrBowhEr4geJbkMKUJONIr8exu+H
	zWHLTLkGzzyEg9/ASUXrA3CreijcIXMmFl94N4dVJ
X-Gm-Gg: AZuq6aJd/rww0gTTTxf3hC2LolR+mzpRIrtc3a2Ir8Cc/Uq4H7FpBQaKUUo7vE2OXze
	L5Y6eCnwq9bvTfJoHPI7D7HXbXmtY0n8WFwhDFNhB0ri7BAKpbu2ZO50Xn4y4i6QhIB180hICBW
	yBjPwcMrEeayvef9H6RIb5Qz86Mc8WiTeuyW4lkQwM7IaGl1Cd1avSIk3Zq3qGb5bQjiScHh3Sc
	I39h3qOCaa51Rv2jQj/7LQOhFH/gyTpTJaMjAVj42mieMGWIucGhWPuVLJLyLFmdLUyxSLtx+WT
	wDnp
X-Received: by 2002:a17:90b:28cc:b0:340:be4d:a718 with SMTP id
 98e67ed59e1d1-354870ae629mr234033a91.7.1770143381135; Tue, 03 Feb 2026
 10:29:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <32Xtx4IaYj8nhPIXtt0gPimTRQy4RNjzmsqI1vQB1YBpRes0TEgu6zVzWbBEcn2U6ZxB14BD9vakmezNyhdXDt3CVGO8WYGxHSZZ1qtQVy8=@spawn.link>
 <8f5bb04853073dc620b5a6ebc116942a9b0a2b5c.camel@kernel.org>
 <e5-exnk0NS5Bsw0Ir_wplkePzOzCUPSsez9oqF7OVAAq3DASvNJ62B9EuQbvIqHitDgxtVnu74QYDYVEQ8rCCU74p4YupWxaKZNN34EPKUY=@spawn.link>
 <9ceb6cbcef39f8e82ab979b3d617b521aa0fcf83.camel@kernel.org>
 <CA+zj3DKAraQASpyVfkcDyGXu_oaR9SnYY18pDkN+jDgi54kRMQ@mail.gmail.com>
 <998f6d6819c2e0c3745599d61d8452c3bc478765.camel@kernel.org>
 <3DMb18lL2VzwORom5oMGlQizKpO_Na6Rhmv5GDA9GpN3ELrsA5plqhzezDxDs_UcXaqFQ9qUHb9y4cY4JRy7TjQ108_dVkZH9D2Yj48ABH0=@spawn.link>
 <CAJfpegu5tAFr3+sEQGi6YWGHMEVpVByFoVxzCONERGvJJdk5vg@mail.gmail.com>
In-Reply-To: <CAJfpegu5tAFr3+sEQGi6YWGHMEVpVByFoVxzCONERGvJJdk5vg@mail.gmail.com>
From: =?UTF-8?Q?Johannes_Sch=C3=BCth?= <j.schueth@jotschi.de>
Date: Tue, 3 Feb 2026 19:29:29 +0100
X-Gm-Features: AZwV_QjcPJsBNwsBRk14wh7tKfyhfH6Ut0d8gg2IlveK_YYbqsMVUYcYYqFBzQY
Message-ID: <CA+zj3DLwu20Q-1qUU-o8fSvnz9V_us35uQ5nqi7AEPNwZ=DAbA@mail.gmail.com>
Subject: Re: NFSv4 + FUSE xattr user namespace regression/change?
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Antonio SJ Musumeci <trapexit@spawn.link>, Trond Myklebust <trondmy@kernel.org>, 
	linux-fsdevel@vger.kernel.org, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[jotschi-de.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[jotschi.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76218-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[jotschi-de.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.schueth@jotschi.de,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[spawn.link,kernel.org,vger.kernel.org,fastmail.fm,linuxfoundation.org];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jotschi.de:url,spawn.link:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,szeredi.hu:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 55C35DDB0C
X-Rspamd-Action: no action

Thank you for the patch. I applied it to 6.18.8 and 6.15.11.
Unfortunately the xattr operations still fail in the same way.
Note that 6.15.10 was still working for me.
I included the wireshark dumps [0] [1] from the mount process. The
access rights show up as:
Access Denied: MD XT DL XAW, [Allowed RD LU XAR XAL] in 6.18.8

Greetings, Johannes

[0] https://www.jotschi.de/files/fuse_nfs_mount_6_18_8-xattr-fuse-patch.pcap
[1] https://www.jotschi.de/files/fuse_nfs_mount_6_15_11-xattr-fuse-patch.pcap


Am Di., 3. Feb. 2026 um 10:28 Uhr schrieb Miklos Szeredi <miklos@szeredi.hu>:
>
> On Mon, 2 Feb 2026 at 20:54, Antonio SJ Musumeci <trapexit@spawn.link> wrote:
>
> > So where do we go from here? Bring in NFS server folks? Miklos?
>
> Can you please try the attached patch on the server?
>
> Thanks,
> Miklos

