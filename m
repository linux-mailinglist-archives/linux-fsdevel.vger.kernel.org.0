Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815221DCDBF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 May 2020 15:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgEUNJ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 May 2020 09:09:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55578 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727846AbgEUNJ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 May 2020 09:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590066594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0tHBgCvyZltVrN0JriCw+VgbLMlwZL8WCxbksXie0bo=;
        b=c17tgnesnqVBVo50K7DBxwy6wsjHJhVR71tC44KcRGr3RCDp24EKS9D5LcO+DcodEixby4
        Mn1giVkPiGhJ9eb4IbpgS8hcssoUGehMqjSF8PK9pjTR7Lk6G2aj47imFmjgklizXTCU9H
        K2Lir1TVLHSR8VMEZ9n/pCLzBqe4wz8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-cH8H9hgPP622hPLjK9Dncg-1; Thu, 21 May 2020 09:09:52 -0400
X-MC-Unique: cH8H9hgPP622hPLjK9Dncg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5A078014D4;
        Thu, 21 May 2020 13:09:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA365106222B;
        Thu, 21 May 2020 13:09:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] Adjust comments in linux/fs_parser.h
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 21 May 2020 14:09:49 +0100
Message-ID: <159006658996.105720.14023071485286413229.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix some comments in linux/fs_parser.h that have not kept up with the
changes.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/fs_parser.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index 2eab6d5f6736..784f4bfa2aa2 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -53,10 +53,10 @@ struct fs_parameter_spec {
 struct fs_parse_result {
 	bool			negated;	/* T if param was "noxxx" */
 	union {
-		bool		boolean;	/* For spec_bool */
-		int		int_32;		/* For spec_s32/spec_enum */
-		unsigned int	uint_32;	/* For spec_u32{,_octal,_hex}/spec_enum */
-		u64		uint_64;	/* For spec_u64 */
+		bool		boolean;	/* For fs_param_is_bool */
+		int		int_32;		/* For fs_param_is_{s32,enum} */
+		unsigned int	uint_32;	/* For fs_param_is_{u32*,enum,fd) */
+		u64		uint_64;	/* For fs_param_is_u64 */
 	};
 };
 


