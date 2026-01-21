Return-Path: <linux-fsdevel+bounces-74845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLziNuG+cGkRZgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 12:56:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 61122565A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 12:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05C2474CAE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 11:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8683D332A;
	Wed, 21 Jan 2026 11:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFbHrbR0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQe7gfUh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384CD37A49B
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 11:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768995862; cv=pass; b=t64gySUhmNzW2JAX9qFTKKTulQRArNruJv+S7Vdxkd+ApvksNpw95ZbQb0C9YeBG+HS4fHkiEXKryFWcOmU02oDHGW78v3dLr3eX+LtTGdzOurKg32UvLXu2sKIgBxVl3p8olnc5RuZQsotakN9tt81LCCsgS3z51daNXiQdEWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768995862; c=relaxed/simple;
	bh=hhGbc+OIWEfPbONatLXmqY6q7JwxqIGzS3znH81pCp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=psv8lYYJyt/COHRExhf0zg0YFGq1p+07z5gQQG+ju7oV6rFPb51R0Kz6XnxHwTxMWhP6FmMErvHQzZrWT4mePXUbAV3ROucQpVu8yXwv1AkZR+DhStk4iy6981JdeiR3q7IDQ4SgvlOyU4OqiTwJdJUMjPXC6tbrAl7eVDwWZDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HFbHrbR0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EQe7gfUh; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768995859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oZsWBF3suT4vQaUZt0zT5ll7sVtHhnyQaXi5InAKqFM=;
	b=HFbHrbR0Rjb//1CA80guc/T0BkDwZ6HOTcUi1A7dGm7BYwdvFVdYcTkqKkv/uU+rxT56tU
	2JnRTYhKOLuaXHSwp2BUfX3NWYZVdBwdp0lQZ48drnQg4ZmNkRjngo1OYiYSADQHkGkGMU
	AcPPk3DZOXbDvrEeekpEl7WttymtQFY=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-ZPJs_iKZOkuBFb7q9ds32g-1; Wed, 21 Jan 2026 06:44:17 -0500
X-MC-Unique: ZPJs_iKZOkuBFb7q9ds32g-1
X-Mimecast-MFC-AGG-ID: ZPJs_iKZOkuBFb7q9ds32g_1768995856
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5ec87b2b4ddso5890942137.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 03:44:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768995856; cv=none;
        d=google.com; s=arc-20240605;
        b=SSDQZVLoawCA4jtQmfFvJqZLj87L7A9OtHfrFq/DG7N3CRpORuJwXjzXvXB0vx1L05
         oZLGqch+XbNzfW+bBRL5iRdPdI9eR7GMfz6l4vIVbWCcwBRewK7RpsEl0C2ji4se0iIY
         b0NJN4XgEIRLzIxk7IAJ1hK5YH4+UjW+9WtmSqf0yxVtnMRZ3JYekOM7WPbct9NfrF/S
         PP5lj5fmquiUTqeO6gyhwxiECfJ9j1Xtfr5vNL8tSEp8UBdxtUIUjfW7GFBkunkQP8oA
         Zl1oNa4bVdBhvQ+QpcR4B27YdKbE6HUcPQ6+hVlTUiMfRu40qakIbrTDGOrkvBTmL6G0
         /P2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oZsWBF3suT4vQaUZt0zT5ll7sVtHhnyQaXi5InAKqFM=;
        fh=pC3I5LOro3KXGJq9CKfYjPLtIMkhfi8s3ah75Xz/DyE=;
        b=D081e0E6ZiFDwO2+GrHmK3ufC24ehs2GdKPUHSTrtEoOG+Rviz8hmJ4vEWVsAxjk7j
         1318sXeYEGDVClad8aGCaTZK8Cy9sMI7CV4Uwhq820IQ6LMpRR6XQZhCMVJbaEW2T8Kc
         feQi3rw+aYW0rr5uSV4R7jcc9MKwMN3NWCJhWHRVEv2RrHsdLaVrp1b75SEws5GcgQ79
         1QH7jZ1MDUbXUSIXxlZAwblKITmJchDIZkmHtzH7lVOTbMkEADqp5G3gif+dhYHD8ZsA
         nK9bcGHKM4rqOtTeQx6oj80p+4LGl91jMgqMZlD2mTzqqn6DzYlzoXaYO9Wx2byoJ296
         lNnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768995856; x=1769600656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZsWBF3suT4vQaUZt0zT5ll7sVtHhnyQaXi5InAKqFM=;
        b=EQe7gfUhcymFIxtGDX1ePOhwa9LrhP61qq1i4pWFD7f1zzZ36Hhzbwt6bD8qAOL1ho
         vKMrVP1cXLvAKEZuIt0/FqKiyY1dM7thzK+KkviMPv4hXG92FOUy7LQRiEEgPDyJpf5j
         VEZ0HI1hbwfsYP5nQ4P1yXcucLpgJpdaS6/qw4NpH0A6wMMF1WoGVXUWKOuzvV5Ml8mY
         TLkzBBGvqFEIhoZ9T1FRoK/aJkOUnHd3ru6+cMyGm3Wl4A0yjSPvMQ9U7KXqr54iqQ55
         JCWCoq3Ia4RzeBQqvP9/jGS781LpL285ZKmy3dJMVVe9B3mdlDfWOEX9e8y5kUgqvi6p
         SHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768995856; x=1769600656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oZsWBF3suT4vQaUZt0zT5ll7sVtHhnyQaXi5InAKqFM=;
        b=EUulHj6vh+wuV4y6blcr3SM/tfw/+qtyzqU9LSk5Qoy2XvimU/8MQ+/sJd28kd8hd2
         ILB/HibmY40dxQhty1tPvPuqVlMw7zQRHcNJ30C4ifN3URepMrUCePZAyikkhrjZtZmq
         hiD+T71hjOLlX5ZL9yG2Ilc8eZ3jv0NvKq6X4nZkomMfhiAoN6OFOeMyNTesjklCwXBe
         R5OjCDYSprP/2YIaPegStpAjatpiSdt822wmYyWxkj1ox2PFGuy7rXWa8XB+uuZ/NYHs
         gBBp0YW1Ez3TB3RPClDGfPwW1n4a4VAvC+sVSGRvD94E4GKU1LCHET4i+y4lcZwhurDD
         SGuw==
X-Forwarded-Encrypted: i=1; AJvYcCURRmRhyOMlo59BwzCEV7Fr0O0SvvnbU5yVywi6hv92kj9uIMa6VfCAeVwQerz8q0pyo4WuggmBlSMk8H72@vger.kernel.org
X-Gm-Message-State: AOJu0YwkfJ0JGxRznzOEJ5/AL+TmP6oK8nor8EjrRpilnsRMKl8FofwC
	VL1yYWc6Q4zowf0DS4Pac14pqilA6/VMBYGiTnkDpBhjXs/0ZaPmi7ulyvK1w4TUA+tKzSM7mUk
	E4u49jHg0sQpibFyRQpzJRa5gWTarnvhgDXpuiuGYSlOOu7iEA0MTgjbHwc7+RxAanKGjg0SGb4
	JWIUIZab83vShd/uprfuaFZBCIOg0q/huoTTl7+AX3frDSS0iNAHvL
X-Gm-Gg: AZuq6aLC3gfQx99AwgyjDEZ0fyfRD3pxK4EHNgTBIWK6v9FA0U4p5gH6Cd39yCK9cW9
	59lKUNd+fenpbN7wYg7LLbQq02WK4AaH0FAYv2hbXGrTGqu/471vVesFvqvKtN8lLmeJSy/OI7d
	RWeFGivbKb1sx3S+73VthyhkpMXMbrXUPgM/upzsuDVtAEbFhNS5Liyd8O0xEjK4d5DUYZfrvgx
	XQ7jUteFlavp257WyUrzMCj
X-Received: by 2002:a05:6102:f10:b0:5ee:a309:6684 with SMTP id ada2fe7eead31-5f1a4dc26femr4866858137.10.1768995856291;
        Wed, 21 Jan 2026 03:44:16 -0800 (PST)
X-Received: by 2002:a05:6102:f10:b0:5ee:a309:6684 with SMTP id
 ada2fe7eead31-5f1a4dc26femr4866853137.10.1768995855823; Wed, 21 Jan 2026
 03:44:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118182446.3514417-1-amarkuze@redhat.com> <721bc15d532ea4dd03e079bd516f332208fa48c2.camel@redhat.com>
 <8dce90cb96a33a123e5baa1613fde06658523495.camel@redhat.com>
In-Reply-To: <8dce90cb96a33a123e5baa1613fde06658523495.camel@redhat.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 21 Jan 2026 13:44:04 +0200
X-Gm-Features: AZwV_QjaXNZnvDFd1zoJ-6DaOBDmAwtKnhuBVtW5WB_ZlS3FgKD5dJuAgdRFWVw
Message-ID: <CAO8a2Si0hRbY0=w7sbBGn212hg4CD5=CxNsKjmr8jwEgTUmziQ@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH v5 0/2] ceph: add subvolume metrics
 reporting support
To: Viacheslav Dubeyko <vdubeyko@redhat.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74845-lists,linux-fsdevel=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amarkuze@redhat.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 61122565A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Local tree seems to have lagged behind, I'll rebase and send an updated ver=
sion

On Wed, Jan 21, 2026 at 2:30=E2=80=AFAM Viacheslav Dubeyko <vdubeyko@redhat=
.com> wrote:
>
> On Tue, 2026-01-20 at 16:18 -0800, Viacheslav Dubeyko wrote:
> > On Sun, 2026-01-18 at 18:24 +0000, Alex Markuze wrote:
> > > This patch series adds support for per-subvolume I/O metrics collecti=
on
> > > and reporting to the MDS. This enables administrators to monitor I/O
> > > patterns at the subvolume granularity, which is useful for multi-tena=
nt
> > > CephFS deployments where different subvolumes may be allocated to
> > > different users or applications.
> > >
> > > The implementation requires protocol changes to receive the subvolume=
_id
> > > from the MDS (InodeStat v9), and introduces a new metrics type
> > > (CLIENT_METRIC_TYPE_SUBVOLUME_METRICS) for reporting aggregated I/O
> > > statistics back to the MDS.
> > >
> > > Note: The InodeStat v8 handling patch (forward-compatible handling fo=
r
> > > the versioned optmetadata field) is now in the base tree, so this ser=
ies
> > > starts with v9 parsing.
> > >
> > > Patch 1 adds support for parsing the subvolume_id field from InodeSta=
t
> > > v9 and storing it in the inode structure for later use. This patch al=
so
> > > introduces CEPH_SUBVOLUME_ID_NONE constant (value 0) for unknown/unse=
t
> > > state and enforces subvolume_id immutability with WARN_ON_ONCE if
> > > attempting to change an already-set subvolume_id.
> > >
> > > Patch 2 adds the complete subvolume metrics infrastructure:
> > > - CEPHFS_FEATURE_SUBVOLUME_METRICS feature flag for MDS negotiation
> > > - Red-black tree based metrics tracker for efficient per-subvolume
> > >   aggregation with kmem_cache for entry allocations
> > > - Wire format encoding matching the MDS C++ AggregatedIOMetrics struc=
t
> > > - Integration with the existing CLIENT_METRICS message
> > > - Recording of I/O operations from file read/write and writeback path=
s
> > > - Debugfs interfaces for monitoring
> > >
> > > Metrics tracked per subvolume include:
> > > - Read/write operation counts
> > > - Read/write byte counts
> > > - Read/write latency sums (for average calculation)
> > >
> > > The metrics are periodically sent to the MDS as part of the existing
> > > metrics reporting infrastructure when the MDS advertises support for
> > > the SUBVOLUME_METRICS feature.
> > >
> > > Debugfs additions in Patch 2:
> > > - metrics/subvolumes: displays last sent and pending subvolume metric=
s
> > > - metrics/metric_features: displays MDS session feature negotiation
> > >   status, showing which metric-related features are enabled (includin=
g
> > >   METRIC_COLLECT and SUBVOLUME_METRICS)
> > >
> > > Changes since v4:
> > > - Merged CEPH_SUBVOLUME_ID_NONE and WARN_ON_ONCE immutability check
> > >   into patch 1 (previously split across patches 2 and 3)
> > > - Removed unused 'cl' variable from parse_reply_info_in() that would
> > >   cause compiler warning
> > > - Added read I/O recording in finish_netfs_read() for netfs read path
> > > - Simplified subvolume_metrics_dump() to use direct rb-tree iteration
> > >   instead of intermediate snapshot allocation
> > > - InodeStat v8 patch now in base tree, reducing series from 3 to 2
> > >   patches
> > >
> > > Changes since v3:
> > > - merged CEPH_SUBVOLUME_ID_NONE patch into its predecessor
> > >
> > > Changes since v2:
> > > - Add CEPH_SUBVOLUME_ID_NONE constant (value 0) for unknown/unset sta=
te
> > > - Add WARN_ON_ONCE if attempting to change already-set subvolume_id
> > > - Add documentation for struct ceph_session_feature_desc ('bit' field=
)
> > > - Change pr_err() to pr_info() for "metrics disabled" message
> > > - Use pr_warn_ratelimited() instead of manual __ratelimit()
> > > - Add documentation comments to ceph_subvol_metric_snapshot and
> > >   ceph_subvolume_metrics_tracker structs
> > > - Use kmemdup_array() instead of kmemdup() for overflow checking
> > > - Add comments explaining ret > 0 checks for read metrics (EOF handli=
ng)
> > > - Use kmem_cache for struct ceph_subvol_metric_rb_entry allocations
> > > - Add comment explaining seq_file error handling in dump function
> > >
> > > Changes since v1:
> > > - Fixed unused variable warnings (v8_struct_v, v8_struct_compat) by
> > >   using ceph_decode_skip_8() instead of ceph_decode_8_safe()
> > > - Added detailed comment explaining InodeStat encoding versions v1-v9
> > > - Clarified that "optmetadata" is the actual field name in MDS C++ co=
de
> > > - Aligned subvolume_id handling with FUSE client convention (0 =3D un=
known)
> > >
> > >
> > > Alex Markuze (2):
> > >   ceph: parse subvolume_id from InodeStat v9 and store in inode
> > >   ceph: add subvolume metrics collection and reporting
> > >
> > >  fs/ceph/Makefile            |   2 +-
> > >  fs/ceph/addr.c              |  14 ++
> > >  fs/ceph/debugfs.c           | 157 +++++++++++++++++
> > >  fs/ceph/file.c              |  68 +++++++-
> > >  fs/ceph/inode.c             |  41 +++++
> > >  fs/ceph/mds_client.c        |  72 ++++++--
> > >  fs/ceph/mds_client.h        |  14 +-
> > >  fs/ceph/metric.c            | 183 ++++++++++++++++++-
> > >  fs/ceph/metric.h            |  39 ++++-
> > >  fs/ceph/subvolume_metrics.c | 416 ++++++++++++++++++++++++++++++++++=
++++++++++
> > >  fs/ceph/subvolume_metrics.h |  97 +++++++++++
> > >  fs/ceph/super.c             |   8 +
> > >  fs/ceph/super.h             |  11 ++
> > >  13 files changed, 1094 insertions(+), 28 deletions(-)
> > >  create mode 100644 fs/ceph/subvolume_metrics.c
> > >  create mode 100644 fs/ceph/subvolume_metrics.h
> > >
> > > --
> > > 2.34.1
> >
> > Let me run xfstests on the patchset. I'll be back with the results ASAP=
.
> >
>
> I have troubles to apply your pathset on Linux kernel 6.19-rc6:
>
> git am ./v5_20260118_amarkuze_ceph_add_subvolume_metrics_reporting_suppor=
t.mbx
> Applying: ceph: handle InodeStat v8 versioned field in reply parsing
> Applying: ceph: parse subvolume_id from InodeStat v9 and store in inode
> error: patch failed: fs/ceph/inode.c:742
> error: fs/ceph/inode.c: patch does not apply
> Patch failed at 0002 ceph: parse subvolume_id from InodeStat v9 and store=
 in
> inode
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> Which is your code base? Which branch have you used as base one?
>
> Thanks,
> Slava.
>


