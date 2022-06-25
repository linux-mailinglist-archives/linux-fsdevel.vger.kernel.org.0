Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1916155AA1E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jun 2022 14:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbiFYMtB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jun 2022 08:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbiFYMtA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jun 2022 08:49:00 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7520F17AA5
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jun 2022 05:48:59 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id p14so4867777pfh.6
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jun 2022 05:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=4xBYgBhSuEsq9ZZe/IswQWwloxjZZr9dDqsNSPWfFj8=;
        b=Z9greU1+mePPI1ki1Bg4bcqglJBPo7v/+F5xNbg3SuzLFcbzNGbDhGANzi6KfDNSDc
         hxmP/TqxlHtj7Q+rEWSWwiCH8+eQ24bEaL2nQBQVWE3nCp5FiUWVJJue7q7XHDPbBS2H
         aiLOUXg4z7NaO9hQbXTP60FgG5p0oU0r1awJUzzR1KJJF9QovHKRbDv6576c35guxdyn
         M2VcjfF9+6U/XqPPS9rvs7QPH7ow2pSPp4LXQLPSlffmdAT375zx+W+p0e7vPk4B+gFL
         Kb7YxTHzEyj1aOS3Q7VBHbi1W2ANcEw3RSWWwInKkfUOozvEB6TtkF8z68JiWrntydB0
         dc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=4xBYgBhSuEsq9ZZe/IswQWwloxjZZr9dDqsNSPWfFj8=;
        b=l9kUKX3fA8BhzYxy12zbmYkjIYjy0V6LLZmwyLNyWqn0xEIpYUtjyFV+Q+AqW587Bg
         v6ZGYtW/vOiSuC5e1ja2OQ1dfk0F6PljcT662njPXCyvQ6Ulkmd5CCPf3tnErMMhiKKg
         D1oQGdimgns92uFciUhXDiZZQz/JaRGWao8TqVHHMbOoaHWRz767F5T66BhaK9j/h8Me
         tXzg7IeUu0FZqUl+gN71pbRh+vduj7GC1m9pLQrIPfTc7iHkf6vtRHXZJQRYeNuEc7KZ
         3/CVzR+fYNhWo7J/AjWCJBE35ueK2o3GO4qTlHNMj2bm3RPeMz0TcpGGUm/DnNqFCEVd
         wktg==
X-Gm-Message-State: AJIora8OAo7wl/iS6Pm2GbwD+ms/Y4f6rhhA18bNs1mQ2xMQ76UrRSk7
        LZac2IaoklLMaPw2kL8COpKWIGlvXaM4LQ==
X-Google-Smtp-Source: AGRyM1t6yZgvSz7PHkkloiTL8IY85na6KGvKbM4AMqMN7D97HK1lmys+JJAmfWkix+o+R4Tkr2tdlw==
X-Received: by 2002:a62:1687:0:b0:50d:3364:46d4 with SMTP id 129-20020a621687000000b0050d336446d4mr4418880pfw.74.1656161338645;
        Sat, 25 Jun 2022 05:48:58 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c8-20020aa79528000000b00525135bd555sm3580418pfp.162.2022.06.25.05.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 05:48:58 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org, kernel-team@fb.com,
        shr@fb.com
Cc:     david@fromorbit.com, jack@suse.cz, willy@infradead.org,
        hch@infradead.org
In-Reply-To: <20220623175157.1715274-1-shr@fb.com>
References: <20220623175157.1715274-1-shr@fb.com>
Subject: Re: (subset) [RESEND PATCH v9 00/14] io-uring/xfs: support async buffered writes
Message-Id: <165616133761.54036.18358524155859182075.b4-ty@kernel.dk>
Date:   Sat, 25 Jun 2022 06:48:57 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 23 Jun 2022 10:51:43 -0700, Stefan Roesch wrote:
> This patch series adds support for async buffered writes when using both
> xfs and io-uring. Currently io-uring only supports buffered writes in the
> slow path, by processing them in the io workers. With this patch series it is
> now possible to support buffered writes in the fast path. To be able to use
> the fast path the required pages must be in the page cache, the required locks
> in xfs can be granted immediately and no additional blocks need to be read
> form disk.
> 
> [...]

Applied, thanks!

[13/14] xfs: Specify lockmode when calling xfs_ilock_for_iomap()
        (no commit info)
[14/14] xfs: Add async buffered write support
        (no commit info)

Best regards,
-- 
Jens Axboe


