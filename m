Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00288750C94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 17:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbjGLPdA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 11:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbjGLPc6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:32:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70720C2;
        Wed, 12 Jul 2023 08:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=689SEK0ciFY8KgDlRHFBreHHAC2z+cvH0wQ011Q2aMI=; b=df/VKiT91ZqRa0x7ofoJaXGlph
        PM7CRP4KkwoXZKNJlvYdkig+/LLrQ9LVGVf40H6Qaywx20JwTqHlizlUxF15FF/hdi7QMcfJ88rOM
        Tk9o3z44pMTcermnTCrLWAF39fzqRsD0ms+1lMmZtzToJzTD0SUcPG6eXBFgIigvbDeEBrSIYXiW/
        GnykGmmqxl8DWPpBQb6tfrtLGgdO7lnddHDuy7SXW0bC9E1PhpCLadB/V3QSWJPX+bNFvOifeRdsy
        3Vg5gSGOgGr74Cyg+9z9dxsezgnvq5bViTggfgF6K6g7cj7jT1ssxpJXUEt4gBcr4IJbEN74vqTce
        EZsIkLBg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJboy-000MRl-20;
        Wed, 12 Jul 2023 15:32:04 +0000
Message-ID: <03e153ce-328b-f279-2a40-4074bea2bc8f@infradead.org>
Date:   Wed, 12 Jul 2023 08:31:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 01/79] fs: add ctime accessors infrastructure
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144507.55591-2-jlayton@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230621144507.55591-2-jlayton@kernel.org>
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

Hi Jeff,

On arch/um/, (subarch i386 or x86_64), hostfs build fails with:

../fs/hostfs/hostfs_kern.c:520:36: error: incompatible type for arg
ument 2 of 'inode_set_ctime_to_ts'
../include/linux/fs.h:1499:73: note: expected 'struct timespec64' b
ut argument is of type 'const struct hostfs_timespec *'


-- 
~Randy
