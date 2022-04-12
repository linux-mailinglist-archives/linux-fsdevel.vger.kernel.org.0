Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407224FEA50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 01:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiDLXlX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 19:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiDLXlC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:41:02 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24171A94C6
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Apr 2022 16:22:46 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id q189so326598oia.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Apr 2022 16:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cXG2uBz6lRa6SmsxOh4UHnvAS1v6j3gtk2oaRONS+x4=;
        b=VPl1Lq9jWUOfdQHl/1KZuWWM6wCjlya9ZIm56mGgKOGxFiC5BaCc1BSVeUdc1pyItB
         BIIRsGb7m/uTTFP7EQ9bwdIRf6Qc2mw3gELQG2VwZAg2xJ2tVel9MI1+ME9SUoGaJ8Ck
         Z8ts0Cz8Sv7S9Fzd/Im/JfbGqbs45u5Dpd4A8hT36LVn0vEKF5gJNhz9Xj3HxeT5GFx9
         3orzrVLxvjY3XUMpiLuJPsctZxiLUWVgCZp6UZHqMNblOrfxFCYbsUPAtL6PjFLKvIYv
         yR16Pm/ZW/nafNyxKUqk8z/2UQ0ECbaF4NEyEpOJWqi+m9FgHi5wKcizOSX3GGI9F65b
         O8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cXG2uBz6lRa6SmsxOh4UHnvAS1v6j3gtk2oaRONS+x4=;
        b=yQIUYPE49MSQP455obR2EwsnHUsbmOc9XovfWEMsKqZwWVRnbVnPOKMp0/FwVyxjTk
         gKt03ap8lJ0OsoONqOR5MmAZddK8+lLLdLJ/5wD5hOjev2cVJsz10jF6V/mrTz/9M2+B
         /mp88tAQCbDGBcrKc4/yepOckRT85f/uu24wRG4fUkpRqKp1LUhNy/sRTeA1tO5J2RED
         4R8jn6uSKeh7xqgplPvzBpcJgR3dGYZgnRIE4FWizNBWzGFKPBj/mHv3gMdaczwiuDll
         hUSZ9qOy2yYSTPcZiDSposoCjk/lD7rvG0bFLIg0OFO4NLhj4NvG1RYOBpdAZ8wGzZ6h
         VECA==
X-Gm-Message-State: AOAM530bVOHkHOyDVauhAJBkLEw+tWEYYX3hF298T8/hVJQ9bzuVFVE9
        2+NxIRFFc7iH4rwIebmRNTGt99BVtUW2Zly7si2J1A==
X-Google-Smtp-Source: ABdhPJzEsDa0QPWqZoKnqzlrHygJjKtOSvpADAV6Jhisjm10RxdCfr8ioS/LCXNm6BQQZeX47QnFzwejPCzwj9rtzOk=
X-Received: by 2002:a05:6808:1154:b0:2da:2fbd:eba9 with SMTP id
 u20-20020a056808115400b002da2fbdeba9mr2979048oiu.133.1649805765445; Tue, 12
 Apr 2022 16:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220410160904.3758789-1-ruansy.fnst@fujitsu.com> <20220410160904.3758789-2-ruansy.fnst@fujitsu.com>
In-Reply-To: <20220410160904.3758789-2-ruansy.fnst@fujitsu.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 12 Apr 2022 16:22:34 -0700
Message-ID: <CAPcyv4iqHMR4Pee0Mjca2iM6Vhht8s=56-ZefYvpBmxuEi0Q6A@mail.gmail.com>
Subject: Re: [PATCH v12 1/7] dax: Introduce holder for dax_device
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, david <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 10, 2022 at 9:09 AM Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
>
> To easily track filesystem from a pmem device, we introduce a holder for
> dax_device structure, and also its operation.  This holder is used to
> remember who is using this dax_device:
>  - When it is the backend of a filesystem, the holder will be the
>    instance of this filesystem.
>  - When this pmem device is one of the targets in a mapped device, the
>    holder will be this mapped device.  In this case, the mapped device
>    has its own dax_device and it will follow the first rule.  So that we
>    can finally track to the filesystem we needed.
>
> The holder and holder_ops will be set when filesystem is being mounted,
> or an target device is being activated.
>

Looks good to me:

Reviewed-by: Dan Williams <dan.j.wiliams@intel.com>

I am assuming this will be staged in a common DAX branch, but holler
now if this should go through the XFS tree.
