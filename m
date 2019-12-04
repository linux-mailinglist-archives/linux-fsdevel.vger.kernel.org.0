Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB15D1136CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 21:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbfLDUxa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 15:53:30 -0500
Received: from mail.phunq.net ([66.183.183.73]:47278 "EHLO phunq.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727889AbfLDUxa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 15:53:30 -0500
Received: from [172.16.1.14]
        by phunq.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.92.3)
        (envelope-from <daniel@phunq.net>)
        id 1icbeK-0007Yx-JU; Wed, 04 Dec 2019 12:53:28 -0800
Subject: Re: [RFC] Thing 1: Shardmap fox Ext4
From:   Daniel Phillips <daniel@phunq.net>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <176a1773-f5ea-e686-ec7b-5f0a46c6f731@phunq.net>
 <20191127142508.GB5143@mit.edu>
 <6b6242d9-f88b-824d-afe9-d42382a93b34@phunq.net>
 <6C8DAF47-CA09-4F3B-BF32-2D7044C1EE78@dilger.ca>
 <22c57727-2826-8945-1964-66e66fe82d39@phunq.net>
Message-ID: <57e71e35-b3a4-67e8-d5db-af3b41e9230a@phunq.net>
Date:   Wed, 4 Dec 2019 12:53:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <22c57727-2826-8945-1964-66e66fe82d39@phunq.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019-12-04 12:47 p.m., Daniel Phillips wrote:
> On 2019-12-04 10:03 a.m., Andreas Dilger wrote:
>>> Here is a pretty picture to get started:
>>>
>>>     https://github.com/danielbot/Shardmap/wiki/Shardmap-media-format
>>
>> The shardmap diagram is good conceptually, but it would be useful
>> to add a legend on the empty side of the diagram that shows the on-disk
>> structures.
> 
> Sounds good, but not sure exactly what you had in mind. Fields of a
> shard entry? Fields of the block 0 header? The record entry block has
> its own diagram, and is polymorphic anyway, so no fixed format.

Ah, the legend can explain that lower tier shard 2 is in process of
being split into upper tier shards 4 and 5, and label the shards
with offset numbers.
