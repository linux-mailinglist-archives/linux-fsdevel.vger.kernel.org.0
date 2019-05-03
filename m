Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 389E31280C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 08:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfECGvu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 02:51:50 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32924 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726182AbfECGvu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 02:51:50 -0400
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 1F5BFADAC147873D12BC;
        Fri,  3 May 2019 07:51:49 +0100 (IST)
Received: from [10.204.65.144] (10.204.65.144) by smtpsuk.huawei.com
 (10.201.108.35) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 3 May
 2019 07:51:45 +0100
Subject: Re: [PATCH V2 3/4] IMA: Optionally make use of filesystem-provided
 hashes
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Garrett <mjg59@google.com>
CC:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        <linux-fsdevel@vger.kernel.org>, <miklos@szeredi.hu>
References: <20190226215034.68772-1-matthewgarrett@google.com>
 <1551923650.31706.258.camel@linux.ibm.com>
 <CACdnJuv+d2qEc+vQosmDOzdu57Jjpjq9-CZEy8epz0ob5mptsA@mail.gmail.com>
 <1551991690.31706.416.camel@linux.ibm.com>
 <CACdnJuvkA6M_fu3+BARH2AMHksTXbvWmRyK9ZaxcH-xZMq4G2g@mail.gmail.com>
 <CACdnJuv2zV1OnbVaHqkB2UU=dAEzzffajAFg_xsgXRMvuZ5fTw@mail.gmail.com>
 <1554416328.24612.11.camel@HansenPartnership.com>
 <CACdnJutZzJu7FxcLWasyvx9BLQJeGrA=7WA389JL8ixFJ6Skrg@mail.gmail.com>
 <1554417315.24612.15.camel@HansenPartnership.com>
 <CACdnJuutKe+i8KLUmPWjbFOWfrO2FzYVPjYZGgEatFmZWkw=UA@mail.gmail.com>
 <1554431217.24612.37.camel@HansenPartnership.com>
 <CACdnJut_vN9pJXq-j9fEO1CFZ-Aq83cO2LiFmep=Fn9_NOKhWQ@mail.gmail.com>
 <CACdnJusKM74vZ=zg+0fe50gNRVaDPCdw9mfbbq45yTqnZfZX5w@mail.gmail.com>
 <1556828700.4134.128.camel@linux.ibm.com>
 <CACdnJutAw02Hq=NDeHoSsZAh2D95EBag_U8GYoSfNJ7eM61OxQ@mail.gmail.com>
 <1556838167.7067.9.camel@linux.ibm.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <6fc66a58-2d34-e8cc-ee01-ec04c85196eb@huawei.com>
Date:   Fri, 3 May 2019 08:51:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1556838167.7067.9.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.65.144]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/3/2019 1:02 AM, Mimi Zohar wrote:
> On Thu, 2019-05-02 at 15:37 -0700, Matthew Garrett wrote:
>> On Thu, May 2, 2019 at 1:25 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>>> Suppose instead of re-using the "d-ng" for the vfs hash, you defined a
>>> new field named d-vfs.  Instead of the "ima-ng" or "d-ng|n-ng", the
>>> template name could be "d-vfs|n-ng".
>>
>> Is it legitimate to redefine d-ng such that if the hash comes from the
>> filesystem it adds an additional prefix? This will only occur if the
>> admin has explicitly enabled the trusted_vfs option, so we wouldn't
>> break any existing configurations. Otherwise, I'll look for the
>> cleanest approach for making this dynamic.
> 
> I would assume modifying d-ng would break existing attestation
> servers.

Yes, I would also prefer to avoid modification of d-ng.


> Perhaps instead of making the template format dynamic based on fields,
> as I suggested above, define a per policy rule template format option.

This should not be too complicated. The template to use will be returned
by ima_get_action() to process_measurement().

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
