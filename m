Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859C75F9DAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 13:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiJJLfz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 07:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiJJLfw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 07:35:52 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8147D6CD37;
        Mon, 10 Oct 2022 04:35:49 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id a3so16645208wrt.0;
        Mon, 10 Oct 2022 04:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jr6QUg4W3KCMgn//RzqzYopSrHaXWN6D/2F2E2n78+o=;
        b=AsEfPf2TiJbvEz92D8N3jlqaxcRRjPXuD/oxHfnN7m+ZjrqWMdPul708x1RwSyRzEU
         qt+ioz8N1jDj/WbDAJb068bSX8UHXgUcDPF12gSzrvYYIBv4O+ievYINUZUDXSEADcBX
         BzzhbxS0aResm8dd/83NVjHxdiPUyQ7vYPqbblVk7iIsu7T27YhG620ZA2hvrW32Vaw1
         M2SBUo8ck0gfpXfavGYpG4V+aOVtaPXSRkrhAZz5XZdpKcC61r3GLd8eV4pMTL9Nnh5w
         QotnJ9y7aEuYUclBw4PrkQzfQNhhg8A0qZZZqt/ukal0qcrX+dnlOtCgqNTKKaLboaUI
         1kuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jr6QUg4W3KCMgn//RzqzYopSrHaXWN6D/2F2E2n78+o=;
        b=wpoCI02hg+qbhAGyEUeFyn7rj3TOBAQ89fRnEAoQhNVLbkOA2e/P6GXPlE8o71E82/
         xCt8H3B10+2aEriMBvxsKb0mwJB41BLBCbPaBaPE45S7Ewiaigp9z6jtwqdrYBsRu7W4
         p1ntxGUYwzwXisxWkglCS6bkA0opsXVK9N5IkJG2Ys33VRUE+aH3uo0INRV18h2hFlar
         sxHNxu35phHGyU9zg4V5tnU8tiZgRN9e59i4ijrSAl8DUtRrKd0OJtxyUbvepQOuBk64
         RDbLJP4E9IDxpid4zoNiULadGC0z4N/cuqwprLHhJbw5DPBymlCuQXK6pcleGcaoCWmD
         2OLQ==
X-Gm-Message-State: ACrzQf3HzHRrakJxmzSHVDxTE/LklnGuf3bCw6yGjUzGgNk3YalFO0WE
        0zQUNp9eBO7GVNGTXXIAeRU=
X-Google-Smtp-Source: AMsMyM45nIQ+4isA/wR9XJ47XEZguYnuBIiLPwckYxxFL6SrsVMyMMFKTBJl6gLeGNn7t14z+Shsqw==
X-Received: by 2002:a5d:4950:0:b0:230:cc5a:f6b0 with SMTP id r16-20020a5d4950000000b00230cc5af6b0mr1643870wrs.656.1665401747925;
        Mon, 10 Oct 2022 04:35:47 -0700 (PDT)
Received: from [192.168.42.102] (sm4-84-91-228-85.netvisao.pt. [84.91.228.85])
        by smtp.gmail.com with ESMTPSA id l10-20020adfe9ca000000b002286670bafasm8622031wrn.48.2022.10.10.04.35.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 04:35:47 -0700 (PDT)
Message-ID: <f6101785-aff8-aadf-8ea7-35f60668bcf8@gmail.com>
Date:   Mon, 10 Oct 2022 12:35:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: [PATCH v2 4/5] fs/ntfs3: document the hidedotfiles mount option
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

Add documentation for the hidedotfiles mount option.

Signed-off-by: Daniel Pinto <danielpinto52@gmail.com>
---
 Documentation/filesystems/ntfs3.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/filesystems/ntfs3.rst b/Documentation/filesystems/ntfs3.rst
index d67ccd22c63b..fa03165f2310 100644
--- a/Documentation/filesystems/ntfs3.rst
+++ b/Documentation/filesystems/ntfs3.rst
@@ -75,6 +75,12 @@ this table marked with no it means default is without **no**.
      - Files with the Windows-specific SYSTEM (FILE_ATTRIBUTE_SYSTEM) attribute
        will be marked as system immutable files.
 
+   * - hidedotfiles
+     - Updates the Windows-specific HIDDEN (FILE_ATTRIBUTE_HIDDEN) attribute
+       when creating and moving or renaming files. Files whose names start
+       with a dot will have the HIDDEN attribute set and files whose names
+       do not start with a dot will have it unset.
+
    * - discard
      - Enable support of the TRIM command for improved performance on delete
        operations, which is recommended for use with the solid-state drives
