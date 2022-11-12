Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847D7626B03
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Nov 2022 19:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbiKLSTb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Nov 2022 13:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiKLSTa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Nov 2022 13:19:30 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292B16325;
        Sat, 12 Nov 2022 10:19:30 -0800 (PST)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 88BF21FA3;
        Sat, 12 Nov 2022 18:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1668276996;
        bh=UENfRwnMTqqFxvN03L67bz06uG47M90a2UjcISC+Zik=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=TDCwClYr6BUhAecZK7pV0dxjpkNoJGKAq9xCdG/AiycvA54iEz0WQ3lPc9lt1NnSO
         72n43LP+gLTQI9JLqKPfOopPxIADOKx8oPCkv4+SvTJWv5EGBNLDgSGVqnt2dHL4Li
         QbQgTuT5Gtv5KRU5UHUhPh41SWDLu+FqdMmZPlYY=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 53F8026;
        Sat, 12 Nov 2022 18:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1668277168;
        bh=UENfRwnMTqqFxvN03L67bz06uG47M90a2UjcISC+Zik=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=hwKDy7XmSHJ0oV+N6Hk57OLAEMhiLJEORll2x/aVNywF7F1xkHGfBwpRMwvZXn/TG
         2AsWnpkwXeGDYi7judz6m/8wowpghGL8+Mop/6BTrmudl9kdd2lsPaqogHkGKIWBCr
         RluTQMpkSplB/82HZrgBXgBHidvK7q/n9qwHtJl8=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Sat, 12 Nov 2022 21:19:27 +0300
Message-ID: <2f53a723-be3a-be02-72d5-91d83d7b1210@paragon-software.com>
Date:   Sat, 12 Nov 2022 21:19:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/2] fs/ntfs3: Add system.ntfs_attrib_be extended
 attribute
Content-Language: en-US
To:     Daniel Pinto <danielpinto52@gmail.com>, <ntfs3@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <c9b467dd-9294-232b-b808-48f62c3c2186@gmail.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <c9b467dd-9294-232b-b808-48f62c3c2186@gmail.com>
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



On 10/10/22 14:41, Daniel Pinto wrote:
> Changes v1->v2:
> - Add documentation for the system.ntfs_attrib_be extended attribute
> 
> Improves compatibility with NTFS-3G by adding the system.ntfs_attrib_be
> extended attribute.
> 
> Daniel Pinto (2):
>    fs/ntfs3: add system.ntfs_attrib_be extended attribute
>    fs/ntfs3: document system.ntfs_attrib_be extended attribute
> 
>   Documentation/filesystems/ntfs3.rst |  5 +++++
>   fs/ntfs3/xattr.c                    | 20 ++++++++++++++------
>   2 files changed, 19 insertions(+), 6 deletions(-)

Thank you for your work, applied!
