Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A2254A986
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 08:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346571AbiFNGen (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 02:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbiFNGel (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:34:41 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBBF26133
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 23:34:40 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id e11so7757163pfj.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 23:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:references:to
         :cc:in-reply-to:content-transfer-encoding;
        bh=+jAhLK+0fRHMqQ7qoZz//CDul2lnBSp2wfTG4W3TRQY=;
        b=7Hz1hDej1YfISAhj2ghxc0GuGt9PuotmojKTh/wg//kRhsnoNxfc9Gp9LvFaBQPI0l
         YHKYhqJvGpQpbYuFf9Ot1cur89S3jnDDzRI5DBjedkjHjsxNYgtH1eED7YmCgftrJ3/R
         lELB83OmKsKTdtDVTgOjLQD9ASREJCYAHZYj1nfJXZnnny2BNlZmQ2/jf/nEUBJIuc8R
         tjYhQdvSg59dBQnJ4lkLON1lW8OrnrmDJZRFwGG7PJIqo6h0fXrx/8ZIdFd5MlOmkpYQ
         0nJ+isjUBxgLmbtEB4FvTMylSj8e/xsxS4HApXUbKCp6bpAtKgUPUHgwmFuztn90L/DM
         vCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:references:to:cc:in-reply-to:content-transfer-encoding;
        bh=+jAhLK+0fRHMqQ7qoZz//CDul2lnBSp2wfTG4W3TRQY=;
        b=s9Ud7eAFZrFp9UGnckj0EcGS6qKZuwdy2NRItH6GULNgJFDTF1VXoLKoI+dlFtlSEs
         txi/Dj9gnJGrKweZZkpvSWGaXOvC+AzHWWi5ftZMP7O0LE+rxR4kEifK9pQEJ7KaTHM4
         r3hoKZK6iYKFMmDlciex5z/AB+MQ+Cd05PC4+//8HUS0mkzGLV3yHMrUbf8rK8nnUCvD
         PRiSiyoY/u43jGNavpp3eP5hAv+nuPpHmcRsOhx+58WfvQILu00m21SajBJ+nqSsySI+
         h97+lfU0rAG4QL2Ei6+DVZIz2uYkKUpmEYEflmlHrvBrfNg38V5RVpCNxo8caSS+NmS3
         ml9w==
X-Gm-Message-State: AOAM531YixKV+3uTxoKQlNfU+LWEo9NfzEO7QyACBFhTvGo1u8tGU+z0
        trlv4MHeDYPglmSQ5rz6NMDSMSxuroTiww==
X-Google-Smtp-Source: ABdhPJwI8ptLculCXHH09zaUTB4/GIyuPN6zhr0t2oVTtpjjxCMh96Fh9i44Mib1GeyNhURAH8gs1Q==
X-Received: by 2002:a05:6a00:a21:b0:522:9134:c620 with SMTP id p33-20020a056a000a2100b005229134c620mr2891196pfh.68.1655188480394;
        Mon, 13 Jun 2022 23:34:40 -0700 (PDT)
Received: from [10.4.226.233] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id x16-20020a1709027c1000b0015e8d4eb276sm6277288pll.192.2022.06.13.23.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 23:34:40 -0700 (PDT)
Message-ID: <0ccf0d41-f080-5dde-6afb-5957e2d92a39@bytedance.com>
Date:   Tue, 14 Jun 2022 14:34:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
From:   Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH 0/1] cachefiles: Add a command to restore on-demand requests
References: <98ac6b1a-1c63-65ab-d315-7a1e38cef46f@bytedance.com>
To:     dhowells@redhat.com, Jeffle Xu <jefflexu@linux.alibaba.com>,
        xiang@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-erofs@lists.ozlabs.org, zhujia.zj@bytedance.com,
        chao@kernel.org
In-Reply-To: <98ac6b1a-1c63-65ab-d315-7a1e38cef46f@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David, Jeffle & Xiang

In production environment, process crashes sometimes occurs.

In cachefiles on-demand read scenario, if user daemon crashes,
requests will return -EIO.
User programs which do not consider this error will trap into
uncertain state.

Based on this, we came up with a user daemon crash recover scheme.
Even if user daemon crashes, the device connection and anonymous fd
will not be released. Recovered user daemon only needs to write 'restore'
to /dev/cachefiles to restore in-flight requests.

Userspace Crash Recover Demo (Based on Jeffle's User Demo)
--------------------------
Git tree:
	https://github.com/userzj/demand-read-cachefilesd.git main
Gitweb:
	https://github.com/userzj/demand-read-cachefilesd

Jia Zhu (1):
   cachefiles: Add a command to restore on-demand requests

  fs/cachefiles/daemon.c   |  1 +
  fs/cachefiles/internal.h |  3 +++
  fs/cachefiles/ondemand.c | 25 +++++++++++++++++++++++++
  3 files changed, 29 insertions(+)

-- 
2.20.1
