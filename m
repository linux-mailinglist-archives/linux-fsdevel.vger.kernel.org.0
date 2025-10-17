Return-Path: <linux-fsdevel+bounces-64503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD703BE92F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 16:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4971AA1325
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 14:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674E91A5B8B;
	Fri, 17 Oct 2025 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="bjh//T5g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RITuW7EI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D503396E9;
	Fri, 17 Oct 2025 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760711319; cv=none; b=nPP2USRcC8ukG8gT/fCFWBWMKWuvRgf06PecnfkYiRWwy/gMD2/dJbHLtd/iSKxSmYLdJHI4UwBipzc00h3EC5VX9lghKOAETx7pc+N/0o28m3ab95qGXAujCyP9jYxxAPWrZaw2vjzuSnyDNvfb8OP61E0fIxy170PowGD7QM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760711319; c=relaxed/simple;
	bh=cuw9SMN0A2G7BgaBy9mG+4BGZEF20KpXdyfRBfMoiBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYsMqLIN7SUf8DJ2gLteEpLvJ1xgXqDpzESRTUGtGczU4wlSDOMdokv0hP8bEQ40qjJAGEjs7gniIsgVbRSplsSHibun1U/8o6849nMqCJ4WdqOhMf24BcheFQp+VPtyuVMrzvbeWPO3OGQKCYrq7sfaStPmqcMKTbyZmHSgDh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=bjh//T5g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RITuW7EI; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5DE807A010D;
	Fri, 17 Oct 2025 10:28:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 17 Oct 2025 10:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1760711316; x=
	1760797716; bh=fOUvMhyzND8SMM+3QM7//4J9ZC4R57kXKY5ct5iBbmI=; b=b
	jh//T5gYDmcxKURMENlhard0U76Q5lY8oEELDXAh1qIh4/u+3OARgGGXBUoNXkb5
	lSbjKnE0BqY9k8t8vMhyPguIBImltkFnXODmIlTSqqTi2ehUT8KqwigAfsIosrmd
	whzvydxgbdrBzaRlyqegjMpp9J+A+oagJaj4ZN0Oal1D7smHh/DKWc1cuqqdvyJ5
	COySGiSqe3IqAiM/dLWzrUdKzsxbxmeZWtex1NHjPBT0D/tvR4gr3Aw5jUs2LA5t
	QtsiCi/PPlVGwBuINlMSz+xPW6Ygx8Y9ovOthzs61/yMSTZ5Fhz6z8mwFQnX/6KG
	E19UT63dbQowZszuS7eAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760711316; x=1760797716; bh=fOUvMhyzND8SMM+3QM7//4J9ZC4R57kXKY5
	ct5iBbmI=; b=RITuW7EIxxQVsTC7ZCYZer1u1Q7uJgoypwI6+SQMGJOFB09kT69
	IPph0sKr2MxWAjt7Jn3xS+WbOFFn+tYL2vhEYrbx5ehky3V9xylDSN3U8AXqUhWr
	iY+gMmnns6DHrq0m86c1ebNnVn01DeQd8+mzig583j4ebQZrbNHSyaKe1RdQm6NJ
	qFx6y0wCZAcmCR1Du4mhqDQHy2+VD6Q2sf9wYTBNX+TZIOBcCX0hKI3fTVVL9PvU
	vjiVKtmCsK3ItARBFBWyAkD0qfgFDGBmmTIJRWBxRrzB1Yn4LOUenptZU6DL+J7n
	XG8xCCQn+lIY9NgU8QY4CweErdaug4MD3Kw==
X-ME-Sender: <xms:k1LyaAj1Odqo_C2-_8Nk_hUenNkz0_p0XdBxXL5CLKmjRS8xylZn_Q>
    <xme:k1LyaGtrRtlfKJsfOdiI4Q74A15jruqbjlBgAJQ4MIX4pQ5JgTY-0ZhKAEs2C0-rU
    A_KQQC6GHx5GpWiiJkIDjUrYRkbrn7GsQT4taHFTGffg3crcr8WjNM>
X-ME-Received: <xmr:k1LyaJ3IlOtN3z_O20hIRkzG9YqdnaBAyCn4Dn2H_z20K5pO5HDevjdAsZ5UNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdelgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugesfhhrohhmohhrsg
    hithdrtghomhdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmtghgrh
    hofheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphdrrhgrghhhrghvsehsrghmshhu
    nhhgrdgtohhmpdhrtghpthhtohepiihlrghnghesrhgvughhrghtrdgtohhmpdhrtghpth
    htoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfsh
    guvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:k1LyaNwxvozgb9ulil_-fdPW4iUhQhCf4cJctnltxPe6VyelIvJCYw>
    <xmx:k1LyaEV58ky8AODoEyF2iw127ag2NWtOirtR380GUyU0fgpeYCsJMA>
    <xmx:k1LyaPDBl0ezsw88WgTMdyg5VqCkuuauMepjqZmz7Bt6fF4R1BdfUw>
    <xmx:k1LyaF7nKYe2UWjApQsTE3ynoxs-YbphWTvEac7w6iWLt0QWtvQ0cg>
    <xmx:lFLyaKdRBX33i2NfuLF_QffZ2vE5ImnL07iMFCruCD3NNf4Ok2AdM9X->
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 10:28:34 -0400 (EDT)
Date: Fri, 17 Oct 2025 15:28:32 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Dave Chinner <david@fromorbit.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Pankaj Raghav <p.raghav@samsung.com>, Zorro Lang <zlang@redhat.com>, akpm@linux-foundation.org, 
	linux-mm <linux-mm@kvack.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	xfs <linux-xfs@vger.kernel.org>
Subject: Re: Regression in generic/749 with 8k fsblock size on 6.18-rc1
Message-ID: <764hf2tqj56revschjgubi2vbqaewjjs5b6ht7v4et4if5irio@arwintd3pfaf>
References: <20251014175214.GW6188@frogsfrogsfrogs>
 <rymlydtl4fo4k4okciiifsl52vnd7pqs65me6grweotgsxagln@zebgjfr3tuep>
 <20251015175726.GC6188@frogsfrogsfrogs>
 <bknltdsmeiapy37jknsdr2gat277a4ytm5dzj3xrcbjdf3quxm@ej2anj5kqspo>
 <aPFyqwdv1prLXw5I@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPFyqwdv1prLXw5I@dread.disaster.area>

On Fri, Oct 17, 2025 at 09:33:15AM +1100, Dave Chinner wrote:
> On Thu, Oct 16, 2025 at 11:22:00AM +0100, Kiryl Shutsemau wrote:
> > On Wed, Oct 15, 2025 at 10:57:26AM -0700, Darrick J. Wong wrote:
> > > On Wed, Oct 15, 2025 at 04:59:03PM +0100, Kiryl Shutsemau wrote:
> > > > On Tue, Oct 14, 2025 at 10:52:14AM -0700, Darrick J. Wong wrote:
> > > > > Hi there,
> > > > > 
> > > > > On 6.18-rc1, generic/749[1] running on XFS with an 8k fsblock size fails
> > > > > with the following:
> > > > > 
> > > > > --- /run/fstests/bin/tests/generic/749.out	2025-07-15 14:45:15.170416031 -0700
> > > > > +++ /var/tmp/fstests/generic/749.out.bad	2025-10-13 17:48:53.079872054 -0700
> > > > > @@ -1,2 +1,10 @@
> > > > >  QA output created by 749
> > > > > +Expected SIGBUS when mmap() reading beyond page boundary
> > > > > +Expected SIGBUS when mmap() writing beyond page boundary
> > > > > +Expected SIGBUS when mmap() reading beyond page boundary
> > > > > +Expected SIGBUS when mmap() writing beyond page boundary
> > > > > +Expected SIGBUS when mmap() reading beyond page boundary
> > > > > +Expected SIGBUS when mmap() writing beyond page boundary
> > > > > +Expected SIGBUS when mmap() reading beyond page boundary
> > > > > +Expected SIGBUS when mmap() writing beyond page boundary
> > > > >  Silence is golden
> > > > > 
> > > > > This test creates small files of various sizes, maps the EOF block, and
> > > > > checks that you can read and write to the mmap'd page up to (but not
> > > > > beyond) the next page boundary.
> > > > > 
> > > > > For 8k fsblock filesystems on x86, the pagecache creates a single 8k
> > > > > folio to cache the entire fsblock containing EOF.  If EOF is in the
> > > > > first 4096 bytes of that 8k fsblock, then it should be possible to do a
> > > > > mmap read/write of the first 4k, but not the second 4k.  Memory accesses
> > > > > to the second 4096 bytes should produce a SIGBUS.
> > > > 
> > > > Does anybody actually relies on this behaviour (beyond xfstests)?
> > > 
> > > Beats me, but the mmap manpage says:
> > ...
> > > POSIX 2024 says:
> > ...
> > > From both I would surmise that it's a reasonable expectation that you
> > > can't map basepages beyond EOF and have page faults on those pages
> > > succeed.
> > 
> > <Added folks form the commit that introduced generic/749>
> > 
> > Modern kernel with large folios blurs the line of what is the page.
> > 
> > I don't want play spec lawyer. Let's look at real workloads.
> 
> Or, more importantly, consider the security-related implications of
> the change....
> 
> > If there's anything that actually relies on this SIGBUS corner case,
> > let's see how we can fix the kernel. But it will cost some CPU cycles.
> > 
> > If it only broke syntactic test case, I'm inclined to say WONTFIX.
> > 
> > Any opinions?
> 
> Mapping beyond EOF ranges into userspace address spaces is a
> potential security risk. If there is ever a zeroing-beyond-EOF bug
> related to large folios (history tells us we are *guaranteed* to
> screw this up somewhere in future), then allowing mapping all the
> way to the end of the large folio could expose a -lot more- stale
> kernel data to userspace than just what the tail of a PAGE_SIZE
> faulted region would expose.

Could you point me to the details on a zeroing-beyond-EOF bug?
I don't have context here.

But if it is, as you saying, *guaranteed* to happen again, maybe we
should slap __GFP_ZERO on page cache allocations? It will address the
problem at the root.

Although, I think you are being dramatic about "*guaranteed*"...

If we solved problem of zeroing upto PAGE_SIZE border, I don't see
why zeroing upto folio_size() border any conceptually different.
Might require some bug squeezing, sure.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

