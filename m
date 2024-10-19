Return-Path: <linux-fsdevel+bounces-32410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 381D99A4BC1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 09:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9BCF1F2352A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 07:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FA51DDC2E;
	Sat, 19 Oct 2024 07:17:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BC71CC15E;
	Sat, 19 Oct 2024 07:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729322261; cv=none; b=ov3Q/QA4e8UVTAGnzK+liOkh5HnW5f++O76jnxAvv5/wltfHJ/k6+8ePN9HOMJVnFxH7bKRAo5tfZ2b8zFH5l0dyrG6mYYHBoe7YZ+eeHKSF0tAqwWyTTwfX5HbqyHn2oa/2cnXcF5qktPzHCUVGLZOciSj5eygBi7y2r3mETns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729322261; c=relaxed/simple;
	bh=pjx16WCMw/sQrrsCxHRbpEFWf5y2yLaA1KolqpC+Wjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FrNcKTKvELEV3uM1FX6x0gKWKo2T4gi/R4E8w8l4Fi4xdqM/v08jZZNDCHlSwNdKIcI7g2TP4jEuVbn3SdjF426cBIG5yM/W9B2Ah5PWKQ5jTm7wYTtw9I668Qoe15nqZCyLZHcvTCEqouKCJMFc2D40dCQ24xGvKjH4kQlKiPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com; spf=none smtp.mailfrom=chenxiaosong.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chenxiaosong.com
X-QQ-mid: bizesmtpsz10t1729322168tw3qsh
X-QQ-Originating-IP: Eh4zX456hZMGcfuxgcpGlK9/0p8Mh8Jxw52RkerpuR4=
Received: from sonvhi-TianYi510S-07IMB.. ( [116.128.244.171])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 19 Oct 2024 15:15:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3942789612294147170
From: chenxiaosong@chenxiaosong.com
To: corbet@lwn.net,
	dhowells@redhat.com,
	jlayton@kernel.org,
	brauner@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	trondmy@kernel.org,
	anna@kernel.org,
	chuck.lever@oracle.com,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH 1/3] Documentation: nfs: idmapper: keep consistent with nfsidmap manual
Date: Sat, 19 Oct 2024 15:15:37 +0800
Message-Id: <20241019071539.125934-2-chenxiaosong@chenxiaosong.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019071539.125934-1-chenxiaosong@chenxiaosong.com>
References: <20241019071539.125934-1-chenxiaosong@chenxiaosong.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:chenxiaosong.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: M3ziZXKDk+iOsjm9mH5d8oiRCkBzKEtIIucugsMBUMQ55Qpcs0Vu5/nF
	jh380GYPkKGRjKRY+9KiCfo+R6eo86AcouDlMcp9K5VgCvz4eCjNENksuVdC2CRie94Mn9G
	5WTszOitSep0BTjrWXb/48bVXlUCXCyycTG1JiXcyU6kYK94m2qVPnaP6UXMi680/2DGMKd
	2TExRoJGs1KCkFTO9Q5oXx5x65VVI2cXCi5AUvpGSyVjGTZTpgbMEdakLlW/ypicWcDN9qG
	edBBTVjdGN+XDVlTTFZAIMpmB5fk9GsxHy+LF7XWohk4TbykhZ43cyNWaAFJGMNLx1lSTZS
	ULb6wynlDG09NO2fNBR5GXOJr+Lgq68WTC7SOKguspcb5ZkBvS7ocxY/pQBC1WRUfq9IQBf
	V3Nm+SMY9jJlqWasK/cCMRhHpvwFV3yULijxq7y0Jqns5bC/E+zXsfYQ15+fZfuTVZG7V8F
	uIOhEEGi0BdtBF7RNwEXIJ7K5DF2NCaR0LKp/gXIgtuTTWy2SCniOeMZV5CncWP3KByQXRT
	n9y4vLBs70+FPYfkXYvHfFY8ubXPj8t/zxAlu2d2rwIEx/ca+rm5FriKJn0/38xlgvtYX87
	nygNGL6q+AQrVJbvw9+FGMvTgxQUmlhbO6Or9PC0cAC+F2WDr8V66TZ/VcaB6KV/kcvixjm
	yneJ5V2k56faGXsfT0+StU54YmGk4wQs6TDcdNHRKDS9vL0h3NRrbedqjQZumtExacx2NLP
	a/zgEEdOyx2DZVMdJjtfNlFa90uVu8KufV4cDx653xwFyraHlJO0CV/rjAv9G4QaHliuSZK
	85BH3vEfj9qgcCJ9P2/NgoxJSvKG4Z2BSbjyJM161cct7qJhUbw8ayxrjjWCDERjIdcLI4a
	4tabA75lY9EW3VLuD6/nIcSfumGnzU/Lem+6miMkkkt6O0Gje0ZDubKmZ+qFHLKoWBeqNx4
	zaXmtwCwACQK6LE3+tGYOVswiHtA2V1K5uPc=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

The usage of `nfsidmap` has been updated(e.g., use `-t 600` set the
expiration timer), keep it consistent with nfsidmap manual (Link[1]).

Link[1]: https://git.kernel.org/pub/scm/linux/kernel/git/rw/nfs-utils.git/tree/utils/nfsidmap/nfsidmap.man
Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
---
 Documentation/admin-guide/nfs/nfs-idmapper.rst | 59 ++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/Documentation/admin-guide/nfs/nfs-idmapper.rst b/Documentation/admin-guide/nfs/nfs-idmapper.rst
index 58b8e63412d5..0b72fd3a38af 100644
--- a/Documentation/admin-guide/nfs/nfs-idmapper.rst
+++ b/Documentation/admin-guide/nfs/nfs-idmapper.rst
@@ -24,55 +24,60 @@ Configuring
 ===========
 
 The file /etc/request-key.conf will need to be modified so /sbin/request-key can
-direct the upcall.  The following line should be added:
+properly direct the upcall. The following line should be added before a call to
+keyctl negate:
 
-``#OP	TYPE	DESCRIPTION	CALLOUT INFO	PROGRAM ARG1 ARG2 ARG3 ...``
-``#======	=======	===============	===============	===============================``
-``create	id_resolver	*	*		/usr/sbin/nfs.idmap %k %d 600``
+.. code-block:: none
 
+	#OP	TYPE		DESCRIPTION	CALLOUT INFO	PROGRAM ARG1 ARG2 ARG3 ...
+	#======	===============	===============	===============	===============================
+	create	id_resolver	*		*		/usr/sbin/nfsidmap -t 600 %k %d
 
-This will direct all id_resolver requests to the program /usr/sbin/nfs.idmap.
-The last parameter, 600, defines how many seconds into the future the key will
-expire.  This parameter is optional for /usr/sbin/nfs.idmap.  When the timeout
-is not specified, nfs.idmap will default to 600 seconds.
+This will direct all id_resolver requests to the program /usr/sbin/nfsidmap.
+The -t 600 defines how many seconds into the future the key will expire.
+This is an optional parameter for  /usr/sbin/nfsidmap  and  will default to 600
+seconds when not specified.
 
-id mapper uses for key descriptions::
+The idmapper system uses four key descriptions:
 
-	  uid:  Find the UID for the given user
-	  gid:  Find the GID for the given group
-	 user:  Find the user  name for the given UID
-	group:  Find the group name for the given GID
+.. code-block:: none
 
-You can handle any of these individually, rather than using the generic upcall
-program.  If you would like to use your own program for a uid lookup then you
-would edit your request-key.conf so it look similar to this:
+	  uid: Find the UID for the given user
+	  gid: Find the GID for the given group
+	 user: Find the user name for the given UID
+	group: Find the group name for the given GID
 
-``#OP	TYPE	DESCRIPTION	CALLOUT INFO	PROGRAM ARG1 ARG2 ARG3 ...``
-``#======	=======	===============	===============	===============================``
-``create	id_resolver	uid:*	*		/some/other/program %k %d 600``
-``create	id_resolver	*	*		/usr/sbin/nfs.idmap %k %d 600``
+You can choose to handle any of these individually, rather than using the
+generic upcall program.  If you would like to use your own program for a uid
+lookup then you would edit your request-key.conf so it looks similar to this:
 
+.. code-block:: none
+
+	#OP	TYPE		DESCRIPTION	CALLOUT INFO	PROGRAM ARG1 ARG2 ARG3 ...
+	#======	===============	===============	===============	==========================
+	create	id_resolver	uid:*		*		/some/other/program %k %d
+	create	id_resolver	*		*		/usr/sbin/nfsidmap %k %d
 
 Notice that the new line was added above the line for the generic program.
-request-key will find the first matching line and corresponding program.  In
-this case, /some/other/program will handle all uid lookups and
-/usr/sbin/nfs.idmap will handle gid, user, and group lookups.
+request-key will find the first matching line and run the corresponding program.
+In this case,  /some/other/program  will  handle  all  uid lookups,
+and /usr/sbin/nfsidmap will handle gid, user, and group lookups.
 
 See Documentation/security/keys/request-key.rst for more information
 about the request-key function.
 
 
-nfs.idmap
+nfsidmap
 =========
 
-nfs.idmap is designed to be called by request-key, and should not be run "by
+nfsidmap is designed to be called by request-key, and should not be run "by
 hand".  This program takes two arguments, a serialized key and a key
 description.  The serialized key is first converted into a key_serial_t, and
 then passed as an argument to keyctl_instantiate (both are part of keyutils.h).
 
-The actual lookups are performed by functions found in nfsidmap.h.  nfs.idmap
+The actual lookups are performed by functions found in nfsidmap.h.  nfsidmap
 determines the correct function to call by looking at the first part of the
 description string.  For example, a uid lookup description will appear as
 "uid:user@domain".
 
-nfs.idmap will return 0 if the key was instantiated, and non-zero otherwise.
+nfsidmap will return 0 if the key was instantiated, and non-zero otherwise.
-- 
2.34.1


