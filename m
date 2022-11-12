Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2D0626B01
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Nov 2022 19:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbiKLSSK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Nov 2022 13:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiKLSSJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Nov 2022 13:18:09 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85D614D0F;
        Sat, 12 Nov 2022 10:18:07 -0800 (PST)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 470EA1FA3;
        Sat, 12 Nov 2022 18:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1668276914;
        bh=LBXEojUVbSkmPtK6kRYVLbqPDb+pgXVfC2bn8oUwaSI=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=nvIsr8JfPmG7aN5TgzgHArDbL+5wSQ1IZbQAca+I0CeL1gXuqzulp7oxTAwA8FhRr
         VifVawKLo1rD01w+Ow3titZFJwXCqkcYQe2Fma66cq4uWeEh7IInPiOHPobZtZk2if
         Wu+FN+Nl/DCgOxTmDh5an4FPqbt1RsrWg2/Vdo6o=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Sat, 12 Nov 2022 21:18:05 +0300
Message-ID: <7241fb97-c7f7-2136-e93a-b498bcedf5e4@paragon-software.com>
Date:   Sat, 12 Nov 2022 21:18:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/5] fs/ntfs3: Fix and rename hidedotfiles mount option
Content-Language: en-US
To:     Daniel Pinto <danielpinto52@gmail.com>, <ntfs3@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <9c404576-856b-6935-f2e3-c4d0749f16ea@gmail.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <9c404576-856b-6935-f2e3-c4d0749f16ea@gmail.com>
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



On 10/10/22 14:27, Daniel Pinto wrote:
> Changes v1->v2:
> - Add documentation for hidedotfiles mount option.
> 
> The current implementation of the hidedotfiles has some problems, namely:
> - there is a bug where enabling it actually disables it and vice versa
> - it only works when creating files, not when moving or renaming them
> - it is not listed in the enabled options list by the mount command
> - its name differs from the equivalent hide_dot_files mount option
>    used by NTFS-3G, making it incompatible with it for no reason
> 
> This series of patches tries to fix those problems.
> 
> Daniel Pinto (5):
>    fs/ntfs3: fix hidedotfiles mount option by reversing behaviour
>    fs/ntfs3: make hidedotfiles mount option work when renaming files
>    fs/ntfs3: add hidedotfiles to the list of enabled mount options
>    fs/ntfs3: document the hidedotfiles mount option
>    fs/ntfs3: rename hidedotfiles mount option to hide_dot_files
> 
>   Documentation/filesystems/ntfs3.rst | 6 ++++++
>   fs/ntfs3/frecord.c                  | 9 +++++++++
>   fs/ntfs3/inode.c                    | 2 +-
>   fs/ntfs3/super.c                    | 6 ++++--
>   4 files changed, 20 insertions(+), 3 deletions(-)

Good catch with differences between NTFS-3G and ntfs3.
Applied, thanks!
