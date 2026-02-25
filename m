Return-Path: <linux-fsdevel+bounces-78349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEZMORTLnmm0XQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 11:12:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9359619590C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 11:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6648F3128C22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 10:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092453921C5;
	Wed, 25 Feb 2026 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="EHUjEWbA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C500C38F95C
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 10:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014093; cv=pass; b=ln0TOJNghJ8IwkfxaJYGlfrdIHVeTm1+XFJlx8oBSwfQJYGPNv2E2ME7+CUtfPU8WatylnmALxU2SaKNcLtSushvy647b4BtK9Oo9q5XN9uVVswSAI2cNgZZqOHrGSAQfCSZkTrzBcLiRiHY6ButnCZuKBrwOu6yQakkGBSAv4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014093; c=relaxed/simple;
	bh=P+nn7GxNNTTR4z83VRm4nDPbYz8l5IDhZ9xoBNCdUfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWWL+r636/GQ7zdUdpDy5ed7fClkIUpt7H3808kmorXEkrM54PfRAAX3W84G04LMGFmY+DIFKqcGCBdt1OiBXs591n4PcvnU15JJU35j0SlxQSs2EW60S0RqQ16F2wlFUaj+jMtIsHTkIC5M2UaC7FTJZNH2V0Iu+S1+SzL1TNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=EHUjEWbA; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3878de20527so55367801fa.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 02:08:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772014090; cv=none;
        d=google.com; s=arc-20240605;
        b=WFduGcpCmINDwGMWNzqhgLS6yjAaRjuesDGO9XruRAmgJhwqqH4jYGw4UsRTR2eTzf
         vDpHJUcJq6R5KVPmj4GpjxckkkT9tNKhA8adToZspPBNvnBWlsT8GNzIAkPfIPI+ef98
         jmlMKmH0ALfH6Dlxn47tsNghV+z/2K+iObXOWb76zmQSDZgI/ynU79Rp1njtzlsKQICZ
         kS7UANi4+fSboV3QIju+OpRNUESgTNkLbq1dQb/SnEq0dCZUdUdM5uQCBA0a3I3lE19N
         221L+BPMlkc5z/L+1oogDJFNCfb/aliiSAsrapUIUvx0CGoLZ5F9Jbb0Pe3jI+9K68pL
         1nqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P+nn7GxNNTTR4z83VRm4nDPbYz8l5IDhZ9xoBNCdUfk=;
        fh=AAF8w2Hi8v/MDgyttIJ93yQS3oR7vOmAv5AmTs2dR6E=;
        b=gmepFZSRn3fWHL4D833YqCydWrttQ2P4vFwi6PDyhrC1WqWYOBqmLnQxzq/19ZQ8TI
         nlxMQrPUv3H8ddvJVieI4Zh0eRXEe2RdnxrqVuuWdWzoqIYNbqNqfs7tEpxesEXh23Rp
         xVZ0UIPU84oufTQz/Mc84cekQALZSagEBP9fvEzv13KdEjoSoLDqT6Nbog6xabPUyE5H
         wlSrXWFAn2+QXyX3xae7wzxT26RqMtVVy66V2YhiBrbkcYcbtFXj+Y0OsSver7CGmCFo
         e71xDu9YmBpAFlbt19FkVd++k95JrEy76rL6ax6KVHlacesVtHDH3PyFNn3mS11p7r3I
         2C2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1772014090; x=1772618890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+nn7GxNNTTR4z83VRm4nDPbYz8l5IDhZ9xoBNCdUfk=;
        b=EHUjEWbAmES8Sf83245PgtIM8NbuFiFAiI2agIi42ooPvjuPeMZUkyJ6AL1iZlIuM9
         RxbLTm1ut57NfxMO9zTSXN9FCCWRkA2iprpqJrHj+T1WdSbxDVmZ4XfSBZnj2U/yT7TJ
         70SmgInM23E8fCP/TeHF0vozWxBM7MBDmTghms4xq3LLRV9kBG5cVy8eCeZHQM1Cz3EB
         LaMbglT25bSg/I9OZKB72d8o68aD/Zy/MxbNxHTXTCFS3Ltf191tavlga03a25E31ZKm
         vkIn+7uBgHpOEiNYN2ZRKMzWMdHJj1vtC3uUg/TtA/+Ik/urSZ7Wr1RVDn0C+0NqcAU2
         UcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772014090; x=1772618890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P+nn7GxNNTTR4z83VRm4nDPbYz8l5IDhZ9xoBNCdUfk=;
        b=TflDxvwNDIq3CQ6cnGLePvIIQfexSWmT0y1sgx5jHeoY2AyFtZjWuC4YXnRq8dw/hY
         NS0xOeKIpj79QT9Bkl1+xbl+mbsCR0b27MogvSIG3xcEgu3thoDJSk9WlnrjdX5BUXgW
         WqjrKJpznM7NkO8AFyGdk/cBaVVeR5ZTnvt7Um39ImcqUqmoyEO3Lcmf+6kEC2VR/Rve
         LCQXx+iOgAvBgL9nW/hEwxLcXGlQ4srwtLhE0fromauhGwFa/LPqMjWh5H0AWL5fU2kq
         4bPIwtcdIEFC4R+iMD4HYtiJ5u+QqoHAQ4waPXvHmHwLnJsQn4jvcGF7HnG30z3Ca2Kc
         AKyw==
X-Forwarded-Encrypted: i=1; AJvYcCWknWmodsNSUY+f/juht+0ojowIgmfgM2qoQXepeKFaYtG9GfQM6sQeA8Pu0sT8Y55HhUiIX0au1wumjkEX@vger.kernel.org
X-Gm-Message-State: AOJu0YxI3ccr+Z8M2WiVpDUEKGFLCsN8Wtwzo9XHaAgwip58JcvtY/xS
	nSK8Lnhah9vRbHremaeww9muSmsRmHMOpguTFvfKBCJxGPUzwQXL2rQehbu8lJL8GIgbobuwgwI
	sgu47QLkTMxkbKwLo4AVIEmmnMR0jAU5jBrGHdjReng==
X-Gm-Gg: ATEYQzzN8z2akmQ4+G2sRdfyij0kNTGFTE0siYLmhafLFDAisTOXUkX7TYfPPxmnYOv
	VAHPzvVm7Spox8qFKGsXltIOrDHKtVvYssToHirYL5D0zABdn3pznp5pykxvy5Ru4AZhvEYEV34
	kj2J1X5sV5y0xsj8PJ70ghly0kuANN7p6Ddn7ApBNt/+Ra3mnKqKBpkt7XQKOCUdK+FgdWbyFwQ
	RqImHDV0wxdv2qDDnBvbISTD3K0A82PrMZ0X9FUCdHwRCnFpyOBugLHXalSzLBqzM7jlth6gi/Q
	2Db8x58EGKVU3dBN4rhtm2kU6NGR6aoRfmZrzQv4VpO62/0aXjHZFpayIeBee7DS91bJ
X-Received: by 2002:a05:651c:324e:b0:387:421c:3cc with SMTP id
 38308e7fff4ca-389e2bb0ca7mr6069021fa.16.1772014089948; Wed, 25 Feb 2026
 02:08:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <31a2a4c2-8c33-429a-a2b1-e1f3a0e90d72@nvidia.com>
 <459953fa-5330-4eb1-a1b4-7683b04e3d45@flourine.local> <aY77ogf5nATlJUg_@shinmob>
 <CAJpMwyis1iZB2dQMC4VC8stVhRhOg0mfauCWQd_Nv8Ojb+X-Yw@mail.gmail.com> <40edeeec-dbc3-4aef-ac86-691e1ed2ed06@acm.org>
In-Reply-To: <40edeeec-dbc3-4aef-ac86-691e1ed2ed06@acm.org>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Wed, 25 Feb 2026 11:07:58 +0100
X-Gm-Features: AaiRm53Zv-ldie7aCzcsDbQaCCWr2F8I9cWxTChkMF5C5q2noC0qJ-esR5e6yic
Message-ID: <CAJpMwygzTcBnKVp=bJWZpW9X5JdcP9Lj4H1BRBu2bNV_kGyDQQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
To: Bart Van Assche <bvanassche@acm.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Daniel Wagner <dwagner@suse.de>, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, Hannes Reinecke <hare@suse.de>, hch <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>, "tytso@mit.edu" <tytso@mit.edu>, 
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Christian Brauner <brauner@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
	"willy@infradead.org" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	"amir73il@gmail.com" <amir73il@gmail.com>, "vbabka@suse.cz" <vbabka@suse.cz>, Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[ionos.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ionos.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78349-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[wdc.com,suse.de,nvidia.com,vger.kernel.org,lists.infradead.org,lists.linux-foundation.org,lst.de,kernel.dk,grimberg.me,mit.edu,kernel.org,oracle.com,javigon.com,infradead.org,suse.cz,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haris.iqbal@ionos.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ionos.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,acm.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9359619590C
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 6:08=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 2/15/26 1:18 PM, Haris Iqbal wrote:
> > A possible feature for blktest could be integration with something
> > like virtme-ng.
> > Running on VM can be versatile and fast. The run can be made parallel
> > too, by spawning multiple VMs simultaneously.
> Hmm ... this probably would break tests that measure performance and
> also tests that modify data or reservations of a physical storage
> device.

Performance related tests can be skipped when running in a virtual environm=
ent.
Regarding data modification, if the tests do not involve any crash or
reboot, then the VMs can be started in "snapshot" mode. This gives a
number of advantages.
a) Data modifications will not persist once the VM is shut down. This
means the disk will be clean for the next test cycle.
b) Using just a single set of qcow files, one can bring up any number
of VMs in snapshot mode. The data written while the VM is running can
be safely read/modified, but it disappears after a reboot.

>
> Bart.

