Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726C86FC9F4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 17:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbjEIPM2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 11:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjEIPM1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 11:12:27 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECE94487
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 08:12:26 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-760dff4b701so37536639f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 May 2023 08:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683645146; x=1686237146;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vGmB2fwn2Slv3KDaoYeib3ycyBiAUda5CL4vke5Wr4=;
        b=BCp4OZCJK86rxFQiR7JpsNIO5dus0EyJe4WnCQubjdNRgjS4fOFo0per5wpk0qqkay
         rusDHNTaNgfLw2V3tdgTzhSuEZBBCuEwKgTMGa3PMRh5cwA4rWzdBBBi0cPCzy8U+Aoa
         jf/CDRgabPYT8S0ohYF0UfkwzwIXZlCT5qRhr0bx7BPYAn+qpXMT6rlRcFr1ivyCCul7
         1bkPnPVxNs2SAGRjK95LBgZGRqmAmKQFwhGSXYuwrHNfVwZV3OfmjsL4U7Sajd+S2eI0
         ldlL598/2WU4OvHDQ+zEwwz6/8LplFn9+bg3FmSx+xxmCVuYjU7chRRN9Pd5yui26kBX
         GXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683645146; x=1686237146;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8vGmB2fwn2Slv3KDaoYeib3ycyBiAUda5CL4vke5Wr4=;
        b=WLKsjppRrgbDrpXrT4fRuirjewAzVtPm/NVZoy22UAppFzkQKwDiGDI6713gF/gXSW
         PCPu4EpsZLRXqiXzzgN9PWk7a5snSXMQRMnj06mMWJBU6nvwo4/cU2Vbw3XfWT5F88r6
         LC/lT9JH6DayJEckS8hwpuOxzCfyppw1vDsZ7pWATYAZVQZfWH1k0kVwK75q8YJmXWy1
         CZhVCdt7nTzuGYcSwkKjr938euytaVuIaJOENkrr/ddnxd/aVDsWtO2NCOYZWolw1ky6
         X0ZruQtI/SaJVf3JEQBvdG3F3yWjH90zRPYiYrIG1Z28m1fSgaPN1RDAIy5w0fSn9s/I
         +tIg==
X-Gm-Message-State: AC+VfDyATTMLMzg3y6MdYWM1jxPCKveL26Hbh7xIKfE6HyVxYDE8j0qC
        7MI4v6TmuCCEDqDU5SmGN7+4CkaAalOIM55ZdQA=
X-Google-Smtp-Source: ACHHUZ7aW9vAqMEwntu7U5w2EsZ+dKpPNZn3TXT7JdsQMDEModbNVzsYttHyFtGfqetYlxZ7ojIr+A==
X-Received: by 2002:a05:6e02:52d:b0:332:f7a:4347 with SMTP id h13-20020a056e02052d00b003320f7a4347mr6666442ils.3.1683645145905;
        Tue, 09 May 2023 08:12:25 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id z2-20020a92cb82000000b0032b3a49d5fdsm3152501ilo.75.2023.05.09.08.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 08:12:25 -0700 (PDT)
Message-ID: <e5946d67-4e5e-b056-ba80-656bab12d9f6@kernel.dk>
Date:   Tue, 9 May 2023 09:12:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] pipe: check for IOCB_NOWAIT alongside O_NONBLOCK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pipe reads or writes need to enable nonblocking attempts, if either
O_NONBLOCK is set on the file, or IOCB_NOWAIT is set in the iocb being
passed in. The latter isn't currently true, ensure we check for both
before waiting on data or space.

Fixes: afed6271f5b0 ("pipe: set FMODE_NOWAIT on pipes")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

With the pipe nonblock rework, these two hunsk from one of the other
patches was inadvertently dropped. We obviously need to check both,
or files without O_NONBLOCK but IOCB_NOWAIT set in the iocb will still
block on space/data when writing/reading to/from a pipe.

I can just include this in the io_uring changes as it directly impacts
io_uring (breaking a few test cases), or you guys can queue it up on
the VFS side. Would be great to get this in -rc2 as it's stalling
the regression testing with the vanilla kernels.

diff --git a/fs/pipe.c b/fs/pipe.c
index ceb17d2dfa19..c88611c612ba 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -342,7 +342,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 			break;
 		if (ret)
 			break;
-		if (filp->f_flags & O_NONBLOCK) {
+		if (filp->f_flags & O_NONBLOCK || iocb->ki_flags & IOCB_NOWAIT) {
 			ret = -EAGAIN;
 			break;
 		}
@@ -547,7 +547,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 			continue;
 
 		/* Wait for buffer space to become available. */
-		if (filp->f_flags & O_NONBLOCK) {
+		if (filp->f_flags & O_NONBLOCK || iocb->ki_flags & IOCB_NOWAIT) {
 			if (!ret)
 				ret = -EAGAIN;
 			break;
-- 
Jens Axboe

