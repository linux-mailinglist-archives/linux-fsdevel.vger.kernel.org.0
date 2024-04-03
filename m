Return-Path: <linux-fsdevel+bounces-16070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 590CD8978E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 21:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14CE7288005
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 19:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA49A1552FF;
	Wed,  3 Apr 2024 19:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+BsV4B+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5C0154C09;
	Wed,  3 Apr 2024 19:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712171789; cv=none; b=Uh1GlpWpO5KlPqUxobabDkOwLDdYyOkpiuubmFTxIf5J1WzVYXvKyUQFMwoR6Y8JO/XEM4fi1eJl3TEMrdmrVYXHakB8nRHJGHcQogCMIuuXS/oVjkzcf7UrjtJ0GPY5zSX5hufySaysmxlQ0bywNdqlC/8stZ0BtJacw/O8bCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712171789; c=relaxed/simple;
	bh=JsM5mkCH6HCrr21KWiyEBg8/v2IEioU5Aq4XlPGc5zg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fVYYnOEFM7M52JADt10xUZxk2l9mcqM06DxO/X0BLhfM8qG+EG8ruKYBEmAjRFXXdYMf1UkjT19o/DBbtsrXaGLJQiBKVUv16XAxhB4lMYq40vYAp8loIi+DVmGkkWtt83Gy7hR/o2QTU9zDPX+3patPt0iZICpcHyGISGE8OMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+BsV4B+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4F3C433C7;
	Wed,  3 Apr 2024 19:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712171788;
	bh=JsM5mkCH6HCrr21KWiyEBg8/v2IEioU5Aq4XlPGc5zg=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=a+BsV4B+kCslv/iESfG8GcvrWbGidFMrLxDUlHgpi7cN+bOtujc899mQ9EknVYJZp
	 7AbLj6FjjzVkDc7JTOOXNUzvXMXUPX1bTJDp0/b63ReuTo9ZnNtKHNbYoIm63z6F+L
	 rp00xhD8pTmEXYWSh/ELe9SvFIi0McXYSvE0rI7+WPutxmb+auHLP4Yd4+4k4rWRHq
	 GGnyB+gcvBMVSZglMjmfdpaSAKKtMJyYiAZbICojAUjtu9V36mbN/2xM8/fpDPNNRH
	 6kL4EuN7NWVBK/JCDJoR+sPeCxKncqyNtO8o5JLS51vziWb2+FCu1K0Acx9bJM4f1M
	 +tHsu2qF2EnOA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 41937CE0D85; Wed,  3 Apr 2024 12:16:28 -0700 (PDT)
Date: Wed, 3 Apr 2024 12:16:28 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Zhenhua Huang <quic_zhenhuah@quicinc.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH fs/proc/bootconfig] remove redundant comments from
 /proc/bootconfig
Message-ID: <f036c5b0-20cc-40c1-85f9-69fa9edd0c95@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

commit 717c7c894d4b ("fs/proc: Add boot loader arguments as comment to
/proc/bootconfig") adds bootloader argument comments into /proc/bootconfig.

/proc/bootconfig shows boot_command_line[] multiple times following
every xbc key value pair, that's duplicated and not necessary.
Remove redundant ones.

Output before and after the fix is like:
key1 = value1
*bootloader argument comments*
key2 = value2
*bootloader argument comments*
key3 = value3
*bootloader argument comments*
...

key1 = value1
key2 = value2
key3 = value3
*bootloader argument comments*
...

Fixes: 717c7c894d4b ("fs/proc: Add boot loader arguments as comment to /proc/bootconfig")
Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: <linux-trace-kernel@vger.kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>

diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
index 902b326e1e560..e5635a6b127b0 100644
--- a/fs/proc/bootconfig.c
+++ b/fs/proc/bootconfig.c
@@ -62,12 +62,12 @@ static int __init copy_xbc_key_value_list(char *dst, size_t size)
 				break;
 			dst += ret;
 		}
-		if (ret >= 0 && boot_command_line[0]) {
-			ret = snprintf(dst, rest(dst, end), "# Parameters from bootloader:\n# %s\n",
-				       boot_command_line);
-			if (ret > 0)
-				dst += ret;
-		}
+	}
+	if (ret >= 0 && boot_command_line[0]) {
+		ret = snprintf(dst, rest(dst, end), "# Parameters from bootloader:\n# %s\n",
+			       boot_command_line);
+		if (ret > 0)
+			dst += ret;
 	}
 out:
 	kfree(key);

