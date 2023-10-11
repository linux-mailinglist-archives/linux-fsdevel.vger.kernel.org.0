Return-Path: <linux-fsdevel+bounces-92-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C037C5929
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 18:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38FBF1C20F78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 16:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEF5200B6;
	Wed, 11 Oct 2023 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="DiCixaA5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840E73E485
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 16:32:32 +0000 (UTC)
Received: from snail.cherry.relay.mailchannels.net (snail.cherry.relay.mailchannels.net [23.83.223.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169CE91
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 09:32:31 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A2899901237
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 16:32:30 +0000 (UTC)
Received: from pdx1-sub0-mail-a302.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4751F900949
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 16:32:30 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1697041950; a=rsa-sha256;
	cv=none;
	b=tjyU8q1bkiNoHiPM7300FmL7mv2v9T+d/4qlD8hf7MitHdJ77g2KaO8sYQzQkZBKVM9z0N
	9Xc27Kf05z4u/pccYZMOTk+XBhnkM+xPjoJ0ps2erbwfd11B9WhlVnSQJbSq+6idhMmjAI
	s8pPE8XysaZXG/12dZ4aFElsvMr5IiNKx2HME4oX5+gAGr9ICdxUe2SXVdWPKMyDvEq3t1
	EPOC7gwVDmnDdb6IUgzVzp8opLYo3f1DPEkG7EV+KgyhJXGOhEVUBxK1fZSl6K2dVlOPgw
	M5dB4LwS+5ft9XFregJcC0i08DdyqxucLka+N3+wjpxihHjW+vvXQH+8wP1HrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1697041950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=0mayE2tgx6c3p1kcbaVx2fh0JTz8yW+1IQDg6h9TpTk=;
	b=kPoH3wnl9NREBD3Z2Gx6XlYddf1AB0u/QaR/ZLds/KyXw654FtVXaeyEiWxuvUfT5VcJW3
	WZ/et+8OX8Ybo+hpBTN6pIDoIlD9mkrzfXCoLZNi644LAPplEG4mKBpbjnTmaJKtl8lPxP
	FsnozlIH3t4i4qZmgr5Ukw0hY3RnW8c8b+jcZRBeiZ61/pBA4BtkIkzPI/stOQdcagWDxJ
	jr3JjpxsEZyMxUJNSEtXRXXWz3lkESJbd+3fGr4g44nJc/Ypssz03IQNV0EsleXj/+64Ai
	4fze8OMm/U5Y8gPqD4eEWc7Zb9xioZ/gXIPcAIgDM75aF+iJ+T/jDiRSo4y0bg==
ARC-Authentication-Results: i=1;
	rspamd-7d5dc8fd68-g6jkh;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Bitter-Spicy: 0ff4617613f2fb73_1697041950506_3419825280
X-MC-Loop-Signature: 1697041950506:2943192606
X-MC-Ingress-Time: 1697041950506
Received: from pdx1-sub0-mail-a302.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.126.222.25 (trex/6.9.1);
	Wed, 11 Oct 2023 16:32:30 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a302.dreamhost.com (Postfix) with ESMTPSA id 4S5JG54H4KzRt
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 09:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1697041949;
	bh=0mayE2tgx6c3p1kcbaVx2fh0JTz8yW+1IQDg6h9TpTk=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=DiCixaA5ykv9lwYos/4ju2YzP14tpLY0ADNV2TQQ4BfLKMqCPYToEjobhk2amVouq
	 Q2Rv3LrIZReR3WFFMNwO8+ahgJYAOca0rVNq4QWzqsLo2m4lJ9xHWkD/xTli8ah+Nx
	 6W+eI+ahs0sK/hdGtR/iqYDvRx36Xh3I06CViSpaxXcpklWAeohprXXYXNc3cV2wuh
	 Or49uzfRR4nMf8U+a1M9v8TeiGy6xdPjjNQs8iZO9g/5DI59cc5t6yQQmFyXTZaqen
	 wVeRKm0K/z00ie8tghfWFNFSL7XJL2WA15bGXWv3xZUIdE7mrv5kqON0l45UgsxnbT
	 D5+plpiD4mCAg==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e005b
	by kmjvbox (DragonFly Mail Agent v0.12);
	Wed, 11 Oct 2023 09:32:20 -0700
Date: Wed, 11 Oct 2023 09:32:20 -0700
From: Krister Johansen <kjlx@templeofstupid.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
	linux-kernel@vger.kernel.org,
	German Maglione <gmaglione@redhat.com>, Greg Kurz <groug@kaod.org>,
	Max Reitz <mreitz@redhat.com>,
	Bernd Schubert <bernd.schubert@fastmail.fm>
Subject: Re: [resend PATCH v2 2/2] fuse: ensure that submounts lookup their
 parent
Message-ID: <20231011163220.GA1970@templeofstupid.com>
References: <cover.1696043833.git.kjlx@templeofstupid.com>
 <45778432fba32dce1fb1f5fd13272c89c95c3f52.1696043833.git.kjlx@templeofstupid.com>
 <CAJfpegtOdqeK34CYvBTuVwOzcyZG8hnusiYO05JdbATOxfVMOg@mail.gmail.com>
 <20231010023507.GA1983@templeofstupid.com>
 <CAJfpegvr0cHj53jSPyBxVZnMpReq_RFhT-P1jv8eUu4pqxt9HA@mail.gmail.com>
 <20231011012545.GA1977@templeofstupid.com>
 <CAJfpegukL5bj6U0Kvvw_uTW1jstoD2DTLM7kByx2HAhOP02HEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegukL5bj6U0Kvvw_uTW1jstoD2DTLM7kByx2HAhOP02HEg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 09:07:33AM +0200, Miklos Szeredi wrote:
> On Wed, 11 Oct 2023 at 03:26, Krister Johansen <kjlx@templeofstupid.com> wrote:
> 
> > I am curious what you have in mind in order to move this towards a
> > proper fix?  I shied away from the approach of stealing a nlookup from
> > mp_fi beacuse it wasn't clear that I could always count on the nlookup
> > in the parent staying positive.  E.g. I was afraid I was either going to
> > not have enough nlookups to move to submounts, or trigger a forget from
> > an exiting container that leads to an EBADF from the initial mount
> > namespace.
> 
> One idea is to transfer the nlookup to a separately refcounted object
> that is referenced from mp_fi as well as all the submounts.

That seems possible.  Would the idea be to move all tracking of nlookup
to a separate refcounted object for the particular nodeid, or just do
this for the first lookup of a submount?

Would you like me to put together a v3 that heads this direction?

Thanks,

-K

