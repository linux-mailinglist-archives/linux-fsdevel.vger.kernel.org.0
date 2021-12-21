Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB7647C751
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 20:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241720AbhLUTRF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 14:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhLUTRF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 14:17:05 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB5DC06173F
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Dec 2021 11:17:04 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id k21so19067264ioh.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Dec 2021 11:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=DQp0I7r6Ke8ioOsCOhwIYXNvl3VTy+q5CXgKMoHFn6M=;
        b=lLDI2uunwQhcxsc4ASiyrBVaO+ewn/0kRZzASN2FF3LfmiyCM6TIesvti2eAcHvHvo
         eo4EatnPPOmQMAKKl26yJR1eGEK0L53N5jZBEqDx6qv741cNErp9KD9Ao2EOgEbiZFNO
         JYvzkKyXai/mhhCpSHmL1igKn0OhzConaZ58DXnVFaVZPqr/+kSpMh80OoPTtSIbEaeo
         6Xq72zGK2CZiw50WFwmuzHrCAzuNCDlBYT0nDtaPOfm4FcXClbgL38fxNnB6L9+VvLSH
         0httxO2jxJkzEqbT3Hjcv+HCujOIjWv99/Z7C24nbKyidhfXI0/S8GJwBcP3HzVPgPPS
         fTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=DQp0I7r6Ke8ioOsCOhwIYXNvl3VTy+q5CXgKMoHFn6M=;
        b=b06KZt+k36RgKfKcEdYyVR9hVkLZ4HlffqRJPXM20ocd92CmslAkJjqCDpdbNlXMon
         cggZqAeSCLmhQVgrzPsKptfrZNKTsn9iI+pzEUKynEohACTaOhZC6WuLuQOc3RYMRL3Y
         qtSFAyN+PQajfUuhlgFzHFVcB9YCGrdn3I8Xpq+v1L7Oeka3O9K0GOVJ7osapaJGXqnW
         3z7x2Cot3T0rrQ8O44tth4md5L1bUNs1/FcuifgOVmZ8cTY4EEl5Ln0BVyK6S/9ebkYd
         J19fjPlVAKlTBSTK+05mwkJ1GoK5q0rgb1L9Mw+3CNdZ/H/yogx3pfla0jYSiodY7lJM
         pwng==
X-Gm-Message-State: AOAM53399/nUTKqeoKZ++mDu5zEHfUKfPwRo3AI6VtP3OzLSjjjk5PPV
        7ZZl2q5ra+YlLz9IZQTheZEGiFcosJgqfQ==
X-Google-Smtp-Source: ABdhPJw6z8rSi1BcvBQsQYhCsqggZHq8Bw+kmGZ7IeAPQiYwtz9N7No6UwgFNslGZNckRolhSKGCZg==
X-Received: by 2002:a02:b603:: with SMTP id h3mr2968301jam.233.1640114224316;
        Tue, 21 Dec 2021 11:17:04 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f10sm4563500ilu.88.2021.12.21.11.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 11:17:04 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        Stefan Roesch <shr@fb.com>
Cc:     torvalds@linux-foundation.org
In-Reply-To: <20211221164004.119663-1-shr@fb.com>
References: <20211221164004.119663-1-shr@fb.com>
Subject: Re: [PATCH v7 0/3] io_uring: add getdents64 support
Message-Id: <164011422387.623301.5246002969893185131.b4-ty@kernel.dk>
Date:   Tue, 21 Dec 2021 12:17:03 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 21 Dec 2021 08:40:01 -0800, Stefan Roesch wrote:
> This series adds support for getdents64 in liburing. The intent is to
> provide a more complete I/O interface for io_uring.
> 
> Patch 1: fs: add offset parameter to iterate_dir function.
>   This adds an offset parameter to the iterate_dir()
>   function. The new parameter allows the caller to specify
>   the offset to use.
> 
> [...]

Applied, thanks!

[1/3] fs: add offset parameter to iterate_dir function
      commit: 1533c1b579e1e866465fd9d04c8a5ebb1e25ba28
[2/3] fs: split off vfs_getdents function of getdents64 syscall
      commit: 54d460de2423434e7aa9f7fcb9656230de53b85e
[3/3] io_uring: add support for getdents64
      commit: b4518682080d3a1cdd6ea45a54ff6772b8b2797a

Best regards,
-- 
Jens Axboe


