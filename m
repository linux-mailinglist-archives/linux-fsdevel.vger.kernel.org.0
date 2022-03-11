Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0534D5C6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 08:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbiCKHiM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 02:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiCKHiL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:38:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D29C1B71A9;
        Thu, 10 Mar 2022 23:37:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CAC761B0E;
        Fri, 11 Mar 2022 07:37:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038F3C340EC;
        Fri, 11 Mar 2022 07:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646984227;
        bh=GQ4RaP2ez2tkLbCqL2jRU2LQnBbaB4HlcNPpvWVk95c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Weu8ocNdi/tIQd7tZzhM1nZuurzzjPE9n3PsbmoL0tLFZN/jGfCYkmXk32SMnDLCW
         RxmdHu2gIEXiewMZXl5kOVGfUpjOVeJ9vOulcQDX37O3ajY3TjZSqJOFZJ8b7noRIg
         NUxIzUTfkGuytF576LsAp4JvFrIq2sQgUPuESuqxPYQGXHzIImk0bzkI1pHY00PwuS
         9RdOJIBtEBf17Zsv1YV8IsyePAv6cC2QsYIUtwss4Mpae7HbEue8wFjidvmWzqM/Z/
         uJrDZWtQBWMpa/zWAOcCIm6vfgq7TInRQqiovEQbBtPIDoOEdw3xyQ0dYGggZaExn0
         9HY2WjvkyykxA==
Message-ID: <13f33ba9-cbfb-6ffb-a19a-a87127c80804@kernel.org>
Date:   Fri, 11 Mar 2022 15:36:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v4 07/21] erofs: use meta buffers for
 erofs_read_superblock()
Content-Language: en-US
To:     Jeffle Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, xiang@kernel.org,
        linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org
References: <20220307123305.79520-1-jefflexu@linux.alibaba.com>
 <20220307123305.79520-8-jefflexu@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220307123305.79520-8-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/3/7 20:32, Jeffle Xu wrote:
> The only change is that, meta buffers read cache page without __GFP_FS
> flag, which shall not matter.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
