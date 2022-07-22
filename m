Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0A557E820
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 22:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiGVUMp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 16:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236592AbiGVUMl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:12:41 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57512A9B9B;
        Fri, 22 Jul 2022 13:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1658520757;
        bh=1lu/oIs0WiJHNhHfcks6ORWsi614Qbc/WNzkGCwoC/0=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=CFEnlPpiSi8Kz2mJNF9KdmEO99RJSp3MaCyxk0rkXbpgq2Xd7Dd5x/sMzlxm4LHqJ
         8gDl+l6PGdKyo2o3Hc3lFoDGNtmm6GOdzXOZ3bEvek3V7a2hXnbmDZinLWPiD1cx3q
         S4NIk2sTZ2bVR/L1ODLl2FZWIKqhLsjZJCppDBSk=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 849581287A12;
        Fri, 22 Jul 2022 16:12:37 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VHxCfJzEDPyx; Fri, 22 Jul 2022 16:12:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1658520757;
        bh=1lu/oIs0WiJHNhHfcks6ORWsi614Qbc/WNzkGCwoC/0=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=CFEnlPpiSi8Kz2mJNF9KdmEO99RJSp3MaCyxk0rkXbpgq2Xd7Dd5x/sMzlxm4LHqJ
         8gDl+l6PGdKyo2o3Hc3lFoDGNtmm6GOdzXOZ3bEvek3V7a2hXnbmDZinLWPiD1cx3q
         S4NIk2sTZ2bVR/L1ODLl2FZWIKqhLsjZJCppDBSk=
Received: from [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b] (unknown [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 06CBA1287A10;
        Fri, 22 Jul 2022 16:12:36 -0400 (EDT)
Message-ID: <7e1182f7c01af15d47d7ee836a72bbd5e9b47d64.camel@HansenPartnership.com>
Subject: Re: [PATCH] hfsplus: Fix code typo
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Xin Gao <gaoxin@cdjrlc.com>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 22 Jul 2022 16:12:34 -0400
In-Reply-To: <20220722195133.18730-1-gaoxin@cdjrlc.com>
References: <20220722195133.18730-1-gaoxin@cdjrlc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2022-07-23 at 03:51 +0800, Xin Gao wrote:
> The double `free' is duplicated in line 498, remove one.
> 
> Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
> ---
>  fs/hfsplus/btree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> index 66774f4cb4fd..655cf60eabbf 100644
> --- a/fs/hfsplus/btree.c
> +++ b/fs/hfsplus/btree.c
> @@ -495,7 +495,7 @@ void hfs_bmap_free(struct hfs_bnode *node)
>  	m = 1 << (~nidx & 7);
>  	byte = data[off];
>  	if (!(byte & m)) {
> -		pr_crit("trying to free free bnode "
> +		pr_crit("trying to free bnode "

What makes you think this message needs correcting?  The code seems to
be checking whether we're freeing an already free bnode, meaning the
message looks correct as is and the proposed change makes it incorrect.

James


