Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35DA6382C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 04:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiKYDgV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Nov 2022 22:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKYDgU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Nov 2022 22:36:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920D92AC57;
        Thu, 24 Nov 2022 19:36:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D732621E1;
        Fri, 25 Nov 2022 03:36:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1292CC433C1;
        Fri, 25 Nov 2022 03:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669347378;
        bh=wKWPk4v8fe90jffTIHyQjUbwPtVaGLxqGFEpI0P7wnE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YTqZbNiRd4JIWn0K8jzRIqEDGOkfDpOe3H7Mh1qixAiAm+8XzeAOmWoqz4YaQxk+L
         bN0908UoIcr3RNueemlQyVj6OYnR2g0a++qQzBUNzvlypbC/CQDTwawvHAsZmbZy7o
         eGz8b8YIftg2Jn7zN0Ia872itxFTG+7H4mx1HT6aCaTaLEemm30HaTGMmUnFhdT5OG
         iBFvoiplRvGL2GTEe1MJAnzmn5X6IKVEcqgnNy3ionyb8mgAN5ov/Ao3YTHpOU3wyn
         qY7P6trgGmIJofxRtN0esLJNrvLfLE61VfiycElQf94+/xSeFvFjSObSDwQqk9cQ1A
         Yy1unQXoyXl5g==
Message-ID: <6bce9afb-2561-7937-caea-8aadaa5a21cd@kernel.org>
Date:   Fri, 25 Nov 2022 11:36:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [f2fs-dev] [PATCH v3] fsverity: stop using PG_error to track
 error status
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        linux-f2fs-devel@lists.sourceforge.net
References: <20221028175807.55495-1-ebiggers@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221028175807.55495-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/10/29 1:58, Eric Biggers wrote:
> @@ -116,43 +116,51 @@ struct bio_post_read_ctx {
>   	struct f2fs_sb_info *sbi;
>   	struct work_struct work;
>   	unsigned int enabled_steps;
> +	bool decompression_attempted;

How about adding some comments for decompression_attempted? Otherwise it
looks good to me.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
