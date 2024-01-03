Return-Path: <linux-fsdevel+bounces-7161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A4582290D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 08:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7092E283778
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 07:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9440A1803D;
	Wed,  3 Jan 2024 07:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="C590/BvQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA4D1802F
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 07:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e77a2805fso7161080e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jan 2024 23:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1704267593; x=1704872393; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AbFo3Bg4oMZjrfE+TFYwDX0ZlwLxbfW/PTfwAvhZxA=;
        b=C590/BvQ+x+TjDQLzADKZQlVt++vWdDjP6ZgZeLpcQ06y2/Z5g2CqJRNYfvJBbAHi+
         yPbNSOrcxxgbnI0RXNT4HWaogsifw1MQeCvQjbBZWBygd0CcS2KvldX00NfgRb9iohvm
         czLsY9Op3/o9KpUVhtT7VaMN6nrzW8HJBKGFilVNdQH7NUhpG5pu/HKSGwbUFiosqWVR
         BPs8jSiclFT0j/dvW//cWnHvvsBaHxARba7GV/3ceHUCWb/N65yG+yIVrmX0FvIHKF+i
         rQ+lDKLD8frJpVU2yn1isPo9RVkzjHuIGFLtPT+wBXlX9T15Wj7TirMbcvBlf7ZZA9gZ
         qP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704267593; x=1704872393;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+AbFo3Bg4oMZjrfE+TFYwDX0ZlwLxbfW/PTfwAvhZxA=;
        b=QpXMi0Rj7TaMRrcfQmpQK88dWx9MijgMyYTsR14Nc0zcWPUitshYWimVmpAwjYQNzM
         iJ9GfT9eWmrqTA//w3A4Q7WeEuDslGzKT5nzYrYUe84dC9HKPbfrR5n+ngZKWfk1Xt/E
         msLorkNm0ZYlNMr8534wMIFzSxPQliQR8E6eUmcvmr8tiU8iAPtQzDF75fV790aQk63Q
         PYC4vc4mOKqvQu38nUp86jUHvteosRT/MC+KoXBEBOumecPe0RnbD0IEKgB7jQ3KYAOD
         wUD5X7ucZp3dInDemS6tJzNt6u/3nyT2WEVJDoEdrg74zGksLf0tI9WvJ3NFYpOHIHpm
         ipbQ==
X-Gm-Message-State: AOJu0YxEJrWuJJ2wMgAi8wmlQ2JHeH19wmdCydlLjWWCgjFjRuPjg9bj
	mB88ICVefwnnpqCeYOPeREVIbW7kx2Jom04kDk7aBMJJvAM=
X-Google-Smtp-Source: AGHT+IGqLUJo7QIpSVAnkZsf7fjF/Nf2AiCvSI6SngMMh/NRhhjNMGkInvDVxHCRiQdE6k74oTMzJQ==
X-Received: by 2002:a05:6512:20ce:b0:50e:7aef:e9df with SMTP id u14-20020a05651220ce00b0050e7aefe9dfmr2993498lfr.19.1704267592993;
        Tue, 02 Jan 2024 23:39:52 -0800 (PST)
Received: from smtpclient.apple ([2a00:1370:81a4:169c:b817:c4e5:4423:6afc])
        by smtp.gmail.com with ESMTPSA id c25-20020a056512239900b0050e84c1b75fsm2129354lfv.84.2024.01.02.23.39.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jan 2024 23:39:52 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [LSF/MM/BPF TOPIC] bcachefs
From: Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <mpvktfgmdhcjohcwg24ssxli3nrv2nu6ev6hyvszabyik2oiam@axba2nsiovyx>
Date: Wed, 3 Jan 2024 10:39:50 +0300
Cc: lsf-pc@lists.linux-foundation.org,
 linux-bcachefs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <74751256-EA58-4EBB-8CA9-F1DD5E2F23FA@dubeyko.com>
References: <i6ugxvkuz7fsnfoqlnmtjyy2owfyr4nlkszdxkexxixxbafhqa@mbsiiiw2jwqi>
 <3EB6181B-2BEA-49BE-A290-AFDE21FFD55F@dubeyko.com>
 <mpvktfgmdhcjohcwg24ssxli3nrv2nu6ev6hyvszabyik2oiam@axba2nsiovyx>
To: Kent Overstreet <kent.overstreet@linux.dev>
X-Mailer: Apple Mail (2.3696.120.41.1.4)



> On Jan 2, 2024, at 7:05 PM, Kent Overstreet =
<kent.overstreet@linux.dev> wrote:
>=20
> On Tue, Jan 02, 2024 at 11:02:59AM +0300, Viacheslav Dubeyko wrote:
>>=20
>>=20
>>> On Jan 2, 2024, at 1:56 AM, Kent Overstreet =
<kent.overstreet@linux.dev> wrote:
>>>=20
>>> LSF topic: bcachefs status & roadmap
>>>=20
>>=20
>> <skipped>
>>=20
>>>=20
>>> A delayed allocation for btree nodes mode is coming, which is the =
main
>>> piece needed for ZNS support
>>>=20
>>=20
>> I could miss some emails. But have you shared the vision of ZNS =
support
>> architecture for the case of bcachefs already? It will be interesting =
to hear
>> the high-level concept.
>=20
> There's not a whole lot to it. bcache/bcachefs allocation is already
> bucket based, where the model is that we allocate a bucket, then write
> to it sequentially and never overwrite until the whole bucket is =
reused.
>=20
> The main exception has been btree nodes, which are log structured and
> typically smaller than a bucket; that doesn't break the "no =
overwrites"
> property ZNS wants, but it does mean writes within a bucket aren't
> happening sequentially.
>=20
> So I'm adding a mode where every time we do a btree node write we =
write
> out the whole node to a new location, instead of appending at an
> existing location. It won't be as efficient for random updates across =
a
> large working set, but in practice that doesn't happen too much; =
average
> btree write size has always been quite high on any filesystem I've
> looked at.
>=20
> Aside from that, it's mostly just plumbing and integration; bcachefs =
on
> ZNS will work pretty much just the same as bcachefs on regular block =
devices.

I assume that you are aware about limited number of open/active zones
on ZNS device. It means that you can open for write operations
only N zones simultaneously (for example, 14 zones for the case of WDC
ZNS device). Can bcachefs survive with such limitation? Can you limit =
the number
of buckets for write operations?

Another potential issue could be the zone size. WDC ZNS device =
introduces
2GB zone size (with 1GB capacity). Could be the bucket is so huge? And =
could
btree model of operations works with such huge zones?

Technically speaking, limitation (14 open/active zones) could be the =
factor of
performance degradation. Could such limitation doesn=E2=80=99t effect =
the bcachefs
performance?

Could ZNS model affects a GC operations? Or, oppositely, ZNS model can
help to manage GC operations more efficiently?

Do you need in conventional zone? Could bcachefs work without using
the conventional zone of ZNS device?

Thanks,
Slava.


