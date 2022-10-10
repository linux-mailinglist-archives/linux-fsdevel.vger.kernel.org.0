Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43ECB5F9DA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 13:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiJJLeN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 07:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbiJJLeL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 07:34:11 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C0A51417;
        Mon, 10 Oct 2022 04:34:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bp11so3826780wrb.9;
        Mon, 10 Oct 2022 04:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TeL0o0yVihRehcTsidItMwxwi4VSKF8819s3pNgUkoA=;
        b=bJkgt8XBMOYlvYMRd60SqsD5SsRRa2mD22nqQul7gLCyl3sVtJGeJak1zQE8e3Q5H/
         PMxmIeeit7bbDDmaasHyMKxQZPJ9NKiT2JVaaudImql6n0GSX98F35GMJt4q0ydiW0TA
         txD86vwQ4TRMmumInbvulZ+h0TjgEF270O6YZDGxhIH/yQCoL69sgNtp60v+dBFiYdtt
         7CuNjbJdSV/41sveFiN1ZfAM9M//seU6iBDwSx/0pH/QkPr8NDVcw9ZKloJ7NYxs3QQc
         2BgWyytVHjFQ6u9KC4jd6FBTGRS2lEpquLHkHEyMNl571mVNiEAq/yHSCvHohXGPvfbr
         wJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TeL0o0yVihRehcTsidItMwxwi4VSKF8819s3pNgUkoA=;
        b=XslQ7I7VpogQzVnhJK7yI2g/HZ4SLx8B4O912iC7jgeLlHtZynF2px9IJmYvqSSns8
         YeV4crRgPXGvF7uviisdUB7EzvJp0OprKENDUaCgbrHh2pL3jppYBAN0+Kj/s7c7TMKH
         +hnkd2vfVc89z1Mu9XyIc/oAQene5uMV6KLOgHKtWqgxeJz77R3kyJCoY2pVBjSDsSpx
         eE2fITBk1k13lVy6FwhiILdFemgnMGrjlweaT94sKP3LrnaFaFRHfmxC5VPeHR7KIrZ+
         yMSbRa+AUvdI5ux+OQEzUZZUHpvuqlgm84Xk3M+LoJwZ85Ofs4piG+NIgRHO+a8riopQ
         zKcQ==
X-Gm-Message-State: ACrzQf21pQ7VEbnS+vyfwkmCJ5s8peQPd9xjowA0e9OTCzKBOjctFPGD
        gd+UoyjgJHjJrNUBrpg+Yn4=
X-Google-Smtp-Source: AMsMyM6tGY6fRMNDLA/tSbtiGWuEd/ro4K+ih7XhEt3DRhNSFFITKmTKqGjonek1rDh8nRYdI/DpjQ==
X-Received: by 2002:a5d:490c:0:b0:22e:6545:996e with SMTP id x12-20020a5d490c000000b0022e6545996emr10729516wrq.523.1665401647825;
        Mon, 10 Oct 2022 04:34:07 -0700 (PDT)
Received: from [192.168.42.102] (sm4-84-91-228-85.netvisao.pt. [84.91.228.85])
        by smtp.gmail.com with ESMTPSA id h5-20020a5d4305000000b0022ac1be009esm8680012wrq.16.2022.10.10.04.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 04:34:07 -0700 (PDT)
Message-ID: <d9a3544f-fa02-e232-f1f1-4317138a245b@gmail.com>
Date:   Mon, 10 Oct 2022 12:34:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: [PATCH v2 3/5] fs/ntfs3: add hidedotfiles to the list of enabled
 mount options
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
