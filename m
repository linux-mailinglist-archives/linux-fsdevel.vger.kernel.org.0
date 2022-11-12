Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C7B626AFD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Nov 2022 19:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbiKLSQE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Nov 2022 13:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiKLSQE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Nov 2022 13:16:04 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B2914D0F;
        Sat, 12 Nov 2022 10:16:03 -0800 (PST)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 960DC1FA3;
        Sat, 12 Nov 2022 18:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1668276789;
        bh=qW0gnLZ8q0BPl9s3w7rT3Hbc4C3NEDf9fxBKmQZaJJQ=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=BWPe30B+09ziq+BQVvLbim8wXXB2Y+Z2tmn3g0zoxyHNFQS5JL93JdQkT+splbK6V
         DSwUobL5ANqwmgBvyyCTOZul4dVOVlZZVJQXF50EwioM7kBASQSub/HV8XF3kvMjLR
         e0y3HgR1WfysY7neCcooVI62JoAZANeFd2sLXV1E=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 5E74026;
        Sat, 12 Nov 2022 18:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1668276961;
        bh=qW0gnLZ8q0BPl9s3w7rT3Hbc4C3NEDf9fxBKmQZaJJQ=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=ubQKHGUFQPYlEdyxs/lAbFvAO0HJt9ucFEDImvAKSr/guLfXBEXB0sUTBJaLCK7bo
         8UY4VczJghWmJ6bC/TZEoQ2y0NJG5GW6vaJA1CFBKk1KSFnsZ11wq9wL2AsWCJSfhw
         RX5K2RfWBqWCc04DBSBVQ6yW09C3gdEJWZ1l+IIE=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Sat, 12 Nov 2022 21:16:01 +0300
Message-ID: <a66e6baf-8cff-49ca-7a86-310369973ea3@paragon-software.com>
Date:   Sat, 12 Nov 2022 21:16:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/2] fs/ntfs3: Add windows_names mount option
Content-Language: en-US
To:     Daniel Pinto <danielpinto52@gmail.com>, <ntfs3@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1b23684d-2cac-830e-88e3-1dc1c1567441@gmail.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <1b23684d-2cac-830e-88e3-1dc1c1567441@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/10/22 14:11, Daniel Pinto wrote:
> Changes v1->v2:
> - Add documentation for windows_names mount option.
> 
> When enabled, the windows_names mount option prevents the creation
> of files or directories with names not allowed by Windows. Use
> the same option name as NTFS-3G for compatibility.
> 
> Daniel Pinto (2):
>    fs/ntfs3: add windows_names mount option
>    fs/ntfs3: document windows_names mount option
> 
>   Documentation/filesystems/ntfs3.rst |   8 +++
>   fs/ntfs3/frecord.c                  |   7 +-
>   fs/ntfs3/fsntfs.c                   | 104 ++++++++++++++++++++++++++++
>   fs/ntfs3/inode.c                    |   7 ++
>   fs/ntfs3/ntfs_fs.h                  |   2 +
>   fs/ntfs3/super.c                    |   7 ++
>   6 files changed, 134 insertions(+), 1 deletion(-)

Thanks for patches, applied!
