Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9A45F77F9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 14:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiJGMc0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 08:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJGMcZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 08:32:25 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E589C09A0;
        Fri,  7 Oct 2022 05:32:24 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so2510579wmb.3;
        Fri, 07 Oct 2022 05:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWxMysi2/3NJWXxgKPp/Nbbb+bbU2AmdShH4qAYKTNU=;
        b=GBk+e/ZbyR9pyYD92T8WZXqcfpv0AYJdivhb9bP37beyU5deYRHWOSvZJoKxHKA+w8
         +8kefxZBKK0EQSlqogTLCVSEvETxznxQ474tJsi7StHDRe0QuTBBGeI3jMppQ3ZkD0d4
         2380BcgpJ5qv4Eg2jEYcaE0ZprVNQXqH74zbYgxtpqdNOSQcy0/OAH2Nym8/R7aswuGr
         BysKs9S6+Y9ctd/PwvikDg+tUUktftVA6UiKFHi8KTlCVblgdYYLeEcAH+zW7unrRo8h
         M7sbz+8uNkbrjyaFoGxzhmDpLfOXf2QM/VScVHM7wmklUDnlni08keP0sXTR+XuNK5vE
         xKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fWxMysi2/3NJWXxgKPp/Nbbb+bbU2AmdShH4qAYKTNU=;
        b=WFhztuil+st3BZ5M3IElX8xBDKYTBHzSTIdmtXmr0Dka0rHk9ztVIGjjhzoKRzlUPy
         qsaFfIKqH7xxDbK3tsqLMymTWtwT3IwlYtsuFmY9fzKZNTm6qz8kj9xqlFizcKPPNsOF
         cIh3L13y9QqCHT3xx+ectbKhxyRagNG9VDrDCdCu+W66/G0ScIzYkl8gOurDJdj1i2EX
         BEfLQWwduiW0prtIoLlnWD3DOPcqE6DF4unjJP84tMb8f8LLy5I5JknwchNiND/oICyH
         DY57pCZkihR+IWOBvKQKNWDRKSPNj67EzysC5Oy3MpSxqSRUl/jXIcOrf8gKZoi2f50T
         gabQ==
X-Gm-Message-State: ACrzQf0V73yEJD8rCc0RWlPFKeHPM1acXvEwYXLYCywo8KGiO2gFrToH
        Tk8Q4+QKShscwzzew99ycbY=
X-Google-Smtp-Source: AMsMyM40/cmUUKJSQhA9fKALLFjxRz2K05UOQV4IUgHzZ06EpuiOTvvXYNAbMOwT4laroryKKHnWtQ==
X-Received: by 2002:a05:600c:3483:b0:3b4:99f4:1191 with SMTP id a3-20020a05600c348300b003b499f41191mr3000557wmq.147.1665145943067;
        Fri, 07 Oct 2022 05:32:23 -0700 (PDT)
Received: from [192.168.42.102] (mo-217-129-7-245.netvisao.pt. [217.129.7.245])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c154b00b003a3442f1229sm9002422wmg.29.2022.10.07.05.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 05:32:22 -0700 (PDT)
Message-ID: <536f13a9-0890-7e69-65e9-5fe1a30e04ef@gmail.com>
Date:   Fri, 7 Oct 2022 13:32:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Daniel Pinto <danielpinto52@gmail.com>
Subject: [PATCH 0/4] fs/ntfs3: Fix and rename hidedotfiles mount option
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

The current implementation of the hidedotfiles has some problems, namely:
 - there is a bug where enabling it actually disables it and vice versa
 - it only works when creating files, not when moving or renaming them
 - is is not listed in the enabled options list by the mount command
 - its name differs from the equivalent hide_dot_files mount option
   used by NTFS-3G, making it incompatible with it for no reason

This series of patches tries to fix those problems.

Daniel Pinto (4):
  fs/ntfs3: fix hidedotfiles mount option by reversing behaviour
  fs/ntfs3: make hidedotfiles mount option work when renaming files
  fs/ntfs3: add hidedotfiles to the list of enabled mount options
  fs/ntfs3: rename hidedotfiles mount option to hide_dot_files

 fs/ntfs3/frecord.c | 9 +++++++++
 fs/ntfs3/inode.c   | 2 +-
 fs/ntfs3/super.c   | 6 ++++--
 3 files changed, 14 insertions(+), 3 deletions(-)
