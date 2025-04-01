Return-Path: <linux-fsdevel+bounces-45478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9EBA783DC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 23:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0176F3A4AAA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 21:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E41920E32B;
	Tue,  1 Apr 2025 21:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Mfp0yoJ8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC589F4ED
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Apr 2025 21:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743542214; cv=none; b=P2YQdiVitUqdvnZKJnnjbFDRUk3ZtdyZ97TKwZ07Bkv7byDizfEG75bWHcWJcptkIdczEUc+b7v0sffEh9dMFv0SNUJtLheh46DSzjxq1nPWi8nzlBAcP+w2FuVze03J9LeKcTBnP9mLRu3+g3+MBOd9v8n/MqztOYX0Q6v6Ecg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743542214; c=relaxed/simple;
	bh=1IsjK6xYFf5FbhIKfeaonN1Cs+Y9Lz84wgDKyhglZt4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zi9d/oCHq2jTmh339PiuEI1gzxsJrfTvV+1d19TLTRokcu+/TsUjXH6yytB9SssWy8NjEtrx2hfUrBof34mpTAVj0uYA5djyNL1tABu9GY/s2AhTJjrRoyf0AymR7IBTKTz2ySRPdOXmXYjAGz1K3347FxLWDovcaysbKbaPFqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Mfp0yoJ8; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531KGek1000475
	for <linux-fsdevel@vger.kernel.org>; Tue, 1 Apr 2025 14:16:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=b8enlN2i7m4bEWJSz90/GHX9HF325SS2ayjUnvDzDao=; b=Mfp0yoJ8/bqp
	5yg+ZKXkqlTDJefMtSTWoGIztRysoJtU4XSZJMGvU7ji10QBl5cQFiUm8WRCuydN
	4KzhT+BPqbjH5t0wlwcKUvyhvaxsw59AzwRBid3vaRHjacgRaCq2IqQUbTXQQ7r7
	TD+Wrbj5Pgdmn/jezENc3MSjQiXpJ5H6N7EBF19STAoF4wM6/UlwPDun1cBk8w8M
	O1AyotHjcWZGbep8KuMeY6HhThMdUpSVwPAmUVXU3fk7tEsw5UU4ISAmywd6L9HX
	zpRLQXpJu7jj2wtWjxP/2yrRYeuv/B8useebo4l5zJNqHG1x6KRiFaKAyR4Otg8C
	HdJOCPOmtQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 45rhrr3f27-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 01 Apr 2025 14:16:51 -0700 (PDT)
Received: from twshared9216.15.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 1 Apr 2025 21:16:49 +0000
Received: by devvm18334.vll0.facebook.com (Postfix, from userid 202792)
	id 467D823EE9413; Tue,  1 Apr 2025 14:16:44 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <jack@suse.cz>
CC: <amir73il@gmail.com>, <ibrahimjirdeh@meta.com>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: Re: Reseting pending fanotify events
Date: Tue, 1 Apr 2025 14:16:09 -0700
Message-ID: <20250401211609.2433022-1-ibrahimjirdeh@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <6za2mngeqslmqjg3icoubz37hbbxi6bi44canfsg2aajgkialt@c3ujlrjzkppr>
References: <6za2mngeqslmqjg3icoubz37hbbxi6bi44canfsg2aajgkialt@c3ujlrjzkppr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: zV6Oh4oWj8IpVljEcljN5MZn_MjOXvt0
X-Proofpoint-ORIG-GUID: zV6Oh4oWj8IpVljEcljN5MZn_MjOXvt0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_09,2025-04-01_01,2024-11-22_01

Hopefully the formatting works well now. Also including some replies to
questions from earlier in the thread in case they were lost.

> But what confuses me is the following: You have fanotify instance to wh=
ich
> you've got fd from fanotify_init(). For any process to be hanging, this=
 fd
> must be still held open by some process. Otherwise the fanotify instanc=
e
> gets destroyed and all processes are free to run (they get FAN_ALLOW re=
ply
> if they were already waiting). So the fact that you see processes hangi=
ng
> when your fanotify listener crashes means that you have likely leaked t=
he
> fd to some other process (lsof should be able to tell you which process=
 has
> still handle to fanotify instance). And the kernel has no way to know t=
his
> is not the process that will eventually read these events and reply...

I can clarify this further. In our case its important to not destroy the =
fanotify
instance during daemon shutdown as giving FAN_ALLOW to waiting processes =
could
enable accessing a file which has not actually been populated. To this en=
d, we
persist the fd from fanotify_init accross daemon restarts. In particular =
since
the daemon is a systemd unit, we rely on the systemd fd store (https://sy=
stemd.io/FILE_DESCRIPTOR_STORE/)
for this, which essentially will maintain a dup of the fanotify fd. This =
is why
we can run into the case of hanging events during planned restart or unin=
tented
crash. Heres a sample trace of D-state process I had linked in earlier re=
ply:

[<0>] fanotify_handle_event+0x8ac/0x10f0
[<0>] fsnotify+0x5fb/0x8d0
[<0>] __fsnotify_parent+0x17f/0x260
[<0>] security_file_open+0x8f/0x130
[<0>] vfs_open+0x109/0x4c0
[<0>] path_openat+0x9a4/0x27d0
[<0>] do_filp_open+0x91/0x120
[<0>] bprm_execve+0x15c/0x690
[<0>] do_execveat_common+0x22c/0x330
[<0>] __x64_sys_execve+0x36/0x40
[<0>] do_syscall_64+0x3d/0x90
[<0>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

Confirmed it was killable per Jan's clarification.

> > > In this case, any events that have been read but not yet responded =
to would be lost.
> > > Initially we considered handling this internally by saving the file=
 descriptors for pending events,
> > > however this proved to be complex to do in a robust manner.
> > >
> > > A more robust solution is to add a kernel fanotify api which resets=
 the fanotify pending event queue,
> > > thereby allowing us to recover pending events in the case of daemon=
 restart.
> > > A strawman implementation of this approach is in
> > > https://github.com/torvalds/linux/compare/master...ibrahim-jirdeh:l=
inux:fanotify-reset-pending,
> > > a new ioctl that resets `group->fanotify_data.access_list`.
> > > One other alternative we considered is directly exposing the pendin=
g event queue itself
> > > (https://github.com/torvalds/linux/commit/cd90ff006fa2732d28ff6bb59=
75ca5351ce009f1)
> > > to support monitoring pending events, but simply resetting the queu=
e is likely sufficient for our use-case.
> > >
> > > What do you think of exposing this functionality in fanotify?
> > >
> >
> > Ignoring the pending events for start, how do you deal with access to
> > non-populated files while the daemon is down?
> >
> > We were throwing some idea about having a mount option (something
> > like a "moderate" mount) to determine the default response for specif=
ic
> > permission events (e.g. FAN_OPEN_PERM) in the case that there is
> > no listener watching this event.
> >
> > If you have a filesystem which may contain non-populated files, you
> > mount it with as "moderated" mount and then access to all files is
> > denied until the daemon is running and also denied if daemon is down.
> >
> > For restart, it might make sense to start a new daemon to start liste=
ning
> > to events before stopping the old daemon.
> > If the new daemon gets the events before the old daemon, things shoul=
d
> > be able to transition smoothly.
>
> I agree this would be a sensible protocol for updates. For unplanned cr=
ashes
> I agree we need something like the "moderated" mount option.

We can definitely try out the suggested approach of starting up new daemo=
n
instance  alongside old one to prevent downtime during planned restart.

