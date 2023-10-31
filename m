Return-Path: <linux-fsdevel+bounces-1634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB3E7DCC1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 12:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74BE4B20F91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 11:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789B31BDE1;
	Tue, 31 Oct 2023 11:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJgcO3uJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE1C1A73C
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 11:47:36 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AF991;
	Tue, 31 Oct 2023 04:47:35 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc58219376so15104295ad.1;
        Tue, 31 Oct 2023 04:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698752855; x=1699357655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3C17UJiVwd6DOa03RYkc0No/IhhZUWEzgYPRcFfwfdM=;
        b=EJgcO3uJFikFayJPOBxdndx2o1Y81EMmkHIhmkF42b1a6A14uoFIhsX1oUBYNEWBt4
         2iqxfqkyOo4pDcsunXaxsAxhu9Dk+Favvp8G1m8ZuW3imREFfh5UxhgQ58VA+cRIkItf
         UwafJ9/SdlRS5DM1XNuZa+DLktMdYkEsl7I7l3s29AzqgTQX/2RacolIIfIHOs1PrdBf
         wHf6W8tUQQ3EM7xZt17Q2sqxkwUYDRk0mPv9uwVd2p+sRpfEXMJjznbadfOADTnjYniX
         4SMdwIMkzXJ33Z+YN7kS1/9cIUDQ8bsNZFMMsGIkC84OFdD16lSEqppIduyCBamu7yOF
         OCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698752855; x=1699357655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3C17UJiVwd6DOa03RYkc0No/IhhZUWEzgYPRcFfwfdM=;
        b=uKPTgG+sRhBiYhx60YHO18kOQE761hAYKOlW7NvDJ6afsqXWa0pZyejE8lQCTd8Mjk
         TdvKOxL2qh27E5Nu98WNJ5PxwB37AqvkI8ssDDKqtonxmYfcr6sffWBCHs+BHI63jHYh
         aobJcoQVXuxdO28gwSBGPGMyZJVoUG1Jpr9GxbJSuAVDsE3WMMxDIqqb3qqlPDz5AwoK
         pLw08DYz+qR/b6bIFowtjwCr2mrFh80zgSsrk6owKb1Uqutyz9svFSr67okwQVY2lWwZ
         0wwygv8egHXF0WRVcUE5esBdr1CBqOa/E+2Pse7wi60ZxPUpP0uYnTD/7KcLlYs9JZBs
         p7kg==
X-Gm-Message-State: AOJu0Yzs/zESH+Sj9ljfZhk/TNW7vBT5muUZap9nGBI2ZGUeEG1YlV5T
	TYHKAl6pUD6r1FEo58cKOLs=
X-Google-Smtp-Source: AGHT+IHGD0OVTJ2k1R9HRR8YcAOyu3CWnt5QT3tNviymPi26+SleD2bMuWNlKjwZksiHiC2sIXi8dw==
X-Received: by 2002:a17:903:807:b0:1cc:2a23:cbab with SMTP id kr7-20020a170903080700b001cc2a23cbabmr10730665plb.27.1698752855137;
        Tue, 31 Oct 2023 04:47:35 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902d50f00b001c9b8f76a89sm1165904plg.82.2023.10.31.04.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 04:47:34 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
	id 98CE8819BFD9; Tue, 31 Oct 2023 18:47:31 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Yusong Gao <a869920004@163.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] fs: Clarify "non-RCY" in access_override_creds() comment
Date: Tue, 31 Oct 2023 18:47:28 +0700
Message-ID: <20231031114728.41485-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037; i=bagasdotme@gmail.com; h=from:subject; bh=u5ekTWI8pmEnF9ckTR+SSRBAZyiP/895cBZE6O+O9IE=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKkOL7585ZvKVbn7cL/DDeUtT30jX25+fFTS6/yK7z2yZ ibMSxQdOkpZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjAR810M/+MP7PR/1MgsPqcv 4avC3T+rFKT3FTvZGS9xmsPWZFZo3sjIcLQq2dJmnUTCqYzu6P4W3TMvL6w7pWnNKb59q9VrFUE mbgA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

The term is originally intended as a joke that stands for "non-racy".
This trips new contributors who mistake it for RCU typo [1].

Replace the term with more-explicit wording.

Link: https://lore.kernel.org/r/20231030-debatten-nachrangig-f58abcdac530@brauner/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 fs/open.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index 98f6601fbac65e..a89c64629aacf4 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -442,7 +442,8 @@ static const struct cred *access_override_creds(void)
 	 * 'get_current_cred()' function), that will clear the
 	 * non_rcu field, because now that other user may be
 	 * expecting RCU freeing. But normal thread-synchronous
-	 * cred accesses will keep things non-RCY.
+	 * cred accesses will keep things non-racy to avoid RCU
+	 * freeing.
 	 */
 	override_cred->non_rcu = 1;
 

base-commit: 7f680e5f256f346a5d3cd83a17c84bb6bc950008
-- 
An old man doll... just what I always wanted! - Clara


