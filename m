Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C195672DA4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 08:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240274AbjFMG7b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 02:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240315AbjFMG72 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 02:59:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CD61989
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 23:59:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76DFD61767
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 06:59:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A512C433EF;
        Tue, 13 Jun 2023 06:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686639560;
        bh=SPEL5kh5w1H8wV7VLzDULtULcpG+CgS/rLlCsPfdqwk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=X0Lr9UW4wp3iCxUNar41NAWIC5592MzUlo+BNuNuBz16hUrj+7iJ/n7TYRp38tq5o
         xyPnrjRYD9GKcmg4IgzONnmwWw5uaqdOmJDYoJnRLoCzw/ux1l1tI9RhleUSgCl5Bo
         L4p2ON2qTsL9jqQNUlORW/TBG6AANLX/lmwVQnrhlKh9ZF5qD5YhWcwYG/EkqWaNqU
         7BER9j9FEHq6Eqm5BLuvUru4QhTCyUevZxDGOOvrpNf17rs8IayBL1VUw5p5tnzNkX
         70cA6s4/DppafFp+G2xPNroBf7J9lqr3X8VxI7QzXoVVCIzwNncCoZtCKEVuz6URSR
         Xv0d8R0Q4R7aA==
Message-ID: <6ee69796-d591-7320-1d13-5f91da904c6f@kernel.org>
Date:   Tue, 13 Jun 2023 15:59:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] zonefs: set FMODE_CAN_ODIRECT instead of a dummy
 direct_IO method
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, naohiro.aota@wdc.com
Cc:     jth@kernel.org, linux-fsdevel@vger.kernel.org
References: <20230612053515.585428-1-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230612053515.585428-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/12/23 14:35, Christoph Hellwig wrote:
> Since commit a2ad63daa88b ("VFS: add FMODE_CAN_ODIRECT file flag") file
> systems can just set the FMODE_CAN_ODIRECT flag at open time instead of
> wiring up a dummy direct_IO method to indicate support for direct I/O.
> Do that for zonefs so that noop_direct_IO can eventually be removed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied to for-6.5. Thanks !


-- 
Damien Le Moal
Western Digital Research

