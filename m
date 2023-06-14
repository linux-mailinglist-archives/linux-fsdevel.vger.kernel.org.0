Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E884F730546
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 18:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbjFNQnb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 12:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbjFNQn1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:43:27 -0400
Received: from mx1.veeam.com (mx1.veeam.com [216.253.77.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7C81A3;
        Wed, 14 Jun 2023 09:43:24 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.veeam.com (Postfix) with ESMTPS id A838441C22;
        Wed, 14 Jun 2023 12:43:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx1-2022; t=1686761001;
        bh=jNTgcvWm1vw80HHo0h776WVZUmiYhzpPLC0Z4LijRXU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To:From;
        b=kIebp/AY7hQOAPU7dr4d2uQksODoxH0g/Z1VW20qAjTclm2YEp/FOQMds78ngEKkK
         X5AoTgpoN2bGr1/8zPbkNYjRImT29BknuqEfCgYsAeE+gYWJmEMEnv0DdkOLFydauT
         a7ihjMGKq5BHyq5bAhAGErRN30NDlXD04HhOfwoJn2MeJIVC+Spr9+kVY0UDPIpMA7
         ICWaidyXrAjvvvMeqSeLy/12zbRN7Hq5ckHeI9IQ3MD1e7IznjuXwbDArQK8V3obt1
         XSwV2jtKL3cTAlka9tAqd3JrvElD67sQpFr9l+5T6N3FAaMVhxC/hKY7WJzDksj0v9
         PkFEwWfHNV3PQ==
Received: from [172.24.10.107] (172.24.10.107) by prgmbx01.amust.local
 (172.24.128.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Wed, 14 Jun
 2023 18:43:20 +0200
Message-ID: <c4c9da4f-0d82-4e35-0365-f246666f0c37@veeam.com>
Date:   Wed, 14 Jun 2023 18:43:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v5 04/11] blksnap: header file of the module interface
To:     Christoph Hellwig <hch@infradead.org>
CC:     Dave Chinner <david@fromorbit.com>, <axboe@kernel.dk>,
        <corbet@lwn.net>, <snitzer@kernel.org>, <viro@zeniv.linux.org.uk>,
        <brauner@kernel.org>, <dchinner@redhat.com>, <willy@infradead.org>,
        <dlemoal@kernel.org>, <linux@weissschuh.net>, <jack@suse.cz>,
        <ming.lei@redhat.com>, <linux-block@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        "Donald Buczek" <buczek@molgen.mpg.de>
References: <20230612135228.10702-1-sergei.shtepa@veeam.com>
 <20230612135228.10702-5-sergei.shtepa@veeam.com>
 <ZIjsywOtHM5nIhSr@dread.disaster.area> <ZIldkb1pwhNsSlfl@infradead.org>
 <733f591e-0e8f-8668-8298-ddb11a74df81@veeam.com>
 <ZInJlD70tMKoBi7T@infradead.org>
Content-Language: en-US
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
In-Reply-To: <ZInJlD70tMKoBi7T@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A29240315546D7067
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/14/23 16:07, Christoph Hellwig wrote:
> I don't actually think swapfile is a very good idea, in fact the Linux
> swap code in general is not a very good place to look for inspirations
> 😄

Perhaps. I haven't looked at the code yet. But I like the idea of
protecting the file from any access from the user-space, as it is
implemented for swapfile.

> 
> IFF the usage is always to have a whole file for the diff storage the
> over all API is very simple - just pass a fd to the kernel for the area,
> and then use in-kernel direct I/O on it.  Now if that file should also
> be able to reside on the same file system that the snapshot is taken
> of things get a little more complicated, because writes to it also need
> to automatically set the BIO_REFFED flag.

There is definitely no task to create a difference storage file on the
same block device for which the snapshot is being created. The file can
be created on any block device.

Still, the variant when a whole partition is allocated for the difference
storage can also be useful.

> I have some ideas for that and will share some draft code with you.

I'll be glad.
