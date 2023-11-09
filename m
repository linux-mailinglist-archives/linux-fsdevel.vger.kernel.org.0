Return-Path: <linux-fsdevel+bounces-2662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9017E746B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 23:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E2EE1C20CFE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 22:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847D138FB2;
	Thu,  9 Nov 2023 22:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="iXdBe3Qq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EE238F96
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 22:37:33 +0000 (UTC)
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F34420B
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 14:37:32 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 3A65F941653
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 22:37:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a219.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id E7A6794178D
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 22:37:31 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1699569451; a=rsa-sha256;
	cv=none;
	b=Dj5xzZU6VQJ4GCvXE4Ka4YjV7Q+CTwVK1raMykKacJ4iOYBFo8fRaoTZyWpK6HYyZEYTmf
	wRJ27ShByRLyweT30u8wSJ8LvVulVRhgALZMX+sviVtOMmL3b96sasKWgTdAwL48UVyWGk
	TnkCYWAhYOQc4+gQ3xSHHFMrQKlUlnggcrTJ1UIRjLza9WK2jTQC3eYHDf1e1gp00mX/h6
	RIBf1iQi5go03rfT3n77uQ2T/ugMEqGn9J0bCzEI5OAVyezfcCMqD5qld+lOXnOnLRJ5OX
	Qc0xgd4RdfXTHykpkbMSK0JY3ZT0/dJi00o6q0BXX3VdHfU+FLivVATbZgZHkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1699569451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 dkim-signature; bh=8YwB9PBpFMCaeiI6zpE8rWC2hSXeSpyA9B0exPLdmbY=;
	b=dEPfv+N39p+cC2mOsd/h1a0AGAyoWdE9LNLWY0YAiFSo4nRHHT3YWjcMjg5lTNiKWa3yk5
	clsFIjDHihQ8flgGgITKQSrpdG9YxCn3xnwF7tt4HqzBqWAk/lsVBj4rsGcemLUElW5xb0
	+X930Pqxr19V+rF9bwi2mfZjZdV1TyJQIfPFDjyjzceYqVqyNybGQL9UKT3C+DOz+OhpL5
	jpFe2hmFttMHRYZg6NuJ7u/RzxmSVp6vu9qxssOFo2R4uUydNmNiEHNiXbcjdxDCaoK1Dl
	tGgl8LNuhF7hGoOCUVGiyF/qalaHXeKgm33fNG0RoySrn8C3n6rxcktz4EmHBg==
ARC-Authentication-Results: i=1;
	rspamd-6f98f74948-x7vsh;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Oafish-Versed: 57d2ecbf64f86524_1699569452077_3528514091
X-MC-Loop-Signature: 1699569452077:1373560052
X-MC-Ingress-Time: 1699569452077
Received: from pdx1-sub0-mail-a219.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.124.29.37 (trex/6.9.2);
	Thu, 09 Nov 2023 22:37:32 +0000
Received: from kmjvbox.templeofstupid.com (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a219.dreamhost.com (Postfix) with ESMTPSA id 4SRGzv2mD0zfM
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 14:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1699569451;
	bh=8YwB9PBpFMCaeiI6zpE8rWC2hSXeSpyA9B0exPLdmbY=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=iXdBe3QqD7hYZNkR3gTX16NMfS0osjVYrWrrlW8DpMru9YBAnHLloxIKsO8SV603N
	 MOIz6lOQprbztIl3bFRxvSl9ypsW7G7Gkr8dA2R94UNg+zcTr+bLNDcdJoYITKVL/w
	 tq9BS9p/FqpsbsjtTbs/7b8aSRyNK1W977KkkOuaTUSaB1Qe2hvqbMjUv63N+yqhgT
	 sgZwk0cVlbCuwyMF2NS9FTBmi/UeYF4/SLgdCgvd1L58tdp0DrTGGny+No6gJ0uaFD
	 0xELaaZPVi72foXlwG+c4GacYIbH93Maub+Lg5+xXyy1Sbd1qOnHRwA25f79d18+bW
	 Sn91mwHOfiGYQ==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e0044
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Thu, 09 Nov 2023 14:36:57 -0800
Date: Thu, 9 Nov 2023 14:36:57 -0800
From: Krister Johansen <kjlx@templeofstupid.com>
To: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-kernel@vger.kernel.org,
	German Maglione <gmaglione@redhat.com>, Greg Kurz <groug@kaod.org>,
	Max Reitz <mreitz@redhat.com>,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	"Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
	"Saarinen, Jani" <jani.saarinen@intel.com>,
	lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
	regressions@lists.linux.dev, intel-gfx@lists.freedesktop.org
Subject: [PATCH 0/2] Fuse submount_lookup needs to be initialized
Message-ID: <cover.1699564053.git.kjlx@templeofstupid.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Miklos,
I got a couple of bug reports[1][2] this morning from teams that are
tracking regresssions in linux-next.  My patch 513dfacefd71 ("fuse:
share lookup state between submount and its parent") is causing panics
in the fuse unmount path.  The reports came from users with SLUB_DEBUG
enabled, and the additional debug sanitization catches the fact that the
submount_lookup field isn't getting initialized which could lead to a
subsequently bogus attempt to access the submount_lookup structure and
adjust its refcount.

I've added SLUB_DEBUG to my testing kconfig, and have reproduced the
problem using the memfd self-test that was triggering the problem for
both reporters.  With the fix that follows this e-mail, I see no more
erroneous accesses of poisoned slub memory.

I'm a bit unsure of the desired approach for fixing these kinds of
problems.  I'm also away from the office on Nov 10th and Nov 13th, but
expect to be back on the console on the Nov 14th.  Given the gap, I've
prepared a pair of patches, but we only need one.

The first is simply a followup fix that addresses the problem in a
subsequent one-line commit.

If you'd rather revert the entire bad patch and go again, the second
patch in the series is a v5 of the original with the submount_lookup
initialization added.

Either should do, but I wasn't sure which approach was preferable.

Thanks, and my apologies for the inconvenience.

-K

[1] https://lore.kernel.org/linux-fsdevel/CA+G9fYue-dV7t-NrOhWwGshvyboXjb2B6HpCDVDe3bgG7fbnsg@mail.gmail.com/T/#u
[2] https://lore.kernel.org/intel-gfx/SJ1PR11MB6129508509896AD7D0E03114B9AFA@SJ1PR11MB6129.namprd11.prod.outlook.com/T/#u

