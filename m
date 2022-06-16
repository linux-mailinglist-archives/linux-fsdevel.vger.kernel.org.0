Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C11554DFD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jun 2022 13:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiFPLOg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jun 2022 07:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiFPLOf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:14:35 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C665BE70;
        Thu, 16 Jun 2022 04:14:34 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id r1so1009627plo.10;
        Thu, 16 Jun 2022 04:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aY+rbvTncYwIQUsfu1kfNRqIKlHQfqdkAsaQGSStGAc=;
        b=T1nyQf+o+quWJWjHgREea65Lu4Mwv9/vEkhHIn5ouzUN4xbbRmkbks6WcAe6EO03XX
         oUeq6768kVgvWYBVYkZ549DhKwbJpKEVDNIoeW1rt9JgEVF/isu5nDY9iKXewFEq/AVV
         SUkt37VFzTt82n8W9Fjdg2Zpz5NWHbljWwsCCf3pZsPmsxALDtUiK/qj2N5rtISdrpu3
         P+jQqReFuz9h//86mZp68hZ7LPyPxkfWoET989/fjOQLFj3Dj+jQWQnqageLe27e172T
         QsSGz20a826PdEXyvhQV/izlKVVN2B7R0vCMS/6+RDsgRCVlSKirYOU0R412LfwOQniP
         FA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aY+rbvTncYwIQUsfu1kfNRqIKlHQfqdkAsaQGSStGAc=;
        b=O32QDGgot7jd33ij2E2am4xriP0Xc+x1c5jJhcH14/QCPSKeET3LvcKXeraQzfGtQT
         K4SevairZTkb7/uhSWzAEwnDV1KiBlU/cjTps8ziXpwOyd/6Zq2OnTd6MkpEvjDzPuaP
         Krom1rfXNdVpwGzQjvbmshlsQAgPYWucbILO0JkBC9A01xuegVWDbiwj2K0E/an9p7o9
         5wdF6bldzFeTOjpfkaukpqrKTsHH/y17p4T2FINOmlRk+Lq3N2ev6Z2bMD44m0mta2vw
         lNKIDh3UUxt5yhBLMeBLAh6O9YAtmBOQ7L2ixCg1bkOPNOB/oyxt6uVr7CDaq9xCfo23
         6XWw==
X-Gm-Message-State: AJIora+NPaRJj8Hm5vYfiaTt8FAz5DL1QMULHmCvnuQ443b0+jhScWvx
        TQgh0ArWzB3MqTIgXPJU9RQDxEhtIvAIWOfwag==
X-Google-Smtp-Source: AGRyM1uP5evC9BLzvpMcKxMLrva/0mNlFe3Li55ooomvmqNgreTCCewyVOQcsfYFGScxDnGG1w5w4iOYQVUXvMWjWTo=
X-Received: by 2002:a17:90a:1588:b0:1e0:a45c:5c1 with SMTP id
 m8-20020a17090a158800b001e0a45c05c1mr4607943pja.65.1655378074447; Thu, 16 Jun
 2022 04:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <1655198062-13288-1-git-send-email-kaixuxia@tencent.com> <YqrbmiZ4HMiuvl17@infradead.org>
In-Reply-To: <YqrbmiZ4HMiuvl17@infradead.org>
From:   Kaixu Xia <xiakaixu1987@gmail.com>
Date:   Thu, 16 Jun 2022 19:14:23 +0800
Message-ID: <CAGjdHu=aZtV38SHqUbWQv2OD9PXpy3+ohEqL5F4G+_83AE0sBg@mail.gmail.com>
Subject: Re: [PATCH] iomap: set did_zero to true when zeroing successfully
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        djwong@kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> =E4=BA=8E2022=E5=B9=B46=E6=9C=8816=E6=
=97=A5=E5=91=A8=E5=9B=9B 15:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jun 14, 2022 at 05:14:22PM +0800, xiakaixu1987@gmail.com wrote:
> > From: Kaixu Xia <kaixuxia@tencent.com>
> >
> > It is unnecessary to check and set did_zero value in while() loop,
> > we can set did_zero to true only when zeroing successfully at last.
>
> Looks good, but this really should be separate patches for dax and
> iomap.

Thanks for your suggestion, will separate it in V2.
