Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3305494A13
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 09:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359457AbiATIvY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 03:51:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34090 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359427AbiATIvX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:51:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 933EAB81CF6;
        Thu, 20 Jan 2022 08:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36EAC340E0;
        Thu, 20 Jan 2022 08:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642668681;
        bh=B/b871Ft6dOFRZ8+4OluzkF5fHlAiKwo8dhP/7V1BqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S7DXgAvgRFW0sUF/GTnaSyGzljTfTge2klD9btrBp9zEzfjIs0Lpf8X5yNi51omNc
         7pITJoP++G1V1INovfMExJE8EHToMSh1YnuWAYjKDu4oCO6WdbqsMRH3zhi0i7a50S
         YsSjGd0BfVIWNNJXYRYy1jdh0H3fvgoPDwz+WPChAkiaOdRP5UoJ3MLaqQLFAjL/zY
         V099iudaugfCCTa+maFiIFc1CknuswsCyYRH5gWx10/kV/ty9cxl86ZYj4XVRlMf4e
         Qt0n/xKQBZIf+PgStFL22RHA/4P3KBMdpubVnDlWTeU6dGB373J5iFkx3qHje9iCy0
         vEMZrUjnUPQlg==
Date:   Thu, 20 Jan 2022 09:51:12 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/coredump: rate limit the unsafe core_pattern warning
Message-ID: <20220120085112.irctg4263dd2r2a5@wittgenstein>
References: <20220119222729.98545-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220119222729.98545-1-colin.i.king@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 19, 2022 at 10:27:29PM +0000, Colin Ian King wrote:
> It is possible to spam the kernel log with many invalid attempts
> to set the core_pattern. Rate limit the warning message to make
> it less spammy.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Acked-by: Christian Brauner <brauner@kernel.org>
