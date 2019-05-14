Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58AC61CE31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 19:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfENRok (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 13:44:40 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32941 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726229AbfENRok (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 13:44:40 -0400
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 9D28C725DEC5245686F9;
        Tue, 14 May 2019 18:44:38 +0100 (IST)
Received: from [10.220.96.108] (10.220.96.108) by smtpsuk.huawei.com
 (10.201.108.34) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 14 May
 2019 18:44:35 +0100
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
To:     Arvind Sankar <nivedita@alum.mit.edu>
CC:     Rob Landley <rob@landley.net>,
        Arvind Sankar <niveditas98@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <initramfs@vger.kernel.org>
References: <dca50ee1-62d8-2256-6fdb-9a786e6cea5a@landley.net>
 <20190512194322.GA71658@rani.riverdale.lan>
 <3fe0e74b-19ca-6081-3afe-e05921b1bfe6@huawei.com>
 <4f522e28-29c8-5930-5d90-e0086b503613@landley.net>
 <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
 <49965ffd-dd57-ffe5-4a2f-73cdfb387848@landley.net>
 <de91ef53-6bb3-b937-8773-5f6b34e1acb7@huawei.com>
 <20190514152704.GB37109@rani.riverdale.lan>
 <20190514155739.GA70223@rani.riverdale.lan>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <ca622341-5ea2-895e-8b82-7181a709c104@huawei.com>
Date:   Tue, 14 May 2019 19:44:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190514155739.GA70223@rani.riverdale.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.220.96.108]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/14/2019 5:57 PM, Arvind Sankar wrote:
> On Tue, May 14, 2019 at 11:27:04AM -0400, Arvind Sankar wrote:
>> It's also much easier to change/customize it for the end
>> system's requirements rather than setting the process in stone by
>> putting it inside the kernel.
> 
> As an example, if you allow unverified external initramfs, it seems to
> me that it can try to play games that wouldn't be prevented by the
> in-kernel code: setup /dev in a weird way to try to trick /init, or more
> easily, replace /init by /bin/sh so you get a shell prompt while only
> the initramfs is loaded. It's easy to imagine that a system would want
> to lock itself down to prevent abuses like this.

Yes, these issues should be addressed. But the purpose of this patch set
is simply to set xattrs. And existing protection mechanisms can be
improved later when the basic functionality is there.


> So you might already want an embedded initramfs that can be trusted and
> that can't be overwritten by an external one even outside the
> security.ima stuff.

The same problems exist also the root filesystem. These should be solved
regardless of the filesystem used, for remote attestation and for local
enforcement.

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
