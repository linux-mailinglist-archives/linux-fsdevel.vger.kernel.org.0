Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F77763AC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 17:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjGZPT0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 11:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjGZPTY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:19:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFDE26AE;
        Wed, 26 Jul 2023 08:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=ENp8t2alD9uqWSc+lVmb+ztvUQXJv9bHqkir1OYXiZQ=; b=Zktt9cmfUVUjC5iN3Pf6hJxBWZ
        pONXfD/vj7s9mjqgRHd1uXzmF89SyNsi4jKE3kGyIPy2Lbr8lZGBx94kPGgg6cXhoybPp93Gpa0Hp
        dSO4VFfWrDuOkjMJc1bQmD1hJF53UyBtA+rRAsukRUT2zNXoAkzVpFGMuQjyc3n5MM4dH7cB8Vs2G
        lEpOmMnrPw3Dp2zj2Bb890sg2PECXXfIWKFShQKbR66J5FLB31H4NGMpxkO7+Bv6CyxHQ+CbDAGB6
        hlr3dqIHeOKPBbn4BZU7KQd7Lr2UN6I4auxZ1OlMsPzF2qtGu4KhY0ezyP5xn+IPsrLDx1toevPIU
        +GlVwSYA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qOgIB-00ApOw-1k;
        Wed, 26 Jul 2023 15:19:11 +0000
Message-ID: <a08cff9e-9bf6-2176-b2d2-dbbc3a0c9350@infradead.org>
Date:   Wed, 26 Jul 2023 08:19:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] fuse: enable larger read buffers for readdir.
Content-Language: en-US
To:     Jaco Kroon <jaco@uls.co.za>, Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230726105953.843-1-jaco@uls.co.za>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230726105953.843-1-jaco@uls.co.za>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/26/23 03:59, Jaco Kroon wrote:
> +config FUSE_READDIR_ORDER
> +	int
> +	range 0 5
> +	default 5
> +	help
> +		readdir performance varies greatly depending on the size of the read.
> +		Larger buffers results in larger reads, thus fewer reads and higher
> +		performance in return.
> +
> +		You may want to reduce this value on seriously constrained memory
> +		systems where 128KiB (assuming 4KiB pages) cache pages is not ideal.
> +
> +		This value reprents the order of the number of pages to allocate (ie,

	                   represents                                            (i.e.,

> +		the shift value).  A value of 0 is thus 1 page (4KiB) where 5 is 32
> +		pages (128KiB).

-- 
~Randy
