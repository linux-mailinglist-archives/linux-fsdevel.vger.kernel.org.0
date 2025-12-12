Return-Path: <linux-fsdevel+bounces-71174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A20C7CB787D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 02:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 275ED30039E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 01:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2658924DCE3;
	Fri, 12 Dec 2025 01:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5jzf8qo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A91219FC;
	Fri, 12 Dec 2025 01:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765502228; cv=none; b=iyo+aNWr9mIDHxgCwvF0QVXkmr1TOXwq78L6OHAVxUuCJtkehglW7YJziSNc6EYjOq5L/I8LEHLA5jdperz4aT3Zjm3z2UK+uDiPIQjn16EMc7NXkuvZkBWR8bho1V4gUkoh0xRW7jjrYR31wxp7E6qX6EuyoRrTxvuIQI/2Wsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765502228; c=relaxed/simple;
	bh=9TYcESrho76VKCg838GHOj8IUeqDDF8vAva70L9A6Vk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Fqhh1V3RtY6kdNF3teIwsPno2YJUE/DOZLwKOgfhW4J177a0tha9Q637RbRx2XiPDTkCaM5pmNNmkXR+esIRBZsmh80DBgp6cuFYJaW92XMVvWBIt1XsiFQhInPx4UwcjqiUFBViAIDHhYF2+aoIXy/pwVoAWn04LJFN2OHEuL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5jzf8qo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7443BC16AAE;
	Fri, 12 Dec 2025 01:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765502228;
	bh=9TYcESrho76VKCg838GHOj8IUeqDDF8vAva70L9A6Vk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=e5jzf8qo3oMz8H+RHNI6SvEyguI3wkI+NPdMCNpBInkeqI+4THhhHJ88gBzZqS2TF
	 o0DdH854/hz8sDb3VGnxPJ7fgzMuWmpl9E2R7lvbcltGt7AjPNSdyzS6pIeEWJ4nyK
	 4yopRtan4P0DoIMIgaskwR43Sv5wnkv2fwswO9HkM0s8dmSc6aNaMak1cYkcEWPcWv
	 lgOIq2uYlGxn0kFx306CvrHdfvWSzu33SzPJMFCm5ap3/vUeEIZ399UsGahJw+pc+Z
	 TWWaNdHHotpz/s463tNVbi4RlMjgh0DqsCSl7HjPF5eyrO87VJOlxVU9MMZYBrE+iI
	 IMTQ1OwTF9XwA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9D260F40074;
	Thu, 11 Dec 2025 20:17:06 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 11 Dec 2025 20:17:06 -0500
X-ME-Sender: <xms:Em07aXXru7VRw27WV74wnpbmHTxNgqddovrGVuMBqnEN4ymBGMirqQ>
    <xme:Em07aaYy-Zd1hV2IJZ-Ds0WxvL5j_0jXS93mzzOf-RYzDZpFL230v1XhgDN0NBrpB
    7NvIkpjmkWqU71wSkoYmlWoA5vle2CfQnUgAU20XXOt3fEGsHzkKqs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheprgguihhlghgvrhdrkhgvrhhnvghlseguihhlghgvrhdrtggrpdhrtghpthhtoh
    epsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvggsihhgghgvrhhs
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhihhrohhfuhhmihesmhgrihhlrdhprg
    hrkhhnvghtrdgtohdrjhhppdhrtghpthhtohepthihthhsohesmhhithdrvgguuhdprhgt
    phhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhope
    grlhhmrgiirdgrlhgvgigrnhgurhhovhhitghhsehprghrrghgohhnqdhsohhfthifrghr
    vgdrtghomhdprhgtphhtthhopehvohhlkhgvrhdrlhgvnhguvggtkhgvsehsvghrnhgvth
    druggvpdhrtghpthhtoheplhhinhhugidqvgigthegsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:Em07abThipl_qzI3JjqYlaFSEYKA9WxgtgQddbS6Ju-cKrupRIXYnQ>
    <xmx:Em07acP1QGx5L7a7mhBx8FaplQHJm51P79Gm3P67YEX_V-Mwz_m6_A>
    <xmx:Em07aR7bZLLkqiBQ_VijPqanLdWKDVQtUf24f6NjIOKZP0sWIX9egQ>
    <xmx:Em07afWyIMl4axoBXBbfTf8t1Nmxi_BtaYpGWgbEuZPSs19xggesDg>
    <xmx:Em07aYPAc9RI8JlKKUxUfGPsSQ2T9ldrcAdXPkvG9GqC67rE9i0mB2a9>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7834B780054; Thu, 11 Dec 2025 20:17:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AG4gnELdBCjJ
Date: Thu, 11 Dec 2025 20:16:45 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Eric Biggers" <ebiggers@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, hirofumi@mail.parknet.co.jp,
 almaz.alexandrovich@paragon-software.com, tytso@mit.edu,
 adilger.kernel@dilger.ca, Volker.Lendecke@sernet.de,
 "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <9f30d902-2407-4388-805b-b3f928193269@app.fastmail.com>
In-Reply-To: <20251211234152.GA460739@google.com>
References: <20251211152116.480799-1-cel@kernel.org>
 <20251211152116.480799-2-cel@kernel.org> <20251211234152.GA460739@google.com>
Subject: Re: [PATCH v2 1/6] fs: Add case sensitivity info to file_kattr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, Dec 11, 2025, at 6:41 PM, Eric Biggers wrote:
> On Thu, Dec 11, 2025 at 10:21:11AM -0500, Chuck Lever wrote:
>> +/* Values stored in the low-order byte */
>> +enum fileattr_case_folding {
>> +	/* Code points are compared directly with no case folding. */
>> +	FILEATTR_CASEFOLD_NONE = 0,
>> +
>> +	/* ASCII case-insensitive: A-Z are treated as a-z. */
>> +	FILEATTR_CASEFOLD_ASCII,
>> +
>> +	/* Unicode case-insensitive matching. */
>> +	FILEATTR_CASEFOLD_UNICODE,
>> +};
>
> What does "Unicode case-insensitive matching" mean?  There are many
> different things it could mean: there are multiple types of Unicode
> normalization, Unicode case-folding, NTFS's upper case table, etc.
> There are also multiple versions of each.

This is left over from the RFC version of the series, and can be removed.


> I see you're proposing that ext4, fat, and ntfs3 all set
> FILEATTR_CASEFOLD_UNICODE, at least in some cases.
>
> That seems odd, since they don't do the matching the same way.

The purpose of this series is to design the VFS infrastructure. Exactly what
it reports is up to folks who actually understand i18n.


-- 
Chuck Lever

