Return-Path: <linux-fsdevel+bounces-71796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F524CD2EA3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Dec 2025 13:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED6DE30102BB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Dec 2025 12:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0051D5CF2;
	Sat, 20 Dec 2025 12:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ZMNUJHqa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qZCZMqRF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0F318B0A
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Dec 2025 12:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766233125; cv=none; b=Xvw6+xa/I3O2lj0ypYl+ZlGCT5DjeJsolWkxa2fV1tqzoBOkmvMaV5psvdYfjWg/3RF1dBvmFLrOoWmHifvG64+d1jB91cWqhi7RbAdg1BK5ExoVKWBdndsX8b2H8GMH7MD/FJ1hp/T4O4ey1GT0lLDmSrYVxNVjuuaF+FQiRME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766233125; c=relaxed/simple;
	bh=SLJNK7je+yijqlHM3c3vJtApdHLMZUnE+J3SamKtsg4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=t3eOd9iTyuLQT/JBCEx8Jniof4FaZqxMqYfdFRLEkUSMO3coN6/3wZer7GKPFvzBuFcOmMFuIZffrLly1ncfIZW/IfF9bpVQncf5BM2Y8ggXmJ2V0Jep1tjXMLL3gbnhD6ngAb+VBGuGFKYgEtC3/vcn7gVxHvogyuIX1r8rfcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ZMNUJHqa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qZCZMqRF; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 38167EC00C6;
	Sat, 20 Dec 2025 07:18:42 -0500 (EST)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-04.internal (MEProxy); Sat, 20 Dec 2025 07:18:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766233122;
	 x=1766319522; bh=J0+iYPCNdQLGxjMdcbwA/gTR2x+sGNDsrapagDJOjyk=; b=
	ZMNUJHqaIlhxOZxNF5kSN9cyqEffKO1N6c+BEpBlv8VjXQMbHQE7yoALKJ0HjI/b
	XvGAc6Nr/uXvXo9lym6t/FhNbTT8hJ0mSSBz+fmaESsNJJOl7jlu7LgAT+0sDIu3
	9Ki9V/JcUOfgAwGFROotsToxiJrzZ2HbHUg/qvUaZIsoyJuKUij2LQthPHxIVZHT
	8dPzn3VcdepxgSOgThr/jM4iCzdR6eBphXPpTptuUXHjKJRJy4wlZja4j/aSTymk
	QtqFEZPslcpgA2KOsgjQagojGoMci4HnQdqU53UAPoZV6TEruD3xNxW9FNgzp4rX
	rCThjZ3LfEUaBUqtpw6mWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766233122; x=
	1766319522; bh=J0+iYPCNdQLGxjMdcbwA/gTR2x+sGNDsrapagDJOjyk=; b=q
	ZCZMqRFfdIVy+pv6ds6PnALhXDnC0sRLUaAmzj3s4eVEqx67+Ol363oA9MOttWV2
	j6hXQPA/CRtlNilvr4HTv16wkfHYlGm9V6j7lI69yUJ3XWv2O6KxcLjZB0OGGlW7
	9Pb6sKpvPbvw3pOLBVtxWWn+Gos1HAh5Vj93mri1hme7FUkzJuZiJJ0PCEni5MfC
	6qQ40JesdRdWISaTK2J+CavcrMWFx0ijMPey4PXY9Owlvp6KchmrR39qmMPIz3Ra
	164FxKRCIRTCLjUZGZtgfcqqiEVjq0sisy6FgxS0o+vS4efs1uxSgU2KGk1LftxX
	zoQDQ7mzZgTT8pMwzmq3Q==
X-ME-Sender: <xms:H5RGaeWggCPW-3VtQo0jpC7-99pN-EJCk2wblScdGz1-ni6zzovHpQ>
    <xme:H5RGaVYT_XLO9OmSwEzEJsXvW2S4qWUO59PT1vBDEEtjuR17lQ2yRdmUOnh16NRBk
    N4b2YhYcXMwf3mfadzQdQvw6TUuKClb1exusXGWb9um0WliqAYI0RC9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeeffedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtoheplhhinhhugiesrg
    hrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehmphgvsegvlhhlvghrmhgrnhdr
    ihgurdgruhdprhgtphhtthhopegrnhgurhgvrghssehgrghishhlvghrrdgtohhmpdhrtg
    hpthhtohepnhhpihhgghhinhesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhrvghn
    sgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrug
    drohhrghdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehinhhtvghlrdgtohhmpdhr
    tghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:H5RGaQN7rv5zp-HFb4nG5aaO04M6xP8R7qsDCEyc91z_HfiEw9u7pw>
    <xmx:H5RGabPeugWqp3_PtYsF-HqGb-Qi4TuBmur4HsG9oKOJ7JXp_YbzCw>
    <xmx:H5RGaUNckeV1xAQTE2DLNCcunDp1dlhBcx2IoeXkPzkj3nzshhpIWw>
    <xmx:H5RGaXb7G2ORik0ZKe9tiOzWwycV_3Ybzkw_-C8JbPSkIm3ilKdNHg>
    <xmx:IpRGaSEvRduNosmd8e790xMBHZoVrcyCL5X-_b1o6s4G1yFIMK_FSZ54>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C2004C40054; Sat, 20 Dec 2025 07:18:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AhgucsMdbVXw
Date: Sat, 20 Dec 2025 13:17:14 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dave Hansen" <dave.hansen@intel.com>, "Arnd Bergmann" <arnd@kernel.org>,
 linux-mm@kvack.org
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Christophe Leroy" <chleroy@kernel.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Jason Gunthorpe" <jgg@nvidia.com>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Matthew Wilcox" <willy@infradead.org>,
 "Richard Weinberger" <richard@nod.at>,
 "Russell King" <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>, "Michal Simek" <monstr@monstr.eu>,
 "David Hildenbrand (Red Hat)" <david@kernel.org>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Vlastimil Babka" <vbabka@suse.cz>, "Mike Rapoport" <rppt@kernel.org>,
 "Suren Baghdasaryan" <surenb@google.com>,
 "Michal Hocko" <mhocko@suse.com>, "Nishanth Menon" <nm@ti.com>,
 "Lucas Stach" <l.stach@pengutronix.de>
Message-Id: <25642e76-43d6-4b17-94a9-e7dc53512223@app.fastmail.com>
In-Reply-To: <a2ce2849-e572-404c-9713-9283a43c09fe@intel.com>
References: <20251219161559.556737-1-arnd@kernel.org>
 <20251219161559.556737-2-arnd@kernel.org>
 <a3f22579-13ee-4479-a5fd-81c29145c3f3@intel.com>
 <bad18ad8-93e8-4150-a85e-a2852e243363@app.fastmail.com>
 <a2ce2849-e572-404c-9713-9283a43c09fe@intel.com>
Subject: Re: [PATCH 1/4] arch/*: increase lowmem size to avoid highmem use
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Dec 19, 2025, at 21:52, Dave Hansen wrote:
> On 12/19/25 12:20, Arnd Bergmann wrote:
>>> But, in the end, I don't this this matters all that much. If you think
>>> having x86 be consistent with ARM, for example, is more important and
>>> ARM really wants this complexity, I can live with it.
>> Yes, I think we do want the default of VMSPLIT_3G_OPT for
>> configs that have neither highmem nor lpae, otherwise the most
>> common embedded configs go from 3072 MiB to 1792 MiB of virtual
>> addressing, and that is much more likely to cause regressions
>> than the 2816 MiB default.
>
> The only thing we'd "regress" would be someone who is repeatedly
> starting from scratch with a defconfig and expecting defconfig to be the
> same all the time. I honestly think that's highly unlikely.

The entire vmsplit selection is guarded by a CONFIG_EXPERT conditional,
so I would expect it to change both for embedded distros that store
a project specific defconfig and for individual users that have a full
.config. If someone sets CONFIG_EXPERT, they do indeed keep any
previous defaults, but I'm also less worried about them.

In the Arm version, the 'choice' statement itself does not depend
on CONFIG_EXPERT, but I've added 'depends on !HIGHMEM || EXPERT'
in VMSPLIT_3G and VMSPLIT_3G_OPT for a similar effect.

> If folks are upgrading and _actually_ exposed to regressions, they've
> got an existing config and won't be hit by these defaults at *all*. They
> won't actually regress.
>
> In other words, I think we can be a lot more aggressive about defaults
> than with the feature set we support. I'd much rather add complexity in
> here for solving a real problem, like if we have armies of 32-bit x86
> users constantly starting new projects from scratch and using defconfigs.
>
> I'd _really_ like to keep the defaults as simple as possible.

I'm fine with 

	default VMSPLIT_2G_OPT if !X86_LPAE
	default VMSPLIT_2G

and dropping the VMSPLIT_3G_OPT default for non-highmem x86
builds if you think that's better. I still think we need the
special case for X86_LPAE/NX users to get to the point of having
VMSPLIT_2G_OPT as the default across architectures for current
HIGHMEM users that have exactly 2GB.

I honestly don't know enough about x86-32 users to have
a good idea who should be optimizing for. The embedded systems
(vortex86 and geode) seem to mostly have 512MB or less and no
PAE, so it probably works either way. As with similar
Arm configurations, these seemed like the highest priority
to me.

I see there are a few rare vortex86dx3 boards and the
upcoming vortex86ex3 that can have 2GB and would be using
HIGHMEM=y but PAE=n today, and these really want the 2G_OPT
split by default, not VMSPLIT_2G.

Hobbyists running on vintage PC systems instead may have
intentionally seeked out the few machines that actually support
2GB or 3.5GB of RAM on late Pentium-M or early Atom CPUs,
though most of the historic machines between the i486 and
the last 32-bit desktops would likely have much less.

    Arnd

