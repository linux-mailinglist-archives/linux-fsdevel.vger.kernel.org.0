Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77E2219B492
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 19:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732727AbgDARNR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 13:13:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40874 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732137AbgDARNR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 13:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=wdgTSKNxkD1QrwAjRgDdie5nQ4gbwZFe8HVIvvfYi0s=; b=KJntRMJ8Qks9UoOE0UgBNQ4Dyr
        oTcjRKMZ6Jf3Gk/IJlNgmVLKtTXcnPwXUsOSjEOz5uphzyUiBLQJo5o7PNsl5LrPcwVNnSiAKVvsb
        EyuIe9gLPIJpM69FvjZNpfYVsJZoOmOs+Ik5+N0tX3FfjD3I1dSBXGZWHv9ASkPKrJValKJth9X0/
        6qWTivVQG1Q4mPA/b4MTBvIzD3/W8/Z5t1IHR66LpXrQnSzPUGwU9UDR5BWrWiQvR8AWjNiN+T4wg
        qrl22e1u2+csSEP8rhDaM5Xz9aNdmcjZXcpO4P4n77fobZ+0b07wCIh/WYLt/XTgeqmcKmYcvVp2R
        +8bmJBbA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJgvR-0000rx-7y; Wed, 01 Apr 2020 17:13:13 +0000
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
 <9c03fee8-af1a-2035-b903-611a631094b0@infradead.org>
 <20200331152106-mutt-send-email-mst@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cd94bd62-57c4-b82e-0434-8a470a9ea613@infradead.org>
Date:   Wed, 1 Apr 2020 10:13:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331152106-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/31/20 12:22 PM, Michael S. Tsirkin wrote:
> On Tue, Mar 31, 2020 at 11:42:47AM -0700, Randy Dunlap wrote:
>> On 3/31/20 11:37 AM, Michael S. Tsirkin wrote:
>>> On Tue, Mar 31, 2020 at 11:27:54AM -0700, Randy Dunlap wrote:
>>>> On 3/30/20 6:47 PM, akpm@linux-foundation.org wrote:
>>>>> The mm-of-the-moment snapshot 2020-03-30-18-46 has been uploaded to
>>>>>
>>>>>    http://www.ozlabs.org/~akpm/mmotm/
>>>>>
>>>>> mmotm-readme.txt says
>>>>>
>>>>> README for mm-of-the-moment:
>>>>>
>>>>> http://www.ozlabs.org/~akpm/mmotm/
>>>>>
>>>>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>>>>> more than once a week.
>>>>>
>>>>> You will need quilt to apply these patches to the latest Linus release (5.x
>>>>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
>>>>> http://ozlabs.org/~akpm/mmotm/series
>>>>>
>>>>> The file broken-out.tar.gz contains two datestamp files: .DATE and
>>>>> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
>>>>> followed by the base kernel version against which this patch series is to
>>>>> be applied.
>>>>>
>>>>> This tree is partially included in linux-next.  To see which patches are
>>>>> included in linux-next, consult the `series' file.  Only the patches
>>>>> within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
>>>>> linux-next.
>>>>>
>>>>>
>>>>> A full copy of the full kernel tree with the linux-next and mmotm patches
>>>>> already applied is available through git within an hour of the mmotm
>>>>> release.  Individual mmotm releases are tagged.  The master branch always
>>>>> points to the latest release, so it's constantly rebasing.
>>>>>
>>>>> 	https://github.com/hnaz/linux-mm
>>>>
>>>> on i386:
>>>>
>>>> ld: drivers/vhost/vdpa.o: in function `vhost_vdpa_init':
>>>> vdpa.c:(.init.text+0x52): undefined reference to `__vdpa_register_driver'
>>>> ld: drivers/vhost/vdpa.o: in function `vhost_vdpa_exit':
>>>> vdpa.c:(.exit.text+0x14): undefined reference to `vdpa_unregister_driver'
>>>>
>>>>
>>>>
>>>> drivers/virtio/vdpa/ is not being built. (confusing!)
>>>>
>>>> CONFIG_VIRTIO=m
>>>> # CONFIG_VIRTIO_MENU is not set
>>>> CONFIG_VDPA=y
>>>
>>> Hmm. OK. Can't figure it out. CONFIG_VDPA is set why isn't
>>> drivers/virtio/vdpa/ built?
>>> we have:
>>>
>>
>> Ack.  Hopefully Yamada-san can tell us what is happening here.
> 
> OK I pushed a fix (moving the vdpa subsystem up a level) and pushed into
> my tree, refs/heads/next .  Seems to build fine now, but I'd appreciate
> it if you can give it a spin.

This now builds successfully on linux-next of 20200401.

Thanks.

-- 
~Randy

