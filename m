Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93B9E22E33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 10:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbfETIRA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 04:17:00 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32954 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729496AbfETIRA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 04:17:00 -0400
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 7536EA16AA066197D4C3;
        Mon, 20 May 2019 09:16:58 +0100 (IST)
Received: from [10.220.96.108] (10.220.96.108) by smtpsuk.huawei.com
 (10.201.108.37) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 20 May
 2019 09:16:52 +0100
Subject: Re: [PATCH v3 2/2] initramfs: introduce do_readxattrs()
To:     Arvind Sankar <nivedita@alum.mit.edu>
CC:     <hpa@zytor.com>, <viro@zeniv.linux.org.uk>,
        <linux-security-module@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <initramfs@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <zohar@linux.vnet.ibm.com>,
        <silviu.vlasceanu@huawei.com>, <dmitry.kasatkin@huawei.com>,
        <takondra@cisco.com>, <kamensky@cisco.com>, <arnd@arndb.de>,
        <rob@landley.net>, <james.w.mcmechan@gmail.com>,
        <niveditas98@gmail.com>
References: <20190517165519.11507-1-roberto.sassu@huawei.com>
 <20190517165519.11507-3-roberto.sassu@huawei.com>
 <CD9A4F89-7CA5-4329-A06A-F8DEB87905A5@zytor.com>
 <20190517210219.GA5998@rani.riverdale.lan>
 <20190517211014.GA9198@rani.riverdale.lan>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <cee53f00-a216-0666-0774-0f3ebf1b1292@huawei.com>
Date:   Mon, 20 May 2019 10:16:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190517211014.GA9198@rani.riverdale.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.220.96.108]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/17/2019 11:10 PM, Arvind Sankar wrote:
> On Fri, May 17, 2019 at 05:02:20PM -0400, Arvind Sankar wrote:
>> On Fri, May 17, 2019 at 01:18:11PM -0700, hpa@zytor.com wrote:
>>>
>>> Ok... I just realized this does not work for a modular initramfs, composed at load time from multiple files, which is a very real problem. Should be easy enough to deal with: instead of one large file, use one companion file per source file, perhaps something like filename..xattrs (suggesting double dots to make it less likely to conflict with a "real" file.) No leading dot, as it makes it more likely that archivers will sort them before the file proper.
>> This version of the patch was changed from the previous one exactly to deal with this case --
>> it allows for the bootloader to load multiple initramfs archives, each
>> with its own .xattr-list file, and to have that work properly.
>> Could you elaborate on the issue that you see?
> Roberto, are you missing a changelog entry for v2->v3 change?

The changelog for v1->v2 is missing.

Thanks

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
