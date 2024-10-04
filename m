Return-Path: <linux-fsdevel+bounces-30987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C9F9903CF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 15:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1268B23266
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 13:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A426216A0F;
	Fri,  4 Oct 2024 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAQVSWlR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC8D215F60;
	Fri,  4 Oct 2024 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728047896; cv=none; b=ELd/pKkvG2us+lYUTqbx4aeynLuGjFVfLYzXYkuwAKPp0xi40wf/l1e6k5boDxzwidyYOy4x9rqWcpdIejxOPNsRmv7f3lYsizGwnU5LN35UgVhAO8a4+PD/4I7V5m94qKt7Tcf3r7c0XtCt/3ANezsVAqthXTy/cIPsOwg9eUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728047896; c=relaxed/simple;
	bh=DauhQaF1OAWq0DfDhQ+QqY1qQnmk0ScTlDFH/YL1d68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S2zNrOg8w4GvPCNYvDtZnWSE1s5UNAMS1XHn6/N/Zq6IPIhfU7xr0EGzhk96xYZ3IpuJguJ38cZOWgtGr98eL2H0m8DLMw5chaPRf0GDzYLWl1BepZKV0upTrb7oT9jg59+4c1Cr83FxXItf+AIgp9rhTCRHFgMDa4LnkZhu/n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAQVSWlR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B10C4CEC6;
	Fri,  4 Oct 2024 13:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728047896;
	bh=DauhQaF1OAWq0DfDhQ+QqY1qQnmk0ScTlDFH/YL1d68=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KAQVSWlRlgsP3AD0RLK8udpfPZK/yorC9fW5vPX3gyJhrgcrQJ5rSUyXGLhebIVcs
	 CXo4SV/nZLZQB2xmtuJYE2qOamKF1V7aBYS5vGiRv3Uhe+3WPvHBLQBQGwwANfjrnr
	 5JrzH/nqXZ+C4kuclONJARUBfI65X9RypBCNzw9hJhBnL7az6Oljxhn1Jq4UJmqmv7
	 4kz8Tk2LR/HEjnJasSRC29SMuLhMDA6y9VPXc3SUrwmYVkb1MAPQwKXQJ5w9PnzKr0
	 jbH5wiCQ8ZTk25z4xkthXrLl3B9F6IG71SqtEEdWpH8H8PooB6gPE30NquRzv/tTre
	 7Z957p/t/TsZQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 04 Oct 2024 09:16:48 -0400
Subject: [PATCH v4 5/9] nfs_common: make include/linux/nfs4.h include
 generated nfs4_1.h
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-delstid-v4-5-62ac29c49c2e@kernel.org>
References: <20241004-delstid-v4-0-62ac29c49c2e@kernel.org>
In-Reply-To: <20241004-delstid-v4-0-62ac29c49c2e@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Tom Haynes <loghyr@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=21227; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=DauhQaF1OAWq0DfDhQ+QqY1qQnmk0ScTlDFH/YL1d68=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/+sNVyhLVrwangU3C/bp5Y3DEFjvdxwHtYAS+
 Z//S1rlTjiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv/rDQAKCRAADmhBGVaC
 FadgEADLgX6toFFY+yV7I3/Su+0YxAkvCNn224/THXfwXCSn6/TDqoknpxjwVcD71MyikMITFVe
 y76bE+a/KdLU+OIWP0P5XKOhg0T0Gb2WRNvewOh0KZowekViO00E3+ive6cZn039xm1ngCpqao7
 Jc1C03T65WvmaR6FduqVSiQQMxLMUSG0AWnWNHm9nP/GA+VnVyFK9piz6YtOg8noXFd5jEfFacG
 xHLXB04i8MKNMe0OjwKoQCcTN+OfS1Lt1lljDUG1C3hbOUp8s98L7Rnsndm7CBeiKesxiZ/wVfa
 tv6jiNIeYrMuUUHwIUm468BChieMagTvpAbs0Q2NkoHLzO9WyqdXExbFopxUj+YY9wfSrTfPw+n
 Hqz8LJURlT6ffR0qm1Zq9c0/4VXswXpQgwWc4XlgV+3WSVddMe7DMcmnak0MluNF0lpBSh1rTRr
 oI0fnFkOXQZxqKD32J03DiMdRAurY6FF3PtkrANC27JoAXyocIrXS556FoAAYhLi2cNkbVWdp1K
 bmKVf8r4casesGqT+YWWhW1bqjGBsjwrWotloEM/5v6djuxH3Dq1GiOJyZw/YjKPGrWOXEv0Xl8
 gTk+veb6DjlIY0HfWXAY7FCFfnRKOcqo1djK7G0yeuB9c/6tXL9tkwWSfVUtZbd3YZGw8dRNFzc
 MVuC8V6sa7qn7Yg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In the long run, the NFS development community intends to autogenerate a
lot of the XDR handling code.  Both the NFS client and server include
"include/linux/nfs4.hi". That file was hand-rolled, and some of the symbols
in it conflict with the autogenerated symbols.

Add a small nfs4_1.x to Documentation that currently just has the
necessary definitions for the delstid draft, and generate the relevant
header and source files. Make include/linux/nfs4.h include the generated
include/linux/sunrpc/xdrgen/nfs4_1.h and remove the conflicting
definitions from it and nfs_xdr.h.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/sunrpc/xdr/nfs4_1.x    | 166 ++++++++++++++++++++++++
 fs/nfsd/Makefile                     |  17 ++-
 fs/nfsd/nfs4xdr_gen.c                | 239 +++++++++++++++++++++++++++++++++++
 fs/nfsd/nfs4xdr_gen.h                |  25 ++++
 include/linux/nfs4.h                 |   7 +-
 include/linux/nfs_xdr.h              |   5 -
 include/linux/sunrpc/xdrgen/nfs4_1.h | 124 ++++++++++++++++++
 7 files changed, 571 insertions(+), 12 deletions(-)

diff --git a/Documentation/sunrpc/xdr/nfs4_1.x b/Documentation/sunrpc/xdr/nfs4_1.x
new file mode 100644
index 0000000000000000000000000000000000000000..fc37d1ecba0f40e46c6986df90d07a0e6e6ae9b2
--- /dev/null
+++ b/Documentation/sunrpc/xdr/nfs4_1.x
@@ -0,0 +1,166 @@
+/*
+ * Copyright (c) 2010 IETF Trust and the persons identified
+ * as the document authors.  All rights reserved.
+ *
+ * The document authors are identified in RFC 3530 and
+ * RFC 5661.
+ *
+ * Redistribution and use in source and binary forms, with
+ * or without modification, are permitted provided that the
+ * following conditions are met:
+ *
+ * - Redistributions of source code must retain the above
+ *   copyright notice, this list of conditions and the
+ *   following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the
+ *   following disclaimer in the documentation and/or other
+ *   materials provided with the distribution.
+ *
+ * - Neither the name of Internet Society, IETF or IETF
+ *   Trust, nor the names of specific contributors, may be
+ *   used to endorse or promote products derived from this
+ *   software without specific prior written permission.
+ *
+ *   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS
+ *   AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
+ *   WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ *   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
+ *   FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
+ *   EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
+ *   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
+ *   EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *   NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ *   SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ *   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ *   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
+ *   OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ *   IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ *   ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+pragma header nfs4;
+
+/*
+ * Basic typedefs for RFC 1832 data type definitions
+ */
+typedef hyper		int64_t;
+typedef unsigned int	uint32_t;
+
+/*
+ * Basic data types
+ */
+typedef uint32_t	bitmap4<>;
+
+/*
+ * Timeval
+ */
+struct nfstime4 {
+	int64_t		seconds;
+	uint32_t	nseconds;
+};
+
+
+/*
+ * The following content was extracted from draft-ietf-nfsv4-delstid
+ */
+
+typedef bool            fattr4_offline;
+
+
+const FATTR4_OFFLINE            = 83;
+
+
+struct open_arguments4 {
+  bitmap4  oa_share_access;
+  bitmap4  oa_share_deny;
+  bitmap4  oa_share_access_want;
+  bitmap4  oa_open_claim;
+  bitmap4  oa_create_mode;
+};
+
+
+enum open_args_share_access4 {
+   OPEN_ARGS_SHARE_ACCESS_READ  = 1,
+   OPEN_ARGS_SHARE_ACCESS_WRITE = 2,
+   OPEN_ARGS_SHARE_ACCESS_BOTH  = 3
+};
+
+
+enum open_args_share_deny4 {
+   OPEN_ARGS_SHARE_DENY_NONE  = 0,
+   OPEN_ARGS_SHARE_DENY_READ  = 1,
+   OPEN_ARGS_SHARE_DENY_WRITE = 2,
+   OPEN_ARGS_SHARE_DENY_BOTH  = 3
+};
+
+
+enum open_args_share_access_want4 {
+   OPEN_ARGS_SHARE_ACCESS_WANT_ANY_DELEG           = 3,
+   OPEN_ARGS_SHARE_ACCESS_WANT_NO_DELEG            = 4,
+   OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL              = 5,
+   OPEN_ARGS_SHARE_ACCESS_WANT_SIGNAL_DELEG_WHEN_RESRC_AVAIL
+                                                   = 17,
+   OPEN_ARGS_SHARE_ACCESS_WANT_PUSH_DELEG_WHEN_UNCONTENDED
+                                                   = 18,
+   OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS    = 20,
+   OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION = 21
+};
+
+
+enum open_args_open_claim4 {
+   OPEN_ARGS_OPEN_CLAIM_NULL          = 0,
+   OPEN_ARGS_OPEN_CLAIM_PREVIOUS      = 1,
+   OPEN_ARGS_OPEN_CLAIM_DELEGATE_CUR  = 2,
+   OPEN_ARGS_OPEN_CLAIM_DELEGATE_PREV = 3,
+   OPEN_ARGS_OPEN_CLAIM_FH            = 4,
+   OPEN_ARGS_OPEN_CLAIM_DELEG_CUR_FH  = 5,
+   OPEN_ARGS_OPEN_CLAIM_DELEG_PREV_FH = 6
+};
+
+
+enum open_args_createmode4 {
+   OPEN_ARGS_CREATEMODE_UNCHECKED4     = 0,
+   OPEN_ARGS_CREATE_MODE_GUARDED       = 1,
+   OPEN_ARGS_CREATEMODE_EXCLUSIVE4     = 2,
+   OPEN_ARGS_CREATE_MODE_EXCLUSIVE4_1  = 3
+};
+
+
+typedef open_arguments4 fattr4_open_arguments;
+pragma public fattr4_open_arguments;
+
+
+%/*
+% * Determine what OPEN supports.
+% */
+const FATTR4_OPEN_ARGUMENTS     = 86;
+
+
+const OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION = 0x200000;
+
+
+const OPEN4_RESULT_NO_OPEN_STATEID = 0x00000010;
+
+
+/*
+ * attributes for the delegation times being
+ * cached and served by the "client"
+ */
+typedef nfstime4        fattr4_time_deleg_access;
+typedef nfstime4        fattr4_time_deleg_modify;
+pragma public 		fattr4_time_deleg_access;
+pragma public		fattr4_time_deleg_modify;
+
+
+%/*
+% * New RECOMMENDED Attribute for
+% * delegation caching of times
+% */
+const FATTR4_TIME_DELEG_ACCESS  = 84;
+const FATTR4_TIME_DELEG_MODIFY  = 85;
+
+
+const OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS = 0x100000;
+
diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
index 18cbd3fa7691a27b39a3b1264637b9422aeb42ba..7cf31c5a17597428cc27f8f1c95732f5221c2daa 100644
--- a/fs/nfsd/Makefile
+++ b/fs/nfsd/Makefile
@@ -18,9 +18,24 @@ nfsd-$(CONFIG_NFSD_V2) += nfsproc.o nfsxdr.o
 nfsd-$(CONFIG_NFSD_V2_ACL) += nfs2acl.o
 nfsd-$(CONFIG_NFSD_V3_ACL) += nfs3acl.o
 nfsd-$(CONFIG_NFSD_V4)	+= nfs4proc.o nfs4xdr.o nfs4state.o nfs4idmap.o \
-			   nfs4acl.o nfs4callback.o nfs4recover.o
+			   nfs4acl.o nfs4callback.o nfs4recover.o nfs4xdr_gen.o
 nfsd-$(CONFIG_NFSD_PNFS) += nfs4layouts.o
 nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) += blocklayout.o blocklayoutxdr.o
 nfsd-$(CONFIG_NFSD_SCSILAYOUT) += blocklayout.o blocklayoutxdr.o
 nfsd-$(CONFIG_NFSD_FLEXFILELAYOUT) += flexfilelayout.o flexfilelayoutxdr.o
 nfsd-$(CONFIG_NFS_LOCALIO) += localio.o
+
+
+.PHONY: xdrgen
+
+xdrgen: ../../include/linux/sunrpc/xdrgen/nfs4_1.h nfs4xdr_gen.h nfs4xdr_gen.c
+
+../../include/linux/sunrpc/xdrgen/nfs4_1.h: ../../Documentation/sunrpc/xdr/nfs4_1.x
+	../../tools/net/sunrpc/xdrgen/xdrgen definitions $< > $@
+
+nfs4xdr_gen.h: ../../Documentation/sunrpc/xdr/nfs4_1.x
+	../../tools/net/sunrpc/xdrgen/xdrgen declarations $< > $@
+
+nfs4xdr_gen.c: ../../Documentation/sunrpc/xdr/nfs4_1.x
+	../../tools/net/sunrpc/xdrgen/xdrgen source $< > $@
+
diff --git a/fs/nfsd/nfs4xdr_gen.c b/fs/nfsd/nfs4xdr_gen.c
new file mode 100644
index 0000000000000000000000000000000000000000..e5d34f9a3147d9d51fb3b9db4c29b048b1083cbf
--- /dev/null
+++ b/fs/nfsd/nfs4xdr_gen.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0
+// Generated by xdrgen. Manual edits will be lost.
+// XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_1.x
+// XDR specification modification time: Thu Oct  3 11:30:59 2024
+
+#include <linux/sunrpc/svc.h>
+
+#include "nfs4xdr_gen.h"
+
+static bool __maybe_unused
+xdrgen_decode_int64_t(struct xdr_stream *xdr, int64_t *ptr)
+{
+	return xdrgen_decode_hyper(xdr, ptr);
+};
+
+static bool __maybe_unused
+xdrgen_decode_uint32_t(struct xdr_stream *xdr, uint32_t *ptr)
+{
+	return xdrgen_decode_unsigned_int(xdr, ptr);
+};
+
+static bool __maybe_unused
+xdrgen_decode_bitmap4(struct xdr_stream *xdr, bitmap4 *ptr)
+{
+	if (xdr_stream_decode_u32(xdr, &ptr->count) < 0)
+		return false;
+	for (u32 i = 0; i < ptr->count; i++)
+		if (!xdrgen_decode_uint32_t(xdr, &ptr->element[i]))
+			return false;
+	return true;
+};
+
+static bool __maybe_unused
+xdrgen_decode_nfstime4(struct xdr_stream *xdr, struct nfstime4 *ptr)
+{
+	if (!xdrgen_decode_int64_t(xdr, &ptr->seconds))
+		return false;
+	if (!xdrgen_decode_uint32_t(xdr, &ptr->nseconds))
+		return false;
+	return true;
+};
+
+static bool __maybe_unused
+xdrgen_decode_fattr4_offline(struct xdr_stream *xdr, fattr4_offline *ptr)
+{
+	return xdrgen_decode_bool(xdr, ptr);
+};
+
+static bool __maybe_unused
+xdrgen_decode_open_arguments4(struct xdr_stream *xdr, struct open_arguments4 *ptr)
+{
+	if (!xdrgen_decode_bitmap4(xdr, &ptr->oa_share_access))
+		return false;
+	if (!xdrgen_decode_bitmap4(xdr, &ptr->oa_share_deny))
+		return false;
+	if (!xdrgen_decode_bitmap4(xdr, &ptr->oa_share_access_want))
+		return false;
+	if (!xdrgen_decode_bitmap4(xdr, &ptr->oa_open_claim))
+		return false;
+	if (!xdrgen_decode_bitmap4(xdr, &ptr->oa_create_mode))
+		return false;
+	return true;
+};
+
+static bool __maybe_unused
+xdrgen_decode_open_args_share_access4(struct xdr_stream *xdr, open_args_share_access4 *ptr)
+{
+	u32 val;
+
+	if (xdr_stream_decode_u32(xdr, &val) < 0)
+		return false;
+	*ptr = val;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_open_args_share_deny4(struct xdr_stream *xdr, open_args_share_deny4 *ptr)
+{
+	u32 val;
+
+	if (xdr_stream_decode_u32(xdr, &val) < 0)
+		return false;
+	*ptr = val;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_open_args_share_access_want4(struct xdr_stream *xdr, open_args_share_access_want4 *ptr)
+{
+	u32 val;
+
+	if (xdr_stream_decode_u32(xdr, &val) < 0)
+		return false;
+	*ptr = val;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_open_args_open_claim4(struct xdr_stream *xdr, open_args_open_claim4 *ptr)
+{
+	u32 val;
+
+	if (xdr_stream_decode_u32(xdr, &val) < 0)
+		return false;
+	*ptr = val;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_open_args_createmode4(struct xdr_stream *xdr, open_args_createmode4 *ptr)
+{
+	u32 val;
+
+	if (xdr_stream_decode_u32(xdr, &val) < 0)
+		return false;
+	*ptr = val;
+	return true;
+}
+
+bool
+xdrgen_decode_fattr4_open_arguments(struct xdr_stream *xdr, fattr4_open_arguments *ptr)
+{
+	return xdrgen_decode_open_arguments4(xdr, ptr);
+};
+
+bool
+xdrgen_decode_fattr4_time_deleg_access(struct xdr_stream *xdr, fattr4_time_deleg_access *ptr)
+{
+	return xdrgen_decode_nfstime4(xdr, ptr);
+};
+
+bool
+xdrgen_decode_fattr4_time_deleg_modify(struct xdr_stream *xdr, fattr4_time_deleg_modify *ptr)
+{
+	return xdrgen_decode_nfstime4(xdr, ptr);
+};
+
+static bool __maybe_unused
+xdrgen_encode_int64_t(struct xdr_stream *xdr, const int64_t value)
+{
+	return xdrgen_encode_hyper(xdr, value);
+};
+
+static bool __maybe_unused
+xdrgen_encode_uint32_t(struct xdr_stream *xdr, const uint32_t value)
+{
+	return xdrgen_encode_unsigned_int(xdr, value);
+};
+
+static bool __maybe_unused
+xdrgen_encode_bitmap4(struct xdr_stream *xdr, const bitmap4 value)
+{
+	if (xdr_stream_encode_u32(xdr, value.count) != XDR_UNIT)
+		return false;
+	for (u32 i = 0; i < value.count; i++)
+		if (!xdrgen_encode_uint32_t(xdr, value.element[i]))
+			return false;
+	return true;
+};
+
+static bool __maybe_unused
+xdrgen_encode_nfstime4(struct xdr_stream *xdr, const struct nfstime4 *value)
+{
+	if (!xdrgen_encode_int64_t(xdr, value->seconds))
+		return false;
+	if (!xdrgen_encode_uint32_t(xdr, value->nseconds))
+		return false;
+	return true;
+};
+
+static bool __maybe_unused
+xdrgen_encode_fattr4_offline(struct xdr_stream *xdr, const fattr4_offline value)
+{
+	return xdrgen_encode_bool(xdr, value);
+};
+
+static bool __maybe_unused
+xdrgen_encode_open_arguments4(struct xdr_stream *xdr, const struct open_arguments4 *value)
+{
+	if (!xdrgen_encode_bitmap4(xdr, value->oa_share_access))
+		return false;
+	if (!xdrgen_encode_bitmap4(xdr, value->oa_share_deny))
+		return false;
+	if (!xdrgen_encode_bitmap4(xdr, value->oa_share_access_want))
+		return false;
+	if (!xdrgen_encode_bitmap4(xdr, value->oa_open_claim))
+		return false;
+	if (!xdrgen_encode_bitmap4(xdr, value->oa_create_mode))
+		return false;
+	return true;
+};
+
+static bool __maybe_unused
+xdrgen_encode_open_args_share_access4(struct xdr_stream *xdr, open_args_share_access4 value)
+{
+	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
+}
+
+static bool __maybe_unused
+xdrgen_encode_open_args_share_deny4(struct xdr_stream *xdr, open_args_share_deny4 value)
+{
+	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
+}
+
+static bool __maybe_unused
+xdrgen_encode_open_args_share_access_want4(struct xdr_stream *xdr, open_args_share_access_want4 value)
+{
+	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
+}
+
+static bool __maybe_unused
+xdrgen_encode_open_args_open_claim4(struct xdr_stream *xdr, open_args_open_claim4 value)
+{
+	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
+}
+
+static bool __maybe_unused
+xdrgen_encode_open_args_createmode4(struct xdr_stream *xdr, open_args_createmode4 value)
+{
+	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
+}
+
+bool
+xdrgen_encode_fattr4_open_arguments(struct xdr_stream *xdr, const fattr4_open_arguments *value)
+{
+	return xdrgen_encode_open_arguments4(xdr, value);
+};
+
+bool
+xdrgen_encode_fattr4_time_deleg_access(struct xdr_stream *xdr, const fattr4_time_deleg_access *value)
+{
+	return xdrgen_encode_nfstime4(xdr, value);
+};
+
+bool
+xdrgen_encode_fattr4_time_deleg_modify(struct xdr_stream *xdr, const fattr4_time_deleg_modify *value)
+{
+	return xdrgen_encode_nfstime4(xdr, value);
+};
diff --git a/fs/nfsd/nfs4xdr_gen.h b/fs/nfsd/nfs4xdr_gen.h
new file mode 100644
index 0000000000000000000000000000000000000000..c4c6a5075b17be3f931e2a20e282e33dc6e10ef1
--- /dev/null
+++ b/fs/nfsd/nfs4xdr_gen.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Generated by xdrgen. Manual edits will be lost. */
+/* XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_1.x */
+/* XDR specification modification time: Thu Oct  3 11:30:59 2024 */
+
+#ifndef _LINUX_XDRGEN_NFS4_1_DECL_H
+#define _LINUX_XDRGEN_NFS4_1_DECL_H
+
+#include <linux/types.h>
+
+#include <linux/sunrpc/xdr.h>
+#include <linux/sunrpc/xdrgen/_defs.h>
+#include <linux/sunrpc/xdrgen/_builtins.h>
+#include <linux/sunrpc/xdrgen/nfs4_1.h>
+
+bool xdrgen_decode_fattr4_open_arguments(struct xdr_stream *xdr, fattr4_open_arguments *ptr);
+bool xdrgen_encode_fattr4_open_arguments(struct xdr_stream *xdr, const fattr4_open_arguments *value);
+
+bool xdrgen_decode_fattr4_time_deleg_access(struct xdr_stream *xdr, fattr4_time_deleg_access *ptr);
+bool xdrgen_encode_fattr4_time_deleg_access(struct xdr_stream *xdr, const fattr4_time_deleg_access *value);
+
+bool xdrgen_decode_fattr4_time_deleg_modify(struct xdr_stream *xdr, fattr4_time_deleg_modify *ptr);
+bool xdrgen_encode_fattr4_time_deleg_modify(struct xdr_stream *xdr, const fattr4_time_deleg_modify *value);
+
+#endif /* _LINUX_XDRGEN_NFS4_1_DECL_H */
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 8d7430d9f2183f08fc995b12370d0ddddf0bffba..b907192447755a614289554a01928c1ebb61c3dc 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -17,6 +17,7 @@
 #include <linux/uidgid.h>
 #include <uapi/linux/nfs4.h>
 #include <linux/sunrpc/msg_prot.h>
+#include <linux/sunrpc/xdrgen/nfs4_1.h>
 
 enum nfs4_acl_whotype {
 	NFS4_ACL_WHO_NAMED = 0,
@@ -512,12 +513,6 @@ enum {
 	FATTR4_XATTR_SUPPORT		= 82,
 };
 
-enum {
-	FATTR4_TIME_DELEG_ACCESS	= 84,
-	FATTR4_TIME_DELEG_MODIFY	= 85,
-	FATTR4_OPEN_ARGUMENTS		= 86,
-};
-
 /*
  * The following internal definitions enable processing the above
  * attribute bits within 32-bit word boundaries.
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 12d8e47bc5a38863b2831fb16056f742fa81612e..e0ae0a14257f21f212e439dde1ce66ac301eb86c 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1315,11 +1315,6 @@ struct nfs4_fsid_present_res {
 
 #endif /* CONFIG_NFS_V4 */
 
-struct nfstime4 {
-	u64	seconds;
-	u32	nseconds;
-};
-
 #ifdef CONFIG_NFS_V4_1
 
 struct pnfs_commit_bucket {
diff --git a/include/linux/sunrpc/xdrgen/nfs4_1.h b/include/linux/sunrpc/xdrgen/nfs4_1.h
new file mode 100644
index 0000000000000000000000000000000000000000..6025ab6b739833aad33567102e216c162003f408
--- /dev/null
+++ b/include/linux/sunrpc/xdrgen/nfs4_1.h
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Generated by xdrgen. Manual edits will be lost. */
+/* XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_1.x */
+/* XDR specification modification time: Thu Oct  3 11:30:59 2024 */
+
+#ifndef _LINUX_XDRGEN_NFS4_1_DEF_H
+#define _LINUX_XDRGEN_NFS4_1_DEF_H
+
+#include <linux/types.h>
+#include <linux/sunrpc/xdrgen/_defs.h>
+
+typedef s64 int64_t;
+
+typedef u32 uint32_t;
+
+typedef struct {
+	u32 count;
+	uint32_t *element;
+} bitmap4;
+
+struct nfstime4 {
+	int64_t seconds;
+	uint32_t nseconds;
+};
+
+typedef bool fattr4_offline;
+
+enum { FATTR4_OFFLINE = 83 };
+
+struct open_arguments4 {
+	bitmap4 oa_share_access;
+	bitmap4 oa_share_deny;
+	bitmap4 oa_share_access_want;
+	bitmap4 oa_open_claim;
+	bitmap4 oa_create_mode;
+};
+
+enum open_args_share_access4 {
+	OPEN_ARGS_SHARE_ACCESS_READ = 1,
+	OPEN_ARGS_SHARE_ACCESS_WRITE = 2,
+	OPEN_ARGS_SHARE_ACCESS_BOTH = 3,
+};
+typedef enum open_args_share_access4 open_args_share_access4;
+
+enum open_args_share_deny4 {
+	OPEN_ARGS_SHARE_DENY_NONE = 0,
+	OPEN_ARGS_SHARE_DENY_READ = 1,
+	OPEN_ARGS_SHARE_DENY_WRITE = 2,
+	OPEN_ARGS_SHARE_DENY_BOTH = 3,
+};
+typedef enum open_args_share_deny4 open_args_share_deny4;
+
+enum open_args_share_access_want4 {
+	OPEN_ARGS_SHARE_ACCESS_WANT_ANY_DELEG = 3,
+	OPEN_ARGS_SHARE_ACCESS_WANT_NO_DELEG = 4,
+	OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL = 5,
+	OPEN_ARGS_SHARE_ACCESS_WANT_SIGNAL_DELEG_WHEN_RESRC_AVAIL = 17,
+	OPEN_ARGS_SHARE_ACCESS_WANT_PUSH_DELEG_WHEN_UNCONTENDED = 18,
+	OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS = 20,
+	OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION = 21,
+};
+typedef enum open_args_share_access_want4 open_args_share_access_want4;
+
+enum open_args_open_claim4 {
+	OPEN_ARGS_OPEN_CLAIM_NULL = 0,
+	OPEN_ARGS_OPEN_CLAIM_PREVIOUS = 1,
+	OPEN_ARGS_OPEN_CLAIM_DELEGATE_CUR = 2,
+	OPEN_ARGS_OPEN_CLAIM_DELEGATE_PREV = 3,
+	OPEN_ARGS_OPEN_CLAIM_FH = 4,
+	OPEN_ARGS_OPEN_CLAIM_DELEG_CUR_FH = 5,
+	OPEN_ARGS_OPEN_CLAIM_DELEG_PREV_FH = 6,
+};
+typedef enum open_args_open_claim4 open_args_open_claim4;
+
+enum open_args_createmode4 {
+	OPEN_ARGS_CREATEMODE_UNCHECKED4 = 0,
+	OPEN_ARGS_CREATE_MODE_GUARDED = 1,
+	OPEN_ARGS_CREATEMODE_EXCLUSIVE4 = 2,
+	OPEN_ARGS_CREATE_MODE_EXCLUSIVE4_1 = 3,
+};
+typedef enum open_args_createmode4 open_args_createmode4;
+
+typedef struct open_arguments4 fattr4_open_arguments;
+
+enum { FATTR4_OPEN_ARGUMENTS = 86 };
+
+enum { OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION = 0x200000 };
+
+enum { OPEN4_RESULT_NO_OPEN_STATEID = 0x00000010 };
+
+typedef struct nfstime4 fattr4_time_deleg_access;
+
+typedef struct nfstime4 fattr4_time_deleg_modify;
+
+enum { FATTR4_TIME_DELEG_ACCESS = 84 };
+
+enum { FATTR4_TIME_DELEG_MODIFY = 85 };
+
+enum { OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS = 0x100000 };
+
+#define NFS4_int64_t_sz                 \
+	(XDR_hyper)
+#define NFS4_uint32_t_sz                \
+	(XDR_unsigned_int)
+#define NFS4_bitmap4_sz                 (XDR_unsigned_int)
+#define NFS4_nfstime4_sz                \
+	(NFS4_int64_t_sz + NFS4_uint32_t_sz)
+#define NFS4_fattr4_offline_sz          \
+	(XDR_bool)
+#define NFS4_open_arguments4_sz         \
+	(NFS4_bitmap4_sz + NFS4_bitmap4_sz + NFS4_bitmap4_sz + NFS4_bitmap4_sz + NFS4_bitmap4_sz)
+#define NFS4_open_args_share_access4_sz (XDR_int)
+#define NFS4_open_args_share_deny4_sz   (XDR_int)
+#define NFS4_open_args_share_access_want4_sz (XDR_int)
+#define NFS4_open_args_open_claim4_sz   (XDR_int)
+#define NFS4_open_args_createmode4_sz   (XDR_int)
+#define NFS4_fattr4_open_arguments_sz   \
+	(NFS4_open_arguments4_sz)
+#define NFS4_fattr4_time_deleg_access_sz \
+	(NFS4_nfstime4_sz)
+#define NFS4_fattr4_time_deleg_modify_sz \
+	(NFS4_nfstime4_sz)
+
+#endif /* _LINUX_XDRGEN_NFS4_1_DEF_H */

-- 
2.46.2


