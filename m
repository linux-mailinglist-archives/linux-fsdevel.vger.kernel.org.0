Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3775F7816
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 14:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJGMlC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 08:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiJGMlB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 08:41:01 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E28DCA8A9;
        Fri,  7 Oct 2022 05:40:59 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bv10so3557412wrb.4;
        Fri, 07 Oct 2022 05:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TeL0o0yVihRehcTsidItMwxwi4VSKF8819s3pNgUkoA=;
        b=BZkYYzZyw4zycnScyBtEpNLIX899gEQlS/5rsH17mcUdljcvuhkugTpSyomVciEvYd
         wKDRA11s19JcqtbScccYcptzSiMnZrLw3CS62J8Vg/sFGMNYfNVm1TyvYSs8wLPR8lbP
         As5xxidFsWEB+juHN8+HNirKyttXP1m0ctIjy61NRh/81jCm2VIVVVbNjtdl5gv9IhS7
         mj1toYktfaCJ/2SUdiBU7NyRGjd+zB/lZPSW0l0KvHUgy3FPdNIIQZ7TSTms0bXdmgUl
         7RcbIa3B9flzP7KBVwjEBzW4xsN6wAUvu13UNHwykJjuZVPojmEgAZihCB6QPLkyePq/
         YwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TeL0o0yVihRehcTsidItMwxwi4VSKF8819s3pNgUkoA=;
        b=hUOgEM4B1zV12/BHh5il7dFkJZM1BBqOV6cxCEiAEaigQ2TjCmo9791jystKkji333
         3GZQFFU7zXk6mIATBIBegTAe+A/BF68jNY7trmN1SQi5TA42IlT1h3F3u+UHWK+TqW49
         g32cagPFz0Wj0uhaym2LuBDPQhEjxoonGXDBYFBhKswPSqeIZQybP3va7txFiZGriKDT
         Hn5BF3x7oW6F8wGVJeKPk+6+8yVvblo546i4b/Lms0FYIiM9DcvaqurMTLWGZqPiL6Iw
         FN2SqDwvHk9GGPTyos15ioMoaADXAdESkp0gOaNfUp1gdYyRjAmEMi67oNNCaofhCPvs
         pTNw==
X-Gm-Message-State: ACrzQf2RBDw3i4uinhlbfQ5KcLS1/J1E1o804tQc1CLhB0QFp6RyFRR5
        2681bgIJC5mK6bwhSTAXW0E=
X-Google-Smtp-Source: AMsMyM5h2+D1e4uZKFLYgE5UyqCFtnQcMChNkepEFjKek393OI6sH7ESwap5tdOXasiNQJ6grRl5YQ==
X-Received: by 2002:adf:df82:0:b0:22c:dba0:1eff with SMTP id z2-20020adfdf82000000b0022cdba01effmr3147434wrl.13.1665146457788;
        Fri, 07 Oct 2022 05:40:57 -0700 (PDT)
Received: from [192.168.42.102] (mo-217-129-7-245.netvisao.pt. [217.129.7.245])
        by smtp.gmail.com with ESMTPSA id n11-20020a05600c3b8b00b003a540fef440sm8959584wms.1.2022.10.07.05.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 05:40:57 -0700 (PDT)
Message-ID: <89694a7f-42ba-dcbb-4eb3-b1700f21e9c9@gmail.com>
Date:   Fri, 7 Oct 2022 13:40:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: [PATCH 3/4] fs/ntfs3: add hidedotfiles to the list of enabled mount
 options
Content-Language: en-US
From:   Daniel Pinto <danielpinto52@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <536f13a9-0890-7e69-65e9-5fe1a30e04ef@gmail.com>
In-Reply-To: <536f13a9-0890-7e69-65e9-5fe1a30e04ef@gmail.com>
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

Currently, the ntfs3 driver does return the hidedotfiles mount
option in the list of enabled mount options. This can confuse
users who may doubt they enabled the option when not seeing in
the list provided by the mount command.

Add hidedotfiles mount option to the list of enabled options
provided by the mount command when it is enabled.

Signed-off-by: Daniel Pinto <danielpinto52@gmail.com>
---
 fs/ntfs3/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index c6fd2afde172..d796541e2a67 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -561,6 +561,8 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",showmeta");
 	if (opts->nohidden)
 		seq_puts(m, ",nohidden");
+	if (opts->hide_dot_files)
+		seq_puts(m, ",hidedotfiles");
 	if (opts->force)
 		seq_puts(m, ",force");
 	if (opts->noacsrules)
