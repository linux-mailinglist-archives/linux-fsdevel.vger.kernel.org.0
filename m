Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946DF6BD7C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 19:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjCPSFi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 14:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjCPSFg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 14:05:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79BA2B638;
        Thu, 16 Mar 2023 11:05:34 -0700 (PDT)
Received: from [192.168.10.39] (unknown [39.37.168.222])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 87F6A66030A0;
        Thu, 16 Mar 2023 18:05:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678989932;
        bh=jwiEZNS4tHI3AyhUR5flPCUmaY4pqgMo6a2MuOTvpgc=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=UIKk2odsIVHeVbbI48EfWDpxnqExfuk36zZrRLgt0Qmook2AMvSibZKa576mOmHG2
         LZmDmyzgeYfKRefHU/slR1yA/TK2MPeJ5YXaiUvcXZn8Axj9106fZHdh/24kzVSNnx
         HgRG5pUyDAfAiyBfsnW1T2CrEb/Olz29roFry91NjFaUG2zGVEL0HsFIxaKahufTHH
         RKbUppqFLOPocBRpG1jm490YFHRkzcLTj5KOMRmSntgsEj/tKOEBJzJK/pIbG1NlL9
         jvNovDhTa3ZZYMseTC59Kk1llZi/L1UL7KYs8p5rGCxS2p5GW8CHmnon+5TMo6q9i2
         YEQv+Q0xzRLVA==
Message-ID: <5750b0af-4028-d9c3-8ae8-432713869a81@collabora.com>
Date:   Thu, 16 Mar 2023 23:05:21 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WC?= =?UTF-8?Q?aw?= 
        <emmir@google.com>, Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v11 2/7] userfaultfd: Define dummy uffd_wp_range()
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
References: <20230309135718.1490461-1-usama.anjum@collabora.com>
 <20230309135718.1490461-3-usama.anjum@collabora.com>
 <ZBK+86eMMazwfhdx@kernel.org>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ZBK+86eMMazwfhdx@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/16/23 12:02 PM, Mike Rapoport wrote:
> Hi,
> 
> On Thu, Mar 09, 2023 at 06:57:13PM +0500, Muhammad Usama Anjum wrote:
>> Define uffd_wp_range() for the cases when CONFIG_USERFAULTFD isn't set.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>  include/linux/userfaultfd_k.h | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
>> index b680c0ec8b85..fd1a1ecdb5f6 100644
>> --- a/include/linux/userfaultfd_k.h
>> +++ b/include/linux/userfaultfd_k.h
>> @@ -182,6 +182,14 @@ extern int userfaultfd_wp_async(struct vm_area_struct *vma);
>>  
>>  #else /* CONFIG_USERFAULTFD */
>>  
>> +extern inline long uffd_wp_range(struct mm_struct *dst_mm,
> 
> static inline
I'll update.

> 
>> +				 struct vm_area_struct *vma,
>> +				 unsigned long start, unsigned long len,
>> +				 bool enable_wp)
>> +{
>> +	return 0;
>> +}
>> +
> 
> I didn't see uffd_wp_range() defined in the previous patch.
> Could be a rebase issue?
> 
> In any case, the stub should be defined in the same patch as the actual
> function in order not to break bisectability.
This 2/7 patch is a preparatory patch for 3/7 patch. I'll merge both then.

> 
>>  /* mm helpers */
>>  static inline vm_fault_t handle_userfault(struct vm_fault *vmf,
>>  				unsigned long reason)
>> -- 
>> 2.39.2
>>
> 

-- 
BR,
Muhammad Usama Anjum
