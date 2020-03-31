Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3775F199E41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 20:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgCaSmw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 14:42:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51016 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCaSmv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 14:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=BUBDl8TWBoALLJ/DLYt44Ai1/mhcHhqeudMrwUyZMDY=; b=C9Ntx/2MgYNBNindlNbMzVjVVC
        oQw6CZkC8lgWs/k2Yz4CNeAF4A0MB3zeFIfjj94hjSuuFJRUhmsUY2Ig1Wj8HJpGpPvinUwWWgEfl
        cPv4BWq+CM1bRWBHu0RVLQT/SH1OlHJAFbohYD58pWpDdcrmDWI8potb6nIx/1IIQ7ycfdWEeTSiN
        n+2tvFeOqk8S+jYZa7nkRXp1pKDKANAcVgqdBb1EADCOaGusInhUbvcPscEIsnDgfQViGYTUwMFXp
        CF/KExq+yVRzDScTl0YVM6U9GFOYjy7EZPaL4q/BH8EwQRuaxRlGAK8zb6fXxmcSxAIR6nOulGrCI
        TZaKtizw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJLqb-0002mj-7I; Tue, 31 Mar 2020 18:42:49 +0000
Subject: Re: mmotm 2020-03-30-18-46 uploaded (VDPA + vhost)
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>
References: <20200331014748.ajL0G62jF%akpm@linux-foundation.org>
 <969cacf1-d420-223d-7cc7-5b1b2405ec2a@infradead.org>
 <20200331143437-mutt-send-email-mst@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9c03fee8-af1a-2035-b903-611a631094b0@infradead.org>
Date:   Tue, 31 Mar 2020 11:42:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331143437-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/31/20 11:37 AM, Michael S. Tsirkin wrote:
> On Tue, Mar 31, 2020 at 11:27:54AM -0700, Randy Dunlap wrote:
>> On 3/30/20 6:47 PM, akpm@linux-foundation.org wrote:
>>> The mm-of-the-moment snapshot 2020-03-30-18-46 has been uploaded to
>>>
>>>    http://www.ozlabs.org/~akpm/mmotm/
>>>
>>> mmotm-readme.txt says
>>>
>>> README for mm-of-the-moment:
>>>
>>> http://www.ozlabs.org/~akpm/mmotm/
>>>
>>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>>> more than once a week.
>>>
>>> You will need quilt to apply these patches to the latest Linus release (5.x
>>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
>>> http://ozlabs.org/~akpm/mmotm/series
>>>
>>> The file broken-out.tar.gz contains two datestamp files: .DATE and
>>> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
>>> followed by the base kernel version against which this patch series is to
>>> be applied.
>>>
>>> This tree is partially included in linux-next.  To see which patches are
>>> included in linux-next, consult the `series' file.  Only the patches
>>> within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
>>> linux-next.
>>>
>>>
>>> A full copy of the full kernel tree with the linux-next and mmotm patches
>>> already applied is available through git within an hour of the mmotm
>>> release.  Individual mmotm releases are tagged.  The master branch always
>>> points to the latest release, so it's constantly rebasing.
>>>
>>> 	https://github.com/hnaz/linux-mm
>>
>> on i386:
>>
>> ld: drivers/vhost/vdpa.o: in function `vhost_vdpa_init':
>> vdpa.c:(.init.text+0x52): undefined reference to `__vdpa_register_driver'
>> ld: drivers/vhost/vdpa.o: in function `vhost_vdpa_exit':
>> vdpa.c:(.exit.text+0x14): undefined reference to `vdpa_unregister_driver'
>>
>>
>>
>> drivers/virtio/vdpa/ is not being built. (confusing!)
>>
>> CONFIG_VIRTIO=m
>> # CONFIG_VIRTIO_MENU is not set
>> CONFIG_VDPA=y
> 
> Hmm. OK. Can't figure it out. CONFIG_VDPA is set why isn't
> drivers/virtio/vdpa/ built?
> we have:
> 

Ack.  Hopefully Yamada-san can tell us what is happening here.

> 
> obj-$(CONFIG_VDPA) += vdpa/
> 
> and under that:
> 
> obj-$(CONFIG_VDPA) += vdpa.o
> 
> 
>> CONFIG_VDPA_MENU=y
>> # CONFIG_VDPA_SIM is not set
>> CONFIG_VHOST_IOTLB=y
>> CONFIG_VHOST_RING=m
>> CONFIG_VHOST=y
>> CONFIG_VHOST_SCSI=m
>> CONFIG_VHOST_VDPA=y
>>
>> Full randconfig file is attached.
>>
>> (This same build failure happens with today's linux-next, Mar. 31.)
>>
>> @Yamada-san:  Is this a kbuild problem (or feature)?
>>
>> -- 
>> ~Randy
>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> 


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
