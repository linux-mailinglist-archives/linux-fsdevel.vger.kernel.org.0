Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE6D11615B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2019 11:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfLHKZ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Dec 2019 05:25:26 -0500
Received: from mail.phunq.net ([66.183.183.73]:53070 "EHLO phunq.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfLHKZZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Dec 2019 05:25:25 -0500
Received: from [172.16.1.14]
        by phunq.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.92.3)
        (envelope-from <daniel@phunq.net>)
        id 1idtkg-000500-DD; Sun, 08 Dec 2019 02:25:22 -0800
Subject: Re: [RFC] Thing 1: Shardmap fox Ext4
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <176a1773-f5ea-e686-ec7b-5f0a46c6f731@phunq.net>
 <20191127142508.GB5143@mit.edu>
 <c3636a43-6ae9-25d4-9483-34770b6929d0@phunq.net>
 <20191128022817.GE22921@mit.edu>
From:   Daniel Phillips <daniel@phunq.net>
Message-ID: <3b4d380f-cb33-b0fb-2426-67109875ce77@phunq.net>
Date:   Sun, 8 Dec 2019 02:25:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191128022817.GE22921@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-11-27 6:28 p.m., Theodore Y. Ts'o wrote:
> The use of C++ with templates is presumably one of the "less so"
> parts, and it was that which I had in mind when I said,
> "reimplementing from scratch".

The templates were removed without reimplementing from scratch:

   https://github.com/danielbot/Shardmap/blob/master/shardmap.h#L88
   https://github.com/danielbot/Shardmap/blob/master/shardmap.cc#L82

The duopack/tripack facility, central to Shardmap efficient scalability, are
now just ordinary C code that happens to be compiled by a C++ compiler. I
think the machine code should be identical to what the templates produced,
though I did not verify.

This was a strictly mechanical conversion, less error prone than
reimplementing from scratch I would think. I expect the rest of the
back conversions to be similarly mechanical.

Regards,

Daniel
