Return-Path: <linux-fsdevel+bounces-60959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4713B537A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 17:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7035F3BBC39
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 15:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30A934A332;
	Thu, 11 Sep 2025 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejzpmWJY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452E8337683;
	Thu, 11 Sep 2025 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604362; cv=none; b=hnbhJT1udYt1OT4ZvyCjgICyg3YVPssW/pVmy1SRT5YxDDJ+Jdc41bBrcMyJDttFkfHM7al2yZ+IeKAsao5G2+1reBvro6ZZKek12HpyUaLWDRHlE2uZCHMQPB2WgJPf43kSFmux5AcLSAL8APmNcylX5W5x2FSLXPCejvbyUyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604362; c=relaxed/simple;
	bh=SfhJYDJXxv3MqG42eHr0HrwJVpTMBIv1QNwURJTGJO0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Icv+hKrAKajf5OHZyciral+X2E6l4oyUf/iu8kvFko2cJVDT0mn5eDhMPD+cLLdBn5dSmIamJW9jzJY/DR6UiCKDtgtNyl31ZezMCyKxUQqnEPXmP+5Qj+Gw042Z/giqTp0cssx3y0ve9EKib4+iKOLaDRqs89vk5JPyg1Xoms8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejzpmWJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE93C4CEF0;
	Thu, 11 Sep 2025 15:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757604361;
	bh=SfhJYDJXxv3MqG42eHr0HrwJVpTMBIv1QNwURJTGJO0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ejzpmWJYYZgSJBcXyZlmWINCU1vNyNIMcCY6EctxcofNnAFmqD0REPsHHkCeRHq9S
	 cWCV0a7lO7KpY/sSd6ewUAGUaThGtx9kGCareJkUu6Ksz3HbTXOrNc+hckc/hJl5OF
	 7eCsY3HGmCPENjIP8jrAr/1RuX2nmVyg1KSeB9smndL8HtP5zY0JwLlCv1JWchckLA
	 utikQ7ehCTdPAWT1TidQF/lNypeBVcSioOaXQU3OlMT3xKr9nxkp03hCvm3hNtftRc
	 QstSj7oMy82qMG92kUAdiC+c/+GCxcAZ7E43Ieq1fg+yYnnX2uA5xYfQ0KZa7GmJ9+
	 jAqDDor8w/0gA==
Message-ID: <e0da383964e9f398854e70c51e15c02faaf009b9.camel@kernel.org>
Subject: Re: fattr4_archive "deprecated" ? Re: NFSv4.x export options to
 mark export as case-insensitive, case-preserving? Re: LInux NFSv4.1 client
 and server- case insensitive filesystems supported?
From: Trond Myklebust <trondmy@kernel.org>
To: Rick Macklem <rick.macklem@gmail.com>, Cedric Blancher
	 <cedric.blancher@gmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux NFS Mailing List
	 <linux-nfs@vger.kernel.org>
Date: Thu, 11 Sep 2025 11:26:00 -0400
In-Reply-To: <CAM5tNy5=k9_5GsZkbV225ZmMw7S38o30Zt3RDoBC8UKcoxYGbg@mail.gmail.com>
References: 
	<CALXu0Ufzm66Ors3aBBrua0-8bvwqo-=RCmiK1yof9mMUxyEmCQ@mail.gmail.com>
	 <CALXu0Ufgv7RK7gDOK53MJsD+7x4f0+BYYwo2xNXidigxLDeuMg@mail.gmail.com>
	 <44250631-2b70-4ce8-b513-a632e70704ed@oracle.com>
	 <aEZ3zza0AsDgjUKq@infradead.org>
	 <e5e385fd-d58a-41c7-93d9-95ff727425dd@oracle.com>
	 <aEfD3Gd0E8ykYNlL@infradead.org>
	 <CALXu0UfgvZdrotUnyeS6F6qYSOspLg_xwVab8BBO6N3c9SFGfA@mail.gmail.com>
	 <e1ca19a0-ab61-453f-9aea-ede6537ce9da@oracle.com>
	 <CALXu0Uc9WGU8QfKwuLHMvNrq3oAftV+41K5vbGSkDrbXJftbPw@mail.gmail.com>
	 <47ece316-6ca6-4d5d-9826-08bb793a7361@oracle.com>
	 <CAKAoaQ=RNxx4RpjdjTVUKOa+mg-=bJqb3d1wtLKMFL-dDaXgCA@mail.gmail.com>
	 <CAM5tNy7w71r6WgWOz4tXtLi=yvw55t_5dFe_x-13Thy5NgjEGA@mail.gmail.com>
	 <CALXu0Uep=q9mu1suZ0r04MGJn-xRn2twiRtQbGgtr1eZ7D_6sg@mail.gmail.com>
	 <CAM5tNy5=k9_5GsZkbV225ZmMw7S38o30Zt3RDoBC8UKcoxYGbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-11 at 08:01 -0700, Rick Macklem wrote:
> On Thu, Sep 11, 2025 at 1:08=E2=80=AFAM Cedric Blancher
> <cedric.blancher@gmail.com> wrote:
> >=20
> > CAUTION: This email originated from outside of the University of
> > Guelph. Do not click links or open attachments unless you recognize
> > the sender and know the content is safe. If in doubt, forward
> > suspicious emails to IThelp@uoguelph.ca.
> >=20
> > On Wed, 10 Sept 2025 at 15:38, Rick Macklem
> > <rick.macklem@gmail.com> wrote:
> > >=20
> > > On Wed, Sep 10, 2025 at 3:47=E2=80=AFAM Roland Mainz
> > > <roland.mainz@nrubsig.org> wrote:
> > > >=20
> > > > On Tue, Sep 9, 2025 at 9:32=E2=80=AFPM Chuck Lever
> > > > <chuck.lever@oracle.com> wrote:
> > > > >=20
> > > > > On 9/9/25 12:33 PM, Cedric Blancher wrote:
> > > > > > On Tue, 9 Sept 2025 at 18:12, Chuck Lever
> > > > > > <chuck.lever@oracle.com> wrote:
> > > > > > >=20
> > > > > > > On 9/9/25 12:06 PM, Cedric Blancher wrote:
> > > > > > > > Due lack of a VFS interface and the urgend use case of
> > > > > > > > needing to
> > > > > > > > export a case-insensitive filesystem via NFSv4.x, could
> > > > > > > > we please get
> > > > > > > > two /etc/exports options, one setting the case-
> > > > > > > > insensitive boolean
> > > > > > > > (true, false, get-default-from-fs) and one for case-
> > > > > > > > preserving (true,
> > > > > > > > false, get-default-from-fs)?
> > > > > > > >=20
> > > > > > > > So far LInux nfsd does the WRONG thing here, and
> > > > > > > > exports even
> > > > > > > > case-insensitive filesystems as case-sensitive. The
> > > > > > > > Windows NFSv4.1
> > > > > > > > server does it correctly.
> > > > >=20
> > > > > As always, I encourage you to, first, prototype in NFSD the
> > > > > hard-coding
> > > > > of these settings as returned to NFS clients to see if that
> > > > > does what
> > > > > you really need with Linux-native file systems.
> > > >=20
> > > > If Cedric wants just case-insensitive mounts for a Windows
> > > > NFSv4
> > > > (Exceed, OpenText, ms-nfs41-client, ms-nfs42-client, ...), then
> > > > the
> > > > only thing needed is ext4fs or NTFS in case-insensitive mode,
> > > > and that
> > > > the Linux NFSv4.1 server sets
> > > > FATTR4_WORD0_CASE_INSENSITIVE=3D=3Dtrue and
> > > > FATTR4_WORD0_CASE_PRESERVING=3D=3Dtrue (for FAT
> > > > FATTR4_WORD0_CASE_PRESERVING=3D=3Dfalse). Only applications using
> > > > ADS
> > > > (Alternate Data Streams) will not work, because the Linux NFS
> > > > server
> > > > does not support "OPENATTR"&co ops.
> > > >=20
> > > > If Cedric wants Windows home dirs:
> > > > This is not working with the Linux NFSv4.1 server, because it
> > > > must support:
> > > > - FATTR4_WORD1_SYSTEM
> > > > - FATTR4_WORD0_ARCHIVE
> > > > - FATTR4_WORD0_HIDDEN
> > > > - Full ACL support, the current draft POSIX-ACLs in Linux
> > > > NFSv4.1
> > > > server&&{ ext4fs, btrfs, xfs etc. } causes malfunctions in the
> > > > Windows
> > > > "New User" profile setup (and gets you a temporary profile in
> > > > C:\Users\*.temp+lots of warnings and a note to log out
> > > > immediately
> > > > because your user profile dir has been "corrupted")
> > > >=20
> > > > Windows home dirs with NFSv4 only work so far with the
> > > > Solaris&&Illumos NFS servers, and maybe the FreeBSD >=3D 14 NFS
> > > > server
> > > > (not tested yet).
> > > I'll just note that the named attribute support (the windows
> > > client
> > > folk like the name)
> > > along with Hidden and System are in 15 only.
> > > And Archive is not supported because it is listed as "deprecated"
> > > in the RFC.
> > > (If this case really needs it, someone should try to get it
> > > "undeprecated" on
> > > nfsv4@ietf.org. I could add Archive easily. All of these are for
> > > ZFS only.
> > > ZFS also knows case insensitive, although I have not tried it.)
> >=20
> > Who (name!) had the idea to declare fattr4_archive as "deprecated"?
> > It
> > was explicitly added for Windows and DOS compatibility in NFSv4,
> > and
> > unlike Windows EAs (which are depreciated, and were superseded by
> > "named streams") the "archive" attribute is still in use.
> I have no idea who would have done this, but here is the snippet from
> RFC5661 (which started being edited in 2005 and was published in
> 2010,
> so it has been like this for a long time). The same words are in
> RFC8881
> and currently in the RFC8881bis draft. Can this be changed?
> I'd say yes, but it will take time and effort on someone's part.
> Posting to nfsv4@ietf.org, noting that this attribute is needed
> by the Windows client (and at least a suggestion that time_backup
> is not a satisfactory replacement) would be a good start.
>=20
> 5.8.2.1.=C2=A0 Attribute 14: archive
>=20
> =C2=A0=C2=A0 TRUE, if this file has been archived since the time of last
> =C2=A0=C2=A0 modification (deprecated in favor of time_backup).
>=20
> The problem has been a serious lack of Windows expertise in the NFSv4
> working group. Long ago (20+ years) the Hummingbird developers were
> actively involved (Hummingbird became Open Network Solutions, which
> became a division of OpenText, if I recall it correctly).
>=20
> But there has been no one with Windows expertise involved more
> recently.
>=20
> My suggestion (I'll repeat it) is to have someone participate in the
> Bakeathon
> testing events (the next one is in about one month and can be
> attended
> remotely using a tailscale VPN). When someone tests at the event and
> finds an issue, the server developers are there and can discussion
> what
> it takes to fix it.
>=20
> Also, participation on the nfsv4@ietf.org=C2=A0mailing list (some working
> group
> members will not be reading this Linux list) and attendance at
> working
> group meetings would help. (The working group meetings can
> also be attended remotely and there is an automatic fee waiver for
> remote attendance if you, like me, are not funded to do the work.)
>=20
> With no involvement from people with Windows expertise, the testing
> has become basically a bunch of servers being tested against by
> various versions of the Linux client (with me being at outlier,
> testing
> the FreeBSD client).

As stated in the line you quote, it is listed as being deprecated in
favour of the backup time because the latter provides a superset of the
same functionality: by comparing the value of the backup time to the
value of the mtime, you can determine the value of the archive bit (it
is set if the backup time is newer than the mtime).

In addition, the backup time also tells you exactly when the file was
last backed up.

So no, this is not about people who don't understand Windows. It's
about repackaging the same functionality in a way that is more useful
to people who understand backups.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

