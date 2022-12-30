Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57996597F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Dec 2022 13:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiL3MDv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 07:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiL3MDu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 07:03:50 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288DA1A07F
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Dec 2022 04:03:48 -0800 (PST)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id A2BE82139;
        Fri, 30 Dec 2022 12:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1672401613;
        bh=MLrryah8PcAIEgqMp1+hU+ya9+8F75oeNu3M5zQRMAA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=rTRPIDsMtRf+wV3YavbAqZEbgm134rKbtewer5a3BJmhWQdv3zlcsir9Kz4s9q/6Y
         DeI+cj2gbywO9t0FSdddkb80mH12ZkPY+r4+OnoO3sZoAo8Aqw0+BfgRmu8ubTJMf5
         RCS3lHOu3xXMbXPteI8/HkiyRPl5TlYpZQDq+FL0=
Received: from [192.168.211.146] (192.168.211.146) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 30 Dec 2022 15:03:45 +0300
Message-ID: <ff9118fe-9a6e-d178-dc0f-52230f369d53@paragon-software.com>
Date:   Fri, 30 Dec 2022 16:03:45 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: remove ->writepage in ntfs3
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
CC:     <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>
References: <20221116133452.2196640-1-hch@lst.de>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20221116133452.2196640-1-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.146]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 16.11.2022 17:34, Christoph Hellwig wrote:
> Hi Konstantin,
>
> this small series removes the deprecated ->writepage method from ntfs3.
> I don't have a ntfs test setup so this is untested and should be handled
> with care.
>
> Diffstat:
>   inode.c |   33 +++++++++++++++------------------
>   1 file changed, 15 insertions(+), 18 deletions(-)
Hello Christoph,

Sorry for the delay. We have taken your patches for testing.

We will be back with an answer as soon as possible.
