Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8055F7804
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 14:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJGMgr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 08:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiJGMgq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 08:36:46 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4466DCA8A1;
        Fri,  7 Oct 2022 05:36:43 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u10so7118625wrq.2;
        Fri, 07 Oct 2022 05:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K3gXHoOtP/G7cPHnJm5sliNg7u+93Tq1/waVlo7q5Aw=;
        b=W/By9sT1B0l37Szu1oY35mVdTCtdmZkfO9z5iyy9KYOfafScHvXUDb/l9KeO8JwC1u
         5UM/ELQpZrHnNxYd5YxZUuHwaOqWl7iReJkVMzhuWM6Axsnc3/2S0mFjKyYY1mPnalmi
         w+9qZQNeeR7r/1hhLtfR1JzH9Kr4gAPI9ABearYLn7jgIWeH5eUr+HrnRpruV2CJwQlq
         y5toeuXlmvSj+DZRpQ7MOxOWWmYNnYWb0LMCAptHVfnYO+6+vxdqw5GaRZHoNFGIUrOJ
         PQpHIf+Fict0z8xe5C3YH/FZ+U+PBSm+e22NiptTdtsj1ik/mW0y+nLhYlPn51pos9Ju
         PiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K3gXHoOtP/G7cPHnJm5sliNg7u+93Tq1/waVlo7q5Aw=;
        b=UQDhL3Q0Rd0gUbLJ+2hEsuf+1NSwnaZvugBvmH26IWnbRD3ZmadvEF7bubw1SYxWcD
         KgmCrC5izDqHnewKZUp6y3KwG0wkRxlErRHUVhtFqFI9LoEte67DgyAAKtlfDDPtXCBW
         M3lPEKB067+mqRNDR15H5LYAJR70/aQ/FGdDF4B+tDkgv0tHlQo1mEnzOX0ndczUYtzy
         hv9Su2sBNVTAgKLhUT6cm3GlGeGz+xJ5BNy5QesdR9Dtkhkls2IjQ1M6dL2UA29FEnMJ
         7bPULuPS34Sdwb3muaZdS+JJxTMaXRolqDxRIED83ENb9OZMbvwfPQuiiHAQ2ynTe147
         cPTw==
X-Gm-Message-State: ACrzQf09AXpFIlpnzLpduyfHIs+R+Lvd4Chlf7zsbXpUD6DITjmR7HRM
        g73qmaUSr0f15LWh7c/HjCd6UnPEHUE=
X-Google-Smtp-Source: AMsMyM5ejhzR9Km12OJn+zM8m9X1QRG6cw2SCRQv+JKQ3MdO2sPDGxOL3MmOuOFz9awJ1yci7zxScw==
X-Received: by 2002:adf:d4cb:0:b0:22e:489d:e0e3 with SMTP id w11-20020adfd4cb000000b0022e489de0e3mr3228129wrk.653.1665146201846;
        Fri, 07 Oct 2022 05:36:41 -0700 (PDT)
Received: from [192.168.42.102] (mo-217-129-7-245.netvisao.pt. [217.129.7.245])
        by smtp.gmail.com with ESMTPSA id bt7-20020a056000080700b0022e62529888sm2049929wrb.67.2022.10.07.05.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 05:36:41 -0700 (PDT)
Message-ID: <ca14dc16-a00e-bff3-500f-4c9227a30674@gmail.com>
Date:   Fri, 7 Oct 2022 13:36:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: [PATCH 1/4] fs/ntfs3: fix hidedotfiles mount option by reversing,
 behaviour
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
