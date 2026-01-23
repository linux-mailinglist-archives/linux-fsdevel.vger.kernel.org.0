Return-Path: <linux-fsdevel+bounces-75305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WICpI7aYc2lgxQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 16:50:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF27077FAA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 16:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9DBF6300729F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 15:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D9A28751D;
	Fri, 23 Jan 2026 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oe08t/o/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16AF2D6E76;
	Fri, 23 Jan 2026 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769183405; cv=none; b=TTF6JMw8Xwxw+K9iaTE2pmeSWotJeh/7v9a+nLsykETjm12C3cRxxfoqsjH9G8WQwHQt+/lhZJrkTKa4NyOnaYIsGh89Kwne79pntg+6JrkjqOfll8GMUAR0y5nsKq8gCUQP7+9KmDrb0dzyxmEJ1unPNRhi6mevuMTQyrYb5lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769183405; c=relaxed/simple;
	bh=kDP9Yb3CbfggR8X+hWoqLQMPd20AumtY0Il/c8TNaKY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Ca5jGWz6WrM5WBETKs7kcZMzz61dcfgoVHSB+FzHoUIdSgO1ykeqPJWDHUMJ9b599WARaZ4zF+cqW5o2K8xwiMVpzitOvujaQj3ZkeAXVcGhiumnRtAFZXo5thOis2Yg0xPVqJUlploC4fgliKCYF5WGrH8wW+xQxS4hx9xyypM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oe08t/o/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2876AC19421;
	Fri, 23 Jan 2026 15:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769183405;
	bh=kDP9Yb3CbfggR8X+hWoqLQMPd20AumtY0Il/c8TNaKY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Oe08t/o/2NDsUrMKUH1M6DPGJM2ZN7cDoW08+cOE4juSlAGvrXORrSwCclCZw2aDV
	 ZkVTKgFOWWiO1/7UD1FizCrSF5aPkbMt0Xz4yP7v5wFhzCq1Ehfu3cawiSSiJn4aFe
	 tMl2S1/Ku9JhhGFB7uQXeL5ZqG6ZVdbkqwNvLCmPFT6cK/SRjDjHv08QbhhTdsOSlg
	 YMufXMi1X8phtUbamkl5WfuMZM1sjX7V2NmsZD7t/TCp+rOJJNc02MHDzBzX/GOr5L
	 jR8J1YHTCxnnSmEGS1fVMkvtoFxQA5PdCm3odBjzpdLrYydUjdPpPGZlr8mqEYL1Up
	 hVo8FmzWqbd9w==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0A23CF40068;
	Fri, 23 Jan 2026 10:50:03 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 23 Jan 2026 10:50:03 -0500
X-ME-Sender: <xms:qphzaYMIDusB_Xk8Iw4J_qqx-jkUaULhjU_4qBqzWqUpKgNdpST7Cg>
    <xme:qphzaZwl8v4sf68uioXcKj_hJesszvmBEUsFWRFNXVrVwnqNhC5YZvqLhTM2T-XL_
    29Ydjf5oRad8fHsuBJog-RE6knXPauD3N-ITfWRSm2Ph-WFBMqAALk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeelgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepfeefpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehsvghnohiihhgrthhskhihsegthhhrohhmihhumhdrohhrghdprhgtphhtth
    hopegrughilhhgvghrrdhkvghrnhgvlhesughilhhgvghrrdgtrgdprhgtphhtthhopehs
    lhgrvhgrseguuhgsvgihkhhordgtohhmpdhrtghpthhtoheprhhonhhnihgvshgrhhhlsg
    gvrhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gtvghmsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhgroheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepughjfihonhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:qphzaSbprTumlZMvqgi-fN0ySmTrpZ1Sy0mhtQX_uK9_de-fQjcsIQ>
    <xmx:qphzacPOrC9HHyrIfATDQn96t02Xea-4bAtCO00lX8l1ixs2IPp1Qg>
    <xmx:qphzaV7RqCEgahzQH87IyqIo3vInECWRwzjRgOBG54mM8UGQ7ppphw>
    <xmx:qphzaXdkpZ-ujvs4OTjQ3zL-M4ps1358Ma37t8lfmfNwKytySSzPTw>
    <xmx:q5hzaR40E4HhwCPyJxnEpYdnMVQu5gKh2EFfpqDTxHOkz4PYOS4LUXhO>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D0B1A780075; Fri, 23 Jan 2026 10:50:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AX_vFn8fWldV
Date: Fri, 23 Jan 2026 10:49:38 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-api@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net,
 "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>,
 "Namjae Jeon" <linkinjeon@kernel.org>,
 "Sungjong Seo" <sj1557.seo@samsung.com>,
 "Yuezhang Mo" <yuezhang.mo@sony.com>,
 almaz.alexandrovich@paragon-software.com,
 "Viacheslav Dubeyko" <slava@dubeyko.com>, glaubitz@physik.fu-berlin.de,
 frank.li@vivo.com, "Theodore Tso" <tytso@mit.edu>,
 adilger.kernel@dilger.ca, "Carlos Maiolino" <cem@kernel.org>,
 "Steve French" <sfrench@samba.org>, "Paulo Alcantara" <pc@manguebit.org>,
 "Ronnie Sahlberg" <ronniesahlberg@gmail.com>,
 "Shyam Prasad N" <sprasad@microsoft.com>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Jaegeuk Kim" <jaegeuk@kernel.org>,
 "Chao Yu" <chao@kernel.org>, "Hans de Goede" <hansg@kernel.org>,
 senozhatsky@chromium.org, "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <95aa2a65-e1e8-44ef-a62a-e3190a11cb32@app.fastmail.com>
In-Reply-To: <20260123002904.GM5945@frogsfrogsfrogs>
References: <20260122160311.1117669-1-cel@kernel.org>
 <20260122160311.1117669-8-cel@kernel.org>
 <20260123002904.GM5945@frogsfrogsfrogs>
Subject: Re: [PATCH v7 07/16] ext4: Report case sensitivity in fileattr_get
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-75305-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.cz:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BF27077FAA
X-Rspamd-Action: no action



On Thu, Jan 22, 2026, at 7:29 PM, Darrick J. Wong wrote:
> On Thu, Jan 22, 2026 at 11:03:02AM -0500, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>> 
>> Report ext4's case sensitivity behavior via the FS_XFLAG_CASEFOLD
>> flag. ext4 always preserves case at rest.
>> 
>> Case sensitivity is a per-directory setting in ext4. If the queried
>> inode is a casefolded directory, report case-insensitive; otherwise
>> report case-sensitive (standard POSIX behavior).
>> 
>> Reviewed-by: Jan Kara <jack@suse.cz>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/ext4/ioctl.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>> 
>> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
>> index 7ce0fc40aec2..462da7aadc80 100644
>> --- a/fs/ext4/ioctl.c
>> +++ b/fs/ext4/ioctl.c
>> @@ -996,6 +996,13 @@ int ext4_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
>>  	if (ext4_has_feature_project(inode->i_sb))
>>  		fa->fsx_projid = from_kprojid(&init_user_ns, ei->i_projid);
>>  
>> +	/*
>> +	 * Case folding is a directory attribute in ext4. Set FS_XFLAG_CASEFOLD
>> +	 * for directories with the casefold attribute; all other inodes use
>> +	 * standard case-sensitive semantics.
>> +	 */
>> +	if (IS_CASEFOLDED(inode))
>> +		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
>
> Curious.  Shouldn't the VFS set FS_XFLAG_CASEFOLD if the VFS casefolding
> flag is set?
>
> OTOH, there are more filesystems that apparently support casefolding
> (given the size of this patchset) than actually set S_CASEFOLD.  I think
> I'm ignorant of something here...

I'm not clear if there's a review action needed. Help?


-- 
Chuck Lever

