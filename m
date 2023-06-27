Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3892373F3BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 06:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjF0Euo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 00:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjF0Eug (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:50:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA71EB;
        Mon, 26 Jun 2023 21:50:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B25A60F1E;
        Tue, 27 Jun 2023 04:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C29FC433C8;
        Tue, 27 Jun 2023 04:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687841434;
        bh=xQVFq/TTj7+kNNOeanHm8M+j68vWEOX0jbWLiLFRSco=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sTwGaTweOdOdDY9NRy9K20ToheNd0YYKjmFm7Pm6v+Dqf2g2W1UxQXsJRJBXKHfBH
         L/dU7hIVMMmvAxZ+/GJes0u2lSgErd4JcUHBU37O0YSUlcNPzXG8jxS1PYBZVGfvzL
         lZDmm9SQWmn+C3lynrCH+KxiF+oXCmGzElZTaszF4fTXa0NFQikRYqltPZp9osOpVt
         +EcddWaRJ9TuOFFDuC0RjM6r50AnMCaBg5CNLP4+XHXUybKYNYJrroLFQORtKzNGim
         ZlumK1YqY/LAS9dm3nAaV0L37WE6W31+DA7VkE3h/Z9lUYH1+CmyZIvTHC33UTNse/
         ENvwClmwn+/qw==
Message-ID: <b47ecf8e-4210-799a-ad4f-e12569b1ca45@kernel.org>
Date:   Tue, 27 Jun 2023 13:50:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] zonefs: do not use append if device does not support it
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andreas Hindborg <nmi@metaspace.dk>,
        "open list:ZONEFS FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        gost.dev@samsung.com, Andreas Hindborg <a.hindborg@samsung.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230626164752.1098394-1-nmi@metaspace.dk>
 <ZJpbUShJUL788r7u@infradead.org>
 <31ceba83-9d06-8fc6-4688-d568a698a4cc@kernel.org>
 <ZJpqBwzVu+h9g0VV@infradead.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZJpqBwzVu+h9g0VV@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/27/23 13:48, Christoph Hellwig wrote:
> On Tue, Jun 27, 2023 at 01:45:38PM +0900, Damien Le Moal wrote:
>> But thinking of it, we probably would be better off having a generic check for
>> "q->limits.max_zone_append_sectors != 0" in blk_revalidate_disk_zones().
> 
> Agreed.

I'll send something.

-- 
Damien Le Moal
Western Digital Research

