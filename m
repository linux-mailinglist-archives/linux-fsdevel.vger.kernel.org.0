Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0A3342915
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 00:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhCSXMk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 19:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhCSXMJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 19:12:09 -0400
X-Greylist: delayed 199 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 19 Mar 2021 16:12:06 PDT
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de [IPv6:2a01:238:400:100::c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAFAC061760
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 16:12:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1616195165; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rBBL2LXqxWxT3SP2/NUPTDKmcxcjQrS6Et8IZsmjOUlgrFF47hJJiL1TuXZ5/GMMOW
    RFzctnKsP14BEQqGtp5KzLFxlwYqqpRgh6VzyeARk/8ymxUlz66Tw6vNczK92nAiEpIz
    2LJJQsM9wZZetqJrK9Pr4RAvrSp1qFz+hDtTpVAKoGOpiVK41p9v/18ykGe3nbAi9PtT
    X688G+t7b+10u5Y+0cZxsEivkASrxtMAPd8xb3s1x//+IFerVwS/hgL/feoiR9IN3TIM
    kbb5W37CBdO2hCzX42aBP0DlkMTQTOtNymHh9K/z9rMi0YdD7rn9Xj93wJrfrz3szj8K
    W5lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1616195165;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=10ocK1xc4e0dW1IfGLa5MXYEmDR1IRDCmJNBWSjcWnE=;
    b=KePyDc6hBnwx4cHzw2DHN52cKzBeZHUWmKNvfoGFl/pTilgaY3bSg9EHtsTBWRjcSA
    7H/UJSdCO/+cJHJqdNv81G9+ooNB0XqxXU5ZCPjNBIhV6gBTzlJJQRvCDXKlkkwfd5OD
    TsMNmeTO6eIAgTIi9AyZc6jrTX1L1pQTW4+M4RkaN2MWnxZavSzveN2UDQGfx68ZMiA8
    cagcU/mSbpnt0XIpu/uatUt2x3zWQKhj2dMjjUYf6zSTlWEhmZ54CyVu9hlVnEZranvc
    DZ5iyqO7p1JKGI1ducH3GhIoqwQ5AMzbToycJgdaVbX+IrpHEpSQb67polWjvxpUwkj5
    b0eQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1616195165;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=10ocK1xc4e0dW1IfGLa5MXYEmDR1IRDCmJNBWSjcWnE=;
    b=PxESum/sCTAD9ZLz/vXKDeMZJZtT6V+QpCVWG5doGcNyPeD3EzqZtXwDyc74A3v5XA
    GXdDueQb0t/be+KUKaLFMAlFwfMXH2jRyyDYwImidg6B8TYuVSsJnMbIGYuqfLvK5f3a
    pJlizXGcwsSUSvtzWfggATLsuXIgfm1PY0AESXlwHSJfnHh8V0SspPJHIMbNhR+Tg0C2
    jFVcfusnbIieKhy/WIITqkwMyhlaYVtnhxrnkfcD90atoiBntlAsNTeF12XRt4RY9KoY
    9dPzhWETQk1rOGXoj4oijqlKJncQVCM7z44qOhZjJmENUqn6v0DpmLLPlaMf29S5GYBL
    8xwA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzBW/OdlBZQ4AHSS325Pjw=="
X-RZG-CLASS-ID: mo00
Received: from sender
    by smtp.strato.de (RZmta 47.21.0 SBL|AUTH)
    with ESMTPSA id k0a44fx2JN64CNJ
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 20 Mar 2021 00:06:04 +0100 (CET)
From:   Olaf Hering <olaf@aepfle.de>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Olaf Hering <olaf@aepfle.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v1] binfmt: check return value of remove_arg_zero
Date:   Sat, 20 Mar 2021 00:05:53 +0100
Message-Id: <20210319230554.11991-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation to build with -Werror=unused-result, use remove_arg_zero properly.

Fixes commit b6a2fea39318e43fee84fa7b0b90d68bed92d2ba

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 fs/binfmt_em86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_em86.c b/fs/binfmt_em86.c
index 06b9b9fddf70..5b1c02a0250f 100644
--- a/fs/binfmt_em86.c
+++ b/fs/binfmt_em86.c
@@ -63,7 +63,8 @@ static int load_em86(struct linux_binprm *bprm)
 	 * This is done in reverse order, because of how the
 	 * user environment and arguments are stored.
 	 */
-	remove_arg_zero(bprm);
+	retval = remove_arg_zero(bprm);
+	if (retval < 0) return retval; 
 	retval = copy_string_kernel(bprm->filename, bprm);
 	if (retval < 0) return retval; 
 	bprm->argc++;
