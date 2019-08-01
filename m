Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49F577D963
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 12:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbfHAKbG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 06:31:06 -0400
Received: from mailout-taastrup.gigahost.dk ([46.183.139.199]:58490 "EHLO
        mailout-taastrup.gigahost.dk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729266AbfHAKbG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 06:31:06 -0400
X-Greylist: delayed 568 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Aug 2019 06:31:05 EDT
Received: from mailout.gigahost.dk (mailout.gigahost.dk [89.186.169.112])
        by mailout-taastrup.gigahost.dk (Postfix) with ESMTP id 1CBAB18903FE;
        Thu,  1 Aug 2019 10:21:26 +0000 (UTC)
Received: from smtp.gigahost.dk (smtp.gigahost.dk [89.186.169.109])
        by mailout.gigahost.dk (Postfix) with ESMTP id 46ABD782B5B;
        Thu,  1 Aug 2019 10:21:35 +0000 (UTC)
Received: by smtp.gigahost.dk (Postfix, from userid 1000)
        id E57CE2721A8F; Thu,  1 Aug 2019 10:21:25 +0000 (UTC)
X-Screener-Id: 5857e2a064aad267b6e1bd03c61cb04f8a07a3e3
Received: from [10.0.0.207] (085083064049.dynamic.telenor.dk [85.83.64.49])
        by smtp.gigahost.dk (Postfix) with ESMTPSA id 734332721A0D;
        Thu,  1 Aug 2019 10:21:25 +0000 (UTC)
Subject: Re: UDF filesystem image with Write-Once UDF Access Type
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Jan Kara <jack@suse.cz>
Cc:     "Steven J. Magnani" <steve.magnani@digidescorp.com>,
        Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190712100224.s2chparxszlbnill@pali>
 <20190801073530.GA25064@quack2.suse.cz>
 <20190801084411.l4uv7xrb5ilouuje@pali>
From:   Roald Strauss <mr_lou@dewfall.dk>
Message-ID: <294d59b9-67e8-9984-b80b-0a7c44f1707c@dewfall.dk>
Date:   Thu, 1 Aug 2019 12:21:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801084411.l4uv7xrb5ilouuje@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey all


I'm a bit pressed for time these days, so I won't be able to do any 
tests any time soon.

Also have to admit that I lost interest in UDF a bit, since we ended up 
looking towards hardware solutions for write-protections instead.

But when/if mkudffs includes an option to create a write-once / 
read-only filesystem while adding files to it at the same time (because 
how else am I gonna put files onto my read-only filesystem?), then it 
might become interesting again.


- Roald




Den 01/08/2019 kl. 10.44 skrev Pali Rohár:
> On Thursday 01 August 2019 09:35:30 Jan Kara wrote:
>> On Fri 12-07-19 12:02:24, Pali Rohár  wrote:
>>> Also in git master of udftools has mkduffs now new option --read-only
>>> which creates UDF image with Read-Only Access Type.
>> I've tested this and the kernel properly mounts the image read-only.
> Roald, can you test that problem which you described to me with
> read-only access type is now correctly fixed?
>
