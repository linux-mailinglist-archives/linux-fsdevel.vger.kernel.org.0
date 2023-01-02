Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EFC65B82D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jan 2023 00:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbjABX3A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Jan 2023 18:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjABX26 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Jan 2023 18:28:58 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3503C636E
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jan 2023 15:28:58 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CE6CA2E0;
        Mon,  2 Jan 2023 23:28:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CE6CA2E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1672702137; bh=unNNJAx1raXuxH1RlsXKdSAI/uTGa8PJJMnIQDlQYdA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=SM+bbid8PNP40mUjI1k96DLERYBtjWHNqHtYKmDeOU/LDeF2mZtRceEOpkDdWtF3f
         ysDANU56I4+I0uUfI1ilFbIjL+/4TcRmJ8lJf7eG3vGzS24GbH5xgaibZG+qp4hCZi
         ixZbtHl4eLO+1G/1CXHhbiYNNT9peiev3ODoYjPLtMPv+LZ6VhvlzKWnd32w5HcdDg
         hXIY+05ZkjxRfFpAyF2m9AcDWDrFk2GZDc27X//uatTCgJbWdhLUO4PeZFqC/Hgwcx
         /4uoDMJjMgKzwj4iZOESJx43XtVeQawyga47fVVJwox3fBgmvVOtzuNmgT53xn2MyO
         8+WCZS2qoyCng==
From:   Jonathan Corbet <corbet@lwn.net>
To:     yang.yang29@zte.com.cn, kuba@kernel.org, bagasdotme@gmail.com
Cc:     davem@davemloft.net, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH linux-next v3] docs: proc.rst: add softnet_stat to
 /proc/net table
In-Reply-To: <202212091421536982085@zte.com.cn>
References: <202212091421536982085@zte.com.cn>
Date:   Mon, 02 Jan 2023 16:28:56 -0700
Message-ID: <87ilhoh5xj.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

<yang.yang29@zte.com.cn> writes:

> From: Yang Yang <yang.yang29@zte.com.cn>
>
> /proc/net/softnet_stat exists for a long time, but proc.rst miss it.
> Softnet_stat shows some statistics of struct softnet_data of online
> CPUs. Struct softnet_data manages incoming and output packets
> on per-CPU queues. Note that fastroute and cpu_collision in
> softnet_stat are obsolete and their value is always 0.
>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> Reviewed-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
> ---
> Changes since v2: - refine patch subject and git log, thanks to Bagas Sanjaya.
> Changes since v1: - refine patch subject
> ---
>  Documentation/filesystems/proc.rst | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

jon
