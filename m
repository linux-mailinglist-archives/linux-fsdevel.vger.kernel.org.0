Return-Path: <linux-fsdevel+bounces-6697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D97A481B75B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 14:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912B6284177
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 13:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494B4768EC;
	Thu, 21 Dec 2023 13:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQvin3l/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE3674E12
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 13:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703165054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uo7e1CTALt1we/Nqh6VRmDSjCN+RQpDofWlN35YXm2s=;
	b=hQvin3l/aubs4DTFTK2qLkQTrP0z4pHIq8dHufWeL6nYWRAa28Vbbqy4OFLOXIfdsZTcOy
	7tMuwkO1XwyYchCqMItZgJgjnCSv8l8YUGChUTx8ikJKak9Bo0FqWAWFqgMQSAdmMk+30p
	FvriKJEPEEWIeCAPBomKaWTD2RwtlQA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-SrS0bx-8O5aE_qMQbirc2w-1; Thu, 21 Dec 2023 08:24:10 -0500
X-MC-Unique: SrS0bx-8O5aE_qMQbirc2w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4C5585CEA4;
	Thu, 21 Dec 2023 13:24:09 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.39.195.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 991261C060AF;
	Thu, 21 Dec 2023 13:24:06 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/40] afs: Remove whitespace before most ')' from the trace header
Date: Thu, 21 Dec 2023 13:22:56 +0000
Message-ID: <20231221132400.1601991-2-dhowells@redhat.com>
In-Reply-To: <20231221132400.1601991-1-dhowells@redhat.com>
References: <20231221132400.1601991-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

checkpatch objects to whitespace before ')', so remove most of it from the
afs trace header.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---
 include/trace/events/afs.h | 242 ++++++++++++++++++-------------------
 1 file changed, 121 insertions(+), 121 deletions(-)

diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index e9d412d19dbb..cfcd6452c156 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -654,12 +654,12 @@ TRACE_EVENT(afs_receive_data,
 	    TP_ARGS(call, iter, want_more, ret),
 
 	    TP_STRUCT__entry(
-		    __field(loff_t,			remain		)
-		    __field(unsigned int,		call		)
-		    __field(enum afs_call_state,	state		)
-		    __field(unsigned short,		unmarshall	)
-		    __field(bool,			want_more	)
-		    __field(int,			ret		)
+		    __field(loff_t,			remain)
+		    __field(unsigned int,		call)
+		    __field(enum afs_call_state,	state)
+		    __field(unsigned short,		unmarshall)
+		    __field(bool,			want_more)
+		    __field(int,			ret)
 			     ),
 
 	    TP_fast_assign(
@@ -686,9 +686,9 @@ TRACE_EVENT(afs_notify_call,
 	    TP_ARGS(rxcall, call),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		call		)
-		    __field(enum afs_call_state,	state		)
-		    __field(unsigned short,		unmarshall	)
+		    __field(unsigned int,		call)
+		    __field(enum afs_call_state,	state)
+		    __field(unsigned short,		unmarshall)
 			     ),
 
 	    TP_fast_assign(
@@ -708,9 +708,9 @@ TRACE_EVENT(afs_cb_call,
 	    TP_ARGS(call),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		call		)
-		    __field(u32,			op		)
-		    __field(u16,			service_id	)
+		    __field(unsigned int,		call)
+		    __field(u32,			op)
+		    __field(u16,			service_id)
 			     ),
 
 	    TP_fast_assign(
@@ -733,11 +733,11 @@ TRACE_EVENT(afs_call,
 	    TP_ARGS(call_debug_id, op, ref, outstanding, where),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		call		)
-		    __field(int,			op		)
-		    __field(int,			ref		)
-		    __field(int,			outstanding	)
-		    __field(const void *,		where		)
+		    __field(unsigned int,		call)
+		    __field(int,			op)
+		    __field(int,			ref)
+		    __field(int,			outstanding)
+		    __field(const void *,		where)
 			     ),
 
 	    TP_fast_assign(
@@ -762,9 +762,9 @@ TRACE_EVENT(afs_make_fs_call,
 	    TP_ARGS(call, fid),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		call		)
-		    __field(enum afs_fs_operation,	op		)
-		    __field_struct(struct afs_fid,	fid		)
+		    __field(unsigned int,		call)
+		    __field(enum afs_fs_operation,	op)
+		    __field_struct(struct afs_fid,	fid)
 			     ),
 
 	    TP_fast_assign(
@@ -794,10 +794,10 @@ TRACE_EVENT(afs_make_fs_calli,
 	    TP_ARGS(call, fid, i),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		call		)
-		    __field(unsigned int,		i		)
-		    __field(enum afs_fs_operation,	op		)
-		    __field_struct(struct afs_fid,	fid		)
+		    __field(unsigned int,		call)
+		    __field(unsigned int,		i)
+		    __field(enum afs_fs_operation,	op)
+		    __field_struct(struct afs_fid,	fid)
 			     ),
 
 	    TP_fast_assign(
@@ -829,10 +829,10 @@ TRACE_EVENT(afs_make_fs_call1,
 	    TP_ARGS(call, fid, name),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		call		)
-		    __field(enum afs_fs_operation,	op		)
-		    __field_struct(struct afs_fid,	fid		)
-		    __array(char,			name, 24	)
+		    __field(unsigned int,		call)
+		    __field(enum afs_fs_operation,	op)
+		    __field_struct(struct afs_fid,	fid)
+		    __array(char,			name, 24)
 			     ),
 
 	    TP_fast_assign(
@@ -866,11 +866,11 @@ TRACE_EVENT(afs_make_fs_call2,
 	    TP_ARGS(call, fid, name, name2),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		call		)
-		    __field(enum afs_fs_operation,	op		)
-		    __field_struct(struct afs_fid,	fid		)
-		    __array(char,			name, 24	)
-		    __array(char,			name2, 24	)
+		    __field(unsigned int,		call)
+		    __field(enum afs_fs_operation,	op)
+		    __field_struct(struct afs_fid,	fid)
+		    __array(char,			name, 24)
+		    __array(char,			name2, 24)
 			     ),
 
 	    TP_fast_assign(
@@ -907,8 +907,8 @@ TRACE_EVENT(afs_make_vl_call,
 	    TP_ARGS(call),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		call		)
-		    __field(enum afs_vl_operation,	op		)
+		    __field(unsigned int,		call)
+		    __field(enum afs_vl_operation,	op)
 			     ),
 
 	    TP_fast_assign(
@@ -927,10 +927,10 @@ TRACE_EVENT(afs_call_done,
 	    TP_ARGS(call),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		call		)
-		    __field(struct rxrpc_call *,	rx_call		)
-		    __field(int,			ret		)
-		    __field(u32,			abort_code	)
+		    __field(unsigned int,		call)
+		    __field(struct rxrpc_call *,	rx_call)
+		    __field(int,			ret)
+		    __field(u32,			abort_code)
 			     ),
 
 	    TP_fast_assign(
@@ -953,10 +953,10 @@ TRACE_EVENT(afs_send_data,
 	    TP_ARGS(call, msg),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		call		)
-		    __field(unsigned int,		flags		)
-		    __field(loff_t,			offset		)
-		    __field(loff_t,			count		)
+		    __field(unsigned int,		call)
+		    __field(unsigned int,		flags)
+		    __field(loff_t,			offset)
+		    __field(loff_t,			count)
 			     ),
 
 	    TP_fast_assign(
@@ -977,10 +977,10 @@ TRACE_EVENT(afs_sent_data,
 	    TP_ARGS(call, msg, ret),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		call		)
-		    __field(int,			ret		)
-		    __field(loff_t,			offset		)
-		    __field(loff_t,			count		)
+		    __field(unsigned int,		call)
+		    __field(int,			ret)
+		    __field(loff_t,			offset)
+		    __field(loff_t,			count)
 			     ),
 
 	    TP_fast_assign(
@@ -1001,9 +1001,9 @@ TRACE_EVENT(afs_dir_check_failed,
 	    TP_ARGS(vnode, off, i_size),
 
 	    TP_STRUCT__entry(
-		    __field(struct afs_vnode *,		vnode		)
-		    __field(loff_t,			off		)
-		    __field(loff_t,			i_size		)
+		    __field(struct afs_vnode *,		vnode)
+		    __field(loff_t,			off)
+		    __field(loff_t,			i_size)
 			     ),
 
 	    TP_fast_assign(
@@ -1022,11 +1022,11 @@ TRACE_EVENT(afs_folio_dirty,
 	    TP_ARGS(vnode, where, folio),
 
 	    TP_STRUCT__entry(
-		    __field(struct afs_vnode *,		vnode		)
-		    __field(const char *,		where		)
-		    __field(pgoff_t,			index		)
-		    __field(unsigned long,		from		)
-		    __field(unsigned long,		to		)
+		    __field(struct afs_vnode *,		vnode)
+		    __field(const char *,		where)
+		    __field(pgoff_t,			index)
+		    __field(unsigned long,		from)
+		    __field(unsigned long,		to)
 			     ),
 
 	    TP_fast_assign(
@@ -1056,11 +1056,11 @@ TRACE_EVENT(afs_call_state,
 	    TP_ARGS(call, from, to, ret, remote_abort),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		call		)
-		    __field(enum afs_call_state,	from		)
-		    __field(enum afs_call_state,	to		)
-		    __field(int,			ret		)
-		    __field(u32,			abort		)
+		    __field(unsigned int,		call)
+		    __field(enum afs_call_state,	from)
+		    __field(enum afs_call_state,	to)
+		    __field(int,			ret)
+		    __field(u32,			abort)
 			     ),
 
 	    TP_fast_assign(
@@ -1084,9 +1084,9 @@ TRACE_EVENT(afs_lookup,
 	    TP_ARGS(dvnode, name, fid),
 
 	    TP_STRUCT__entry(
-		    __field_struct(struct afs_fid,	dfid		)
-		    __field_struct(struct afs_fid,	fid		)
-		    __array(char,			name, 24	)
+		    __field_struct(struct afs_fid,	dfid)
+		    __field_struct(struct afs_fid,	fid)
+		    __array(char,			name, 24)
 			     ),
 
 	    TP_fast_assign(
@@ -1116,15 +1116,15 @@ TRACE_EVENT(afs_edit_dir,
 	    TP_ARGS(dvnode, why, op, block, slot, f_vnode, f_unique, name),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		vnode		)
-		    __field(unsigned int,		unique		)
-		    __field(enum afs_edit_dir_reason,	why		)
-		    __field(enum afs_edit_dir_op,	op		)
-		    __field(unsigned int,		block		)
-		    __field(unsigned short,		slot		)
-		    __field(unsigned int,		f_vnode		)
-		    __field(unsigned int,		f_unique	)
-		    __array(char,			name, 24	)
+		    __field(unsigned int,		vnode)
+		    __field(unsigned int,		unique)
+		    __field(enum afs_edit_dir_reason,	why)
+		    __field(enum afs_edit_dir_op,	op)
+		    __field(unsigned int,		block)
+		    __field(unsigned short,		slot)
+		    __field(unsigned int,		f_vnode)
+		    __field(unsigned int,		f_unique)
+		    __array(char,			name, 24)
 			     ),
 
 	    TP_fast_assign(
@@ -1157,8 +1157,8 @@ TRACE_EVENT(afs_protocol_error,
 	    TP_ARGS(call, cause),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		call		)
-		    __field(enum afs_eproto_cause,	cause		)
+		    __field(unsigned int,		call)
+		    __field(enum afs_eproto_cause,	cause)
 			     ),
 
 	    TP_fast_assign(
@@ -1177,9 +1177,9 @@ TRACE_EVENT(afs_io_error,
 	    TP_ARGS(call, error, where),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,	call		)
-		    __field(int,		error		)
-		    __field(enum afs_io_error,	where		)
+		    __field(unsigned int,	call)
+		    __field(int,		error)
+		    __field(enum afs_io_error,	where)
 			     ),
 
 	    TP_fast_assign(
@@ -1199,9 +1199,9 @@ TRACE_EVENT(afs_file_error,
 	    TP_ARGS(vnode, error, where),
 
 	    TP_STRUCT__entry(
-		    __field_struct(struct afs_fid,	fid		)
-		    __field(int,			error		)
-		    __field(enum afs_file_error,	where		)
+		    __field_struct(struct afs_fid,	fid)
+		    __field(int,			error)
+		    __field(enum afs_file_error,	where)
 			     ),
 
 	    TP_fast_assign(
@@ -1222,9 +1222,9 @@ TRACE_EVENT(afs_cm_no_server,
 	    TP_ARGS(call, srx),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,			call	)
-		    __field(unsigned int,			op_id	)
-		    __field_struct(struct sockaddr_rxrpc,	srx	)
+		    __field(unsigned int,			call)
+		    __field(unsigned int,			op_id)
+		    __field_struct(struct sockaddr_rxrpc,	srx)
 			     ),
 
 	    TP_fast_assign(
@@ -1243,9 +1243,9 @@ TRACE_EVENT(afs_cm_no_server_u,
 	    TP_ARGS(call, uuid),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,			call	)
-		    __field(unsigned int,			op_id	)
-		    __field_struct(uuid_t,			uuid	)
+		    __field(unsigned int,			call)
+		    __field(unsigned int,			op_id)
+		    __field_struct(uuid_t,			uuid)
 			     ),
 
 	    TP_fast_assign(
@@ -1265,11 +1265,11 @@ TRACE_EVENT(afs_flock_ev,
 	    TP_ARGS(vnode, fl, event, error),
 
 	    TP_STRUCT__entry(
-		    __field_struct(struct afs_fid,	fid		)
-		    __field(enum afs_flock_event,	event		)
-		    __field(enum afs_lock_state,	state		)
-		    __field(int,			error		)
-		    __field(unsigned int,		debug_id	)
+		    __field_struct(struct afs_fid,	fid)
+		    __field(enum afs_flock_event,	event)
+		    __field(enum afs_lock_state,	state)
+		    __field(int,			error)
+		    __field(unsigned int,		debug_id)
 			     ),
 
 	    TP_fast_assign(
@@ -1295,13 +1295,13 @@ TRACE_EVENT(afs_flock_op,
 	    TP_ARGS(vnode, fl, op),
 
 	    TP_STRUCT__entry(
-		    __field_struct(struct afs_fid,	fid		)
-		    __field(loff_t,			from		)
-		    __field(loff_t,			len		)
-		    __field(enum afs_flock_operation,	op		)
-		    __field(unsigned char,		type		)
-		    __field(unsigned int,		flags		)
-		    __field(unsigned int,		debug_id	)
+		    __field_struct(struct afs_fid,	fid)
+		    __field(loff_t,			from)
+		    __field(loff_t,			len)
+		    __field(enum afs_flock_operation,	op)
+		    __field(unsigned char,		type)
+		    __field(unsigned int,		flags)
+		    __field(unsigned int,		debug_id)
 			     ),
 
 	    TP_fast_assign(
@@ -1328,7 +1328,7 @@ TRACE_EVENT(afs_reload_dir,
 	    TP_ARGS(vnode),
 
 	    TP_STRUCT__entry(
-		    __field_struct(struct afs_fid,	fid		)
+		    __field_struct(struct afs_fid,	fid)
 			     ),
 
 	    TP_fast_assign(
@@ -1345,8 +1345,8 @@ TRACE_EVENT(afs_silly_rename,
 	    TP_ARGS(vnode, done),
 
 	    TP_STRUCT__entry(
-		    __field_struct(struct afs_fid,	fid		)
-		    __field(bool,			done		)
+		    __field_struct(struct afs_fid,	fid)
+		    __field(bool,			done)
 			     ),
 
 	    TP_fast_assign(
@@ -1365,9 +1365,9 @@ TRACE_EVENT(afs_get_tree,
 	    TP_ARGS(cell, volume),
 
 	    TP_STRUCT__entry(
-		    __field(u64,			vid		)
-		    __array(char,			cell, 24	)
-		    __array(char,			volume, 24	)
+		    __field(u64,			vid)
+		    __array(char,			cell, 24)
+		    __array(char,			volume, 24)
 			     ),
 
 	    TP_fast_assign(
@@ -1392,10 +1392,10 @@ TRACE_EVENT(afs_cb_break,
 	    TP_ARGS(fid, cb_break, reason, skipped),
 
 	    TP_STRUCT__entry(
-		    __field_struct(struct afs_fid,	fid		)
-		    __field(unsigned int,		cb_break	)
-		    __field(enum afs_cb_break_reason,	reason		)
-		    __field(bool,			skipped		)
+		    __field_struct(struct afs_fid,	fid)
+		    __field(unsigned int,		cb_break)
+		    __field(enum afs_cb_break_reason,	reason)
+		    __field(bool,			skipped)
 			     ),
 
 	    TP_fast_assign(
@@ -1418,8 +1418,8 @@ TRACE_EVENT(afs_cb_miss,
 	    TP_ARGS(fid, reason),
 
 	    TP_STRUCT__entry(
-		    __field_struct(struct afs_fid,	fid		)
-		    __field(enum afs_cb_break_reason,	reason		)
+		    __field_struct(struct afs_fid,	fid)
+		    __field(enum afs_cb_break_reason,	reason)
 			     ),
 
 	    TP_fast_assign(
@@ -1439,10 +1439,10 @@ TRACE_EVENT(afs_server,
 	    TP_ARGS(server_debug_id, ref, active, reason),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		server		)
-		    __field(int,			ref		)
-		    __field(int,			active		)
-		    __field(int,			reason		)
+		    __field(unsigned int,		server)
+		    __field(int,			ref)
+		    __field(int,			active)
+		    __field(int,			reason)
 			     ),
 
 	    TP_fast_assign(
@@ -1465,9 +1465,9 @@ TRACE_EVENT(afs_volume,
 	    TP_ARGS(vid, ref, reason),
 
 	    TP_STRUCT__entry(
-		    __field(afs_volid_t,		vid		)
-		    __field(int,			ref		)
-		    __field(enum afs_volume_trace,	reason		)
+		    __field(afs_volid_t,		vid)
+		    __field(int,			ref)
+		    __field(enum afs_volume_trace,	reason)
 			     ),
 
 	    TP_fast_assign(
@@ -1489,10 +1489,10 @@ TRACE_EVENT(afs_cell,
 	    TP_ARGS(cell_debug_id, ref, active, reason),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		cell		)
-		    __field(int,			ref		)
-		    __field(int,			active		)
-		    __field(int,			reason		)
+		    __field(unsigned int,		cell)
+		    __field(int,			ref)
+		    __field(int,			active)
+		    __field(int,			reason)
 			     ),
 
 	    TP_fast_assign(


