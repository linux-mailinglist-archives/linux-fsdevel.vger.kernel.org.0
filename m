Return-Path: <linux-fsdevel+bounces-8030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BBB82E9F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 08:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 003741C230B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 07:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ECA10A35;
	Tue, 16 Jan 2024 07:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="mRdC/J5k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AB610A2B
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 07:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e7e55c0f6so11406247e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 23:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1705389802; x=1705994602; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzT3SOTLB504vsVso9MP/8Q8rWFpwQYwmLj6yEBm/S0=;
        b=mRdC/J5kvbfdAEjwh3Q9XKJTQgbtN+1zBcMxQ/2h/GgT7xz8NaMQw3CMCUeCHzZ0+a
         VOmMhcUkDQrhXlzjrn5Ze1GqvfEBbeRhht6vSVKGoAcXZHAzyrhADHdsfqrYiTFQe8jF
         Fn0iPPdhc6fBuY8edl4kFv8HSgSiwyO7GI4fsp2SgQDtyws75fMxYDkSaN/uQIKNSzvf
         wGBnmUc24V60c5MBO0Gq2dZrykDYNpu29xR1D22BUSjLRLWWEhlh3ELz8XoKDFSKBhXB
         CnBvxyCVqLf/biyfpTix0HMm+CO/Vw+BFce34T1eiH0ktpnNQ8X9h4bQZr6UvTdtJQ5E
         BNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705389802; x=1705994602;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzT3SOTLB504vsVso9MP/8Q8rWFpwQYwmLj6yEBm/S0=;
        b=myEubEMfehszpfJ0lCDMyga+ymGlKhuVhObfxOce7PjfEgYWNIVgFqdZVDEXrsZJ7L
         bqukkdeXv5bKmo63IGQ7uajnk22er3vYeWtCpPQhuqUWvDU8OJCGeJQK6e9diCKlc2T3
         3ZStQzpWaqdcav+FZwcPxICHGCp46Fn61DaF4SNzS1GkxhWoQ6hfq2VVCtDiUS+SBI+P
         7v1qkkXP8Uu3yAlwG8VxPK78+aUAANABwtN4SfUh5oQMFz6d4e2hlc77I+Sz9s0/WLzy
         F8Hgvm3x48bEob6d/zpnMGy/mBnkRJr7yk/FQyiY0bwSViwuRqbVci2O4lhwVDZimLwD
         O5nw==
X-Gm-Message-State: AOJu0YzONQ+MZg/JKNoItNFZn4aFYKn8s1mVfaoOzncFPYIifgbtkdAt
	qgBe72MFkM6ovLhgELWfefV686ZwrRwv9w==
X-Google-Smtp-Source: AGHT+IGlnqteRubYF9UE4RBwmqW+zVHTgjKXHNHebV1eAChN34qlp1qREyOrIKmyDDbwVY5qioi0GA==
X-Received: by 2002:ac2:4e8a:0:b0:50e:285f:3a8 with SMTP id o10-20020ac24e8a000000b0050e285f03a8mr1211813lfr.108.1705389802082;
        Mon, 15 Jan 2024 23:23:22 -0800 (PST)
Received: from smtpclient.apple ([2a00:1370:81a4:169c:5d31:9b9f:2cc5:3e9c])
        by smtp.gmail.com with ESMTPSA id u9-20020a056512040900b0050e3615f608sm1677061lfk.209.2024.01.15.23.23.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jan 2024 23:23:21 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [LSF/MM/BPF TOPIC] : Current status of ZNS SSD support in file
 systems
From: Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <0ea56c32-c71b-4997-b1c7-6d9bbc49a1dd@acm.org>
Date: Tue, 16 Jan 2024 10:23:20 +0300
Cc: lsf-pc@lists.linux-foundation.org,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 naohiro.aota@wdc.com,
 =?utf-8?Q?Matias_Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
 =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
 dlemoal@kernel.org,
 slava@dubeiko.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <8012184C-DF1F-421B-93CA-07B27C0B39C9@dubeyko.com>
References: <20240115082236.151315-1-slava@dubeyko.com>
 <0ea56c32-c71b-4997-b1c7-6d9bbc49a1dd@acm.org>
To: Bart Van Assche <bvanassche@acm.org>,
 jaegeuk@kernel.org
X-Mailer: Apple Mail (2.3696.120.41.1.4)



> On Jan 16, 2024, at 5:58 AM, Bart Van Assche <bvanassche@acm.org> =
wrote:
>=20
> On 1/15/24 00:22, Viacheslav Dubeyko wrote:
>> POTENTIAL ATTENDEES:
>> bcachefs - Kent Overstreet
>> btrfs - Naohiro Aota
>> ssdfs - Viacheslav Dubeyko
>> WDC - Matias Bj=C3=B8rling
>> Samsung - Javier Gonz=C3=A1lez
>> Anybody else would like to join the discussion?
>=20
> Since F2FS has a mature zoned storage implementation, you may want to
> include the F2FS maintainer.
>=20

Sure. Jaegeuk, would you like to join the discussion?

Thanks,
Slava.=

