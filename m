Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F055F9D98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 13:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbiJJLa1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 07:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiJJLaU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 07:30:20 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349B55141F;
        Mon, 10 Oct 2022 04:30:17 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so6213450wmb.3;
        Mon, 10 Oct 2022 04:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K3gXHoOtP/G7cPHnJm5sliNg7u+93Tq1/waVlo7q5Aw=;
        b=Dc2nT/4q8/jBUtQ7KRFrVaRYynz7726UdERw2EVrft35KrVuLTb7nmRSMT8vSSO+0r
         WvZEzNZUg7yVN9JxcxHbahdTc3OVbtvsQM3OuvdXpC2zXIPZJW8MibYM79tnGacCUh/h
         7Key3Bbpt8SVl9iwM3aFWGrDBcRRMOH3sOP1NkH1zLNWa1h+4YSro/BoBW+/JWDE5f/G
         Y3dyaUck1t05h/fAKhiO8YXgwSpEbumBxWY7aQ2C6YWY+nex5rqsUrGnJdY2fo+HC6zd
         d/E+rGpVFGHE9C+B7PHpunITjgA3qIfup5hP028D9qDgCRbAt+y7G8ewp6ZHnl20xs77
         S7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K3gXHoOtP/G7cPHnJm5sliNg7u+93Tq1/waVlo7q5Aw=;
        b=Iz/7UoE1PgjY8YVkc+Di8r57X6YfF5O7QQJWl8IBJTnjsxB/O3BDj1SsTJ/VAyMp4M
         t6Ejcl9yydI7Wat36rOq0V8kKksIcISdV/9j2ACseKZAhusgI+990Xo55irbt+Klhxll
         4bXZAKIH3lJ0zODZVKcDLAlrOSf2MA4yZsGB/J6VvTgqgam2mPvih+QlnzphiEPQqM78
         VHe1bCkSMLyPA/NlNEestrFo0KfeDGSovzGBRfEk5KP//ViXl52M/oHygNWDPgNNcbtO
         +Oo6nsbmOAtduCxMZ+stQi+Z2j5IqUTAe0Ml1OcfbmcnkpP1zygQiTfkGd05unZknUFi
         yYoA==
X-Gm-Message-State: ACrzQf2ebSK5SRSICK0BLdZ1fQfxypafha6qFT/QLzZQk7ZCxFk04DAQ
        zCvL8TpTaVNbuBEHp1ErxXg=
X-Google-Smtp-Source: AMsMyM7tOmkCJQGYoo8JZxnb/78cJD3WnQS0D3xmyynREYxFhKOPx4l/iKu4rWoyju7dzol8rwaPGQ==
X-Received: by 2002:a05:600c:221a:b0:3b4:75b8:3f7f with SMTP id z26-20020a05600c221a00b003b475b83f7fmr11998187wml.175.1665401416375;
        Mon, 10 Oct 2022 04:30:16 -0700 (PDT)
Received: from [192.168.42.102] (sm4-84-91-228-85.netvisao.pt. [84.91.228.85])
        by smtp.gmail.com with ESMTPSA id t128-20020a1c4686000000b003b4a699ce8esm7713297wma.6.2022.10.10.04.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 04:30:16 -0700 (PDT)
Message-ID: <51c60bcf-82a0-efbf-438d-4925c905503e@gmail.com>
Date:   Mon, 10 Oct 2022 12:30:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: [PATCH v2 1/5] fs/ntfs3: fix hidedotfiles mount option by reversing
 behaviour
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

Currently, the hidedotfiles mount option is behaving in the reverse
way of what would be expected: enabling it disables setting the
hidden attribute on files or directories with names starting with a
dot and disabling it enables the setting.

Reverse the behaviour of the hidedotfiles mount option so it matches
what is expected.

Signed-off-by: Daniel Pinto <danielpinto52@gmail.com>
---
 fs/ntfs3/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 1e2c04e48f98..c6fd2afde172 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -359,7 +359,7 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
 		opts->nohidden = result.negated ? 1 : 0;
 		break;
 	case Opt_hide_dot_files:
-		opts->hide_dot_files = result.negated ? 1 : 0;
+		opts->hide_dot_files = result.negated ? 0 : 1;
 		break;
 	case Opt_acl:
 		if (!result.negated)
