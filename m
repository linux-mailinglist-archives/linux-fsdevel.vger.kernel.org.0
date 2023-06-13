Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AF272E007
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 12:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242008AbjFMKrm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 06:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238981AbjFMKrk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:47:40 -0400
Received: from mx4.veeam.com (mx4.veeam.com [104.41.138.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96811AC;
        Tue, 13 Jun 2023 03:47:39 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id D96E25E91D;
        Tue, 13 Jun 2023 13:47:37 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx4-2022; t=1686653258;
        bh=Z7dNDDmcpifePckvcqW3TSCqfRweG1amD84n3lPragY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To:From;
        b=G81g0nM4EYIPIQEClVwgOGTxMajn0Ko1zyPiCrWwoKHprdoEd8oLiDEE4qaLbjrNp
         VZe0PpeeqGdLTgyqAMv2gCODJvMXr18nCaOsz5uCa+B6EVY6YO7LbLYxubvuHknSLw
         +Sf5GD/P3f4ElvgLDl6C+02x/jeBbE/ecien7pvE44117yMV9PhA7S0lDmEpnYXF1G
         6w/xdup9AYJbf4dvxFFT1pjLUWh9USwm94QAnCU0vDSOYXuecjsgmOwttyBomuIiva
         j+SLkf2kWAH5bumQnimtvQ79U7Qj5xta8aMXLkRzurdwUqt6I0ADNfdWYQuOrjvf9f
         O6tUHBnRi4eww==
Received: from [172.24.10.107] (172.24.10.107) by prgmbx01.amust.local
 (172.24.128.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 13 Jun
 2023 12:47:36 +0200
Message-ID: <7dbbaf60-c85d-5a7a-8f16-5f5e4ff43cd8@veeam.com>
Date:   Tue, 13 Jun 2023 12:47:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 11/11] blksnap: Kconfig and Makefile
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, <axboe@kernel.dk>,
        <hch@infradead.org>, <corbet@lwn.net>, <snitzer@kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <willy@infradead.org>, <dlemoal@kernel.org>, <wsa@kernel.org>,
        <heikki.krogerus@linux.intel.com>, <ming.lei@redhat.com>,
        <gregkh@linuxfoundation.org>, <linux-block@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20230609115858.4737-1-sergei.shtepa@veeam.com>
 <20230609115858.4737-11-sergei.shtepa@veeam.com>
 <499ded51-3fb8-f11b-8776-08ab2e9a8812@infradead.org>
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
In-Reply-To: <499ded51-3fb8-f11b-8776-08ab2e9a8812@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A29240315546D7163
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/13/23 01:43, Randy Dunlap wrote:
>> +config BLKSNAP
>> +	tristate "Block Devices Snapshots Module (blksnap)"
>> +	help
>> +	  Allow to create snapshots and track block changes for block devices.
>> +	  Designed for creating backups for simple block devices. Snapshots are
>> +	  temporary and are released then backup is completed. Change block
> 	                             when backup is completed.
> 
> or is the order of operations as listed: release snapshots and then backup
> can be completed?
> 
>> +	  tracking allows to create incremental or differential backups.

"when backup is completed." - it will be more correct.

Normal backup process:

Take snapshot                                        Release snapshot
    |    Start backup                        Finish backup   |
    |        |  Copy data from snapshot images    |          |
------------------------------------------------------------------------->
                                                                         t

In case of failure, for example, when the snapshot is overflowing:

                                           The snapshot is corrupted
Take snapshot                                   | Release snapshot
    |    Start backup                           |   | Finish failed backup
    |        |  Copy data from snapshot images  |   |    |
------------------------------------------------------------------------->
                                                                         t
