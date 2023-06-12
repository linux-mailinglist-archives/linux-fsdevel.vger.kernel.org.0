Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D278272BBC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 11:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbjFLJJV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 05:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjFLJIz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:08:55 -0400
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2562330DB;
        Mon, 12 Jun 2023 02:04:15 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 8322640340;
        Mon, 12 Jun 2023 05:04:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1686560652;
        bh=Fszu4MmPAu1QrzS78Dhcfb4fbTNjdXrHWd9KLrzlumw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To:From;
        b=SnbODABjYKnPPePgMn5IyMrrFZWpQrkDbt4pAZadXzfEyu5pzbAP/FHeT6CfDav2z
         tWRA7qoaXM2nkMHsDo3bnEitGXEghfroyb7C2Zp1psyUysAI97XljW8ighjAhNWSld
         iJ6zP6GYySOe4fuhPhmZgEoXw7LbhjrJ3AW09QD+EcFY8RsWWxFD4bVqlfedxaaVSN
         pMQIHS/f1vx3pPvKVkHSjick9rFSKlo/ObLH8lFm9oOPXGtCkiO7wpWl3k4epyuywT
         25/hZrijq+GE+chimh8cmOVDd1pfu7yZWS3zilryNVgmEIGvpiZwYyET0wwqgIi5De
         4YHUhumGtWF0w==
Received: from [172.24.10.107] (172.24.10.107) by prgmbx01.amust.local
 (172.24.128.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Mon, 12 Jun
 2023 11:04:11 +0200
Message-ID: <1bfc8c1d-f49a-2128-a457-4651832f3d2a@veeam.com>
Date:   Mon, 12 Jun 2023 11:03:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 00/11] blksnap - block devices snapshots module
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
CC:     <axboe@kernel.dk>, <corbet@lwn.net>, <snitzer@kernel.org>,
        <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <willy@infradead.org>, <dlemoal@kernel.org>, <wsa@kernel.org>,
        <heikki.krogerus@linux.intel.com>, <ming.lei@redhat.com>,
        <gregkh@linuxfoundation.org>, <linux-block@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20230609115206.4649-1-sergei.shtepa@veeam.com>
 <ZIaVz62ntyrhHdup@infradead.org>
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
In-Reply-To: <ZIaVz62ntyrhHdup@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A29240315546D7767
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/12/23 05:49, Christoph Hellwig wrote:
> Hi Sergei,
> 
> what tree does this apply to?  New block infrastructure and drivers
> should be against Jen's for-6.5/block tree, and trying to apply the
> series against that seems to fail in patch 1 already.
> 

Hi.

Thank you. My mistake is that for the base branch I used this:
Link: https://github.com/torvalds/linux

> Jen's for-6.5/block tree
Link: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-6.5/block
I have to prepare a patch for this branch.

I'm sorry if I remind you of a kitten who is just learning how to
properly lap milk from a bowl :)

I guess I don't need to increment the patch version.
Is it enough to do a "RESEND"?
