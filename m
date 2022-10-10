Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321A75F9DA5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 13:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiJJLcf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 07:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbiJJLcU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 07:32:20 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E7C58159;
        Mon, 10 Oct 2022 04:32:15 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a10so16535173wrm.12;
        Mon, 10 Oct 2022 04:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CGcpwMtrr4F0Rl9cO3XqszINhBjZp294W8XfrrtEik8=;
        b=Czw7WsXz6I0DhvuBx8oLZnLaTVnNrk2eYPyEIj8Jx9mSUWqqoc1uwvuJbhH67iKcKz
         NtcWdn1u6DrW2JhFsqQHnme3ignfqeUlgcHy0GOwwXU7xnTQDzfkhvGc6rxDDsfUScU/
         qcZv446AA23ofK85cz2urgiOae4tQlVoxDzYpiIcBPaKLDUteC/ycIW3kQ9O9tUZ772Q
         0AGNs9mIPAH6+vnG8rzyTMq6K6GbX7lWRuBKW/tV10n33czStFoJIohzG/g3TimIMTte
         Jvo4jAA8jtliNbD2GvaFcy02DpOzCzJQw5GswLiinjK7h0HrPsotb/Jx+f9ubHAmj818
         +jqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGcpwMtrr4F0Rl9cO3XqszINhBjZp294W8XfrrtEik8=;
        b=zHlV8reVJX8lpiQ8gBtCcO0yP3K7GZgp/HJIJ0bYUQgieQr2A3sXRYQhQ3D/HaBq6u
         6g08RlQsuUCUYiWLE6mWnjyoIiagkuMB7PN233/0cdab6Ngnfb85hfcXxPuHehT0RWAf
         ynD7lPwfYCkF7DNFNga/9Zs9VJVit9fTSnqL3eS2WV9n0M6XQDC0K5hkcnKuuR3wczlZ
         uPl7R3o0qC2QXSi/g99gGdzZgfGnTejee3jNqO0OqXJpTqmL66hgWJZjBF/aBilMBMhh
         UixUi0CKyGeK9Q0Fb88jGrGOeQgeQc0l3wRmXH394XjDyppSd8wA7oE2tJ++qJXBkwA0
         Hpyg==
X-Gm-Message-State: ACrzQf0xwIMDHh7knIFVkZBunF/kg5vQbTyojRio8NhWtHKOM/JROBIY
        C3Sc4zvdFeKqyMoyPk/fiJ0=
X-Google-Smtp-Source: AMsMyM6uVMrIO38uJtkfTAO5XLP7z6K4gFiOwMWvtXt+2oLX1fKOwCWF1vBsdrNqDwCjwQlhqQcz4Q==
X-Received: by 2002:a5d:6384:0:b0:22e:6027:9da4 with SMTP id p4-20020a5d6384000000b0022e60279da4mr10653619wru.686.1665401534087;
        Mon, 10 Oct 2022 04:32:14 -0700 (PDT)
Received: from [192.168.42.102] (sm4-84-91-228-85.netvisao.pt. [84.91.228.85])
        by smtp.gmail.com with ESMTPSA id h5-20020a5d4305000000b0022ac1be009esm8675317wrq.16.2022.10.10.04.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 04:32:13 -0700 (PDT)
Message-ID: <232b8d40-eb93-6a73-86bb-c664d7b2ccee@gmail.com>
Date:   Mon, 10 Oct 2022 12:32:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: [PATCH v2 2/5] fs/ntfs3: make hidedotfiles mount option work when
 renaming files
Content-Language: pt-PT
From:   Daniel Pinto <danielpinto52@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <9c404576-856b-6935-f2e3-c4d0749f16ea@gmail.com>
In-Reply-To: <9c404576-856b-6935-f2e3-c4d0749f16ea@gmail.com>
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

Currently, the hidedotfiles mount option only has an effect when
creating new files. Removing or adding the starting dot when moving
or renaming files does not update the hidden attribute.

Make hidedotfiles also set or uset the hidden attribute when a file
gains or loses its starting dot by being moved or renamed.

Signed-off-by: Daniel Pinto <danielpinto52@gmail.com>
---
 fs/ntfs3/frecord.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 70a80f9412f7..41a20d71562a 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3018,6 +3018,15 @@ int ni_add_name(struct ntfs_inode *dir_ni, struct ntfs_inode *ni,
 	struct ATTR_FILE_NAME *de_name = (struct ATTR_FILE_NAME *)(de + 1);
 	u16 de_key_size = le16_to_cpu(de->key_size);
 
+	/* If option "hidedotfiles" then set hidden attribute for dot files. */
+	if (ni->mi.sbi->options->hide_dot_files) {
+		if (de_name->name_len > 0 &&
+		    le16_to_cpu(de_name->name[0]) == '.')
+			ni->std_fa |= FILE_ATTRIBUTE_HIDDEN;
+		else
+			ni->std_fa &= ~FILE_ATTRIBUTE_HIDDEN;
+	}
+
 	mi_get_ref(&ni->mi, &de->ref);
 	mi_get_ref(&dir_ni->mi, &de_name->home);
