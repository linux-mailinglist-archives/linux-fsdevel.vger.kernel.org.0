Return-Path: <linux-fsdevel+bounces-45769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78015A7BE80
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 15:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1461B60A5B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 13:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097631F3BAC;
	Fri,  4 Apr 2025 13:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="C++QbNXB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1851F152A;
	Fri,  4 Apr 2025 13:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.235.159.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743774872; cv=none; b=uhXKjB8V05qZ8MmR4RVPkUD+sCeEXNcRKdd+xgUVhSQjY3rvxaXc7t9BHr/p/8voaKPnYa5aK4EURm25UwMl6tfAjzslpc/a73nW9/gMZomPsAr80zZEqMCe11J0wBhqWncogxY/06piCRnOWHx8zk4Pu5Sl6GOThWZf4Og3dMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743774872; c=relaxed/simple;
	bh=fWaw2ZUPGKmOQZAHXiRFC7j4hJRlnQ1r68G5x96Gep0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=eUg3Te8BtAPkbW44P7BOR+GbL9chJPqqlgevlU+xqIBR4Mct9am39UVux4Cmi8o5rS4dhvDctLMqBCQPS2aB5MjZHkQs+TEKIi0r8ovNZp/b4qzDW+Rk/sHWO6iyvlzlXEuXUbinvMm5NKu4iPo4CdsecSfXRpnJVD8/i6YMJXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=C++QbNXB; arc=none smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
Date: Fri, 04 Apr 2025 13:54:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1743774863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBpwiga24ZDFaxXlPSaint51OdZYZUZt9Yg1IPcK0sU=;
	b=C++QbNXBf9Xz8W7pwLbb3YxlcSx1P7KFpN9LKOg+Ltar2eLyO5PkiHRba0qIEo8t/5bRnD
	vloHNopiuEv7+u7qeBqWu+BUYyO3sb5w0/gMgjmRGnjFXGcwTLB2bIs1KDFP3535lZNi0x
	35ViKjTx84H5xvH+KGphILsFiNNllR8mifZ1KaVJ7iP9dxY6wDpkJm/1k73w1vEl5TvpzF
	9viKAKC4mGJuaNczjwzeqPwfSzbZDNOojhVwZqAKmSGXBK1JJzlOBAeBWkwOULlXtw3NcD
	c3VtSieMQ5z7Wbip7qzAHWqJfQa9P34VDOBExJGPPkjcD+uu4U8ZfPCG0LHHjQ==
From: Paulo Alcantara <pc@manguebit.com>
To: Nicolas Baranger <nicolas.baranger@3xo.fr>,
 Christoph Hellwig <hch@infradead.org>
CC: hch@lst.de, David Howells <dhowells@redhat.com>, netfs@lists.linux.dev,
 linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Steve French <smfrench@gmail.com>,
 Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5Bnetfs/cifs_-_Linux_6=2E14=5D_loop_on_file_?=
 =?US-ASCII?Q?cat_+_file_copy_when_files_are_on_CIFS_share?=
In-Reply-To: <48685a06c2608b182df3b7a767520c1d@3xo.fr>
References: <10bec2430ed4df68bde10ed95295d093@3xo.fr> <35940e6c0ed86fd94468e175061faeac@3xo.fr> <Z-Z95ePf3KQZ2MnB@infradead.org> <48685a06c2608b182df3b7a767520c1d@3xo.fr>
Message-ID: <F89FD4A3-FE54-4DB2-BA08-3BCC8843C60E@manguebit.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

I'll look into it as soon as I recover from my illness=2E  Sorry for the d=
elay=2E

On 4 April 2025 08:50:27 UTC, Nicolas Baranger <nicolas=2Ebaranger@3xo=2Ef=
r> wrote:
>Hi Christoph
>
>Thanks for answer and help
>Did someone reproduced the issue (very easy) ?
>
>
>CIFS SHARE is mounted as /mnt/fbx/FBX-24T
>echo toto >/mnt/fbx/FBX-24T/toto
>
>ls -l /mnt/fbx/FBX-24T/toto
>-rw-rw-rw- 1 root root 5 20 mars  09:20 /mnt/fbx/FBX-24T/toto
>
>cat /mnt/fbx/FBX-24T/toto
>toto
>toto
>toto
>toto
>toto
>toto
>toto
>^C
>
>
>CIFS mount options:
>grep cifs /proc/mounts
>//10=2E0=2E10=2E100/FBX24T /mnt/fbx/FBX-24T cifs rw,nosuid,nodev,noexec,r=
elatime,vers=3D3=2E1=2E1,cache=3Dnone,upcall_target=3Dapp,username=3Dfbx,do=
main=3DHOMELAN,uid=3D0,noforceuid,gid=3D0,noforcegid,addr=3D10=2E0=2E10=2E1=
00,file_mode=3D0666,dir_mode=3D0755,iocharset=3Dutf8,soft,nounix,serverino,=
mapposix,mfsymlinks,reparse=3Dnfs,nativesocket,symlink=3Dmfsymlinks,rsize=
=3D65536,wsize=3D65536,bsize=3D16777216,retrans=3D1,echo_interval=3D60,acti=
meo=3D1,closetimeo=3D1 0 0
>
>KERNEL: uname -a
>Linux 14RV-SERVER=2E14rv=2Elan 6=2E14=2E0-rc2-amd64 #0 SMP PREEMPT_DYNAMI=
C Wed Feb 12 18:23:00 CET 2025 x86_64 GNU/Linux
>
>
>Kind regards
>Nicolas Baranger
>
>
>Le 2025-03-28 11:45, Christoph Hellwig a =C3=A9crit :
>
>> Hi Nicolas,
>>=20
>> please wait a bit, many file system developers where at a conference
>> this week=2E
>

