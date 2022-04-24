Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D94B50D428
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Apr 2022 20:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbiDXScB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Apr 2022 14:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbiDXScA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Apr 2022 14:32:00 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04096393E8
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Apr 2022 11:28:58 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id y19so4108239ljd.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Apr 2022 11:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=4jxhZqavvbyyFAA9cfwoOFpMGSpNKkzhU/liqcH12Ns=;
        b=aeYJpl/r7cvDW8RmQYEdJePhT0DYsoiplsShgJs+OH6jf2nMlc3GAcbuWSqN71u6bp
         KZEki8Rc0ULrHLuCglVhimgSdL8s4uxA3/H4MgBB2sBbjuB7l8YGPa/EQ1jR3aelpfZY
         Iw0JQKwlNdn3/QVdH8JsUWpMgprMPwsn7S8G6YdJcbVZ+JvmyqLHUBcEmWsED1NuTuEi
         K84eYdBCGP+JhV9jl1zBTEhF0+E4cov0EfMlVhiEQwvNbZ8TuxVzRnHwTJWCGf6PSm5B
         d3ax4RQxDN5Ny3cpTS2DsZea3ukua7kLtVDOTBmC19/zejVHRnxidM3yJwyC87r6mnnw
         nHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=4jxhZqavvbyyFAA9cfwoOFpMGSpNKkzhU/liqcH12Ns=;
        b=rngvfy2xnTPuFX8vx9iSMFanLxhSlZK26X3STFHyrEG7IjTo/A5r48zPFEwwPM9kMR
         A24QB7Kh3xRKjJsx2/OdVPgQZwkrBKOxcLXLsttIPoRUKhIBxLNDbq7cYxYbKAyY0RMf
         18pgR+pWMRXjgCwMy4znG+zmk0TnESvR2rS7S8nlrAcrPMxE0x80qQ0g1tbYelMQWR7A
         ywvp8Lbr6iua/mW8WtbfQyqjd0KPjiqyDmuZxbFXyEhRqgZseLbgGaWdlpGqxG9qXBZZ
         28HiQlYAsTIu4aOzqDja90MpPNYvfhR9E6PyHOVgr+8WtDnZVSm8Qy4SHShIdmiPOnY8
         ml8w==
X-Gm-Message-State: AOAM531K2qGF9jerWZ8EMIzrw2uSEPO9CztA+QEJeJG/lN9tKPgEOH8W
        A+RP0paS8gfNtA4yV6+uqVAMYFqHgQF7lA==
X-Google-Smtp-Source: ABdhPJzDEYMz9JOqLwJeatFTQvylX3NJMYQdZGlIASIeE3R0y0H6z8vtp7VieQO/R2g67u4plY+XOw==
X-Received: by 2002:a2e:2204:0:b0:24d:cbdc:85d9 with SMTP id i4-20020a2e2204000000b0024dcbdc85d9mr8958033lji.494.1650824936092;
        Sun, 24 Apr 2022 11:28:56 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id a5-20020a195f45000000b00471feeb01cbsm422045lfj.54.2022.04.24.11.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 11:28:55 -0700 (PDT)
Message-ID: <b1b9cf79-d0a8-bb9a-5dca-42ceb74ffcbf@openvz.org>
Date:   Sun, 24 Apr 2022 21:28:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH] sysctl: minor cleanup in new_dir()
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, kernel@openvz.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Byte zeroing is not required here, since memory was allocated by kzalloc()

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 fs/proc/proc_sysctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 7d9cfc730bd4..094c24e010ae 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -978,7 +978,6 @@ static struct ctl_dir *new_dir(struct ctl_table_set *set,
 	table = (struct ctl_table *)(node + 1);
 	new_name = (char *)(table + 2);
 	memcpy(new_name, name, namelen);
-	new_name[namelen] = '\0';
 	table[0].procname = new_name;
 	table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
 	init_header(&new->header, set->dir.header.root, set, node, table);
-- 
2.25.1

