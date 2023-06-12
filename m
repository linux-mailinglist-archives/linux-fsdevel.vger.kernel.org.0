Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2585B72BC41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 11:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjFLJ1D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 05:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbjFLJZ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:25:59 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B714490;
        Mon, 12 Jun 2023 02:19:56 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1a2c85ef3c2so2638649fac.0;
        Mon, 12 Jun 2023 02:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686561596; x=1689153596;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/kdfCBirwzAruhooshUag2P/P8fZiXPMaXUlCsTPwkQ=;
        b=QS3knZ7sYVbF4CcbzGl5hAkiewnEtKlzddRTIv6zuks4JXSjBUgtNsUFSmxX04Kd+d
         DEdrXdx3LoIAJH9LmUXaHrEY90Y6WxQLvSOw+CJScL8rXiny+AO7b5MOFrBHkSysMGL1
         2qpO7KpG9c5XLpRz50bzgcEgpUhcT0w1N3LfVb34+ocgLabxRMn6LSKD58e5mA5QjICb
         4rrjR1EHev7MMq+hch6l2F37TA5wp9pOgGRtGQ1WZc907nYnnENs5ok2+LzBBYMyYCpW
         3uOmZVr3wQF7d/EuVPAcCsqvnxkTmmq9Saj8b8vbzlJ0iOgg/mBMGVL8ihslaaroxq4x
         VmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686561596; x=1689153596;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/kdfCBirwzAruhooshUag2P/P8fZiXPMaXUlCsTPwkQ=;
        b=AipaT9ft5G6ax0w2tsFOkGLet94kFlQkn96Vckg2medDeOPod7rooFN52cyUuTQZKW
         OHhRDRJHstBzfqRKqlK/cBpF7edk4qiotAl2HJV3JjX6k/vxLHYqnw1BiHkWyTyQU2bV
         9msOKAqzxw6KxQcmqnqTGl3yJcYGq1NBtunGtwYYHDobHTB8xTO6AQunUUBTaRXU/I1n
         WLoXGt3MNjOJdyE8ZNDjj+J/IhGpvwaCisuTOlTUVckyU0aBpcKqmmpSUudP9nA9n6PG
         YzMutJ2ji0aQXbYZrBhS4vNDvgiudd0j60UXGULDSxO3TyhugyblOKESai8kOl0vrsgO
         kAyA==
X-Gm-Message-State: AC+VfDwA3JZ6/wjHYccZyS5Mk0QM2BHEuYmaMOFwffWvX5X6sajUIle0
        1F1BsLn8PFWyswlEpS/9KovQMdYX2Xo=
X-Google-Smtp-Source: ACHHUZ6NsRU/w+5hUARYX7lYbC7y3dG9HiDgO/MaQvQxUDkjm3UpxpHV9/qJlM5qy/FCcwcuwprt8g==
X-Received: by 2002:a05:6808:284:b0:397:f82f:90a4 with SMTP id z4-20020a056808028400b00397f82f90a4mr3359956oic.3.1686561595919;
        Mon, 12 Jun 2023 02:19:55 -0700 (PDT)
Received: from dw-tp ([129.41.58.23])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090a5d0c00b0025930e50e28sm8769372pji.41.2023.06.12.02.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:19:55 -0700 (PDT)
Date:   Mon, 12 Jun 2023 14:49:50 +0530
Message-Id: <87wn09ghqh.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv9 1/6] iomap: Rename iomap_page to iomap_folio_state and others
In-Reply-To: <ZIa51URaIVjjG35D@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Sun, Jun 11, 2023 at 11:21:48PM -0700, Christoph Hellwig wrote:
>> Looks good:
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!

>
> Actually, coming back to this:
>
> -to_iomap_page(struct folio *folio)
> +static inline struct iomap_folio_state *iomap_get_ifs
>
> I find the to_* naming much more descriptive for derving the
> private data.  get tends to imply grabbing a refcount.

Not always. That would be iomap_ifs_get(ifs)/iomap_ifs_put(ifs).

See this -

static inline void *folio_get_private(struct folio *folio)
{
	return folio->private;
}

So, is it ok if we hear from others too on iomap_get_ifs() function
name?

-ritesh
