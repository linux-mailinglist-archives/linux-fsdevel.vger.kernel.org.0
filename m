Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 227886BEA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 16:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfGQO4A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 10:56:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45824 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfGQO4A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 10:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Hqyv4zXqfJWvsDUEBnkw44GnKu9JuXe0Tjma2P25hIA=; b=PHYffguA8Do4AfdhPOYF0/QtR
        EBq7JI6/Gk9l93jsR/Cf9s2z+BbMdIBQ8GHui9bYZGDTSOqKeEPo/kvRMc4XhyPbZg2VeZDfN0uuq
        foSMg9eo7rjoTJo418aje2TXH7SjtLzXIp0/024YtEiakXEukBeaFPEnJuwj6ksU8Uy4EjPlMD80D
        10Yefa9I8t2ANsgEGs7aA+mZbNIoVtd1UaJV1sHNPVep8F7ZoTA2S8w8riTU21Nv3hQZMregOi8uN
        KYjnbu21XWjjfu/mQuFe0rj+2NdprGxL/TaghcjCuL/dek6+vevJsl/qY6XeyUxY0yxdGeIopMHvg
        K3FHAlAig==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hnlLb-0006dc-4A; Wed, 17 Jul 2019 14:55:59 +0000
Subject: Re: mmotm 2019-07-16-17-14 uploaded
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
References: <20190717001534.83sL1%akpm@linux-foundation.org>
 <8165e113-6da1-c4c0-69eb-37b2d63ceed9@infradead.org>
 <20190717143830.7f7c3097@canb.auug.org.au>
 <a9d0f937-ef61-1d25-f539-96a20b7f8037@infradead.org>
 <072ca048-493c-a079-f931-17517663bc09@infradead.org>
 <20190717180424.320fecea@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a1179bac-204d-110e-327f-845e9b09a7ab@infradead.org>
Date:   Wed, 17 Jul 2019 07:55:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190717180424.320fecea@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/17/19 1:04 AM, Stephen Rothwell wrote:
> Hi Randy,
> 
> On Tue, 16 Jul 2019 23:21:48 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> drivers/dma-buf/dma-buf.c:
>> <<<<<<< HEAD
>> =======
>> #include <linux/pseudo_fs.h>
>>>>>>>>> linux-next/akpm-base  
> 
> I can't imagine what went wrong, but you can stop now :-)
> 
> $ grep '<<< HEAD' linux-next.patch | wc -l
> 1473

Yes, I did the grep also, decided to give up.

> I must try to find the emails where Andrew and I discussed the
> methodology used to produce the linux-next.patch from a previous
> linux-next tree.



-- 
~Randy
