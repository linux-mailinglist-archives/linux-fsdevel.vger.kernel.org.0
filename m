Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3989292849
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Oct 2020 15:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgJSNh5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Oct 2020 09:37:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57733 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728249AbgJSNh5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Oct 2020 09:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603114676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mS8bITCyzTOP2XiCenDLyc/N0OBdUAE0vG9p0LTiHC0=;
        b=dbN5F1BOOpQ1/0ptlzjrTNkjkrmgrgWaktiHCc7wu9jq0heMd/LwpwXn5xYonMv2HutO/T
        MrUiC+sZCM1xoAb27kDfYUei4oCRBs7yeCKlVx8gEmsWGvU46hxG1qWqQ0xeSDPZdX4eeC
        947zmGPYaewBUQY1eqzvHNoCTNiSxdU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-sh6SRx4KOba2vtIWzoBh7w-1; Mon, 19 Oct 2020 09:37:54 -0400
X-MC-Unique: sh6SRx4KOba2vtIWzoBh7w-1
Received: by mail-wr1-f72.google.com with SMTP id 2so7440194wrd.14
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2020 06:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mS8bITCyzTOP2XiCenDLyc/N0OBdUAE0vG9p0LTiHC0=;
        b=tkrqEoDwTWHCd5LiAWLCMZ5FN1QuASuzpmWnADl3PPEEq17aAYfk+db++5+MTg9UQd
         hZKctLzgULVUbl8nCnze4KIOGCRXch0V39oTooet8k5yxKq7d6WW7P2Zhz6pMgfVrETP
         Aeu4mkJdFcsfig+E0r+GyNFwzvksNHADVHmxCW3/JqaOzPtBIWMsnAXNuv8Jj+VCTAbr
         i39wMpRa0g5WNCmKfoiyhwUVazVOoLDLxg7rc3xtIzavXzn+z6WbKB73vwdv33DzIvmD
         psMxHQ9zKpBqddj1aiegDCat1npWR789VrYyDHeTSvnqJ2npI+4yuQ9Z+2+ftfUU+0Vm
         5m8w==
X-Gm-Message-State: AOAM530JV2sTXFSY6E5eTQdDRGdWkWbG8l5oNJBA6hjGaSXlGgLF543b
        oMGqne7Un/iYHedItok4bYC9WphEyXaw+9avN7OoZ1dgw2LwRdWDtO+As9jWqHWHnXpUHd2+iQJ
        zpwJPG7lVMwFdsOTKsptoozPjow==
X-Received: by 2002:a5d:6cc8:: with SMTP id c8mr18748416wrc.233.1603114672885;
        Mon, 19 Oct 2020 06:37:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAbCwKwVrnG9IjlEBOZo1+niRf9C9XuEZwHILJgt8/gQc3q9lqDdmd/vrjTfgDna8KJRZWMA==
X-Received: by 2002:a5d:6cc8:: with SMTP id c8mr18748381wrc.233.1603114672632;
        Mon, 19 Oct 2020 06:37:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id x81sm81282wmb.11.2020.10.19.06.37.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 06:37:52 -0700 (PDT)
Subject: Re: [PATCH 00/35] Enhance memory utilization with DMEMFS
To:     Dan Williams <dan.j.williams@intel.com>,
        Joao Martins <joao.m.martins@oracle.com>
Cc:     yulei zhang <yulei.kernel@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Haiwei Li <lihaiwei.kernel@gmail.com>,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jane Y Chu <jane.chu@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
 <bdd0250e-4e14-f407-a584-f39af12c4e09@oracle.com>
 <CACZOiM2qKhogXQ_DXzWjGM5UCeCuEqT6wnR=f2Wi_T45_uoYHQ@mail.gmail.com>
 <b963565b-61d8-89d3-1abd-50cd8c8daad5@oracle.com>
 <CACZOiM26GPtqkGyecG=NGuB3etipV5-KgN+s19_U1WJrFxtYPQ@mail.gmail.com>
 <98be093d-c869-941a-6dd9-fb16356f763b@oracle.com>
 <CAPcyv4jZ7XTnYd7vLQ18xij7d+80jU0zLs+ykS2frY-LMPS=Nw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3626f5ff-b6a0-0811-5899-703a0714897d@redhat.com>
Date:   Mon, 19 Oct 2020 15:37:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jZ7XTnYd7vLQ18xij7d+80jU0zLs+ykS2frY-LMPS=Nw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 15/10/20 00:25, Dan Williams wrote:
> Now, with recent device-dax extensions, it
> also has a coarse grained memory management system for  physical
> address-space partitioning and a path for struct-page-less backing for
> VMs. What feature gaps remain vs dmemfs, and can those gaps be closed
> with incremental improvements to the 2 existing memory-management
> systems?

If I understand correctly, devm_memremap_pages() on ZONE_DEVICE memory
would still create the "struct page" albeit lazily?  KVM then would use
the usual get_user_pages() path.

Looking more closely at the implementation of dmemfs, I don't understand
is why dmemfs needs VM_DMEM etc. and cannot provide access to mmap-ed
memory using remap_pfn_range and VM_PFNMAP, just like /dev/mem.  If it
did that KVM would get physical addresses using fixup_user_fault and
never need pfn_to_page() or get_user_pages().  I'm not saying that would
instantly be an approval, but it would make remove a lot of hooks.

Paolo

