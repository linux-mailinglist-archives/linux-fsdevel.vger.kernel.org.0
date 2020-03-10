Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFAA17F782
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 13:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCJMe3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 08:34:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11205 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726269AbgCJMe2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:34:28 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5156D9D3176ACC83AB8A
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2020 20:34:27 +0800 (CST)
Received: from [10.173.111.60] (10.173.111.60) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 10 Mar
 2020 20:34:26 +0800
Subject: Re: [RFC][QUESTION] fuse: how to enlarge the max pages per request
To:     <miklos@szeredi.hu>
References: <6149dfe9-1389-ada6-05db-eb71b989dcb2@huawei.com>
CC:     <linux-fsdevel@vger.kernel.org>
From:   piaojun <piaojun@huawei.com>
Message-ID: <c089d598-c67e-b520-c41b-8f92990e96b9@huawei.com>
Date:   Tue, 10 Mar 2020 20:34:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <6149dfe9-1389-ada6-05db-eb71b989dcb2@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.111.60]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ping?

On 2020/3/10 18:03, piaojun wrote:
> Hi Miklos,
> 
>>From my test, a fuse write req can only contain 128KB which seems
> limited by FUSE_DEFAULT_MAX_PAGES_PER_REQ in kernel. I wonder if I
> could enlarge this macro to get more bandwidth, or some other adaption
> should be done?
> 
> Up to now, many userspace filesystem is designed for big data which
> needs big bandwidth, such as 2MB or more. So could we add a feature to
> let the user config the max pages per request? Looking forward for your
> reply.
> 
> Thanks,
> Jun
> 
