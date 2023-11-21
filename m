Return-Path: <linux-fsdevel+bounces-3336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EB07F37AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 21:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F932B216C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 20:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF99A47799;
	Tue, 21 Nov 2023 20:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=owlfolio.org header.i=@owlfolio.org header.b="bAwn9NJ3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RHig11LW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA839188;
	Tue, 21 Nov 2023 12:43:05 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id A89DD5C0742;
	Tue, 21 Nov 2023 15:43:02 -0500 (EST)
Received: from imap45 ([10.202.2.95])
  by compute5.internal (MEProxy); Tue, 21 Nov 2023 15:43:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=owlfolio.org; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1700599382; x=1700685782; bh=cP
	+4Qdty6Ljkpn+y6fboIIavjZKfR1zjbDxx2nbUIFU=; b=bAwn9NJ3+05S40b+eO
	kl/0W6aIkS95XzxogpgShnf7tDnsrqgKA2kJeaUDtWHI+bVRCYzUkK1fvYa68/oz
	FaGopVcbHWkDXADUovAv8J+8FLn1ib8RsrIBOV6ImNQvp+qfn5uT+ILmycqSaI0H
	vhWPZH4TiMU8DSqfO9zPT1uIVZavoQLzr7G8Xdquz0upH03+9aRqmzno0GFxmyMD
	qn30BazpYWnJatJrTkbf+U/K3J7R+MmV0LBZqYhREib/o7rlesyq4hAPsfQvRar6
	vwWZWF/LX2bzyJXgXtZtNHML5ca9H5njKD6ZBMFnIgWZaQ1ouXagNGGb/LwjHx+t
	Bn/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1700599382; x=1700685782; bh=cP+4Qdty6Ljkp
	n+y6fboIIavjZKfR1zjbDxx2nbUIFU=; b=RHig11LWilXrXEkwF6b4y6XMfX+E/
	dz0xkIJVYHtmexR1EFQpb1vJYvQSZtKLqyvWL7bMWHfn2Ni+EXEmZA7R/iJpbEQI
	vz8RK5To8NLvZz5XMjg4fx2DZ2tLqDwensBWFtbuHwQVotWclyYJlm3pB7x+N5kO
	Pw3IMD4oG9GFRYVqW3Pa2wKPpC+ht9IKXsFDEcNAyM4OE2+tkhUj0OfrnLXhSnJW
	jGYLO68UwFnv8cgyv597+dhlEfrsVqdzp6y9eDn8CtY9QB1/mcuwIPDqiUXqKkX7
	66BhjLk4RgJDWLdeMxdlgfH6pyZ9bedwJTvdoxuUgg6M1XFZdpunL7TxQ==
X-ME-Sender: <xms:VRZdZSSrahJN9hlxrV-5hE7qEMwyIbZ4ATvZFUQP9LTER36m7I-7OQ>
    <xme:VRZdZXxSU_KMvlQGmqccaPVBSek-wy91AFimCNFx5Fpetyzrtv51MaI3OD276PZRj
    nfvtlD7OluIqg-qfvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegledgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdgk
    rggtkhcuhggvihhnsggvrhhgfdcuoeiirggtkhesohiflhhfohhlihhordhorhhgqeenuc
    ggtffrrghtthgvrhhnpefhleefheduhfelgeehgeejveehueeihedvgfeuueetteelieei
    teehfefhleduieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpeiirggtkhesohiflhhfohhlihhordhorhhg
X-ME-Proxy: <xmx:VRZdZf3eRZMU6GUBrFb4HV4lWpNxZs2H8GioLjST2bSGWSaRqMLqiA>
    <xmx:VRZdZeCrNrcRbo3jfcKAoVMMJqsRNNtYw9oWDQ8S7CGLhOPJgH5Obw>
    <xmx:VRZdZbgydg_il2MZV7y_pTSaSe0O9mQzbwh5HcIuKGCtvX983jSvbA>
    <xmx:VhZdZeoV9OZIL5gwZCVfI7UnFreGewzGo-dXiYLH_nTKRHBUj0GEEw>
Feedback-ID: i876146a2:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A37C5272007C; Tue, 21 Nov 2023 15:43:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c1a2c685-6985-4010-933e-a633be647b49@app.fastmail.com>
In-Reply-To: 
 <CAJfpegt-rNHdH1OdZHoNu86W6m-OHjWn8yT6LezFzPNxymWLzw@mail.gmail.com>
References: 
 <CAJfpegsMahRZBk2d2vRLgO8ao9QUP28BwtfV1HXp5hoTOH6Rvw@mail.gmail.com>
 <87fs15qvu4.fsf@oldenburg.str.redhat.com>
 <CAJfpegvqBtePer8HRuShe3PAHLbCg9YNUpOWzPg-+=gGwQJWpw@mail.gmail.com>
 <87leawphcj.fsf@oldenburg.str.redhat.com>
 <CAJfpegsCfuPuhtD+wfM3mUphqk9AxWrBZDa9-NxcdnsdAEizaw@mail.gmail.com>
 <CAJfpegsBqbx5+VMHVHbYx2CdxxhtKHYD4V-nN5J3YCtXTdv=TQ@mail.gmail.com>
 <ZVtEkeTuqAGG8Yxy@maszat.piliscsaba.szeredi.hu>
 <878r6soc13.fsf@oldenburg.str.redhat.com>
 <ZVtScPlr-bkXeHPz@maszat.piliscsaba.szeredi.hu>
 <15b01137-6ed4-0cd8-4f61-4ee870236639@redhat.com>
 <6aa721ad-6d62-d1e8-0e65-5ddde61ce281@themaw.net>
 <c3209598-c8bc-5cc9-cec5-441f87c2042b@themaw.net>
 <bcbc0c84-0937-c47a-982c-446ab52160a2@themaw.net>
 <CAJfpegt-rNHdH1OdZHoNu86W6m-OHjWn8yT6LezFzPNxymWLzw@mail.gmail.com>
Date: Tue, 21 Nov 2023 15:42:41 -0500
From: "Zack Weinberg" <zack@owlfolio.org>
To: "Miklos Szeredi" <miklos@szeredi.hu>, "Ian Kent" <raven@themaw.net>
Cc: "Ian Kent" <ikent@redhat.com>, "Florian Weimer" <fweimer@redhat.com>,
 "GNU libc development" <libc-alpha@sourceware.org>,
 'linux-man' <linux-man@vger.kernel.org>,
 "Alejandro Colomar" <alx@kernel.org>,
 "Linux API" <linux-api@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 "Karel Zak" <kzak@redhat.com>, "David Howells" <dhowells@redhat.com>,
 "Christian Brauner" <christian@brauner.io>,
 "Amir Goldstein" <amir73il@gmail.com>, "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: proposed libc interface and man page for statmount(2)
Content-Type: text/plain

On Tue, Nov 21, 2023, at 2:42 PM, Miklos Szeredi wrote:
>
> handle = listmount_open(mnt_id, flags);
> for (;;) {
>     child_id = listmount_next(handle);
>     if (child_id == 0)
>         break;
>     /* do something with child_id */
> }
> listmount_close(handle)

Why can't these be plain old open, read, and close? Starting from a pathname in /proc or /sys. Doesn't allow lseek.

zw

