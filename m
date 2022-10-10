Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FC85F9D6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 13:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbiJJLQl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 07:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiJJLQd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 07:16:33 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBAC5E66B;
        Mon, 10 Oct 2022 04:16:31 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n9so1069888wms.1;
        Mon, 10 Oct 2022 04:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9giZufS4y5/shKHrpokess7OrPrf6cZViJH9fhLHRYo=;
        b=cZVy/fEQmhoCZNL+hOCJRs8BQhYwfCrMjqXDoDWz54B23MA2dTMrHXKjaOtpEGWWVz
         BfvgQeNUB8plvHgywOnLpl+4f3pM4cBM0M/1tck+LXZxnDxjuj0EmQdC6rZUCZwojrQc
         jDiPdpGpNIW5Fe7/FbHUn4QIVY9bILYdoZFcC9ylAXZO8xvfBul3N67MksH+/VgCg7bx
         s5otZaKWbkQdv2IUTapERckff4DmZ9EaVlpZGasI39Yqk0rQQo//Pvw8vW2upCDCuK7C
         7YnjVEjpfoCqaA26E8OirBZQbpARlcpYZlqe1CjUjVkQ7PQXEOxNrgjb74L3xeJvJjor
         MAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9giZufS4y5/shKHrpokess7OrPrf6cZViJH9fhLHRYo=;
        b=jmhgHtKrySDU7Zb5h/zG6+g7rAdU3lyOi5VFPUPLy5xn6kObwswUJEjlHeFDInUlnC
         2wf2eisoEjOxtXbXpbMdvJ+5SrWQO7jLk3YSzgs40+uoZqeSsJira1r/FJCXEE7LTCCX
         F9bTdOC5hoh8pwPMOrlPwvikooIyPzRpwrLYWouwLEAFKIOUI2CQ7BP5N0OkWtnQpEAj
         hxbnyg9122woAN5nwYp+T1I3kLrTmqFpAFz89fWSJLNbeNQviHDAtI9lrnqBUe9yMkGv
         QXt0KKLNKk4cXpemaCydflkFzlneYbsBngWhdn9tiIp1L0MilCI/kotxCqg+8kNLWiNe
         fabA==
X-Gm-Message-State: ACrzQf1aWYM2GgI78lCka75WXMSFD8W5KsuZBGD6WW7jMC5U1fI1MmD1
        1Amhxfe5ECmL6pjgzruwjAs=
X-Google-Smtp-Source: AMsMyM4lAU8ZnSLDHTk0XpHri2yGkuyh7WJJAXZtqmN2jC4n6EW1AnU5q9Ekt+9Frcd6B8e1eRilYQ==
X-Received: by 2002:a05:600c:3b1f:b0:3b4:b1fc:4797 with SMTP id m31-20020a05600c3b1f00b003b4b1fc4797mr19493484wms.129.1665400590309;
        Mon, 10 Oct 2022 04:16:30 -0700 (PDT)
Received: from [192.168.42.102] (sm4-84-91-228-85.netvisao.pt. [84.91.228.85])
        by smtp.gmail.com with ESMTPSA id q67-20020a1c4346000000b003c6b67426b0sm2283795wma.12.2022.10.10.04.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 04:16:30 -0700 (PDT)
Message-ID: <f9f0fd00-9881-6a3f-6534-3b97358b22d4@gmail.com>
Date:   Mon, 10 Oct 2022 12:16:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: [PATCH v2 2/2] fs/ntfs3: document windows_names mount option
Content-Language: pt-PT
From:   Daniel Pinto <danielpinto52@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1b23684d-2cac-830e-88e3-1dc1c1567441@gmail.com>
In-Reply-To: <1b23684d-2cac-830e-88e3-1dc1c1567441@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add documentation for windows_names mount option.

Signed-off-by: Daniel Pinto <danielpinto52@gmail.com>
---
 Documentation/filesystems/ntfs3.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/filesystems/ntfs3.rst b/Documentation/filesystems/ntfs3.rst
index d67ccd22c63b..cda8e0e010d4 100644
--- a/Documentation/filesystems/ntfs3.rst
+++ b/Documentation/filesystems/ntfs3.rst
@@ -75,6 +75,14 @@ this table marked with no it means default is without **no**.
      - Files with the Windows-specific SYSTEM (FILE_ATTRIBUTE_SYSTEM) attribute
        will be marked as system immutable files.
 
+   * - windows_names
+     - Prevents the creation of files and directories with a name not allowed
+       by Windows, either because it contains some not allowed character (which
+       are the characters " * / : < > ? \\ | and those whose code is less than
+       0x20), because the name (with or without extension) is a reserved file
+       name (CON, AUX, NUL, PRN, LPT1-9, COM1-9) or because the last character
+       is a space or a dot. Existing such files can still be read and renamed.
+
    * - discard
      - Enable support of the TRIM command for improved performance on delete
        operations, which is recommended for use with the solid-state drives
