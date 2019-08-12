Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A83FE8A00D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 15:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfHLNt4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 09:49:56 -0400
Received: from UHIL19PA35.eemsg.mail.mil ([214.24.21.194]:52131 "EHLO
        UHIL19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfHLNtz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:49:55 -0400
X-EEMSG-check-017: 11718142|UHIL19PA35_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,377,1559520000"; 
   d="scan'208";a="11718142"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Aug 2019 13:49:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1565617793; x=1597153793;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=XI4obDbT5jxk8krhNUG+JCTxrf4Ynwc9uGtR2DBTVBQ=;
  b=CMBu7K6LbJas4FWCbM6+ddKmsIHsqsiKusFaBMbj6wP1Ph5/BVBmQoET
   MF8GPbDJwHTSfh/0fgMUkopvQFvy3JhEuEHn1qHogYcgHbCbNbXiC1rJt
   sAF9iFwy6NPj7HjvLADRHJEFCEhq63aCSvgN78GiZlQIao0XcJXgWBzb0
   Raq/ZyRhOMkQP5hFWbIqWjpqTeJK6R5yBlRIcbHhVhYcNmPN2rUFmatrA
   GwBq33IfsTulLoMN3Jf94y0UC+tThJwDtk1SU0NRNv2vBbL9ks3hQBfvj
   +6kyvbJM3hg8Wy+hP2txNPsrL4hP0NhP1Jx/49uISZHgew5nsAAiGl8Vo
   Q==;
X-IronPort-AV: E=Sophos;i="5.64,377,1559520000"; 
   d="scan'208";a="31341783"
IronPort-PHdr: =?us-ascii?q?9a23=3AuMvjtxUSylWIjoDNQgJY/X79pGzV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZReFuqdThVPEFb/W9+hDw7KP9fy5AypZu8rK7i1KWacPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sBvdutMLjYd8Jas9xR?=
 =?us-ascii?q?rEr3tVcOlK2G1kIk6ekQzh7cmq5p5j9CpQu/Ml98FeVKjxYro1Q79FAjk4Km?=
 =?us-ascii?q?45/MLkuwXNQguJ/XscT34ZkgFUDAjf7RH1RYn+vy3nvedgwiaaPMn2TbcpWT?=
 =?us-ascii?q?S+6qpgVRHlhDsbOzM/7WrakdJ7gr5Frx29phx/24/Ub5+TNPpiZaPWYNcWSX?=
 =?us-ascii?q?NcUspNSyBNB4WxYIUVD+oFIO1WsY/zqVUTphe6HAWhCufixjpOi3Tr36M1zv?=
 =?us-ascii?q?4hHBnb0gI+EdIAsHfaotv7O6gdU++60KbGwC7fb/5Uwzrx9JTEfx4jrPyKQL?=
 =?us-ascii?q?l+cdDRyU4qFw7dklifs5blPzST1u8Qsmab6OtgWv+xhG4jtgp8pSKgydsjio?=
 =?us-ascii?q?nOh4Ia107L+D5lwIc1OdK4SEl7bcSiEJtLrS6WLYR2QsQ8Q2xxvisx174IuY?=
 =?us-ascii?q?ajcSQXx5kqyATTZvyaf4SS/B7uW/idLS1liH9jZbmxnQy98VK6xe35TsS01V?=
 =?us-ascii?q?FKoTdbndTUrXAN0gDT6tCASvtg4ketwTaP2B7X6uFDOU00ibDUK4Qgwr4tjZ?=
 =?us-ascii?q?ofq1jDHy/ql0X2i6+abEMk9fSz6+v7eLnmo56cN4tshgH/NKQhhNC/DPwlPg?=
 =?us-ascii?q?UBUGWX4+Sx2KD58UHnT7hGkOc6nrTBvJDfP8sbp6q5AwFP0oYk7hayFy2p38?=
 =?us-ascii?q?gXnXkALVJKZQyIgpP1O1DOPP/4DfC/j06qkDdw3f/KJLLhApLTLnTbirfuYa?=
 =?us-ascii?q?5961JAyAo01d1f5YhbBa0CIP/oQU/xqcfYAQEjPwOowuftEM992Z8GWWKTHq?=
 =?us-ascii?q?+ZN7vfsUeS6eIyJ+mBf5cVtyzgK/gh/vLuiHg5mVgHfaa3x5cYdHe4HvF+KU?=
 =?us-ascii?q?WDfXXsmssBEXsNvgcmVuPqjVyCUSRRanu8XqI84io2CI2jDYjZR4CthKaN0z?=
 =?us-ascii?q?u8Hp1TfmpGEEyDEW/0d4WYXPcBcDmSLdFlkjwFU7ihVoAg2AqwtA/11bVnNP?=
 =?us-ascii?q?DY+i4GupL50th6+enTmQs19TxuAMSXy3uNQH1snmMUWz8227hyoUh8yleFzK?=
 =?us-ascii?q?h5jOVUFcdN6PxVTwc6L5/cz/B6CtzrXwLBecqGSEuiQtq4GjwxUN0xzMEUY0?=
 =?us-ascii?q?pnGNWtkArD3yy0DL8RjbCLA4Y08q3E1XjrO8l902rG1LUmj1Q+RstPNGumhr?=
 =?us-ascii?q?Nw9gTKCY7JiFiWmLi0dasC2C7A73mDzWWQs0FCSgJwUrvKXWoZZkTIqdT1/E?=
 =?us-ascii?q?TCT6WhCb4/KAtO1daCKrdWat3ulVhJWffjONPQYm2vn2ewAQ2Iy6iWbIX0Zm?=
 =?us-ascii?q?od3D/SCFQenw8P+naGMBA0Bj29rGLGEDxuCVXvblvu8el7r3O7VFU0zwCRb0?=
 =?us-ascii?q?B60bq64BsViuKdS/8J2bIEoighoS1uHFmhx9LWF8aApw15caVYYNM95kpH1G?=
 =?us-ascii?q?3Auwx+IJOgNaZiiUAacwlsoUPu2At4Cp9ancgpsnwq1gxyJryc0F9bcDOYx5?=
 =?us-ascii?q?/wafXrLTzQ9RbnSKfM0xmK0t+d+Y8U9e817V7x6kXhLkM/9z1C1N5P3jPI/p?=
 =?us-ascii?q?zXCCIKWI/1F0Mw8AJ34brdZ39uyZnT0ChFOLOztHft3NMlCe9tnh+rcNBePK?=
 =?us-ascii?q?6sCB75E8pcAdOnbuMthQ76PVo/IOlO+ftsbIudfPyc1fvuZb0xkQ=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AFEwALbVFd/wHyM5BmHAEBAQQBAQcEAQGBZ4FuKoE/M?=
 =?us-ascii?q?iqEHo8lUQEBBoE2iVwOjzqBZwkBAQEBAQEBAQE0AQIBAYQ/AoJuIzgTAQQBA?=
 =?us-ascii?q?QEEAQEDAQkBAWyFM4I6KQGCZwECAyMVNgkCEAsOCgICHwcCAiE2BgEMBgIBA?=
 =?us-ascii?q?YJfP4FrAwkUq1SBMoVJgjMNX4FJgQwoi2QXeIEHgTiCaz6CGoF3ARIBgyqCW?=
 =?us-ascii?q?ASOXIY9lW5ACYIfkDmDcwYbgjCHL45ejVWJV5A7IWdxKwgCGAghDzuCbIJ6j?=
 =?us-ascii?q?ikjAzCBBgEBjBSCQwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 12 Aug 2019 13:49:52 +0000
Received: from moss-callisto.infosec.tycho.ncsc.mil (moss-callisto [192.168.25.136])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x7CDnp0H028739;
        Mon, 12 Aug 2019 09:49:51 -0400
Subject: Re: [Non-DoD Source] Re: [PATCH] fanotify, inotify, dnotify,
 security: add security hook for fs notifications
To:     Jan Kara <jack@suse.cz>, Paul Moore <paul@paul-moore.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20190731153443.4984-1-acgoide@tycho.nsa.gov>
 <CAHC9VhQUoDwBiLi+BiW=_Px18v3xMhhGYDD2mLdu9YZJDWw1yg@mail.gmail.com>
 <CAOQ4uxigYZunXgq0BubRFNM51Kh_g3wrtyNH77PozUX+3sM=aQ@mail.gmail.com>
 <CAHC9VhRpTuL2Lj1VFwHW4YLpx0hJVSxMnXefooHqsxpEUg6-0A@mail.gmail.com>
 <CAOQ4uxiGNXbZ-DWeXTkNM4ySFbBbo1XOF1=3pjknsf+EjbNuOw@mail.gmail.com>
 <16c7c0c4a60.280e.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <20190812134145.GA11343@quack2.suse.cz>
From:   Aaron Goidel <acgoide@tycho.nsa.gov>
Message-ID: <f03baf3a-d688-b949-09e3-5c2beb2f6f07@tycho.nsa.gov>
Date:   Mon, 12 Aug 2019 09:49:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190812134145.GA11343@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/12/19 9:41 AM, Jan Kara wrote:
> On Sat 10-08-19 11:01:16, Paul Moore wrote:
>> On August 10, 2019 6:05:27 AM Amir Goldstein <amir73il@gmail.com> wrote:
>>
>>>>>> Other than Casey's comments, and ACK, I'm not seeing much commentary
>>>>>> on this patch so FS and LSM folks consider this your last chance - if
>>>>>> I don't hear any objections by the end of this week I'll plan on
>>>>>> merging this into selinux/next next week.
>>>>>
>>>>> Please consider it is summer time so people may be on vacation like I was...
>>>>
>>>> This is one of the reasons why I was speaking to the mailing list and
>>>> not a particular individual :)
>>>
>>> Jan is fsnotify maintainer, so I think you should wait for an explicit ACK
>>> from Jan or just merge the hook definition and ask Jan to merge to
>>> fsnotify security hooks.
>>
>> Aaron posted his first patch a month ago in the beginning of July and I
>> don't recall seeing any comments from Jan on any of the patch revisions.
>> I would feel much better with an ACK/Reviewed-by from Jan, or you - which
>> is why I sent that email - but I'm not going to wait forever and I'd like
>> to get this into -next soon so we can get some testing.
> 
> Yeah, sorry for the delays. I'm aware of the patch but I was also on
> vacation and pretty busy at work so Amir always beat me in commenting on
> the patch and I didn't have much to add. Once Aaron fixes the latest
> comments from Amir, I'll give the patch the final look and give my ack.
> 
> 								Honza
> 

I already re-spun the patch with the changes Amir and I agreed to. There 
was an email with the PATCH v2. It may have flown under the radar a bit, 
so just wanted to point that out.
-- 
Aaron
