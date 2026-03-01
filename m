Return-Path: <linux-fsdevel+bounces-78853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEfxEMd1pGk4hwUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 18:22:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9DA1D0D0E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 18:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CDDB3003ED0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2026 17:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F93F332EA7;
	Sun,  1 Mar 2026 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+0Zx4fi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCF230AD05;
	Sun,  1 Mar 2026 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772385693; cv=none; b=qZ5h0S1h+h3i/CA0SkbBbjDS9wJR6qDoqHD2A8nmOzi4fI2/fpgNAMs6jh411wtLdexKzruMlTp3Tp4fT/gqImwdGrPZzGdjjSr1s4cfbgGPMejjbSqTroUeFQZxUhiw9K8NdI8DP9ZgY8u8wTHXsfkVmH/QDfr4obXugtk/6gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772385693; c=relaxed/simple;
	bh=hwcGfL/oQf0JR4fA95FfSbGguRaydCp9gZr/sLU7S7A=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AJd0YIXQAwyVBjLioTtj1OWDqVlceAKsCijVxmTlWdEgpbUenfnM3MJa4ldCIQtEyxuRiAhXMrLo/L7jVIcAVLoLxTx98b8I+2luoT3o5l5SAQ1ujA5yN2nt67Hd6u0pyNEjKTpO/VDdpNp9K/O28Ks5Xp7gl7QnBICJA1LLDmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+0Zx4fi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4EDC116C6;
	Sun,  1 Mar 2026 17:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772385693;
	bh=hwcGfL/oQf0JR4fA95FfSbGguRaydCp9gZr/sLU7S7A=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=I+0Zx4fiEF2Te8/xRCeBiP8m/36eg8dL1txtDkCcZIK5mg1Fbw45sWnG3LoGT9t8Y
	 a6NuhzItwRHF2kcJc/qVqcLQV20FoOCG9/OgTY/xrfm4hBfI+jEyQzUnTYFXJRr0Kn
	 PcaTdazVlWLoo5353nz1JARPneRiQWeRooJAMRtsVg3Pb+T2IKc3XERoK4ycILSuS7
	 h3IYXVqLSN6A6KAQW6JdCE5cSJ+Xb/N1qXLs36AMsOTEDsDEvJfb5CoYFmOm466njI
	 G7o6Zm+7WrJV5fTP8i0PqsYcj7L5nmmkxUmUdFkJ2hx4Fqd+2uAPtIY6UO2lc+zg9E
	 TocZCAiF1TKKg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 762BAF40069;
	Sun,  1 Mar 2026 12:21:31 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sun, 01 Mar 2026 12:21:31 -0500
X-ME-Sender: <xms:m3WkaYsGj-bOuyJM-T6LeCy1YliMaD_SS1Me2KD41prtc04m_JO9ww>
    <xme:m3WkaQR_eRjy7bsrTG9z5FE4SElaqLxKX7MiAyhQUnWtxcGUI0X2FE3-rEU-b2q3q
    sM3wXWzF8GBe6eP-GBKLduVtTLXTeikbxzEqp-oiQk5ul85YIvcPJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheehfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefghfeguedtieeiveeugfevtdejfedukeevgfeggfeugfetgfeltdetueelleelteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhopegsrhgruh
    hnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomh
    dprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopehn
    vghilhgssehofihnmhgrihhlrdhnvghtpdhrtghpthhtohepohhkohhrnhhivghvsehrvg
    guhhgrthdrtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgtohhmpdhrtghpthht
    ohepjhgrtghksehsuhhsvgdrtgii
X-ME-Proxy: <xmx:m3WkaXHsve7AsKk_OUjsf5GWLWeEP-l0HTOfHHLKvH97qyE2eUPiTw>
    <xmx:m3WkaccDdmqPZInkpPjyqNzo2AvAfOb-yuXrxMyPLXyC0jAGpUZy7g>
    <xmx:m3WkaYpzsTJR3ZIhEZYv8RQKoiFWTYOs3Lsf-JdJVq0STJJHkRdtyQ>
    <xmx:m3WkaVCs_oQtNuRDY7BZilYuvej6vOTk3OMea65eHVSMUU2xDfIeAw>
    <xmx:m3WkaZdf7yXkrBcNzkFTcQ6imXfJc6tfc2bT3TOcTNCThtlPW990y9Tm>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4F95E780070; Sun,  1 Mar 2026 12:21:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AVsRjBM015Tw
Date: Sun, 01 Mar 2026 12:20:54 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Jan Kara" <jack@suse.cz>, "Christian Brauner" <brauner@kernel.org>,
 "Jan Kara" <jack@suse.com>, NeilBrown <neilb@ownmail.net>,
 "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <d7f2562a-7d32-41d5-a02e-904aa4203ed3@app.fastmail.com>
In-Reply-To: 
 <CAOQ4uxiX5anNeZge9=uzw8Dkbad3bMBk5Ana5S94t9VfKNFO5g@mail.gmail.com>
References: <20260224163908.44060-1-cel@kernel.org>
 <20260224163908.44060-2-cel@kernel.org>
 <20260226-alimente-kunst-fb9eae636deb@brauner>
 <CAOQ4uxhEpf1p3agEF7_HBrhUeKz1Fb_yKAQ0Pjo0zztTJfMoXA@mail.gmail.com>
 <1165a90b-acbf-4c0d-a7e3-3972eba0d35a@kernel.org>
 <jxyalrg3a2yjtjfmdylncg7fz63jstbq6pwhhqlaaxju5sk72f@55lb7mfucc5i>
 <3cff098e-74a8-4111-babb-9c13c7ba2344@kernel.org>
 <CAOQ4uxiX5anNeZge9=uzw8Dkbad3bMBk5Ana5S94t9VfKNFO5g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] fs: add umount notifier chain for filesystem unmount
 notification
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78853-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,suse.com,ownmail.net,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2E9DA1D0D0E
X-Rspamd-Action: no action



On Sun, Mar 1, 2026, at 9:37 AM, Amir Goldstein wrote:
> On Fri, Feb 27, 2026 at 4:10=E2=80=AFPM Chuck Lever <cel@kernel.org> w=
rote:
>>
>> On 2/26/26 8:32 AM, Jan Kara wrote:
>> > On Thu 26-02-26 08:27:00, Chuck Lever wrote:
>> >> On 2/26/26 5:52 AM, Amir Goldstein wrote:
>> >>> On Thu, Feb 26, 2026 at 9:48=E2=80=AFAM Christian Brauner <braune=
r@kernel.org> wrote:
>> >>>> Another thing: These ad-hoc notifiers are horrific. So I'm pitch=
ing
>> >>>> another idea and I hope that Jan and Amir can tell me that this =
is
>> >>>> doable...
>> >>>>
>> >>>> Can we extend fsnotify so that it's possible for a filesystem to
>> >>>> register "internal watches" on relevant objects such as mounts a=
nd
>> >>>> superblocks and get notified and execute blocking stuff if neede=
d.
>> >>>>
>> >>>
>> >>> You mean like nfsd_file_fsnotify_group? ;)
>> >>>
>> >>>> Then we don't have to add another set of custom notification mec=
hanisms
>> >>>> but have it available in a single subsystem and uniformely avail=
able.
>> >>>>
>> >>>
>> >>> I don't see a problem with nfsd registering for FS_UNMOUNT
>> >>> event on sb (once we add it).
>> >>>
>> >>> As a matter of fact, I think that nfsd can already add an inode
>> >>> mark on the export root path for FS_UNMOUNT event.
>> >>
>> >> There isn't much required here aside from getting a synchronous no=
tice
>> >> that the final file system unmount is going on. I'm happy to try
>> >> whatever mechanism VFS maintainers are most comfortable with.
>> >
>> > Yeah, then as Amir writes placing a mark with FS_UNMOUNT event on t=
he
>> > export root path and handling the event in
>> > nfsd_file_fsnotify_handle_event() should do what you need?
>>
>> Turns out FS_UNMOUNT doesn't do what I need.
>>
>> 1/3 here has a fatal flaw: the SRCU notifier does not fire until all
>> files on the mount are closed. The problem is that NFSD holds files
>> open when there is outstanding NFSv4 state. So the SRCU notifier will
>> never fire, on umount, to release that state.
>>
>> FS_UNMOUNT notifiers have the same issue.
>>
>> They fire from fsnotify_sb_delete() inside generic_shutdown_super(),
>> which runs inside deactivate_locked_super(), which runs when s_active
>> drops to 0. That requires all mounts to be freed, which requires all
>> NFSD files to be closed: the same problem.
>>
>> For any notification approach to actually do what is needed, it needs=
 to
>> fire during do_umount(), before propagate_mount_busy(). Something lik=
e:
>>
>> do_umount(mnt):
>>     <- NEW: notify subsystems, allow them to release file refs
>>     retval =3D propagate_mount_busy(mnt, 2)   // now passes
>>     umount_tree(mnt, ...)
>>
>> This is what Christian's "internal watches... execute blocking stuff"
>> would need to enable. The existing fsnotify plumbing (groups, marks,
>> event dispatch) provides the infrastructure, but a new notification h=
ook
>> in do_umount() is required =E2=80=94 neither fsnotify_vfsmount_delete=
() nor
>> fsnotify_sb_delete() fires early enough.
>>
>> But a hook in do_umount() fires for every mount namespace teardown, n=
ot
>> just admin-initiated unmounts. NFSD's callback would need to filter
>> (e.g., only act when it's the last mount of a superblock that NFSD is
>> exporting).
>>
>> This is why I originally went with fs_pin. Not saying the series shou=
ld
>> go back to that, but this is the basic requirement: NFSD needs
>> notification of a umount request while files are still open on that
>> mount, so that it can revoke the NFSv4 state and close those files.
>>
>
> I understand the problem with FS_UNMOUNT, but I fail to understand
> the desired semantics, specifically the "the last mount of a superblock
> that NFSD is exporting".

Perhaps that description nails down too much implementation detail,
and it might be stale. A broader description is this user story:

"As a system administrator, I'd like to be able to unexport an NFSD
share that is being accessed by NFSv4 clients, and then unmount it,
reliably (for example, via automation). Currently the umount step
hangs if there are still outstanding delegations granted to the NFSv4
clients."

The discussion here has added some interesting corner cases: NFSD
can export bind mounts (portions of a local physical file system);
unprivileged users can create and umount file systems using "share".

The goal is to make umount behavior more deterministic without
having to insert additional adminstrative steps.

--=20
Chuck Lever

