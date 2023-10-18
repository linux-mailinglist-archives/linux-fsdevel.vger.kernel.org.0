Return-Path: <linux-fsdevel+bounces-580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB767CD1D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 03:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B548228176F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 01:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AF715BC;
	Wed, 18 Oct 2023 01:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="c64xqLxv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3764C1115
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 01:34:02 +0000 (UTC)
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D74FB6
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 18:33:59 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id DE213900E90
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 01:33:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a302.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 7FCA7900F2A
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 01:33:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1697592838; a=rsa-sha256;
	cv=none;
	b=U6rlTSa32qkQMCpQWAH+Az5XgLqmWxTBQZ4OanMCLNe1lEPpoIG4tWU0oALsBBAz6a7RRR
	G/LlS1k61ODdkATC+o6XUnY0Y5Vz5I2pmbcJACLBwEt9LTkW6D5EJUc9EjJZmODlGmJJG1
	l9KhE9O+1WuGcz43cr1LCRoJdlYwHquuo798/Pw2U53u2b9tqPTFPWHOA34vY+ednkNCw3
	pgvchq93Ke1GTUW/5O5EjTFXy0yK8mqRr3wnobLhlRyb+ISeF+esLNuuIbKCOOvG/4OZWc
	oFGxST03ApmvJ6Evb2IlIiMaM3visc5DWE44Phw+RkvuyBmqa++MadeN8Odgwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1697592838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=vd0Xck8mcg9xcRF5wt8r7Tn5ey7m1v7me2mhfXHihEs=;
	b=YfbgIp85nuiONoXGnaiGC/5C1b87/qjETvvhYCAEpNcYsGRrmrAawbVFocKs9LMqXPcy4I
	ze3JV9CZszl0VcCN2oCZjc9i1T1MQV+B/o+Df0+TpugzcaMX053rE6vykoTN+CsNt0hf8n
	L9AlkyNk5i30CIHWETIVOLsuhfRu5/Y1VnL7B5/1klcwQ9HAaV6KBc3ybBfMjuMGb7CPqL
	PxnH4SY2TBr7D9MZ7AYmikDx3xR5/ttBlA9LXsC7xxnmS2GAAeNHNXbZHOxHfrIKjgYUp6
	vsunJOz0Ksxud6Hh+X7xoS3tioO8Frt4MgqVZdhaW6tmXe5xrkWsSP1NJ9picQ==
ARC-Authentication-Results: i=1;
	rspamd-555cdc57c9-sx567;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Tasty-Attack: 700e1c9632d2aa45_1697592838743_845709700
X-MC-Loop-Signature: 1697592838743:4184951420
X-MC-Ingress-Time: 1697592838743
Received: from pdx1-sub0-mail-a302.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.92.163 (trex/6.9.2);
	Wed, 18 Oct 2023 01:33:58 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a302.dreamhost.com (Postfix) with ESMTPSA id 4S9D0614BtzJF
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 18:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1697592838;
	bh=vd0Xck8mcg9xcRF5wt8r7Tn5ey7m1v7me2mhfXHihEs=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=c64xqLxv+mCCkyi4tQUAc/a30ChapTuCb4kEIISZrT3dh1Br19VxixZNnJaQz8bI/
	 KpIhtXF/mnB31iueDtYHXYatfgawJOJmpnHiECStlOVtXicNsUOO6edoXSFLXHYuYZ
	 3VYFtkA4ou5HxniLRUoq/4uB40qsi+L3FJoNz31Vfvc77uEM1xsxuk0EnXlvlt/XaC
	 t6rpu2GigOAIuXEieGUEZrMWRKWWN6CK9w/Ljy7Tjn9BP0q9DbfDMfhe2tbSTsPBzg
	 dwP2tcKSsHNbzK/5RKjAodAm1pzB6fWbL50N8c6up1nvqxJZ3LQeHYEJCo64KsS6jH
	 KmTfOyDR1sgTg==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e0083
	by kmjvbox (DragonFly Mail Agent v0.12);
	Tue, 17 Oct 2023 18:33:46 -0700
Date: Tue, 17 Oct 2023 18:33:46 -0700
From: Krister Johansen <kjlx@templeofstupid.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Krister Johansen <kjlx@templeofstupid.com>,
	linux-fsdevel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
	linux-kernel@vger.kernel.org,
	German Maglione <gmaglione@redhat.com>, Greg Kurz <groug@kaod.org>,
	Max Reitz <mreitz@redhat.com>,
	Bernd Schubert <bernd.schubert@fastmail.fm>
Subject: Re: [resend PATCH v2 2/2] fuse: ensure that submounts lookup their
 parent
Message-ID: <20231018013346.GA3902@templeofstupid.com>
References: <cover.1696043833.git.kjlx@templeofstupid.com>
 <45778432fba32dce1fb1f5fd13272c89c95c3f52.1696043833.git.kjlx@templeofstupid.com>
 <CAJfpegtOdqeK34CYvBTuVwOzcyZG8hnusiYO05JdbATOxfVMOg@mail.gmail.com>
 <20231010023507.GA1983@templeofstupid.com>
 <CAJfpegvr0cHj53jSPyBxVZnMpReq_RFhT-P1jv8eUu4pqxt9HA@mail.gmail.com>
 <20231011012545.GA1977@templeofstupid.com>
 <CAJfpegukL5bj6U0Kvvw_uTW1jstoD2DTLM7kByx2HAhOP02HEg@mail.gmail.com>
 <20231011163220.GA1970@templeofstupid.com>
 <CAJfpegtzyUhcVbYrLG5Uhdur9fPxtdvxyYhFzCBf9Q8v6fK3Ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtzyUhcVbYrLG5Uhdur9fPxtdvxyYhFzCBf9Q8v6fK3Ow@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Miklos,

On Wed, Oct 11, 2023 at 08:27:34PM +0200, Miklos Szeredi wrote:
> On Wed, 11 Oct 2023 at 18:32, Krister Johansen <kjlx@templeofstupid.com> wrote:
> >
> > On Wed, Oct 11, 2023 at 09:07:33AM +0200, Miklos Szeredi wrote:
> > > On Wed, 11 Oct 2023 at 03:26, Krister Johansen <kjlx@templeofstupid.com> wrote:
> > >
> > > > I am curious what you have in mind in order to move this towards a
> > > > proper fix?  I shied away from the approach of stealing a nlookup from
> > > > mp_fi beacuse it wasn't clear that I could always count on the nlookup
> > > > in the parent staying positive.  E.g. I was afraid I was either going to
> > > > not have enough nlookups to move to submounts, or trigger a forget from
> > > > an exiting container that leads to an EBADF from the initial mount
> > > > namespace.
> > >
> > > One idea is to transfer the nlookup to a separately refcounted object
> > > that is referenced from mp_fi as well as all the submounts.
> >
> > That seems possible.  Would the idea be to move all tracking of nlookup
> > to a separate refcounted object for the particular nodeid, or just do
> > this for the first lookup of a submount?
> 
> Just for submounts.  And yes, it should work if the count from the
> first lookup is transferred to this object (fuse_iget()) and
> subsequent counts (fuse_dentry_revalidate()) go to the mountpoint
> inode as usual.  This will result in more than one FORGET in most
> cases, but that's okay.
> 
> > Would you like me to put together a v3 that heads this direction?
> 
> That would be great, thanks.

Thanks for the pointers here.  I started over and followed the approach
that you suggested.  It condensed to a single patch, so I'll send it as
a follow-up to this thread.

-K

