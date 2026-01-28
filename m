Return-Path: <linux-fsdevel+bounces-75800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCIqLRlwemlI6QEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 21:22:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50062A8737
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 21:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95996302E91C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 20:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C541329C77;
	Wed, 28 Jan 2026 20:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKvAKP/p";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wz/4ytum"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B5A328B40
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 20:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769631761; cv=none; b=mRPoGGIaenzxv4mOMDI/9CaMXcTdSL8LLqOZWuxvePRRa97azN354bpbcgDcKwZpKBIrrZa3TL58XfnIDV+76TxETcHrhxYSe1W7usY0Jf2PeCquypfF+CdKSP3PrzryVY9xn4csnJhBT3o3q4yIEt4xHJZIMcUwHiezpL0LOqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769631761; c=relaxed/simple;
	bh=4C7ipU2WM0zEzxW3FXI5JTqegwZnetPl9fNMb+DjeMY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ifXQhOynY4nOy/V8fDqEN4RkbMdEh2iWAEb1Rt5rldSozeZUvWGTGo5ggdLT8jlDfVDJfP1Eu3rlzYVpDBrGBNm732CfQh/U5mZN5eFH3XSqPzV2jngN/WiWtanR0BpJeCsKj1kkpk4+FdS5nvjF80UEKSMylv08kPTABduyhx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GKvAKP/p; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wz/4ytum; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769631758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=onFKMzXoVenVyGhf6RXsTyH6GOGmC7fNOuqOGCT4im0=;
	b=GKvAKP/pCRI7oqE4ShT8XP+8+iM/Xr7KIoaHyeA6W1o8ZVpFF9jrlQb9629f0qkeLfY0tU
	Kb2FsGi6mg6n+8YVovq3i2KHvifP33oH0BvkUfwKMf112Amk87ueUUetlCZaSYI/EOd8Rc
	VJPhpXijE78BOx2rFbmelVaZQTK0o1U=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-IhGNA7IxP-qMns3OgryFUA-1; Wed, 28 Jan 2026 15:22:36 -0500
X-MC-Unique: IhGNA7IxP-qMns3OgryFUA-1
X-Mimecast-MFC-AGG-ID: IhGNA7IxP-qMns3OgryFUA_1769631756
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-794747bef4cso4130697b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 12:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769631756; x=1770236556; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=onFKMzXoVenVyGhf6RXsTyH6GOGmC7fNOuqOGCT4im0=;
        b=Wz/4ytumN0xFQB8qiA87ntDtrPfjYGsv8DeT/rKlU2hd34h+vV6acQ2IpPS2N1I8MR
         d/6T7uuNDsh7RcbYJn1+ObcCx3zJxmrpuRFNXm+lcbQEFdincXmBkiTOks2Xxcw/CmwD
         qBWq388FpadPUdFR1LZH/X9zCjg0C+l1Sd9BFf+e81ZXJa/XeUS8vMqeT+Tq3d/kiGRD
         IZIfOHtSg5SOvURWZyRO4t/iKuEOvQVUOKE1xYLbniiTMolPeusLUuNgxGw+IFUJj7Co
         bE3UAmHd26Nd1qvVASi/eOfuhwBiFWQ18Ws00iCuVrxgVd42h4aP4BflrxmzDZCU4X4Y
         fVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769631756; x=1770236556;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=onFKMzXoVenVyGhf6RXsTyH6GOGmC7fNOuqOGCT4im0=;
        b=CJrkNhjpj7RFH5mnGjSk7C3GlS6PD2A6tnUvPK4BDB+9jrX7lfRfxCDctsRpKVXvT5
         uH6hSyIToijtbn2h1qwlqveBPlvtUQwNymbb3mFJGfaNw+UUQ9oP7KokS0q4UdfwugAB
         bg36a0HTLqB43bXfN5cY9H6G5hj/vemGDHYkRK5eZQI+7JWaPDPewftM1Ebh47TVLXPR
         O4uN3zt6JxAKvBosuZ2Jwb4sMsTpEVrFYbFawtUUa4rN8ZywHcZkMtxwsyZqjAuRnE9o
         EAsmfs3ZHobrW0IlHxFC0kteJtzKXkzSNg+H8AoV2k62ldscghM0Z2QUxn1KtFrWXC+6
         MdVA==
X-Forwarded-Encrypted: i=1; AJvYcCVJbVyOv//+AX6eHAgrZLkdNWLSYQEreEdcPXhd2+08WSq4dR5HjTvj+cGxO0Fz2NubYNCBUPGOomDjgCks@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Ffx86SGzFEjJz1E1IPhByMco89XOom1lK2URf3aZTGxu6dp6
	42h4gUF5nXBt4yJoCS/fUQIZ9ifT76XPh8ebY6hGQ2sBpnvRMDs2itY9UvRw7D5W8HyCXcmjxBi
	k8EnI4v6C4yyOBeOCT+HFmc7SYTvKr4uy0La0V7dxSnZP7ZDRsFwZDuL4fHUuDgr9U2k=
X-Gm-Gg: AZuq6aJO5mzFnobUC10Picyp73mnHDAbE8YLXc8E7zC+emX0EdDcJQBuV6/6o5NiGY3
	j1wg1oVO3PI60MMjjvbhRPsxsTh5aQDTVWHoG9d0gUASTMTGIxrUw5mx8R1EEI9fN9Z7zbj/BrC
	Mc9C1qUH1P5SWt784bQBVdAuGj4KcHkCpW50fFl20CUECAGvV+WbRd1lz4Sibq/7TUkCPbUva0d
	LCAQa4rmjV1Ez39cJBOmvEEv0bYVINT+qeRQX65hEeKeaa4Cjd9LOVDTDKxO8zujobBFhjYnGgW
	SPnzX/iT3tYBFXIBq6F5FD00Emjr+Q9V5KZvG9Sza37Vux80dvV0urZpuDVls/xuJ+KJyc4Fpg6
	8fbvd3JedFyWs/j+GTbljYDOJLMsIuTCu9ndaOL8R
X-Received: by 2002:a05:690c:6287:b0:78d:6dac:e903 with SMTP id 00721157ae682-7947ac5c625mr51963437b3.60.1769631756223;
        Wed, 28 Jan 2026 12:22:36 -0800 (PST)
X-Received: by 2002:a05:690c:6287:b0:78d:6dac:e903 with SMTP id 00721157ae682-7947ac5c625mr51963177b3.60.1769631755762;
        Wed, 28 Jan 2026 12:22:35 -0800 (PST)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::41])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794828a9e55sm15447717b3.30.2026.01.28.12.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 12:22:35 -0800 (PST)
Message-ID: <764e96d344ad558ff0b8620b29a427641d52d85b.camel@redhat.com>
Subject: Re: [EXTERNAL] Re: [PATCH v5] ceph: fix kernel crash in ceph_open()
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	pdonnell@redhat.com, linux-fsdevel@vger.kernel.org, amarkuze@redhat.com, 
	khiremat@redhat.com, Pavan.Rallabhandi@ibm.com
Date: Wed, 28 Jan 2026 12:22:25 -0800
In-Reply-To: <CAOi1vP-CAYAKykctYWAQNab7tU93nQQwnobBn3pJw+ZqUJCh7A@mail.gmail.com>
References: <20260114195524.1025067-2-slava@dubeyko.com>
	 <CAOi1vP8CwX5T_R4gdZ0egg2oxCwFGAvoi6Us2k4=QFKmtqHmjQ@mail.gmail.com>
	 <3e4c420c7dd63ac3ecd0c9c21aea4f75784eada4.camel@redhat.com>
	 <CAOi1vP-CAYAKykctYWAQNab7tU93nQQwnobBn3pJw+ZqUJCh7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-75800-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdubeyko@redhat.com,linux-fsdevel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[proofpoint.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 50062A8737
X-Rspamd-Action: no action

On Wed, 2026-01-28 at 19:37 +0100, Ilya Dryomov wrote:
> On Mon, Jan 26, 2026 at 9:18=E2=80=AFPM Viacheslav Dubeyko <vdubeyko@redh=
at.com> wrote:
> >=20
> > On Mon, 2026-01-26 at 13:35 +0100, Ilya Dryomov wrote:
> > > On Wed, Jan 14, 2026 at 8:56=E2=80=AFPM Viacheslav Dubeyko <slava@dub=
eyko.com> wrote:
> > > >=20
> > > > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > >=20
> > > > The CephFS kernel client has regression starting from 6.18-rc1.
> > > >=20
> > > > sudo ./check -g quick
> > > > FSTYP         -- ceph
> > > > PLATFORM      -- Linux/x86_64 ceph-0005 6.18.0-rc5+ #52 SMP PREEMPT=
_DYNAMIC Fri
> > > > Nov 14 11:26:14 PST 2025
> > > > MKFS_OPTIONS  -- 192.168.1.213:3300:/scratch
> > > > MOUNT_OPTIONS -- -o name=3Dadmin,ms_mode=3Dsecure 192.168.1.213:330=
0:/scratch
> > > > /mnt/cephfs/scratch
> > > >=20
> > > > Killed
> > > >=20
> > > > Nov 14 11:48:10 ceph-0005 kernel: [  154.723902] libceph: mon0
> > > > (2)192.168.1.213:3300 session established
> > > > Nov 14 11:48:10 ceph-0005 kernel: [  154.727225] libceph: client167=
616
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.087260] BUG: kernel NULL p=
ointer
> > > > dereference, address: 0000000000000000
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.087756] #PF: supervisor re=
ad access in
> > > > kernel mode
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.088043] #PF: error_code(0x=
0000) - not-
> > > > present page
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.088302] PGD 0 P4D 0
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.088688] Oops: Oops: 0000 [=
#1] SMP KASAN
> > > > NOPTI
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.090080] CPU: 4 UID: 0 PID:=
 3453 Comm:
> > > > xfs_io Not tainted 6.18.0-rc5+ #52 PREEMPT(voluntary)
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.091245] Hardware name: QEM=
U Standard PC
> > > > (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.092103] RIP: 0010:strcmp+0=
x1c/0x40
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.092493] Code: 90 90 90 90 =
90 90 90 90
> > > > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 4=
8 83 c0 01 84
> > > > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31=
 ff c3 cc cc
> > > > cc cc 31
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.094057] RSP: 0018:ffff8881=
536875c0
> > > > EFLAGS: 00010246
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.094522] RAX: 0000000000000=
000 RBX:
> > > > ffff888116003200 RCX: 0000000000000000
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.095114] RDX: 0000000000000=
063 RSI:
> > > > 0000000000000000 RDI: ffff88810126c900
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.095714] RBP: ffff888153687=
6a8 R08:
> > > > 0000000000000000 R09: 0000000000000000
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.096297] R10: 0000000000000=
000 R11:
> > > > 0000000000000000 R12: dffffc0000000000
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.096889] R13: ffff8881061d0=
000 R14:
> > > > 0000000000000000 R15: 0000000000000000
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.097490] FS:  000074a85c082=
840(0000)
> > > > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.098146] CS:  0010 DS: 0000=
 ES: 0000
> > > > CR0: 0000000080050033
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.098630] CR2: 0000000000000=
000 CR3:
> > > > 0000000110ebd001 CR4: 0000000000772ef0
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099219] PKRU: 55555554
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099476] Call Trace:
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099686]  <TASK>
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099873]  ?
> > > > ceph_mds_check_access+0x348/0x1760
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.100267]  ?
> > > > __kasan_check_write+0x14/0x30
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.100671]  ? lockref_get+0xb=
1/0x170
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.100979]  ?
> > > > __pfx__raw_spin_lock+0x10/0x10
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.101372]  ceph_open+0x322/0=
xef0
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.101669]  ? __pfx_ceph_open=
+0x10/0x10
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.101996]  ?
> > > > __pfx_apparmor_file_open+0x10/0x10
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.102434]  ?
> > > > __ceph_caps_issued_mask_metric+0xd6/0x180
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.102911]  do_dentry_open+0x=
7bf/0x10e0
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103249]  ? __pfx_ceph_open=
+0x10/0x10
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103508]  vfs_open+0x6d/0x4=
50
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103697]  ? may_open+0xec/0=
x370
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103893]  path_openat+0x201=
7/0x50a0
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104110]  ? __pfx_path_open=
at+0x10/0x10
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104345]  ?
> > > > __pfx_stack_trace_save+0x10/0x10
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104599]  ?
> > > > stack_depot_save_flags+0x28/0x8f0
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104865]  ? stack_depot_sav=
e+0xe/0x20
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105063]  do_filp_open+0x1b=
4/0x450
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105253]  ?
> > > > __pfx__raw_spin_lock_irqsave+0x10/0x10
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105538]  ? __pfx_do_filp_o=
pen+0x10/0x10
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105748]  ? __link_object+0=
x13d/0x2b0
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105949]  ?
> > > > __pfx__raw_spin_lock+0x10/0x10
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106169]  ?
> > > > __check_object_size+0x453/0x600
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106428]  ? _raw_spin_unloc=
k+0xe/0x40
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106635]  do_sys_openat2+0x=
e6/0x180
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106827]  ?
> > > > __pfx_do_sys_openat2+0x10/0x10
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107052]  __x64_sys_openat+=
0x108/0x240
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107258]  ?
> > > > __pfx___x64_sys_openat+0x10/0x10
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107529]  ?
> > > > __pfx___handle_mm_fault+0x10/0x10
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107783]  x64_sys_call+0x13=
4f/0x2350
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108007]  do_syscall_64+0x8=
2/0xd50
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108201]  ?
> > > > fpregs_assert_state_consistent+0x5c/0x100
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108467]  ? do_syscall_64+0=
xba/0xd50
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108626]  ? __kasan_check_r=
ead+0x11/0x20
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108801]  ?
> > > > count_memcg_events+0x25b/0x400
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109013]  ? handle_mm_fault=
+0x38b/0x6a0
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109216]  ? __kasan_check_r=
ead+0x11/0x20
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109457]  ?
> > > > fpregs_assert_state_consistent+0x5c/0x100
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109724]  ?
> > > > irqentry_exit_to_user_mode+0x2e/0x2a0
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109991]  ? irqentry_exit+0=
x43/0x50
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110180]  ? exc_page_fault+=
0x95/0x100
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110389]
> > > > entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110638] RIP: 0033:0x74a85b=
f145ab
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110821] Code: 25 00 00 41 =
00 3d 00 00
> > > > 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee b=
f 9c ff ff ff
> > > > b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 54=
 24 28 64 48
> > > > 2b 14 25
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.111724] RSP: 002b:00007ffc=
77d316d0
> > > > EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.112080] RAX: fffffffffffff=
fda RBX:
> > > > 0000000000000002 RCX: 000074a85bf145ab
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.112442] RDX: 0000000000000=
000 RSI:
> > > > 00007ffc77d32789 RDI: 00000000ffffff9c
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.112790] RBP: 00007ffc77d32=
789 R08:
> > > > 00007ffc77d31980 R09: 0000000000000000
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113125] R10: 0000000000000=
000 R11:
> > > > 0000000000000246 R12: 0000000000000000
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113502] R13: 00000000fffff=
fff R14:
> > > > 0000000000000180 R15: 0000000000000001
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113838]  </TASK>
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113957] Modules linked in:
> > > > intel_rapl_msr intel_rapl_common intel_uncore_frequency_common inte=
l_pmc_core
> > > > pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry int=
el_vsec
> > > > kvm_intel kvm joydev irqbypass polyval_clmulni ghash_clmulni_intel =
aesni_intel
> > > > rapl floppy input_leds psmouse i2c_piix4 vga16fb mac_hid i2c_smbus =
vgastate
> > > > serio_raw bochs qemu_fw_cfg pata_acpi sch_fq_codel rbd msr parport_=
pc ppdev lp
> > > > parport efi_pstore
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.116339] CR2: 0000000000000=
000
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.116574] ---[ end trace 000=
0000000000000
> > > > ]---
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.116826] RIP: 0010:strcmp+0=
x1c/0x40
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.117058] Code: 90 90 90 90 =
90 90 90 90
> > > > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 4=
8 83 c0 01 84
> > > > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31=
 ff c3 cc cc
> > > > cc cc 31
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.118070] RSP: 0018:ffff8881=
536875c0
> > > > EFLAGS: 00010246
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.118362] RAX: 0000000000000=
000 RBX:
> > > > ffff888116003200 RCX: 0000000000000000
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.118748] RDX: 0000000000000=
063 RSI:
> > > > 0000000000000000 RDI: ffff88810126c900
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.119116] RBP: ffff888153687=
6a8 R08:
> > > > 0000000000000000 R09: 0000000000000000
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.119492] R10: 0000000000000=
000 R11:
> > > > 0000000000000000 R12: dffffc0000000000
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.119865] R13: ffff8881061d0=
000 R14:
> > > > 0000000000000000 R15: 0000000000000000
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.120242] FS:  000074a85c082=
840(0000)
> > > > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.120704] CS:  0010 DS: 0000=
 ES: 0000
> > > > CR0: 0000000080050033
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.121008] CR2: 0000000000000=
000 CR3:
> > > > 0000000110ebd001 CR4: 0000000000772ef0
> > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.121409] PKRU: 55555554
> > > >=20
> > > > We have issue here [1] if fs_name =3D=3D NULL:
> > > >=20
> > > > const char fs_name =3D mdsc->fsc->mount_options->mds_namespace;
> > > >     ...
> > > >     if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name)=
) {
> > > >             / fsname mismatch, try next one */
> > > >             return 0;
> > > >     }
> > > >=20
> > > > v2
> > > > Patrick Donnelly suggested that: In summary, we should definitely s=
tart
> > > > decoding `fs_name` from the MDSMap and do strict authorizations che=
cks
> > > > against it. Note that the `--mds_namespace` should only be used for
> > > > selecting the file system to mount and nothing else. It's possible
> > > > no mds_namespace is specified but the kernel will mount the only
> > > > file system that exists which may have name "foo".
> > > >=20
> > > > v3
> > > > The namespace_equals() logic has been generalized into
> > > > __namespace_equals() with the goal of using it in
> > > > ceph_mdsc_handle_fsmap() and ceph_mds_auth_match().
> > > > The misspelling of CEPH_NAMESPACE_WILDCARD has been corrected.
> > > >=20
> > > > v4
> > > > The __namespace_equals() now supports wildcard check.
> > > >=20
> > > > v5
> > > > Patrick Donnelly suggested to add the sanity check of
> > > > kstrdup() returned pointer in ceph_mdsmap_decode()
> > > > added logic. Also, he suggested much simpler logic of
> > > > namespace strings comparison in the form of
> > > > ceph_namespace_match() logic.
> > > >=20
> > > > This patch reworks ceph_mdsmap_decode() and namespace_equals() with
> > > > the goal of supporting the suggested concept. Now struct ceph_mdsma=
p
> > > > contains m_fs_name field that receives copy of extracted FS name
> > > > by ceph_extract_encoded_string(). For the case of "old" CephFS file=
 systems,
> > > > it is used "cephfs" name. Also, namespace_equals() method has been
> > > > reworked with the goal of proper names comparison.
> > > >=20
> > > > [1] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__elixir.b=
ootlin.com_linux_v6.18-2Drc4_source_fs_ceph_mds-5Fclient.c-23L5666&d=3DDwIF=
aQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3Dq5bIm4AXMzc8NJu1_RGmnQ2fMWKq4Y4RAkElvUgSs=
00&m=3D-RKqmT80mqztmazmh-jahx70DEvPkJZRpkLlPXPBvbDdutZZKxyg6BDU5Z04AOF7&s=
=3D7Jho3hQD0UqfS2Qa34AM3oVIaSClnuiNCvRbAhnkih0&e=3D=20
> > > > [2] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__tracker.=
ceph.com_issues_73886&d=3DDwIFaQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3Dq5bIm4AXMzc=
8NJu1_RGmnQ2fMWKq4Y4RAkElvUgSs00&m=3D-RKqmT80mqztmazmh-jahx70DEvPkJZRpkLlPX=
PBvbDdutZZKxyg6BDU5Z04AOF7&s=3DVz1-hQxF-IhOzkTFifY5fBmuLpwaV06jQm-1RjsYvLU&=
e=3D=20
> > > >=20
> > > > Fixes: 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue")
> > > > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > > cc: Kotresh Hiremath Ravishankar <khiremat@redhat.com>
> > > > cc: Alex Markuze <amarkuze@redhat.com>
> > > > cc: Ilya Dryomov <idryomov@gmail.com>
> > > > cc: Patrick Donnelly <pdonnell@redhat.com>
> > > > cc: Ceph Development <ceph-devel@vger.kernel.org>
> > > > ---
> > > >  fs/ceph/mds_client.c         | 11 +++++------
> > > >  fs/ceph/mdsmap.c             | 24 ++++++++++++++++++------
> > > >  fs/ceph/mdsmap.h             |  1 +
> > > >  fs/ceph/super.h              | 24 +++++++++++++++++++-----
> > > >  include/linux/ceph/ceph_fs.h |  6 ++++++
> > > >  5 files changed, 49 insertions(+), 17 deletions(-)
> > > >=20
> > > > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > > > index 7e4eab824dae..703c14bc3c95 100644
> > > > --- a/fs/ceph/mds_client.c
> > > > +++ b/fs/ceph/mds_client.c
> > > > @@ -5671,7 +5671,7 @@ static int ceph_mds_auth_match(struct ceph_md=
s_client *mdsc,
> > > >         u32 caller_uid =3D from_kuid(&init_user_ns, cred->fsuid);
> > > >         u32 caller_gid =3D from_kgid(&init_user_ns, cred->fsgid);
> > > >         struct ceph_client *cl =3D mdsc->fsc->client;
> > > > -       const char *fs_name =3D mdsc->fsc->mount_options->mds_names=
pace;
> > > > +       const char *fs_name =3D mdsc->mdsmap->m_fs_name;
> > > >         const char *spath =3D mdsc->fsc->mount_options->server_path=
;
> > > >         bool gid_matched =3D false;
> > > >         u32 gid, tlen, len;
> > > > @@ -5679,7 +5679,8 @@ static int ceph_mds_auth_match(struct ceph_md=
s_client *mdsc,
> > > >=20
> > > >         doutc(cl, "fsname check fs_name=3D%s  match.fs_name=3D%s\n"=
,
> > > >               fs_name, auth->match.fs_name ? auth->match.fs_name : =
"");
> > > > -       if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_n=
ame)) {
> > > > +
> > > > +       if (!ceph_namespace_match(auth->match.fs_name, fs_name, NAM=
E_MAX)) {
> > >=20
> > > Hi Slava,
> > >=20
> > > How was this tested?  In particular, do you have a test case covering
> > > an MDS auth cap that specifies a particular fs_name (i.e. one where
> > > auth->match.fs_name wouldn't be NULL or CEPH_NAMESPACE_WILDCARD)?
> > >=20
> > > I'm asking because it looks like ceph_namespace_match() would always
> > > declare a mismatch in that scenario due to the fact that NAME_MAX is
> > > passed for target_len and
> > >=20
> > >     if (strlen(pattern) !=3D target_len)
> > >             return false;
> > >=20
> > > condition inside of ceph_namespace_match().  This in turn means that
> > > ceph_mds_check_access() would disregard the respective cap and might
> > > allow access where it's supposed to be denied.
> > >=20
> > >=20
> >=20
> > I have run the xfstests (quick group) with the patch applied. I didn't =
see any
> > unusual behavior. If we believe that these tests are not enough, then, =
maybe, we
> > need to introduce the additional Ceph specialized tests.
>=20
> I'd expect that the manual steps quoted in commit 22c73d52a6d0 ("ceph:
> fix multifs mds auth caps issue") as well the automated tests added in
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_ceph_ce=
ph_pull_64550&d=3DDwIFaQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3Dq5bIm4AXMzc8NJu1_RG=
mnQ2fMWKq4Y4RAkElvUgSs00&m=3D-RKqmT80mqztmazmh-jahx70DEvPkJZRpkLlPXPBvbDdut=
ZZKxyg6BDU5Z04AOF7&s=3DflpYs6_1sBk-MBf0SCwdyOABcYR-h7pBadLy1SLyaho&e=3D  wo=
uld be run, at the very least.
>=20
> On top of that I'd recommend devising some ad-hoc test cases for
> CEPH_NAMESPACE_WILDCARD and mds_namespace mount option handling as that
> has been a recurrent source of problems throughout all postings.
>=20
> "./check -g quick" barely scratches the surface on any of this...
>=20
>=20

So, it sounds that we have not enough Ceph dedicated test-cases in xfstests=
.

Thanks,
Slava.


