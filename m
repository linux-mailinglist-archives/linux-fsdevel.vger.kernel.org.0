Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB5834D26E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 17:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfFTPtR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jun 2019 11:49:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44070 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfFTPtR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DEHl/heRoFE3pmtAOs3jRbe+EMJIxlq4+fAPJDAKNqA=; b=Q8dvbg7Y3KEguFux87Tlx8c4nI
        TzRU0UFrSH0P5s98Ir4S7dS3oFK63/wyKX/EX9awC86Z4Lp/RmiDXdS/rWlSXwuz8FpMlJqT97jzE
        8BgOhI3ManVmb4M15/4DF851rnD+ujzuR7FcZVkUKPU4StnexKlSXhp3F7yX9fifgd9BHu9mgc/l9
        Rm8jaiQ+3L1+e4ExkTlf0yQ8G8NiOS9o537wp1iWcdguBUqtBW1oUSLtGWdPNvKqMmHIcOMG/h1Me
        jU/P1a3P6/0bgnpPWPJGSXH3yUdmgSVkoc+q+jL0vmermx/de1lRLpX4Fny6RGoDoaYx/WOfOHylU
        v94QgEpQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdzJ5-0000MQ-Ia; Thu, 20 Jun 2019 15:48:59 +0000
Subject: Re: mmotm 2019-06-19-20-32 uploaded (drivers/base/memory.c)
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        David Hildenbrand <david@redhat.com>
References: <20190620033253.hao9i0PFT%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <bbc205e3-f947-ad46-6b62-afb72af7791e@infradead.org>
Date:   Thu, 20 Jun 2019 08:48:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190620033253.hao9i0PFT%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/19/19 8:32 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2019-06-19-20-32 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 

on i386 or x86_64:

../drivers/base/memory.c: In function 'find_memory_block':
../drivers/base/memory.c:621:43: error: 'hint' undeclared (first use in this function); did you mean 'uint'?
  return find_memory_block_by_id(block_id, hint);
                                           ^~~~


-- 
~Randy
