Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86B1260CF0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 10:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbgIHID7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 04:03:59 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43478 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729566AbgIHICB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:02:01 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CC0F86FC8FB9F0E75DEE;
        Tue,  8 Sep 2020 16:01:59 +0800 (CST)
Received: from [10.67.102.197] (10.67.102.197) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 8 Sep 2020 16:01:49 +0800
To:     <jack@suse.cz>, <amir73il@gmail.com>
CC:     <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <wangle6@huawei.com>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Subject: Question: Why is there no notification when a file is opened using
 filp_open()?
Message-ID: <25817189-49a7-c64f-26ee-78d4a27496b6@huawei.com>
Date:   Tue, 8 Sep 2020 16:01:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The file opening action on the system may be from user-mode sys_open() 
or kernel-mode filp_open().
Currently, fsnotify_open() is invoked in do_sys_openat2().
But filp_open() is not notified. Why? Is this an omission?

Do we need to call fsnotify_open() in filp_open() or  do_filp_open() to 
ensure that both user-mode and kernel-mode file opening operations can 
be notified?

Thanks
Xiaoming Ni
