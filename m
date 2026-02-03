Return-Path: <linux-fsdevel+bounces-76207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPIeG9wYgmmZPAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 16:48:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB0DDB818
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 16:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C4FC30EC5E0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 15:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513823B9610;
	Tue,  3 Feb 2026 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTiJRmMc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33973B9605
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770133334; cv=none; b=baqQ9RtJbBn81QyXiCFTkqIU4TGmlMDrrLziMExqXxewCZO80s0R7Eo2fBv+w6X1HB5q14saSgiDiRSJHcng2CzUM97Z6J+LiMIghlJJ6YnhEi2ReVARnKZeHqMdtOORwqtMFq5hE9n58Unvd0gYnwPoHLAimhpOMJk5IUuR52g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770133334; c=relaxed/simple;
	bh=3m6PM7BiTfYOv0eengmhgqKYzAjLzI/HkhF1VU3RCnE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Xn7+syeMDPDpC8SgvCGeqDlFH6BG+z8W/n2JHcB9JsLxdWYsukYDB7J2QrN/Ah6zh/nORxOdOkXIUjqV8tg2OD7H6xROflFOYeW8nNmkQOQWyMeR44ZMe9jdqsSKYbWJDHOQzzCayooYbSb/vsTOzV2YL0fp0tLskmOt1vDKtts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTiJRmMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94ABFC116D0
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 15:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770133334;
	bh=3m6PM7BiTfYOv0eengmhgqKYzAjLzI/HkhF1VU3RCnE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=hTiJRmMc68PzXZzo3rk5pIHo3FEuKZml110/dH+yBPj9fc/bJN36Dx9Q+o2k479ZA
	 dbuE9BBrj1WJtd5wyDm7EubV0GqhspK0H9JwezrOEY+9W96fR8Ve1XZ7x45D2CwpCW
	 4WBJxyYKhJOgv41Vnh6DcAWyinUJ3keH7uYnosdbeW20zi+b/HEsAYWmxGcjKljnFm
	 pM3lxpzXod3O9rZdGJhCe5IgAzkkSz7SjzygqwolymRxKpaJQlyJtjZz+X4G7MuL/Q
	 S6hOEHveJVyypTfKLko/waDS3leLV/YHSJ9KQ+Posp3EMsPPcciiNL22fAAPKB0nj4
	 R7MlqhPT29AdQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8DC2BF40068;
	Tue,  3 Feb 2026 10:42:13 -0500 (EST)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-02.internal (MEProxy); Tue, 03 Feb 2026 10:42:13 -0500
X-ME-Sender: <xms:VReCaU0E5VQhxrnNNTWe65aDJ6kepY_g3IIqitt9hes8da2Rt9DnxA>
    <xme:VReCaZ7W6n-4zRjEx4MHIJnHx9ijV-ZDAlPlowGJ9AEdVDAqJbucbRQmHDCvcE-t9
    hfCOad93jHYFGVeFai5VWltDxk7_v7MgXM-7FsSnsBxTscmbqNJz04j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedtgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehnnhgr
    ucfutghhuhhmrghkvghrfdcuoegrnhhnrgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpeeuudehieehteekfeeuffeugfeihfeugeevfeejveffueehieevjeeggffh
    jeehkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghnnhgrodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdduieejjeduvddtjeelqdeffedvvdefgeejuddqrghnnhgrpe
    epkhgvrhhnvghlrdhorhhgsehnohifhhgvhigtrhgvrghmvghrhidrtghomhdpnhgspghr
    tghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhgruhhnvg
    hrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehsfhhorhhshhgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepthhrohhnughmhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrghn
    uggvrhesmhhihhgrlhhitgihnhdrtghomhdprhgtphhtthhopehjrggtkhesshhushgvrd
    gtiidprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:VReCacZSz_jgt5atIJ--lInunwoUf_isHc7F7f0nwjc_cHMfN3ou_A>
    <xmx:VReCaTT1EC4fWDniDuKQ2Me9lJxiTm4td5OSILSt4XZCAVIQmEkIMQ>
    <xmx:VReCaT86QM07ak_slf_X29BRCht82VBoicniuk5tFtzsExWl2sh-KQ>
    <xmx:VReCabjR8il8TUDpKzGbNwkbEdN0pkVzCRh4DKX3zlLl3SA03udurQ>
    <xmx:VReCacbUv7Kv8kTmg9ART5cfjxcWuMGqbu-x3HKCu88NHSYvThRS6rBg>
Feedback-ID: i20964851:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 647D0B6006E; Tue,  3 Feb 2026 10:42:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AQ5zJGJASj87
Date: Tue, 03 Feb 2026 10:41:52 -0500
From: "Anna Schumaker" <anna@kernel.org>
To: "Christian Brauner" <brauner@kernel.org>,
 "Jeff Layton" <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, "Trond Myklebust" <trondmy@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>,
 "Alexander Mikhalitsyn" <alexander@mihalicyn.com>
Message-Id: <b9e9b0dd-745b-46fb-9e62-807d53dd417c@app.fastmail.com>
In-Reply-To: <20260203-leimen-kundgeben-7be98e9cd156@brauner>
References: <20260129-twmount-v1-1-4874ed2a15c4@kernel.org>
 <20260203-leimen-kundgeben-7be98e9cd156@brauner>
Subject: Re: [PATCH] vfs: add FS_USERNS_DELEGATABLE flag and set it for NFS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76207-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid,oracle.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CBB0DDB818
X-Rspamd-Action: no action



On Tue, Feb 3, 2026, at 10:08 AM, Christian Brauner wrote:
> On Thu, 29 Jan 2026 16:47:43 -0500, Jeff Layton wrote:
>> Commit e1c5ae59c0f2 ("fs: don't allow non-init s_user_ns for filesystems
>> without FS_USERNS_MOUNT") prevents the mount of any filesystem inside a
>> container that doesn't have FS_USERNS_MOUNT set.
>> 
>> This broke NFS mounts in our containerized environment. We have a daemon
>> somewhat like systemd-mountfsd running in the init_ns. A process does a
>> fsopen() inside the container and passes it to the daemon via unix
>> socket.
>> 
>> [...]
>
> Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
> Patches in the vfs-7.0.misc branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.

Acked-by: Anna Schumaker <anna.schumaker@oracle.com>

>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-7.0.misc
>
> [1/1] vfs: add FS_USERNS_DELEGATABLE flag and set it for NFS
>       https://git.kernel.org/vfs/vfs/c/269c46e936f3

