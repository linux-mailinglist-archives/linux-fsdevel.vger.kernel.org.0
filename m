Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86275F9D54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 13:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiJJLLY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 07:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbiJJLLX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 07:11:23 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E667246D91;
        Mon, 10 Oct 2022 04:11:22 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so6196347wmb.0;
        Mon, 10 Oct 2022 04:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g284Hwqas55uYSjGq3vvwN/bg9BNQaBmJr08O4Ly1GQ=;
        b=JMrM3DbAJpoWMS1inM2jvCxgnU7FfTrVT/1e7BBsGNQQamCIHKRvYy4dHvGNktfU7O
         +UhmiCq3mmKc15EGXxTZqQlhYtBO9+Ye1INyeUKOmZD0j0OdAXG61kon9s/MUSADeQOj
         2aoMHLlmXVMPi5ArvgJLNmctSUy0eCqaOsmC8Jdz/NndeaBL7dqPT7ikydXC3uLkS1Fd
         Zhu4l+qabqSRl/jVbUx6KuiHLmIHqmTJ0hy//hFb1dvm7pRjXrap+Q0WKDOn29ZyV//W
         26sOHMQdwEFJ2f79fKddOx0xtZ564VoT4jwnaDRNnSw7Qj9V6cD6ge1mJFyCDfFZXEkh
         +gJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g284Hwqas55uYSjGq3vvwN/bg9BNQaBmJr08O4Ly1GQ=;
        b=c+42HHpESEhNz45r0f//18GDa1zfRnSHsTe5nAQRMv5C69nDPBD7ZaDHM0hm+6rdY0
         oveOFHH0Fks1oWqu876Xlise+QlXN82LhGVCHWBKkA/JhiKh/4c2d/oJjOyM9A/TOZGh
         uIWdIRb1K7xNjoWzSIuN74SfiMq2uT+MvIl/wPbKYliFyySqV+q+b6lwbwjv8+oTe3e7
         kzJ051z2PwxkSFO16zoTAZKfktYm4Ck7uTcGkmjuzPt7HXwEz+qsz4lKZBjgZ3uYF48A
         q81EqncTwnWe3TkJ2ZgThPqPg71thddDNJwFB/jzzDJmTDgny9e124lnoaf8lOtt+6us
         ckvA==
X-Gm-Message-State: ACrzQf3msbahLrbitcwim+ZAYHohoge2oEnUAbQhdfUN9fW//isrkH97
        veY2qhjNC4Uf9lNJSGb+9MLngLuJss4=
X-Google-Smtp-Source: AMsMyM5+1N6+K6LeM5JpapeQokf1CUGnZeD/IoxuHXa6dPo4LFuuBYzY3FuRusstacq5MYD+DWLEWw==
X-Received: by 2002:a05:600c:3c84:b0:3b4:eff4:ab69 with SMTP id bg4-20020a05600c3c8400b003b4eff4ab69mr19158807wmb.104.1665400281061;
        Mon, 10 Oct 2022 04:11:21 -0700 (PDT)
Received: from [192.168.42.102] (sm4-84-91-228-85.netvisao.pt. [84.91.228.85])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c4ed400b003b4ac05a8a4sm22532297wmq.27.2022.10.10.04.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 04:11:20 -0700 (PDT)
Message-ID: <1b23684d-2cac-830e-88e3-1dc1c1567441@gmail.com>
Date:   Mon, 10 Oct 2022 12:11:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: pt-PT
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Daniel Pinto <danielpinto52@gmail.com>
Subject: [PATCH v2 0/2] fs/ntfs3: Add windows_names mount option
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

Changes v1->v2:
- Add documentation for windows_names mount option.

When enabled, the windows_names mount option prevents the creation
of files or directories with names not allowed by Windows. Use
the same option name as NTFS-3G for compatibility.

Daniel Pinto (2):
  fs/ntfs3: add windows_names mount option
  fs/ntfs3: document windows_names mount option

 Documentation/filesystems/ntfs3.rst |   8 +++
 fs/ntfs3/frecord.c                  |   7 +-
 fs/ntfs3/fsntfs.c                   | 104 ++++++++++++++++++++++++++++
 fs/ntfs3/inode.c                    |   7 ++
 fs/ntfs3/ntfs_fs.h                  |   2 +
 fs/ntfs3/super.c                    |   7 ++
 6 files changed, 134 insertions(+), 1 deletion(-)
