Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD05362ADCD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 23:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbiKOWJF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 17:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiKOWJC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:09:02 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B50E23E9E;
        Tue, 15 Nov 2022 14:09:01 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 51EC137E;
        Tue, 15 Nov 2022 22:09:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 51EC137E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1668550141; bh=3Frn0Rz4+neOrtAKdNxQcaw3NAu7ZonRNmggKtwrpOA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FriXPDhsrfq2J/k3jZZVNgFIJq7oOqy3f1ZPdc7uLMVIxLNWk2WC5U1gsRhz0/ZZz
         nfTdvK4ymPcRJQDelZkHPDHVnlj6vR4ETk+xfANxv6bzbF+2ChJR+EcUkoCnmwuxT8
         Vlm+8W/NwpIBUXTjxwozIEuha6quq+DVIGqBO/ZVwni0YizZEeUwGo0ne7PKV8sXg2
         xrEjCz68r4xv8owissgN3CdSo+1MNIufOpab8pOkC9orqaoXjIBCBXxSdNcl0kSydp
         pmpsFaTHIiZoN67zUHEsPUQIUL6UeOL09zxXhD2O7IcaqCWpn4bNSkpRv7tPptR7hZ
         MjXh59c8vKe6Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Chen Linxuan <chenlinxuan@uniontech.com>
Cc:     Chen Linxuan <chenlinxuan@uniontech.com>,
        Yuan Haisheng <heysion@deepin.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: update the description of TracerPid in
 procfs.rst
In-Reply-To: <20221102081517.19770-1-chenlinxuan@uniontech.com>
References: <20221102081517.19770-1-chenlinxuan@uniontech.com>
Date:   Tue, 15 Nov 2022 15:09:00 -0700
Message-ID: <87v8nf98g3.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Chen Linxuan <chenlinxuan@uniontech.com> writes:

> When the tracer of process is outside of current pid namespace, field
> `TracerPid` in /proc/<pid>/status will be 0, too, just like this process
> not have been traced.
>
> This is because that function `task_pid_nr_ns` used to get the pid of
> tracer will return 0 in this situation.
>
> Co-authored-by: Yuan Haisheng <heysion@deepin.com>
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> ---
>  Documentation/filesystems/proc.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 898c99eae8e4..e98e0277f05e 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -245,7 +245,8 @@ It's slow but very precise.
>   Ngid                        NUMA group ID (0 if none)
>   Pid                         process id
>   PPid                        process id of the parent process
> - TracerPid                   PID of process tracing this process (0 if not)
> + TracerPid                   PID of process tracing this process (0 if not, or
> +                             the tracer is outside of the current pid namespace)

Applied, thanks.

jon
