Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0A643955E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 13:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhJYL52 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 07:57:28 -0400
Received: from mailin.dlr.de ([194.94.201.12]:39488 "EHLO mailin.dlr.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231895AbhJYL51 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 07:57:27 -0400
X-IPAS-Result: =?us-ascii?q?A2EmAACCmnZh/xaKuApaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UUHAQELAYMKgVcLjGCIcIIlmX+BfAsBAQEBAQEBAQEIAUEEAQGFAAKCUSY0C?=
 =?us-ascii?q?Q4BAgQBAQEBAwIDAQEBAQEBAwEBBgEBAQEBAQUEAQECgSCFL0aCNSKDdAEBA?=
 =?us-ascii?q?QEDOj8MBAIBCBEEAQEBHhAyHQgBAQQOBQixMHiBM4EBhGmFD4E6AYV8VIdFg?=
 =?us-ascii?q?lCBFYMqPoRMRoUwBI0/gnJqvx8HggmgEi8VlWuRMZYMoHOFCQIEAgQFAhaBY?=
 =?us-ascii?q?YIVcYM4URcCD5xwdDgCBgsBAQMJkV+BEAEB?=
IronPort-PHdr: A9a23:XB7DyhMWq84mYf5SnjQl6nbuDRdPi9zP1u491JMrhvp0f7i5+Ny6Z
 QqDv60r1gSUFtmBo9t/yMPu+5j6XmIB5ZvT+FsjS7drEyE/tMMNggY7C9SEA0CoZNTjbig9A
 dgQHAQ9pyLzPkdaAtvxaEPPqXOu8zESBg//NQ1oLejpB4Lelcu62/6u95HJfQlFijqwbbx9I
 RmosA7cqtQYjYx+J6gr1xDHuGFIe+NYxWNpIVKcgRPx7dqu8ZBg7ipdpesv+9ZPXqvmcas4S
 6dYDCk9PGAu+MLrrxjDQhCR6XYaT24bjwBHAwnB7BH9Q5fxri73vfdz1SWGIcH7S60/VDK/5
 KlpVRDokj8KOT4n/m/Klsx+gqFVoByjqBx+34Hab46aOeFifqPEf9MWWXZNUtpPWyFHH4iyb
 5EPD+0EPetAqITwu1oPogGiBQW2HO3v1yVIhnDs0q0+0uQuDx/G0Rc9ENIKqnTYtsj6O7kLX
 O2z0aLHwinNYelM1jfh9IjHbAohofeUUL5uc8fcxlQiGgHbg1iQp4HoIjyb2+cNvmWF8udtV
 +GihnMjpg9/ojWiydkhhInVi44LxF3I6Tl1zZo1K9C4RkN2Z8OvHphItyyCKod6XtkuT3xrt
 Ss10LEKpJC2cSsQxJg52RLTc+GLfoqW7h75SuqdPC10iG9ndb++nRq+7E6twfDmWMauylZFt
 C9Fn8HJtnAKyhPc9NCKSuB4/ke9wTaP0B3T6v1cLUA0i6XbL5khz6Y+mJQVv0rNES/4lkXxg
 qGVcUsq4Pak5/robLrnuJKQLY50igfiMqQ0gMOzG/k3MgwUX2SB5OuzyqXv/Uz/QLpUkv07i
 rTVvIzAKcgGpaO0DBVZ3pst5hu8FTuqzsoUkWECLF1feRKHi4bpO0vJIPD9Ffqyn1Wtny13x
 /zcJrPhH4/NLnfZn7flfLZy9VBcxREuwtBb/ZJYEKwOL+zrVk/rqNPYFgM5MxCzw+v/BtR91
 4ceWWaPA6KCMaPSt1GI5vg1LOaReoAaoivyJ+Ii5/70gn8zgUUdcrWx3ZsLdHC4GexrI0GYY
 Xrqn9cAHn4GvgQlTOP3llKCTyBcZ3KpUqIi6TE0FpimAZ3ARo+zmryB2jm0HplMamBBEFCMH
 iSgS4LRD+gNbCaDCs5nnCYNWbWoR8kmzx745yHgzL8yesPG8zFek4/529Fx5uDNvR0273p4A
 pLOgCm2U2hokzZQFHcN16dlrBklomo=
IronPort-Data: A9a23:njRMcqiK1bIQ9cqF6M2/EY/AX1610RIKZh0ujC45NGQN5FlHY01je
 htvDWyPOqyINzP1c9xwb97noR8AvJ7dzNYyTgVqrHg0RS5jpJueD7x1DKtR0wB+jCHnZBg6h
 ynLQoCYdKjYdleF+lH1dOGJQUBUjclkfJKlYAL/En03FVAMpBsJ00o5wrdh2NMw2LBVPivU0
 T/Mi5yHULOa82MsWo4kw/rrRMRH5amaVJsw5zTSVNgT1LPsvyB94KE3ecldG0DFrrx8RYZWc
 QpiIIaRpQs19z91Yj+sfy2SnkciGtY+NiDW4pZatjTLbrGvaUXe345iXMfwZ3u7hB2StYtw9
 /5Cj6Whah8QY4zTiedGCDlhRnQW0a1uoNcrIFCTleC+4WPjUl7Uma9DPGpwPIsE4O8xDWVUs
 /AVQNwPRknbwbvmnPTiEbkq3J5LwMrDZevzvllJ3zjFS9A7W5/KR6TH+/dU2C12is0m8fP2O
 ptAMmMzN0SojxtnN3YUEbM9kMSShnj9L2J8qniP/ZcK/D2GpOB2+P23WDbPQfSVRMFRj26Zo
 Gzc9mj0Cx1cM8aQoRKB83SxlqrBhi/2Ro8WPKO3++Qsg1CJwGEXThoMWjOGTeKRhkqyVtxRL
 k0R4nB0oLg5sk2tUsP0GRG8ujiIs3bwRuZtLgHz0ynVooK83upTLjFsouJpADD+iPILeA==
IronPort-HdrOrdr: A9a23:oTd/9K3IEFXbQ0aZgEre/QqjBchxeYIsimQD101hICG9Lfb1qy
 n+ppkmPEHP4gr5AEtQ4expOMG7MBHhHO1OkPIs1NaZLUbbUQ6TQ72KgrGSpQEIdxefygc/79
 YvT0EdMqyIMbESt6+Ti2fYLz9J+qjezEnCv5a6854Zd3AMV0gW1XYcNu/0KDwUeCB2Qb4CUL
 aM7MtOoDStPV4NaN6gO3UDV+/f4/XWiZPPe3c9dl8awTjLqQntxK/xEhCe0BtbeShI260e/W
 /MlBG8zrm/ssu81gTX2wbontRrcZrau5h+7f63+40owwbX+0KVjUNaKvq/VQUO0aOSAZAR4Z
 /xSlkbTp1OAjjqDxuISFPWqnTdOXAVmiTfIBaj8AreiM3nXnYxDsJan4JXchHQ9konu7hHod
 129mOHrd5cCBvbhiTz59LBShFtkUq4yEBS7dI7jmNEFZIEZLBQvOUkjT1oOYZFEyTg5I89Fu
 5ySMna+fZNaFufK2vUp2913bWXLz4O97i9Mz0/U+GuonBrdUpCvgAlLQ0k7wM93YN4T4MB6/
 XPM6xumr0LRsgKbbhlDONERcesEGTCTR/FLWrXeD3cZe06EmOIr4Sy7KQ+5emsdpBNxJwumI
 7ZWFcdsWIpYUrhBcCHwZUO+BHQR2e2Wyjr16hlltVEk6y5QKCuPTyISVgoncflq/IDAtfDU/
 L2I55SC++LFxqmJW+I5XyJZ3B/EwhsbCQlgKdNZ7vVmLO6FmTDjJ2oTMru
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.87,180,1631570400"; 
   d="scan'208";a="59131438"
From:   <Azat.Nurgaliev@dlr.de>
To:     <willy@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>
Subject: RE: Turn off readahead completely
Thread-Topic: Turn off readahead completely
Thread-Index: AdfGfdxpjOk8ymokTbSOj+D6SC4J2///4Z2A//mxatA=
Date:   Mon, 25 Oct 2021 11:55:03 +0000
Message-ID: <066d9015e3c44c3a84eca5886d80bf04@dlr.de>
References: <8aa213d5d5464236b7e47aaa6bb93bb8@dlr.de>
 <YXFq0QYhDBQC5G0l@casper.infradead.org>
In-Reply-To: <YXFq0QYhDBQC5G0l@casper.infradead.org>
Accept-Language: en-GB, en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tm-snts-smtp: B8D0AED6DE5C26BA26EB8361495BDAF07D67EA907957A0C7C620EA8FC6B65CB12000:8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thank you for the reply, Matthew.

I'm experimenting with GDAL and, in particular, working on improving the I/O performance of geo-applications.
I wanted to get more control from the application over how the kernel handles I/O requests.
But basically all the optimizations are hidden in readahead. Whatever requests are executed are all translated into readahead.

It would be very useful to be able to evaluate the difference with more fine-grained control on the application side.

-----Original Message-----
From: Matthew Wilcox <willy@infradead.org> 
Sent: Donnerstag, 21. Oktober 2021 15:28
To: Nurgaliev, Azat <Azat.Nurgaliev@dlr.de>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: Turn off readahead completely

On Thu, Oct 21, 2021 at 01:16:46PM +0000, Azat.Nurgaliev@dlr.de wrote:
> Hello everyone,
> 
> I need to turn readahead off completely in order to do my experiments. 
> Is there any way to turn it off completely?
> 
> Setting /sys/block/<dev>/queue/read_ahead_kb to 0 causes readahead to become 4kb.

That's entirely intentional.  What experiment are you actually trying to perform?
