Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1923A42505
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 14:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438450AbfFLMIZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 08:08:25 -0400
Received: from server.eikelenboom.it ([91.121.65.215]:54960 "EHLO
        server.eikelenboom.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436551AbfFLMIZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=eikelenboom.it; s=20180706; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HMMzkEP4WbpPiU7OaAK4YYStnvL4huMRmKxIzkOsvO0=; b=YziB4QXQ1wZZTmpueJ7TbStAiC
        2OB0T4AcHVrvcXFvdn+encKtRh++7eIctsFdZRN2IA428qb3nU1FiAGa68Q+vvyr6BL7ohsIraMK7
        zJzAnpX/bMXKuE8eLl7Ued5Z8lCWfuCFrWtHbjg5lForaybVdp6y73fJa6pfzOXXUfBw=;
Received: from ip4da85049.direct-adsl.nl ([77.168.80.73]:25793 helo=[10.97.34.6])
        by server.eikelenboom.it with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <linux@eikelenboom.it>)
        id 1hb23B-0004SJ-0E; Wed, 12 Jun 2019 14:08:21 +0200
Subject: Re: [PATCH] fuse: require /dev/fuse reads to have enough buffer
 capacity (take 2)
To:     Kirill Smelkov <kirr@nexedi.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, gluster-devel@gluster.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <876aefd0-808a-bb4b-0897-191f0a8d9e12@eikelenboom.it>
 <CAJfpegvRBm3M8fUJ1Le1dPd0QSJgAWAYJGLCQKa6YLTE+4oucw@mail.gmail.com>
 <20190611202738.GA22556@deco.navytux.spb.ru>
 <CAOssrKfj-MDujX0_t_fgobL_KwpuG2fxFmT=4nURuJA=sUvYYg@mail.gmail.com>
 <20190612112544.GA21465@deco.navytux.spb.ru>
From:   Sander Eikelenboom <linux@eikelenboom.it>
Message-ID: <97c87eb3-5b95-c848-8c50-ed7b535220b0@eikelenboom.it>
Date:   Wed, 12 Jun 2019 14:11:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612112544.GA21465@deco.navytux.spb.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/06/2019 13:25, Kirill Smelkov wrote:
> On Wed, Jun 12, 2019 at 09:44:49AM +0200, Miklos Szeredi wrote:
>> On Tue, Jun 11, 2019 at 10:28 PM Kirill Smelkov <kirr@nexedi.com> wrote:
>>
>>> Miklos, would 4K -> `sizeof(fuse_in_header) + sizeof(fuse_write_in)` for
>>> header room change be accepted?
>>
>> Yes, next cycle.   For 4.2 I'll just push the revert.
> 
> Thanks Miklos. Please consider queuing the following patch for 5.3.
> Sander, could you please confirm that glusterfs is not broken with this
> version of the check?
> 
> Thanks beforehand,
> Kirill

Sure will give it a spin this evening and report back.

--
Sander
