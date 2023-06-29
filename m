Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AD5742F3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 23:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjF2VEd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 17:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjF2VEc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 17:04:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530791BC6;
        Thu, 29 Jun 2023 14:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=J/Le96Hd+j13NdY/bbUKc97A6Qhb9OOEKINA5FlMdBc=; b=LAqUkWtZd0VW1y8npxGmiGyUTa
        9dDtUf/A+7L/tlqLJHfjtdSEPxEJlPDpIyPBhYqg19uZcsfLFjOc8twD1U01P2danEgyfygbhyaZL
        ia3N3kO6fcyvYbSiI4PjbKyhYR0g7YTfiNIjMWEGpGbdigtikSyXVSbM/PaDMYq22qIyFsYEVWWkQ
        r91INYFie1dEFLqBtswXaA9MW47K81cIpkVyKkTcHIhAlU9Fb9bhsjkpSdVkS+vbr/0VW5oZJNOvx
        bhg5cDkf54CCHr/WKD151rlnIuIgQl2Y4z1/NRfFDRfedUeeKeNvj4fTqDCl6F5ItPW6M8oLPQ0Q6
        vniqQR2w==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEyoE-002AzK-1P;
        Thu, 29 Jun 2023 21:04:10 +0000
Message-ID: <3cc9f07a-3105-27f9-176d-9deea975ce3c@infradead.org>
Date:   Thu, 29 Jun 2023 14:04:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 6/6] mm: userfaultfd: add basic documentation for
 UFFDIO_POISON
Content-Language: en-US
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20230629205040.665834-1-axelrasmussen@google.com>
 <20230629205040.665834-6-axelrasmussen@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230629205040.665834-6-axelrasmussen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

typo below.

On 6/29/23 13:50, Axel Rasmussen wrote:
> Just describe the feature at a really basic level.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  Documentation/admin-guide/mm/userfaultfd.rst | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
> index 7c304e432205..b19053436369 100644
> --- a/Documentation/admin-guide/mm/userfaultfd.rst
> +++ b/Documentation/admin-guide/mm/userfaultfd.rst
> @@ -244,6 +244,21 @@ write-protected (so future writes will also result in a WP fault). These ioctls
>  support a mode flag (``UFFDIO_COPY_MODE_WP`` or ``UFFDIO_CONTINUE_MODE_WP``
>  respectively) to configure the mapping this way.
>  
> +Memory Poisioning Emulation
> +---------------------------
> +
> +In response to a fault (either missing or minor), an action userspace can
> +take to "resolve" it is to issue a ``UFFDIO_POISON``. This will cause any
> +future faulters to either get a SIGBUS, or in KVM's case the guest will
> +receive an MCE as if there were hardware memory poisoning.
> +
> +This is used to emulate hardware memory poisoning. Imagine a VM running on a
> +machine which experiences a real hardware memory error. Later, we live migrate
> +the VM to another physical machine. Since we want the migration to be
> +transparent to the guest, we want that same address range to act as if it was
> +still poisoned, even though it's on a new physical host which ostentisbly

                                                                 ostensibly

> +doesn't have a memory error in the exact same spot.
> +
>  QEMU/KVM
>  ========
>  

-- 
~Randy
