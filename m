Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18C929E550
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 08:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbgJ2H4S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 03:56:18 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:46885 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727521AbgJ2Hzv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:55:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=zoucao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UDWpOpj_1603958147;
Received: from ali-6c96cfe06eab.local(mailfrom:zoucao@linux.alibaba.com fp:SMTPD_---0UDWpOpj_1603958147)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 29 Oct 2020 15:55:48 +0800
Subject: Re: [PATCH 1/2] fs:regfs: add register easy filesystem
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <1603175408-96164-1-git-send-email-zoucao@linux.alibaba.com>
 <00513aa5-1cc5-bc1c-1ca7-d5cd6e3f1ed6@linux.alibaba.com>
 <fe9f0382-da87-77ab-75ab-5a4bec0a9a21@linux.alibaba.com>
 <20201029024435.GO3576660@ZenIV.linux.org.uk>
From:   zc <zoucao@linux.alibaba.com>
Message-ID: <46ef0656-ecf6-6ce2-564d-914c79f37561@linux.alibaba.com>
Date:   Thu, 29 Oct 2020 15:55:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201029024435.GO3576660@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2020/10/29 上午10:44, Al Viro 写道:
> On Wed, Oct 28, 2020 at 02:27:20PM +0800, zc wrote:
>> Hi viro:
>>
>>     have time for reviewing this?
> Start with removing unused boilerplate.  When quite a chunk
> of the codebase is simply never used, filtering _that_ out
> is on the author, not reviewers.

sorry, i will remove these unused boilerplat.

Regsards,

zoucao

