Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E776DBBC1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Apr 2023 17:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjDHPQt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Apr 2023 11:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDHPQs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Apr 2023 11:16:48 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64090EF96;
        Sat,  8 Apr 2023 08:16:46 -0700 (PDT)
Received: from [192.168.1.190] (ip5b426bea.dynamic.kabel-deutschland.de [91.66.107.234])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: buczek)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6247761E4052B;
        Sat,  8 Apr 2023 17:16:43 +0200 (CEST)
Message-ID: <be98bee0-4ddc-194f-82be-767e0bb9f60f@molgen.mpg.de>
Date:   Sat, 8 Apr 2023 17:16:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 02/11] block: Block Device Filtering Mechanism
To:     Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk,
        hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org,
        kch@nvidia.com, martin.petersen@oracle.com, vkoul@kernel.org,
        ming.lei@redhat.com, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230404140835.25166-1-sergei.shtepa@veeam.com>
 <20230404140835.25166-3-sergei.shtepa@veeam.com>
Content-Language: en-US
From:   Donald Buczek <buczek@molgen.mpg.de>
In-Reply-To: <20230404140835.25166-3-sergei.shtepa@veeam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Sergei,

On 4/4/23 16:08, Sergei Shtepa wrote:
> The block device filtering mechanism is an API that allows to attach
> block device filters. Block device filters allow perform additional
> processing for I/O units.
> [...]
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index b7b56871029c..1848d62979a4 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -185,6 +185,11 @@ struct fsxattr {
>   #define BLKROTATIONAL _IO(0x12,126)
>   #define BLKZEROOUT _IO(0x12,127)
>   #define BLKGETDISKSEQ _IOR(0x12,128,__u64)
> +/* 13* is defined in linux/blkzoned.h */

nit: This is already explained in the comment below your insert.

Best

  Donald

> +#define BLKFILTER_ATTACH	_IOWR(0x12, 140, struct blkfilter_name)
> +#define BLKFILTER_DETACH	_IOWR(0x12, 141, struct blkfilter_name)
> +#define BLKFILTER_CTL		_IOWR(0x12, 142, struct blkfilter_ctl)
> +
>   /*
>    * A jump here: 130-136 are reserved for zoned block devices
>    * (see uapi/linux/blkzoned.h)

