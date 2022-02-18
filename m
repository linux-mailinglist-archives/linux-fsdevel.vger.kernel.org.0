Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CABB4BBC49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 16:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbiBRPiU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 10:38:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236779AbiBRPiT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:38:19 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F7AB19
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Feb 2022 07:38:01 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id e5so10355948vsg.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Feb 2022 07:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KlximUQdmdZXnbPJfSZ8Lynpd+nv/zvxyZZuYYKSUXI=;
        b=g3upiXitzv9z8uQ7TM0hwJzfK03O6j1Vg+vHnquOztZoylzuCrPT0q4wrKL3WKZhB5
         IQsJ1+1/PaIJO7CoqzR+WPgOKQYg9UYu1qVbkG9u+v6kvjpbi7VIp76ro34h70ybylbB
         QH61m9wFRVPSZ9as4GZpO37wj8PUAc3sNbkkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KlximUQdmdZXnbPJfSZ8Lynpd+nv/zvxyZZuYYKSUXI=;
        b=7ZOaAhgjWWs95PYSSY4DrPt9ecMArjdKDE2P3mjy2XhHaf8m/A3ONkbLAA0xmO1VY3
         VZuHeXkRHJ6gcpGnv9ldKAOMaUQbsDrOU8Wc+OMxwrnbGomRFujvHAdJzSvTPTNSjZbU
         98OpBOpzk/42RSM9EUj3Wf1elci6FqbjHtltpKPY+E/WpBnTni2A01N3kThZ+SWs/O/L
         zl6iqBIvCoxUS7cLdtpGKxcUBH6Z7tV90p3DWCk25FueF0X0OGQuU73lwL6ktIKyAmht
         CuHSEvB4YRmMLYXHsQJXbyxRF6aylGhdn5Fw2yamP2JRpu+CLyoCw+rZQ7SQie8xAsPm
         PMow==
X-Gm-Message-State: AOAM532KIihJqYn4MVf/NDwtffnVYDtBx7JI4xLusJzDb3jDZH1bZfrd
        qZVzZ2gMJTaHwpQup72fl+cnO4yn+dFoAEFtmTcFDw==
X-Google-Smtp-Source: ABdhPJw5OiV2XwmsRGvm4YmDdzaptihW/JaMJrgn06mbKEHHNTHIky4Tyyfh8C/lgnKpB9JFFMDq/S+RMzjSY2DHOSM=
X-Received: by 2002:a67:e0cc:0:b0:31b:d7bf:8403 with SMTP id
 m12-20020a67e0cc000000b0031bd7bf8403mr3828513vsl.61.1645198679465; Fri, 18
 Feb 2022 07:37:59 -0800 (PST)
MIME-Version: 1.0
References: <20220214210708.GA2167841@xavier-xps> <CAJfpegvVKWHhhXwOi9jDUOJi2BnYSDxZQrp1_RRrpVjjZ3Rs2w@mail.gmail.com>
 <YguspMvu6M6NJ1hL@zeniv-ca.linux.org.uk> <YgvPbljmJXsR7ESt@zeniv-ca.linux.org.uk>
 <YgvSB6CKAhF5IXFj@casper.infradead.org> <YgvS1XOJMn5CjQyw@zeniv-ca.linux.org.uk>
 <CAJfpegv03YpTPiDnLwbaewQX_KZws5nutays+vso2BVJ1v1+TA@mail.gmail.com>
 <YgzRwhavapo69CAn@miu.piliscsaba.redhat.com> <20220216131814.GA2463301@xavier-xps>
 <CAJfpegsQO-35p6uoG2ZfuCOLPFwnkbTcLc3K8r+HiS2un9au_w@mail.gmail.com>
In-Reply-To: <CAJfpegsQO-35p6uoG2ZfuCOLPFwnkbTcLc3K8r+HiS2un9au_w@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 18 Feb 2022 16:37:48 +0100
Message-ID: <CAJfpeguFUB_eqdE=CETE+mBhp0ZmeouoFeEs7=O5UibCmPi=CQ@mail.gmail.com>
Subject: Re: race between vfs_rename and do_linkat (mv and link)
To:     Xavier Roche <xavier.roche@algolia.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 16 Feb 2022 at 14:37, Miklos Szeredi <miklos@szeredi.hu> wrote:

> One issue with the patch is nesting of lock_rename() calls in stacked
> fs (rwsem is not allowed to recurse even for read locks).

Scratch that, there's no recursion since do_linkat() is not called
from stacked fs.  And taking link_rwsem is optional for the link
operation, so this is fine.  For stacked fs the race is hopefully
taken care by the top layer locking, no need to repeat it in lower
layers.

I've now sent this patch with a proper header comment to Al.

Thanks,
Miklos
