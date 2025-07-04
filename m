Return-Path: <linux-fsdevel+bounces-53990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 687C2AF9BBA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 22:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9743AE335
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 20:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FEA246793;
	Fri,  4 Jul 2025 20:37:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plwbeout05.prod.sxb1.secureserver.net (sxb1plwbeout05.prod.sxb1.secureserver.net [188.121.53.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1341E2E36E7
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751661420; cv=none; b=m+CkD6C3Y0Z2uvwyfOWFwKKF5uocOGI9t2ELcQZd//L3ltaoIALkHohPV5MX8QIDgWp4bF1DttWRk0RXw638BmRer6E7PGUvy7jAPfMnI5yZdDUnngOsYe8jbg6pS/rdAbSYaCI6O/uuRc72mdEUq0XHaIiUMDYgt6jX2EZtZnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751661420; c=relaxed/simple;
	bh=7wt1aA/Y6+bwD+sUGk5sKOMU16N/kgJnFcSB6eZIRW0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=n4tWTfzqF5yxL7vNdrEnm4pAzTaQHJaIIPrJlflwoQTYowcUqeTjvPSqGts+S5/8DyBYSReyRos5GvfzHhPmCtAFrY92gHDhMI0AuT4iIhsU8oTfIwfbBA/AESD3tTdirWGcAMAPyTdGRqOaEPKJ2KVOpI7xXd16Ldmd/mtXJhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
X-MW-NODE: 
X-CMAE-Analysis: v=2.4 cv=V4N90fni c=1 sm=1 tr=0 ts=686830d2
 a=dFffxkGDbYo3ckkjzRcKYg==:117 a=dFffxkGDbYo3ckkjzRcKYg==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=8pif782wAAAA:8 a=9qxNCY_qAAAA:8
 a=PCSORCwJg7iORsY_thYA:9 a=QEXdDO2ut3YA:10 a=EebzJV9D4rpJJoWO5PQE:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
X-SID: XmRmuHadriUIv
Date: Fri, 4 Jul 2025 20:51:46 +0100 (BST)
From: Phillip Lougher <phillip@squashfs.org.uk>
To: "Joakim Tjernlund (Nokia)" <joakim.tjernlund@nokia.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: "phillip.lougher@gmail.com" <phillip.lougher@gmail.com>
Message-ID: <443821641.1977435.1751658706057@eu1.myprofessionalmail.com>
In-Reply-To: <88b54d9a1562393526abc4556a6105ef1aca7ace.camel@nokia.com>
References: <bd03e4e1d56d67644b60b2a58e092a0e3fdcff57.camel@nokia.com>
 <88b54d9a1562393526abc4556a6105ef1aca7ace.camel@nokia.com>
Subject: Re: squashfs can starve/block apps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.38.73
X-Originating-Port: 54904
X-Originating-Client: open-xchange-appsuite
X-CMAE-Envelope: MS4xfIDb7ALsXEpRYvChPn9kf/c99U137JqsQXB6RV58Dap7mYGjx5oEnSbCvecwl6GLHbGrVedDU4ijB3Yi2tYmKjQuWs+/+2HslQCL2CfZkXQE1aiaOn5J
 mBGvofneMoxlhonNfsuHtGVvxo1HfgpjVccePg/Q9xmxT/+3mbU3BJPMg18z5pbIqfOp0rqX7L2KalAi/lJ+UJ00LfVymjtBDOhoSGiH5K7rpAmfuW9Essd3
 vKz9tSsj7wQjEgpnyJcq89nZ8uHx5BmPKObzWLWbk7/fRbD8uE5IhmlvG9+5jCQM0PjV0o3W7fCzcvuEdKX8sQ==

> On 26/06/2025 15:27 BST Joakim Tjernlund (Nokia) <joakim.tjernlund@nokia.=
com> wrote:
>=20
> =20
> On Thu, 2025-06-26 at 10:09 +0200, Joakim Tjernlund wrote:
> > We have an app running on a squashfs RFS(XZ compressed) and a appfs als=
o on squashfs.
> > Whenever we validate an SW update image(stream a image.xz, uncompress i=
t and on to /dev/null),=20
> > the apps are starved/blocked and make almost no progress, system time i=
n top goes up to 99+%
> > and the console also becomes unresponsive.
> >=20
> > This feels like kernel is stuck/busy in a loop and does not let apps ex=
ecute.
> >=20

I have been away at the Glastonbury festival, hence the delay in replying. =
But
this isn't really anything to do with Squashfs per se, and basic computer
science theory explains what is going on here.  So I'm surprised no-else ha=
s
responded.

> > Kernel 5.15.185
> >=20
> > Any ideas/pointers ?

Yes,

> >=20
> > =C2=A0Jocke
>=20
> This will reproduce the stuck behaviour we see:
>  > cd /tmp (/tmp is an tmpfs)
>  > wget https://fullImage.xz

You've identified the cause here.

>=20
> So just downloading it to tmpfs will confuse squashfs, seems to
> me that squashfs somehow see the xz compressed pages in page cache/VFS an=
d
> tried to do something with them.

But this is the completely wrong conclusion.  Squashfs doesn't "magically"
see files downloaded into a different filesystem and try to do something
with them.

What is happening is the system is thrashing, because the page cache doesn'=
t
have enough remaining space to contain the working set of the running
application(s).

See Wikipedia article https://en.wikipedia.org/wiki/Thrashing_(computer_sci=
ence)

Tmpfs filesystems (/tmp here) are not backed by physical media, and their
content are stored in the page cache.  So in effect if fullImage.xz takes
most of the page cache (system RAM), then there is no much space left to st=
ore
the pages of the applications that are running, and they constantly replace
each others pages.

To make it easy, imagine we have two processes A and B, and the page cache
doesn't have enough space to store both the pages for processes A and B.

Now:

1. Process A starts and demand-pages pages into the page cache from the
   Squashfs root filesystem.  This takes CPU resources to decompress the pa=
ges.
   Process A runs for a while and then gets descheduled.

2. Process B starts and demand-pages pages into the page cache, replacing
   Process A's pages.  It runs for a while and then gets descheduled.

3 Process A restarts and finds all its pages have gone from page cache, and=
 so
  it has to re-demand-page the pages back.  This replaces Process B's pages=
.

4. Process B restarts and finds all its pages have gone from the page cache=
 ...

In effect the system spends all it's time reading pages from the
Squashfs root filesystem, and doesn't do anything else, and hence it looks
like it has hung.

This is not a fault with Squashfs, and it will happen with any filesystem
(ext4 etc) when system memory is too small to contain the working set of
pages.

Now, to repeat what has caused this is the download of that fullImage.xz
which has filled most of the page cache (system RAM).  To prevent that
from happening, there are two obvious solutions:

1. Split fullImage.xz into pieces and only download one piece at a time.  T=
his
   will avoid filling up the page cache and the system trashing.

2. Kill all unnecessary applications and processes before downloading
   fullImage.xz.  In doing that you reduce the working set to RAM available=
,
   which will again prevent thrashing.

Hope that helps.

Phillip

