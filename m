Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DF56DF5A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 14:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjDLMkj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 08:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjDLMki (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:40:38 -0400
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EE17EC6;
        Wed, 12 Apr 2023 05:40:10 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 6DA9D406BD;
        Wed, 12 Apr 2023 08:39:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1681303193;
        bh=ZsREK7Jdmk5/bS3HMVbcUFFY2ynvc5y6DHn+evYJiIo=;
        h=Date:Subject:To:CC:References:From:In-Reply-To:From;
        b=SF1B2Nsiq0/ZYmAlZBDyu/yXVj4ytwYuY9AoNhXvBgiaH8IE40FJ4JlV48QH9GdDv
         pUjp74EqI4D+JZ0wS4FEdluiM7kmxAE4QJk6ZhqpzlyPh/bP8zC7r+0aSNLtEXSd+o
         x4B/tQxvhhSUPdD0O8zmgyBc4FOBTwEqzyurcj+uW9Dx2aRLX0Tu/BRAa17m3gXvc/
         J94mZl/i0GdKZxPlxoevDUQWnSmNkOGTlTziVuVI6YJW8h4eYq+DdfFWYbB5ZnmhdG
         E2Er8Q6vWJmYxHdn8ePQrmQwtUzesurwtRqsWW1oXZ1Eev70c7Bs23amGor+1ACAqp
         LDmrV+4zVNOAg==
Received: from [172.24.10.107] (172.24.10.107) by prgmbx01.amust.local
 (172.24.128.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Wed, 12 Apr
 2023 14:39:50 +0200
Message-ID: <62b90944-724d-093a-2e83-c7665d5dbd54@veeam.com>
Date:   Wed, 12 Apr 2023 14:39:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 01/11] documentation: Block Device Filtering Mechanism
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, <axboe@kernel.dk>,
        <hch@infradead.org>, <corbet@lwn.net>, <snitzer@kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <willy@infradead.org>, <kch@nvidia.com>,
        <martin.petersen@oracle.com>, <vkoul@kernel.org>,
        <ming.lei@redhat.com>, <gregkh@linuxfoundation.org>,
        <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <20230404140835.25166-1-sergei.shtepa@veeam.com>
 <20230404140835.25166-2-sergei.shtepa@veeam.com> <ZDOY4tWY9wjPDb/c@debian.me>
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
In-Reply-To: <ZDOY4tWY9wjPDb/c@debian.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A2924031554647062
X-Veeam-MMEX: True
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks, Bagas!

I have made changes in my repository.
Link: https://github.com/SergeiShtepa/linux/commit/d3309add0f355ef09483238868636c5db1258135
