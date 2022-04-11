Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E3A4FC755
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 00:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347793AbiDKWJi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 18:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245695AbiDKWJg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 18:09:36 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FF920BFF
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 15:07:21 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id s14so5449800plk.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 15:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uGTALhbZONK07EnTqNzLb5OFo7sOJ1WnH/JS/fksxZ4=;
        b=qW44w090em7gPbYvbMftkAX4Kvke2EP4xsZopvyQYxJet+uD2q9FrkvME10M9tUtmO
         X0ArALnU4GOM4RpFLYtr4bx0MpBZA554kHWbufBfTUNaqHhLHDjr51XHQdOPMxkQgCXg
         NV0mdNXOuzxeZUNmauE//Xw4ily3/UjO/MvX7UN7+CVRdmJUV6HF15N4VgrrGumDREwQ
         mQr7NBQxJVjAKI7QuaN+TbxUCnrDwve7/GDCashxgzsy+utUcS00v8RMdQzi18ZQO+sj
         C3gytJIJs+P+LCAmm5F7B8ZgvVAvSUSOeGPK1NcM/2jE17EGM2aXjbAO22u5NH5fWlQJ
         NrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uGTALhbZONK07EnTqNzLb5OFo7sOJ1WnH/JS/fksxZ4=;
        b=D1F6Q/dLAAlViiOSXM+49pwbUzMNk/+f+0JDMrN3Rnv+sEotvgMwBB8bqy7pS3hbmm
         iNWXlt2lzZjEsWq4Rh0jWSCMAgh0ujKmcX5Qa9wCJwR1fFKuap00zgERtnQdoJxIui5G
         jqZrju3kZr4X7tFmzovNldmZDu+0Rpymj976ZNL3lwj7egbJ/NgT9/Be/hGh9aGiWF+k
         OEciQTFaVQcs6CZJBDpLKoz+LZVAUu8El/Oq2iEb0sr/5gAlTD5djpkOsJCBmpraahLv
         zJR8mHeFnx/ULsxEy0Oac/Y8tGaH9kc3BJWsdQ4uJarKiDUivEKCX02q7YrWbVqJeYvs
         cE4w==
X-Gm-Message-State: AOAM532SwwE3n/hVAVy1hCv4pWoKdUlxy8QP/G8yw19PwTMfMiRe/qWc
        CTR5O3U9253fSBxF24IFXwC1NFFDolzs+C6QM+KiBg==
X-Google-Smtp-Source: ABdhPJynx2l3cB2Gnxdh26yL6kd+AAVfXhzzqC3Ft2s9qeSNSOaR3yfL83lS+0+wlt4mWc4yp2miJE+sHJq1HcNQSls=
X-Received: by 2002:a17:902:eb92:b0:158:4cc9:698e with SMTP id
 q18-20020a170902eb9200b001584cc9698emr11070951plg.147.1649714840717; Mon, 11
 Apr 2022 15:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220405194747.2386619-1-jane.chu@oracle.com> <20220405194747.2386619-2-jane.chu@oracle.com>
In-Reply-To: <20220405194747.2386619-2-jane.chu@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 11 Apr 2022 15:07:10 -0700
Message-ID: <CAPcyv4gr7YzrmqNhA-S8h-nRhpr8OHhUkn16c8jiL1U3ypp1wQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] x86/mm: fix comment
To:     Jane Chu <jane.chu@oracle.com>
Cc:     david <david@fromorbit.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 5, 2022 at 12:48 PM Jane Chu <jane.chu@oracle.com> wrote:
>
> There is no _set_memory_prot internal helper, while coming across
> the code, might as well fix the comment.

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>  arch/x86/mm/pat/set_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index abf5ed76e4b7..38af155aaba9 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -1816,7 +1816,7 @@ static inline int cpa_clear_pages_array(struct page **pages, int numpages,
>  }
>
>  /*
> - * _set_memory_prot is an internal helper for callers that have been passed
> + * __set_memory_prot is an internal helper for callers that have been passed
>   * a pgprot_t value from upper layers and a reservation has already been taken.
>   * If you want to set the pgprot to a specific page protocol, use the
>   * set_memory_xx() functions.
> --
> 2.18.4
>
