Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E47849FC83
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 16:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbiA1PMu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 10:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbiA1PMu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:12:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC69C061714;
        Fri, 28 Jan 2022 07:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KyI69O45ehxmAwW9fv0/0osW50iJDw/JIdPZTiNNAzg=; b=26Gu36fCTUmYN60362r3RhqdKh
        YcL881BVqXKsYL2Qr+vF/OwMMxr01K2qvoGltiUpef1W13xfm1nhUUz0e/+VvZrjwXFo2snUkfr1v
        uzCK9rPtfqi1dPoJy2rH90zfcMwIJp9yAUoU7aShZ792EaPe1fKrmHvi7fbeWEiKxQO06qH7SN+EZ
        /viBOV7OYdkD5IRw2dirUjL3vjl9XVyS44k98DFUAYUllEgkIM3cxLBJrK2LhMZUHFMiK+gI7IgKc
        4A0bzopTN+x4JvaMz16tNmzh47Jev3Ykil7VGZvIMtbVlx2VZg954lX02nXlcClspMXDbGcMIiz2C
        lOPGHlSQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nDSvc-002fAw-Ca; Fri, 28 Jan 2022 15:12:44 +0000
Date:   Fri, 28 Jan 2022 07:12:44 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     tangmeng <tangmeng@uniontech.com>
Cc:     tglx@linutronix.de, keescook@chromium.org, yzaikin@google.com,
        john.stultz@linaro.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] kernel/time: move timer sysctls to its own file
Message-ID: <YfQH7K1rKnFoY3pk@bombadil.infradead.org>
References: <20220128065505.16685-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128065505.16685-1-tangmeng@uniontech.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 28, 2022 at 02:55:05PM +0800, tangmeng wrote:
> This moves the kernel/timer/timer.c respective sysctls to its own file.
> 
> Signed-off-by: tangmeng <tangmeng@uniontech.com>
> ---
> +static int __init timer_sysctl_init(void)
> +{
> +	register_sysctl_init("kerneli/timer", timer_sysctl);
> +	return 0;
> +}
> +#else

You mean kernel/timer right?

 Luis
