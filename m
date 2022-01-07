Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458D848767C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 12:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347109AbiAGL3r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jan 2022 06:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236893AbiAGL3r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:29:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34540C061245;
        Fri,  7 Jan 2022 03:29:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8A62B825A5;
        Fri,  7 Jan 2022 11:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11AEBC36AE9;
        Fri,  7 Jan 2022 11:29:42 +0000 (UTC)
Date:   Fri, 7 Jan 2022 12:29:40 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Fix duplicate path separator in printed entries
Message-ID: <20220107112940.rrn5gloahk5durwu@wittgenstein>
References: <e3054d605dc56f83971e4b6d2f5fa63a978720ad.1641551872.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e3054d605dc56f83971e4b6d2f5fa63a978720ad.1641551872.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 07, 2022 at 11:38:44AM +0100, Geert Uytterhoeven wrote:
> sysctl_print_dir() always terminates the printed path name with a slash,
> so printing a slash before the file part causes a duplicate like in
> 
>     sysctl duplicate entry: /kernel//perf_user_access
> 
> Fix this by dropping the extra slash.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Seems good,
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
