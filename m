Return-Path: <linux-fsdevel+bounces-42554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8918A436E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 09:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261C83B7D51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 08:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A527F25C6E2;
	Tue, 25 Feb 2025 08:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="nuB/bCA9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YPoIMkvS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378FB192B8F;
	Tue, 25 Feb 2025 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740470553; cv=none; b=uCWBc33p7U3TpiWi/mH5p2IidpH+BOrpZ/uAoLuxVcdGPeMXLs8I0H41f8b0Ei5jjuXj12gicaQqhPXnJIwKVx9LaZzu3U0J9Zffvb4ff7Jzy3PxXkinF/DjTg/nWT5z0YGBovBgVPCN4eX9wHxwbr4OZtfUkBdsLBsS/Ar1vXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740470553; c=relaxed/simple;
	bh=k1leRad2ojzsetmQP/1iyqy9qsl2R22cOQijt9+MijA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZIO+a0t8+4dHXOU7mjcv7QyHPdgtZKX1FpkrkNC0LBzUVhawRnYcTR0ukxKvazFjY6YmyefvQg4FtdH+rtcZjcgtirMGOhaDYAbtXJ03XcdPM+/5QAck6tahL/q5HHE/ipStWgfuZ9b+AfPNN++j3296gDXza+a3QrMa6MHkPmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=nuB/bCA9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YPoIMkvS; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailflow.stl.internal (Postfix) with ESMTP id BC32C1D40DC7;
	Tue, 25 Feb 2025 03:02:28 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Tue, 25 Feb 2025 03:02:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740470548;
	 x=1740477748; bh=QLBFywS7XyTxwPOejQif6z/28yCPC+NOlxqp7jJivgU=; b=
	nuB/bCA9S1ItHoQccv5Gpf2mwvDce7RRcNcpwlxjDxO1holF+tGByrAapeP7OrFr
	HAk3aSlywo6BQ3aIq3YD97bpYimQZCmCJzQVQ4J7/FjQNoffpOdztKN3jNMkLAsm
	9VGEaeHYbe7aA1pwEwTc5Ly3uUaA5trnjhjeblm3R3qCmYh5gobnjqpCGnSMaJxH
	Q4rT9xQzPWGhTDWs9MOLPKEFr4nLKLYdEEplecb0+f886EV6VW5atz2MXrJXfgSa
	8nO2s+I0QTs8G0bnVObE2Z5vC+C/ADHfqNq9PLbtRtoWaqB9bL1p64n0kbx/qUFh
	GI6t/ArRTPIDtTrox5TXCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740470548; x=
	1740477748; bh=QLBFywS7XyTxwPOejQif6z/28yCPC+NOlxqp7jJivgU=; b=Y
	PoIMkvS6Pmv9DRNik2ZIAlOAGJxA128xi+2AFbN1p4mZSMpWJvjWRKHZs4PLFfc6
	1+aHv049YnYKEfVZEN+sir1Y3b3y0M5hJe6zr9DGoS6Mofb56X+snvlPvlUK0F+4
	mXCUv/SVSH9ziGwDTAMYmz7Q5CpBKdy6teD7hFBcWYrwRSOU7VayJcaFf2MNpoPY
	RwMyBak80wphhNQM/ZbdE2tRPYWKp2xSTpvayyVo+xrq2jkqVAoOaz4M/GmpQhDQ
	GoohNCukP3A1YcdSedH7Ka31l79hVrCqcvm9Qig3waOu8sHkFMFBcxErO5OHkgJx
	1CybiPzK73IGpPLVmfvxA==
X-ME-Sender: <xms:EHm9Z5ksovKix4IxAYOa6NPEsSLcphOoyOjz8HC-1Dt-R6Vx9U_HmQ>
    <xme:EHm9Z02PIBag6kVjBAxYukVUJEdGe04NJq4rDChWSx6WsgtBg87p-_V2omgoWP2jZ
    _7Dx_WXLOJSuAYYKgM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekuddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvleehvddv
    geejvdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeeh
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpd
    hrtghpthhtohepthhssghoghgvnhgusegrlhhphhgrrdhfrhgrnhhkvghnrdguvgdprhgt
    phhtthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtghpthhtoh
    eplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegthhhrihhs
    thhophhhvgdrlhgvrhhohiestghsghhrohhuphdrvghupdhrtghpthhtohepuggrvhgvmh
    esuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehmihgtseguihhgihhkohgurdhn
    vghtpdhrtghpthhtohepmhhpvgesvghllhgvrhhmrghnrdhiugdrrghupdhrtghpthhtoh
    eprghnughrvggrshesghgrihhslhgvrhdrtghomh
X-ME-Proxy: <xmx:EHm9Z_qJ-ITA7HBjaqdXvk3f-nqGrbsu3fDpFPFh2RmK-q6S1Rh3pg>
    <xmx:EHm9Z5nHJC0k8dToMBJ4l8OzwQT8BBLHg391079G2HLzyfUZiOWn0A>
    <xmx:EHm9Z302TC_YPcv_Alc8uVIbhcs_m4NaqklpywGUw6d3uwcpJgO6qQ>
    <xmx:EHm9Z4sdir4sphaNBGTPw7csAyqyoGjyjpv2MyJVBqSCdS8S2iGxGQ>
    <xmx:FHm9Z9FhQ4LWTtKGSN8SQ9W8XolOVrCxrHfKpOz3hrDt-C_9ux6zE9sc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A3F4B2220072; Tue, 25 Feb 2025 03:02:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Feb 2025 09:02:04 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Amir Goldstein" <amir73il@gmail.com>,
 "Andrey Albershteyn" <aalbersh@redhat.com>,
 "Darrick J. Wong" <djwong@kernel.org>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Matt Turner" <mattst88@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Michal Simek" <monstr@monstr.eu>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Helge Deller" <deller@gmx.de>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Naveen N Rao" <naveen@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>,
 "Rich Felker" <dalias@libc.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Chris Zankel" <chris@zankel.net>,
 "Max Filippov" <jcmvbkbc@gmail.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-api@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-xfs@vger.kernel.org, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 "Theodore Ts'o" <tytso@mit.edu>
Message-Id: <6b51ffa2-9d67-4466-865e-e703c1243352@app.fastmail.com>
In-Reply-To: <20250224-klinke-hochdekoriert-3f6be89005a8@brauner>
References: <20250211-xattrat-syscall-v3-1-a07d15f898b2@kernel.org>
 <20250221181135.GW21808@frogsfrogsfrogs>
 <CAOQ4uxgyYBFqkq6cQsso4LxJsPJ4uECOdskXmz-nmGhhV5BQWg@mail.gmail.com>
 <20250224-klinke-hochdekoriert-3f6be89005a8@brauner>
Subject: Re: [PATCH v3] fs: introduce getfsxattrat and setfsxattrat syscalls
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025, at 12:32, Christian Brauner wrote:
> On Fri, Feb 21, 2025 at 08:15:24PM +0100, Amir Goldstein wrote:
>> On Fri, Feb 21, 2025 at 7:13=E2=80=AFPM Darrick J. Wong <djwong@kerne=
l.org> wrote:

>> > > @@ -23,6 +23,9 @@
>> > >  #include <linux/rw_hint.h>
>> > >  #include <linux/seq_file.h>
>> > >  #include <linux/debugfs.h>
>> > > +#include <linux/syscalls.h>
>> > > +#include <linux/fileattr.h>
>> > > +#include <linux/namei.h>
>> > >  #include <trace/events/writeback.h>
>> > >  #define CREATE_TRACE_POINTS
>> > >  #include <trace/events/timestamp.h>
>> > > @@ -2953,3 +2956,75 @@ umode_t mode_strip_sgid(struct mnt_idmap *=
idmap,
>> > >       return mode & ~S_ISGID;
>> > >  }
>> > >  EXPORT_SYMBOL(mode_strip_sgid);
>> > > +
>> > > +SYSCALL_DEFINE4(getfsxattrat, int, dfd, const char __user *, fil=
ename,
>> > > +             struct fsxattr __user *, fsx, unsigned int, at_flag=
s)
>> >
>> > Should the kernel require userspace to pass the size of the fsx buf=
fer?
>> > That way we avoid needing to rev the interface when we decide to gr=
ow
>> > the structure.
>
> Please version the struct by size as we do for clone3(),
> mount_setattr(), listmount()'s struct mnt_id_req, sched_setattr(), all
> the new xattrat*() system calls and a host of others. So laying out the
> struct 64bit and passing a size alongside it.
>
> This is all handled by copy_struct_from_user() and copy_struct_to_user=
()
> so nothing to reinvent. And it's easy to copy from existing system
> calls.

I don't think that works in this case, because 'struct fsxattr'
is an existing structure that is defined with a fixed size of
28 bytes. If we ever need more than 8 extra bytes, then the
existing ioctl commands are also broken.

Replacing fsxattr with an extensible structure of the same contents
would work, but I feel that just adds more complication for little
gain.

On the other hand, there is an open question about how unknown
flags and fields in this structure. FS_IOC_FSSETXATTR/FS_IOC_FSGETXATTR
treats them as optional and just ignores anything it doesn't
understand, while copy_struct_from_user() would treat any unknown
but set bytes as -E2BIG.

The ioctl interface relies on the existing behavior, see
0a6eab8bd4e0 ("vfs: support FS_XFLAG_COWEXTSIZE and get/set of
CoW extent size hint") for how it was previously extended
with an optional flag/word. I think that is fine for the syscall
as well, but should be properly documented since it is different
from how most syscalls work.

    Arnd

