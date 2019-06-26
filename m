Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA480567C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 13:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfFZLiX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 07:38:23 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33036 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726077AbfFZLiX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 07:38:23 -0400
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 9E9C615522E748CA3604;
        Wed, 26 Jun 2019 12:38:21 +0100 (IST)
Received: from [10.220.96.108] (10.220.96.108) by smtpsuk.huawei.com
 (10.201.108.35) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 26 Jun
 2019 12:38:12 +0100
Subject: Re: [PATCH v4 00/14] ima: introduce IMA Digest Lists extension
To:     Mimi Zohar <zohar@linux.ibm.com>, <dmitry.kasatkin@huawei.com>,
        <mjg59@google.com>, Rob Landley <rob@landley.net>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>
References: <20190614175513.27097-1-roberto.sassu@huawei.com>
 <9029dd14-1077-ec89-ddc2-e677e16ad314@huawei.com>
 <88d368e6-5b3c-0206-23a0-dc3e0aa385f0@huawei.com>
 <1561484133.4066.16.camel@linux.ibm.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <19b082d1-b36e-bcbf-b25a-6d0969c9b638@huawei.com>
Date:   Wed, 26 Jun 2019 13:38:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1561484133.4066.16.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.220.96.108]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/25/2019 7:35 PM, Mimi Zohar wrote:
> [Cc'ing Rob Landley]
> 
> On Tue, 2019-06-25 at 14:57 +0200, Roberto Sassu wrote:
>> Mimi, do you have any thoughts on this version?
> 
> I need to look closer, but when I first looked these changes seemed to
> be really invasive.  Let's first work on getting the CPIO xattr

If you can provide early comments, that would be great. I'll have a look
at the problems and when the xattr support for the ram disk is
upstreamed I will be ready to send a new version.

Thanks

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
