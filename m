Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2284D510581
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 19:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349209AbiDZRhc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 13:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349190AbiDZRh3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 13:37:29 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8F6939B3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 10:34:20 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id n134so21001144iod.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 10:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7f2dI15a4+fxCm2oUbnayxZipYVTc4CPiFnYf4iZd2U=;
        b=SREAqgM7dV17pgSKvTHXqGRtHaa149tdP3zeKDxtvrWfF/g9kSkykZn7f2kF/kZLrp
         4ADMNFdr49SVVqqxE4FHv2OBrlkZEsjAwubpihKozfaxZGLx7hfE7uTEAW3lvU4/70if
         Lzcv5LPTbN395oaYwmC48671h2iLMAq3lDqPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7f2dI15a4+fxCm2oUbnayxZipYVTc4CPiFnYf4iZd2U=;
        b=OV5dKmeCBLQcJN0p4maXf5Azh0Q8fi1Ib3+tP4CXrgoWbxlrySbfVe3WTbEq++1Vvk
         0p4SRC2mQyopOlBjimb8fHVHVYDUTyXCCiY9rFpBkAYedqOAUiBNlOvHZLzv9fDGTzZc
         BzINQqWXXsJeTeF8CsZmzLIWlX2lFQlP7mup0i7rykgPFyUzGYqNSSxarpckpMDKvPrc
         AcJRfT4U4RwYFExwmqvYLwLuC5G5oD/9m0dCIUDzQX6bRt/0FQ3Mjh8jzuOmRJzCLAti
         LLXMVahkyqUx8dluXxNvSIkXtjw+ewzN2okVo5l/xaNnnWVAh6TKKVZlf0x6Xn8YToCS
         OmMQ==
X-Gm-Message-State: AOAM533MZvvcbkPvZ8UZh0cZXKvI7dzvP+o8hkTP4MccqUffuk6D/Sgl
        q8VwT0CenZ+l7k04QZM2khRErXbMGeDDTw==
X-Google-Smtp-Source: ABdhPJzQGDlIXE5ent6k2MVRos1IeGAWobjiKgxDUQSt7g0QXIN9BmEROJsT2JY8WurBH/mD6/+5sA==
X-Received: by 2002:a6b:490f:0:b0:657:5e68:66b8 with SMTP id u15-20020a6b490f000000b006575e6866b8mr7896021iob.102.1650994459551;
        Tue, 26 Apr 2022 10:34:19 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id t11-20020a922c0b000000b002c85834eb06sm8164495ile.47.2022.04.26.10.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 10:34:19 -0700 (PDT)
Subject: Re: [PATCH v2 6/6] selftests: vm: add /dev/userfaultfd test cases to
 run_vmtests.sh
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, zhangyi <yi.zhang@huawei.com>
Cc:     linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220422212945.2227722-1-axelrasmussen@google.com>
 <20220422212945.2227722-7-axelrasmussen@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f257d358-1ec8-d3f4-d3c2-e61e0063df03@linuxfoundation.org>
Date:   Tue, 26 Apr 2022 11:34:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220422212945.2227722-7-axelrasmussen@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/22/22 3:29 PM, Axel Rasmussen wrote:
> This new mode was recently added to the userfaultfd selftest. We want to
> exercise both userfaultfd(2) as well as /dev/userfaultfd, so add both
> test cases to the script.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>   tools/testing/selftests/vm/run_vmtests.sh | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
> index 5065dbd89bdb..57f01505c719 100755
> --- a/tools/testing/selftests/vm/run_vmtests.sh
> +++ b/tools/testing/selftests/vm/run_vmtests.sh
> @@ -121,12 +121,17 @@ run_test ./gup_test -a
>   run_test ./gup_test -ct -F 0x1 0 19 0x1000
>   
>   run_test ./userfaultfd anon 20 16
> +run_test ./userfaultfd anon:dev 20 16
>   # Hugetlb tests require source and destination huge pages. Pass in half the
>   # size ($half_ufd_size_MB), which is used for *each*.
>   run_test ./userfaultfd hugetlb "$half_ufd_size_MB" 32
> +run_test ./userfaultfd hugetlb:dev "$half_ufd_size_MB" 32
>   run_test ./userfaultfd hugetlb_shared "$half_ufd_size_MB" 32 "$mnt"/uffd-test
>   rm -f "$mnt"/uffd-test
> +run_test ./userfaultfd hugetlb_shared:dev "$half_ufd_size_MB" 32 "$mnt"/uffd-test
> +rm -f "$mnt"/uffd-test
>   run_test ./userfaultfd shmem 20 16
> +run_test ./userfaultfd shmem:dev 20 16
>   
>   #cleanup
>   umount "$mnt"
> 

Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
